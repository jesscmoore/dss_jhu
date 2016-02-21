#! /usr/bin/env Rscript
# plot1.r			Loads electricity data and plots as histogram the household 
# global minute-averaged active power (in kilowatt)
#
# author: Jess Moore
# created: 20 February, 2015
#
# comments:

# Turn warnings into errors to debug warnings
# options(warn=2)

setwd("/Users/jesscobrien/Google Drive/code/Coursera/ExploratoryDataAnalysis")

# store the current directory
initial.dir<-getwd()

# load data into dataframe
datafile <- "household_power_consumption.txt"
hpc <- read.csv(datafile, header=TRUE, sep=";",na.string="?")
names(hpc)
str(hpc)

# Navigate to plotting dir
setwd("dss_jhu")

# convert date factor vector to date object for plotting and maths, and string vector
hpc$Date<-as.Date(hpc$Date,format="%d/%m/%Y")
str(hpc)
head(hpc)
tail(hpc)
readline(prompt = "Check classes: ")

# Select date range and columns
ss<-subset(hpc,Date>=as.Date("2007-02-01") & Date<=as.Date("2007-02-02"),select=c(Date,Global_active_power) )
dim(ss)
str(ss)

# Plot histogram
hist(ss$Global_active_power,
     xlab="Global Active Power (kiowatts",main="Global Active Power",col="red")

readline(prompt = "Check plot: ")

# Plot to png
outfile="plot1.png"
png(filename=outfile,width=480,height=480)
hist(ss$Global_active_power,
     xlab="Global Active Power (kiowatts",main="Global Active Power",col="red")
dev.off()
cat("-> Printed plot to png: ",outfile,"\n")

# Return to working dir
setwd(initial.dir)

