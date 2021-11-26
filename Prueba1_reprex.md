This template demonstrates many of the bells and whistles of the `reprex::reprex_document()` output format. The YAML sets many options to non-default values, such as using `#;-)` as the comment in front of output.

## Code style

Since `style` is `TRUE`, this difficult-to-read code (look at the `.Rmd` source file) will be restyled according to the Tidyverse style guide when it’s rendered. Whitespace rationing is not in effect!

``` r
x <- 1
y <- 2
z <- x + y
z
#;-) [1] 3
```

## Quiet tidyverse

The tidyverse meta-package is quite chatty at startup, which can be very useful in exploratory, interactive work. It is often less useful in a reprex, so by default, we suppress this.

However, when `tidyverse_quiet` is `FALSE`, the rendered result will include a tidyverse startup message about package versions and function masking.

``` r
library(tidyverse)
#;-) -- Attaching packages --------------------------------------- tidyverse 1.3.1 --
#;-) v ggplot2 3.3.5     v purrr   0.3.4
#;-) v tibble  3.1.5     v dplyr   1.0.7
#;-) v tidyr   1.1.4     v stringr 1.4.0
#;-) v readr   2.0.2     v forcats 0.5.1
#;-) -- Conflicts ------------------------------------------ tidyverse_conflicts() --
#;-) x dplyr::filter() masks stats::filter()
#;-) x dplyr::lag()    masks stats::lag()
```

## Chunks in languages other than R

Remember: knitr supports many other languages than R, so you can reprex bits of code in Python, Ruby, Julia, C++, SQL, and more. Note that, in many cases, this still requires that you have the relevant external interpreter installed.

Let’s try Python!

``` python
x = 'hello, python world!'
print(x.split(' '))
#;-) ['hello,', 'python', 'world!']
```

And bash!

``` bash
echo "Hello Bash!";
pwd;
ls | head;
#;-) Hello Bash!
#;-) /c/Users/jgeis/Documents/Claudia/Cursos/Impartidos/EDconRMarkdown/Github
#;-) Github.Rproj
#;-) Prueba1.Rmd
#;-) Prueba1_reprex.Rmd
#;-) Prueba1_reprex_std_out_err.txt
#;-) README.md
```

Write a function in C++, use Rcpp to wrap it and …

``` cpp
#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::export]]
NumericVector timesTwo(NumericVector x) {
  return x * 2;
}
```

then immediately call your C++ function from R!

``` r
timesTwo(1:4)
#;-) [1] 2 4 6 8
```

## Standard output and error

Some output that you see in an interactive session is not actually captured by rmarkdown, when that same code is executed in the context of an `.Rmd` document. When `std_out_err` is `TRUE`, `reprex::reprex_render()` uses a feature of `callr:r()` to capture such output and then injects it into the rendered result.

Look for this output in a special section of the rendered document (and notice that it does not appear right here).

``` r
system2("echo", args = "Output that would normally be lost")
```

## Session info

Because `session_info` is `TRUE`, the rendered result includes session info, even though no such code is included here in the source document.

<details style="margin-bottom:10px;">
<summary>
Standard output and standard error
</summary>

``` sh
running: bash  -c "echo \"Hello Bash!\";
pwd;
ls | head;"
Building shared library for Rcpp code chunk...
Output that would normally be lost
```

</details>
<details style="margin-bottom:10px;">
<summary>
Session info
</summary>

