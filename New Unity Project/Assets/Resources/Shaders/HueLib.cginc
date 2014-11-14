
half3 shift_col(float3 RGB, float3 shift)
{
	half3 RESULT = half3(RGB);
	half VSU = shift.z*shift.y*cos(shift.x*3.1415/180);
	half VSW = shift.z*shift.y*sin(shift.x*3.1415/180);
	RESULT.x = (.299*shift.z+.701*VSU+.168*VSW)*RGB.x
	 + (.587*shift.z-.587*VSU+.330*VSW)*RGB.y
	 + (.114*shift.z-.114*VSU-.497*VSW)*RGB.z;

	RESULT.y = (.299*shift.z-.299*VSU-.328*VSW)*RGB.x
	 + (.587*shift.z+.413*VSU+.035*VSW)*RGB.y
	 + (.114*shift.z-.114*VSU+.292*VSW)*RGB.z;

	RESULT.z = (.299*shift.z-.3*VSU+1.25*VSW)*RGB.x
	 + (.587*shift.z-.588*VSU-1.05*VSW)*RGB.y
	 + (.114*shift.z+.886*VSU-.203*VSW)*RGB.z;

	return (RESULT);

}