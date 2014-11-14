Shader "Sprites/HSVShader" {
 
     Properties {
 
         _MainTex ("Texture", 2D) = "white" {}
 
         _MatchColor("MatchColor", Color ) = (0,0,0,0)
         
         _MatchError("MatchError", Float ) = 0.01
         
         _HueShift("HueShift", Range(0,359) ) = 0
 
         _Sat("Saturation", Range(0,1)) = 1
 
         _Val("Value", Range(0,1)) = 1
         
         _Alpha ("Alpha", Range(0,1)) = 1
 
     }
 
     SubShader {
 
  
 
         Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType" = "Transparent" }
 
         ZWrite Off
 
         Blend SrcAlpha OneMinusSrcAlpha
 
         Cull Off
 
  
 
         Pass
         {
 
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "HueLib.cginc"
 
			uniform sampler2D _MainTex;
			uniform float _HueShift;
			uniform float _Sat;
			uniform float _Val;
			uniform float _Alpha;
			uniform float4 _MainTex_ST;
			uniform half3 _MatchColor;
			uniform half _MatchError;
            
            struct appdata_base
            {
                float4 vertex : POSITION;
                float2 texcoord : TEXCOORD0; 
            };
            
			struct v2f 
			{
				float4  pos : SV_POSITION;
				float2  uv : TEXCOORD0;
			};

			v2f vert (appdata_base v)
			{
				v2f o;
				o.pos = mul (UNITY_MATRIX_MVP, v.vertex);
				o.uv = v.texcoord;
				return o;
			}

			half4 frag(v2f i) : COLOR
			{
				half4 col = tex2D(_MainTex, i.uv);
				half3 s = col - _MatchColor;
				s.r = abs(s.r);
				s.g = abs(s.g);
				s.b = abs(s.b);
				if(s.r < _MatchError && s.g < _MatchError && s.b < _MatchError)
				{
					float3 shift = float3(_HueShift, _Sat, _Val);
					return half4(half3(shift_col(col, shift)), col.a * _Alpha);
				}else
				{
					col.a = col.a * _Alpha;
					return col;
				}
			}
 
             ENDCG
 
         }
 
     }
 
     Fallback "Particles/Alpha Blended"
 
 }