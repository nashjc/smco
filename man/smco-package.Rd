\name{smco-package}
\alias{smco-package}

\docType{package}
\Rdversion{0.1}
\author{
	Prof. Juan D. Velasquez, Ph.D.\cr
	Grupo de Computacion Aplicada\cr
	Univesidad Nacional de Colombia\cr
	jdvelasq@unal.edu.co\cr
}

\title{A simple Monte Carlo optimizer using adaptive coordinate sampling}

\description{
This package introduces a novel approach to optimize non-linear 
complex functions based on three simple ideas: first, the 
thus sampling of each component of the solution vector, one at a time, 
based on a truncated normal distribution; second, the evolution 
of the standard deviation of the sampling distribution in each iteration, 
as a mechanism of self-adaptation; and third, 
the restart of the algorithm for escaping of local optima.  
}

\details{
    \tabular{ll}{
        Package: \tab smco\cr
        Type: \tab Package\cr
        Version: \tab 1.0\cr
        Date: \tab 2011-06-05\cr
        License: \tab GPL (>= 2)\cr
        LazyLoad: \tab yes\cr
    }
    Unique function:
	\tabular{ll}{
		smco():          \tab Simple Monte Carlo optimizer\cr
	}
}

\references{
    Velasquez, J. D. (2011). \emph{A Simple Monte Carlo optimizer based on 
    Adaptive Coordinate Sampling}. Submitted to Operation Research Letters.
}

\keyword{ package }
\keyword{ optimize }


\examples{
SphereModel.fcn <-
function( x ) {
  return(sum(x ^ 2))
}

f = SphereModel.fcn;    
ndim = 10; 
LB = rep( -600.000, ndim); 
UB = rep(  600.000, ndim); 
maxiter = 100; 

s = smco(par = NULL, fn = SphereModel.fcn, N = ndim, LB = LB,
    UB = UB, maxiter = maxiter, Co = 0.01, Cmin = 0.0001, 
    Cmax = 0.5, trc = TRUE, lambda = 20,
    useBFGS = TRUE, control = list(maxit = 10))
}
