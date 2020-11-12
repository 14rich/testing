FROM ubuntu:18.04

RUN    apt-get update && \
       apt-get install -y bison dpkg-dev libgdbm-dev wget jq && \
       apt install -y curl && \
       apt install -y rsync && \
       apt install -y rclone && \
       apt install -y ruby-full && \
       apt-get clean

RUN    DEBIAN_FRONTEND="noninteractive" apt-get install -y awscli build-essential zlibc zlib1g-dev openssl libxslt1-dev libxml2-dev libssl-dev libreadline7 libreadline-dev libyaml-dev libsqlite3-dev sqlite3

RUN    gem install cf-uaac --no-document

#RUN    gem install bosh-gen --no-document

ENV BBR_VERSION="1.7.2" \
    CREDHUB_VERSION="2.7.0" \
    FLY_VERSION="6.5.1" 

RUN    curl -o /usr/share/bash-completion/completions/cf7 https://raw.githubusercontent.com/cloudfoundry/cli-ci/master/ci/installers/completion/cf7

RUN    curl -L "https://packages.cloudfoundry.org/stable?release=linux64-binary&version=v7&source=github" | tar -zx && \
       mv cf /usr/local/bin

RUN    curl -sSL "https://github.com/cloudfoundry-incubator/bosh-backup-and-restore/releases/download/v${BBR_VERSION}/bbr-${BBR_VERSION}.tar" | tar -x -C /tmp && mv /tmp/releases/bbr /usr/local/bin/bbr  

RUN    curl -sSL "https://github.com/cloudfoundry-incubator/credhub-cli/releases/download/${CREDHUB_VERSION}/credhub-linux-${CREDHUB_VERSION}.tgz" | tar -xz -C /usr/local/bin
 
RUN    curl -sSL "https://github.com/concourse/concourse/releases/download/v${FLY_VERSION}/fly-${FLY_VERSION}-linux-amd64.tgz" | tar -xz -C /usr/local/bin 

RUN    wget https://github.com/pivotal-cf/om/releases/download/0.26.0/om-linux -O /usr/local/bin/om && chmod +x /usr/local/bin/om 

RUN    curl -L "https://packages.cloudfoundry.org/stable?release=linux64-binary&version=v7&source=github" | tar -zx -C /usr/local/bin && \
       chmod +x /usr/local/bin/cf && \
       curl -o /usr/share/bash-completion/completions/cf7 https://raw.githubusercontent.com/cloudfoundry/cli-ci/master/ci/installers/completion/cf7

RUN    wget -P /usr/local/bin "https://github.com/cloudfoundry/bosh-cli/releases/download/v6.4.0/bosh-cli-6.4.0-linux-amd64" && \
       chmod +x /usr/local/bin/bosh-cli-6.4.0-linux-amd64 && \
       mv /usr/local/bin/bosh-cli-6.4.0-linux-amd64 /usr/local/bin/bosh

RUN    wget -P /tmp "https://get.helm.sh/helm-v3.3.4-linux-amd64.tar.gz" && \
       tar zvxf /tmp/helm-v3.3.4-linux-amd64.tar.gz -C \tmp\ && \
       mv /tmp/linux-amd64/helm /usr/local/bin/
