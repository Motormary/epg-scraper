#!/bin/sh
set -e

# Fix ownership on mounted volume (runs as root)
chown -R epg:epg /epg/guides

# Drop to non-root user, exec the actual command
exec su-exec epg "$@"
