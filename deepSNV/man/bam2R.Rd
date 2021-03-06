\name{bam2R}
\alias{bam2R}
\title{Read nucleotide counts from a .bam file}
\usage{
  bam2R(file, chr, start, stop, q = 25, s = 2,
    head.clip = 0, max.depth = 1e+06, verbose = FALSE)
}
\arguments{
  \item{file}{The name of the .bam file as a string.}

  \item{chr}{The chromosome as a string.}

  \item{start}{The start position (1-indexed).}

  \item{stop}{The end position (1-indexed).}

  \item{q}{An optional cutoff for the nucleotide Phred
  quality. Default q = 25. Nucleotides with Q < q will be
  masked by 'N'.}

  \item{s}{Optional choice of the strand. Defaults to s = 2
  (both).}

  \item{head.clip}{Should n nucleotides from the head of
  reads be clipped? Default 0.}

  \item{max.depth}{The maximal depth for the pileup
  command. Default 1,000,000.}

  \item{verbose}{Boolean. Set to TRUE if you want to get
  additional output.}
}
\value{
  A named \code{\link{matrix}} with rows corresponding to
  genomic positions and columns for the nucleotide counts
  (A, T, C, G, -), masked nucleotides (N), (INS)ertions,
  (DEL)etions, (HEAD)s and (TAIL)s that count how often a
  read begins and ends at the given position, respectively,
  and the sum of alignment (QUAL)ities, which can be
  indicative of alignment problems. Counts from matches on
  the reference strand (s=0) are uppercase, counts on the
  complement (s=1) are lowercase. The returned matrix has
  11 * 2 (strands) = 22 columns and (stop - start + 1)
  rows.
}
\description{
  This function uses a C interface to read the nucleotide
  counts on each position of a .bam alignment. The counts
  of both strands are reported separately and nucleotides
  below a quality cutoff are masked. It is called by
  \code{\link{deepSNV}} to parse the alignments of the test
  and control experiments, respectively.
}
\examples{
## Simple example:
counts <- bam2R(file = system.file("extdata", "test.bam", package="deepSNV"), chr="B.FR.83.HXB2_LAI_IIIB_BRU_K034", start = 3120, stop=3140, q = 10)
show(counts)
## Not run: Requires an internet connection, but try yourself.
# bam <- bam2R(file = "http://www.bsse.ethz.ch/cbg/software/deepSNV/data/test.bam", chr="B.FR.83.HXB2_LAI_IIIB_BRU_K034", start = 2074, stop=3585, q=10)
# head(bam)
}
\author{
  Moritz Gerstung
}

