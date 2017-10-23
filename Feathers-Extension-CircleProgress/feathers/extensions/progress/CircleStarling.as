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
		private var images:Vector.<Image> = new Vector.<Image>(4);
		
		public function create(radius:Number, backCircleColor:int, backCircleAlpha:Number, thickness:Number):Image
		{
			var renderTexture:RenderTexture = new RenderTexture(radius*2, radius*2);
			images[0] = new Image(renderTexture);
			
			var circle:Shape = new Shape();
			circle.graphics.beginFill(0x0);
			circle.graphics.drawCircle(radius, radius , radius);
			circle.graphics.endFill();
			
			var shape:Shape = new Shape();
			shape.graphics.beginFill(0x0);
			shape.graphics.drawCircle(radius, radius, radius - thickness);
			shape.graphics.endFill();
			
			shape.blendMode = BlendMode.ERASE;

			renderTexture.draw(circle);
			renderTexture.draw(shape);
			
			images[0].blendMode = BlendMode.ERASE;
			
			var backRenderTexture:RenderTexture = new RenderTexture(radius*2, radius*2);
			images[1] = new Image(backRenderTexture);
			
			var backCircle:Shape = new Shape();
			backCircle.graphics.beginFill(backCircleColor, backCircleAlpha);
			backCircle.graphics.drawCircle(radius, radius, radius);
			backCircle.graphics.endFill();
			
			var backShape:Shape = new Shape();
			backShape.graphics.beginFill(0x0);
			backShape.graphics.drawCircle(radius, radius, radius - thickness);
			backShape.graphics.endFill();
			
			backShape.blendMode = BlendMode.ERASE;

			backRenderTexture.draw(backCircle);
			backRenderTexture.draw(backShape);
			
			circle.graphics.clear();
			shape.graphics.clear();
			backCircle.graphics.clear();
			backShape.graphics.clear();
			
			return images[1];
		}
		
		public function getBow(percentage:Number, radius:Number, color:int):Image
		{
			var renderTexture:RenderTexture = new RenderTexture(radius*2, radius*2);
			images[2] = new Image(renderTexture);
			
			var circleBow:Shape = new Shape();
			circleBow.graphics.beginFill(0x0);
			drawPieMask(circleBow.graphics, percentage, radius, radius, radius);
			circleBow.graphics.endFill();
			
			renderTexture.draw(circleBow);
			renderTexture.draw(images[0]);
			
			var childRenderTexture:RenderTexture = new RenderTexture(radius*2, radius*2);
			images[3] = new Image(childRenderTexture);
			
			var child:Shape = new Shape();
			child.graphics.beginFill(color);
			drawPieMask(child.graphics, percentage, radius, radius, radius);
			child.graphics.endFill();
			
			images[2].blendMode = BlendMode.ERASE;
			
			childRenderTexture.draw(child);
			childRenderTexture.draw(images[2]);
			
			circleBow.graphics.clear();
			child.graphics.clear();
			
			return images[3];
		}
		
		private function drawPieMask(graphics:Graphics, percentage:Number, radius:Number = 50, x:Number = 0, y:Number = 0, rotation:Number = 0, sides:int = 6):void
		{
			rotation = -Math.PI/2;
			// graphics should have its beginFill function already called by now
			graphics.moveTo(x, y);
			if (sides < 3) sides = 3; // 3 sides minimum
			// Increase the length of the radius to cover the whole target
			radius /= Math.cos(1/sides * Math.PI);
			// Find how many sides we have to draw
			var sidesToDraw:int = Math.floor(percentage/100 * sides);
			for (var i:int = 0; i <= sidesToDraw; i++)
			lineToRadians((i / sides) * (Math.PI * 2) + rotation, graphics, radius, x, y);
			// Draw the last fractioned side
			if (percentage/100 * sides != sidesToDraw)
			lineToRadians(percentage/100 * (Math.PI * 2) + rotation, graphics, radius, x, y);
		}
		// Shortcut function
		private function lineToRadians(rads:Number, graphics:Graphics, radius:Number, x:Number = 0, y:Number = 0):void
		{
			graphics.lineTo(Math.cos(rads) * radius + x, Math.sin(rads) * radius + y);
		}
	}
}