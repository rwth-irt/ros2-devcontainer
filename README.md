# ROS2 Devcontainer

This repo will get you set up using ROS2 with VSCode as your IDE.

Based on Allison Thackston's template, see [how she develops with vscode and ros2](https://www.allisonthackston.com/articles/vscode_docker_ros2.html) for a more in-depth look on how to use this workspace.

## Features

### Style

ROS2-approved formatters are included in the IDE.  

* **c++** uncrustify; config from `ament_uncrustify`
* **python** autopep8; vscode settings consistent with the [style guide](https://index.ros.org/doc/ros2/Contributing/Code-Style-Language-Versions/)

### Tasks
There are many pre-defined tasks, see [`.vscode/tasks.json`](.vscode/tasks.json) for a complete listing.
You are welcome to adjust them to suit your needs.  

Take a look at [how I develop using tasks](https://www.allisonthackston.com/articles/vscode_tasks.html) for an idea of how Allison uses tasks in her development.

### Debugging

This template sets up debugging for python files, gdb for cpp programs and ROS launch files.  See [`.vscode/launch.json`](.vscode/launch.json) for configuration details.

### Continuous Integration

The template also comes with basic continuous integration set up. See [`.github/workflows/ros.yaml`](/.github/workflows/ros.yaml).

To remove a linter, just delete its name from this line:

```yaml
      matrix:
          linter: [cppcheck, cpplint, uncrustify, lint_cmake, xmllint, flake8, pep257]
```

## How to use this devcontainer

### Prerequisites

You should already have Docker and VSCode with the remote containers plugin installed on your system.

* [docker](https://docs.docker.com/engine/install/)
* [vscode](https://code.visualstudio.com/)
* [vscode remote containers plugin](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)


### Clone repo

Now you can clone this repo as normal

![template_download](https://user-images.githubusercontent.com/6098197/91332342-e4e0f680-e780-11ea-9525-49b0afa0e4bb.png)

### Open it in VSCode

Now that you've cloned your repo onto your computer, you can open it in VSCode (File->Open Folder). 

When you open it for the first time, you should see a little popup that asks you if you would like to open it in a container.  Say yes!

![template_vscode](https://user-images.githubusercontent.com/6098197/91332551-36898100-e781-11ea-9080-729964373719.png)

If you don't see the pop-up, click on the little green square in the bottom left corner, which should bring up the container dialog

![template_vscode_bottom](https://user-images.githubusercontent.com/6098197/91332638-5d47b780-e781-11ea-9fb6-4d134dbfc464.png)

In the dialog, select "Remote Containers: Reopen in container"

VSCode will build the Dockerfile inside `.devcontainer` for you.  If you open a terminal inside VSCode (Terminal->New Terminal), you should see that your username has been changed to `ros`, and the bottom left green corner should say "Dev Container"

![template_container](https://user-images.githubusercontent.com/6098197/91332895-adbf1500-e781-11ea-8afc-7a22a5340d4a.png)

### Adapt to your needs
Check your `docker-compose.yml` and adjust values as required, specifically `Optional` values.
This allows you to en-/disable the dedicated NVIDIA GPU or use external devices.

### Update the template with your code
1. Specify the repositories you want to include in your workspace in `src/ros2.repos` or delete `src/ros2.repos` and develop directly within the workspace.
2. If you are using a `ros2.repos` file, import the contents `Terminal->Run Task..->import from workspace file`
3. Install dependencies `Terminal->Run Task..->install dependencies`
4. (optional) Adjust scripts to your liking.  These scripts are used both within tasks and CI.
   * `setup.sh` The setup commands for your code.  Default to import workspace and install dependencies.
   * `build.sh` The build commands for your code.  Default to `--merge-install` and `--symlink-install`
   * `test.sh` The test commands for your code.
5. Develop!

### Check if everything is working
Check the output in the *Dev Containers* terminal, it should give you an `OpenGL renderer string` which specifies your GPU vendor.

Run this command to see if the GUI show up, TAB autocomplete should work.
Requires `ros2-<distro>-desktop` to be installed in `.devcontainer/Dockerfile`
```bash
ros2 run turtlesim turtlesim_node
```
Start another terminal and run this node to control the turtle with your keyboard, instructions are printed into the terminal.
```bash
ros2 run turtlesim turtle_teleop_key
```
Finally check whether the Qt and 3D applications work without glitches, e.g., when resizing:
```bash
ros2 run rviz2 rviz2
```

## FAQ

### git asks for user and email
Check if *configuring* the container finished.
The vscode remote containers extension should handle the magic for you, but does only so after successfully running the `postCreateCommand`.

### WSL2 networking
WSL2 supports different networking modes, **NAT** being the default.
Communication with external devices requires to forward ports and set firewall rules, e.g., using [this tool](https://github.com/Esensats/pfwsl).
However, this approach only supports TCP ports, not UDP ports.

Recently, Microsoft added the **mirrored** which enables working with external devices over all protocols.
However, simple examples do not work using the DDS discovery mechanism.
Starting the ros2 daemon resolves this issue, but might require additional steps if you have a multi machine setup.
```bash
ros2 daemon start
```