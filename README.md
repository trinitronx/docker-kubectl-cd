docker-kubectl-cd
=================
[![Build Status](https://img.shields.io/travis/trinitronx/docker-kubectl-cd.svg)](https://travis-ci.org/trinitronx/docker-kubectl-cd)
[![Docker Pulls](https://img.shields.io/docker/pulls/trinitronx/kubectl-cd.svg)](https://hub.docker.com/r/trinitronx/kubectl-cd)
[![Docker Stars](https://img.shields.io/docker/stars/trinitronx/kubectl-cd.svg)](https://hub.docker.com/r/trinitronx/kubectl-cd)
[![Gittip](http://img.shields.io/gittip/trinitronx.svg)](https://www.gittip.com/trinitronx)


These are basic docker images starting from official OS base images, and installing [`build-essential` packages][build-tools], `docker` and `kubectl`. Intended for use when building & deploying containerized applications to [Kubernetes](https://kubernetes.io) in a Continuous Deployment pipeline.

Supported platforms:
--------------------

 - ubuntu-1604
 - ubuntu-1404
 - ubuntu-1204
 - centos-7
 - centos-6
 - alpine-3.6

Binaries Installed
------------------

 - `docker`
 - `kubectl`

See `Dockerfile`s for `kubectl` version (`K8S_VERSION`).

Please also see the documentation for the base image: [`trinitronx/build-tools`][build-tools]

Image Size
==========

Note: imagelayers.io may not be working properly. If in doubt, check the [Docker Hub page][2] under "tags", or download the images yourself to inspect via `docker images` or `docker inspect`.

 - `trinitronx/kubectl-cd:ubuntu-1604`: [![Image Layers](https://badge.imagelayers.io/trinitronx/kubectl-cd:ubuntu-1604-kubectl-1.6.3.svg)](https://imagelayers.io/?images=trinitronx/kubectl-cd:ubuntu-1604-kubectl-1.6.3 'Get your own badge on imagelayers.io')
 - `trinitronx/kubectl-cd:ubuntu-1404`: [![Image Layers](https://badge.imagelayers.io/trinitronx/kubectl-cd:ubuntu-1404-kubectl-1.6.3.svg)](https://imagelayers.io/?images=trinitronx/kubectl-cd:ubuntu-1404-kubectl-1.6.3 'Get your own badge on imagelayers.io')
 - `trinitronx/kubectl-cd:ubuntu-1204`: [![Image Layers](https://badge.imagelayers.io/trinitronx/kubectl-cd:ubuntu-1204-kubectl-1.6.3.svg)](https://imagelayers.io/?images=trinitronx/kubectl-cd:ubuntu-1204-kubectl-1.6.3 'Get your own badge on imagelayers.io')
 - `trinitronx/kubectl-cd:centos-7`: [![Image Layers](https://badge.imagelayers.io/trinitronx/kubectl-cd:centos-7-kubectl-1.6.3.svg)](https://imagelayers.io/?images=trinitronx/kubectl-cd:centos-7-kubectl-1.6.3 'Get your own badge on imagelayers.io')
 - `trinitronx/kubectl-cd:centos-6`: [![Image Layers](https://badge.imagelayers.io/trinitronx/kubectl-cd:centos-6-kubectl-1.6.3.svg)](https://imagelayers.io/?images=trinitronx/kubectl-cd:centos-6-kubectl-1.6.3 'Get your own badge on imagelayers.io')
 - `trinitronx/kubectl-cd:alpine-3.6`: [![Image Layers](https://badge.imagelayers.io/trinitronx/kubectl-cd:alpine-3.6-kubectl-1.6.3.svg)](https://imagelayers.io/?images=trinitronx/kubectl-cd:alpine-3.6-kubectl-1.6.3 'Get your own badge on imagelayers.io')

Usage
=====

Because `ENTRYPOINT` is set to `kubectl` you should run the container just the same as you would with the `kubectl` executable:

    docker run trinitronx/kubectl-cd

If you did not specify `--server` or `--kubeconfig=/path/to/.kube/config`, `kubectl` will default to `localhost:8080`.

This will work if `kube-apiserver` is running on your docker host at `localhost:8080`. However, you will need to call docker with `--net=host`:

    docker run --rm --net=host trinitronx/kubectl-cd

If `kube-apiserver` is not running on your build host at `localhost:8080`, you can use `--server` to specify a server, or if you have `~/.kube/config` you may volume mount that into the container:

    docker run --rm -v ~/.kube:/root/.kube trinitronx/kubectl-cd

It may be helpful to create a shell alias to make it appear as if you are running the local executable:

    alias kubectl='docker run --rm -it -u $(id -u) -e HOME=${HOME} -v ${HOME}:${HOME} trinitronx/kubectl-cd'

This creates a shortcut to run `trinitronx/kubectl-cd` as if it were the bare `kubectl` binary. So you may run commands such as:

    kubectl get pods

Note the `--rm` in the above examples.  This option automatically causes docker to remove the old containers after the command exits as with `docker rm`.  This will prevent old containers from building up each time you run `kubectl`.

The commands above will use the `trinitronx/kubectl-cd:latest` tag to provide the latest pushed docker image based on `alpine` Linux.  However, you may specify an explicit os  & version by tag.  This may be helpful in controlled environments to avoid `kubectl` client & `kube-apiserver` version incompatibility. For example, to run `kubectl` version `1.2.3` based on `alpine`:

    docker run --rm trinitronx/kubectl-cd:1.2.3

To run `kubectl` version `1.2.3` based on `ubuntu-1604`:

    docker run --rm trinitronx/kubectl-cd:ubuntu-1604-kubectl-1.2.3

The image tags are created from the `K8S_VERSION` variable detected from the built `Dockerfile`.


Building
========

To build the images locally, checkout [this repo][1] and run:

    make build
    # OR:
    ./bin/docker-build

Testing
=======

[This repo][1] contains basic `bats` tests to check the built images for the binaries installed.

To run the tests:

    make test

License
=======

[GNU GPL v2](http://choosealicense.com/licenses/gpl-2.0/)

See LICENSE.md for full text

Copyright
=========

Copyright James Cuzella 2014-2017 ([@trinitronx][trinitronx-keybase])

[1]: https://github.com/trinitronx/docker-kubectl-cd
[2]: https://hub.docker.com/r/trinitronx/kubectl-cd
[build-tools]: https://github.com/trinitronx/docker-build-tools
[trinitronx-keybase]: https://gist.github.com/trinitronx/aee110cbdf55e67185dc44272784e694
