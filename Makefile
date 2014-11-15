DIR=$(shell pwd)

.PHONY : default build_container manual container build push local

default: container

build_container:
	docker build -t initrd meta

manual: build_container
	./meta/launch /bin/bash || true

container: build_container
	./meta/launch

build:
	

push:
	ssh -oStrictHostKeyChecking=no git@github.com &>/dev/null || true
	git tag -f "$$(./build/ducktape -v)"
	git push origin ":$$(./build/ducktape -v)" || true
	git push --tags origin master
	targit -a .github -c -f dock0/ducktape $$(./build/ducktape -v) build/ducktape
	targit -a .github -c -f dock0/ducktape latest build/ducktape

local: build push

