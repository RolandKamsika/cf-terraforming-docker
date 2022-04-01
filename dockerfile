ARG VERSION=master

FROM golang:1.17.5-alpine AS build

ENV GO111MODULE=on

RUN apk add git \
	&& git clone https://github.com/cloudflare/cf-terraforming.git /cf-terraforming \
	&& cd /cf-terraforming \
    && git checkout $VERSION \
    && go build -o cf-terraforming cmd/cf-terraforming/main.go

FROM alpine:3.15

RUN apk update && apk add ca-certificates && rm -rf /var/cache/apk/* \ 
&& update-ca-certificates

COPY --from=build /cf-terraforming/cf-terraforming /usr/local/bin/cf-terraforming

ENV TERRAFORM_VERSION 1.1.7

RUN apk --update --no-cache add libc6-compat git openssh-client python3 py-pip && pip install awscli \
	&& apk --no-cache add curl \
	&& cd /usr/local/bin && \
    curl https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -o terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip

WORKDIR /work

RUN printf 'terraform {\n  required_version = ">= 0.13"\n  required_providers {\n   cloudflare = {\n      source = "cloudflare/cloudflare"\n    }\n  }\n}' > /work/main.tf \
	&& terraform init

ENTRYPOINT ["/usr/local/bin/cf-terraforming"]


