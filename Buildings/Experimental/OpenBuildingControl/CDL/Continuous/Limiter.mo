within Buildings.Experimental.OpenBuildingControl.CDL.Continuous;
block Limiter "Limit the range of a signal"

  parameter Real uMax "Upper limit of input signal";
  parameter Real uMin "Lower limit of input signal";

  Interfaces.RealInput u "Connector of Real input signal"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));

  Interfaces.RealOutput y "Connector of Real output signal"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));

equation
  assert(uMax >= uMin, "Limiter: Limits must be consistent. However, uMax (=" + String(uMax) +
                       ") < uMin (=" + String(uMin) + ")");
  y = homotopy(actual = smooth(0,if u > uMax then uMax else if u < uMin then uMin else u), simplified=u);
  annotation (
Documentation(info="<html>
<p>
Block that outputs <code>y = min(uMax, max(uMin, u))</code>,
where
<code>u</code> is an input
and
<code>uMax</code> and <code>uMin</code> are parameters.
</p>
<p>
If <code>uMax &lt; uMin</code>, an error occurs and no output is produced.
</p>
</html>", revisions="<html>
<ul>
<li>
January 3, 2017, by Michael Wetter:<br/>
First implementation, based on the implementation of the
Modelica Standard Library.
</li>
</ul>
</html>"), Icon(coordinateSystem(
    preserveAspectRatio=true,
    extent={{-100,-100},{100,100}}), graphics={
        Text(
          lineColor={0,0,255},
          extent={{-150,110},{150,150}},
          textString="%name"),
        Rectangle(
        extent={{-100,-100},{100,100}},
        lineColor={0,0,127},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
    Line(points={{0,-90},{0,68}}, color={192,192,192}),
    Polygon(
      points={{0,90},{-8,68},{8,68},{0,90}},
      lineColor={192,192,192},
      fillColor={192,192,192},
      fillPattern=FillPattern.Solid),
    Line(points={{-90,0},{68,0}}, color={192,192,192}),
    Polygon(
      points={{90,0},{68,-8},{68,8},{90,0}},
      lineColor={192,192,192},
      fillColor={192,192,192},
      fillPattern=FillPattern.Solid),
    Line(points={{-80,-70},{-50,-70},{50,70},{80,70}}),
    Text(
      extent={{-150,150},{150,110}},
      textString="%name",
      lineColor={0,0,255}),
    Line(
      visible=strict,
      points={{50,70},{80,70}},
      color={255,0,0}),
    Line(
      visible=strict,
      points={{-80,-70},{-50,-70}},
      color={255,0,0}),
    Text(
      extent={{12,72},{94,98}},
      lineColor={0,0,0},
          textString="%uMax"),
    Text(
      extent={{-100,-98},{-18,-72}},
      lineColor={0,0,0},
          textString="%uMin")}),
    Diagram(coordinateSystem(
    preserveAspectRatio=true,
    extent={{-100,-100},{100,100}}), graphics={
    Line(points={{0,-60},{0,50}}, color={192,192,192}),
    Polygon(
      points={{0,60},{-5,50},{5,50},{0,60}},
      lineColor={192,192,192},
      fillColor={192,192,192},
      fillPattern=FillPattern.Solid),
    Line(points={{-60,0},{50,0}}, color={192,192,192}),
    Polygon(
      points={{60,0},{50,-5},{50,5},{60,0}},
      lineColor={192,192,192},
      fillColor={192,192,192},
      fillPattern=FillPattern.Solid),
    Line(points={{-50,-40},{-30,-40},{30,40},{50,40}}),
    Text(
      extent={{46,-6},{68,-18}},
      lineColor={128,128,128},
      textString="u"),
    Text(
      extent={{-30,70},{-5,50}},
      lineColor={128,128,128},
      textString="y"),
    Text(
      extent={{-58,-54},{-28,-42}},
      lineColor={128,128,128},
      textString="uMin"),
    Text(
      extent={{26,40},{66,56}},
      lineColor={128,128,128},
      textString="uMax")}));
end Limiter;