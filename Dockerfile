FROM node:22-alpine
ARG GIT_REPO=https://github.com/Motormary/epg-scraper.git
ARG GIT_BRANCH=master
ARG WORKDIR=/epg

RUN apk update \
    && apk upgrade --available \
    && apk add curl git tzdata bash \
    && mkdir -p "${WORKDIR}" \
    && cd "${WORKDIR}" \
    && git clone --depth 1 -b "${GIT_BRANCH}" "${GIT_REPO}" . \
    && npm install

RUN apk del git curl \
    && rm -rf /var/cache/apk/*

# Create non-root user + own workdir
RUN addgroup -S epg && adduser -S epg -G epg \
    && chown -R epg:epg $WORKDIR

WORKDIR $WORKDIR
USER epg

CMD ["sleep", "infinity"]
