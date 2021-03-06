
/*
 * Copyright (c) 2008 - 2009 NVIDIA Corporation.  All rights reserved.
 *
 * NVIDIA Corporation and its licensors retain all intellectual property and proprietary
 * rights in and to this software, related documentation and any modifications thereto.
 * Any use, reproduction, disclosure or distribution of this software and related
 * documentation without an express license agreement from NVIDIA Corporation is strictly
 * prohibited.
 *
 * TO THE MAXIMUM EXTENT PERMITTED BY APPLICABLE LAW, THIS SOFTWARE IS PROVIDED *AS IS*
 * AND NVIDIA AND ITS SUPPLIERS DISCLAIM ALL WARRANTIES, EITHER EXPRESS OR IMPLIED,
 * INCLUDING, BUT NOT LIMITED TO, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 * PARTICULAR PURPOSE.  IN NO EVENT SHALL NVIDIA OR ITS SUPPLIERS BE LIABLE FOR ANY
 * SPECIAL, INCIDENTAL, INDIRECT, OR CONSEQUENTIAL DAMAGES WHATSOEVER (INCLUDING, WITHOUT
 * LIMITATION, DAMAGES FOR LOSS OF BUSINESS PROFITS, BUSINESS INTERRUPTION, LOSS OF
 * BUSINESS INFORMATION, OR ANY OTHER PECUNIARY LOSS) ARISING OUT OF THE USE OF OR
 * INABILITY TO USE THIS SOFTWARE, EVEN IF NVIDIA HAS BEEN ADVISED OF THE POSSIBILITY OF
 * SUCH DAMAGES
 */

#include <optix.h>
#include <optixu/optixu_math_namespace.h>

using namespace optix;

//rtTextureSampler<float4, 2>		envmap;

rtDeclareVariable(float3, background_light, , ); // horizon color
rtDeclareVariable(float3, background_dark, , );  // zenith color
rtDeclareVariable(float3, up, , );               // global up vector

rtDeclareVariable(optix::Ray, ray, rtCurrentRay, );

struct PerRayData_radiance
{
  float3 result;
  float  importance;
  int    depth;
};

rtDeclareVariable(PerRayData_radiance, prd_radiance, rtPayload, );

// -----------------------------------------------------------------------------

RT_PROGRAM void miss()
{
  //const float3 result = make_float3(0.3,0.3,0.3);		
  //const float t = max(dot(ray.direction, up), 0.0f);
  //lerp(background_light, background_dark, t);		//-- Original OptiX sample used a gradient background
	
  float theta = atan2f ( ray.direction.x, ray.direction.z );
  float phi = M_PIf * 0.5f - acosf ( ray.direction.y );
  float u = 0.5 + (theta*5 + M_PIf) * (0.5f * M_1_PIf);
  float v = 0.5f * (1.0f + sin(phi));

  //prd_radiance.result = make_float3 ( tex2D(envmap, u, v) );  

  prd_radiance.result = make_float3 ( 0, 0, 1 );
}
