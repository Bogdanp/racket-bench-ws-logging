# racket-bench-ws-log

Utilities for benchmarking the Racket web server log dispatcher.

## Usage

To get a report named "baseline" and a log of GCs named "baseline.mem":

1. `env PLTSTDERR="error debug@GC" racket app.rkt 2>baseline.mem`
2. `attack.sh baseline` from another terminal session

Once you have multiple GC logs, you can compare them with

1. `racket plot.rkt baseline.mem updated.mem ...`
