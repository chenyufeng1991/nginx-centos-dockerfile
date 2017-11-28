FROM centos:6.7
MAINTAINER chenyufeng "yufengcode@gmail.com"

# 设置当前工具目录
# 该命令不会新增镜像层
WORKDIR /home

#安装wget
RUN yum install -y wget
RUN rpm --rebuilddb && yum install -y tar
#下载并解压源码包
RUN wget http://nginx.org/download/nginx-1.8.0.tar.gz
RUN tar -zxvf nginx-1.8.0.tar.gz
WORKDIR nginx-1.8.0
#编译安装nginx
RUN rpm --rebuilddb && yum install -y gcc make pcre-devel zlib-devel
RUN ./configure   --prefix=/usr/local/nginx   --with-pcre
RUN make
RUN make install
#启动Nginx服务
RUN /usr/local/nginx/sbin/nginx
#修改Nginx配置文件,以非daemon方式启动
RUN echo "daemon off;">>/usr/local/nginx/conf/nginx.conf
#设置生成容器时需要执行的脚本
CMD ["/usr/local/nginx/sbin/nginx"]
#开放22、80、443端口
EXPOSE 22 80 443
