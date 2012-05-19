package ;

import nme.display.Shape;
import nme.display.Graphics;

class Particle extends Shape {
	
	public var color:Int;
	public var radius:Float;
	public var speed:Float;
	
	public function new () {
		super();
		color = 0;
		radius = 1.0;
		speed = 1.0;
	}
	
	// draws the particle on the given target Graphics
	// or on the own graphics
	public function draw(?target:Graphics):Void
	{
		
		if(target==null || target==graphics){
			target = graphics;
			target.clear();
		}
		
		target.beginFill(color);
		target.drawCircle(x,y,radius);
		target.endFill();
	}
}
