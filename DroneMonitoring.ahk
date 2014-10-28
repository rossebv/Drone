;Run, C:\Program Files (x86)\DJI Product\Ground Station 4.0.10\release\GroundStationVer4.exe
SetTitleMatchMode 2
DetectHiddenText, On

if WinExist("Ground") {
	WinActivate, Ground
    Msgbox, Ready to start recording motor voltage?
}
else {
	Msgbox, Groundstation not seen.
	return
}


WinActive("Ground")
time = %A_now%
date = %A_MMMM% %A_DD%, %A_YYYY%
StartTime := A_TickCount
FileCreateDir, C:\Users\Ross\Documents\GroundStationVoltageMonitor\%date%

while (1)

if WinExist("Ground") {
	WinActive("Ground")
	WinGetText, text
	Loop, parse, text, `n, `r

		IfInString, A_LoopField, motorvoltage
		{
			IfInString, A_LoopField, .
			{
				ElapsedTime := (A_TickCount - StartTime)/1000
				FileAppend, 
				(
				%ElapsedTime% %A_LoopField% %A_Space%
				), C:\Users\Ross\Documents\GroundStationVoltageMonitor\%date%\%time%.txt
			}
		}
	
	;WinGetText, text
	;Loop, parse, text, `n, `r
	;	IfInString, A_LoopField, lati
	;	{
	;		;IfInString, A_LoopField, lati
	;		;{
	;			ElapsedTime := (A_TickCount - StartTime)/1000
	;			FileAppend, 
	;			(
	;			 %A_LoopField% %A_Space%
	;			), C:\Users\Ross\Documents\GroundStationVoltageMonitor\%date%\%time%.txt
	;		;}
	;	}
	;	
	;	WinGetText, text
	;	Loop, parse, text, `n, `r
	;	IfInString, A_LoopField, longi
	;	{
	;		;IfInString, A_LoopField, longi
	;		;{
	;			ElapsedTime := (A_TickCount - StartTime)/1000
	;			FileAppend, 
	;			(
	;			 %A_LoopField% %A_Space%
	;			), C:\Users\Ross\Documents\GroundStationVoltageMonitor\%date%\%time%.txt
	;		;}
	;	}
		
		WinGetText, text
		Loop, parse, text, `n, `r
		IfInString, A_LoopField, altitude
		{
			;IfInString, A_LoopField, (m)
			;{
				ElapsedTime := (A_TickCount - StartTime)/1000
				FileAppend, 
				(
				 %A_LoopField% %A_Space%
				), C:\Users\Ross\Documents\GroundStationVoltageMonitor\%date%\%time%.txt
			;}
		}
		
		WinGetText, text
		Loop, parse, text, `n, `r
		IfInString, A_LoopField, H.Speed
		{
			;IfInString, A_LoopField, (m/s)
			;{
				ElapsedTime := (A_TickCount - StartTime)/1000
				FileAppend, 
				(
				 %A_LoopField% %A_Space%
				), C:\Users\Ross\Documents\GroundStationVoltageMonitor\%date%\%time%.txt
			;}
		}
		
		WinGetText, text
		Loop, parse, text, `n, `r
		IfInString, A_LoopField, V.Speed
		{
			IfInString, A_LoopField, (m/s)
			{
				ElapsedTime := (A_TickCount - StartTime)/1000
				FileAppend, 
				(
				 %A_LoopField%`n
				), C:\Users\Ross\Documents\GroundStationVoltageMonitor\%date%\%time%.txt
			}
		}
		Sleep, 1000
	}
else{
	Msgbox, Groundstation not found - stopping voltage acquisition
	return
}	
