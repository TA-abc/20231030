# R hclust

dat <- iris[,-5]
rd <- dist(dat)
rd.mat <-as.matrix(rd)
dim(rd.mat)

methods <- c(
  "ward.D","ward.D2","single"
 ,"complete","average","mcguitty"
 ,"median","centroid"
)

method <- methods[1]
rc <- hclust(d=rd,method="ward.D2",members = NULL)
# data.frame or matrix error
#
# member != NULL
# - d  not dissimilarity between singleton, but dissimilarity between clusters
# - members are observation number by cluster.

plot(rc)

# ?hclust
# 
# Value
# merge	
# an n-1 by 2 matrix. 
# Row i of merge describes the merging of clusters at step i of the clustering. 
# If an element j in the row is negative, then observation −j was merged at this stage. 
# If j is positive then the merge was with the cluster formed at the (earlier) stage j of the algorithm. 
# Thus negative entries in merge indicate agglomerations of singletons, and positive entries indicate agglomerations of non-singletons.
# height
# a set of n−1 real values (non-decreasing for ultrametric trees). 
# The clustering height: that is, the value of the criterion associated with the clustering method for the particular agglomeration.
# order
# a vector giving the permutation of the original observations suitable for plotting, 
# in the sense that a cluster plot using this ordering and matrix merge will not have crossings of the branches.
# labels	
# labels for each of the objects being clustered.
# call	
# the call which produced the result.
# method	
# the cluster method that has been used.
# dist.method	
# the distance that has been used to create d 
# (only returned if the distance object has a "method" attribute).

rc$merge[1:5,]
plot(rc$merge[,1],rc$merge[,2])
rc$height
rc$order
rc$labels
rc$method
rc$call
rc$dist.method



rc.cut <- cutree(tree=rc,k=2)
rc.cut


# Example

require(graphics)

### Example 1: Violent crime rates by US state

hc <- hclust(dist(USArrests), "ave")
plot(hc)
plot(hc, hang = -1)

## Do the same with centroid clustering and *squared* Euclidean distance,
## cut the tree into ten clusters and reconstruct the upper part of the
## tree from the cluster centers.
hc <- hclust(dist(USArrests)^2, method = "cen")
memb <- cutree(hc, k = 10)
cent <- NULL
for(k in 1:10){
  cent <- rbind(cent, colMeans(USArrests[memb == k, , drop = FALSE]))
}

USArrests[1:3,]
cent[1:3,]

hc1 <- hclust(dist(cent)^2, method = "cen", members = table(memb))
opar <- par(mfrow = c(1, 2))
plot(hc,  labels = FALSE, hang = -1, main = "Original Tree")
plot(hc1, labels = FALSE, hang = -1, main = "Re-start from 10 clusters")
par(opar)

### Example 2: Straight-line distances among 10 US cities
##  Compare the results of algorithms "ward.D" and "ward.D2"

mds2 <- -cmdscale(UScitiesD)
plot(mds2, type="n", axes=FALSE, ann=FALSE)
text(mds2, labels=rownames(mds2), xpd = NA)

hcity.D  <- hclust(UScitiesD, "ward.D") # "wrong"
hcity.D2 <- hclust(UScitiesD, "ward.D2")
opar <- par(mfrow = c(1, 2))
plot(hcity.D,  hang=-1)
plot(hcity.D2, hang=-1)
par(opar)


