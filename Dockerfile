FROM alpine:3
MAINTAINER Jens Fischer

# install necessary packages
RUN apk add --no-cache \
        git \
        make \
        pkgconfig \
        build-base

# Compile mupdf
RUN git clone --recursive git://git.ghostscript.com/mupdf.git \
        && cd mupdf \
        && git submodule update --init \
        && make HAVE_X11=no HAVE_GLUT=no prefix=/usr/local install \
        && cd / \
        && rm -r mupdf \
        && apk del \
        git \
        make \
        pkgconfig \
        build-base

# Set Environment variables
ENV LANG=de_DE.ISO-8859

# Provide Volumes
RUN mkdir /var/local/pdf \
        && mkdir /var/local/pdf/out

VOLUME /var/local/pdf

WORKDIR /var/local/pdf

ENTRYPOINT ["mutool"]
