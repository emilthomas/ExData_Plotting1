# Author : Emil Thomas


#Read first 2 rows, determine the class, then read the entire file for fast reading
dat <- read.table("household_power_consumption.txt", header = TRUE, sep=";", nrows= 2, na.strings="?")
classes <- sapply(dat, class)
dat <- read.table("household_power_consumption.txt", header = TRUE, sep=";", na.strings="?", colClasses= classes)

dat = dat[grepl("^[12]/2/2007", dat$Date), ]            #search and retain the date starting with 1 or 2 of feb
dat$Date <- as.Date(dat$Date, format = "%d/%m/%Y")      #this is the format in the input file
temp <- paste(dat$Date, dat$Time)
datetime = strptime(temp, format="%Y-%m-%d %H:%M:%S")   #convert to POSIXct datatype

#Begin Plotting
png(filename= "plot3.png", width=480, height=480)       #although 480 is default...

plot(datetime, dat$Sub_metering_1, type = "l", col="black", xlab = "", ylab = "Energy sub metering")
lines(datetime, dat$Sub_metering_2, type = "l", col= "red")
lines(datetime, dat$Sub_metering_3, type = "l", col= "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty= c(1,1,1), col=c("black", "red", "blue")) 

dev.off()                                               #For png
