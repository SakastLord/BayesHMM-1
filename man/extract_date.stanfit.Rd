% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fit.R
\name{extract_date.stanfit}
\alias{extract_date.stanfit}
\title{Extract the date when the model was run.}
\usage{
\method{extract_date}{stanfit}(fit)
}
\arguments{
\item{fit}{An object returned by either \code{\link{draw_samples}} or \code{\link{optimizing}}.}
}
\value{
An integer with the date used to fit the model.
}
\description{
Extract the date when the model was run.
}
\keyword{internal}
