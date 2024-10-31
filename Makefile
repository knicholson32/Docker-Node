.PHONY: all test clean

create-local:
	docker build --file ./docker/Dockerfile --build-arg GIT_COMMIT=$(shell git rev-parse HEAD) --build-arg CI=true -t docker-node-template:local .
dev:
	rm -rf ./node_modules
	docker build --file ./docker/Dockerfile --target build-deps -t docker-node-template:dev .
	docker-compose -f ./docker/docker-compose.dev.yml -p docker-node-template up --remove-orphans
local:
	docker-compose -f ./docker/docker-compose.local.yml up --remove-orphans