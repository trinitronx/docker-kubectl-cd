.PHONY: test build clean

REGISTRY := $(shell git remote show -n origin | grep Fetch | cut -d: -f2- | cut -d: -f2- | cut -d/ -f1)
REPO_NAME := $(shell git remote show -n origin | grep Fetch | cut -d: -f2- | cut -d: -f2- | cut -d/ -f2 | sed -e 's/\.git//g' -e 's/docker-//g')
REPO := $(REGISTRY)/$(REPO_NAME)

# Auto-documented Makefile
# Source: http://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
help: ## Shows this generated help info for Makefile targets
	@grep -E '^[a-zA-Z_-]+:.*?(## )?.*$$' $(MAKEFILE_LIST) | sort | awk '{ if ( $$0 ~ /^[a-zA-Z_-]+:.*?## ?.*$$/ ) { split($$0,resultArr,/:.*## /) ; printf "\033[36m%-30s\033[0m %s\n", resultArr[1], resultArr[2] } else if ( $$0 ~ /^[a-zA-Z_-]+:.*$$/ ) { split($$0,resultArr,/:.*?/);  printf "\033[36m%-30s\033[0m\n", resultArr[1] } } '

list: ## Just list all Makefile targets without help
	@$(MAKE) -pRrq -f $(lastword $(MAKEFILE_LIST)) : 2>/dev/null | awk -v RS= -F: '/^# File/,/^# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' | sort | egrep -v -e '^[^[:alnum:]]' -e '^$@$$' | xargs

test: build $(wildcard spec/bats/*) ## Run bats tests against the images. Tests run inside containers.
	for tag in $$(ls -1 docker-platforms); do \
	  export K8S_VERSION=$$(grep "ENV K8S_VERSION" docker-platforms/$${tag}/Dockerfile | cut -d' ' -f 3) ; \
	  echo "TESTING: $(REPO):$${tag}-kubectl-$${K8S_VERSION}" ; \
	  docker run --rm  -ti -v $$(pwd)/spec:/spec -e K8S_VERSION=$${K8S_VERSION} --entrypoint=/bin/bash $(REPO):$${tag}-kubectl-$${K8S_VERSION} \
	    -c "git clone https://github.com/sstephenson/bats.git && cd bats && ./install.sh /usr/local && env | grep K8S_VERSION && kubectl version --client && bats /spec/bats " ; \
	done

.docker-build:
	./bin/docker-build
	git rev-parse HEAD > .docker-build

build: .docker-build ## Generates the docker images for this project.

.shipped: .packaged
	./bin/docker-push
	echo "$(DEPLOY_TAG)" > .shipped


ship: .shipped ## Pushes the packaged docker images to the docker registry.

clean: ## Remove all generated and temporary build files.
	rm -f .shipped
	rm -f .docker-build
