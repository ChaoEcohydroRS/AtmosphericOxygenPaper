# A persistently low level of atmospheric oxygen in Earth's middle age

This GitHub repository includes R scripts (also accessed online from figshare http://10.6084/m9.figshare.13114379) for importing, analyzing, and visualizing the data using R statistical software (http://www.R-project.org/).

## Contents

- [Overview](#overview)
- [Repo Contents](#repo-contents)
- [System Requirements](#system-requirements)
- [Installation Guide](#installation-guide)
- [Demo](#demo)
- [License](./LICENSE)
- [Citation](#citation)

# Overview
This GitHub repository includes R scripts to reproduce the analyses in the manuscript, 
"A persistently low level of atmospheric oxygen in Earth's middle age". 
Datasets includes the compilation of Ce/Ce* in marine carbonate rocks, as well as pO2 dataset and proxy results from other models during the Phanerozoic Eon. 
The datasets used in this study are available upon request (xiaomliu@email.unc.edu). 


The code does the following analyses: 
(1) fit a curve to the lowest 10% of Ce/Ce* values in every 100 Myr interval, 
(2) provide quantitative estimates of Earth’s atmospheric oxygen evolution after the GOE using our compiled Ce/Ce* carbonate data and a thermodynamics-based Ce oxidization model,
(3) selected lowest Ce/Ce* values for a given time interval and consider the statistical distribution of sample numbers, for example, used the lowest 10% (<10th percentiles) of values for each 100 Myr interval to estimate the atmospheric oxygen level from the Ce/Ce* data for each group,
(4) compare our modeling pO2 results with other models and proxy results during the Phanerozoic Eon. 

The Figs 2 and 3 included in the study can be reproduced using this scripts with R statistical software (http://www.R-project.org/).

# Repo Contents

- [README.md]: the detailed documentation, and usage of the script examples.
- [R_ScriptForFigure2.R]: R script for reproducing Figure 2
- [R_ScriptForFigure3.R]: R script for reproducing Figure 3
- [License]: License file


# System Requirements
## OS Requirements
The developmental version of the scripts has been tested on the Windows 10 systems. 
The scripts should be compatible with Mac, and Linux operating systems because it has used R packages which is a compatible software.

### Hardware Requirements
The scripts requires only a standard computer with enough RAM to support the operations defined by a user. For minimal performance, this will be a computer with about 2 GB of RAM. For optimal performance, we recommend a computer with the following specs (same as the computation environment we used):

RAM: 8+ GB  
CPU: 4+ cores, 3.2+ GHz/core

The runtimes below are generated using a computer with the recommended specs (8 GB RAM, 4 cores@3.2 GHz).

### Software Requirements

Before setting up script testing environment, users should have `R` version 3.3.2 (which we used) or higher, and several packages set up from CRAN.

# Installation Guide
### Installing R version 3.4.2 on Windows 10

the latest version of R can be installed by following the guilds below:

1. Download R from http://cran.us.r-project.org/.
2. Click on Download R for Windows. Click on base. Click on Download R 3.3.2 for Windows (or a newer version that appears).
3. Install R. Leave all default settings in the installation options.

4. Install RStudio requires R 3.0.1+.

5. Download RStudio Desktop for windows from http://rstudio.org/download/desktop (it should be called something like RStudio Desktop 1.3.1093 — Windows Vista/7/8/10). Choose default installation options.
6. Open RStudio. 
(If you want to learn how to install packages, you can see find some tutorials from the following site or from some books:
https://towardsdatascience.com/setup-a-data-science-environment-on-your-personal-computer-6ce931113914).

total setup time depending on your personal computer system and familar with the R software,
but usually should install within about 10 minues.


### Package dependencies

Users should install the following packages prior to using these scripts:

```
install.packages(c('ggplot2', 'quantreg', 'dplyr', 'tidyverse'))
```

which will install in about 20 seconds on a machine with the recommended specs.


If you are having an issue that you believe to be tied to software versioning issues, please drop us an [Issue](https://github.com/neurodata/lol/issues). 



# Demo
## Instructions to run on data

```
#Loading the dependence packages
library(quantreg)
library(dplyr)
library(ggplot2)
library(tidyverse)

#define a workstation
workstation='C:\\Workstation\\XiaomingLiu\\'

# loading the compar dataset
#give the file path of the dataset prepared
csvfile=paste(workstation,'Ce_DataVersion3.csv',sep='')

#read the csv file and get the dataframe
CeDataFrame <- read_csv(csvfile)
```





The R script file named "R_ScriptForFigure3.txt" is used to reproduce the Figure 3 in this paper.

# Instructions for use
### Figure 2 quick example
The R script file named "R_ScriptForFigure2.txt" is used to reproduce the Figure 2 in this paper.
The script has add very detialed comments for almost each line of the code and please check out the code into the R script.


library(quantreg)
library(dplyr)
library(ggplot2)
library(tidyverse)





### Figure 3 quick example

# License
MIT License

Copyright (c) 2019-2020 Guillaume Rousselet

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.


# Citation

For usage of the scripts and associated manuscript, please cite according to citation of the published paper.
Xiaoming Liu et.al. 2020. A persistently low level of atmospheric oxygen in Earth's middle age, Nature communications. Under-reviewing
