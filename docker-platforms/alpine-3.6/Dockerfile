FROM trinitronx/build-tools:alpine-3.6

MAINTAINER James Cuzella @trinitronx https://keybase.io/trinitronx/

ENTRYPOINT ["/bin/kubectl"]

ENV K8S_VERSION 1.6.4

RUN set -x && \
    wget -O /bin/kubectl https://storage.googleapis.com/kubernetes-release/release/v${K8S_VERSION}/bin/linux/amd64/kubectl && \
    chmod +x /bin/kubectl

RUN set -x && \
    wget -O /bin/docker https://master.dockerproject.org/$(uname -s | tr 'A-Z' 'a-z')/$(uname -m)/docker && \
    wget -q -O - https://master.dockerproject.org/$(uname -s | tr 'A-Z' 'a-z')/$(uname -m)/docker.sha256 | awk '{ print $1 "  /bin/docker" }' | \
      sha256sum -c - && \
    chmod +x /bin/docker
