FROM debian:trixie-slim AS download

RUN apt-get update
RUN apt-get install -y \
        ca-certificates

ARG VERSION
ADD https://github.com/tursodatabase/homebrew-tap/releases/download/$VERSION/homebrew-tap_Linux_x86_64.tar.gz /tmp
RUN tar -xzf /tmp/homebrew-tap_Linux_x86_64.tar.gz -C /tmp

FROM scratch AS turso

COPY --from=download /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=download /tmp/turso .

ENTRYPOINT ["./turso"]