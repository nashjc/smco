\name{smco}
\alias{smco}
\alias{smco.default}
\Rdversion{1.1}
\author{
	Prof. Juan D. Velasquez, Ph.D.\cr
	Grupo de Computacion Aplicada\cr
	Univesidad Nacional de Colombia\cr
	jdvelasq@unal.edu.co\cr
}
\keyword{ optimize }

\seealso{\code{\link[stats]{optim}}}

\title{simple Monte Carlo optimizer using adaptive coordinate sampling}

\description{
The function \code{smco} is use to optimize non-linear 
complex functions based on three simple ideas: first, the 
sampling of each component of the solution vector, one at a time, 
based on a truncated normal distribution; second, the evolution 
of the standard deviation of the sampling distribution in each iteration, 
as a mechanism of self-adaptation; and third, 
the restart of the algorithm for escaping of local optima.
}

\usage{
    smco(par = NULL, fn, gr = NULL, ..., N = length(par), 
        LB, UB, maxiter = 1000, Co = 0.01, Cmin = 0.0001, 
        Cmax = 0.5, trc = FALSE, lambda = 20, useBFGS = FALSE, 
        control = list(), hessian = FALSE)
}

\arguments{

  \item{par}{Initial values for the parameters to be optimized over. When it is 'NULL'
          the user must be specify the value for the 'N' parameter and the algorithm
          it is initializated in a random point.}
  
  \item{fn}{A function to be minimized (or maximized), with first
          argument the vector of parameters over which minimization is
          to take place.  It should return a scalar result.}
  
  \item{gr}{A function to return the gradient for the '"L-BFGS-B"' method when
          the option \code{trc} is set to TRUE.  If it is 'NULL', a
          finite-difference approximation will be used.}
  
  \item{...}{Further arguments to be passed to 'fn' and 'gr'.}
  
  \item{N}{The number of dimensions of the vector of solution variables}
  
  \item{LB, UB}{Lower and upper bounds on the variables.}
  
  \item{maxiter}{The maximum number of iterations. The number of function calls to 
            '"L-BFGS-B"' implementation is not taking into count. }
  
  \item{Co, Cmin, Cmax}{Initial, minimum and maximum values for the 
          standard deviation of the truncated normal distribution}
  
  \item{trc}{Logical. When it is 'TRUE' the progress of the optimization algorithm
          is reported.}
  
  \item{lambda}{Restarting parameter. When the algorithm reaches 'lambda' * 'N'  iterations
          without found a new local optimum the restart ocurrs.}
  
  \item{useBFGS}{Logical. When it value is 'TRUE', first, a new random 
          value for the current coordinate is generated using a truncated 
          normal distribution; second, the one-dimensional optimization of 
          the value of the current coordinate is made using the 
          '"L-BFGS-B"' method implemented in the \code{optim} function}
  
  \item{control}{A list of control parameters for the '"L-BFGS-B"' implemented 
          in the \code{optim} function.}
  
  \item{hessian}{A control parameter for the '"L-BFGS-B"' implemented 
          in the \code{optim} function.}
  
}

\details{
The algorithm tries to improve the current solution by changing the 
i-th coordinate by a random value generated using a truncated normal 
distribution. Only a random value for each coordinate is generated 
each time. When the parameter 'useBFGS' is 'TRUE', the new random 
value is used as the initial point for the one-dimensional 
optimization of the i-th coordinate using '"L-BFGS-B"' method 
implemented in the \code{optim} function. \cr\cr

The standard deviation of the truncated random deviation changes in 
each iteration in a random way. The values of the standard deviation 
are bounded to the interval defined by 'Cmin' and 'Cmax'. \cr\cr

When the algorithm reaches 'lambda' * 'N'  iterations  without found 
a new local optimum the restart ocurrs. For this, a new random 
current solution is generated. \cr\cr

}


\references{
    Velasquez, J. D. (2011). \emph{A Simple Monte Carlo optimizer based on 
    Adaptive Coordinate Sampling}. Submitted to Operation Research Letters.
}
	
\value{
A list with components:

    \item{par}{The best set of parameters found.}
    
    \item{value}{The value of 'fn' corresponding to 'par'.}
    
    \item{f.opt, f.min, f.curr}{Vectors of size 'maxiter' containing the values 
        of the global optimum, local optimum  and current value of the function 'fn' 
        for the current iteration.}
    
    \item{call}{The call to the function.}

}


%% \note{
%%  ~~further notes~~
%% }



%% \seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
%% }

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
