library("ggplot2"); #Loading graphical library


# ======= Loading the dataset as data frame

cat("Loading dataset.\n");

planes <- read.delim("2006.csv",
                     sep = ",",
                     stringsAsFactors = FALSE,
                     header = TRUE,
                     na.string = "");

cat("Dataset loaded.\n");


# ======== Organizing dataset

# Vector of columns name to be kepts
columns.toKeep <- c("Year", "Month", "DayofMonth", "DepTime", "CRSDepTime", "ArrTime", "CRSArrTime", "ActualElapsedTime",
"CRSElapsedTime", "AirTime", "ArrDelay", "DepDelay", "Origin", "Dest", "TaxiIn", "TaxiOut", "Cancelled");

# Keeping only columns from columns.toKeep
cat("Removing useless columns.\n");
planes <- planes[,columns.toKeep];
cat("Columns removed.\n");

# Building a Date object "Date" column
cat("Creating \"Date\" column from Year, Month, DayofMonth.\n");
planes <- transform(planes,
                    Date = as.Date(paste(Year,
                                         Month,
                                         DayofMonth,
                                         sep = "/"),
                                   "%Y/%m/%d"));
cat("\"Date\" column created.\n");

# Building a YearMonth string from Date column
cat("Creating \"YearMonth\" column.\n");
planes$YearMonth <- strftime(planes$Date, format = "%Y/%m");
cat("\"YearMonth\" column created.\n");

print(head(planes));

# ========== Printing graph: How many flight / months
# Graph
graph.howManyPlanes <- ggplot(planes, aes(x = YearMonth)) +
                       geom_histogram();

# Saving graph
ggsave(plot=graph.howManyPlanes, filename="flightsPerMonth.png", height=8, width=6)

# Printing graph
print(graph.howManyPlanes);