SHELL=/bin/bash

DOCKER_USERNAME := $(shell whoami)
APPLICATION_NAME := cyberchef

export DOCKER_USERNAME
export APPLICATION_NAME
 
build:
	docker build --tag ${DOCKER_USERNAME}/${APPLICATION_NAME} .

push:
	docker push ${DOCKER_USERNAME}/${APPLICATION_NAME}