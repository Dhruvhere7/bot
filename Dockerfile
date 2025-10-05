FROM ubuntu:22.04

ENV container docker
ENV DEBIAN_FRONTEND=noninteractive

# install systemd and ssh
RUN apt-get update && \
    apt-get install -y systemd systemd-sysv dbus dbus-user-session \
    openssh-server sudo curl iproute2 iputils-ping vim nano && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# setup SSH with root:root
RUN mkdir -p /var/run/sshd && \
    echo 'root:root' | chpasswd && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

VOLUME ["/sys/fs/cgroup"]

CMD ["/sbin/init"]
