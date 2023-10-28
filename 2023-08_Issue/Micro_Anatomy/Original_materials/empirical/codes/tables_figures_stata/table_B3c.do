**********************************************************************
* Guntin, Ottonello and Perez (2022)
* Code replicates Table B3 - panel c
**********************************************************************


cls
clear all
set mem 200m
set more off

global database = "$user/working_data"
global output   = "$user/output"
global input    = "$user/input"

grstyle clear
grstyle init
grstyle set plain, horizontal grid  

 **********************************************
 ****** Table B3 panel - Average of logs ******
 **********************************************
 
** ITALY
 
* Data by decile

u "$database/resid_ITA.dta", clear

tempfile sample_data
save `sample_data', replace

local year = "2006 2014" 
gen decile = .
foreach x of local year {
fastxtile decile_`x' = uy if year == `x' [fw=freqwt] , nq(20)
replace decile = decile_`x' if year == `x'
drop decile_`x'
}

replace uy = ln(uy)
replace uc = ln(uc)

collapse(mean) uc uy  [fw=freqwt], by(year decile)

xtset decile year

gen g_uy = uy - L8.uy
gen g_uc = uc - L8.uc

gen elast = g_uc/g_uy

keep if year == 2014

keep elast g_uy g_uc decile year

keep if decile == 20
drop decile

gen categ = "top5"

tempfile top5
save `top5', replace

u `sample_data', clear

local year = "2006 2014" 
gen decile = .
foreach x of local year {
fastxtile decile_`x' = uy if year == `x' [fw=freqwt] , nq(10)
replace decile = decile_`x' if year == `x'
drop decile_`x'
}

replace uy = ln(uy)
replace uc = ln(uc)

collapse(mean) uc uy  [fw=freqwt], by(year decile)

xtset decile year

gen g_uy = uy - L8.uy
gen g_uc = uc - L8.uc

gen elast = g_uc/g_uy

keep if year == 2014

keep elast g_uy g_uc decile year

keep if decile == 10
drop decile

gen categ = "top"

tempfile top
save `top', replace

u `sample_data', clear

local year = "2006 2014" 
gen decile = .
foreach x of local year {
fastxtile decile_`x' = uy if year == `x' [fw=freqwt] , nq(5)
replace decile = decile_`x' if year == `x'
drop decile_`x'
}

replace uy = ln(uy)
replace uc = ln(uc)

collapse(mean) uc uy  [fw=freqwt], by(year decile)

xtset decile year

gen g_uy = uy - L8.uy
gen g_uc = uc - L8.uc

gen elast = g_uc/g_uy

keep if year == 2014

keep elast g_uy g_uc decile year

keep if decile == 5
drop decile

gen categ = "top20"

tempfile top20
save `top20', replace


u `sample_data', clear

replace uy = ln(uy)
replace uc = ln(uc)

collapse(mean) uc uy  [fw=freqwt], by(year)

tsset year

gen g_uy = uy - L8.uy
gen g_uc = uc - L8.uc

gen elast = g_uc/g_uy

keep if year == 2014

keep elast g_uy g_uc year

gen categ = "all"

append using `top20'
append using `top'
append using `top5'

drop year
gen episode = "Italy"

tempfile ITA
save `ITA', replace

** SPAIN

* Deciles data

u "$database/resid_SPA.dta", clear

tempfile sample_data
save `sample_data', replace

