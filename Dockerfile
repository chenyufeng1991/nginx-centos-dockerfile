FROM centos:6.7
MAINTAINER chenyufeng "yufengcode@gmail.com"

# 设置当前工具目录
# 该命令不会新增镜像层
WORKDIR /home

#安装wget
RUN yum install -y wget && \
    rpm --rebuilddb && \
    yum install -y tar

#下载并解压源码包
RUN wget http://nginx.org/download/nginx-1.8.0.tar.gz && \
    tar -zxvf nginx-1.8.0.tar.gz && \ 
    mv nginx-1.8.0/ nginx && \
    rm -f nginx-1.8.0.tar.gz

# 切换到nginx目录执行以下操作
WORKDIR nginx

#编译安装nginx
RUN rpm --rebuilddb && \
    yum install -y gcc make pcre-devel zlib-devel && \
    ./configure --prefix=/usr/local/nginx --with-pcre && \
    make && \
    make install && \
    /usr/local/nginx/sbin/nginx && \
    echo "daemon off;">>/usr/local/nginx/conf/nginx.conf && \
    yum clean all 

EXPOSE 22 80 443

CMD ["/usr/local/nginx/sbin/nginx"]
