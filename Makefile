VERSION=$(shell date +%Y-%m-%d)

build:
	docker build -f "$(CURDIR)/Dockerfile" -t bodak/rust-python-alpine:$(VERSION) \
		--no-cache .
	docker push bodak/rust-python-alpine:$(VERSION)
