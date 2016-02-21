#! /usr/bin/env Rscript
# plot3.r			Loads electricity data and plots time series of energy consumption in 
# different parts of the household
# Sub_metering_1: kitchen energy consumption (watt-hour of active energy)
# containing mainly a dishwasher, an oven and a microwave (hot plates are not electric but gas powered).
# Sub_metering_2: laundry energy consumption (watt-hour of active energy)
# containing a washing-machine, a tumble-drier, a refrigerator and a light.
# Sub_metering_3: electric water-heater and air-conditioner energy consumption 
# (watt-hour of active energy)
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
# hpc <- read.csv(datafile, header=TRUE, sep=";",na.string="?",stringsAsFactors=FALSE)
hpc <- read.csv(datafile, header=TRUE, sep=";",na.string="?")
names(hpc)
str(hpc)

# Navigate to plotting dir
setwd("dss_jhu")

# convert date and time factor vectors to date/character object for plotting and maths, and string vector
hpc$Datetime<-strptime(paste(hpc$Date,hpc$Time),"%d/%m/%Y %H:%M:%S")
hpc$Date<-as.Date(hpc$Date,format="%d/%m/%Y")
hpc$Time<-as.character(hpc$Time)
str(hpc)
head(hpc)
tail(hpc)
readline(prompt = "Check classes: ")


# Select date range and columns
ss<-subset(hpc,Date>=as.Date("2007-02-01") & Date<=as.Date("2007-02-02"))
str(ss)
summary(ss$Sub_metering_1)
summary(ss$Sub_metering_2)
summary(ss$Sub_metering_3)

# 
# # Plot time series
with(ss,plot(Datetime,Sub_metering_1,type="n",
              ylab="Energy sub metering",xlab=""))
with(ss,lines(Datetime,Sub_metering_1))
with(ss,lines(Datetime,Sub_metering_2,col="red"))
with(ss,lines(Datetime,Sub_metering_3,col="blue"))
legend("topright",lty=1,col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

readline(prompt = "Check plot: ")
 
# # Plot to png
outfile="plot3.png"
png(filename=outfile,width=480,height=480)

with(ss,plot(Datetime,Sub_metering_1,type="n",
             ylab="Energy sub metering",xlab=""))
with(ss,lines(Datetime,Sub_metering_1))
with(ss,lines(Datetime,Sub_metering_2,col="red"))
with(ss,lines(Datetime,Sub_metering_3,col="blue"))
legend("topright",lty=1,col=c("black","red","blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

dev.off()
cat("-> Printed plot to png: ",outfile,"\n")


# Return to working dir
setwd(initial.dir)
