FROM golang:1.16 AS builder

WORKDIR /go/src/xfiles
COPY . .

RUN mkdir -p /scratch/xfiles && \
    mkdir -p /scratch/go/bin && \
    CGO_ENABLED=0 go build -ldflags="-w -s" -o /scratch/go/bin/xfiles

## Smush it
FROM alpine
COPY --from=builder /scratch/ /
ENTRYPOINT ["/go/bin/xfiles"]
