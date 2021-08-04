# EVT_analysis
Returns of various financial assets are analysed using the techniques of Extreme Value Theory and using fat-tailed distributions using R in Jupyter Notebook.
Here I also post the pictures which could not be rendered properly in the notebook.

**Apple excess distribution and the fitted power law**
![000003 (1)](https://user-images.githubusercontent.com/87700777/128239663-967f7876-d2cd-4c47-a1da-d669aab233bc.png)
The excess distribution seems to fit the data nicely.

**Apple survival function and the fitted power law**
![000003 (2)](https://user-images.githubusercontent.com/87700777/128239891-987320ef-306d-42b8-b7a7-5f68082d6365.png)
The tail is also fitted nicely. Notice that now we are able to capture the observation in the very tail (corresponding to the loss of 20%)

**Residuals of the fit of power law to Apple lossess**
![000003 (3)](https://user-images.githubusercontent.com/87700777/128240032-16524213-5100-403f-9289-a6e19a313b93.png)
The residuals in the scatterplot seem to be pretty random and don't show any pattern which is a sign of a good fit.

**QQ-plot of the residuals**
![000003 (4)](https://user-images.githubusercontent.com/87700777/128240124-a8b76006-cffd-4344-b1fc-3b04d43e7203.png)
They are pretty well fitted to the thin-tailed exponential distribution which means that we were able to explain much of the "fattness of the tail"
