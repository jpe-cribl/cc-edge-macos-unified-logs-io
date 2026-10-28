# cc-edge-macos-unified-logs-io

Cribl Edge pack for macOS Unified Logging events.

## Pipeline

`macos_unified_logs` runs these functions in order:

1. `drop` removes a launchd event unless its text matches one of these
   case-insensitive phrases: `Successfully spawned`, `spawn deferred`,
   `internal event: EXITED`, `exited due to`, `ran for`, `did not exit`,
   `throttl`, `inefficient`, `crash`. Events from other processes are not
   affected.
2. `eval` sets `index` to `os` and `sourcetype` to `macos:unified_log` on every
   remaining event.

The route sends events whose `datatype` is `macos-unified-log` to this
pipeline. The pack ships no sources; any source can send events to the
pipeline by its id.

## Installation

Install the test harness dependencies:

```sh
cd tests && pnpm install --frozen-lockfile
```

## Usage

Validate the pack structure (`PACK_TYPE` must be `edge`):

```sh
PACK_TYPE=edge ./scripts/validate-pack-structure.sh
```

Run the lint, type check, and fixture-driven test suite against a Cribl instance
on `localhost:9000` (`CRIBL_HOST`, `CRIBL_PORT`, `CRIBL_USER`, `CRIBL_PASS`):

```sh
cd tests && pnpm run lint && pnpm run typecheck && pnpm run test
```
