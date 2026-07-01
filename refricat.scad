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
insulationW=5*cm;
ventilationW=5*cm;

frigdeColor=[.8,.8,.8];
cardboardColor1=[.8,.7,.2];
cardboardColor2=[.7,.6,.2];

cathouseL=1*m;
cathouseh=1*m;


module fridge_body() {
    color(frigdeColor)
    difference() {
        cube([fridgel,fridgeL,fridgeh]);
        translate([fridgeW,fridgeW,fridgeW])
        cube([fridgel-2*fridgeW,fridgeL+2*fridgeW,fridgeh-2*fridgeW]);
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
}

module fridge() {
    union() {
       fridge_body();
       fridge_door();
    }
}


module cathouse_base() {
    color(cardboardColor2)
    translate([-insulationW,0,0])
    cube([fridgel++2*insulationW,fridgeL+cathouseL,insulationW]);
}

module cathouse() {
    union() {
        cathouse_base();
        color(cardboardColor2)
        translate([-insulationW,fridgeL-2*insulationW,insulationW])
        difference() {
            cube([fridgel+2*insulationW,cathouseL+2*insulationW,cathouseh+insulationW]);
            translate([insulationW,insulationW,0])
            cube([fridgel-2*insulationW,cathouseL,cathouseh]);
        }
    }
}

union() {
    translate([0,0,insulationW]) fridge();
    cathouse();
}
