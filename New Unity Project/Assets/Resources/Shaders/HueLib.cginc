﻿
half3 shift_col(float3 RGB, float3 shift)
{
	half3 RESULT = half3(RGB);
	half VSU = shift.z*shift.y*cos(shift.x*0.0174527); // 0.01745 ~ pi / 180
	half VSW = shift.z*shift.y*sin(shift.x*0.0174527);
	half temp_za = .299*shift.z;
	half temp_zb = .587*shift.z;
	half temp_zc = .114*shift.z;
	RESULT.x = (temp_za+.701*VSU+.168*VSW)*RGB.x
	 + (temp_zb-.587*VSU+.330*VSW)*RGB.y
	 + (temp_zc-.114*VSU-.497*VSW)*RGB.z;

	RESULT.y = (temp_za-.299*VSU-.328*VSW)*RGB.x
	 + (temp_zb+.413*VSU+.035*VSW)*RGB.y
	 + (.114*shift.z-.114*VSU+.292*VSW)*RGB.z;

	RESULT.z = (temp_za-.3*VSU+1.25*VSW)*RGB.x
	 + (temp_zb-.588*VSU-1.05*VSW)*RGB.y
	 + (temp_zc+.886*VSU-.203*VSW)*RGB.z;

	return (RESULT);

}