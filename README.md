IS_TOO_NUMERIC - an SQL function that determines if a string is too numeric based on comparison to a threshold. 

  FUNCTION IS_TOO_NUMERIC(@TEST_STR varchar(255), @THRESHOLD decimal(15,4)) RETURNS bit

  @TEST_STR   the string of numeric and non-numeric that will be evaluated.
  @THRESHOLD  The maximum allowed ratio of numeric characters to the entire string length expressed as a decimal number.

  Returns 1 if the string is 'too numeric', i.e. the ration of numeric characters in @TEST_STR to the entire string is greater
  than @THRESHOLD, otherwise, it returns 0. 

  Suppose @TEST_STR = 'TZ901LHMN', a nine-character string with three digits. This string's numeric character ratio 
  is 0.333 because it has three digits and 3/9 is 0.333 rounded to three decimal places. If @THRESHOLD is less than 
  0.333, IS_TOO_NUMERIC returns 1, otherwise it returns 0. 

A customer once wanted to reject alphanumeric strings that had too many digits in them. I don't recall the exact reason, but this
function was the end result. To give as much flexibility as possible, we left it up to the customer to define what they considered 
to be "too numeric" or put another way, this string contains too many digits for its length. 

If a string is considered too numeric when it has a ratio of numeric characters to the overall length greater than say 0.3, then 
set @THRESHOLD to that value and @TEST_STR to whatever string you want to test. What one chooses to do with strings that are too 
numeric is beyond the scope of the function code. All the function code does is let the user define the threshold and test a string 
against it. 
