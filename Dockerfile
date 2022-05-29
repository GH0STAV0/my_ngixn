FROM nginx

ENV HOME=/root \
    TERM=xterm \
    DEBIAN_FRONTEND=noninteractive \
    STARTUPDIR=/dockerstartup 

RUN rm /etc/nginx/conf.d/default.conf
RUN apt update
RUN apt install lsof nano netcat procps vsftpd tini libcap2-bin -y
#RUN rm /etc/nginx/nginx.conf /etc/nginx/conf.d/default.conf
RUN rm /etc/vsftpd.conf
#COPY content /usr/share/nginx/html
COPY content/vsftpd.conf /etc/vsftpd.conf
COPY content/vsftpd.userlist /etc/vsftpd.userlist
COPY conf /etc/nginx

RUN update-rc.d vsftpd enable

RUN update-rc.d nginx enable

RUN addgroup ftpusers
# RUN useradd -m -s /bin/bash -g root headless
# RUN echo "headless:1" | /usr/sbin/chpasswd
# RUN echo "headless    ALL=(ALL) ALL" >> /etc/sudoers
RUN useradd -rm -d /home/test1 -s /bin/bash -g ftpusers  -u 1000 test1

RUN  echo 'test1:1212' | chpasswd








# RUN systemctl enable nginx
# RUN systemctl enable vsftpd
COPY ./start_up/startup.sh "${STARTUPDIR}"/
RUN find "${STARTUPDIR}"/ -name '*.sh' -exec chmod a+x {} +
RUN $STARTUPDIR/startup.sh


EXPOSE 21 8077 20
ENTRYPOINT [ "/usr/bin/tini", "--", "/dockerstartup/startup.sh" ]
ENTRYPOINT ["tail", "-f", "/dev/null"]

