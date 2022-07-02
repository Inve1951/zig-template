
# Zig project template - v1

Base setup for zig projects with IDE glue.


## Features

- vscode integration

    - IDE "tasks" to build and run the app and tests

    - IDE "launch configurations" to debug the app, all tests, or just the tests in the currently focused zig file

    - format-on-safe via `zig fmt`

    - `zls` integration

    - zig file templates (see below)


- TODO: cover other IDEs when their zig support gets good enough.


## Zig File Template Setup

To make use of the included templates do the follow:

- install vscode extension `Gruntfuggly.auto-snippet`

- apply machine-local settings (see `.vscode/user/settings.json`) (also *needed* for `zls` and debugging)

- install the templates (see `.vscode/user/snippets/zig.json`)

These get automatically applied when creating new `.zig` files. They provide typical boilerplate with smart TAB key navigation.


## Usage Notes

Set the executable name in `build.zig`.

The debugger "launch configurations" depend on the executable name matching the project's folder name.

The *debug current file's tests* launch configuration does not use `build.zig`.

Tested on Linux;
*should* work on Mac OS;
Windows users please try the commented-out bits of `.vscode/launch.json` and let me know if it works.

`zls` is expected to be on $PATH. Same goes for `zig`.


---
Got any notes? Ping me in the zig discord.
