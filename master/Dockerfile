FROM centos:8 as base

LABEL description="salt-minion version 3002 on CentOS-8 container"

COPY bootstrap.sh /tmp/

RUN ["/bin/bash", "/tmp/bootstrap.sh", "--master"]

EXPOSE 4505
EXPOSE 4506
ENTRYPOINT ["/usr/bin/salt-master", "-d", "--log-file=/var/log/salt/master.log", "--log-file-level=info"]
CMD ["/bin/bash"]