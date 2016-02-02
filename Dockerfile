FROM haskell:7.10
MAINTAINER Lukas Martinelli <me@lukasmartinelli.ch>
RUN cabal update

WORKDIR /opt/hadolint/
COPY ./hadolint.cabal /opt/hadolint/hadolint.cabal
RUN cabal install --only-dependencies -j4 --enable-tests \
 && cabal configure --enable-tests

COPY . /opt/hadolint
RUN cabal install

RUN apt-get update \
  && apt-get remove -y --purge \
            ghc-7.10.3 happy-1.19.5 alex-3.1.4 \
            zlib1g-dev libtinfo-dev \
            libsqlite3-0 libsqlite3-dev ca-certificates g++ \
  && rm -rf /var/lib/apt/lists/*

ENV PATH="/root/.cabal/bin:$PATH"
CMD ["hadolint", "-i"]
