#!/usr/bin/python
# -*- coding: utf-8 -*-
#
# Copyright (c) 2018 Alexander Gerasimov <samik.mechanic@gmail.com>
#

import os, platform, subprocess, sys, fileinput, string
from distutils.dir_util import copy_tree, remove_tree
from distutils.file_util import copy_file, move_file
from datetime import datetime

os.environ ['GCC_EXEC_PREFIX'] = '' # empty the GCC_EXEC_PREFIX variable due to Cygwin issues

def GetPackageVersion(platform): # semi-automatic installaltion package version assigning
    sdkVersionFile = "sdk-version" + "32"*platform
    with open(sdkVersionFile, "r") as f:
        fileVersion = [int(x) for x in f.readline().split(".")]
        for x in list(range(0,len(fileVersion)))[::-1]:
            fileVersion[x] += 1
            if x != 0 and fileVersion[x] == 10:
                fileVersion[x] = 0
            else:
                break

    if (len(sys.argv) == 2): # if you provided your version using the command line argument - use it
        print ("\nWARNING: Next package version should be " + ".".join(map(str, fileVersion)))
        if input("         Overwrite existing value [Y/N]? ").upper() in ["Y", "YES"]:
            try:
                fileVersion = [int(x) for x in sys.argv[1].split(".")]
                print ("\nNew package version confirmed: " + sys.argv[1] + "\n")
            except ValueError:
                print ("Error: invalid version value, falling back to " + ".".join(map(str, fileVersion)))

    nextVersion = ".".join(map(str, fileVersion))
    with open(sdkVersionFile, "w") as f: # save new installer package version for further use
        f.write(nextVersion)
    return nextVersion

def GetISPath(platform): # obtain the Inno Setup 5 compiler path from the registry
    import winreg
    key = winreg.OpenKey(winreg.HKEY_LOCAL_MACHINE, "SOFTWARE\\"
                                                      + "Wow6432Node\\"*(not platform)
                                                      + "Microsoft\\Windows\\CurrentVersion\\Uninstall\\Inno Setup 5_is1")
    value =  winreg.QueryValueEx(key, "InstallLocation")[0]
    return value + "ISCC.exe"

def PrepareScriptFiles(drive, version, platform):
    print ("\nPreparing script files\n------------------------------------")

    if os.path.isdir("installer_src" + "32"*platform): # remove old temporary installer directory
        remove_tree("\\\\?\\" + os.getcwd() + "\\installer_src" + "32"*platform)

    copy_tree("script_src", "installer_src" + "32"*platform) # making temporary directory for installer files
    copy_file("sdk" + "32"*platform + ".iss", "installer_src" + "32"*platform + "/sdk" + "32"*platform + ".iss")
    os.chdir("installer_src" + "32"*platform + "/")

    subprocess.call("tar -xzf redist/jre-x86" +"_x64"*(not platform) + ".tar.gz") # extract your JRE tar archive for Eclipse

    for line in fileinput.input("sdk" + "32"*platform + ".iss", inplace=True):
        print (line.replace("VERSION", version), end='') # setting SDK version to the installer package script
    for line in fileinput.input("sdk" + "32"*platform + ".iss", inplace=True):
        print (line.replace("TEMP_DRIVE", drive), end='') # setting temporary drive letter of Eclipse distro to the installer package script
    for line in fileinput.input("sdk_contents.txt", inplace=True):
        print (line.replace("VERSION", version), end='') # setting SDK version to the installer package info page

    print ("Done.\n")

def PrepareEclipse(eclipse, version):
    print ("\nPreparing Eclipse\n------------------------------------")

    print ("Copy Eclipse distribution...", end='', flush=True)
    copy_tree(eclipse, "\\\\?\\" + os.getcwd() + "\\my-eclipse") # copy Eclipse distribution using extended UNC format (Eclipse files may have long filepaths)
    print ("Done.\n")

    os.chdir("my-eclipse/")
    with open("VERSION", "w") as versionFile: # save Sdk version to Eclipse distribution
        versionFile.write(version + " " + datetime.now().strftime('%Y%m%d-%H%M'))
    os.chdir("../")

def PreparePlugins(eclipse):
    installerDir = os.getcwd()
    print ("\nPreparing plugins\n------------------------------------")

    os.chdir(eclipse + "/../plugins/")
    try:
        pass # paste the code preparing your custom plugins (e.g. building from sources)
    except subprocess.CalledProcessError as e:
        print ("\nERROR: Error occured while building plugins. Aborting")
        exit(-1)

    os.chdir(installerDir + "/my-eclipse/")
    try:
        print ("\nInstall plugins...\n")
        pass # paste the code installing your custom plugins into Eclipse, e.g.
        # subprocess.check_call("eclipsec.exe -nosplash -application org.eclipse.equinox.p2.director -repository file:"
        # + eclipse + "/../plugins/Bin/ -installIU YourPlugin.feature.group")
    except subprocess.CalledProcessError as e:
        print ("\nERROR: Error occured while installing plugins. Aborting")
        exit(-1)
    os.chdir("../")
    print ("\nDone.\n")

