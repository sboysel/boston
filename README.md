<!-- README.md is generated from README.Rmd. Please edit that file -->
boston
======

[![Travis-CI Build Status](https://travis-ci.org/sboysel/boston.svg?branch=master)](https://travis-ci.org/sboysel/boston) <a rel="license" href="http://creativecommons.org/publicdomain/zero/1.0/"> <img src="https://licensebuttons.net/p/zero/1.0/80x15.png" style="border-style: none;" alt="CC0" /> </a>

Spatial data for election wards and precincts for the City of Boston, packaged for `R`. See [here](https://www.cityofboston.gov/maps/pdfs/ward_and_precincts.pdf) for reference. Source data prepared by Dan O’Brien (2015).

Usage
-----

``` r
# devtools::install_packages("sboysel/boston")
library(boston)
plot(precincts)
plot(wards, border = "red", add = TRUE)
```

Data Source
===========

Dan O’Brien. 2015. “Regional Geographies 2015.” Harvard Dataverse. <http://dx.doi.org/10.7910/DVN/PJ3JK2>.
