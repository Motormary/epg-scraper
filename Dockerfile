FROM node:22-alpine
ARG GIT_REPO=https://github.com/Motormary/epg-scraper.git
ARG GIT_BRANCH=master
ARG WORKDIR=/epg

RUN apk update \
    && apk upgrade --available \
    && apk add curl git tzdata bash su-exec \
    && mkdir -p "${WORKDIR}" \
    && cd "${WORKDIR}" \
    && git clone --depth 1 -b "${GIT_BRANCH}" "${GIT_REPO}" . \
    && npm install

RUN apk del git curl \
    && rm -rf /var/cache/apk/*

RUN addgroup -S epg && adduser -S epg -G epg \
    && chown -R epg:epg $WORKDIR

WORKDIR $WORKDIR

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["sleep", "infinity"]
