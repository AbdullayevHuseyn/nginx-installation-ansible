FROM ubuntu

RUN useradd -m ubuntu
RUN echo "ubuntu:ubuntu" | chpasswd
RUN usermod -aG sudo ubuntu

RUN apt update && apt install -y openssh-server

RUN mkdir /var/run/sshd

RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

RUN apt install sudo -y

RUN apt clean && rm -rf /var/lib/apt/*

EXPOSE 22

CMD ["/usr/sbin/sshd","-D"]
