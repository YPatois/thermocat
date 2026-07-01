//
// Refricat
// A cat climatization system
//

mm = 1.0;
cm = 10*mm;
m  = 100*cm;

fridgel=1*m;
fridgeL=1*m;
fridgeh=1*m;
fridgeW=5*cm;
fridgeXch=2*cm;
insulationW=5*cm;
ventilationW=5*cm;

frigdeColor=[.8,.8,.8];
cardboardColor1=[.8,.7,.2];
cardboardColor2=[.7,.6,.2];

cathouseL=1*m;
cathouseh=1*m;

catdoorW=12*cm;
catdoorh=12*cm;

module fridge_exchanger() {
    color([.9,.1,.1])
    cube([fridgel,fridgeXch,fridgeh]);
}

module fridge_body() {
    color(frigdeColor)
    difference() {
        translate([0,fridgeXch,0])
        cube([fridgel,fridgeL-fridgeXch,fridgeh]);
        translate([fridgeW,fridgeW,fridgeW])
        cube([fridgel-2*fridgeW,fridgeL+2*fridgeW,fridgeh-2*fridgeW]);
    }
}

module ventilo() {
    color([.1,.1,.1])
    translate([ventilationW,2*cm,ventilationW])
    difference() {
        translate([-ventilationW,-2*cm,-ventilationW])
        cube([ventilationW*2,4*cm,ventilationW*2]);
        translate([-ventilationW*1.8,-2*cm,-ventilationW*1.8])
        cube([ventilationW*1.8,3*cm,ventilationW*1.8]);
        for (i=[0:12]) {
            rotate([0,i * 360/12,0])
            rotate([90,0,0])
            translate([3.5*cm,0,0])
            cylinder(8*cm, .8*cm, .8*cm, center = true);
            rotate([0,i * 360/12,0])
            rotate([90,0,0])
            translate([2.5*cm,0,0])
            cylinder(8*cm, .6*cm, .6*cm, center = true);
        }
    }
}

module fridge_door() {
    color(cardboardColor1)
    translate([fridgeW,fridgeL-insulationW,fridgeW])
    difference() {
        union() {
            cube([fridgel-2*fridgeW,insulationW,fridgeh-2*fridgeW]);
            translate([-insulationW,insulationW,-insulationW])
            cube([fridgel,insulationW,fridgeh]);
        };
        translate([fridgel/2-2*insulationW,-insulationW,fridgeW])
        cube([ventilationW*2,4*insulationW,ventilationW*2]);
        translate([ fridgel/2-2*insulationW,
                   -insulationW,
                    fridgeh-fridgeW-4*ventilationW])
        cube([ventilationW*2,4*insulationW,ventilationW*2]);
   }
   translate([fridgel/2-1*insulationW,fridgeL,2*fridgeW])
   ventilo();
}

module fridge() {
    union() {
        fridge_exchanger();
        fridge_body();
        fridge_door();
    }
}


module cathouse_base() {
    color(cardboardColor2)
    translate([-insulationW,0,0])
    cube([fridgel+2*insulationW,fridgeL+cathouseL,insulationW]);
}

module cathouse_hatchL() {
    color(cardboardColor2)
    difference() {
        cube([catdoorW+insulationW,4*catdoorW,catdoorh+2*insulationW]);
        translate([0,-2*insulationW,insulationW])
        cube([catdoorW,4*catdoorW-insulationW,catdoorh]);
    }
}

module cathouse_hatchR() {
    mirror([1,0,0]) cathouse_hatchL();
}


module tempprobe() {
    color([.9,.1,.1])
    sphere(5*cm);
}

module cathouse() {
    union() {
        cathouse_base();
        translate([-insulationW,fridgeL-2*insulationW,insulationW])
        color(cardboardColor2)
        difference() {
            cube([fridgel+2*insulationW,cathouseL+2*insulationW,cathouseh+insulationW]);
            translate([insulationW,-insulationW,0])
            cube([fridgel-2*insulationW,cathouseL+2*insulationW,cathouseh]);
            translate([-fridgel/2,cathouseL-catdoorW,0])
            cube([fridgel*2,catdoorW,catdoorh]);
        }
        translate([fridgel+insulationW,fridgeL+cathouseL-4*catdoorW,0])
        cathouse_hatchL();
        translate([-insulationW,fridgeL+cathouseL-4*catdoorW,0])
        cathouse_hatchR();
        translate([fridgel/2,fridgeL+cathouseL/2,fridgeh-insulationW])
        tempprobe();
    }
}

difference() {
    union() {
        translate([0,0,insulationW]) fridge();
        cathouse();
    }
    translate([fridgel/2+30*cm,-20*cm,-20*cm])
    cube([fridgel,fridgeL*3,fridgeh*2]);
}
