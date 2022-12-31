FROM golang:1.19-alpine AS build-base

WORKDIR /app

COPY go.mod .

RUN go mod download

COPY . .

RUN CGO_ENABLED=0 go test --tags=unit -v ./...

RUN go build -o ./out/go-app .

# ==========================================

FROM alpine:latest

COPY --from=build-base /app/out/go-app /app/go-app

CMD [ "/app/go-app" ]
