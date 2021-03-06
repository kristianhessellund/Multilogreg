% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/MultiLGCP.R
\name{sim_lgcp_multi}
\alias{sim_lgcp_multi}
\title{Simulation of semi-parametric multivariate log Gaussian Cox processes}
\usage{
sim_lgcp_multi(
  basecov,
  covariate,
  betas,
  alphas,
  xis,
  sigmas,
  phis,
  n.window,
  n.points,
  beta0s = NULL
)
}
\arguments{
\item{basecov}{Background intensity rho_0.}

\item{covariate}{Optional. A simulated covariate. The covariate must be a matrix.}

\item{betas}{A matrix with covariates.}

\item{alphas}{Alpha parameters. Must be a matrix, where the number of rows correspond
to the number of components in the LGCP. The number of columns correspond to the number
of common latent field.}

\item{xis}{Correlation scale parameters for each common random field. The correlation functions
for the common latent fields are exponential.}

\item{sigmas}{Sigma parameters. The number of sigma parameters must correspond
to the number of components in the LGCP.}

\item{phis}{Correlation scale parameters for each type-specific random field. The correlation functions
for the type-specific random fields are exponential.}

\item{n.window}{window size.}

\item{n.points}{Expected number of point for each component in the LGCP.
The length of n.points must correspond to the number of components.}

\item{beta0s}{Intercepts. The length of beta0s must correspond to the number of components
in the LGCP.}
}
\value{
Multivariate LGCP
}
\description{
Simulation of semi-parametric multivariate log Gaussian Cox processes.
}
\examples{
# Size of the observation window
n.x <- n.y <- 1
xx=seq(0,n.x,length=100)
yy=seq(0,n.x,length=100)

# Simulating a covariate
cov <- as.matrix(RFsimulate(RMexp(var=1,scale=0.05), x=xx, y=yy, grid=TRUE))

# Simulating the background intensity
gamma <- 0.5
background <- as.matrix(RFsimulate(RMgauss(var=1,scale=0.2), x=xx, y=yy, grid=TRUE))*gamma-gamma^2/2

#Set up parameters
beta1 <- c(0.1,0.2,0.3,0.4,0.5)
beta2 <- c(-0.1,-0.2,0,0.1,0.2)
beta2 <- as.matrix(beta2)

# Parameters in the LGCP

alpha <- matrix(c(0.5,-1,0.5,0,-1,0,0,0.5,0,0.5),nrow=5,byrow=TRUE)
xi    <- c(0.02,0.03)
sigma <- matrix(c(sqrt(0.5),sqrt(0.5),sqrt(0.5),sqrt(0.5),sqrt(0.5)),ncol=1)
phi   <- matrix(c(0.02,0.02,0.03,0.03,0.04),ncol=1)

n.window <- n.x
n.points <- c(400,400,400,400,400)

# Simulation of a multivariate LGCP
X <- sim_lgcp_multi(basecov=background,covariate=cov,betas=beta2,alphas=alpha,xi=xi,
sigma=sigma,phis=phi, n.window=n.window,n.points=n.points,beta0s=beta1)

plot(X$markedprocess)

}
\references{
Hessellund, K. B., Xu, G., Guan, Y. and Waagepetersen, R. (2020)
Second order semi-parametric inference for multivariate log Gaussian Cox processes.
}
\author{
Kristian Bjørn Hessellund, Ganggang Xu, Yongtao Guan and Rasmus Waagepetersen.
}
