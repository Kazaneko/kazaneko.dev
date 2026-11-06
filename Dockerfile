# Development container for kazaneko.dev: Hugo only, nothing else.
# Keep HUGO_VERSION in sync with .github/workflows/deploy.yml.
FROM alpine:3.22

ARG HUGO_VERSION=0.151.0
ARG TARGETARCH

# Download the standard Hugo release and check it against the official checksums
RUN set -eux; \
    arch="${TARGETARCH:-amd64}"; \
    file="hugo_${HUGO_VERSION}_linux-${arch}.tar.gz"; \
    base="https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}"; \
    cd /tmp; \
    wget -q "${base}/${file}" "${base}/hugo_${HUGO_VERSION}_checksums.txt"; \
    grep " ${file}\$" "hugo_${HUGO_VERSION}_checksums.txt" | sha256sum -c -; \
    tar -xzf "${file}" hugo; \
    mv hugo /usr/local/bin/hugo; \
    rm -f /tmp/*; \
    hugo version

# Run as an unprivileged user; the site is mounted read-only
RUN adduser -D -u 1000 hugo
USER hugo
ENV HUGO_CACHEDIR=/tmp/hugo_cache
WORKDIR /site

EXPOSE 1313

# Live-reload server. --noBuildLock keeps Hugo from writing into the
# read-only source folder; anything it must write goes to /tmp.
CMD ["hugo", "server", "--bind", "0.0.0.0", "--port", "1313", \
     "--baseURL", "http://localhost:1313/", "--noBuildLock", \
     "--destination", "/tmp/public"]
