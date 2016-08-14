# Tidy Data

To use the tidy data, simply run the `run_analysis.R` script. After that, you'll have a `tidy.data` variable with the tidy data set and a file named `tidy_data.txt` with it.

It is described as follows:

|Variable               | Description |
|-----------------------|-------------|
|subject.id             | The experiment subject's unique identifier, factor.|
|activity.name          | The name of the activity. It's a factor with 6 levels: LAYING, SITTING, STANDING, WALKING, WALKING_DOWNSTAIRS, WALKING_UPSTAIRS.|
|66 different variables | A float between 0 and 1 with the mean of all observations for that activity and that subject.|

# Steps taken to clean the data

1) Read the subject training and test data, merging it.

2) Read the activity training and test data, merging it.

3) Read the activity observations training and test data, merging them.

4) Read the features file, and select all features that have the "mean()" or "std()" text, using the following regular expression: `"(mean|std)\\(\\)"`

5) From these features, add a 'V' to its ID, so we can match it with the activities dataset.

6) Match and filter data to select only mean and standard deviation features.

7) Name all columns as their respective features, using the following replacements for better reading:

```r
names(selected.data) <- gsub("^t", "Time", names(selected.data))
names(selected.data) <- gsub("^f", "Frequency", names(selected.data))
names(selected.data) <- gsub("Acc", "Accelerometer", names(selected.data))
names(selected.data) <- gsub("Gyro", "Gyroscope", names(selected.data))
names(selected.data) <- gsub("BodyBody", "Body", names(selected.data))
names(selected.data) <- gsub("Mag", "Magnitude", names(selected.data))
names(selected.data) <- gsub("-mean\\(\\)", "Mean", names(selected.data))
names(selected.data) <- gsub("-std\\(\\)", "STD", names(selected.data))
names(selected.data) <- gsub("angle", "Angle", names(selected.data))
names(selected.data) <- gsub("gravity", "Gravity", names(selected.data))
```

8) Group the data by subject.id and activity.name and remove the `activity.id` column.

9) Take the `mean` of the remaining columns.

# Examples on tidy.data

