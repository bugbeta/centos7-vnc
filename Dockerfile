## Custom Dockerfile
FROM consol/centos-xfce-vnc
ENV REFRESHED_AT 2018-03-18

# Switch to root user to install additional software
USER 0

## Install a gedit
RUN yum install -y gedit telnet net-tools nc nmap crontabs openssh-server openssh-clients bind-utils traceroute tcpdump freerdp\
    && yum clean all
    
RUN mkdir -p /var/run/sshd /root/.ssh

# centos6
# RUN sed -i 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config
# RUN ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key
# RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key
RUN ssh-keygen -q -t rsa -b 2048 -f /etc/ssh/ssh_host_rsa_key -N ''
RUN ssh-keygen -q -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key -N ''
RUN ssh-keygen -t dsa -f /etc/ssh/ssh_host_ed25519_key -N ''

EXPOSE 22
CMD ["/usr/sbin/sshd -D &"]
# ssh-keygen -q -t rsa -b 2048 -f /etc/ssh/ssh_host_rsa_key -N ''
# ssh-keygen -q -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key -N ''
# ssh-keygen -t dsa -f /etc/ssh/ssh_host_ed25519_key -N ''
# echo "/usr/sbin/sshd -D &">>/etc/rc.local
# chmod +x /etc/rc.d/rc.local
## switch back to default user
#USER 1000
