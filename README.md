# \## STARTED PUSH AT 8:50AM (central time), but for some reason original .git was 3GB. had to remake repo and repush and increase git buffersize, ultimately finishing initial 8:50AM at 10:10AM!
______________________________________________________________________________________________

#[Eventually environment setup will be bundled in fashionfit.bat/sh script (used to run full pipeline from video input to final output) (currently defunct script fails to execute all pipeline commands as outlined in: https://github.com/graphdeco-inria/gaussian-splatting
# ...and out of time to correct [next version task])

# Environment setup instructions: https://medium.com/@heyulei/install-inrias-gaussian-splatting-source-code-on-windows-7781460518ef#id_token=eyJhbGciOiJSUzI1NiIsImtpZCI6IjA3ZjA3OGYyNjQ3ZThjZDAxOWM0MGRhOTU2OWU0ZjUyNDc5OTEwOTQiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIyMTYyOTYwMzU4MzQtazFrNnFlMDYwczJ0cDJhMmphbTRsamRjbXMwMHN0dGcuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIyMTYyOTYwMzU4MzQtazFrNnFlMDYwczJ0cDJhMmphbTRsamRjbXMwMHN0dGcuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMDcxMjkzNzEyOTIzNjExNjYwNDMiLCJlbWFpbCI6ImVuaWthdGhAZ21haWwuY29tIiwiZW1haWxfdmVyaWZpZWQiOnRydWUsIm5iZiI6MTc1ODQxNzEwMywibmFtZSI6IkpvaG4gVGh1bW1lbCIsInBpY3R1cmUiOiJodHRwczovL2xoMy5nb29nbGV1c2VyY29udGVudC5jb20vYS9BQ2c4b2NKRUd6bzdJOE55TU1OUjlJX19uREpGWUgyT1hKN0lGSkNaOXNOajZ1RGFMTWtqRS1PRj1zOTYtYyIsImdpdmVuX25hbWUiOiJKb2huIiwiZmFtaWx5X25hbWUiOiJUaHVtbWVsIiwiaWF0IjoxNzU4NDE3NDAzLCJleHAiOjE3NTg0MjEwMDMsImp0aSI6Ijg0MGFlM2I2MmUwYzIyMWFjNzkzZTQ1MzU2OWZlOTBiZWVhMTUxZGYifQ.a_scZ-PMTPEv3r_OZK8c88zxaIk619-VXYvkBxhL1tDkS_cv2E-IWx2hHuQOPHBYm6nBldCKDyYP3HAaWFhx5s_Bk1JPb7A3wMixiWoyHq3zaJHzu1NUSltlnO5q8RbdiUtJu1TZEQx-CWJlh9hrwQdlSCBsjDpaONez4WMaHkqdJkHJsM5C_PpQTqAlFrPEjR9zlAVUH5b6UtbFQimPIAaSeqXQ9ErRSbWdIIOM8oRXX5JnRum7DaRaHJxewzwBApyMbYWvEsLcVQOdNQCClyXr2Ms4DZsyn-Nqh5FQvcAjpxJuqIlIIrKGsv8Nz9gYgiVtZaZTpjSshtBwR3phYg

# Current operation instructions (until fashionfit.bat/sh is fixed): https://github.com/graphdeco-inria/gaussian-splatting

______________________________________________________________________________________________


# \# Gaussian Splatting Environment Setup for Windows

# This repository contains the setup and implementation for INRIA's Gaussian Splatting on Windows systems. This guide provides step-by-step instructions to overcome common installation challenges on Windows platforms.

# 

# \## Prerequisites

# 

# Installing Gaussian Splatting on Windows requires specific versions of development tools due to compatibility issues. The main challenges are:

# \- Official source code supports Visual Studio 2019, but VS 2022 is currently the default download

# \- CUDA toolkit version compatibility issues with newer environments

# 

# \## Installation Guide

# 

# \### Step 1: Install Visual Studio 2019

# 

# > \*\*Important\*\*: If you have Visual Studio 2022 installed, please uninstall it first.

