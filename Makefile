SHELL=/bin/bash

DOCKER_USERNAME := $(shell whoami)
APPLICATION_NAME := cyberchef

export DOCKER_USERNAME
export APPLICATION_NAME
 
build:
	docker build --tag ${DOCKER_USERNAME}/${APPLICATION_NAME} .

run:
	docker run -p 127.0.0.1:80:8080/tcp ${DOCKER_USERNAME}/${APPLICATION_NAME} 