# Changelog

## 0.1.0

- Adds the `macos_unified_logs` pipeline. It drops launchd events whose
  text does not match a lifecycle phrase, then sets `index` to `os` and
  `sourcetype` to `macos:unified_log` on every remaining event.
- Adds the route that sends `datatype=='macos-unified-log'` events to that
  pipeline.
- Adds fixtures for lifecycle and non-launchd events, and the pack-structure
  validator and test harness.
