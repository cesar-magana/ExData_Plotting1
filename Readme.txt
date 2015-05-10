
First you need to install sqldf. Type install.packages("sqldf") in the R console.

To execute the script from command line, just type one of the following commands:
1. R CMD BATCH plot1.R
2. Rscript plot1.R

If you want the output to print to the terminal it is best to use Rscript.  Note that when using R CMD BATCH plot1.R that instead of redirecting output to standard out and displaying on the terminal a new file called plot1.Rout will be created.