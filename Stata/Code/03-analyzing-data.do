* RRF 2025 - Analyzing Data Template	
*-------------------------------------------------------------------------------	
* Load data
*------------------------------------------------------------------------------- 
	
	*load analysis data 
	use "${data}/Final/TZA_CCT_analysis.dta", clear
	
*-------------------------------------------------------------------------------	
* Exploratory Analysis
*------------------------------------------------------------------------------- 
	
	* Area over treatment by districts 
	gr bar 	area_acre_w, ///
			over(treatment) ///
			by(district)

*-------------------------------------------------------------------------------	
* Final Analysis
*------------------------------------------------------------------------------- 


	* Bar graph by treatment for all districts 
	gr bar 	area_acre_w, ///
			over(treatment) ///
			asy ///
			by(district, rows(1) ///
			title("Area cultivated by treatment") legend(pos(6)) note(" ")) ///
			legend(row(1) order(0 "Assignment:" 1 "Control" 2 "Treatment")) ///
			ytitle("Average area cultivated - acres") ///
			blabel(total, format(%9.1f)) ///
			subtitle(,pos(6) bcolor(none)) 
			
		gr export "$outputs/fig1.png", replace	
	
	* Distribution of non food consumption by female headed hhs with means

	forvalues  hh_head = 0/1 {
		sum nonfood_cons_usd_w if female_head == `hh_head'
		
		local mean_`hh_head' = round(r(mean), 0.1)
		
	} 
	
	
	
	twoway	(kdensity nonfood_cons_usd_w if female == 1, color(navy)) ///
			(kdensity nonfood_cons_usd_w if female == 0, color(dkorange)) ///
			, ///
			xline(`mean_1', lcolor(navy) 	lpattern(dash)) ///
			xline(`mean_0', lcolor(dkorange) 	lpattern(dash)) ///
			xlabel(`mean_1', add) ///
			leg(order(0 "Household Head:" 1 "Female" 2 "Male" ) row(1) pos(6)) ///
			xtitle("Non-food consumption") ///
			ytitle("Density") ///
			title("Distribution of non-food consumption across household heads") 
			///
			note("Dash lines represents the mean by gender of household head")
			
	gr export "$outputs/fig2.png", replace	
	
*-------------------------------------------------------------------------------	
* Summary stats
*------------------------------------------------------------------------------- 

	* defining globals with variables used for summary
	global sumvars 		???
	
	* Summary table - overall and by districts
	eststo all: 	estpost sum ???
	???
	???
	???
	
	
	* Exporting table in csv
	esttab 	??? ///
			using "???", replace ///
			label ///
			????
	
	* Also export in tex for latex
	???
			
			
*-------------------------------------------------------------------------------	
* Balance tables
*------------------------------------------------------------------------------- 	
	
	* Balance (if they purchased cows or not)
	iebaltab 	???, ///
				grpvar(???) ///
				rowvarlabels	///
				format(???)	///
				savecsv(???) ///
				savetex(???) ///
				nonote addnote(???) replace 		

				
*-------------------------------------------------------------------------------	
* Regressions
*------------------------------------------------------------------------------- 				
				
	* Model 1: Regress of food consumption value on treatment
	regress food_cons_usd_w treatment
	regress
	eststo ???		// store regression results
	
	estadd ???
	
	* Model 2: Add controls 
	
	* Model 3: Add clustering by village
	
	* Export results in tex
	esttab 	??? ///
			using "$outputs/???.tex" , ///
			label ///
			b(???) se(???) ///
			nomtitles ///
			mgroup("???", pattern(1 0 0 ) span) ///
			scalars("???") ///
			replace
			
*-------------------------------------------------------------------------------			
* Graphs: Secondary data
*-------------------------------------------------------------------------------			
			
	use "${data}/Final/???.dta", clear
	
	* createa  variable to highlight the districts in sample
	
	* Separate indicators by sample
	
	* Graph bar for number of schools by districts
	gr hbar 	??? ???, ///
				nofill ///
				over(???, sort(???)) ///
				legend(order(0 "???:" 1 "???" 2 "???") row(1)  pos(6)) ///
				ytitle("???") ///
				name(g1, replace)
				
	* Graph bar for number of medical facilities by districts				
	gr hbar 	???
				
	grc1leg2 	???, ///
				row(???) legend(???) ///
				ycommon xcommon ///
				title("???", size(???))
			
	
	gr export "$outputs/fig3.png", replace		

****************************************************************************end!			
