FROM ubuntu:16.04
MAINTAINER jsyang <xyloon@gmail.com>

RUN apt update
RUN apt upgrade -y
RUN apt install -y build-essential libssl-dev git-core wget unzip
RUN sed 's/localhost/localhost calypso.localhost/' /etc/hosts > /etc/hosts2
RUN cat /etc/hosts2 > /etc/hosts
RUN rm -f /etc/hosts2
WORKDIR /root

ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 6.10.2
RUN wget -O - https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash \
    && . $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default
ENV PATH $PATH:$NVM_DIR/versions/node/v$NODE_VERSION/bin

RUN wget https://github.com/Automattic/wp-calypso/archive/master.zip
RUN unzip master.zip
WORKDIR /root/wp-calypso-master
RUN mkdir -p .git/hooks && touch .git/hooks/pre-commit
RUN make install

EXPOSE 3000
CMD ["make", "run"]

