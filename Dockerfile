FROM moul/tmux
MAINTAINER Manfred Touron <m@42.am>

# Inspired by https://github.com/mboersma/znc

RUN apt-get -q update && \
    apt-get -qq -y install coreutils g++ libssl-dev make && \
    apt-get clean

ADD http://znc.in/releases/znc-1.2.tar.gz /tmp
RUN cd /tmp/znc-1.2 && \
    ./configure && \
    make && \
    make install && \
    rm -rf /tmp/znc-1.2*

RUN useradd -m -d /znc znc
RUN chmod -R +x /znc && \
    chown -R znc:znc /znc

#VOLUME ["/znc/state"]

ADD command /root/command

EXPOSE 6697

CMD ["run-docker-tmux"]