//--------------------------------------------------------------------------------
// Domain warping
// https://www.iquilezles.org/www/articles/warp/warp.htm
//--------------------------------------------------------------------------------
#include "Noise.cginc"

int _DW_NumOctaves;
float _DW_H;
float _DW_Scale;
float _DW_TimeScale;

float fbm(float2 x)
{    
    float G = exp2(-_DW_H);
    float f = _DW_Scale;
    float a = 1.0;
    float t = 0.0;
    float time = _Time.y * _DW_TimeScale;

    for( int i=0; i<_DW_NumOctaves; i++ )
    {
        float noise = snoise(float3(f*x, time));
        t += a*noise;
        f *= 2.0;
        a *= G;
    }
    return t;
}

float domainWarping(float2 p)
{
    float2 offset = float2(7, 1.3) * 10;
    float2 q = float2( fbm(p),
                fbm( p + offset ) );

    float2 r = float2( fbm( p + 2.0*q + float2(1.7,9.2) ),
                fbm( p + 2.0*q + float2(8.3,2.8) ) );

    return fbm( p + 4.0*r );
}