``` r
sessioninfo::session_info()
#;-) - Session info ---------------------------------------------------------------
#;-)  setting  value                       
#;-)  version  R version 4.0.5 (2021-03-31)
#;-)  os       Windows 10 x64              
#;-)  system   x86_64, mingw32             
#;-)  ui       RTerm                       
#;-)  language (EN)                        
#;-)  collate  Spanish_Mexico.1252         
#;-)  ctype    Spanish_Mexico.1252         
#;-)  tz       America/Mexico_City         
#;-)  date     2021-11-25                  
#;-) 
#;-) - Packages -------------------------------------------------------------------
#;-)  package     * version date       lib source        
#;-)  assertthat    0.2.1   2019-03-21 [1] CRAN (R 4.0.5)
#;-)  backports     1.2.1   2020-12-09 [1] CRAN (R 4.0.3)
#;-)  broom         0.7.9   2021-07-27 [1] CRAN (R 4.0.5)
#;-)  cellranger    1.1.0   2016-07-27 [1] CRAN (R 4.0.5)
#;-)  cli           3.0.1   2021-07-17 [1] CRAN (R 4.0.5)
#;-)  colorspace    2.0-2   2021-06-24 [1] CRAN (R 4.0.5)
#;-)  crayon        1.4.1   2021-02-08 [1] CRAN (R 4.0.5)
#;-)  DBI           1.1.1   2021-01-15 [1] CRAN (R 4.0.5)
#;-)  dbplyr        2.1.1   2021-04-06 [1] CRAN (R 4.0.5)
#;-)  digest        0.6.28  2021-09-23 [1] CRAN (R 4.0.5)
#;-)  dplyr       * 1.0.7   2021-06-18 [1] CRAN (R 4.0.5)
#;-)  ellipsis      0.3.2   2021-04-29 [1] CRAN (R 4.0.5)
#;-)  evaluate      0.14    2019-05-28 [1] CRAN (R 4.0.5)
#;-)  fansi         0.5.0   2021-05-25 [1] CRAN (R 4.0.5)
#;-)  fastmap       1.1.0   2021-01-25 [1] CRAN (R 4.0.5)
#;-)  forcats     * 0.5.1   2021-01-27 [1] CRAN (R 4.0.5)
#;-)  fs            1.5.0   2020-07-31 [1] CRAN (R 4.0.5)
#;-)  generics      0.1.0   2020-10-31 [1] CRAN (R 4.0.5)
#;-)  ggplot2     * 3.3.5   2021-06-25 [1] CRAN (R 4.0.5)
#;-)  glue          1.4.2   2020-08-27 [1] CRAN (R 4.0.5)
#;-)  gtable        0.3.0   2019-03-25 [1] CRAN (R 4.0.5)
#;-)  haven         2.4.3   2021-08-04 [1] CRAN (R 4.0.5)
#;-)  here          1.0.1   2020-12-13 [1] CRAN (R 4.0.5)
#;-)  hms           1.1.1   2021-09-26 [1] CRAN (R 4.0.5)
#;-)  htmltools     0.5.2   2021-08-25 [1] CRAN (R 4.0.5)
#;-)  httr          1.4.2   2020-07-20 [1] CRAN (R 4.0.5)
#;-)  jsonlite      1.7.2   2020-12-09 [1] CRAN (R 4.0.5)
#;-)  knitr         1.36    2021-09-29 [1] CRAN (R 4.0.5)
#;-)  lattice       0.20-45 2021-09-22 [1] CRAN (R 4.0.5)
#;-)  lifecycle     1.0.1   2021-09-24 [1] CRAN (R 4.0.5)
#;-)  lubridate     1.7.10  2021-02-26 [1] CRAN (R 4.0.5)
#;-)  magrittr      2.0.1   2020-11-17 [1] CRAN (R 4.0.5)
#;-)  Matrix        1.3-4   2021-06-01 [1] CRAN (R 4.0.5)
#;-)  modelr        0.1.8   2020-05-19 [1] CRAN (R 4.0.5)
#;-)  munsell       0.5.0   2018-06-12 [1] CRAN (R 4.0.5)
#;-)  pillar        1.6.3   2021-09-26 [1] CRAN (R 4.0.5)
#;-)  pkgconfig     2.0.3   2019-09-22 [1] CRAN (R 4.0.5)
#;-)  png           0.1-7   2013-12-03 [1] CRAN (R 4.0.3)
#;-)  purrr       * 0.3.4   2020-04-17 [1] CRAN (R 4.0.5)
#;-)  R.cache       0.15.0  2021-04-30 [1] CRAN (R 4.0.5)
#;-)  R.methodsS3   1.8.1   2020-08-26 [1] CRAN (R 4.0.3)
#;-)  R.oo          1.24.0  2020-08-26 [1] CRAN (R 4.0.3)
#;-)  R.utils       2.11.0  2021-09-26 [1] CRAN (R 4.0.5)
#;-)  R6            2.5.1   2021-08-19 [1] CRAN (R 4.0.5)
#;-)  rappdirs      0.3.3   2021-01-31 [1] CRAN (R 4.0.5)
#;-)  Rcpp          1.0.7   2021-07-07 [1] CRAN (R 4.0.5)
#;-)  readr       * 2.0.2   2021-09-27 [1] CRAN (R 4.0.5)
#;-)  readxl        1.3.1   2019-03-13 [1] CRAN (R 4.0.5)
#;-)  reprex        2.0.1   2021-08-05 [1] CRAN (R 4.0.5)
#;-)  reticulate    1.22    2021-09-17 [1] CRAN (R 4.0.5)
#;-)  rlang         0.4.11  2021-04-30 [1] CRAN (R 4.0.5)
#;-)  rmarkdown     2.11    2021-09-14 [1] CRAN (R 4.0.5)
#;-)  rprojroot     2.0.2   2020-11-15 [1] CRAN (R 4.0.5)
#;-)  rstudioapi    0.13    2020-11-12 [1] CRAN (R 4.0.5)
#;-)  rvest         1.0.1   2021-07-26 [1] CRAN (R 4.0.5)
#;-)  scales        1.1.1   2020-05-11 [1] CRAN (R 4.0.5)
#;-)  sessioninfo   1.1.1   2018-11-05 [1] CRAN (R 4.0.5)
#;-)  stringi       1.7.5   2021-10-04 [1] CRAN (R 4.0.5)
#;-)  stringr     * 1.4.0   2019-02-10 [1] CRAN (R 4.0.5)
#;-)  styler        1.6.2   2021-09-23 [1] CRAN (R 4.0.5)
#;-)  tibble      * 3.1.5   2021-09-30 [1] CRAN (R 4.0.5)
#;-)  tidyr       * 1.1.4   2021-09-27 [1] CRAN (R 4.0.5)
#;-)  tidyselect    1.1.1   2021-04-30 [1] CRAN (R 4.0.5)
#;-)  tidyverse   * 1.3.1   2021-04-15 [1] CRAN (R 4.0.5)
#;-)  tzdb          0.1.2   2021-07-20 [1] CRAN (R 4.0.5)
#;-)  utf8          1.2.2   2021-07-24 [1] CRAN (R 4.0.5)
#;-)  vctrs         0.3.8   2021-04-29 [1] CRAN (R 4.0.5)
#;-)  withr         2.4.2   2021-04-18 [1] CRAN (R 4.0.5)
#;-)  xfun          0.26    2021-09-14 [1] CRAN (R 4.0.5)
#;-)  xml2          1.3.2   2020-04-23 [1] CRAN (R 4.0.5)
#;-)  yaml          2.2.1   2020-02-01 [1] CRAN (R 4.0.5)
#;-) 
#;-) [1] C:/Users/jgeis/Documents/R/win-library/4.0
#;-) [2] C:/Program Files/R/R-4.0.5/library
```

</details>
