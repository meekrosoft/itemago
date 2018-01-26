NAME   := meekrosoft/itemago
TAG    := $$(git log -1 --pretty=%h)
IMG    := ${NAME}:${TAG}
LATEST := ${NAME}:latest



build:
	@echo ${IMG}
	@docker build -f Dockerfile.thin -t ${IMG} .
	@docker tag ${IMG} ${LATEST}

push:
	@docker push ${NAME}

run:
	@docker run -d --rm -it -p 80:80 --name itemago ${NAME}

stop:
	@docker stop ngingo

runk:
	@kubectl run hello-itemago --image=${IMG} --port=80
	@kubectl expose deployment hello-itemago --type=NodePort

stopk:
	@kubectl delete svc hello-itemago
	@kubectl delete deployment hello-itemago
