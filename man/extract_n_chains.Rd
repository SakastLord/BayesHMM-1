% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/stanfit.R
\name{extract_n_chains}
\alias{extract_n_chains}
\title{Extract the number of chains \emph{M}.}
\usage{
extract_n_chains(stanfit)
}
\arguments{
\item{stanfit}{An object returned by either \code{\link{fit}} or \code{\link{draw_samples}}.}
}
\value{
The number of chains \emph{M} used to fit the model.
}
\description{
Extract the number of chains \emph{M}.
}