def CopyCygwinObjects(platform): # distribute necessary Cygwin components
    winPathList = os.getenv('Path').split(';')
    cygPath = ""
    cygwinDll = ( 'cygwin1.dll', # add your necessary Cygwin libraries your toolhain needs.
                  'cygz.dll'   # these two are always needed
                # 'cygiconv-2.dll',
                # 'cygintl-8.dll',
                # 'cyggcc_s-seh-1.dll' if not platform else 'cyggcc_s-1.dll', # de careful with platform-depending Cygwin library names
                # etc.
                )
    print ("\nPreparing Cygwin distribution\n------------------------------------")
    for _path in winPathList:
        if "cygwin" + "64"*(not platform) + "\\bin" in _path: # find the Cygwin installation path in the PATH global variable
            cygPath = _path
    if cygPath == "":
        print ("\nERROR: Can't find current Cygwin installation in Path. Aborting")
        exit(-1)
    if not os.path.isdir("my-ide"):
        os.mkdir("my-ide")
    os.chdir("my-ide")
    os.mkdir("lib")
    for dll in cygwinDll:
        copy_file(cygPath + "\\" + dll, "lib\\"+dll) # copy the dll's
    terminfoEncoderPath = cygPath + "\\..\\usr\\share\\terminfo\\63\\cygwin" # file needed for correct console input behaviour
    terminfoDstPath = os.path.dirname("usr\\share\\terminfo\\63\\cygwin")    # file needed for correct console input behaviour
    if not os.path.exists(terminfoDstPath):
        os.makedirs(terminfoDstPath)
    copy_file(terminfoEncoderPath, terminfoDstPath)
    os.chdir("../")
    print ("Done.\n")

def Cleanup():
    print ("\nCleaning up\n------------------------------------")
    remove_tree("\\\\?\\" + os.getcwd() + "\\installer_src" + "32"*platform)
    print ("Done.\n")

if __name__ == '__main__':
    if (len(sys.argv) not in list(range(1,3))):
        print ("Usage: builder_win.py <version:optional>")
        exit(-1)

    platform = 1 if platform.architecture()[0].lower() == "32bit" else 0
    issPath = GetISPath(platform=platform)
    version = GetPackageVersion(platform=platform)

    binPath = os.getcwd() + "/../my_toolchain/bin" # directory of your toolchain content
    eclipsePath = os.getcwd() + "\\..\\eclipse\\eclipse_" + "64"*(not platform) + "32"*platform
    localFilesToCheck = ( ["script sources", "script_src"],
                          ["Eclipse", eclipsePath],
                          ["Eclipse plugins", eclipsePath + "\\..\\plugins"],
                          ) # ['file description', 'filePath']
                            # list of objects need to be checked for existense
    freeDrives = ['%s:' % d for d in string.ascii_uppercase if not os.path.exists('%s:' % d)] # select temporary drive letter for Eclipse distro
    selectedDrive = freeDrives[-2] if platform else freeDrives[-1]
    
    if not os.path.isdir(binPath):
        print ("\nERROR: Can't find toolchain in " + binPath + ". Aborting")
        exit(-1)

    if not os.path.isfile(issPath):
        print ("\nERROR: Can't find Inno Setup compiler in " + issPath[:-9] + ". Aborting")
        exit(-1)

    for file in localFilesToCheck:
        if not os.path.isdir(file[1]):
            if not os.path.isfile(file[1]):
                print ("\nERROR: Can't find " + file[0] + " in " + file[1] + ". Aborting")
                exit(-1)

    startString = "MY-SDK " + "x86"*platform + "x86_64"*(not platform) + " installer builder v" + version
    print ("\n\n")
    print (" **** ".center(80,'-'))
    print (startString.center(80,' '))
    print (" **** ".center(80,'-'))

    PrepareScriptFiles(drive=selectedDrive, version=version, platform=platform)
    PrepareEclipse(eclipse=eclipsePath, version=version)
    PreparePlugins(eclipse=eclipsePath)
    CopyCygwinObjects(platform=platform)

    outputName = "MY-SDK-" + version + "." + datetime.now().strftime('%Y%m%d-%H%M') + "-x86" + "_64"*(not platform)
    compilerOptions = "/Qp /O" + os.getcwd() + "/../ /F" + outputName + " sdk" + "32"*platform + ".iss" # compiler options (see ISCC.exe help for details)
    try:
        print ("\nBuilding installer\n------------------------------------\n")
        subprocess.call("subst " + selectedDrive + " " + os.getcwd() + "\\my-eclipse")
        subprocess.check_call("\"" + issPath + "\" " + compilerOptions, shell=True) # call the Inno Setup compiler to proceed with the packaging
        subprocess.call("subst "+ selectedDrive + " /D")
    except subprocess.CalledProcessError as e:
        print ("\nERROR: Setup script compilation has encountered an error. Aborting")
        exit(-1)
    os.chdir("../")
    
    Cleanup()
