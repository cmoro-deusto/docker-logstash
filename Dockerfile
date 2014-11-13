FROM ubuntu:14.04
MAINTAINER Carlos Moro <dordoka@gmail.com>
RUN apt-get -qq update
RUN apt-get install -y software-properties-common
RUN \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get install -y oracle-java8-installer
RUN apt-get -qq install wget
RUN mkdir /opt/logstash
RUN wget -O /tmp/logstash.tar.gz https://download.elasticsearch.org/logstash/logstash/logstash-1.4.2.tar.gz
RUN tar -zxvf /tmp/logstash.tar.gz -C /opt/logstash
RUN useradd --user-group --system --home-dir /opt/logstash logstash
RUN chown -R logstash:logstash /opt/logstash

USER logstash

WORKDIR /opt/logstash
VOLUME /opt/logstash
EXPOSE 5000
