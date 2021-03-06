#' @title Gradient of phi
#' @description Gradient of phi
#' @param alphas Current value of alpha
#' @param xis Current value of xi (log transformed)
#' @param sigmas Current value of sigma^2 (log transformed)
#' @param phis Current value of phi (log transformed)
#' @param R Distance
#' @param fi exp(beta^T z(u))
#' @param fj exp(beta^T z(v))
#' @param mi mark of u
#' @param mj mark of v
#' @param mval all marks
#' @return Gradient of phi
#' @export


gradient.phis <- function(alphas,xis,sigmas,phis,R,fi,fj,mi,mj,mval){
  p=length(mval)
  if(!is.matrix(alphas)){alphas=matrix(alphas,nrow=p)}
  q = dim(alphas)[2]
  #return(alphas)
  k0=0
  Ptmp <- matrix(NA,length(R),p^2)
  for(i in 1:p){
    for(j in 1:p){
      k0 = k0 + 1
      tmp1 <- 0
      for(l in 1:q){tmp1 <- tmp1+alphas[i,l]*alphas[j,l]*exp(-R/exp(xis[l]))}
      if(i==j){Ptmp[,k0] <-  fi[,i]*fj[,j]*exp(tmp1+exp(sigmas[j])*exp(-R/exp(phis[j])))}
      else{Ptmp[,k0] <-  fi[,i]*fj[,j]*exp(tmp1)}
    }
  }
  aggPtmp <- rowSums(Ptmp)

  ptmp_grad <- ptmp_grad2 <- numeric(p)
  k0 = 0
  for(k1 in 1:p){
    for(k2 in 1:p){
      k0 = k0 +1
      R_sub  = R[(mi==mval[k1])&(mj==mval[k2])]
      if(k1==k2){
        tmp3=Ptmp[,k0]*exp(-R/exp(phis[k1]))
        ptmp_grad[k1] <-ptmp_grad[k1]+ sum(exp(-R_sub/exp(phis[k1]))*exp(sigmas[k1])*(R_sub/exp(phis[k1])^2))
        ptmp_grad2[k1] <- ptmp_grad2[k1] + sum(tmp3*exp(sigmas[k1])*(R/exp(phis[k1])^2)/aggPtmp)
      }
    }
  }
  grad <- ptmp_grad-ptmp_grad2
  -grad
}
