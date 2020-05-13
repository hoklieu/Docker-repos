PROJECT_NAME=project_template
BUILD_TAG="hoklieu"
IMAGE_NAME=${PROJECT_NAME}

DOCKER_CMD_COMMON=\
	--dns=x.x.x.x\ ## the proxy of your inner web
	--dns-search=xxx.com ## for proxy

.PHONY:all
all: help

.PHONY:help
help: ## help message
	@echo 'usage make [target] ...' && \
	echo && \
	echo 'target:' && \
	egrep '^(.+)\:\ ##\(.+)'${MAKEFILE_LIST} | column -t -c 2 -s ':#'

.PHONY:build-flask
build-flask: ## build flask docker image from fime
	docker build --file dockerfiles/Dockerfile.flask \
		-t ${IMAGE_NAME}-flask:${BUILD_TAG}

.PHONY:run-flask
run-flask: ## Run flask docker image with bash shell, export port 5000 for react frontend
	## --rm (-d): (run in detached mode, not what you like) and remove container after exit
	## -p: hostPort:containerPort, so in this case would be 5000:5000
	## DOCKER_CMD_COMMON: set custom dns servers for the container
	make build-flask ## first build it
	docker run --rm -it -p 5000:5000  \
		${DOCKER_CMD_COMMON} \
		--name ${IMAGE_NAME} \
		${IMAGE_NAME}-flask:${BUILD_TAG} \
		/bin/bash