local year = "2008 2013" 
gen decile = .
foreach x of local year {
fastxtile decile_`x' = uy if year == `x' [fw=freqwt] , nq(20)
replace decile = decile_`x' if year == `x'
drop decile_`x'
}


replace uy = ln(uy)
replace uc = ln(uc)

collapse(mean) uc uy  [fw=freqwt], by(year decile)

xtset decile year

gen g_uy = uy - L5.uy
gen g_uc = uc - L5.uc

gen elast = g_uc/g_uy

keep if year == 2013

keep elast g_uy g_uc decile year

keep if decile == 20
drop decile

gen categ = "top5"

tempfile top5
save `top5', replace

u `sample_data', clear

local year = "2008 2013" 
gen decile = .
foreach x of local year {
fastxtile decile_`x' = uy if year == `x' [fw=freqwt] , nq(10)
replace decile = decile_`x' if year == `x'
drop decile_`x'
}

replace uy = ln(uy)
replace uc = ln(uc)

collapse(mean) uc uy  [fw=freqwt], by(year decile)

xtset decile year

gen g_uy = uy - L5.uy
gen g_uc = uc - L5.uc

gen elast = g_uc/g_uy

keep if year == 2013

keep elast g_uy g_uc decile year

keep if decile == 10
drop decile

gen categ = "top"

tempfile top
save `top', replace

u `sample_data', clear

local year = "2008 2013" 
gen decile = .
foreach x of local year {
fastxtile decile_`x' = uy if year == `x' [fw=freqwt] , nq(5)
replace decile = decile_`x' if year == `x'
drop decile_`x'
}

replace uy = ln(uy)
replace uc = ln(uc)

collapse(mean) uc uy  [fw=freqwt], by(year decile)

xtset decile year

gen g_uy = uy - L5.uy
gen g_uc = uc - L5.uc

gen elast = g_uc/g_uy

keep if year == 2013

keep elast g_uy g_uc decile year

keep if decile == 5
drop decile

gen categ = "top20"

tempfile top20
save `top20', replace


u `sample_data', clear

replace uy = ln(uy)
replace uc = ln(uc)

collapse(mean) uc uy  [fw=freqwt], by(year)

tsset year

gen g_uy = uy - L5.uy
gen g_uc = uc - L5.uc

gen elast = g_uc/g_uy

keep if year == 2013

keep elast g_uy g_uc year

gen categ = "all"

append using `top20'
append using `top'
append using `top5'

drop year
gen episode = "Spain"

tempfile SPA
save `SPA', replace

** MEX

* Deciles data

u "$database/resid_MEX.dta", clear

tempfile sample_data
save `sample_data', replace

local year = "1994 1996 2006 2010" 
gen decile = .
foreach x of local year {
fastxtile decile_`x' = uy if year == `x' [fw=freqwt] , nq(20)
replace decile = decile_`x' if year == `x'
drop decile_`x'
}

replace uy = ln(uy)
replace uc = ln(uc)

collapse(mean) uc uy  [fw=freqwt], by(year decile)

xtset decile year

gen g_uy = uy - L2.uy
gen g_uc = uc - L2.uc

gen elast = g_uc/g_uy

gen g_uy2 = uy - L4.uy
gen g_uc2 = uc - L4.uc

gen elast2 = g_uc2/g_uy2

keep if year == 1996 | year == 2010

replace elast = elast2 if year == 2010
replace g_uc = g_uc2 if year == 2010
replace g_uy = g_uy2 if year == 2010
keep elast g_uc g_uy decile year

keep if decile == 20
gen episode = "Mexico - Tequila" if year == 1996
replace episode = "Mexico - GFC" if year == 2010
drop year

drop decile

gen categ = "top5"

tempfile top5
save `top5', replace

u `sample_data', clear

local year = "1994 1996 2006 2010" 
gen decile = .
foreach x of local year {
fastxtile decile_`x' = uy if year == `x' [fw=freqwt] , nq(10)
replace decile = decile_`x' if year == `x'
drop decile_`x'
}

replace uy = ln(uy)
replace uc = ln(uc)

collapse(mean) uc uy  [fw=freqwt], by(year decile)

xtset decile year

gen g_uy = uy - L2.uy
gen g_uc = uc - L2.uc

gen elast = g_uc/g_uy

gen g_uy2 = uy - L4.uy
gen g_uc2 = uc - L4.uc

gen elast2 = g_uc2/g_uy2

keep if year == 1996 | year == 2010

replace elast = elast2 if year == 2010
replace g_uc = g_uc2 if year == 2010
replace g_uy = g_uy2 if year == 2010
keep elast g_uc g_uy decile year

keep if decile == 10
gen episode = "Mexico - Tequila" if year == 1996
replace episode = "Mexico - GFC" if year == 2010
drop year

drop decile

gen categ = "top"

tempfile top
save `top', replace

u `sample_data', clear

local year = "1994 1996 2006 2010" 
gen decile = .
foreach x of local year {
fastxtile decile_`x' = uy if year == `x' [fw=freqwt] , nq(5)
replace decile = decile_`x' if year == `x'
drop decile_`x'
}

replace uy = ln(uy)
replace uc = ln(uc)

collapse(mean) uc uy  [fw=freqwt], by(year decile)

xtset decile year

gen g_uy = uy - L2.uy
gen g_uc = uc - L2.uc

gen elast = g_uc/g_uy

gen g_uy2 = uy - L4.uy
gen g_uc2 = uc - L4.uc

gen elast2 = g_uc2/g_uy2

keep if year == 1996 | year == 2010

replace elast = elast2 if year == 2010
replace g_uc = g_uc2 if year == 2010
replace g_uy = g_uy2 if year == 2010
keep elast g_uc g_uy decile year

keep if decile == 5
gen episode = "Mexico - Tequila" if year == 1996
replace episode = "Mexico - GFC" if year == 2010
drop year

drop decile

gen categ = "top20"

tempfile top20
save `top20', replace

u `sample_data', clear

replace uy = ln(uy)
replace uc = ln(uc)

collapse(mean) uc uy  [fw=freqwt], by(year)

tsset year

gen g_uy = uy - L2.uy
gen g_uc = uc - L2.uc

gen elast = g_uc/g_uy

gen g_uy2 = uy - L4.uy
gen g_uc2 = uc - L4.uc

gen elast2 = g_uc2/g_uy2

keep if year == 1996 | year == 2010

replace elast = elast2 if year == 2010
replace g_uc = g_uc2 if year == 2010
replace g_uy = g_uy2 if year == 2010
keep elast g_uc g_uy year

gen episode = "Mexico - Tequila" if year == 1996
replace episode = "Mexico - GFC" if year == 2010
drop year

gen categ = "all"

append using `top20'
append using `top'
append using `top5'

tempfile MEX
save `MEX', replace

*** PER 

* Deciles data

u "$database/resid_PER.dta", clear

tempfile sample_data
save `sample_data', replace

local year = "2007 2010" 
gen decile = .
foreach x of local year {
fastxtile decile_`x' = uy if year == `x' [fw=freqwt] , nq(20)
replace decile = decile_`x' if year == `x'
drop decile_`x'
}

replace uy = ln(uy)
replace uc = ln(uc)

collapse(mean) uc uy  [fw=freqwt], by(year decile)

xtset decile year

gen g_uy = uy - L3.uy
gen g_uc = uc - L3.uc

gen elast = g_uc/g_uy

keep if year == 2010

keep elast g_uy g_uc decile year

keep if decile == 20
gen episode = "Peru"
drop year

drop decile

gen categ = "top5"

tempfile top5
save `top5', replace

u `sample_data', clear

local year = "2007 2010" 
gen decile = .
foreach x of local year {
fastxtile decile_`x' = uy if year == `x' [fw=freqwt] , nq(10)
replace decile = decile_`x' if year == `x'
drop decile_`x'
}

replace uy = ln(uy)
replace uc = ln(uc)

collapse(mean) uc uy  [fw=freqwt], by(year decile)

xtset decile year

gen g_uy = uy - L3.uy
gen g_uc = uc - L3.uc

gen elast = g_uc/g_uy

keep if year == 2010

keep elast g_uy g_uc decile year

keep if decile == 10
gen episode = "Peru"
drop year

drop decile

gen categ = "top"

tempfile top
save `top', replace

u `sample_data', clear

local year = "2007 2010" 
gen decile = .
foreach x of local year {
fastxtile decile_`x' = uy if year == `x' [fw=freqwt] , nq(5)
replace decile = decile_`x' if year == `x'
drop decile_`x'
}

replace uy = ln(uy)
replace uc = ln(uc)

collapse(mean) uc uy  [fw=freqwt], by(year decile)

xtset decile year

gen g_uy = uy - L3.uy
gen g_uc = uc - L3.uc

gen elast = g_uc/g_uy

keep if year == 2010

keep elast g_uy g_uc decile year

keep if decile == 5
gen episode = "Peru"
drop year

drop decile

gen categ = "top20"

tempfile top20
save `top20', replace


u `sample_data', clear

replace uy = ln(uy)
replace uc = ln(uc)

collapse(mean) uc uy  [fw=freqwt], by(year)

tsset year

gen g_uy = uy - L3.uy
gen g_uc = uc - L3.uc

gen elast = g_uc/g_uy

keep if year == 2010

keep elast g_uc g_uy year

gen episode = "Peru"
drop year

gen categ = "all"

append using `top20'
append using `top'
append using `top5'

tempfile PER
save `PER', replace

*** TABLE C - AVERAGE OF LOGS

append using `MEX'
append using `SPA'
append using `ITA'

sum g_uy if categ == "all"
local g_uy_all_mean = r(mean)
sum g_uy if categ == "top20"
local g_uy_top20_mean = r(mean)
sum g_uy if categ == "top"
local g_uy_top_mean = r(mean)
sum g_uy if categ == "top5"
local g_uy_top5_mean = r(mean)

sum g_uc if categ == "all"
local g_uc_all_mean = r(mean)
sum g_uc if categ == "top20"
local g_uc_top20_mean = r(mean)
sum g_uc if categ == "top"
local g_uc_top_mean = r(mean)
sum g_uc if categ == "top5"
local g_uc_top5_mean = r(mean)

sum elast if categ == "all"
local elast_all_mean = r(mean)
sum elast if categ == "top20"
local elast_top20_mean = r(mean)
sum elast if categ == "top"
local elast_top_mean = r(mean)
sum elast if categ == "top5"
local elast_top5_mean = r(mean)

** latex preamble

if _N<500 set obs 500

forval i = 0/10 {
gen tc`i' = ""
}
gen tcEnd = "\\"
local row = 0

local ++row
replace tc1 = "& \multirow{3}{*}{$\Delta \log Y$}\hspace*{.5em}" in `row'
replace tc2 = "& Average" in `row'
replace tc3 = " & " + string(g_uy[17],"%9.2f") in `row'
replace tc4 = " & " + string(g_uy[13],"%9.2f") in `row'
replace tc5 = "& \hspace{.5em}"  in `row'
replace tc6 = " & " + string(g_uy[5],"%9.2f") in `row'
replace tc7 = " & " + string(g_uy[6],"%9.2f") in `row'
replace tc8 = " & " + string(g_uy[1],"%9.2f") in `row'
replace tc9 = " & " in `row'
replace tc10 = " & " + string(`g_uy_all_mean',"%9.2f") in `row'


local ++row
replace tc1 = "& " in `row'
replace tc2 = "& Top 20-income" in `row'
replace tc3 = " & " + string(g_uy[18],"%9.2f") in `row'
replace tc4 = " & " + string(g_uy[14],"%9.2f") in `row'
replace tc5 = "& \hspace{.5em}"  in `row'
replace tc6 = " & " + string(g_uy[7],"%9.2f") in `row'
replace tc7 = " & " + string(g_uy[8],"%9.2f") in `row'
replace tc8 = " & " + string(g_uy[2],"%9.2f") in `row'
replace tc9 = " & " in `row'
replace tc10 = " & " + string(`g_uy_top20_mean',"%9.2f") in `row'

local ++row
replace tc1 = "& " in `row'
replace tc2 = "& Top 10-income" in `row'
replace tc3 = " & " + string(g_uy[19],"%9.2f") in `row'
replace tc4 = " & " + string(g_uy[15],"%9.2f") in `row'
replace tc5 = "& \hspace{.5em}"  in `row'
replace tc6 = " & " + string(g_uy[9],"%9.2f") in `row'
replace tc7 = " & " + string(g_uy[10],"%9.2f") in `row'
replace tc8 = " & " + string(g_uy[3],"%9.2f") in `row'
replace tc9 = " & " in `row'
replace tc10 = " & " + string(`g_uy_top_mean',"%9.2f") in `row'

local ++row
replace tc1 = "& " in `row'
replace tc2 = "& Top 5-income" in `row'
replace tc3 = " & " + string(g_uy[20],"%9.2f") in `row'
replace tc4 = " & " + string(g_uy[16],"%9.2f") in `row'
replace tc5 = "& \hspace{.5em}"  in `row'
replace tc6 = " & " + string(g_uy[11],"%9.2f") in `row'
replace tc7 = " & " + string(g_uy[12],"%9.2f") in `row'
replace tc8 = " & " + string(g_uy[4],"%9.2f") in `row'
replace tc9 = " & " in `row'
replace tc10 = " & " + string(`g_uy_top5_mean',"%9.2f") + "& \hspace{-1em} \vspace{.5em}" in `row'

local ++row
replace tc1 = "& \multirow{3}{*}{$\Delta \log C$}\hspace*{.5em}" in `row'
replace tc2 = "& Average" in `row'
replace tc3 = " & " + string(g_uc[17],"%9.2f") in `row'
replace tc4 = " & " + string(g_uc[13],"%9.2f") in `row'
replace tc5 = "& \hspace{.5em}"  in `row'
replace tc6 = " & " + string(g_uc[5],"%9.2f") in `row'
replace tc7 = " & " + string(g_uc[6],"%9.2f") in `row'
replace tc8 = " & " + string(g_uc[1],"%9.2f") in `row'
replace tc9 = " & " in `row'
replace tc10 = " & " + string(`g_uc_all_mean',"%9.2f") in `row'

local ++row
replace tc1 = "& " in `row'
replace tc2 = "& Top 20-income" in `row'
replace tc3 = " & " + string(g_uc[18],"%9.2f") in `row'
replace tc4 = " & " + string(g_uc[14],"%9.2f") in `row'
replace tc5 = "& \hspace{.5em}"  in `row'
replace tc6 = " & " + string(g_uc[7],"%9.2f") in `row'
replace tc7 = " & " + string(g_uc[8],"%9.2f") in `row'
replace tc8 = " & " + string(g_uc[2],"%9.2f") in `row'
replace tc9 = " & " in `row'
replace tc10 = " & " + string(`g_uc_top20_mean',"%9.2f") in `row'

local ++row
replace tc1 = "& " in `row'
replace tc2 = "& Top 10-income" in `row'
replace tc3 = " & " + string(g_uc[19],"%9.2f") in `row'
replace tc4 = " & " + string(g_uc[15],"%9.2f") in `row'
replace tc5 = "& \hspace{.5em}"  in `row'
replace tc6 = " & " + string(g_uc[9],"%9.2f") in `row'
replace tc7 = " & " + string(g_uc[10],"%9.2f") in `row'
replace tc8 = " & " + string(g_uc[3],"%9.2f") in `row'
replace tc9 = " & " in `row'
replace tc10 = " & " + string(`g_uc_top_mean',"%9.2f") in `row'

local ++row
replace tc1 = "& " in `row'
replace tc2 = "& Top 5-income" in `row'
replace tc3 = " & " + string(g_uc[20],"%9.2f") in `row'
replace tc4 = " & " + string(g_uc[16],"%9.2f") in `row'
replace tc5 = "& \hspace{.5em}"  in `row'
replace tc6 = " & " + string(g_uc[11],"%9.2f") in `row'
replace tc7 = " & " + string(g_uc[12],"%9.2f") in `row'
replace tc8 = " & " + string(g_uc[4],"%9.2f") in `row'
replace tc9 = " & " in `row'
replace tc10 = " & " + string(`g_uc_top5_mean',"%9.2f") + "& \hspace{-1em} \vspace{.5em}" in `row'

local ++row
replace tc1 = "& \multirow{3}{*}{Elasticity}\hspace*{.5em}" in `row'
replace tc2 = "& Average" in `row'
replace tc3 = " & " + string(elast[17],"%9.2f") in `row'
replace tc4 = " & " + string(elast[13],"%9.2f") in `row'
replace tc5 = "& \hspace{.5em}"  in `row'
replace tc6 = " & " + string(elast[5],"%9.2f") in `row'
replace tc7 = " & " + string(elast[6],"%9.2f") in `row'
replace tc8 = " & " + string(elast[1],"%9.2f") in `row'
replace tc9 = " & " in `row'
replace tc10 = " & " + string(`elast_all_mean',"%9.2f") in `row'

local ++row
replace tc1 = "& " in `row'
replace tc2 = "& Top 20-income" in `row'
replace tc3 = " & " + string(elast[18],"%9.2f") in `row'
replace tc4 = " & " + string(elast[14],"%9.2f") in `row'
replace tc5 = "& \hspace{.5em}"  in `row'
replace tc6 = " & " + string(elast[7],"%9.2f") in `row'
replace tc7 = " & " + string(elast[8],"%9.2f") in `row'
replace tc8 = " & " + string(elast[2],"%9.2f") in `row'
replace tc9 = " & " in `row'
replace tc10 = " & " + string(`elast_top20_mean',"%9.2f") in `row'

local ++row
replace tc1 = "& " in `row'
replace tc2 = "& Top 10-income" in `row'
replace tc3 = " & " + string(elast[19],"%9.2f") in `row'
replace tc4 = " & " + string(elast[15],"%9.2f") in `row'
replace tc5 = "& \hspace{.5em}"  in `row'
replace tc6 = " & " + string(elast[9],"%9.2f") in `row'
replace tc7 = " & " + string(elast[10],"%9.2f") in `row'
replace tc8 = " & " + string(elast[3],"%9.2f") in `row'
replace tc9 = " & " in `row'
replace tc10 = " & " + string(`elast_top_mean',"%9.2f") in `row'

local ++row
replace tc1 = "& " in `row'
replace tc2 = "& Top 5-income" in `row'
replace tc3 = " & " + string(elast[20],"%9.2f") in `row'
replace tc4 = " & " + string(elast[16],"%9.2f") in `row'
replace tc5 = "& \hspace{.5em}"  in `row'
replace tc6 = " & " + string(elast[11],"%9.2f") in `row'
replace tc7 = " & " + string(elast[12],"%9.2f") in `row'
replace tc8 = " & " + string(elast[4],"%9.2f") in `row'
replace tc9 = " & " in `row'
replace tc10 = " & " + string(`elast_top5_mean',"%9.2f") + "& \hspace{-1em} \vspace{.5em}" in `row'

outsheet tc* in 1/`row' using "$output/tableB3_c.tex", noquote nonames delimit(" ") replace
