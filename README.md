# cc-edge-macos-unified-logs-io

Cribl Edge pack for macOS Unified Logging events.

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
