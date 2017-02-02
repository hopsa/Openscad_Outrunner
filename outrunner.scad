$fa=0.5;
$fn=180;

driveshaft_h=50;
driveshaft_od=4;
bell_od=40;
bell_h=15;
bell_wall=1;
bell_ceil=1;
driveshaft_behind_bell=10;
mount_od=40;
mount_height=8;
mount_thick=1;
mount_wall=2;
static_shaft_od=6;

test();

module test(){
    color("red")
        bell();
    color("yellow")
        stator();
    color("blue")
        mount();
}

module bell(){
    intersection(){
        difference() {
            cylinder(h=bell_h, r=bell_od/2);
               translate([0,0,-1])
                    cylinder(h=bell_h, r=bell_od/2-bell_wall);
            for (x=[0:5])
                rotate([0,0,360/6*x])
                    translate([10,0,-5])
                        cylinder(h=30,r=4);
        }
        translate([0,0,-100+bell_h+bell_od/2-(bell_wall+bell_ceil)/2])
            cylinder(h=100,r1=100,r2=0);
        
    }
    translate([0,0,-driveshaft_behind_bell]){
        cylinder(h=driveshaft_h, r=driveshaft_od/2); //driveshaft
    }
}
module stator(){
    for(x=[0:7])
        rotate([0,0,360/8*x])
            translate([-1,0,0])
                cube([2,bell_od/2-bell_wall-1,10]);
    translate([0,0,-driveshaft_behind_bell])
        difference(){
            hstatic=driveshaft_behind_bell+bell_h-bell_ceil;
            cylinder(h=hstatic, r=static_shaft_od/2);
            translate([0,0,-1])
                cylinder(h=hstatic+2,r=driveshaft_od/2);
        }
}
 
module mount(){
        translate([0,0,-driveshaft_behind_bell]){
            difference(){
                cylinder(h=mount_height,r=mount_od/2);
                difference(){
                    translate([0,0,mount_thick])
                        cylinder(h=mount_height,r=mount_od/2+1);
                    cylinder(h=mount_height,r=static_shaft_od/2+mount_wall);
                }
                translate([0,0,-1])
                    cylinder(h=100, r=static_shaft_od/2); //inner hole
                translate([-15,0,5]) 
                    rotate([0,90,0])
                        cylinder(h=30,r=1.25); //set screw hole
                for(x=[0:2])
                    rotate([0,0,360/3*x])
                        translate([-10,0,-2])
                            cylinder(h=20,r=1.5);//attachment screw hole
            }
            
            
        }
}