FROM haskell:7.10
MAINTAINER Lukas Martinelli <me@lukasmartinelli.ch>
RUN cabal update

RUN apt-get update \
 && apt-get install --no-install-recommends -y git hlint \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /opt/hadolint/
COPY ./hadolint.cabal /opt/hadolint/hadolint.cabal
RUN cabal install --only-dependencies -j4 --enable-tests \
 && cabal configure --enable-tests

COPY . /opt/hadolint
RUN cabal install

RUN apt-get remove --purge cabal-install ghc happy alex \
            stack zlib1g-dev libtinfo-dev \
            libsqlite3-0 libsqlite3-dev ca-certificates g++ \
            hlint

ENV PATH="/root/.cabal/bin:$PATH"
CMD ["hadolint", "-i"]

