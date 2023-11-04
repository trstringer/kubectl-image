IMAGE_REPO = ghcr.io/trstringer/kubectl
VERSION = v1.28.3

.PHONY: build
build:
	docker build -t $(IMAGE_REPO):$(VERSION) -t $(IMAGE_REPO):latest --build-arg VERSION=$(VERSION) .

.PHONY: push
push:
	docker push $(IMAGE_REPO):$(VERSION)
	docker push $(IMAGE_REPO):latest
