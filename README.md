docdbi
======



## Install


```r
install.packages("devtools")
devtools::install_github("ropensci/docdbi")
```


```r
library("docdbi")
```

## Initialize connections


```r
src_couchdb()
#> src: couchdb 1.6.1 [localhost/5984]
#> databases: _replicator, _users, adsfa, adsfdsf, bulkfromchr, bulkfromlist,
#>      bulktest, bulktest2, bulktest3, bulktest4, bulktest5, cachecall, diamonds,
#>      docdbi, hello_earth, iris, iriscolumns, irisrows, leothelion, leothelion2,
#>      mapuris, mran, mtcars, mtcars2, mtcarsdb, mydb, newdb, newdbs, newnew,
#>      stuff, stuff2, test
```


```r
src_elasticsearch()
#> src: elasticsearch 1.5.2 [http://127.0.0.1:9200]
#> databases: flowers, animals, flights, asdfdf, things2, twitter, -----,
#>      afjaljfalsfjalksdfadf, arrests, stuff_m, diam, logstash-2018.02.28, stuff,
#>      gbif, gbifnewgeo, geoshape, stuff_x, afjaljfalsfjalksdf, diamfromlist,
#>      plos, diamonds, stuff_i, pos, shakespeare2, stuff_e, stuff_g, geonames,
#>      gbifgeo, yep, diamonds_small, iris, stuff_k, things, shakespeare, stuff_j,
#>      gbifgeopoint, stuff_w, hello
```


```r
src_etcd()
#> src: etcd 0.4.6
```


```r
src_mongo()
#> MongoDB 3.0.2 (uptime: 2562s)
#> URL: Scotts-MBP/test
```


```r
src_rrlite()
#> $type
#> [1] "rrlite"
#> 
#> $version
#> [1] '0.2.0'
#> 
#> $con
#> <redis_api>
#>   Public:
#>     APPEND: function
...
```

## CouchDB


```r
src <- src_couchdb()
docout <- docdb_create(src, key = "mtcars", value = mtcars)
head( docdb_get(src, "mtcars") )
#>     mpg cyl disp  hp drat    wt  qsec vs am gear carb
#> 1: 21.0   6  160 110 3.90 2.620 16.46  0  1    4    4
#> 2: 21.0   6  160 110 3.90 2.875 17.02  0  1    4    4
#> 3: 22.8   4  108  93 3.85 2.320 18.61  1  1    4    1
#> 4: 21.4   6  258 110 3.08 3.215 19.44  1  0    3    1
#> 5: 18.7   8  360 175 3.15 3.440 17.02  0  0    3    2
#> 6: 18.1   6  225 105 2.76 3.460 20.22  1  0    3    1
```

## etcd 




```r
src <- src_etcd()
ff <- docdb_create(src, "/mtcars", mtcars)
head( docdb_get(src, "/mtcars") )
#>     mpg cyl  disp  hp drat    wt  qsec vs am gear carb
#> 1: 14.3   8 360.0 245 3.21 3.570 15.84  0  0    3    4
#> 2: 24.4   4 146.7  62 3.69 3.190 20.00  1  0    4    2
#> 3: 17.3   8 275.8 180 3.07 3.730 17.60  0  0    3    3
#> 4: 33.9   4  71.1  65 4.22 1.835 19.90  1  1    4    1
#> 5: 30.4   4  75.7  52 4.93 1.615 18.52  1  1    4    2
#> 6: 13.3   8 350.0 245 3.73 3.840 15.41  0  0    3    4
```

## Elasticsearch

Put the `iris` dataset into ES




```r
src <- src_elasticsearch()
ff <- docdb_create(src, "iris", iris)
head( docdb_get(src, "iris") )
#>   Sepal.Length Sepal.Width Petal.Length Petal.Width Species
#>          5.0         3.6          1.4         0.2  setosa
#>          4.9         3.1          1.5         0.1  setosa
#>          4.8         3.4          1.6         0.2  setosa
#>          5.4         3.9          1.3         0.4  setosa
#>          5.1         3.3          1.7         0.5  setosa
#>          5.2         3.4          1.4         0.2  setosa
```

## MongoDB


```r
library("ggplot2")
src <- src_mongo()
ff <- docdb_create(src, "diamonds_small", diamonds)
ff_m <- docdb_get(src, "diamonds_small")
head(diamonds)
#>   carat       cut color clarity depth table price    x    y    z
#> 1  0.23     Ideal     E     SI2  61.5    55   326 3.95 3.98 2.43
#> 2  0.21   Premium     E     SI1  59.8    61   326 3.89 3.84 2.31
#> 3  0.23      Good     E     VS1  56.9    65   327 4.05 4.07 2.31
#> 4  0.29   Premium     I     VS2  62.4    58   334 4.20 4.23 2.63
#> 5  0.31      Good     J     SI2  63.3    58   335 4.34 4.35 2.75
#> 6  0.24 Very Good     J    VVS2  62.8    57   336 3.94 3.96 2.48
head(ff_m)
#>   carat       cut color clarity depth table price    x    y    z
#> 1  0.23     Ideal     E     SI2  61.5    55   326 3.95 3.98 2.43
#> 2  0.21   Premium     E     SI1  59.8    61   326 3.89 3.84 2.31
#> 3  0.23      Good     E     VS1  56.9    65   327 4.05 4.07 2.31
#> 4  0.29   Premium     I     VS2  62.4    58   334 4.20 4.23 2.63
#> 5  0.31      Good     J     SI2  63.3    58   335 4.34 4.35 2.75
#> 6  0.24 Very Good     J    VVS2  62.8    57   336 3.94 3.96 2.48
```

## Redis


```r
src_rrlite()
#> $type
#> [1] "rrlite"
#> 
#> $version
#> [1] '0.2.0'
#> 
#> $con
#> <redis_api>
#>   Public:
#>     APPEND: function
...
```

## Use with dplyr


```r
library("dplyr")
src <- src_elasticsearch()
```


```r
docdb_get(src, "iris") %>% 
  group_by(Species) %>% 
  summarise(mean = mean(Petal.Length))
#> Error: IndexMissingException[[iris] missing]
```


```r
docdb_get(src, "diamonds_small") %>% 
  group_by(cut) %>% 
  summarise(mean_depth = mean(depth), mean_price = mean(price))
#> Source: local data table [5 x 3]
#> 
#>         cut mean_depth mean_price
#> 1      Good   62.38090   2185.303
#> 2 Very Good   61.74602   2365.310
#> 3     Ideal   61.67477   2503.051
#> 4   Premium   61.21793   2554.372
#> 5      Fair   63.31290   2793.613
```

## Meta

* [Please report any issues or bugs](https://github.com/ropensci/docdbi/issues).
* License: MIT
* Get citation information for `docdbi` in R doing `citation(package = 'docdbi')`

[![rofooter](http://ropensci.org/public_images/github_footer.png)](http://ropensci.org)
