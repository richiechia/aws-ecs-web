## Introduction

This repo is used to build a simple hello world flask application and deploy it in a docker environment. The sections below explain on how you can install docker in MacOS / Ubuntu(WSL)

## GitHub File/Folder Structure

| File Name | Location | Usage |
| --- | --- | --- |
| README.md | `root` | Contains the details of contents present in the repo, including usage and architectural decisions |
| .gitignore | `root` | Used to ignore intentionally untracked files, so that they do not get committed to git (https://git-scm.com/docs/gitignore) |
| app.py | `root` | Application source code |
| Dockerfile | `root` | Instructional file for docker to build a image. (https://docs.docker.com/engine/reference/builder/) |
| requirements.txt | `root` | https://pip.pypa.io/en/stable/reference/requirements-file-format/ |

## Docker Installation

### Ubuntu

For those on WSL Ubuntu, follow the instructions(Steps 1 to 3) here to install docker on your WSL terminal: https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository

### MacOS

For those using MacOS, download docker desktop: https://docs.docker.com/desktop/install/mac-install/

After installing, open your terminal and run the following command to verify that docker is successfully installed:

```
docker --version
```

Remember to launch your Docker Desktop before going to the next section.

## Building and running docker app

Ensure that you have the following 3 files in the directory where you are about to run the commands:

1) app.py
2) Dockerfile (https://docs.docker.com/engine/reference/builder/)
3) requirements.txt (https://pip.pypa.io/en/stable/reference/requirements-file-format/)

![image](https://github.com/jaezeu/hello-flask/assets/48310743/7ddb7999-988c-4c01-ad94-65729f17e78a)


You may have to run the commands below in sudo if your user is not in a docker user group. To run docker as a non root user: https://docs.docker.com/engine/install/linux-postinstall/#manage-docker-as-a-non-root-user

```
# Build a docker image locally 
docker build -t flask-app .

# Listing your built images 
docker images

# Starting your local container with port mapping from host port to container port(-p) and in detached mode(-d)
docker run -d -p 8080:8080 flask-app

# List your running containers
docker ps

# List all your containers(Running and stopped)
docker ps -a

# To stop and remove your container
docker stop <container ID>
docker rm <container ID>

# To remove your docker images
docker rmi <image ID>

```

For all docker commands: https://docs.docker.com/engine/reference/commandline/cli/
