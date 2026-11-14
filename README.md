# SAE J1939 Raspberry Pi

A CODESYS Structured Text project for Raspberry Pi-based control using SAE J1939. The project includes CAN bus and J1939 device configuration, a joystick-message database, and PLC logic for reading joystick axes and buttons.

## Visualisation

The project visualisation displays the joystick's X and Y axes, detents, and 12 buttons:

![CODESYS joystick visualisation showing two axes, detents, and twelve buttons](./_doc/Screenshot%202026-11-14%20105826.png)

## What it contains

- `project/` — CODESYS project objects stored as JSON.
- `st/` — readable Structured Text source extracted from the project objects.
- `_dbc/BJM1.dbc` — DBC definition for Basic Joystick Message 1, including the joystick axis, detent, and 12 button signals.
- `scripts/` — utilities to synchronise Structured Text with project objects, maintain project versions, and create GitHub releases.

The PLC program maps the joystick signals and runs 12 button function blocks. Each `Button` block applies asymmetric debounce and exposes the debounced state, press, and release signals.

## Requirements

- Python 3 (the helper scripts use only the standard library).
- Git.
- CODESYS development and runtime components compatible with the project's device configuration and referenced libraries.
- GitHub CLI (`gh`), authenticated for the repository, only if creating a release.

The recommended Visual Studio Code extensions are listed in `.vscode/extensions.json`; they are optional for using the Python scripts.

## Working with Structured Text

Run commands from the repository root.

Extract the Structured Text from the CODESYS object files into `st/`:

```powershell
python scripts/extract_st.py
```

After editing the extracted source, write the changes back to the matching CODESYS object files:

```powershell
python scripts/update_st.py
```

Review `git diff` after synchronising changes. `update_st.py` modifies files under `project/`.

To keep `st/` refreshed while editing project object files, run the watcher and stop it with `Ctrl+C`:

```powershell
python scripts/watch_extract_st.py
```

Both scripts accept a project-object root and an output or input directory. Use `--help` to see the available options.

## Versioning and releases

Update the project version from the nearest reachable release tag on the current branch's first-parent history:

```powershell
python scripts/update_version.py --dry-run
python scripts/update_version.py
```

Version calculation requires full Git history and a release tag in `vMajor.Minor.Patch` or `vMajor.Minor.Patch.Build` format. The calculated version is written to the project's Project Information object.

Preview a GitHub release before publishing:

```powershell
python scripts/create_release.py --dry-run
```

To publish, use a clean checkout with an `origin` remote and GitHub CLI authentication:

```powershell
python scripts/create_release.py
```

The release tag is taken from the stored project version and targets the current commit.

## Tests

Run the Python utility tests with:

```powershell
python -m unittest discover -s scripts -p "test_*.py" -v
```

## Optional Git hook

The repository includes a pre-commit hook that formats staged JSON `.object` files. Enable it for this checkout with:

```powershell
git config core.hooksPath scripts
```

The hook is optional and can be disabled by removing that local Git configuration:

```powershell
git config --unset core.hooksPath
```
