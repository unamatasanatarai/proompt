# Proompts

![Bash](https://img.shields.io/badge/Language-Bash-4EAA25?style=flat-square&logo=gnu-bash&logoColor=white)
![Markdown](https://img.shields.io/badge/Templates-Markdown-000000?style=flat-square&logo=markdown&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-blue?style=flat-square)
![Maintenance](https://img.shields.io/badge/Maintained%3F-nah-red.svg?style=flat-square)
![Platform](https://img.shields.io/badge/Platform-macOS%20%7C%20Linux-lightgrey?style=flat-square)
![Pure Bash](https://img.shields.io/badge/Architecture-Pure%20Bash-black?style=flat-square)

A high-performance CLI utility suite for managing and applying professional engineering prompt templates. It provides a curated collection of optimized prompts for software architects, product managers, and developers, delivered through a minimal-overhead Bash interface.

## Features

- **Optimized Prompt Library**: Curated templates for roadmapping, HLD reviews, PRD generation, and high-performance Bash scripting.
- **High-Performance CLI**: Built with "Pure Bash" principles to ensure near-zero execution overhead and no unnecessary subshells or forks.
- **Automated Lifecycle**: Includes scripts for installation, remote template synchronization, and local metadata indexing.
- **XDG Compliance**: Respects standard environment variables (`XDG_DATA_HOME`, `XDG_BIN_HOME`) for clean system integration.

## Tech Stack

- **Shell**: Bash 4+ (Optimized for performance and minimal process creation)
- **Formatting**: `shfmt` for consistent shell script semantics
- **Networking**: `curl` for secure remote template synchronization
- **Documentation**: Markdown-based templates

## Project Structure

```text
proompts-templates/    Curated engineering and product prompt templates
metadata/              Project metadata and template index
proompt                Main router CLI utility
proompt-get            Logic for retrieving and applying prompts
proompt-list           Logic for listing available cached prompts
proompt-update         Logic for syncing templates with remote repository
reindex.sh             Utility to rebuild the metadata index
install.sh             Automated installation and setup script
```

## Installation

Install the utility suite to your local bin directory:

```bash
# One-liner installation
curl -sfL https://raw.githubusercontent.com/unamatasanatarai/proompt/master/install.sh | bash

# Local execution
./install.sh
```

The script will download the core utilities and sync the initial prompt library. Ensure your local bin directory (usually `~/.local/bin`) is in your `PATH`.

## Usage

### Main Commands

List all available prompts in the local cache:
```bash
proompt list
```

Retrieve a specific prompt (prints to stdout by default):
```bash
proompt roadmap
```

Copy prompt to clipboard (macOS):
```bash
proompt bash-create | pbcopy
```

Copy prompt to clipboard (linux):
```bash
proompt bash-create | xclip -selection clipboard
```

Sync local cache with the remote repository:
```bash
proompt update
```

### Prompt Library

The suite includes specialized templates such as:
- `roadmap`: Convert PRDs into technical sequence roadmaps.
- `bash-strict`: Expert review for high-performance Bash scripts.
- `hld-review`: Architectural review for High-Level Design documents.
- `stories`: Generate comprehensive user stories from project docs.

## Configuration

The tools utilize the following environment variables for configuration:

- `XDG_BIN_HOME`: Target directory for binary installation (defaults to `~/.local/bin`).
- `XDG_DATA_HOME`: Directory for prompt template storage (defaults to `~/.local/share`).

## Development

To update the local metadata index after adding new templates to `proompts-templates/`:

```bash
./reindex.sh
```

Shell scripts should be formatted using `shfmt` with the following parameters:
```bash
shfmt -ln bash -i 4 -w <file>
```
