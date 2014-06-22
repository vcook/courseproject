### README.md

## run_analysis.R

The "run_analysis.R" script transforms raw Samsung data from files located in
the "./UCI HAR DATA/" subdirectory into two datasets, _data1_ and _data2_.

This script performs the following operations:

* Reads raw data from the test and training files, including separate activity, subject, and feature variable data.
* Merges the raw data into a single _data1_ dataset.
* Truncates _data1_ by selecting a subset of 66 feature variables that have mean() and std() measurements.
* Reads descriptive activity labels and substitutes them for the activity integer variable in _data1_.
* Reads descriptive variable names and substitutes them for the variable names in _data1_.
* Derives a wide tidy dataset, _data2_, from _data1_ that has mean values of for each feature variable for each observed activity/subject combination (listed under the Activity_SubjectID variable).
