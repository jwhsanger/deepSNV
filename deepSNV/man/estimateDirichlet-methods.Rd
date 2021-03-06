\docType{methods}
\name{estimateDirichlet}
\alias{estimateDirichlet}
\alias{estimateDirichlet,deepSNV-method}
\alias{estimateDirichlet,matrix-method}
\title{Learn a base-specific Dirichlet prior.}
\arguments{
  \item{control}{Either a matrix with nucleotide counts or
  a \code{\link{deepSNV-class}} object.}
}
\value{
  An \code{\link{deepSNV-class}} object.
}
\description{
  The prior learns the parameters of a Dirichlet
  distribution seperately for each consensus base. The
  expected value of the Dirichlet distributions is the
  base-substitution matrix, where rows correspond to the
  initial nucleotide and columns to the substituted
  nucleotide. The absolute values determine the higher
  moments of the Dirichlet distributions. After having
  learned the prior the \code{\link{deepSNV-class}} test is
  recomputed.
}
\examples{
data(phiX)
estimateDirichlet(phiX)
}
\author{
  Moritz Gerstung
}

