FROM webdevops/php-apache-dev:7.3
#COPY . /app

# Enable ssh
ENV SSH_PASSWD "root:Docker!"
RUN apt-get update \
        && apt-get install -y --no-install-recommends dialog \
        && apt-get update \
	&& apt-get install -y --no-install-recommends openssh-server \
	&& echo "$SSH_PASSWD" | chpasswd
COPY docker/sshd_config /etc/ssh/
COPY docker/ssh.conf /opt/docker/etc/supervisor.d/
RUN mkdir -p /var/run/sshd

COPY docker/ep.sh /opt/docker/provision/entrypoint.d/

# Plant stub
RUN mkdir -p /app/public
#COPY stub/index.php /app/public

# Git clone on spawn
#ENV GIT_ASKPASS "/githelper/askpass.sh"
#COPY githelper/askpass.sh /githelper/
#COPY docker/20-clone.sh /opt/docker/provision/entrypoint.d/


ENV WEB_DOCUMENT_ROOT=/app/public

#RUN composer1 install -d /app
#RUN ls /app

EXPOSE 8000 2222

