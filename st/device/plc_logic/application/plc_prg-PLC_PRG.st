(* --- Interface --- *)
PROGRAM PLC_PRG
VAR
	joyst1 : SAEJ1939.Joystick;
	joyst1Buttons : ARRAY[1..12] OF Button;
END_VAR
VAR_TEMP
	abButtPressStat : ARRAY[1..12] OF BYTE;
	i : DINT;
END_VAR

(* --- Implementation --- *)
IF SysTimeRtcHighResGet(CANNY.SysTimeRtcHighRes) <> CmpErrors.Errors.ERR_OK THEN
	RETURN;
END_IF

abButtPressStat[1]  := Joyst1Butt1PressStat;
abButtPressStat[2]  := Joyst1Butt2PressStat;
abButtPressStat[3]  := Joyst1Butt3PressStat;
abButtPressStat[4]  := Joyst1Butt4PressStat;
abButtPressStat[5]  := Joyst1Butt5PressStat;
abButtPressStat[6]  := Joyst1Butt6PressStat;
abButtPressStat[7]  := Joyst1Butt7PressStat;
abButtPressStat[8]  := Joyst1Butt8PressStat;
abButtPressStat[9]  := Joyst1Butt9PressStat;
abButtPressStat[10] := Joyst1Butt10PressStat;
abButtPressStat[11] := Joyst1Butt11PressStat;
abButtPressStat[12] := Joyst1Butt12PressStat;
joyst1(
	(* X axis *)
	bXAxisNeutrStat    := Joyst1XAxisNeutrPosStat,
	bXAxisLeverNegStat := Joyst1XAxisLeverLeftNegPosStat,
	bXAxisLeverPosStat := Joyst1XAxisLeverRightPosPosStat,
	rXAxisPos          := Joyst1XAxisPos,
	(* Y axis *)
	bYAxisNeutrStat    := Joyst1YAxisNeutrPosStat,
	bYAxisLeverNegStat := Joyst1YAxisLeverBackNegPosStat,
	bYAxisLeverPosStat := Joyst1YAxisLeverForwPosPosStat,
	rYAxisPos          := Joyst1YAxisPos,
	(* detents *)
	bXAxisDetStat := Joyst1XAxisDetPosStat,
	bYAxisDetStat := Joyst1YAxisDetPosStat,
	(* buttons *)
	abButtPressStat := abButtPressStat);

FOR i := 1 TO 12 DO
	joyst1Buttons[i](IN := joyst1.axButtPress[i]);
END_FOR
