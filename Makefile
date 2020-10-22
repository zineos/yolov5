DOCKER = nvidia-docker
DOCKER_IMAGE = nvcr.io/nvidia/pytorch
TAG = yolov5
CONTAIN_NAME = yolov5_pytorch
WORKDIR = /data

.phony: build run bash stop 

build: 
	$(DOCKER) build \
	-f Dockerfile \
	-t $(DOCKER_IMAGE):$(TAG) \
	.

run:
	$(DOCKER) run -it -d \
	--name $(CONTAIN_NAME) \
	--privileged \
	--network host \
	--restart always \
	--shm-size 16G \
	--hostname $(CONTAIN_NAME) \
	-v /home/neos/data:/data \
	-w $(WORKDIR) \
	$(DOCKER_IMAGE):$(TAG) bash

bash:
	$(DOCKER) exec -it $(CONTAIN_NAME) bash

stop:
	$(DOCKER) stop $(CONTAIN_NAME)
	$(DOCKER) rm $(CONTAIN_NAME)
