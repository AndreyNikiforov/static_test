# Multi-arch build:
#     docker buildx build . --platform=linux/amd64 --progress plain -o .

# map source image to base
FROM python:3.12 AS base
WORKDIR /app
COPY dummy.py .
COPY dummy.js .
RUN \
    export DEBIAN_FRONTEND=noninteractive && apt-get update -y && apt-get install -y patchelf musl-tools build-essential libssl-dev libffi-dev python3-dev && \
    python3 -m venv .venv && \
    . .venv/bin/activate && \
    BOOTLOADER_CC=musl-gcc pip3 install --disable-pip-version-check pyinstaller==6.7.0 wheel==0.42.0 auditwheel==5.4.0 staticx==0.14.1 scons==4.8.0 && \
    pyinstaller --add-data "dummy.js:dummy.js" --onefile dummy.py --name dummy && \
    staticx --loglevel DEBUG --strip dist/dummy dist/dummy_static

FROM scratch
WORKDIR /
COPY --from=base /app/dist/dummy* .
