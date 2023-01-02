FROM centos

RUN cd /etc/yum.repos.d/
RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
RUN sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*

RUN  yum install java-1.8.0-openjdk -y

COPY build/distributions/bdshr-*.noarch.rpm /tmp/tr.rpm
RUN yum install -y /tmp/tr.rpm && rm -f /tmp/tr.rpm && yum clean all
COPY env/* /etc/bdshr-terminology-server/
ENTRYPOINT . /etc/bdshr-terminology-server/bdshr-terminology-server.conf && java -jar $SERVER_OPTS /opt/bdshr-terminology-server/lib/bdshr-terminology-server.jar > /var/log/bdshr-terminology-server/bdshr-terminology-server.log 2

