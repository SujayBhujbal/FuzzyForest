% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/fuzzyforest_fit.R
\name{wff}
\alias{wff}
\title{Fits WGCNA based fuzzy forest algorithm.}
\usage{
wff(X, y, Z = NULL, WGCNA_params = WGCNA_control(p = 6),
  screen_params = screen_control(min_ntree = 5000),
  select_params = select_control(min_ntree = 5000), final_ntree = 500,
  num_processors = 1, nodesize, test_features = NULL, test_y = NULL)
}
\arguments{
\item{X}{A data.frame. Each column corresponds to a feature
vector.  WGCNA will be used to cluster the
features in X.  As a result, the features should be
all be numeric.  Non-numeric features may be input
via Z.}

\item{y}{Response vector.  For classification, y should be a
factor or a character.  For regression, y should be
numeric.}

\item{Z}{Additional features that are not to be screened out
at the screening step.  WGCNA is not carried out on
features in Z.}

\item{WGCNA_params}{Parameters for WGCNA.
See \code{\link[WGCNA]{blockwiseModules}} and
\code{\link[fuzzyforest]{WGCNA_control}} for details.
\code{WGCNA_params} is an object of type
\code{WGCNA_control}.}

\item{screen_params}{Parameters for screening step of fuzzy forests.
See \code{\link[fuzzyforest]{screen_control}} for details.
\code{screen_params} is an object of type
\code{screen_control}.}

\item{select_params}{Parameters for selection step of fuzzy forests.
See \code{\link[fuzzyforest]{select_control}} for details.
\code{select_params} is an object of type
\code{select_control}.}

\item{final_ntree}{Number trees grown in the final random forest.
This random forest contains all selected features.}

\item{num_processors}{Number of processors used to fit random forests.}

\item{nodesize}{Minimum terminal nodesize. 1 if classification.
5 if regression.  If the sample size is very large,
the trees will be grown extremely deep.
This may lead to issues with memory usage and may
lead to significant increases in the time it takes
the algorithm to run.  In this case,
it may be useful to increase \code{nodesize}.}

\item{test_features}{A data.frame containing features from a test set.
The data.frame should contain the features in both
X and Z.}

\item{test_y}{The responses for the test set.}
}
\value{
An object of type \code{\link[fuzzyforest]{fuzzy_forest}}.  This
object is a list containing useful output of fuzzy forests.
In particular it contains a data.frame with list of selected features.
It also includes the random forest fit using the selected features.
}
\description{
Fits fuzzy forest algorithm using WGCNA.  Returns
fuzzy forest object.
}
\note{
This work was partially funded by NSF IIS 1251151.
}
\examples{
library(WGCNA)
library(randomForest)
library(fuzzyforest)
data(ctg)
y <- ctg$NSP
X <- ctg[, 2:22]
WGCNA_params <- WGCNA_control(p = 6, minModuleSize = 1, nThreads = 1)
mtry_factor <- 1; min_ntree <- 500;  drop_fraction <- .5; ntree_factor <- 1
screen_params <- screen_control(drop_fraction = drop_fraction,
                                keep_fraction = .25, min_ntree = min_ntree,
                                ntree_factor = ntree_factor,
                                mtry_factor = mtry_factor)
select_params <- select_control(drop_fraction = drop_fraction,
                                number_selected = 5,
                                min_ntree = min_ntree,
                                ntree_factor = ntree_factor,
                                mtry_factor = mtry_factor)
\donttest{
wff_fit <- wff(X, y, WGCNA_params = WGCNA_params,
                screen_params = screen_params,
                select_params = select_params,
                final_ntree = 500)

#extract variable importance rankings
vims <- wff_fit$feature_list

#plot results
modplot(wff_fit)
}
}
\references{
Leo Breiman (2001). Random Forests. Machine Learning, 45(1), 5-32.

Daniel Conn, Tuck Ngun, Christina M. Ramirez (2015). Fuzzy Forests: a New
WGCNA Based Random Forest Algorithm for Correlated, High-Dimensional Data,
Journal of Statistical Software, Manuscript in progress.

Bin Zhang and Steve Horvath (2005) "A General Framework for Weighted Gene
Co-Expression Network Analysis", Statistical Applications in Genetics and
Molecular Biology: Vol. 4: No. 1, Article 17
}

