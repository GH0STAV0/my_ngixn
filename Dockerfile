FROM nginx
RUN rm /etc/nginx/conf.d/default.conf
RUN apt update
RUN apt install lsof nano netcat procps -y
#RUN rm /etc/nginx/nginx.conf /etc/nginx/conf.d/default.conf

#COPY content /usr/share/nginx/html
COPY conf /etc/nginx
ENTRYPOINT ["tail", "-f", "/dev/null"]
