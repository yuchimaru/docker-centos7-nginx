FROM centos:7
MAINTAINER YuuichiNishioka <westhillworker@gmail.com>
RUN yum update -y && yum clean all
RUN yum install -y http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm
RUN yum install -y --enablerepo=nginx nginx
RUN yum swap -y fakesystemd systemd && yum clean all
ADD index.html /var/www/
ADD nginx.conf /etc/nginx/conf.d/
RUN mv /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf.bk
RUN systemctl enable nginx
EXPOSE 80
ENTRYPOINT ["/usr/sbin/nginx", "-g", "daemon off;", "-c", "/etc/nginx/nginx.conf"]
