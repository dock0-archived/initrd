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
	cp -R ./initcpio/* /usr/lib/initcpio/
	mkdir -p build /lib/modules/kernel
	mkinitcpio -z xz -c /dev/null -A base,udev,lvm-dock0,dock0 -g build/initrd.img -k kernel

push:
	@echo $$(sed -r 's/[0-9]+$$//' version)$$(($$(sed -r 's/.*\.//' version) + 1)) > version
	git commit -am "$$(cat version)"
	ssh -oStrictHostKeyChecking=no git@github.com &>/dev/null || true
	git tag -f "$$(cat version)"
	git push --tags origin master
	@sleep 3
	targit -a .github -c -f dock0/initrd $$(cat version) build/initrd.img

local: build push

