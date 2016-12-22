within Buildings.Experimental.OpenBuildingControl.CDL.Logical;
block Edge "Output y is true, if the input u has a rising edge (y = edge(u))"

  parameter Boolean pre_u_start=false "Start value of pre(u) at initial time";


  Modelica.Blocks.Interfaces.BooleanInput u "Connector of Boolean input signal"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));

  Modelica.Blocks.Interfaces.BooleanOutput y "Connector of Boolean output signal"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));

initial equation
  pre(u) = pre_u_start;

equation
  y = edge(u);
  annotation (
    defaultComponentName="edge1",
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={Text(
          extent={{-90,40},{90,-40}},
          lineColor={0,0,0},
          textString="not"),
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          lineThickness=5.0,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          borderPattern=BorderPattern.Raised),
                              Text(
          extent={{-50,52},{50,-46}},
          lineColor={0,0,0},
          textString="edge"),
        Ellipse(
          extent={{71,7},{85,-7}},
          lineColor=DynamicSelect({235,235,235}, if y > 0.5 then {0,255,0}
               else {235,235,235}),
          fillColor=DynamicSelect({235,235,235}, if y > 0.5 then {0,255,0}
               else {235,235,235}),
          fillPattern=FillPattern.Solid)}),
    Documentation(info="<html>
<p>
The output is <code>true</code> if the Boolean input has a rising edge
from <code>false</code> to <code>true</code>, otherwise
the output is <code>false</code>.
</p>
</html>"));
end Edge;