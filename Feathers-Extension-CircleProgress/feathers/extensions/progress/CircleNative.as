/*
Copyright 2017 pol2095. All Rights Reserved.

This program is free software. You can redistribute and/or modify it in
accordance with the terms of the accompanying license agreement.
*/
package feathers.extensions.progress
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.Shape;
	import flash.display.BlendMode;
	
	import starling.display.Image;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	
	public class CircleNative
	{
		public static function create(radius:Number, backCircleColor:int, backCircleAlpha:Number, thickness:Number):Vector.<Image>
		{
			var main:Sprite = new Sprite();
			
			var atlasString:String='<TextureAtlas><SubTexture name="circle" x="0" y="0" width="'+(radius*2)+'" height="'+(radius*2)+'"/><SubTexture name="backCircle" x="'+(radius*2)+'" y="0" width="'+(radius*2)+'" height="'+(radius*2)+'"/></TextureAtlas>';
			
			var circle:Sprite = new Sprite();
			circle.graphics.beginFill(0x0);
			circle.graphics.drawCircle(0, 0, radius);
			circle.graphics.endFill();
			main.addChild(circle);
			circle.x=radius;
			circle.y=radius;
			var shape:Shape = new Shape();
			shape.graphics.beginFill(0x0);
			shape.graphics.drawCircle(0, 0, radius - thickness);
			shape.graphics.endFill();
			circle.addChild(shape);
			circle.blendMode = BlendMode.LAYER;
			shape.blendMode = BlendMode.ERASE;
			
			var backCircle:Sprite = new Sprite();
			backCircle.graphics.beginFill(backCircleColor, backCircleAlpha);
			backCircle.graphics.drawCircle(0, 0, radius);
			backCircle.graphics.endFill();
			main.addChild(backCircle);
			backCircle.x=radius*3;
			backCircle.y=radius;
			var backShape:Shape = new Shape();
			backShape.graphics.beginFill(0x0);
			backShape.graphics.drawCircle(0, 0, radius - thickness);
			backShape.graphics.endFill();
			backCircle.addChild(backShape);
			backCircle.blendMode = BlendMode.LAYER;
			backShape.blendMode = BlendMode.ERASE;
			
			var bitmapData:BitmapData = new BitmapData(radius*4, radius*2, true, 0x0);
			bitmapData.draw(main);
			var bitmap:Bitmap = new Bitmap(bitmapData);
			var texture:Texture = Texture.fromBitmap(bitmap);
			var atlasXml:XML = new XML(atlasString);
			var atlas:TextureAtlas = new TextureAtlas(texture, atlasXml);
			var images:Vector.<Image> = new Vector.<Image>(2);
			images[0] = new Image( atlas.getTexture("circle") );
			images[1] = new Image( atlas.getTexture("backCircle") );
			
			bitmapData.dispose();
			circle.graphics.clear();
			shape.graphics.clear();
			backCircle.graphics.clear();
			backShape.graphics.clear();
			
			return images;
		}
	}
}