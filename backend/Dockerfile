# Stage 1: Build the Go application
FROM golang:1.16 AS builder

WORKDIR /app/backend

COPY backend/go.mod ./
RUN go mod download

COPY backend ./
RUN go build -o backend .

# Stage 2: Create the final runtime image
FROM debian:bullseye-slim

WORKDIR /app

COPY --from=builder /app/backend /app/

EXPOSE 9000

CMD ["./backend"]
