Human Activity Recognition Using Smartphones
============================================

Included is a run_analysis.R script that will analyze the data from the research on Recognizing Activities based on Smartphone accelerometer readings found here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The final data set should be in a tidier more human readable format which has the averages of each variable for each test subject based on their activity.

A copy of the data has been included in this repo, in order to run this all one should need to do is:
```
setwd("path/to/the/cloned/repo")
source("run_analysis.R")
run_analysis()
```

If you wish to read the output file in R you could do the following:
```
cell_phone_data <- read.table(file.path("output.txt"), header = TRUE)
```