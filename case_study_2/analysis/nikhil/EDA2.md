Case Study 2 - EDA
================
Nikhil Gupta
2020-09-15 06:27:23

  - [Load Libraries](#load-libraries)
  - [Missing Values](#missing-values)
  - [Participants by Year](#participants-by-year)
  - [Age Brackets by Year](#age-brackets-by-year)
  - [Race Times](#race-times)

# Load Libraries

``` r
library(tidyverse)
```

    ## -- Attaching packages -------------------------------------------------------------------------------------------------------- tidyverse 1.3.0 --

    ## v ggplot2 3.3.0     v purrr   0.3.4
    ## v tibble  3.0.0     v dplyr   0.8.5
    ## v tidyr   1.0.2     v stringr 1.4.0
    ## v readr   1.3.1     v forcats 0.5.0

    ## -- Conflicts ----------------------------------------------------------------------------------------------------------- tidyverse_conflicts() --
    ## x dplyr::filter() masks stats::filter()
    ## x dplyr::lag()    masks stats::lag()

``` r
library(plotly)
```

    ## 
    ## Attaching package: 'plotly'

    ## The following object is masked from 'package:ggplot2':
    ## 
    ##     last_plot

    ## The following object is masked from 'package:stats':
    ## 
    ##     filter

    ## The following object is masked from 'package:graphics':
    ## 
    ##     layout

``` r
data = readRDS("../../data/data.rds")
str(data)
```

    ## 'data.frame':    75866 obs. of  22 variables:
    ##  $ Race         : chr  "10M" "10M" "10M" "10M" ...
    ##  $ Name         : chr  "Jane Omoro " "Jane Ngotho " "Lidiya Grigoryeva " "Eunice Sagero " ...
    ##  $ Gender       : chr  "W" "W" "W" "W" ...
    ##  $ Age          : num  26 29 NA 20 29 24 38 NA 27 30 ...
    ##  $ Time         : POSIXct, format: "0000-01-01 00:53:37" "0000-01-01 00:53:38" ...
    ##  $ Pace         : POSIXct, format: "0000-01-01 00:05:22" "0000-01-01 00:05:22" ...
    ##  $ PiS          : num  1 2 3 4 5 6 7 8 9 10 ...
    ##  $ TiS          : num  2358 2358 2358 2358 2358 ...
    ##  $ Division     : chr  "W2529" "W2529" "NR" "W2024" ...
    ##  $ PiD          : num  1 2 NA 1 3 2 1 NA 4 1 ...
    ##  $ TiD          : num  559 559 NA 196 559 196 387 NA 559 529 ...
    ##  $ Hometown     : chr  "Kenya" "Kenya" "Russia" "Kenya" ...
    ##  $ Home State   : chr  NA NA NA NA ...
    ##  $ year         : int  1999 1999 1999 1999 1999 1999 1999 1999 1999 1999 ...
    ##  $ divisionTitle: chr  "Overall+Women" "Overall+Women" "Overall+Women" "Overall+Women" ...
    ##  $ section      : chr  "10M" "10M" "10M" "10M" ...
    ##  $ page         : int  1 1 1 1 1 1 1 1 1 1 ...
    ##  $ link         : chr  "http://www.cballtimeresults.org/performances?utf8=%E2%9C%93&section=10M&year=1999&division=Overall+Women&page=1" "http://www.cballtimeresults.org/performances?utf8=%E2%9C%93&section=10M&year=1999&division=Overall+Women&page=1" "http://www.cballtimeresults.org/performances?utf8=%E2%9C%93&section=10M&year=1999&division=Overall+Women&page=1" "http://www.cballtimeresults.org/performances?utf8=%E2%9C%93&section=10M&year=1999&division=Overall+Women&page=1" ...
    ##  $ DivisionCode : chr  "W" "W" "N" "W" ...
    ##  $ DivisionNum  : chr  "529" "529" "" "024" ...
    ##  $ TimeMins     : num  53.6 53.6 53.7 53.9 54.1 ...
    ##  $ PaceMins     : num  5.37 5.37 5.37 5.4 5.42 ...

``` r
summary(data)
```

    ##      Race               Name              Gender               Age       
    ##  Length:75866       Length:75866       Length:75866       Min.   : 7.00  
    ##  Class :character   Class :character   Class :character   1st Qu.:27.00  
    ##  Mode  :character   Mode  :character   Mode  :character   Median :32.00  
    ##                                                           Mean   :33.85  
    ##                                                           3rd Qu.:39.00  
    ##                                                           Max.   :87.00  
    ##                                                           NA's   :20     
    ##       Time                          Pace                          PiS      
    ##  Min.   :0000-01-01 00:51:44   Min.   :0000-01-01 00:05:10   Min.   :   1  
    ##  1st Qu.:0000-01-01 01:28:39   1st Qu.:0000-01-01 00:08:52   1st Qu.:1356  
    ##  Median :0000-01-01 01:37:29   Median :0000-01-01 00:09:45   Median :2786  
    ##  Mean   :0000-01-01 01:38:13   Mean   :0000-01-01 00:09:50   Mean   :3305  
    ##  3rd Qu.:0000-01-01 01:46:58   3rd Qu.:0000-01-01 00:10:42   3rd Qu.:4905  
    ##  Max.   :0000-01-01 02:57:31   Max.   :0000-01-01 00:17:45   Max.   :9729  
    ##                                                                            
    ##       TiS         Division              PiD              TiD      
    ##  Min.   :2166   Length:75866       Min.   :   1.0   Min.   :   1  
    ##  1st Qu.:4333   Class :character   1st Qu.: 165.0   1st Qu.: 559  
    ##  Median :6395   Mode  :character   Median : 404.0   Median : 953  
    ##  Mean   :6609                      Mean   : 595.6   Mean   :1190  
    ##  3rd Qu.:8853                      3rd Qu.: 816.0   3rd Qu.:1678  
    ##  Max.   :9729                      Max.   :5302.0   Max.   :2803  
    ##                                    NA's   :20       NA's   :20    
    ##    Hometown          Home State             year      divisionTitle     
    ##  Length:75866       Length:75866       Min.   :1999   Length:75866      
    ##  Class :character   Class :character   1st Qu.:2005   Class :character  
    ##  Mode  :character   Mode  :character   Median :2008   Mode  :character  
    ##                                        Mean   :2007                     
    ##                                        3rd Qu.:2010                     
    ##                                        Max.   :2012                     
    ##                                                                         
    ##    section               page           link           DivisionCode      
    ##  Length:75866       Min.   :  1.0   Length:75866       Length:75866      
    ##  Class :character   1st Qu.: 68.0   Class :character   Class :character  
    ##  Mode  :character   Median :140.0   Mode  :character   Mode  :character  
    ##                     Mean   :165.7                                        
    ##                     3rd Qu.:246.0                                        
    ##                     Max.   :487.0                                        
    ##                                                                          
    ##  DivisionNum           TimeMins         PaceMins     
    ##  Length:75866       Min.   : 51.73   Min.   : 5.167  
    ##  Class :character   1st Qu.: 88.65   1st Qu.: 8.867  
    ##  Mode  :character   Median : 97.48   Median : 9.750  
    ##                     Mean   : 98.22   Mean   : 9.823  
    ##                     3rd Qu.:106.97   3rd Qu.:10.700  
    ##                     Max.   :177.52   Max.   :17.750  
    ## 

``` r
head(data)
```

    ##   Race               Name Gender Age                Time                Pace
    ## 1  10M        Jane Omoro       W  26 0000-01-01 00:53:37 0000-01-01 00:05:22
    ## 2  10M       Jane Ngotho       W  29 0000-01-01 00:53:38 0000-01-01 00:05:22
    ## 3  10M Lidiya Grigoryeva       W  NA 0000-01-01 00:53:40 0000-01-01 00:05:22
    ## 4  10M     Eunice Sagero       W  20 0000-01-01 00:53:55 0000-01-01 00:05:24
    ## 5  10M   Alla Zhilyayeva       W  29 0000-01-01 00:54:08 0000-01-01 00:05:25
    ## 6  10M    Teresa Wanjiku       W  24 0000-01-01 00:54:10 0000-01-01 00:05:25
    ##   PiS  TiS Division PiD TiD Hometown Home State year divisionTitle section page
    ## 1   1 2358    W2529   1 559    Kenya       <NA> 1999 Overall+Women     10M    1
    ## 2   2 2358    W2529   2 559    Kenya       <NA> 1999 Overall+Women     10M    1
    ## 3   3 2358       NR  NA  NA   Russia       <NA> 1999 Overall+Women     10M    1
    ## 4   4 2358    W2024   1 196    Kenya       <NA> 1999 Overall+Women     10M    1
    ## 5   5 2358    W2529   3 559   Russia       <NA> 1999 Overall+Women     10M    1
    ## 6   6 2358    W2024   2 196    Kenya       <NA> 1999 Overall+Women     10M    1
    ##                                                                                                              link
    ## 1 http://www.cballtimeresults.org/performances?utf8=%E2%9C%93&section=10M&year=1999&division=Overall+Women&page=1
    ## 2 http://www.cballtimeresults.org/performances?utf8=%E2%9C%93&section=10M&year=1999&division=Overall+Women&page=1
    ## 3 http://www.cballtimeresults.org/performances?utf8=%E2%9C%93&section=10M&year=1999&division=Overall+Women&page=1
    ## 4 http://www.cballtimeresults.org/performances?utf8=%E2%9C%93&section=10M&year=1999&division=Overall+Women&page=1
    ## 5 http://www.cballtimeresults.org/performances?utf8=%E2%9C%93&section=10M&year=1999&division=Overall+Women&page=1
    ## 6 http://www.cballtimeresults.org/performances?utf8=%E2%9C%93&section=10M&year=1999&division=Overall+Women&page=1
    ##   DivisionCode DivisionNum TimeMins PaceMins
    ## 1            W         529 53.61667 5.366667
    ## 2            W         529 53.63333 5.366667
    ## 3            N             53.66667 5.366667
    ## 4            W         024 53.91667 5.400000
    ## 5            W         529 54.13333 5.416667
    ## 6            W         024 54.16667 5.416667

``` r
unique(data$Race)
```

    ## [1] "10M"

``` r
unique(data$Gender)
```

    ## [1] "W"       "xue Zhu" "suzy"    "Cindy"

``` r
unique(data %>% arrange(Age) %>%  select(Age) %>%  pluck(1)) 
```

    ##  [1]  7 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33
    ## [26] 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58
    ## [51] 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 80 81 83 84 85
    ## [76] 86 87 NA

``` r
unique(data %>% arrange(Division) %>%  select(Division) %>%  pluck(1)) 
```

    ##  [1] "NR"    "W0119" "W2024" "W2529" "W3034" "W3539" "W4044" "W4549" "W5054"
    ## [10] "W5559" "W6064" "W6569" "W7074" "W7579" "W8099"

  - Some issues with Gender –\> Does it matter?

# Missing Values

``` r
data %>% 
  select_if(function(x) any(is.na(x))) %>% 
  summarise_each(~ sum(is.na(.))) 
```

    ##   Age PiD TiD Home State
    ## 1  20  20  20        241

``` r
noresults = data %>% dplyr::filter(Division == "NR")
dim(noresults)
```

    ## [1] 19 22

``` r
head(noresults)
```

    ##   Race                 Name Gender Age                Time                Pace
    ## 1  10M   Lidiya Grigoryeva       W  NA 0000-01-01 00:53:40 0000-01-01 00:05:22
    ## 2  10M        Gladys Asiba       W  NA 0000-01-01 00:54:50 0000-01-01 00:05:29
    ## 3  10M   Connie Buckwalter       W  NA 0000-01-01 00:59:36 0000-01-01 00:05:58
    ## 4  10M            Ann Reid       W  NA 0000-01-01 01:53:03 0000-01-01 00:11:18
    ## 5  10M        Loretta Cuce       W  NA 0000-01-01 01:53:38 0000-01-01 00:11:22
    ## 6  10M Unidentified Runner       W  NA 0000-01-01 01:19:45 0000-01-01 00:07:59
    ##    PiS  TiS Division PiD TiD   Hometown Home State year divisionTitle section
    ## 1    3 2358       NR  NA  NA     Russia       <NA> 1999 Overall+Women     10M
    ## 2    8 2358       NR  NA  NA      Kenya       <NA> 1999 Overall+Women     10M
    ## 3   17 2358       NR  NA  NA  Lancaster         PA 1999 Overall+Women     10M
    ## 4 2176 2358       NR  NA  NA   Bethesda         MD 1999 Overall+Women     10M
    ## 5 2611 2972       NR  NA  NA Alexandria         VA 2001 Overall+Women     10M
    ## 6  270 3333       NR  NA  NA Washington         DC 2002 Overall+Women     10M
    ##   page
    ## 1    1
    ## 2    1
    ## 3    1
    ## 4  109
    ## 5  131
    ## 6   14
    ##                                                                                                                link
    ## 1   http://www.cballtimeresults.org/performances?utf8=%E2%9C%93&section=10M&year=1999&division=Overall+Women&page=1
    ## 2   http://www.cballtimeresults.org/performances?utf8=%E2%9C%93&section=10M&year=1999&division=Overall+Women&page=1
    ## 3   http://www.cballtimeresults.org/performances?utf8=%E2%9C%93&section=10M&year=1999&division=Overall+Women&page=1
    ## 4 http://www.cballtimeresults.org/performances?utf8=%E2%9C%93&section=10M&year=1999&division=Overall+Women&page=109
    ## 5 http://www.cballtimeresults.org/performances?utf8=%E2%9C%93&section=10M&year=2001&division=Overall+Women&page=131
    ## 6  http://www.cballtimeresults.org/performances?utf8=%E2%9C%93&section=10M&year=2002&division=Overall+Women&page=14
    ##   DivisionCode DivisionNum  TimeMins  PaceMins
    ## 1            N              53.66667  5.366667
    ## 2            N              54.83333  5.483333
    ## 3            N              59.60000  5.966667
    ## 4            N             113.05000 11.300000
    ## 5            N             113.63333 11.366667
    ## 6            N              79.75000  7.983333

``` r
noage = data %>% dplyr::filter(is.na(Age))
dim(noage)
```

    ## [1] 20 22

``` r
head(noage)
```

    ##   Race                 Name Gender Age                Time                Pace
    ## 1  10M   Lidiya Grigoryeva       W  NA 0000-01-01 00:53:40 0000-01-01 00:05:22
    ## 2  10M        Gladys Asiba       W  NA 0000-01-01 00:54:50 0000-01-01 00:05:29
    ## 3  10M   Connie Buckwalter       W  NA 0000-01-01 00:59:36 0000-01-01 00:05:58
    ## 4  10M            Ann Reid       W  NA 0000-01-01 01:53:03 0000-01-01 00:11:18
    ## 5  10M        Loretta Cuce       W  NA 0000-01-01 01:53:38 0000-01-01 00:11:22
    ## 6  10M Unidentified Runner       W  NA 0000-01-01 01:19:45 0000-01-01 00:07:59
    ##    PiS  TiS Division PiD TiD   Hometown Home State year divisionTitle section
    ## 1    3 2358       NR  NA  NA     Russia       <NA> 1999 Overall+Women     10M
    ## 2    8 2358       NR  NA  NA      Kenya       <NA> 1999 Overall+Women     10M
    ## 3   17 2358       NR  NA  NA  Lancaster         PA 1999 Overall+Women     10M
    ## 4 2176 2358       NR  NA  NA   Bethesda         MD 1999 Overall+Women     10M
    ## 5 2611 2972       NR  NA  NA Alexandria         VA 2001 Overall+Women     10M
    ## 6  270 3333       NR  NA  NA Washington         DC 2002 Overall+Women     10M
    ##   page
    ## 1    1
    ## 2    1
    ## 3    1
    ## 4  109
    ## 5  131
    ## 6   14
    ##                                                                                                                link
    ## 1   http://www.cballtimeresults.org/performances?utf8=%E2%9C%93&section=10M&year=1999&division=Overall+Women&page=1
    ## 2   http://www.cballtimeresults.org/performances?utf8=%E2%9C%93&section=10M&year=1999&division=Overall+Women&page=1
    ## 3   http://www.cballtimeresults.org/performances?utf8=%E2%9C%93&section=10M&year=1999&division=Overall+Women&page=1
    ## 4 http://www.cballtimeresults.org/performances?utf8=%E2%9C%93&section=10M&year=1999&division=Overall+Women&page=109
    ## 5 http://www.cballtimeresults.org/performances?utf8=%E2%9C%93&section=10M&year=2001&division=Overall+Women&page=131
    ## 6  http://www.cballtimeresults.org/performances?utf8=%E2%9C%93&section=10M&year=2002&division=Overall+Women&page=14
    ##   DivisionCode DivisionNum  TimeMins  PaceMins
    ## 1            N              53.66667  5.366667
    ## 2            N              54.83333  5.483333
    ## 3            N              59.60000  5.966667
    ## 4            N             113.05000 11.300000
    ## 5            N             113.63333 11.366667
    ## 6            N              79.75000  7.983333

``` r
setdiff(noage, noresults)
```

    ##   Race             Name Gender Age                Time                Pace  PiS
    ## 1  10M Michelle Hinman       W  NA 0000-01-01 01:39:13 0000-01-01 00:09:55 2455
    ##    TiS Division PiD TiD Hometown Home State year divisionTitle section page
    ## 1 4333    W8099   1   2       NR       <NA> 2005 Overall+Women     10M  123
    ##                                                                                                                link
    ## 1 http://www.cballtimeresults.org/performances?utf8=%E2%9C%93&section=10M&year=2005&division=Overall+Women&page=123
    ##   DivisionCode DivisionNum TimeMins PaceMins
    ## 1            W         099 99.21667 9.916667

  - This seems to be an issue. It looks like this person is placed first
    in the division, but age is not set so she has been classified as
    W8099 and the time seems to be off from what would be expected from
    this age bracket.
  - TODO: Fix this

<!-- end list -->

``` r
# Remove no results
data = data %>% 
  dplyr::filter(Division != "NR")
```

# Participants by Year

``` r
plotdata = data %>% 
  group_by(year) %>% 
  summarise(count=n()) 

p = plotdata %>% 
  ggplot(aes(x=year, y=count)) +
  geom_line() +
  geom_point()
ggplotly(p, tooltip="text")
```

<!--html_preserve-->

<div id="htmlwidget-b0789123717db8688750" class="plotly html-widget" style="width:672px;height:480px;">

</div>

<script type="application/json" data-for="htmlwidget-b0789123717db8688750">{"x":{"data":[{"x":[1999,2000,2001,2002,2003,2004,2005,2006,2007,2008,2009,2010,2011,2012],"y":[2354,2166,2971,3330,3525,3885,4324,5435,5530,6395,8322,8853,9030,9727],"text":"","type":"scatter","mode":"lines+markers","line":{"width":1.88976377952756,"color":"rgba(0,0,0,1)","dash":"solid"},"hoveron":"points","showlegend":false,"xaxis":"x","yaxis":"y","hoverinfo":"text","marker":{"autocolorscale":false,"color":"rgba(0,0,0,1)","opacity":1,"size":5.66929133858268,"symbol":"circle","line":{"width":1.88976377952756,"color":"rgba(0,0,0,1)"}},"frame":null}],"layout":{"margin":{"t":26.2283105022831,"r":7.30593607305936,"b":40.1826484018265,"l":54.7945205479452},"plot_bgcolor":"rgba(235,235,235,1)","paper_bgcolor":"rgba(255,255,255,1)","font":{"color":"rgba(0,0,0,1)","family":"","size":14.6118721461187},"xaxis":{"domain":[0,1],"automargin":true,"type":"linear","autorange":false,"range":[1998.35,2012.65],"tickmode":"array","ticktext":["2001","2004","2007","2010"],"tickvals":[2001,2004,2007,2010],"categoryorder":"array","categoryarray":["2001","2004","2007","2010"],"nticks":null,"ticks":"outside","tickcolor":"rgba(51,51,51,1)","ticklen":3.65296803652968,"tickwidth":0.66417600664176,"showticklabels":true,"tickfont":{"color":"rgba(77,77,77,1)","family":"","size":11.689497716895},"tickangle":-0,"showline":false,"linecolor":null,"linewidth":0,"showgrid":true,"gridcolor":"rgba(255,255,255,1)","gridwidth":0.66417600664176,"zeroline":false,"anchor":"y","title":{"text":"year","font":{"color":"rgba(0,0,0,1)","family":"","size":14.6118721461187}},"hoverformat":".2f"},"yaxis":{"domain":[0,1],"automargin":true,"type":"linear","autorange":false,"range":[1787.95,10105.05],"tickmode":"array","ticktext":["2000","4000","6000","8000","10000"],"tickvals":[2000,4000,6000,8000,10000],"categoryorder":"array","categoryarray":["2000","4000","6000","8000","10000"],"nticks":null,"ticks":"outside","tickcolor":"rgba(51,51,51,1)","ticklen":3.65296803652968,"tickwidth":0.66417600664176,"showticklabels":true,"tickfont":{"color":"rgba(77,77,77,1)","family":"","size":11.689497716895},"tickangle":-0,"showline":false,"linecolor":null,"linewidth":0,"showgrid":true,"gridcolor":"rgba(255,255,255,1)","gridwidth":0.66417600664176,"zeroline":false,"anchor":"x","title":{"text":"count","font":{"color":"rgba(0,0,0,1)","family":"","size":14.6118721461187}},"hoverformat":".2f"},"shapes":[{"type":"rect","fillcolor":null,"line":{"color":null,"width":0,"linetype":[]},"yref":"paper","xref":"paper","x0":0,"x1":1,"y0":0,"y1":1}],"showlegend":false,"legend":{"bgcolor":"rgba(255,255,255,1)","bordercolor":"transparent","borderwidth":1.88976377952756,"font":{"color":"rgba(0,0,0,1)","family":"","size":11.689497716895}},"hovermode":"closest","barmode":"relative"},"config":{"doubleClick":"reset","showSendToCloud":false},"source":"A","attrs":{"1a704c6e19f5":{"x":{},"y":{},"type":"scatter"},"1a703f7c34b5":{"x":{},"y":{}}},"cur_data":"1a704c6e19f5","visdat":{"1a704c6e19f5":["function (y) ","x"],"1a703f7c34b5":["function (y) ","x"]},"highlight":{"on":"plotly_click","persistent":false,"dynamic":false,"selectize":false,"opacityDim":0.2,"selected":{"opacity":1},"debounce":0},"shinyEvents":["plotly_hover","plotly_click","plotly_selected","plotly_relayout","plotly_brushed","plotly_brushing","plotly_clickannotation","plotly_doubleclick","plotly_deselect","plotly_afterplot","plotly_sunburstclick"],"base_url":"https://plot.ly"},"evals":[],"jsHooks":[]}</script>

<!--/html_preserve-->

``` r
p = plotdata %>% 
  ggplot(aes(x = year, y = count)) + 
  geom_bar(stat = "identity")
ggplotly(p, tooltip="text")
```

<!--html_preserve-->

<div id="htmlwidget-f7c96c252ac57b9a8c78" class="plotly html-widget" style="width:672px;height:480px;">

</div>

<script type="application/json" data-for="htmlwidget-f7c96c252ac57b9a8c78">{"x":{"data":[{"orientation":"v","width":[0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091],"base":[0,0,0,0,0,0,0,0,0,0,0,0,0,0],"x":[1999,2000,2001,2002,2003,2004,2005,2006,2007,2008,2009,2010,2011,2012],"y":[2354,2166,2971,3330,3525,3885,4324,5435,5530,6395,8322,8853,9030,9727],"text":"","type":"bar","marker":{"autocolorscale":false,"color":"rgba(89,89,89,1)","line":{"width":1.88976377952756,"color":"transparent"}},"showlegend":false,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null}],"layout":{"margin":{"t":26.2283105022831,"r":7.30593607305936,"b":40.1826484018265,"l":54.7945205479452},"plot_bgcolor":"rgba(235,235,235,1)","paper_bgcolor":"rgba(255,255,255,1)","font":{"color":"rgba(0,0,0,1)","family":"","size":14.6118721461187},"xaxis":{"domain":[0,1],"automargin":true,"type":"linear","autorange":false,"range":[1997.855,2013.145],"tickmode":"array","ticktext":["1998","2002","2006","2010"],"tickvals":[1998,2002,2006,2010],"categoryorder":"array","categoryarray":["1998","2002","2006","2010"],"nticks":null,"ticks":"outside","tickcolor":"rgba(51,51,51,1)","ticklen":3.65296803652968,"tickwidth":0.66417600664176,"showticklabels":true,"tickfont":{"color":"rgba(77,77,77,1)","family":"","size":11.689497716895},"tickangle":-0,"showline":false,"linecolor":null,"linewidth":0,"showgrid":true,"gridcolor":"rgba(255,255,255,1)","gridwidth":0.66417600664176,"zeroline":false,"anchor":"y","title":{"text":"year","font":{"color":"rgba(0,0,0,1)","family":"","size":14.6118721461187}},"hoverformat":".2f"},"yaxis":{"domain":[0,1],"automargin":true,"type":"linear","autorange":false,"range":[-486.35,10213.35],"tickmode":"array","ticktext":["0","2500","5000","7500","10000"],"tickvals":[0,2500,5000,7500,10000],"categoryorder":"array","categoryarray":["0","2500","5000","7500","10000"],"nticks":null,"ticks":"outside","tickcolor":"rgba(51,51,51,1)","ticklen":3.65296803652968,"tickwidth":0.66417600664176,"showticklabels":true,"tickfont":{"color":"rgba(77,77,77,1)","family":"","size":11.689497716895},"tickangle":-0,"showline":false,"linecolor":null,"linewidth":0,"showgrid":true,"gridcolor":"rgba(255,255,255,1)","gridwidth":0.66417600664176,"zeroline":false,"anchor":"x","title":{"text":"count","font":{"color":"rgba(0,0,0,1)","family":"","size":14.6118721461187}},"hoverformat":".2f"},"shapes":[{"type":"rect","fillcolor":null,"line":{"color":null,"width":0,"linetype":[]},"yref":"paper","xref":"paper","x0":0,"x1":1,"y0":0,"y1":1}],"showlegend":false,"legend":{"bgcolor":"rgba(255,255,255,1)","bordercolor":"transparent","borderwidth":1.88976377952756,"font":{"color":"rgba(0,0,0,1)","family":"","size":11.689497716895}},"hovermode":"closest","barmode":"relative"},"config":{"doubleClick":"reset","showSendToCloud":false},"source":"A","attrs":{"1a703a81528c":{"x":{},"y":{},"type":"bar"}},"cur_data":"1a703a81528c","visdat":{"1a703a81528c":["function (y) ","x"]},"highlight":{"on":"plotly_click","persistent":false,"dynamic":false,"selectize":false,"opacityDim":0.2,"selected":{"opacity":1},"debounce":0},"shinyEvents":["plotly_hover","plotly_click","plotly_selected","plotly_relayout","plotly_brushed","plotly_brushing","plotly_clickannotation","plotly_doubleclick","plotly_deselect","plotly_afterplot","plotly_sunburstclick"],"base_url":"https://plot.ly"},"evals":[],"jsHooks":[]}</script>

<!--/html_preserve-->

``` r
# Alternate colored by Division
plotdata = data %>% 
  group_by(year, Division) %>% 
  summarise(count = n())

p = plotdata %>% 
  ggplot(aes(x = year, y = count, fill = Division)) + 
  geom_bar(stat = "identity", position = "stack") 
ggplotly(p, tooltip="text")
```

<!--html_preserve-->

<div id="htmlwidget-aa9cbf626dfff60183a1" class="plotly html-widget" style="width:672px;height:480px;">

</div>

<script type="application/json" data-for="htmlwidget-aa9cbf626dfff60183a1">{"x":{"data":[{"orientation":"v","width":[0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091],"base":[2340,2146,2946,3310,3500,3852,4289,5385,5476,6341,8251,8759,8939,9644],"x":[1999,2000,2001,2002,2003,2004,2005,2006,2007,2008,2009,2010,2011,2012],"y":[14,20,25,20,25,33,35,50,54,54,71,94,91,83],"text":"","type":"bar","marker":{"autocolorscale":false,"color":"rgba(248,118,109,1)","line":{"width":1.88976377952756,"color":"transparent"}},"name":"W0119","legendgroup":"W0119","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null},{"orientation":"v","width":[0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091],"base":[2144,1978,2690,3032,3210,3419,3811,4699,4763,5558,7297,7788,8002,8670],"x":[1999,2000,2001,2002,2003,2004,2005,2006,2007,2008,2009,2010,2011,2012],"y":[196,168,256,278,290,433,478,686,713,783,954,971,937,974],"text":"","type":"bar","marker":{"autocolorscale":false,"color":"rgba(227,137,0,1)","line":{"width":1.88976377952756,"color":"transparent"}},"name":"W2024","legendgroup":"W2024","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null},{"orientation":"v","width":[0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091],"base":[1585,1512,1985,2256,2354,2345,2608,3174,3133,3565,4591,4985,5297,5889],"x":[1999,2000,2001,2002,2003,2004,2005,2006,2007,2008,2009,2010,2011,2012],"y":[559,466,705,776,856,1074,1203,1525,1630,1993,2706,2803,2705,2781],"text":"","type":"bar","marker":{"autocolorscale":false,"color":"rgba(196,154,0,1)","line":{"width":1.88976377952756,"color":"transparent"}},"name":"W2529","legendgroup":"W2529","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null},{"orientation":"v","width":[0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091],"base":[1056,1040,1302,1494,1584,1519,1804,2115,2086,2307,2913,3175,3431,3663],"x":[1999,2000,2001,2002,2003,2004,2005,2006,2007,2008,2009,2010,2011,2012],"y":[529,472,683,762,770,826,804,1059,1047,1258,1678,1810,1866,2226],"text":"","type":"bar","marker":{"autocolorscale":false,"color":"rgba(153,168,0,1)","line":{"width":1.88976377952756,"color":"transparent"}},"name":"W3034","legendgroup":"W3034","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null},{"orientation":"v","width":[0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091],"base":[669,663,840,957,1000,958,1145,1316,1278,1425,1783,1998,2166,2298],"x":[1999,2000,2001,2002,2003,2004,2005,2006,2007,2008,2009,2010,2011,2012],"y":[387,377,462,537,584,561,659,799,808,882,1130,1177,1265,1365],"text":"","type":"bar","marker":{"autocolorscale":false,"color":"rgba(83,180,0,1)","line":{"width":1.88976377952756,"color":"transparent"}},"name":"W3539","legendgroup":"W3539","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null},{"orientation":"v","width":[0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091],"base":[363,376,460,558,582,552,643,756,772,853,1041,1153,1245,1324],"x":[1999,2000,2001,2002,2003,2004,2005,2006,2007,2008,2009,2010,2011,2012],"y":[306,287,380,399,418,406,502,560,506,572,742,845,921,974],"text":"","type":"bar","marker":{"autocolorscale":false,"color":"rgba(0,188,86,1)","line":{"width":1.88976377952756,"color":"transparent"}},"name":"W4044","legendgroup":"W4044","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null},{"orientation":"v","width":[0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091],"base":[177,196,219,284,298,291,355,393,405,442,552,592,670,770],"x":[1999,2000,2001,2002,2003,2004,2005,2006,2007,2008,2009,2010,2011,2012],"y":[186,180,241,274,284,261,288,363,367,411,489,561,575,554],"text":"","type":"bar","marker":{"autocolorscale":false,"color":"rgba(0,192,148,1)","line":{"width":1.88976377952756,"color":"transparent"}},"name":"W4549","legendgroup":"W4549","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null},{"orientation":"v","width":[0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091],"base":[63,87,106,118,130,127,139,166,162,185,233,290,313,373],"x":[1999,2000,2001,2002,2003,2004,2005,2006,2007,2008,2009,2010,2011,2012],"y":[114,109,113,166,168,164,216,227,243,257,319,302,357,397],"text":"","type":"bar","marker":{"autocolorscale":false,"color":"rgba(0,191,196,1)","line":{"width":1.88976377952756,"color":"transparent"}},"name":"W5054","legendgroup":"W5054","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null},{"orientation":"v","width":[0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091],"base":[16,27,40,46,47,44,49,62,55,66,74,87,105,137],"x":[1999,2000,2001,2002,2003,2004,2005,2006,2007,2008,2009,2010,2011,2012],"y":[47,60,66,72,83,83,90,104,107,119,159,203,208,236],"text":"","type":"bar","marker":{"autocolorscale":false,"color":"rgba(0,182,235,1)","line":{"width":1.88976377952756,"color":"transparent"}},"name":"W5559","legendgroup":"W5559","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null},{"orientation":"v","width":[0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091],"base":[6,7,10,14,17,17,13,14,22,16,18,23,33,44],"x":[1999,2000,2001,2002,2003,2004,2005,2006,2007,2008,2009,2010,2011,2012],"y":[10,20,30,32,30,27,36,48,33,50,56,64,72,93],"text":"","type":"bar","marker":{"autocolorscale":false,"color":"rgba(6,164,255,1)","line":{"width":1.88976377952756,"color":"transparent"}},"name":"W6064","legendgroup":"W6064","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null},{"orientation":"v","width":[0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091],"base":[3,2,4,3,7,8,5,4,5,3,6,6,7,9],"x":[1999,2000,2001,2002,2003,2004,2005,2006,2007,2008,2009,2010,2011,2012],"y":[3,5,6,11,10,9,8,10,17,13,12,17,26,35],"text":"","type":"bar","marker":{"autocolorscale":false,"color":"rgba(165,138,255,1)","line":{"width":1.88976377952756,"color":"transparent"}},"name":"W6569","legendgroup":"W6569","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null},{"orientation":"v","width":[0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091],"base":[2,1,2,3,2,3,2,1,1,0,1,2,1],"x":[1999,2001,2002,2003,2004,2005,2006,2007,2008,2009,2010,2011,2012],"y":[1,3,1,4,6,2,2,4,2,6,5,5,8],"text":"","type":"bar","marker":{"autocolorscale":false,"color":"rgba(223,112,248,1)","line":{"width":1.88976377952756,"color":"transparent"}},"name":"W7074","legendgroup":"W7074","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null},{"orientation":"v","width":[0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091],"base":[1,0,1,1,2,0,0,0,0,0,0],"x":[1999,2000,2002,2003,2005,2006,2007,2008,2010,2011,2012],"y":[1,2,1,2,1,2,1,1,1,2,1],"text":"","type":"bar","marker":{"autocolorscale":false,"color":"rgba(251,97,215,1)","line":{"width":1.88976377952756,"color":"transparent"}},"name":"W7579","legendgroup":"W7579","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null},{"orientation":"v","width":[0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091,0.900000000000091],"base":[0,0,0,0,0,0],"x":[1999,2001,2002,2003,2004,2005],"y":[1,1,1,1,2,2],"text":"","type":"bar","marker":{"autocolorscale":false,"color":"rgba(255,102,168,1)","line":{"width":1.88976377952756,"color":"transparent"}},"name":"W8099","legendgroup":"W8099","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null}],"layout":{"margin":{"t":26.2283105022831,"r":7.30593607305936,"b":40.1826484018265,"l":54.7945205479452},"plot_bgcolor":"rgba(235,235,235,1)","paper_bgcolor":"rgba(255,255,255,1)","font":{"color":"rgba(0,0,0,1)","family":"","size":14.6118721461187},"xaxis":{"domain":[0,1],"automargin":true,"type":"linear","autorange":false,"range":[1997.855,2013.145],"tickmode":"array","ticktext":["1998","2002","2006","2010"],"tickvals":[1998,2002,2006,2010],"categoryorder":"array","categoryarray":["1998","2002","2006","2010"],"nticks":null,"ticks":"outside","tickcolor":"rgba(51,51,51,1)","ticklen":3.65296803652968,"tickwidth":0.66417600664176,"showticklabels":true,"tickfont":{"color":"rgba(77,77,77,1)","family":"","size":11.689497716895},"tickangle":-0,"showline":false,"linecolor":null,"linewidth":0,"showgrid":true,"gridcolor":"rgba(255,255,255,1)","gridwidth":0.66417600664176,"zeroline":false,"anchor":"y","title":{"text":"year","font":{"color":"rgba(0,0,0,1)","family":"","size":14.6118721461187}},"hoverformat":".2f"},"yaxis":{"domain":[0,1],"automargin":true,"type":"linear","autorange":false,"range":[-486.35,10213.35],"tickmode":"array","ticktext":["0","2500","5000","7500","10000"],"tickvals":[0,2500,5000,7500,10000],"categoryorder":"array","categoryarray":["0","2500","5000","7500","10000"],"nticks":null,"ticks":"outside","tickcolor":"rgba(51,51,51,1)","ticklen":3.65296803652968,"tickwidth":0.66417600664176,"showticklabels":true,"tickfont":{"color":"rgba(77,77,77,1)","family":"","size":11.689497716895},"tickangle":-0,"showline":false,"linecolor":null,"linewidth":0,"showgrid":true,"gridcolor":"rgba(255,255,255,1)","gridwidth":0.66417600664176,"zeroline":false,"anchor":"x","title":{"text":"count","font":{"color":"rgba(0,0,0,1)","family":"","size":14.6118721461187}},"hoverformat":".2f"},"shapes":[{"type":"rect","fillcolor":null,"line":{"color":null,"width":0,"linetype":[]},"yref":"paper","xref":"paper","x0":0,"x1":1,"y0":0,"y1":1}],"showlegend":true,"legend":{"bgcolor":"rgba(255,255,255,1)","bordercolor":"transparent","borderwidth":1.88976377952756,"font":{"color":"rgba(0,0,0,1)","family":"","size":11.689497716895},"y":0.93503937007874},"annotations":[{"text":"Division","x":1.02,"y":1,"showarrow":false,"ax":0,"ay":0,"font":{"color":"rgba(0,0,0,1)","family":"","size":14.6118721461187},"xref":"paper","yref":"paper","textangle":-0,"xanchor":"left","yanchor":"bottom","legendTitle":true}],"hovermode":"closest","barmode":"relative"},"config":{"doubleClick":"reset","showSendToCloud":false},"source":"A","attrs":{"1a7093147ab":{"x":{},"y":{},"fill":{},"type":"bar"}},"cur_data":"1a7093147ab","visdat":{"1a7093147ab":["function (y) ","x"]},"highlight":{"on":"plotly_click","persistent":false,"dynamic":false,"selectize":false,"opacityDim":0.2,"selected":{"opacity":1},"debounce":0},"shinyEvents":["plotly_hover","plotly_click","plotly_selected","plotly_relayout","plotly_brushed","plotly_brushing","plotly_clickannotation","plotly_doubleclick","plotly_deselect","plotly_afterplot","plotly_sunburstclick"],"base_url":"https://plot.ly"},"evals":[],"jsHooks":[]}</script>

<!--/html_preserve-->

# Age Brackets by Year

``` r
plotdata_by_year = data %>% 
  group_by(year) %>% 
  summarise(count_year = n())

plotdata_by_year_div = data %>% 
  group_by(year, Division) %>% 
  summarise(count_year_div = n())

plotdata = plotdata_by_year %>% 
  plyr::join(plotdata_by_year_div, by = "year", type = "full") %>% 
  mutate(percent = round(count_year_div/count_year*100,1))
  
plotdata %>% 
  ggplot(aes(x = year, y = percent, fill = Division)) + 
  geom_bar(stat = "identity", position = "stack")
```

![](EDA2_files/figure-gfm/unnamed-chunk-13-1.png)<!-- -->

# Race Times

``` r
p = data %>% 
  mutate_at("year", as.factor) %>% 
  ggplot(aes(x=year, y=TimeMins)) + 
  geom_boxplot()

ggplotly(p, tooltip="text")
```

<!--html_preserve-->

<div id="htmlwidget-c3afa0b84ebdb5ad3b0c" class="plotly html-widget" style="width:672px;height:480px;">

</div>


<!--/html_preserve-->

``` r
p = data %>% 
  dplyr::filter(!(Division %in% c("W8099", "W7579"))) %>% 
  mutate_at("year", as.factor) %>% 
  ggplot(aes(x=year, y=TimeMins, fill=year)) + 
  geom_boxplot() +
  facet_wrap(. ~ Division, ncol=4) +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) + 
  coord_flip()

p
```

![](EDA2_files/figure-gfm/unnamed-chunk-15-1.png)<!-- -->

``` r
#ggplotly(p, tooltip="text")
```

``` r
p = data %>% 
  dplyr::filter(Division %in% c("W2529", "W3034", "W3539", "W4044")) %>% 
  mutate_at("year", as.factor) %>% 
  ggplot(aes(x=year, y=TimeMins, fill=year)) + 
  geom_boxplot() +
  facet_wrap(. ~ Division, ncol=4) +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) + 
  coord_flip()

m <- list(
  l = 100,
  r = 50,
  b = 100,
  t = 50,
  pad = 4
)
gp = ggplotly(p, tooltip="text", width=800, height=600) %>%
  layout(
    autosize = F,
    margin=m,
    legend = list(orientation = "h", xanchor = "center", x = 0.5, y = -0.15)
    ) %>% 
  style(legendgroup = NULL)
# gp

# find the annotation you want to move
# Based on https://stackoverflow.com/questions/42763280/r-ggplot-and-plotly-axis-margin-wont-change
labels = c("year", "TimeMins")
for(i in seq_along(gp[['x']][['layout']][['annotations']])){
  for(label in labels){
    if (gp[['x']][['layout']][['annotations']][[i]]$text == label){
      print(paste(
        label, "Index: ", i, "X, Y: ",
        gp[['x']][['layout']][['annotations']][[i]]$x,
        gp[['x']][['layout']][['annotations']][[i]]$y)
      )
    }
  }
}
```

    ## [1] "TimeMins Index:  1 X, Y:  0.5 -0.0356164383561644"
    ## [1] "year Index:  2 X, Y:  -0.0321917808219178 0.5"
    ## [1] "year Index:  7 X, Y:  1.02 1"

``` r
# X Label
gp[['x']][['layout']][['annotations']][[1]]$y = -0.1
# Y Label
gp[['x']][['layout']][['annotations']][[2]]$x = -0.075
# Legend XY
gp[['x']][['layout']][['annotations']][[7]]$x = -0.025
gp[['x']][['layout']][['annotations']][[7]]$y = -0.225
gp
```

<!--html_preserve-->

<div id="htmlwidget-3de6bbe504be08a69277" class="plotly html-widget" style="width:800px;height:600px;">

</div>


<!--/html_preserve-->