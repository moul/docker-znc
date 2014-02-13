FROM moul/sshd
MAINTAINER Manfred Touron <m@42.am>

RUN apt-get update && \
    apt-get -qq -y install coreutils g++ libssl-dev make && \
    apt-get clean

ADD http://znc.in/releases/znc-1.2.tar.gz /tmp
RUN cd /tmp/znc-1.2 && \
    ./configure && \
    make && \
    make install && \
    rm -rf /tmp/znc-1.2*

RUN useradd -m -d /znc znc
ADD run /znc/run
RUN chmod -R +x /znc && \
    chown -R znc:znc /znc

VOLUME ["/znc/state"]

WORKDIR /znc
CMD ["/znc/run"]
#USER znc

EXPOSE 6697
