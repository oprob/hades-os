# HADES OS Makefile

.PHONY: help build clean prepare iso docker-build test

help:
	@echo "HADES OS Build System"
	@echo "===================="
	@echo "make prepare    - Prepare build environment"
	@echo "make build      - Build ISO image"
	@echo "make clean      - Clean build artifacts"
	@echo "make test       - Run tests"
	@echo "make docker     - Build in Docker container"

prepare:
	@echo "Preparing build environment..."
	@scripts/build/prepare-env.sh

build: prepare
	@echo "Building HADES OS ISO..."
	@scripts/build/build-iso.sh

clean:
	@echo "Cleaning build artifacts..."
	@scripts/build/clean.sh

test:
	@echo "Running tests..."
	@pytest tests/

docker:
	@docker build -t hades-os-builder .
	@docker run --rm -v $(PWD):/workspace hades-os-builder make build
