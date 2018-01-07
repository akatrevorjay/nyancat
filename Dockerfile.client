##
## build
##

FROM trevorj/boilerplate:rolling AS builder
MAINTAINER Trevor Joynson <docker@trevor.joynson.io>

RUN lazy-apt build-essential

COPY src src
COPY Makefile README.md nyancat.1 ./

ENV CFLAGS="-static -O2"
ENV CXXFLAGS="${CFLAGS}"

RUN make -j4 \
 && mkdir -pv /out \
 && cp src/nyancat /out/ \
 && strip /out/nyancat

##
## fin
##

FROM busybox:latest
MAINTAINER Trevor Joynson <docker@trevor.joynson.io>

COPY --from=builder /out/nyancat /bin/

USER nobody
CMD ["nyancat"]
