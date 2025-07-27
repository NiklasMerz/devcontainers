# devcontainers

My devcontainer configs linked to project dirs.

## Setup Script

Use `setup-devcontainer.sh` to interactively copy and customize devcontainer configs:

```bash
./setup-devcontainer.sh
```

### Making Script Globally Available

To make the script available as a global command:

```bash
mkdir -p ~/.local/bin
ln -s ~/my-projects/devcontainers/setup-devcontainer.sh ~/.local/bin/setup-devcontainer
```

After setup, run from any project directory:
```bash
setup-devcontainer
```

### Bash Alias (Legacy)

```
alias setup-dc="mkdir -p .devcontainer && cp ~/my-projects/devcontainers/python-js.json .devcontainer/devcontainer.json"
```
