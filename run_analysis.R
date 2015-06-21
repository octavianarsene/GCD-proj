#'
#' Get Human Activity data
#'
#' @return averaged measurements grouped by subject and activity data frame
#' 
getHumanActv <- function(){
  #read features file
  feats <- read.csv("UCI HAR Dataset/features.txt", header=FALSE, sep="", col.names=c('IDX', 'FEATS'), colClasses=c('NULL', NA))
  vfeats <- as.vector(feats)
  fcn <- createFeatsNames(feats)
  
  #read training files
  actr <- read.csv("UCI HAR Dataset/train/y_train.txt", header = FALSE, col.names = "ACTV_CD") 
  sctr <- read.csv("UCI HAR Dataset/train/subject_train.txt", header = FALSE, col.names = "SBJ_CD")
  mtr <- read.csv("UCI HAR Dataset/train/X_train.txt", header = FALSE, sep = "", col.names = vfeats[,], colClasses = fcn)
  
  dtr <- data.frame(sctr, actr, mtr)
  
  #reading test files
  actst <- read.csv("UCI HAR Dataset/test/y_test.txt", header=FALSE, col.names="ACTV_CD") 
  sctst <- read.csv("UCI HAR Dataset/test/subject_test.txt", header=FALSE, col.names="SBJ_CD")
  mtst <- read.csv("UCI HAR Dataset/test/X_test.txt", header=FALSE, sep="", col.names= vfeats[,], colClasses = fcn)
  
  dtst <- data.frame(sctst, actst, mtst)
  
  #merge training & test data sets
  df <- rbind(dtr, dtst)
  
  #add activity labels
  actl <- read.csv("UCI HAR Dataset/activity_labels.txt", header = FALSE, sep = "", col.names = c('ACTV_CD', 'ACTV_NAME'))
  dfm <- merge(df, actl, by.x = 'ACTV_CD', by.y = 'ACTV_CD', all = FALSE)
  
  #remove activity codes and rearrange the cols
  ncols = ncol(dfm)
  df <- dfm[, c(2, ncols, 3:(ncols-1))]
  
  df <- aggregateSubjActv(df)
}

#'
#' Compute the average of measurements grouping by Subject and Activity
#' @param df data frame with filtered measurements list
#' @return averages grouped by subject and activity
#' 
aggregateSubjActv <- function(df){
  ncols = ncol(df)
  adf <- aggregate(df[,3:ncols], list(df$ACTV_NAME, df$SBJ_CD), mean)
  #swap cols
  adf <- adf[, c(2, 1, 3:ncols)]
  names(adf)[1] <- 'Subject Code'
  names(adf)[2] <- 'Activity'
  
  adf
}

#'
#' Filter the 'mean' and 'std' columns
#' @param feats data frame will all measurements
#' @return column names having NULL for non mean and std deviation
#'
createFeatsNames <- function(feats){
  idx <- which(grepl('mean\\(', feats$FEATS) | grepl('std\\(', feats$FEATS))
  fcn <- rep('NULL', nrow(feats))
  sz <- length(idx)
  for(i in 1:sz) {
    fcn[idx[i]] = NA
  }
  
  fcn
}