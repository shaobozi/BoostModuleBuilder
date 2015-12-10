:: build script for build boost filesystem module
@ECHO OFF 
setlocal

pushd %~dp2

IF [%1]==[] set param_missed=1
IF [%2]==[] set param_missed=1

IF defined param_missed (
	ECHO.
	ECHO Usage: boost_module_build.bat ^<module_name^> ^<boost_src_root^> [build_dir]
	ECHO ----------------------------------------------------------------------------
	ECHO module_name: the module name going to be built
	ECHO boost_src_root: Specify the root directory of boost ^(e.g. D:\boost_1_54_0\^)
	ECHO build_dir[optional]: Where to build the filesystem module
	ECHO NOTE: DO NOT FORGET THE BACK SLASH AT THE END OF PATH
	ECHO.
	ECHO e.g. boost_module_build.bat filesystem D:\boost_1_54_0\ E:\boost_file_system
	ECHO.
	goto EOF)
:: b2.exe (boost.build) check
IF NOT EXIST %~dp2b2.exe call %~dp2bootstrap.bat 

:: Create default build directory if build directory is not provided
IF [%3]==[] (
	IF NOT EXIST "./build_%1" mkdir "./build_%1"
	set dest=./build_%1
) ELSE (
	set dest=%~dp3
)

:: build filesystem module
:: b2.exe --help to get a reference of all options and properties
set buildArgs=--build-type=complete --build-dir=%dest% --with-%1 toolset=msvc-10.0 variant=release,debug link=shared threading=multi runtime-link=shared

:: print final command
echo ------- The Command running------
echo %~dp2b2.exe %buildArgs%
echo 

:: Run 
"%~dp2b2.exe" %buildArgs%

:: print final command
echo ------- The Command runded------
echo %~dp2b2.exe %buildArgs%

popd

:EOF
