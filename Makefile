build:
	docker build -f "$(CURDIR)/Dockerfile" -t bodak/rust-python-alpine \
		--no-cache .
	docker push bodak/rust-python-alpine
