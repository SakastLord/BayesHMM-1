#' Gamma density (univariate, continuous, bounded space)
#'
#' @inherit Density
#' @param alpha Either a fixed value or a prior density for the shape parameter.
#' @param beta  Either a fixed value or a prior density for the inverse scale parameter.
#'
#' @family Density
#' @export
#'
#' @examples
#' # With fixed values for the parameters
#' Gamma(1, 1)
#'
#' # With priors for the parameters
#' Gamma(
#'   alpha = Exponential(1), beta = Exponential(1)
#' )
Gamma <- function(alpha = NULL, beta = NULL, bounds = list(NULL, NULL),
                 trunc = list(NULL, NULL), k = NULL, r = NULL, param = NULL) {
  Density("Gamma", bounds, trunc, k, r, param, alpha = alpha, beta = beta)
}

freeParameters.Gamma <- function(x) {
  alphaStr <-
    if (is.Density(x$alpha)) {
      alphaBoundsStr <- make_bounds(x, "alpha")
      sprintf(
        "real%s alpha%s%s;",
        alphaBoundsStr, x$k, x$r
      )
    } else {
      ""
    }

  betaStr <-
    if (is.Density(x$beta)) {
      betaBoundsStr <- make_bounds(x, "beta")
      sprintf(
        "real%s beta%s%s;",
        betaBoundsStr, x$k, x$r
      )
    } else {
      ""
    }

  collapse(alphaStr, betaStr)
}

fixedParameters.Gamma <- function(x) {
  alphaStr <-
    if (is.Density(x$alpha)) {
      ""
    } else {
      if (!check_scalar(x$alpha)) {
        stop("If fixed, alpha must be a scalar.")
      }

      sprintf(
        "real alpha%s%s = %s;",
        x$k, x$r, x$alpha
      )
    }

  betaStr <-
    if (is.Density(x$beta)) {
      ""
    } else {
      if (!check_scalar(x$beta)) {
        stop("If fixed, beta must be a scalar.")
      }

      sprintf(
        "real beta%s%s = %s;",
        x$k, x$r, x$beta
      )
    }

  collapse(alphaStr, betaStr)
}

generated.Gamma <- function(x) {
  sprintf("if(zpred[t] == %s) ypred[t][%s] = gamma_rng(alpha%s%s, beta%s%s);", x$k, x$r, x$k, x$r, x$k, x$r)
}

getParameterNames.Gamma <- function(x) {
  return(c("alpha", "beta"))
}

logLike.Gamma <- function(x) {
  sprintf("loglike[%s][t] = gamma_lpdf(y[t] | alpha%s%s, beta%s%s);", x$k, x$k, x$r, x$k, x$r)
}

prior.Gamma <- function(x) {
  truncStr <- make_trunc(x, "")
  rStr     <- make_rsubindex(x)
  sprintf(
    "%s%s%s ~ gamma(%s, %s) %s;",
    x$param,
    x$k, rStr,
    x$alpha, x$beta,
    truncStr
  )
}