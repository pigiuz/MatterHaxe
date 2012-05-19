package;

import nme.display.Sprite;
import nme.events.Event;
import nme.Lib;

class ParticlesFallGraphics extends Sprite {
		
	
	// main function
	public static function main () {		
		Lib.current.addChild (new ParticlesFallGraphics ());
	}
	
	
	// CONSTANTS:
	// stage width
	inline private static var STAGE_W:Int 				= 512;
	// stage height
	inline private static var STAGE_H:Int 				= 512;
	// amount of particles to display
	inline private static var NUM_PARTICLES:Int			= 500;
	// max radius of a particle
	inline private static var PARTICLE_MAX_RADIUS:Int 	= 10;
	
	// array containing all particles instances
	private var particles:Array<Particle>;
	
	public function new () {
		
		super ();
		init();
	}
	
	// initialization function:
	// - initializes particles array
	// - generates particles and populates array
	// - registers an enterframe handler for looping
	private function init():Void
	{
		
		// initializing array
		particles = new Array<Particle>();
		// generating particles
		generateParticles();
		// then add loop handler
		addEventListener(Event.ENTER_FRAME,onEnterFrame);
		
	}
	
	// generates NUM_PARTICLES particles with a random
	// radius color and speed
	private function generateParticles():Void
	{
		var particle:Particle;
		while(particles.length < NUM_PARTICLES){
			// creating a particle
			particle = new Particle();
			// putting it randomly on the x axis within the width
			particle.x = Math.random()*STAGE_W;
			// but keeping that on top
			particle.y = 0.0;
			// setting a random radius within the max value
			particle.radius = Math.random()*PARTICLE_MAX_RADIUS;
			// getting color components from radius (bigger is brighter)
			var r:Int = cast(particle.radius/PARTICLE_MAX_RADIUS*0xFF);
			var b:Int = cast(particle.radius/PARTICLE_MAX_RADIUS*0xFF);
			var g:Int = cast(particle.radius/PARTICLE_MAX_RADIUS*0xFF);
			// and combining them to one color
			particle.color = g << 8 | b ;
			// then setting the speed (bigger is "heavier")
			particle.speed = particle.radius;
			// storing a reference on the array
			particles.push(
				particle
			);
		}
		
		// then sorting on radius (bigger is nearer)
		particles.sort(
			function(p1:Particle,p2:Particle):Int {
				if(p1.radius==p2.radius)
					return 0;
				return p1.radius>p2.radius?1:-1;
			}
		);
		
	}
	
	
	// loop handler
	private function onEnterFrame(event:Event=null):Void
	{
		// clearing the main graphics context
		graphics.clear();
		// iterating all particles
		var particle:Particle;
		for(i in 0...NUM_PARTICLES){
			// retrieving the particle
			particle = particles[i];
			// moving the particle according to its speed
			particle.y += particle.speed;
			// and moving that to the top whenever it exits the boundaries
			if(particle.y>STAGE_H){
				particle.y = 0;
				particle.x = Math.floor(Math.random()*STAGE_W);
			}
			// rendering the particle into the main graphics context
			particle.draw(graphics);
		}
	}
	
}