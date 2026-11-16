# Score the Michigan Vision-related Anxiety Questionnaire

Score the Michigan Vision-related Anxiety Questionnaire

## Usage

``` r
scoreMVAQ(dat, verbose = 0)
```

## Arguments

- dat:

  data.frame with N rows and 15 columns. First column is patient ID and
  the remaining columns are responses to the 14 items. Responses should
  be integers from 0 to 4.

- verbose:

  A number indicating the amount of printing to console during function
  execution. 0 (default) is none. Higher numbers may result in more
  printing.

## Value

A list with two components, each a data.frame with 3 variables: ID, ARF,
and ACF. The first component, named thetas, contains the IDs (column 1
of of the input), and the 2 domain scores (ARF, ACF) for each patient.
The second, named ses, contains the IDs and the standard errors of the
thetas.

## Examples

``` r
justme <- read.table(
  text = "Me,0,0,0,0,0,0,0,0,1,1,1,0,0,1",
  sep = ",")
scoreMVAQ(justme)
#> $thetas
#>   ID       ARF        ACF
#> 1 Me -0.168155 -0.8727335
#> 
#> $ses
#>   ID      ARF      ACF
#> 1 Me 0.117081 0.494362
#> 

justyou <- data.frame(ID="You", matrix(nrow=1, sample(0:3, 14, TRUE)))
scoreMVAQ(justyou)
#> $thetas
#>    ID       ARF     ACF
#> 1 You 0.4144947 0.71556
#> 
#> $ses
#>    ID      ARF       ACF
#> 1 You 0.152703 0.3146975
#> 

names(justme) <- names(justyou) <- c("ID", sprintf("Q%0.2d", seq(14)))
justus <- rbind(justme, justyou)
scoreMVAQ(justus, verbose = 1)
#> i =  1 
#> i =  2 
#> $thetas
#>    ID        ARF        ACF
#> 1  Me -0.1681550 -0.8727335
#> 2 You  0.4144947  0.7155600
#> 
#> $ses
#>    ID      ARF       ACF
#> 1  Me 0.117081 0.4943620
#> 2 You 0.152703 0.3146975
#> 
```
