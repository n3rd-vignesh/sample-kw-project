README for Demosthenes - a sample C/C++ project for exploring Klocwork

INTRODUCTION

You can use the sample Demosthenes project to test your installation or to explore or
demonstrate Klocwork. You can explore the sample Demosthenes project as a desktop
project, connected to an integration build analysis. Five revisions of the project at
the integration build level let you compare analysis results over time.

You can use:
 * Klocwork Desktop analysis Command-line tools
 * Klocwork Desktop C/C++/C# Plug-in for Microsoft Visual Studio
 * Klocwork Desktop C/C++ Plug-in for Eclipse
 * Server-side Klocwork Static Analysis

---------------------------------------------------------------------------------------
PLATFORMS

Klocwork must be installed on one of the supported platforms listed in the System
requirements:
https://docs.roguewave.com/en/klocwork/current/systemrequirements


---------------------------------------------------------------------------------------
PACKAGES TO INSTALL

For a demo of Server-side Klocwork Static Analysis:
* Install the Server package.

For a demo of Connected desktop:

* Install the Klocwork Server package.
* Install one of the Klocwork Desktop packages (Command-line or IDE integrations)

For more information, see:
https://docs.roguewave.com/en/klocwork/current/kwinstallguide



---------------------------------------------------------------------------------------
RUNNING AN INTEGRATION BUILD ANALYSIS ON WINDOWS

Prerequisites:

- A Klocwork server must be running.
  The URL can be specified by setting the KW_SERVER_URL environment variable.
  Defaults to http://localhost:8080

- Windows SDK 8.1 when analyzing with Visual Studio 2017
  This can be installed using the Visual Studio Installer either through the GUI
  or through an administrator command prompt.
  
- Windows SDK 10 when analyzing with Visual Studio 2019
  It is included by default as part of the Visual Studio 2019 installation

  Example:
  "%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vs_installershell.exe" modify --installPath "%ProgramFiles(x86)%\Microsoft Visual Studio\2017\Professional" --add Microsoft.VisualStudio.Component.Windows81SDK

From <server_install>\samples\demosthenes, run:
 kwrun.bat

kwrun.bat creates a directory called demosthenes_winbuild in its current working
directory. kwrun.bat creates a demosthenes project on the server and analyzes each
revision of the source code.


---------------------------------------------------------------------------------------
RUNNING AN INTEGRATION BUILD ANALYSIS ON LINUX OR SOLARIS

Prerequisites:

- A Klocwork server must be running.

From <server_install>/samples/demosthenes, run:

  [<environment_variable_settings>] kwrun.sh [<output directory>]

Note that for Ubuntu machines that use the Dash shell, run:

  [<environment_variable_settings>] /bin/bash ./kwrun.sh [<output directory>]

where:

  <environment_variable_settings> can include:
  * KW_SERVER_URL=<url>    - specifies the Klocwork Server URL (defaults to
    http://localhost:8080)
  * KW_NO_KWINJECT=[yes|y] - generate build specification without kwinject

  <output_directory> is the directory where all analysis data is stored. The default
  output directory is demosthenes_build, in the current working directory.

kwrun.sh creates a demosthenes project on the server and analyzes each revision of the
source code.


---------------------------------------------------------------------------------------
ACCESSING INTEGRATION BUILD ANALYSIS RESULTS IN KLOCWORK STATIC CODE ANALYSIS

1. In your browser, enter the following URL:
   http://<klocwork_server_host>:<klocwork_server_port>
2. Log in. A user name and password are not required if you have
   installed the Server package on localhost.
3. Choose demosthenes in the Project list.


---------------------------------------------------------------------------------------
DESKTOP ANALYSIS - MICROSOFT VISUAL STUDIO

1. In Visual Studio, Go to Tools > Options > Klocwork and enter License and Klocwork
   Server information.

Open Demosthenes:

1. Go to File > Open > Project/Solution.
2. Navigate to <server_install>\samples\demosthenes.
3. Open the folder that pertains to your version of Visual Studio.
4. Open the 4.sln, 4.vcproj or 4.vcxproj file.

Connect to the server project:

1. Right-click the solution (4.sln, 4.vcproj or 4.vcxproj) in the Solution Explorer.
2. Click Klocwork Solution Properties.
3. Select "demosthenes" from the Klocwork project list.
4. Click OK.

Run the analysis:
* The desktop project will automatically be synchronized with the server
  project.
* With on-the-fly analysis, issues are detected when you pause from typing. It can also
  be configured to run only after you save a file.


---------------------------------------------------------------------------------------
DESKTOP ANALYSIS - COMMAND-LINE

1. Open a console and change directory to the demosthenes demo folder
2. Execute the kwdtprep batch file or shell script.
3. This script will extract a Klocwork build specification from the demosthenes Visual
   Studio solution files and run a local analysis using kwcheck


---------------------------------------------------------------------------------------
FEATURES TO EXPLORE

* Some core code issues: ABV, NPD, MLK, FNH, FMM, UFM. Use F1 to view detailed help for
  a selected issue.
* Some code churn (the number of classes/methods varies)
* One cluster

Copyright (c) Perforce Software, Inc. All rights reserved.
