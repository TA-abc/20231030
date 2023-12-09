# Library
library(ggplot2)

# Dummy data
x <- LETTERS[1:20]
y <- paste0("var", seq(1,20))
dat <- expand.grid(X=x, Y=y)
dat[["Z"]] <- runif(400, 0, 5)

# Controle y order
dat[["Y"]] <- factor(
  dat[["Y"]]
 ,levels = sort(unique(dat[["Y"]]),decreasing = T)
)

xcol <- "X"
ycol <- "Y"
zcol <- "Z"


# Heatmap 
g <- ggplot(dat, aes(x=.data[[xcol]], y=.data[[ycol]], fill=.data[[zcol]]))
g <- g + geom_tile()

#g <- g + scale_fill_gradient(
#  low="white"
#  ,high="black"
#  ,na.value="white"
#)
g <- g + scale_fill_gradient(
  low="white"
 ,high="black"
 ,na.value = "transparent"
 ,breaks=c(
   min(dat[[zcol]])
  ,median(dat[[zcol]])
  ,max(dat[[zcol]])
  )
 ,labels=c(
   paste0("Minimum(", substring(min(dat[[zcol]]),1,4),")")
  ,paste0("Median(", substring(median(dat[[zcol]]),1,4),")")
  ,paste0("Maximum(", substring(max(dat[[zcol]]),1,4),")")
  )
 ,name="Z value"
)
#g <- g + guides(fill=guide_legend(title="Z value"))

g



