#!/usr/bin/env bash

__index_file="metadata/index.txt"
__template_dir="templates"

if [[ ! -d "$__template_dir" ]]; then
    printf 'Error: directory not found: %s\n' "$__template_dir" >&2
    exit 1
fi

if [[ ! -d "metadata" ]]; then
    mkdir -p "metadata" || {
        printf 'Error: failed to create metadata directory\n' >&2
        exit 1
    }
fi

shopt -s nullglob

for __f in "$__template_dir"/*; do
    [[ -f "$__f" ]] || continue
    printf '%s\n' "${__f##*/}"
done >"$__index_file" || {
    printf 'Error: failed to write to %s\n' "$__index_file" >&2
    exit 1
}
