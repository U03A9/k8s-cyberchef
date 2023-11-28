SHELL=/bin/bash

DOCKER_USERNAME ?= $(shell whoami)
APPLICATION_NAME ?= cyberchef
GIT_HASH ?= $(shell git log --format="%h" -n 1)
 
build:
	docker build --tag ${DOCKER_USERNAME}/${APPLICATION_NAME}-${GIT_HASH} .

run:
	docker run -p 8080:8080/tcp ${DOCKER_USERNAME}/${APPLICATION_NAME}-${GIT_HASH}