# 

# 1\. Download Visual Studio 2019 Professional from the \[official Microsoft releases page](https://learn.microsoft.com/en-us/visualstudio/releases/2019/history#release-dates-and-build-numbers)

# 2\. Install version 16.11.39 (recommended)

# 3\. During installation, select and install \*\*"Desktop development with C++"\*\* workload

# 

# \### Step 2: Install Anaconda

# 

# 1\. Download and install Anaconda from the \[official website](https://www.anaconda.com/download/success)

# 2\. Select the Windows version appropriate for your system

# 

# \### Step 3: Setup Python Environment and Dependencies

# 

# Open \*\*Anaconda Prompt\*\* and run the following commands:

# 

# ```bash

# \# Create and activate conda environment

# conda create --name gaussian\_splatting -y python=3.8

# conda activate gaussian\_splatting

# pip install --upgrade pip

# 

# \# Install PyTorch and CUDA toolkit

# pip install torch==2.1.2+cu118 torchvision==0.16.2+cu118 --extra-index-url https://download.pytorch.org/whl/cu118

# conda install -c "nvidia/label/cuda-11.8.0" cuda-toolkit

# ```

# 

# \### Step 4: Install Gaussian Splatting

# 

# ```bash

# \# Clone the source code with submodules

# git clone https://github.com/graphdeco-inria/gaussian-splatting --recursive

# cd gaussian-splatting

# 

# \# Install Python dependencies

# pip install plyfile tqdm

# 

# \# Install submodules

# pip install submodules/diff-gaussian-rasterization

# pip install submodules/simple-knn

# ```

# 

# \## Usage

# 

# \### Training

# 

# To train the Gaussian Splatting model on your dataset:

# 

# ```bash

# python train.py -s <path to COLMAP or NeRF Synthetic dataset>

# ```

# 

# \*\*Supported Dataset Formats:\*\*

# \- COLMAP datasets

# \- NeRF Synthetic datasets

# 

# \## System Requirements

# 

# \- \*\*Operating System\*\*: Windows 10/11

# \- \*\*GPU\*\*: NVIDIA GPU with CUDA 11.8 support

# \- \*\*RAM\*\*: Minimum 16GB recommended

# \- \*\*Storage\*\*: At least 10GB free space for installation and datasets

# 

# \## Troubleshooting

# 

# \### Common Issues

# 

# 1\. \*\*Compilation Errors\*\*: Ensure Visual Studio 2019 is properly installed with C++ development tools

# 2\. \*\*CUDA Compatibility\*\*: Verify your GPU supports CUDA 11.8

# 3\. \*\*Submodule Installation Failures\*\*: Make sure Visual Studio 2019 is in your system PATH

# 

# \### Environment Verification

# 

# To verify your installation, run:

# 

# ```bash

# python -c "import torch; print(torch.cuda.is\_available())"

# ```

# 

# This should return `True` if CUDA is properly configured.

# 

# \## Project Structure

# 

# ```

# gaussian-splatting/

# ├── submodules/

# │   ├── diff-gaussian-rasterization/

# │   └── simple-knn/

# ├── train.py

# ├── render.py

# ├── metrics.py

# └── environment.yml

# ```

# 

# \## Contributing

# 

# When contributing to this project, please ensure:

# 1\. Your development environment matches the specifications above

# 2\. All submodules are properly initialized

# 3\. Tests pass on Windows systems

# 

# \## License

# 

# This project follows the original Gaussian Splatting license from INRIA GraphDeco.

# 

# \## Acknowledgments

# 

# \- Original implementation by \[INRIA GraphDeco](https://github.com/graphdeco-inria/gaussian-splatting)

# \- Windows setup guide adapted from \[Heyulei's Medium article](https://medium.com/@heyulei/install-inrias-gaussian-splatting-source-code-on-windows-7781460518ef)

# 

# ---

# 

# \*\*Note\*\*: This setup has been tested on Windows 10/11 systems. For other operating systems, please refer to the original repository's documentation.

