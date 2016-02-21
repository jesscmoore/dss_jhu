#! /usr/bin/env Rscript
# plot2.r			Loads electricity data and plots time series of household 
# global minute-averaged active power (in kilowatt)
#
# author: Jess Moore
# created: 21 February, 2015
#
# comments:

# Turn warnings into errors to debug warnings
# options(warn=2)

setwd("/Users/jesscobrien/Google Drive/code/Coursera/ExploratoryDataAnalysis")

# store the current directory
initial.dir<-getwd()

# load data into dataframe
datafile <- "household_power_consumption.txt"
hpc <- read.csv(datafile, header=TRUE, sep=";",na.string="?",stringsAsFactors=FALSE)
names(hpc)
str(hpc)

# Navigate to plotting dir
setwd("dss_jhu")

# convert date factor vector to date object for plotting and maths, and string vector
hpc$Datetime<-strptime(paste(hpc$Date,hpc$Time),"%d/%m/%Y %H:%M:%S")
hpc$Date<-as.Date(hpc$Date,format="%d/%m/%Y")
str(hpc)
head(hpc)
tail(hpc)
readline(prompt = "Check classes: ")

# Select date range and columns
ss<-subset(hpc,Date>=as.Date("2007-02-01") & Date<=as.Date("2007-02-02"))
str(ss)

# Plot time series
with(ss,plot(Datetime,Global_active_power,type="n",
             ylab="Global Active Power (kilowatts)",xlab=""))
with(ss,lines(Datetime,Global_active_power))

readline(prompt = "Check plot: ")

# Plot to png
outfile="plot2.png"
png(filename=outfile,width=480,height=480)
with(ss,plot(Datetime,Global_active_power,type="n",
             ylab="Global Active Power (kilowatts)",xlab=""))
with(ss,lines(Datetime,Global_active_power))
dev.off()
cat("-> Printed plot to png: ",outfile,"\n")


# Return to working dir
setwd(initial.dir)
