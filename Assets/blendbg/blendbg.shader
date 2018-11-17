﻿Shader "Hidden/blendbg"
{
	Properties
	{
		[HideInInspector]
		_MainTex ("Texture", 2D) = "white" {}
		bg ("Background", Color) = (0,0,0,1)
		fg ("Foreground", Color) = (1,1,1,1)
		txt ("Text", Color) = (1,1,1,1)
	}
	SubShader
	{
		ZTest Always Cull Off ZWrite Off
		
		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
			};

			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;
				return o;
			}
			
			sampler2D _MainTex;
			fixed4 bg;
			fixed4 fg;
			fixed4 txt;

			fixed4 frag (v2f i) : SV_Target
			{
				fixed4 col = tex2D(_MainTex, i.uv);
				return (1 - col.r)*(fg*col.b + bg*(1-col.b)) + col.r*txt;
			}
			ENDCG
		}
	}
}
