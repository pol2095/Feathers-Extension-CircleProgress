/*
Copyright 2017 pol2095. All Rights Reserved.

This program is free software. You can redistribute and/or modify it in
accordance with the terms of the accompanying license agreement.
*/
package feathers.extensions.progress
{
	import starling.display.Image;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.display.BlendMode;
	import starling.display.Image;
	import starling.textures.RenderTexture;
	import starling.display.Shape;
	import starling.display.Graphics;
	
	public class CircleStarling
	{
		public static function create(radius:Number, backCircleColor:int, backCircleAlpha:Number, thickness:Number):Vector.<Image>
		{
			var images:Vector.<Image> = new Vector.<Image>(2);
			
			var renderTexture:RenderTexture = new RenderTexture(radius*2, radius*2);
			images[0] = new Image(renderTexture);
			
			var circle:Shape = new Shape();
			circle.graphics.beginFill(0x000000);
			circle.graphics.drawCircle(0,0, radius);
			circle.graphics.endFill();
			circle.x=radius;
			circle.y=radius;
			
			var shape:Shape = new Shape();
			shape.graphics.beginFill(0x000000);
			shape.graphics.drawCircle(0,0, radius - thickness);
			shape.graphics.endFill();
			shape.x=radius;
			shape.y=radius;
			
			shape.blendMode = BlendMode.ERASE;

			renderTexture.draw(circle);
			renderTexture.draw(shape);
			
			var backRenderTexture:RenderTexture = new RenderTexture(radius*2, radius*2);
			images[1] = new Image(backRenderTexture);
			
			var backCircle:Shape = new Shape();
			backCircle.graphics.beginFill(backCircleColor, backCircleAlpha);
			backCircle.graphics.drawCircle(0,0, radius);
			backCircle.graphics.endFill();
			backCircle.x=radius;
			backCircle.y=radius;
			
			var backShape:Shape = new Shape();
			backShape.graphics.beginFill(0x000000);
			backShape.graphics.drawCircle(0,0, radius - thickness);
			backShape.graphics.endFill();
			backShape.x=radius;
			backShape.y=radius;
			
			backShape.blendMode = BlendMode.ERASE;

			backRenderTexture.draw(backCircle);
			backRenderTexture.draw(backShape);
			
			return images;
		}
	}
}