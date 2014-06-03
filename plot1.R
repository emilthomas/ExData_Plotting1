# Author : Emil Thomas


#Read first 2 rows, determine the class, then read the entire file for fast reading
dat <- read.table("household_power_consumption.txt", header = TRUE, sep=";", nrows= 2,na.strings="?")
classes <- sapply(dat, class)
dat <- read.table("household_power_consumption.txt", header = TRUE, sep=";", na.strings="?", colClasses= classes)

dat <- dat[grepl("^[12]/2/2007", dat$Date), ]                #search and retain rows the date starting with 1 or 2 of feb

#Begin Plotting
png(filename= "plot1.png", width=480, height=480)
hist(dat$Global_active_power,col="red",xlab="Global Active Power (kilowatts)", main="Global Active Power")
dev.off()
