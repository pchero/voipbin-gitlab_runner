FROM google/cloud-sdk:359.0.0

LABEL maintainer="Sungtae Kim <pchero@gmail.com>"

ENV GOLANG_VERSION "1.17"
ENV TERRAFORM_VERSION "1.0.8"

# install common
RUN apt-get update
RUN apt-get install -y \
    software-properties-common \
    bash \
    gcc \
    openssl \
    openssh-client \
    wget \
    unzip \
    git \
    apt-utils

# install python
RUN apt-get install -y \
  python3 \
  python3-pip \
  python3-apt

# install kustomize
RUN curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"  | bash
RUN mv kustomize /usr/local/bin

# install ansible
RUN pip3 install \
  google-auth \
  requests \
  ansible

# install terraform
RUN wget --quiet https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -P /tmp
RUN unzip /tmp/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /tmp
RUN mv /tmp/terraform /usr/local/bin

# install alembic
RUN pip3 install alembic

# install golang
RUN wget --quiet https://dl.google.com/go/go${GOLANG_VERSION}.linux-amd64.tar.gz -P /usr/local/src
RUN tar -C /usr/local -xzf /usr/local/src/go${GOLANG_VERSION}.linux-amd64.tar.gz

ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH
RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"
RUN go version

WORKDIR $GOPATH

# install golint
RUN go get -u golang.org/x/lint/golint
RUN curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh
