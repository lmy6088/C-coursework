use <Spiff.scad>;

//Resolution of curved surfaces
RESOLUTION = 30;

//Default dimensions of the base
Base_radius = 42;
Base_height = 15;
TEXT_HEIGHT = 4;

//Circular base of the engduino stand
module base()
{
	difference()
	{
		union()
		{
			translate([0,0,Base_height*0.75]) cylinder(r=Base_radius, h=Base_height, centre=true, $fn=RESOLUTION);
			//Making 7 rectangular stands around the base
			for(r=[0:7])
			{
				rotate([0,0,r*360/7]) 
				translate([Base_radius-3,0,0])
				cube([10,10,Base_height+Base_height*0.75],centre=true);
			}
		}
		union()
		{
			//Circular holes around the Base.
			for(r=[0:360])
			{
				rotate([0,0,r*360/7])
				translate([Base_radius/1.2,0,0])
				cylinder(r=2,h=Base_height+Base_height*0.75,centre=true);
			}
		}
				
			
	}
}

module USB_Base()
{
	translate([-Base_radius/2.8,-Base_radius/3.9,Base_height+7])
	cube([Base_radius/1.5,Base_radius/2,Base_height*0.5],centre=true);
}

module addText(textHeight, position, rotation, text)
{
	 translate(position) 
    rotate(a=rotation) {
      linear_extrude(height = textHeight)
      write(text); 
   }
}

module USB_Socket()
{
	difference()//Dimensions of the USB.
	{
		cube([15,8,17],centre=true);
		translate([1.5,1.5,2])
		cube([12,5,15],centre=true);
	}
}

module Position_socket()
{
	translate([-Base_radius/5,-Base_radius/10,Base_height+14.5]) 
	USB_Socket();
}

module stand(radius = Base_radius, height = Base_height){
base();
USB_Base();
Position_socket();
addText(TEXT_HEIGHT,[-25,-25,26],[0,0,0], "Engduino");
addText(TEXT_HEIGHT,[-18,+12,26],[0,0,0], "Min's");
}

stand();