@echo off
@set "INSTALL_PATH=%cd:\=/%"
@set GCC_EXEC_PREFIX=/cygdrive/%INSTALL_PATH:~0,1%/%INSTALL_PATH:~3,-4%/lib/gcc/
@set PATH=%cd%;%cd:~,-4%\lib;%PATH%