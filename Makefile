ifeq ($(RUST_TARGET),)
	TARGET := ""
	RELEASE_SUFFIX := ""
else
	TARGET := $(RUST_TARGET)
	RELEASE_SUFFIX := "-$(TARGET)"
	export CARGO_BUILD_TARGET = $(RUST_TARGET)
endif

VERSION := $(word 3,$(shell grep -m1 "^version" Cargo.toml))
RELEASE := hexyl-$(VERSION)$(RELEASE_SUFFIX)

all: release

hexyl:
	cargo build --locked --release

bin:
	mkdir -p $@

bin/hexyl: hexyl bin
	cp -f target/$(TARGET)/release/hexyl $@

release: bin/hexyl
	tar -C bin -Jcvf $(RELEASE).tar.xz hexyl

.PHONY: all release
