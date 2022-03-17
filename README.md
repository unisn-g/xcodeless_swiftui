# Xcodeless SwiftUI MacOS App

This git contains a template project for building MacOS applications without using the Xcode IDE. It uses GNU Make instead.

## Prerequisites 

- Command Line Tools
- Python

Command line tools are needed to build this template.
To install command line tools, type this command in Terminal:

```
xcode-select —install
```

The scripts that create the .plist files require python to run.

## Building the Project

To build the project, navigate to the root folder and type `make`. This will create a folder called build with an application in it. Double click on it to run the application.

To build a DMG installer, type `make image`.

`make clean` will clean out the build folder.

### Change the Name of the Executable

Open the Makefile and adjust the first four variables to your liking.