## str(tidy.data)
```
'data.frame':	180 obs. of  68 variables:
 $ subject.id                                 : Factor w/ 30 levels "1","2","3","4",..: 1 1 1 1 1 1 2 2 2 2 ...
 $ activity.name                              : Factor w/ 6 levels "LAYING","SITTING",..: 1 2 3 4 5 6 1 2 3 4 ...
 $ TimeBodyAccelerometerMean-X                : num  0.222 0.261 0.279 0.277 0.289 ...
 $ TimeBodyAccelerometerMean-Y                : num  -0.04051 -0.00131 -0.01614 -0.01738 -0.00992 ...
 $ TimeBodyAccelerometerMean-Z                : num  -0.113 -0.105 -0.111 -0.111 -0.108 ...
 $ TimeBodyAccelerometerSTD-X                 : num  -0.928 -0.977 -0.996 -0.284 0.03 ...
 $ TimeBodyAccelerometerSTD-Y                 : num  -0.8368 -0.9226 -0.9732 0.1145 -0.0319 ...
 $ TimeBodyAccelerometerSTD-Z                 : num  -0.826 -0.94 -0.98 -0.26 -0.23 ...
 $ TimeGravityAccelerometerMean-X             : num  -0.249 0.832 0.943 0.935 0.932 ...
 $ TimeGravityAccelerometerMean-Y             : num  0.706 0.204 -0.273 -0.282 -0.267 ...
 $ TimeGravityAccelerometerMean-Z             : num  0.4458 0.332 0.0135 -0.0681 -0.0621 ...
 $ TimeGravityAccelerometerSTD-X              : num  -0.897 -0.968 -0.994 -0.977 -0.951 ...
 $ TimeGravityAccelerometerSTD-Y              : num  -0.908 -0.936 -0.981 -0.971 -0.937 ...
 $ TimeGravityAccelerometerSTD-Z              : num  -0.852 -0.949 -0.976 -0.948 -0.896 ...
 $ TimeBodyAccelerometerJerkMean-X            : num  0.0811 0.0775 0.0754 0.074 0.0542 ...
 $ TimeBodyAccelerometerJerkMean-Y            : num  0.003838 -0.000619 0.007976 0.028272 0.02965 ...
 $ TimeBodyAccelerometerJerkMean-Z            : num  0.01083 -0.00337 -0.00369 -0.00417 -0.01097 ...
 $ TimeBodyAccelerometerJerkSTD-X             : num  -0.9585 -0.9864 -0.9946 -0.1136 -0.0123 ...
 $ TimeBodyAccelerometerJerkSTD-Y             : num  -0.924 -0.981 -0.986 0.067 -0.102 ...
 $ TimeBodyAccelerometerJerkSTD-Z             : num  -0.955 -0.988 -0.992 -0.503 -0.346 ...
 $ TimeBodyGyroscopeMean-X                    : num  -0.0166 -0.0454 -0.024 -0.0418 -0.0351 ...
 $ TimeBodyGyroscopeMean-Y                    : num  -0.0645 -0.0919 -0.0594 -0.0695 -0.0909 ...
 $ TimeBodyGyroscopeMean-Z                    : num  0.1487 0.0629 0.0748 0.0849 0.0901 ...
 $ TimeBodyGyroscopeSTD-X                     : num  -0.874 -0.977 -0.987 -0.474 -0.458 ...
 $ TimeBodyGyroscopeSTD-Y                     : num  -0.9511 -0.9665 -0.9877 -0.0546 -0.1263 ...
 $ TimeBodyGyroscopeSTD-Z                     : num  -0.908 -0.941 -0.981 -0.344 -0.125 ...
 $ TimeBodyGyroscopeJerkMean-X                : num  -0.1073 -0.0937 -0.0996 -0.09 -0.074 ...
 $ TimeBodyGyroscopeJerkMean-Y                : num  -0.0415 -0.0402 -0.0441 -0.0398 -0.044 ...
 $ TimeBodyGyroscopeJerkMean-Z                : num  -0.0741 -0.0467 -0.049 -0.0461 -0.027 ...
 $ TimeBodyGyroscopeJerkSTD-X                 : num  -0.919 -0.992 -0.993 -0.207 -0.487 ...
 $ TimeBodyGyroscopeJerkSTD-Y                 : num  -0.968 -0.99 -0.995 -0.304 -0.239 ...
 $ TimeBodyGyroscopeJerkSTD-Z                 : num  -0.958 -0.988 -0.992 -0.404 -0.269 ...
 $ TimeBodyAccelerometerMagnitudeMean         : num  -0.8419 -0.9485 -0.9843 -0.137 0.0272 ...
 $ TimeBodyAccelerometerMagnitudeSTD          : num  -0.7951 -0.9271 -0.9819 -0.2197 0.0199 ...
 $ TimeGravityAccelerometerMagnitudeMean      : num  -0.8419 -0.9485 -0.9843 -0.137 0.0272 ...
 $ TimeGravityAccelerometerMagnitudeSTD       : num  -0.7951 -0.9271 -0.9819 -0.2197 0.0199 ...
 $ TimeBodyAccelerometerJerkMagnitudeMean     : num  -0.9544 -0.9874 -0.9924 -0.1414 -0.0894 ...
 $ TimeBodyAccelerometerJerkMagnitudeSTD      : num  -0.9282 -0.9841 -0.9931 -0.0745 -0.0258 ...
 $ TimeBodyGyroscopeMagnitudeMean             : num  -0.8748 -0.9309 -0.9765 -0.161 -0.0757 ...
 $ TimeBodyGyroscopeMagnitudeSTD              : num  -0.819 -0.935 -0.979 -0.187 -0.226 ...
 $ TimeBodyGyroscopeJerkMagnitudeMean         : num  -0.963 -0.992 -0.995 -0.299 -0.295 ...
 $ TimeBodyGyroscopeJerkMagnitudeSTD          : num  -0.936 -0.988 -0.995 -0.325 -0.307 ...
 $ FrequencyBodyAccelerometerMean-X           : num  -0.9391 -0.9796 -0.9952 -0.2028 0.0382 ...
 $ FrequencyBodyAccelerometerMean-Y           : num  -0.86707 -0.94408 -0.97707 0.08971 0.00155 ...
 $ FrequencyBodyAccelerometerMean-Z           : num  -0.883 -0.959 -0.985 -0.332 -0.226 ...
 $ FrequencyBodyAccelerometerSTD-X            : num  -0.9244 -0.9764 -0.996 -0.3191 0.0243 ...
 $ FrequencyBodyAccelerometerSTD-Y            : num  -0.834 -0.917 -0.972 0.056 -0.113 ...
 $ FrequencyBodyAccelerometerSTD-Z            : num  -0.813 -0.934 -0.978 -0.28 -0.298 ...
 $ FrequencyBodyAccelerometerJerkMean-X       : num  -0.9571 -0.9866 -0.9946 -0.1705 -0.0277 ...
 $ FrequencyBodyAccelerometerJerkMean-Y       : num  -0.9225 -0.9816 -0.9854 -0.0352 -0.1287 ...
 $ FrequencyBodyAccelerometerJerkMean-Z       : num  -0.948 -0.986 -0.991 -0.469 -0.288 ...
 $ FrequencyBodyAccelerometerJerkSTD-X        : num  -0.9642 -0.9875 -0.9951 -0.1336 -0.0863 ...
 $ FrequencyBodyAccelerometerJerkSTD-Y        : num  -0.932 -0.983 -0.987 0.107 -0.135 ...
 $ FrequencyBodyAccelerometerJerkSTD-Z        : num  -0.961 -0.988 -0.992 -0.535 -0.402 ...
 $ FrequencyBodyGyroscopeMean-X               : num  -0.85 -0.976 -0.986 -0.339 -0.352 ...
 $ FrequencyBodyGyroscopeMean-Y               : num  -0.9522 -0.9758 -0.989 -0.1031 -0.0557 ...
 $ FrequencyBodyGyroscopeMean-Z               : num  -0.9093 -0.9513 -0.9808 -0.2559 -0.0319 ...
 $ FrequencyBodyGyroscopeSTD-X                : num  -0.882 -0.978 -0.987 -0.517 -0.495 ...
 $ FrequencyBodyGyroscopeSTD-Y                : num  -0.9512 -0.9623 -0.9871 -0.0335 -0.1814 ...
 $ FrequencyBodyGyroscopeSTD-Z                : num  -0.917 -0.944 -0.982 -0.437 -0.238 ...
 $ FrequencyBodyAccelerometerMagnitudeMean    : num  -0.8618 -0.9478 -0.9854 -0.1286 0.0966 ...
 $ FrequencyBodyAccelerometerMagnitudeSTD     : num  -0.798 -0.928 -0.982 -0.398 -0.187 ...
 $ FrequencyBodyAccelerometerJerkMagnitudeMean: num  -0.9333 -0.9853 -0.9925 -0.0571 0.0262 ...
 $ FrequencyBodyAccelerometerJerkMagnitudeSTD : num  -0.922 -0.982 -0.993 -0.103 -0.104 ...
 $ FrequencyBodyGyroscopeMagnitudeMean        : num  -0.862 -0.958 -0.985 -0.199 -0.186 ...
 $ FrequencyBodyGyroscopeMagnitudeSTD         : num  -0.824 -0.932 -0.978 -0.321 -0.398 ...
 $ FrequencyBodyGyroscopeJerkMagnitudeMean    : num  -0.942 -0.99 -0.995 -0.319 -0.282 ...
 $ FrequencyBodyGyroscopeJerkMagnitudeSTD     : num  -0.933 -0.987 -0.995 -0.382 -0.392 ...
```

