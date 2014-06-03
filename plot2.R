# Author : Emil Thomas


#Read first 2 rows, determine the class, then read the entire file for fast reading
dat <- read.table("household_power_consumption.txt", header = TRUE, sep=";", nrows= 2, na.strings="?")
classes <- sapply(dat, class)
dat <- read.table("household_power_consumption.txt", header = TRUE, sep=";", na.strings="?", colClasses= classes)

dat = dat[grepl("^[12]/2/2007", dat$Date), ]			#search and retain the date starting with 1 or 2 of feb
dat$Date <- as.Date(dat$Date, format = "%d/%m/%Y")		#this is the format in the input file
temp <- paste(dat$Date, dat$Time)
datetime = strptime(temp, format="%Y-%m-%d %H:%M:%S")	#convert to POSIXct datatype

#Begin Plotting

png(filename= "plot2.png", width=480, height=480)
plot(datetime, dat$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab = "")
dev.off()		#for PNG
