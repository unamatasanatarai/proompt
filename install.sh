#!/usr/bin/env bash

__install_dir="${XDG_BIN_HOME:-${HOME}/.local/bin}"
__base_url="https://raw.githubusercontent.com/unamatasanatarai/proompt/master"

__files=("proompt" "proompt-list" "proompt-get" "proompt-update")

if ! command -v curl >/dev/null 2>&1; then
    printf 'Error: curl is required\n' >&2
    exit 1
fi

if [[ ! -d "$__install_dir" ]]; then
    mkdir -p "$__install_dir" || {
        printf 'Error: failed to create install directory\n' >&2
        exit 1
    }
fi

for __file in "${__files[@]}"; do
    __target="$__install_dir/$__file"
    __url="$__base_url/$__file"

    printf 'Installing %s...\n' "$__file"

    # Use a stable temp name to avoid mktemp fork in loop
    __tmp="$__install_dir/.$__file.tmp"

    if curl -sfL --connect-timeout 10 --max-time 30 -o "$__tmp" "$__url"; then
        if [[ -s "$__tmp" ]]; then
            chmod +x "$__tmp"
            mv "$__tmp" "$__target"
        else
            printf 'Error: downloaded file %s is empty\n' "$__file" >&2
            rm -f "$__tmp"
            exit 1
        fi
    else
        printf 'Error: failed to download %s\n' "$__file" >&2
        rm -f "$__tmp"
        exit 1
    fi
done

printf '\nInstalled to: %s\n' "$__install_dir"

if "$__install_dir/proompt" update; then
    printf 'Sync complete\n'
else
    printf 'Error: sync failed (you can run it manually later with: proompt update)\n' >&2
fi

case ":$PATH:" in
*":$__install_dir:"*) ;;
*)
    printf '\nAdd this to your shell profile:\n'
    printf 'export PATH="%s:$PATH"\n' "$__install_dir"
    ;;
esac

printf '\nUsage:\n'
printf '  proompt update\n'
printf '  proompt list\n'
printf '  proompt meta-prompt\n'
