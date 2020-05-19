OSTYPE := $(shell uname -s)
ifeq ($(OSTYPE),Linux)
	TARGET := x86_64-unknown-linux-musl
else ifeq ($(OSTYPE),Darwin)
	TARGET := x86_64-apple-darwin
else
$(error "Unsupported OSTYPE: $(OSTYPE)")
endif

VERSION := $(word 3,$(shell grep -m1 version Cargo.toml))
RELEASE := hexyl-$(VERSION)-$(shell echo $(OSTYPE) | tr "[:upper:]" "[:lower:]")

all: release

hexyl:
	cargo build --locked --release --target=$(TARGET)

bin:
	mkdir -p $@

bin/hexyl: hexyl bin
	cp -f target/$(TARGET)/release/hexyl $@

release: bin/hexyl
	tar -C bin -Jcvf $(RELEASE).tar.xz hexyl

.PHONY: all release
