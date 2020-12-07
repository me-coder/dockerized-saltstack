FROM centos:8 as base

LABEL description="salt-minion version 3002 on CentOS-8 container"

COPY bootstrap.sh /tmp/

RUN ["/bin/bash", "/tmp/bootstrap.sh", "--minion"]

ENTRYPOINT ["/usr/bin/salt-minion", "-d", "--log-file=/var/log/salt/minion.log", "--log-file-level=info"]
CMD ["/bin/bash"]
