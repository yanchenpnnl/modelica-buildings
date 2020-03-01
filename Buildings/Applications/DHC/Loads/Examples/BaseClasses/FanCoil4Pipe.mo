within Buildings.Applications.DHC.Loads.Examples.BaseClasses;
model FanCoil4Pipe
  "Model of a purely sensible four-pipe fan coil unit computing a required water mass flow rate"
  extends PartialFanCoil4Pipe(
    final have_TSen=true,
    final have_fluPor=true,
    final have_heaPor=false);
equation
  connect(hexHea.port_b2, port_bLoa)
    annotation (Line(points={{-80,0},{-200,0}}, color={0,127,255}));
  connect(port_aLoa, fan.port_a)
    annotation (Line(points={{200,0},{90,0}}, color={0,127,255}));
  connect(TSen, conCoo.u_m) annotation (Line(points={{-220,140},{-40,140},{-40,
          160},{0,160},{0,168}}, color={0,0,127}));
  connect(TSen, conHea.u_m) annotation (Line(points={{-220,140},{-40,140},{-40,
          200},{0,200},{0,208}}, color={0,0,127}));
annotation (
Documentation(
info="<html>
<p>
This is a simplified model of a four-pipe fan coil unit for heating and cooling. 
It is intended to be coupled to a room model by means of fluid ports.
See 
<a href=\"modelica://Buildings.Applications.DHC.Loads.Examples.BaseClasses.PartialFanCoil4Pipe\">
Buildings.Applications.DHC.Loads.Examples.BaseClasses.PartialFanCoil4Pipe</a>
for a description of the modeling principles.
</p>
</html>"));
end FanCoil4Pipe;