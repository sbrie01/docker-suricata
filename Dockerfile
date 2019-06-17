FROM ubuntu:18.04

RUN apt -y install libpcre3-dbg libpcre3-dev autoconf \
    automake libtool libpcap-dev libnet1-dev libyaml-dev \
    libjansson4 libcap-ng-dev libmagic-dev libjansson-dev zlib1g-dev

RUN apt -y install libnetfilter-queue-dev libnetfilter-queue1 libnfnetlink-dev
RUN apt -y install software-properties-common
RUN add-apt-repository ppa:oisf/suricata-stable
RUN apt -y update

RUN apt -y install suricata suricata-dbg

# Open up the permissions on /var/log/suricata so linked containers can
# see it.
RUN chmod 755 /var/log/suricata

COPY /docker-entrypoint.sh /

VOLUME /var/log/suricata

RUN /usr/bin/suricata -V

ENTRYPOINT ["/docker-entrypoint.sh"]
