FROM azul/zulu-openjdk-centos:8-latest

COPY build/distributions/bdshr-*.noarch.rpm /tmp/tr.rpm
RUN yum install -y /tmp/tr.rpm && rm -f /tmp/tr.rpm && yum clean all
COPY env/* /etc/bdshr-terminology-server/
ENTRYPOINT . /etc/bdshr-terminology-server/bdshr-terminology-server.conf && java -jar $SERVER_OPTS /opt/bdshr-terminology-server/lib/bdshr-terminology-server.jar > /var/log/bdshr-terminology-server/bdshr-terminology-server.log 2

