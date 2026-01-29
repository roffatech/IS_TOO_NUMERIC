DROP FUNCTION IF EXISTS IS_TOO_NUMERIC
GO

CREATE FUNCTION IS_TOO_NUMERIC
(
	@TESTSTR varchar(255),
	@THRESHOLD decimal(15,4)
)

RETURNS bit
AS
BEGIN
	DECLARE
		@STRLEN int,
		@NUMLEN int,
		@BITRES bit,
		@RATIO decimal(15,4)

	SELECT @STRLEN = LEN(@TESTSTR)

	IF @STRLEN = 0 
		-- If we have a zero-length string passed in, we get division by zero
		-- so this condition avoids that
		SET @BITRES = 0
	ELSE 
		BEGIN
			-- We need to know the number of digits in TESTSTR
			-- The next line of code compares TESTSTR to a string that is 
			-- the result of converting all the digits to a hashtag character '#'.
			--
			-- Example:
			-- The TRANSLATE function with a TESTSTR of '1A2345ER' becomes '#A####ER'
			-- the REPLACE function with '#A####ER' becomes 'AER'
			-- NUMLEN then becomes LEN('1A2345ER') - LEN('AER') = 5
			SELECT @NUMLEN = LEN(@TESTSTR) - LEN(REPLACE(TRANSLATE(@TESTSTR, '0123456789', '##########'), '#', '')) 

	
			SELECT @RATIO = CONVERT(decimal(15,4), @NUMLEN) / CONVERT(decimal(15,4), @STRLEN)

			IF @RATIO > @THRESHOLD 
				SET @BITRES = 1
			ELSE
				SET @BITRES = 0
		END

	RETURN @BITRES
END 
