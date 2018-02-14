### Custom SDK installation package builder for Inno Setup 5

#### Introduction

This project is a good and (quite) simple example of _semi-automatic build system_ making the _installation packages_ for custom toolchains built on _Windows platform with Cygwin_.

This project might be helpful to you if:

1. You are making your own toolchain for Windows using Cygwin
2. Your toolchain is meant to be used with Eclipse IDE
3. You need to make a good-looking installation package to distribute your SDK

#### Project structure

Refer to **Project.tree** file.

#### System requirements

- MS Windows (tested on Windows 7 both 32- and 64-bit) **[INFO] all packages below need to be the same bitness!**
- Cygwin ( https://cygwin.com/install.html )
- Python with minimal version 3.5 ( https://www.python.org/downloads/ )
- JRE with minimal version 1.8 ( http://www.oracle.com/technetwork/java/javase/downloads/ )
- Inno Setup compiler with minimal version 5 ( http://www.jrsoftware.org/isdl.php )

#### Installer build requirements

- Custom toolchain build located in *my_toolchain/* folder
- Eclipse distributions located in *eclipse/eclipse_(bitness)/* folders
- Eclipse plugins (if needed) located in *eclipse/plugins/* folder

#### Building the installation package

To build the installation package, run the `builder.bat` script as shown:
```
builder.bat (version)
```

where *(version)* - your desired package version in x[.x](1-3) format (will be appended to the package name and to the package info properties). 
This argument is not obliged, the package version is taken from the _sdk-version / sdk-version32_ files by default depending on your machine bitness (automatically incrementing).

On successful build, the package will appear in the *installer/* folder with the name **MY-SDK-(version).(timestamp)**, where *(timestamp)* - the timestamp of current build date-time.

#### Installation package features

- **Universal**: you may easily change anything you want in the scrips to vary the package for your needs
- **Platform-independing**: script made the way you do not need to make any changes to get this working on the 32- or 64-bit machine - automatic bitness detection is on.
- **Updatable**: scripts configured for your easy and fast rebuild of your product and deliver it your clients. The package is configured for updating, removing and re-installing the current installations of your product 


#### Final SDK installation structure

After installing your SDK package to target machine, the structure will be as shown in **SDK.tree** file.
