#Main makefile for up service
IMAGE_NAME       ?= maga
DOCKER_TAG_LOCAL ?= $(IMAGE_NAME):main
PWD              ?= $(shell pwd)

#DOCKER
docker-image: dockerfiles/deployer.dockerfile
	docker build  --file dockerfiles/deployer.dockerfile \
		--tag "$(DOCKER_TAG_LOCAL)" .

docker:
	docker container run --rm $(DOCKER_OPTS) \
		--volume "$(PWD)":/project/$(IMAGE_NAME)/ \
		"$(DOCKER_TAG_LOCAL)" $(CMD)

#Puppet
deploy-to-puppet: CMD:= bash -c 'sshpass -p 'xinnor' scp -r -o StrictHostKeyChecking=no /project/maga/puppet xinnor@172.16.133.246:/opt/'
deploy-to-puppet: docker

#DEPLOY
service-deploy: CMD:= bash -c ' tar -czvf ./service-$$(date +%m-%d-%H:%M:%S).tar.gz -C /project/maga/vm/* \
 && curl -u admin:xinnor --upload-file ./service-$$(date +%m-%d-%H:%M:%S).tar.gz http://172.16.129.194:8081/repository/service-repo/service-$$(date +%m-%d-%H:%M:%S).tar.gz'
service-deploy: docker

#Local run
docker-run: DOCKER_OPTS:= -it
docker-run: docker
