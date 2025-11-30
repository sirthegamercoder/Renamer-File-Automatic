# Renamer File Automatic
A Powershell script (.ps1) that allows you to automatically rename files from subfolders without any hassle.

---

## How it works?
When the `.ps1` file is run, the user is prompted to enter the folder path. After entering it, the script will check several subfolders and their contents. The user is then prompted to enter an input name. After entering it, four digits will be added to the input name. Next, the script will rename several files, and each subsequent file will have four digits added to its name. After the process is complete, you will be asked whether you want to continue to the next subfolder or not.
>[!TIP]
>Before running your script `.ps1` file, you need to run Powershell as administrator first, then type `Set-ExecutionPolicy -ExecutionPolicy Unrestricted` or `Set-ExecutionPolicy -ExecutionPolicy Bypass` before running the script `.ps1` file

---
*This script was made for FNF (Friday Night Funkin') modders who want to create a spritesheet in Funkin Packer but cannot change the prefix name*