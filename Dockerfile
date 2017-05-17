FROM alpine
MAINTAINER kdw.kzm@gmail.com

#configure go path
ENV GOPATH /root/go
ENV PATH $PATH:/usr/local/go/bin:$GOPATH/bin

#package
ENV PACKAGE github.com/kosim21/kzm
ENV PACKAGE_DIR $GOPATH/src/$PACKAGE

#install go and godep, then compile node server.js using godep, then wipe build tools
RUN apk update && \
    apk add git go gzip && \
    go get github.com/tools/godep && \
    mkdir -p $PACKAGE_DIR && \
    git clone https://$PACKAGE.git $PACKAGE_DIR && \
    cd $PACKAGE_DIR && \
    godep go build -ldflags "-X main.VERSION=$(git describe --abbrev=0 --tags)" -o /usr/local/bin/node server.js && \
    cd /tmp && \
    rm -rf $GOPATH && \
    apk del git go gzip && \
    echo "Installed $PACKAGE"

#run package
ENTRYPOINT ["node server.js"]
