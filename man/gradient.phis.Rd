% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/gradient_phi.R
\name{gradient.phis}
\alias{gradient.phis}
\title{Gradient of phi}
\usage{
gradient.phis(alphas, xis, sigmas, phis, R, fi, fj, mi, mj, mval)
}
\arguments{
\item{alphas}{Current value of alpha}

\item{xis}{Current value of xi (log transformed)}

\item{sigmas}{Current value of sigma^2 (log transformed)}

\item{phis}{Current value of phi (log transformed)}

\item{R}{Distance}

\item{fi}{exp(beta^T z(u))}

\item{fj}{exp(beta^T z(v))}

\item{mi}{mark of u}

\item{mj}{mark of v}

\item{mval}{all marks}
}
\value{
Gradient of phi
}
\description{
Gradient of phi
}
