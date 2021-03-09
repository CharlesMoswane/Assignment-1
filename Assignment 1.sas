/*With my submission via email/Efundi, I hereby declare that this assignment is my own 
  original work. I further declare that:
	• No part of it has been copied from another person or source;
	• I didn’t work with another person on the assignment, or assisted fellow students from my own or another university via any channel of communication, or verbally, or in writing;
	• I acknowledge all consulted sources in the text and submitted a bibliography; and
	• Parts without references are my/our own ideas, arguments and conclusions.
  I understand that I may be charged with academic misconduct and/or plagiarism and
  that a disciplinary hearing may be brought against me if this declaration is false.*/

/*Charles Moswane
  25121294
  10 March 2021*/
proc iml;

/*	Density Function*/
	start pdf_gengamma(x) global(a,d,p);

		f = ((p/a**d)*(x**(d-1))*exp(-(x/a)**p))/gamma(d/p);

		return (f);

	finish;

/*	Distribution Function*/
	start cdf_gengamma(x) global(a,d,p);

		interval = 0 || x;
		call quad(f,"pdf_gengamma",interval);

		return f;

	finish;

/*	Quantile Function*/
	start quantile_gengamma(u,lower,upper) global(a,d,p);
	
		n = 1000;
		lo = lower;
		up = upper;
		
		do i = 1 to n;
			c = (up+lo)/2;
			f = cdf_gengamma(c);

			if (f > u) then do;
				up = c;
			end;
			else if(f < u) then do;
				lo = c;
			end;
			else do;
				return c;
			end;

			q = c;
		end;

		return q;

	finish;

	
/*	--------- Main Program ---------*/

	/*	Test 1*/
	print "Test 1";
	a = 3;
	d = 5;
	p = 0.7;
	u = 0.98;
	print a d p u;

	quantile = quantile_gengamma(u,100,130);
	print quantile;

	/*	Test 2*/
	print "Test 2";
	a = 3;
	d = 5;
	p = 0.7;
	u = 0.05;
	print a d p u;

	quantile = quantile_gengamma(u,10,20);
	print quantile;

	/*	Test 3*/
	print "Test 3";
	a = 3;
	d = 0.5;
	p = 5;
	u = 0.98;
	print a d p u;

	quantile = quantile_gengamma(u,1,5);
	print quantile;

	/*	Test 4*/
	print "Test 4";
	a = 3;
	d = 0.5;
	p = 5;
	u = 0.05;
	print a d p u;

	quantile = quantile_gengamma(u,0.001,1);
	print quantile;


quit;