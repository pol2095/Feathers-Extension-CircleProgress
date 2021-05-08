/*
Copyright 2017 pol2095. All Rights Reserved.

This program is free software. You can redistribute and/or modify it in
accordance with the terms of the accompanying license agreement.
*/
package feathers.extensions.progress
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.Shape;
	import flash.display.Graphics;
	import flash.display.BlendMode;
	
	import starling.display.Image;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class CircleNative
	{
		private var circle:Sprite = new Sprite();
		
		public function create(radius:Number, backCircleColor:int, backCircleAlpha:Number, thickness:Number, color:int):Image
		{
			circle.graphics.beginFill(color);
			circle.graphics.drawCircle(radius, radius, radius);
			circle.graphics.endFill();
			var shape:Shape = new Shape();
			shape.graphics.beginFill(0x0);
			shape.graphics.drawCircle(radius, radius, radius - thickness);
			shape.graphics.endFill();
			circle.addChild(shape);
			circle.blendMode = BlendMode.LAYER;
			shape.blendMode = BlendMode.ERASE;
			
			var backCircle:Sprite = new Sprite();
			backCircle.graphics.beginFill(backCircleColor, backCircleAlpha);
			backCircle.graphics.drawCircle(radius, radius, radius);
			backCircle.graphics.endFill();
			var backShape:Shape = new Shape();
			backShape.graphics.beginFill(0x0);
			backShape.graphics.drawCircle(radius, radius, radius - thickness);
			backShape.graphics.endFill();
			backCircle.addChild(backShape);
			backCircle.blendMode = BlendMode.LAYER;
			backShape.blendMode = BlendMode.ERASE;
			
			var bitmapData:BitmapData = new BitmapData(radius*2, radius*2, true, 0x0);
			bitmapData.draw(backCircle);
			var texture:Texture = Texture.fromBitmapData(bitmapData);
			// give the texture a way to recreate itself
			texture.root.onRestore = function():void
			{
				var restoreBMD:BitmapData = new BitmapData(radius*2, radius*2, true, 0x0);
				restoreBMD.draw(backCircle);
				texture.root.uploadBitmapData(restoreBMD);
			}
			var image:Image = new Image( texture );
			
			bitmapData.dispose();
			//circle.graphics.clear();
			//shape.graphics.clear();
			//backCircle.graphics.clear();
			//backShape.graphics.clear();
			
			return image;
		}
		
		public function getBow(percentage:Number, radius:Number):Image
		{
			var circleBow:Sprite = new Sprite();
			circleBow.graphics.beginFill(0x0);
			drawPieMask(circleBow.graphics, 100 - percentage, radius + radius / 20, radius, radius);
			circleBow.graphics.endFill();
			circle.addChild(circleBow);
			//circle.blendMode = BlendMode.LAYER;
			circleBow.blendMode = BlendMode.ERASE;
			
			var bitmapData:BitmapData = new BitmapData(radius*2, radius*2, true, 0x0);
			bitmapData.draw(circle);
			var texture:Texture = Texture.fromBitmapData(bitmapData);
			texture.root.onRestore = function():void
			{
				var restoreBow:Sprite = new Sprite();
				restoreBow.graphics.beginFill(0x0);
				drawPieMask(restoreBow.graphics, 100 - percentage, radius + radius / 20, radius, radius);
				restoreBow.graphics.endFill();
				circle.addChild(restoreBow);
				restoreBow.blendMode = BlendMode.ERASE;
				
				var restoreBMD:BitmapData = new BitmapData(radius*2, radius*2, true, 0x0);
				restoreBMD.draw(circle);
				texture.root.uploadBitmapData(restoreBMD);
				restoreBMD.dispose();
				restoreBow.graphics.clear();
			}
			var image:Image = new Image( texture );
			
			bitmapData.dispose();
			circleBow.graphics.clear();
			
			return image;
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
			lineToRadians((i / sides) * (-Math.PI * 2) + rotation, graphics, radius, x, y);
			// Draw the last fractioned side
			if (percentage/100 * sides != sidesToDraw)
			lineToRadians(percentage/100 * (-Math.PI * 2) + rotation, graphics, radius, x, y);
		}
		// Shortcut function
		private function lineToRadians(rads:Number, graphics:Graphics, radius:Number, x:Number = 0, y:Number = 0):void
		{
			graphics.lineTo(Math.cos(rads) * radius + x, Math.sin(rads) * radius + y);
		}
	}
}