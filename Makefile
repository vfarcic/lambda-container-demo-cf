SHELL := /bin/bash

init:
	go get -d ./...
	-aws ecr create-repository --repository-name lambda-container-demo --image-scanning-configuration scanOnPush=true
	$(eval REGISTRY_URI=$(shell aws ecr describe-repositories --repository-name lambda-container-demo | jq -r ".repositories[0].repositoryUri"))
	cat codefresh-master.yml | sed -e "s@CHANGE_ME_REGISTRY_URI@${REGISTRY_URI}@g" | tee codefresh-master.yml
	-codefresh auth create-context devops-catalog --api-key ${CF_TOKEN}
	$(eval GH_REPO=$(shell git config --get remote.origin.url | sed -e "s@https://github.com/@@g" | sed -e "s@\.git@@g"))
	cat codefresh-master.yml | sed -e "s@CHANGE_ME_REPO@${GH_REPO}@g" | tee codefresh-master.yml
