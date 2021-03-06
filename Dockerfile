FROM ubuntu:focal

RUN echo $(pwd)

RUN apt update

RUN apt install autoconf gcc mtools build-essential gcc-multilib g++-multilib parted dosfstools tar wget -y

RUN wget -O nasm.tar.gz https://www.nasm.us/pub/nasm/releasebuilds/2.15.05/nasm-2.15.05.tar.gz

RUN tar zxvf nasm.tar.gz

WORKDIR "/nasm-2.15.05"

RUN ./configure

RUN make

RUN make install

WORKDIR "/"

RUN rm nasm.tar.gz

RUN rm -fr nasm-2.15.05

RUN mkdir -p /var/ntmos

COPY ./build.sh /usr/bin/

RUN chmod +x /usr/bin/build.sh

VOLUME /var/ntmos

WORKDIR /var/ntmos

CMD [ "/usr/bin/bash", "/usr/bin/build.sh" ]