\docType{methods}
\name{deepSNV}
\alias{deepSNV}
\alias{deepSNV,character,character-method}
\alias{deepSNV,character,matrix-method}
\alias{deepSNV,deepSNV,missing-method}
\alias{deepSNV,matrix,character-method}
\alias{deepSNV,matrix,matrix-method}
\title{Test two matched deep sequencing experiments for low-frequency SNVs.}
\arguments{
  \item{test}{The test experiment. Either a .bam file, or a
  matrix with nucleotide counts, or a
  \code{\link{deepSNV-class}} object.}

  \item{control}{The control experiment. Must be of the
  same type as test, or missing if test is a
  \code{\link{deepSNV-class}} object.}

  \item{alternative}{The alternative to be tested. One of
  greater, less, or two.sided.}

  \item{model}{Which model to use. Either "bin", or
  "betabin". Default "bin".}

  \item{dirichlet.prior}{A base-sepecific Dirichlet prior
  specified as a matrix. Default NULL.}

  \item{pseudo.count}{If dirichlet.prior=NULL, a
  pseudocount can be used to define a flat prior.}

  \item{over.dispersion}{A numeric factor for the
  over.dispersion, if the model is beta-binomial. Default
  100.}

  \item{combine.method}{The method to combine p-values. One
  of "fisher" (default), "max", or "average". See
  \code{\link{p.combine}} for details.}

  \item{regions}{The regions to be parsed if test and
  control are .bam files. Either a \code{\link{data.frame}}
  with columns "chr" (chromosome), "start", "stop", or a
  \code{\link{GRanges}} object. If multiple regions are
  specified, the appropriate slots of the returned object
  are concatenated by row.}

  \item{q}{The quality arguement passed to
  \code{\link{bam2R}} if the experiments are .bam files.}

  \item{s}{The strand argument passed to
  \code{\link{bam2R}} if the experiments are .bam files.}

  \item{head.clip}{The head.clip argument passed to
  \code{\link{bam2R}} if the experiments are .bam files.}

  \item{...}{Additional arguments.}
}
\value{
  A \code{\linkS4class{deepSNV}} object
}
\description{
  This generic function can handle different types of
  inputs for the test and control experiments. It either
  reads from two .bam files, uses two matrices of
  nucleotide counts, or re-evaluates the test results from
  a \code{\link{deepSNV-class}} object. The actual test is
  a likelihood ratio test of a (beta-)binomial model for
  the individual nucleotide counts on each position under
  the hypothesis that both experiments share the same
  parameter, and the alternative that the parameters
  differ. Because the difference in degrees of freedom is
  1, the test statistic \eqn{D = -2 \log
  \max{L_0}/\max{L_1}} is asymptotically distributed as
  \eqn{\chi_1^2}. The statistic may be tuned by a
  nucleotide specific Dirichlet prior that is learned
  across all genomic sites, see
  \code{\link{estimateDirichlet}}. If the model is
  beta-binomial, a global dispersion parameter is used for
  all sites. It can be learned with
  \code{\link{estimateDispersion}}.
}
\examples{
## Short example with 2 SNVs at frequency ~10\%
regions <- data.frame(chr="B.FR.83.HXB2_LAI_IIIB_BRU_K034", start = 3120, stop=3140)
ex <- deepSNV(test = system.file("extdata", "test.bam", package="deepSNV"), control = system.file("extdata", "control.bam", package="deepSNV"), regions=regions, q=10)
show(ex)   # show method
plot(ex)   # scatter plot
summary(ex)   # summary with significant SNVs
ex[1:3,]   # subsetting the first three genomic positions
tail(test(ex, total=TRUE))   # retrieve the test counts on both strands
tail(control(ex, total=TRUE))

## Not run: Full example with ~ 100 SNVs. Requires an internet connection, but try yourself.
# regions <- data.frame(chr="B.FR.83.HXB2_LAI_IIIB_BRU_K034", start = 2074, stop=3585)
# HIVmix <- deepSNV(test = "http://www.bsse.ethz.ch/cbg/software/deepSNV/data/test.bam", control = "http://www.bsse.ethz.ch/cbg/software/deepSNV/data/control.bam", regions=regions, q=10)
data(HIVmix) # attach data instead..
show(HIVmix)
plot(HIVmix)
head(summary(HIVmix))

}
\author{
  Moritz Gerstung
}

