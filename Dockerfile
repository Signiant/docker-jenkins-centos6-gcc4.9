FROM signiant/docker-jenkins-centos6-java8
MAINTAINER devops@signiant.com

# Install yum packages required for cmake build node
COPY yum-packages.list /tmp/yum.packages.list
RUN chmod +r /tmp/yum.packages.list
RUN yum install -y `cat /tmp/yum.packages.list`

# Install c/c++ development tools
RUN yum install -y centos-release-scl

# Install cmake3.12
RUN mv /usr/bin/cmake /usr/bin/cmake2
RUN mv /usr/bin/ccmake /usr/bin/ccmake2
RUN wget https://cmake.org/files/v3.12/cmake-3.12.0-Linux-x86_64.tar.gz -O /tmp/cmake-3.12.0-Linux-x86_64.tar.gz
RUN cd /usr/local/bin && \
tar -xzf /tmp/cmake-3.12.0-Linux-x86_64.tar.gz
RUN ln -s /usr/local/bin/cmake-3.12.0-Linux-x86_64/bin/cmake /usr/bin/cmake

RUN yum install -y devtoolset-3-gcc-c++ devtoolset-3-libstdc++-devel devtoolset-3-gdb python27 python-setuptools python-pip python-wheel

# Install umpire
ENV UMPIRE_VERSION 0.5.5
RUN pip install umpire==${UMPIRE_VERSION}
