﻿Shader "Lesson/Bump/Fog/Albedo" //Shader Component menu name if we click on 
//Shader > Lesson > Bump we will find the shader named Albedo
//shader is written in 2 languages 
//HLSL - high level shader language - input
//Cg - C for graphics - output
// base of the shader is written in HLSL
//and the body is Cg
{
	Properties
		//Properties 
		//is written in HLSL
		//it does not end with a ;
		//this is also your inspector variables
		//and the input of data into the script 
	{
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		//our variable is called _MainTex
		//our Display name in the inspector is Albedo (RGB)
		//it is a 2D variable type, meaning it is an image
		//default colour if we have no image
		_BumpMap("Normal Map", 2D) = "bump" {}
		//Input the bump map is still an image
		//"bump" - tells the program this needs to be a normal map
		_FogColour("Fog Colour", Color) = (0,0,0,1) // R,G,B,A
	}
	SubShader //you can have multiple sub shaders
		//sub shaders are written in HLSL
		//but have Cg contained as the body
		//the multiple shaders allow you to render different levels of detail
		//they run at different GPU levels in a platform
	{
		Tags // reference to the type of rendering 
		{ 
			"RenderType"="Opaque" 
		}
		LOD 200 // this is the Level of Detail
		/////////////
		CGPROGRAM	//THIS IS WHERE Cg Code starts
	   /////////////
		#pragma surface mainColour Lambert finalcolor:myColour vertex:myVertex
		/*
		this tells us that the surface of our model
		is affected by the mainColour Function
		the material type is Lambert
		meaning the material is flat and has no highlights
		*/
		sampler2D _MainTex;
		//this is the 2D texture variable in Cg 
		sampler2D _BumpMap;
		fixed4 _FogColour;

		struct Input //allows us to get the UV map of our model
		{
			float2 uv_MainTex;
			//uv maps are Vector2's X and Y
			//because Vector 2 has 2 input numbers we are using a float2 which gives us 2 floats
			//maps our texture map to the uv map
			//makes sure each pixel is in the right place
			float2 uv_BumpMap;
			half fog;
		};

		void myVertex(inout appdata_full v, out Input data)
		{
			UNITY_INITIALIZE_OUTPUT(Input, data);
			float4 hpos = mul(UNITY_MATRIX_MVP, v.vertex);
			data.fog = min(1, dot(hpos.xy, hpos.xy)*0.05);
		}

		void myColour(Input inCol, SurfaceOutput outCol, inout fixed4 colour)
		{
			fixed3 fogColour = _FogColour.rgb;
			#ifdef UNITY_PASS_FORWARDADD
			fogColour = 0;
			#endif
			colour.rgb = lerp(colour.rgb, fogColour, inCol.fog);
		}

		void mainColour (Input modelsTextureInput, inout SurfaceOutput renderedOutput) 
		//mainColour Function as referenced above
		{
			renderedOutput.Albedo = tex2D (_MainTex, modelsTextureInput.uv_MainTex).rgb;
			//Albedo is our base colour with out reflection or highlights
			//we are setting the surface of the model to the colour of our 2D texture
			//according to the UV map and the RGB (Red Green Blue) 
			renderedOutput.Normal = UnpackNormal(tex2D (_BumpMap, modelsTextureInput.uv_BumpMap));
		}
		/////////
		ENDCG	//THIS IS WHERE Cg Code ends
	   /////////
	}
	FallBack "Diffuse" // if the shader is to powerful and cant be run
	//we replace it with Diffuse which is a flat 1 Texture shader
	//defualt (ahhh fuck it)
			
}
