# Compiling static binary out of Python code

Goal is to pinpoint an error "staticx: /tmp/staticx-pyi-t824cxbs/dummy.js/dummy.js: Invalid ELF image: Magic number does not match"

Steps to Reproduce:
```shell
docker buildx build . --platform=linux/amd64 --progress plain -o .
```

Expected outcome: binary in the output

Actual: fails with error

Environment:
```
> docker buildx version
github.com/docker/buildx v0.15.1-desktop.1 5a84cb97872a2e717a86a0dec58b20fd3f0bea46
```
