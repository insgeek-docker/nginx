############################################################
# Dockerfile to build Nginx container images
# Based on Centos
############################################################
FROM centos:7.5.1804

RUN rpm --import /etc/pki/rpm-gpg/RPM*

RUN yum -y update && yum install -y wget gcc gcc-c++ autoconf automake make openssl openssl-devel libxml2-devel libxslt-devel \
    perl-devel perl-ExtUtils-Embed libtool zlib zlib-devel pcre pcre-devel patch

ADD nginx-1.12.1.tar.gz /home
WORKDIR /home/nginx-1.12.1
RUN ./configure --with-http_ssl_module \
    --with-http_stub_status_module \
    --with-http_realip_module \
    --with-threads && make && make install && rm -rf /home/nginx-1.12.1

VOLUME /data/wwwroot
WORKDIR /data/wwwroot

EXPOSE 80

ENTRYPOINT [ "/usr/local/nginx/sbin/nginx", "-g", "daemon off;"]




