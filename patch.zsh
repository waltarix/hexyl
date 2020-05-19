#!/usr/bin/env zsh

local -a trans=(
	'\u00d7' '\u2716'
	'\u2022' '\u2733'
)

for from to ($trans); do
	rg -l0 $from | xargs -0 --no-run-if-empty sd $from $to
done
