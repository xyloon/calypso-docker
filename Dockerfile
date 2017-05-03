FROM ubuntu:16.04
MAINTAINER jsyang <xyloon@gmail.com>

RUN apt update
RUN apt upgrade -y
RUN apt install -y build-essential libssl-dev git-core wget unzip
WORKDIR /root
RUN wget https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh
RUN /bin/bash install.sh
RUN rm install.sh
ENV NVM_DIR $HOME/.nvm
RUN [ -s /root/.nvm/nvm.sh ] && . /root/.nvm/nvm.sh && nvm install 6.10.2
RUN wget https://github.com/Automattic/wp-calypso/archive/master.zip
RUN unzip master.zip
RUN rm master.zip
WORKDIR /root/wp-calypso-master
EXPOSE 3000
CMD ["/bin/bash"]
#CMD ["make", "run"]


