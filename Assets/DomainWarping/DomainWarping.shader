Shader "Custom/DomainWarping"
{
    Properties
    {
        _UVScale("UVScale", float) = 1
        _DW_NumOctaves("NumOCtaves", Int) = 4
        _DW_H("H", float) = 1
        _DW_Scale("Scale", float) = 1
        _DW_TimeScale("TimeScale", float) = 0.1
    }

    SubShader
    {
        // No culling or depth
        Cull Off ZWrite Off ZTest Always
        Blend One Zero

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"
            #include "DomainWarping.cginc"

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            v2f vert (appdata_img v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.texcoord;
                return o;
            }

            float _UVScale;

            fixed4 frag (v2f i) : SV_Target
            {
                //return fixed4(1,0,0,1);
                //return fbm(i.uv, _H);
                float f = 0.5 + 0.5 * domainWarping(i.uv * _UVScale);
                return f;
            }
            ENDCG
        }
    }
}