## summary(tidy.data)
```
   subject.id             activity.name TimeBodyAccelerometerMean-X
 1      :  6   LAYING            :30    Min.   :0.2216             
 2      :  6   SITTING           :30    1st Qu.:0.2712             
 3      :  6   STANDING          :30    Median :0.2770             
 4      :  6   WALKING           :30    Mean   :0.2743             
 5      :  6   WALKING_DOWNSTAIRS:30    3rd Qu.:0.2800             
 6      :  6   WALKING_UPSTAIRS  :30    Max.   :0.3015             
 (Other):144                                                       
 TimeBodyAccelerometerMean-Y TimeBodyAccelerometerMean-Z
 Min.   :-0.040514           Min.   :-0.15251           
 1st Qu.:-0.020022           1st Qu.:-0.11207           
 Median :-0.017262           Median :-0.10819           
 Mean   :-0.017876           Mean   :-0.10916           
 3rd Qu.:-0.014936           3rd Qu.:-0.10443           
 Max.   :-0.001308           Max.   :-0.07538           
                                                        
 TimeBodyAccelerometerSTD-X TimeBodyAccelerometerSTD-Y
 Min.   :-0.9961            Min.   :-0.99024          
 1st Qu.:-0.9799            1st Qu.:-0.94205          
 Median :-0.7526            Median :-0.50897          
 Mean   :-0.5577            Mean   :-0.46046          
 3rd Qu.:-0.1984            3rd Qu.:-0.03077          
 Max.   : 0.6269            Max.   : 0.61694          
                                                      
 TimeBodyAccelerometerSTD-Z TimeGravityAccelerometerMean-X
 Min.   :-0.9877            Min.   :-0.6800               
 1st Qu.:-0.9498            1st Qu.: 0.8376               
 Median :-0.6518            Median : 0.9208               
 Mean   :-0.5756            Mean   : 0.6975               
 3rd Qu.:-0.2306            3rd Qu.: 0.9425               
 Max.   : 0.6090            Max.   : 0.9745               
                                                          
 TimeGravityAccelerometerMean-Y TimeGravityAccelerometerMean-Z
 Min.   :-0.47989               Min.   :-0.49509              
 1st Qu.:-0.23319               1st Qu.:-0.11726              
 Median :-0.12782               Median : 0.02384              
 Mean   :-0.01621               Mean   : 0.07413              
 3rd Qu.: 0.08773               3rd Qu.: 0.14946              
 Max.   : 0.95659               Max.   : 0.95787              
                                                              
 TimeGravityAccelerometerSTD-X TimeGravityAccelerometerSTD-Y
 Min.   :-0.9968               Min.   :-0.9942              
 1st Qu.:-0.9825               1st Qu.:-0.9711              
 Median :-0.9695               Median :-0.9590              
 Mean   :-0.9638               Mean   :-0.9524              
 3rd Qu.:-0.9509               3rd Qu.:-0.9370              
 Max.   :-0.8296               Max.   :-0.6436              
                                                            
 TimeGravityAccelerometerSTD-Z TimeBodyAccelerometerJerkMean-X
 Min.   :-0.9910               Min.   :0.04269                
 1st Qu.:-0.9605               1st Qu.:0.07396                
 Median :-0.9450               Median :0.07640                
 Mean   :-0.9364               Mean   :0.07947                
 3rd Qu.:-0.9180               3rd Qu.:0.08330                
 Max.   :-0.6102               Max.   :0.13019                
                                                              
 TimeBodyAccelerometerJerkMean-Y TimeBodyAccelerometerJerkMean-Z
 Min.   :-0.0386872              Min.   :-0.067458              
 1st Qu.: 0.0004664              1st Qu.:-0.010601              
 Median : 0.0094698              Median :-0.003861              
 Mean   : 0.0075652              Mean   :-0.004953              
 3rd Qu.: 0.0134008              3rd Qu.: 0.001958              
 Max.   : 0.0568186              Max.   : 0.038053              
                                                                
 TimeBodyAccelerometerJerkSTD-X TimeBodyAccelerometerJerkSTD-Y
 Min.   :-0.9946                Min.   :-0.9895               
 1st Qu.:-0.9832                1st Qu.:-0.9724               
 Median :-0.8104                Median :-0.7756               
 Mean   :-0.5949                Mean   :-0.5654               
 3rd Qu.:-0.2233                3rd Qu.:-0.1483               
 Max.   : 0.5443                Max.   : 0.3553               
                                                              
 TimeBodyAccelerometerJerkSTD-Z TimeBodyGyroscopeMean-X TimeBodyGyroscopeMean-Y
 Min.   :-0.99329               Min.   :-0.20578        Min.   :-0.20421       
 1st Qu.:-0.98266               1st Qu.:-0.04712        1st Qu.:-0.08955       
 Median :-0.88366               Median :-0.02871        Median :-0.07318       
 Mean   :-0.73596               Mean   :-0.03244        Mean   :-0.07426       
 3rd Qu.:-0.51212               3rd Qu.:-0.01676        3rd Qu.:-0.06113       
 Max.   : 0.03102               Max.   : 0.19270        Max.   : 0.02747       
                                                                               
 TimeBodyGyroscopeMean-Z TimeBodyGyroscopeSTD-X TimeBodyGyroscopeSTD-Y
 Min.   :-0.07245        Min.   :-0.9943        Min.   :-0.9942       
 1st Qu.: 0.07475        1st Qu.:-0.9735        1st Qu.:-0.9629       
 Median : 0.08512        Median :-0.7890        Median :-0.8017       
 Mean   : 0.08744        Mean   :-0.6916        Mean   :-0.6533       
 3rd Qu.: 0.10177        3rd Qu.:-0.4414        3rd Qu.:-0.4196       
 Max.   : 0.17910        Max.   : 0.2677        Max.   : 0.4765       
                                                                      
 TimeBodyGyroscopeSTD-Z TimeBodyGyroscopeJerkMean-X TimeBodyGyroscopeJerkMean-Y
 Min.   :-0.9855        Min.   :-0.15721            Min.   :-0.07681           
 1st Qu.:-0.9609        1st Qu.:-0.10322            1st Qu.:-0.04552           
 Median :-0.8010        Median :-0.09868            Median :-0.04112           
 Mean   :-0.6164        Mean   :-0.09606            Mean   :-0.04269           
 3rd Qu.:-0.3106        3rd Qu.:-0.09110            3rd Qu.:-0.03842           
 Max.   : 0.5649        Max.   :-0.02209            Max.   :-0.01320           
                                                                               
 TimeBodyGyroscopeJerkMean-Z TimeBodyGyroscopeJerkSTD-X
 Min.   :-0.092500           Min.   :-0.9965           
 1st Qu.:-0.061725           1st Qu.:-0.9800           
 Median :-0.053430           Median :-0.8396           
 Mean   :-0.054802           Mean   :-0.7036           
 3rd Qu.:-0.048985           3rd Qu.:-0.4629           
 Max.   :-0.006941           Max.   : 0.1791           
                                                       
 TimeBodyGyroscopeJerkSTD-Y TimeBodyGyroscopeJerkSTD-Z
 Min.   :-0.9971            Min.   :-0.9954           
 1st Qu.:-0.9832            1st Qu.:-0.9848           
 Median :-0.8942            Median :-0.8610           
 Mean   :-0.7636            Mean   :-0.7096           
 3rd Qu.:-0.5861            3rd Qu.:-0.4741           
 Max.   : 0.2959            Max.   : 0.1932           
                                                      
 TimeBodyAccelerometerMagnitudeMean TimeBodyAccelerometerMagnitudeSTD
 Min.   :-0.9865                    Min.   :-0.9865                  
 1st Qu.:-0.9573                    1st Qu.:-0.9430                  
 Median :-0.4829                    Median :-0.6074                  
 Mean   :-0.4973                    Mean   :-0.5439                  
 3rd Qu.:-0.0919                    3rd Qu.:-0.2090                  
 Max.   : 0.6446                    Max.   : 0.4284                  
                                                                     
 TimeGravityAccelerometerMagnitudeMean TimeGravityAccelerometerMagnitudeSTD
 Min.   :-0.9865                       Min.   :-0.9865                     
 1st Qu.:-0.9573                       1st Qu.:-0.9430                     
 Median :-0.4829                       Median :-0.6074                     
 Mean   :-0.4973                       Mean   :-0.5439                     
 3rd Qu.:-0.0919                       3rd Qu.:-0.2090                     
 Max.   : 0.6446                       Max.   : 0.4284                     
                                                                           
 TimeBodyAccelerometerJerkMagnitudeMean TimeBodyAccelerometerJerkMagnitudeSTD
 Min.   :-0.9928                        Min.   :-0.9946                      
 1st Qu.:-0.9807                        1st Qu.:-0.9765                      
 Median :-0.8168                        Median :-0.8014                      
 Mean   :-0.6079                        Mean   :-0.5842                      
 3rd Qu.:-0.2456                        3rd Qu.:-0.2173                      
 Max.   : 0.4345                        Max.   : 0.4506                      
                                                                             
 TimeBodyGyroscopeMagnitudeMean TimeBodyGyroscopeMagnitudeSTD
 Min.   :-0.9807                Min.   :-0.9814              
 1st Qu.:-0.9461                1st Qu.:-0.9476              
 Median :-0.6551                Median :-0.7420              
 Mean   :-0.5652                Mean   :-0.6304              
 3rd Qu.:-0.2159                3rd Qu.:-0.3602              
 Max.   : 0.4180                Max.   : 0.3000              
                                                             
 TimeBodyGyroscopeJerkMagnitudeMean TimeBodyGyroscopeJerkMagnitudeSTD
 Min.   :-0.99732                   Min.   :-0.9977                  
 1st Qu.:-0.98515                   1st Qu.:-0.9805                  
 Median :-0.86479                   Median :-0.8809                  
 Mean   :-0.73637                   Mean   :-0.7550                  
 3rd Qu.:-0.51186                   3rd Qu.:-0.5767                  
 Max.   : 0.08758                   Max.   : 0.2502                  
                                                                     
 FrequencyBodyAccelerometerMean-X FrequencyBodyAccelerometerMean-Y
 Min.   :-0.9952                  Min.   :-0.98903                
 1st Qu.:-0.9787                  1st Qu.:-0.95361                
 Median :-0.7691                  Median :-0.59498                
 Mean   :-0.5758                  Mean   :-0.48873                
 3rd Qu.:-0.2174                  3rd Qu.:-0.06341                
 Max.   : 0.5370                  Max.   : 0.52419                
                                                                  
 FrequencyBodyAccelerometerMean-Z FrequencyBodyAccelerometerSTD-X
 Min.   :-0.9895                  Min.   :-0.9966                
 1st Qu.:-0.9619                  1st Qu.:-0.9820                
 Median :-0.7236                  Median :-0.7470                
 Mean   :-0.6297                  Mean   :-0.5522                
 3rd Qu.:-0.3183                  3rd Qu.:-0.1966                
 Max.   : 0.2807                  Max.   : 0.6585                
                                                                 
 FrequencyBodyAccelerometerSTD-Y FrequencyBodyAccelerometerSTD-Z
 Min.   :-0.99068                Min.   :-0.9872                
 1st Qu.:-0.94042                1st Qu.:-0.9459                
 Median :-0.51338                Median :-0.6441                
 Mean   :-0.48148                Mean   :-0.5824                
 3rd Qu.:-0.07913                3rd Qu.:-0.2655                
 Max.   : 0.56019                Max.   : 0.6871                
                                                                
 FrequencyBodyAccelerometerJerkMean-X FrequencyBodyAccelerometerJerkMean-Y
 Min.   :-0.9946                      Min.   :-0.9894                     
 1st Qu.:-0.9828                      1st Qu.:-0.9725                     
 Median :-0.8126                      Median :-0.7817                     
 Mean   :-0.6139                      Mean   :-0.5882                     
 3rd Qu.:-0.2820                      3rd Qu.:-0.1963                     
 Max.   : 0.4743                      Max.   : 0.2767                     
                                                                          
 FrequencyBodyAccelerometerJerkMean-Z FrequencyBodyAccelerometerJerkSTD-X
 Min.   :-0.9920                      Min.   :-0.9951                    
 1st Qu.:-0.9796                      1st Qu.:-0.9847                    
 Median :-0.8707                      Median :-0.8254                    
 Mean   :-0.7144                      Mean   :-0.6121                    
 3rd Qu.:-0.4697                      3rd Qu.:-0.2475                    
 Max.   : 0.1578                      Max.   : 0.4768                    
                                                                         
 FrequencyBodyAccelerometerJerkSTD-Y FrequencyBodyAccelerometerJerkSTD-Z
 Min.   :-0.9905                     Min.   :-0.993108                  
 1st Qu.:-0.9737                     1st Qu.:-0.983747                  
 Median :-0.7852                     Median :-0.895121                  
 Mean   :-0.5707                     Mean   :-0.756489                  
 3rd Qu.:-0.1685                     3rd Qu.:-0.543787                  
 Max.   : 0.3498                     Max.   :-0.006236                  
                                                                        
 FrequencyBodyGyroscopeMean-X FrequencyBodyGyroscopeMean-Y
 Min.   :-0.9931              Min.   :-0.9940             
 1st Qu.:-0.9697              1st Qu.:-0.9700             
 Median :-0.7300              Median :-0.8141             
 Mean   :-0.6367              Mean   :-0.6767             
 3rd Qu.:-0.3387              3rd Qu.:-0.4458             
 Max.   : 0.4750              Max.   : 0.3288             
                                                          
 FrequencyBodyGyroscopeMean-Z FrequencyBodyGyroscopeSTD-X
 Min.   :-0.9860              Min.   :-0.9947            
 1st Qu.:-0.9624              1st Qu.:-0.9750            
 Median :-0.7909              Median :-0.8086            
 Mean   :-0.6044              Mean   :-0.7110            
 3rd Qu.:-0.2635              3rd Qu.:-0.4813            
 Max.   : 0.4924              Max.   : 0.1966            
                                                         
 FrequencyBodyGyroscopeSTD-Y FrequencyBodyGyroscopeSTD-Z
 Min.   :-0.9944             Min.   :-0.9867            
 1st Qu.:-0.9602             1st Qu.:-0.9643            
 Median :-0.7964             Median :-0.8224            
 Mean   :-0.6454             Mean   :-0.6577            
 3rd Qu.:-0.4154             3rd Qu.:-0.3916            
 Max.   : 0.6462             Max.   : 0.5225            
                                                        
 FrequencyBodyAccelerometerMagnitudeMean FrequencyBodyAccelerometerMagnitudeSTD
 Min.   :-0.9868                         Min.   :-0.9876                       
 1st Qu.:-0.9560                         1st Qu.:-0.9452                       
 Median :-0.6703                         Median :-0.6513                       
 Mean   :-0.5365                         Mean   :-0.6210                       
 3rd Qu.:-0.1622                         3rd Qu.:-0.3654                       
 Max.   : 0.5866                         Max.   : 0.1787                       
                                                                               
 FrequencyBodyAccelerometerJerkMagnitudeMean
 Min.   :-0.9940                            
 1st Qu.:-0.9770                            
 Median :-0.7940                            
 Mean   :-0.5756                            
 3rd Qu.:-0.1872                            
 Max.   : 0.5384                            
                                            
 FrequencyBodyAccelerometerJerkMagnitudeSTD FrequencyBodyGyroscopeMagnitudeMean
 Min.   :-0.9944                            Min.   :-0.9865                    
 1st Qu.:-0.9752                            1st Qu.:-0.9616                    
 Median :-0.8126                            Median :-0.7657                    
 Mean   :-0.5992                            Mean   :-0.6671                    
 3rd Qu.:-0.2668                            3rd Qu.:-0.4087                    
 Max.   : 0.3163                            Max.   : 0.2040                    
                                                                               
 FrequencyBodyGyroscopeMagnitudeSTD FrequencyBodyGyroscopeJerkMagnitudeMean
 Min.   :-0.9815                    Min.   :-0.9976                        
 1st Qu.:-0.9488                    1st Qu.:-0.9813                        
 Median :-0.7727                    Median :-0.8779                        
 Mean   :-0.6723                    Mean   :-0.7564                        
 3rd Qu.:-0.4277                    3rd Qu.:-0.5831                        
 Max.   : 0.2367                    Max.   : 0.1466                        
                                                                           
 FrequencyBodyGyroscopeJerkMagnitudeSTD
 Min.   :-0.9976                       
 1st Qu.:-0.9802                       
 Median :-0.8941                       
 Mean   :-0.7715                       
 3rd Qu.:-0.6081                       
 Max.   : 0.2878  
```