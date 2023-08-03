
<!-- README.md is generated from README.Rmd. Please edit that file -->

# scoreMVAQ

<!-- badges: start -->
<!-- badges: end -->

The goal of scoreMVAQ is to convert the 14 responses from the Michigan
Vision-related Anxiety Questionnaire (MVAQ) to two domain scores:
Anxiety due to Rod Function (ARF) and Anxiety due to Cone Function (ACF)

## Installation

You can install the development version of scoreMVAQ from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("chrisandrewsphd/scoreMVAQ")
```

## Examples

### Example 1

This is a basic example which shows you how to score data from a single
individual. `justme` is a data.frame with 15 variables and 1 row. The 15
variables are the patient identifier followed by their 14 responses.

``` r
library(scoreMVAQ)

justme <- read.table(
  text = "Me,0,0,0,0,0,0,0,0,1,1,1,0,0,1",
  sep = ",")
justme
#>   V1 V2 V3 V4 V5 V6 V7 V8 V9 V10 V11 V12 V13 V14 V15
#> 1 Me  0  0  0  0  0  0  0  0   1   1   1   0   0   1

scoreMVAQ(justme)
#> $thetas
#>   ID        ARF        ACF
#> 1 Me -0.1694411 -0.8727335
#> 
#> $ses
#>   ID       ARF      ACF
#> 1 Me 0.1146743 0.494362
```

### Example 2

If you need to score many respondents (or the same respondent at several
visits), you can include them all in a single data.frame and call
`scoreMVAQ()`. The data.frame must have 15 columns still but can have
more than 1 row.

``` r
library(scoreMVAQ)

justme <- read.table(
  text = "Me,0,0,0,0,0,0,0,0,1,1,1,0,0,1",
  sep = ",")
justyou <- data.frame(ID="You", matrix(nrow=1, sample(0:3, 14, TRUE)))
andyoutoo <- data.frame(ID="You 2", matrix(nrow=1, sample(0:3, 14, TRUE)))

names(justme) <- names(justyou) <- names(andyoutoo) <- 
  c("ID", sprintf("Q%0.2d", seq(14)))

justus <- rbind(justme, justyou, andyoutoo)
justus
#>      ID Q01 Q02 Q03 Q04 Q05 Q06 Q07 Q08 Q09 Q10 Q11 Q12 Q13 Q14
#> 1    Me   0   0   0   0   0   0   0   0   1   1   1   0   0   1
#> 2   You   0   1   0   1   3   1   2   2   0   3   2   0   2   3
#> 3 You 2   1   2   3   0   3   2   0   3   3   1   3   1   1   2

scoreMVAQ(justus, verbose = 1)
#> i =  1 
#> i =  2 
#> i =  3
#> $thetas
#>      ID        ARF        ACF
#> 1    Me -0.1694411 -0.8727335
#> 2   You  0.2389201  0.5564517
#> 3 You 2  0.3898790  1.0787744
#> 
#> $ses
#>      ID       ARF       ACF
#> 1    Me 0.1146743 0.4943620
#> 2   You 0.1741195 0.2907901
#> 3 You 2 0.1581833 0.3232279
```

The option `verbose = 1` provides some messaging during the execution of
`scoreMVAQ()`.
