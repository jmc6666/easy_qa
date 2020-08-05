FROM centos:latest
USER root

COPY ./EasyDarwin-linux-8.1.0-1901141151.tar.gz /EasyDarwin-linux-8.1.0-1901141151.tar.gz
COPY ./start.sh /start.sh
RUN mkdir -p /etc/streaming/
COPY ./easydarwin.xml /etc/streaming/easydarwin.xml
RUN yum -y install autoconf automake bzip2 bzip2-devel cmake freetype-devel gcc gcc-c++ git libtool make mercurial pkgconfig zlib-devel tar wget

RUN  gzip -d /EasyDarwin-linux-8.1.0-1901141151.tar.gz \
        && tar -xf /EasyDarwin-linux-8.1.0-1901141151.tar \
        && mv EasyDarwin-linux-8.1.0-1901141151 EasyDarwin \
    && cd /

RUN mkdir /ffmpeg-4.1.5

# install nasm
RUN cd /ffmpeg-4.1.5 \
        && curl -O -L https://www.nasm.us/pub/nasm/releasebuilds/2.14.02/nasm-2.14.02.tar.bz2 \
        && tar xjvf nasm-2.14.02.tar.bz2  \
        && cd nasm-2.14.02 \
        && ./autogen.sh \
        && ./configure --prefix="/ffmpeg-4.1.5/ffmpeg_build" --bindir="/ffmpeg-4.1.5/bin" \
        && make \
        && make install

ENV PATH="/ffmpeg-4.1.5/bin:$PATH"

# install yasm
RUN cd /ffmpeg-4.1.5 \
        && curl -O -L https://www.tortall.net/projects/yasm/releases/yasm-1.3.0.tar.gz \
        && tar xzvf yasm-1.3.0.tar.gz \
        && cd yasm-1.3.0 \
        && ./configure --prefix="/ffmpeg-4.1.5/ffmpeg_build" --bindir="/ffmpeg-4.1.5/bin" \
        && make \
        && make install

# install lib264
#RUN cd /ffmpeg-4.1.5 \
#        && git clone --depth 1 https://code.videolan.org/videolan/x264.git \
#        && cd x264 \
#        && PKG_CONFIG_PATH="/ffmpeg-4.1.5/ffmpeg_build/lib/pkgconfig" ./configure --prefix="/ffmpeg-4.1.5/ffmpeg_build" --bindir="/ffmpeg-4.1.5/bin" --enable-static \
#        && make \
#        && make install
#
# install lib265
#RUN cd /ffmpeg-4.1.5 \
#        && hg clone https://bitbucket.org/multicoreware/x265 \
#        && cd x265/build/linux \
#        && cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX="/ffmpeg-4.1.5/ffmpeg_build" -DENABLE_SHARED:bool=off ../../source \
#        && make \
#        && make install


#install ffmpeg
RUN cd /ffmpeg-4.1.5 \
    && curl -O -L https://ffmpeg.org/releases/ffmpeg-snapshot.tar.bz2 \
    && tar xjvf ffmpeg-snapshot.tar.bz2 \
    && cd ffmpeg \
    && PKG_CONFIG_PATH="/ffmpeg-4.1.5/ffmpeg_build/lib/pkgconfig" ./configure --prefix="/ffmpeg-4.1.5/ffmpeg_build" --pkg-config-flags="--static" --extra-cflags="-I/ffmpeg-4.1.5/ffmpeg_build/include" --extra-ldflags="-L/ffmpeg-4.1.5/ffmpeg_build/lib" --extra-libs=-lpthread --extra-libs=-lm --bindir="/ffmpeg-4.1.5/bin" --enable-gpl --enable-libfreetype --enable-nonfree \
    &&    make  \
    &&    make install

ENTRYPOINT /start.sh
