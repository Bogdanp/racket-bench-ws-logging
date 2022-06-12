#!/usr/bin/env bash

set -euo pipefail

log() {
    printf "[%s] %s\n" "$(date)" "$@"
}

if [ $# -ne 1 ]; then
    echo "usage: ./attack.sh FILENAME"
    exit 1
fi

while true; do sleep 30; [ -f log ] && mv log log.1; done &

FILENAME="$1"
log "Warming up..."
vegeta attack -duration=10s -rate 1000/s < targets | tee "$FILENAME" | vegeta report

log "Attacking for 2 minutes @ 2.5k QPS..."
vegeta attack -duration=2m -rate 2500/s < targets | tee "$FILENAME" | vegeta report

kill %
