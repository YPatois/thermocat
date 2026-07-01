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



module fridge_body() {
    color([.8,.8,.8])
    difference() {
        cube([fridgel,fridgeL,fridgeh]);
        translate([fridgeW,fridgeW,fridgeW])
        cube([fridgel-2*fridgeW,fridgeL+2*fridgeW,fridgeh-2*fridgeW]);
    }
}

/*
module fridge_door() {
    color([.8,.7,.2])
    translate([fridgeW,fridgeL-insulationW,fridgeW])
    difference() {
        union() {
            cube([fridgel-2*fridgeW,insulationW,fridgeh-2*fridgeW]);
            translate([-insulationW,insulationW,-insulationW])
            cube([fridgel,insulationW,fridgeh]);
        };
        union {
            cube([ventilationW,ventilationW,ventilationW]);
        };
    }
}
*/

module fridge_door() {
    color([.8,.7,.2])
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

union() {
    translate([0,0,insulationW]) fridge();
}
