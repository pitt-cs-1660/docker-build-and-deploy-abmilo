# Build stage
FROM golang:1.23 AS builder

WORKDIR /app

COPY go.mod main.go ./
COPY templates/ ./templates/

RUN CGO_ENABLED=0 go build -o <binary-name> .

# Final stage
FROM scratch

WORKDIR /app

COPY --from=builder /app/main .
COPY --from=builder /app/templates ./templates

CMD ["./main"]