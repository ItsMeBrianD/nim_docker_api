# Nim_docker
A nim Docker Engine client with types.

- currently WIP
- version: v1.41
- https://docs.docker.com/engine/api/v1.41/

Use
```nim
import nim_docker

proc main()=
    var docker = initDocker("unix:///var/run/docker.sock")
    var containers = docker.containers()
    echo containers

```