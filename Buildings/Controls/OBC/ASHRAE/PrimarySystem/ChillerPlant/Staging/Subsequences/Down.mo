within Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Staging.Subsequences;
block Down "Stage down conditions"

  parameter Modelica.SIunits.Time delayStaCha = 15*60
    "True delay period";

  parameter Modelica.SIunits.TemperatureDifference TDif = 1
    "Offset between the chilled water supply temperature and its setpoint";

  parameter Modelica.SIunits.TemperatureDifference TDifHyst = 1
    "Hysteresis deadband for temperature";

  parameter Modelica.SIunits.PressureDifference dpDif = 2 * 6895
    "Offset between the chilled water pump Diferential static pressure and its setpoint";

  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uWseSta
    "Waterside economizer status" annotation (
     Placement(transformation(extent={{-180,-170},{-140,-130}}),
        iconTransformation(extent={{-120,-90},{-100,-70}})));

  Buildings.Controls.OBC.CDL.Interfaces.IntegerInput u "Chiller stage"
    annotation (Placement(transformation(extent={{-180,-200},{-140,-160}}),
        iconTransformation(extent={{-120,-110},{-100,-90}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput uOplr(final unit="1")
    "Operating part load ratio of the current stage" annotation (Placement(
        transformation(extent={{-180,90},{-140,130}}), iconTransformation(
          extent={{-120,70},{-100,90}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput uOplrMin(final unit="1")
    "Minimum operating part load ratio at the current stage" annotation (
      Placement(transformation(extent={{-180,60},{-140,100}}),
        iconTransformation(extent={{-120,50},{-100,70}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput uOplrDow(final unit="1")
    "Operating part load ratio of the next stage down" annotation (Placement(
        transformation(extent={{-180,170},{-140,210}}),iconTransformation(extent={{-120,
            110},{-100,130}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput uSplrDow(final unit="1")
    "Staging part load ratio of the next stage down"
    annotation (Placement(transformation(extent={{-180,130},{-140,170}}),
      iconTransformation(extent={{-120,90},{-100,110}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput TChiWatSupSet(
    final unit="K",
    final quantity="ThermodynamicTemperature")
    "Chilled water supply temperature setpoint"
    annotation (Placement(transformation(extent={{-180,-110},{-140,-70}}),
    iconTransformation(extent={{-120,-10},{-100,10}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput TChiWatSup(
    final unit="K",
    final quantity="ThermodynamicTemperature")
    "Chilled water return temperature"
    annotation (Placement(transformation(extent={{-180,-50},{-140,-10}}),
    iconTransformation(extent={{-120,-30},{-100,-10}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput dpChiWatPumSet(
    final unit="Pa",
    final quantity="PressureDifference")
    "Chilled water pump Diferential static pressure setpoint"
    annotation (Placement(transformation(extent={{-180,10},{-140,50}}),
      iconTransformation(extent={{-120,30},{-100,50}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput dpChiWatPum(
    final unit="Pa",
    final quantity="PressureDifference")
    "Chilled water pump Diferential static pressure"
    annotation (Placement(transformation(extent={{-180,-20},{-140,20}}),
    iconTransformation(extent={{-120,10},{-100,30}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput TWsePre(
    final unit="1")
    "Predicted waterside economizer outlet temperature" annotation (Placement(
        transformation(extent={{-180,-80},{-140,-40}}), iconTransformation(
          extent={{-120,-50},{-100,-30}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput uTowFanSpeMax
    "Maximum cooling tower fan speed"
    annotation (Placement(transformation(extent={{-180,-140},{-140,-100}}),
        iconTransformation(extent={{-120,-70},{-100,-50}})));

  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput y "Efficiency condition for chiller staging"
    annotation (Placement(transformation(extent={{140,-10},{160,10}}),
        iconTransformation(extent={{100,-10},{120,10}})));

//protected

  Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Staging.Subsequences.FailsafeCondition faiSafCon(
    final delayStaCha = delayStaCha,
    final TDif = TDif,
    final dpDif = dpDif)
    "Failsafe condition of the next lower stage"
    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));

  Buildings.Controls.OBC.CDL.Logical.And and0 "And for staging down"
    annotation (Placement(transformation(extent={{20,60},{40,80}})));

  Buildings.Controls.OBC.CDL.Logical.LogicalSwitch logSwi
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));

  Buildings.Controls.OBC.CDL.Integers.GreaterThreshold intGreThr(threshold=1)
    "Switches staging down rules"
    annotation (Placement(transformation(extent={{-120,-190},{-100,-170}})));

  Buildings.Controls.OBC.CDL.Continuous.Hysteresis hysTSup(
    final uLow=TDif,
    final uHigh=TDif + TDifHyst)
    "Checks if the predicted downstream WSE chilled water supply temperature is higher than its setpoint plus an offset"
    annotation (Placement(transformation(extent={{-40,-90},{-20,-70}})));

  Buildings.Controls.OBC.CDL.Logical.And3 and1 "Or for staging up"
    annotation (Placement(transformation(extent={{20,-90},{40,-70}})));

  Buildings.Controls.OBC.CDL.Logical.Not not0 "Logical not"
    annotation (Placement(transformation(extent={{-80,-130},{-60,-110}})));

  Buildings.Controls.OBC.CDL.Logical.Not not1 "Logical not"
    annotation (Placement(transformation(extent={{-40,20},{-20,40}})));

  Buildings.Controls.OBC.CDL.Continuous.Add add0(
    final k1=-1,
    final k2=1)
    "Adder for temperatures"
    annotation (Placement(transformation(extent={{-80,-90},{-60,-70}})));

  Buildings.Controls.OBC.CDL.Continuous.Hysteresis hys(
    final uHigh=0.99,
    final uLow=0.98) "Checks if the signal is at its maximum"
    annotation (Placement(transformation(extent={{-120,-130},{-100,-110}})));

  Buildings.Controls.OBC.CDL.Logical.TrueDelay truDel(
    final delayTime=delayStaCha, delayOnInit=true)
    "Delays a true signal"
    annotation (Placement(transformation(extent={{50,-90},{70,-70}})));

  Buildings.Controls.OBC.CDL.Logical.TrueDelay truDel1(
    final delayTime=delayStaCha,
    final delayOnInit=true)
    "Delays a true signal"
    annotation (Placement(transformation(extent={{60,20},{80,40}})));

  Buildings.Controls.OBC.CDL.Continuous.Hysteresis hysOplr(
    final uLow=-0.05,
    final uHigh=0)
    "Checks if the current stage operating part load ratio exceeds the stage up part load ratio"
    annotation (Placement(transformation(extent={{-40,160},{-20,180}})));

  Buildings.Controls.OBC.CDL.Continuous.Add add(
    final k1=-1,
    final k2=+1)
    "Subtracts part load ratios"
    annotation (Placement(transformation(extent={{-80,160},{-60,180}})));

equation
  connect(TChiWatSupSet, faiSafCon.TChiWatSupSet) annotation (Line(points={{-160,
          -90},{-120,-90},{-120,32},{-82,32}},color={0,0,127}));
  connect(dpChiWatPumSet, faiSafCon.dpChiWatPumSet) annotation (Line(points={{-160,30},
          {-130,30},{-130,25},{-82,25}},        color={0,0,127}));
  connect(dpChiWatPum, faiSafCon.dpChiWatPum) annotation (Line(points={{-160,0},
          {-100,0},{-100,22},{-82,22}},   color={0,0,127}));
  connect(u, intGreThr.u)
    annotation (Line(points={{-160,-180},{-122,-180}}, color={255,127,0}));
  connect(y, logSwi.y)
    annotation (Line(points={{150,0},{122,0}},color={255,0,255}));
  connect(add0.y,hysTSup. u)
    annotation (Line(points={{-58,-80},{-42,-80}}, color={0,0,127}));
  connect(uOplr, faiSafCon.uOplrUp) annotation (Line(points={{-160,110},{-100,
          110},{-100,38},{-82,38}},
                               color={0,0,127}));
  connect(uOplrMin, faiSafCon.uOplrUpMin) annotation (Line(points={{-160,80},{
          -110,80},{-110,35},{-82,35}},
                                   color={0,0,127}));
  connect(TChiWatSup, faiSafCon.TChiWatSup) annotation (Line(points={{-160,-30},
          {-110,-30},{-110,28},{-82,28}},  color={0,0,127}));
  connect(TChiWatSupSet, add0.u2) annotation (Line(points={{-160,-90},{-110,-90},
          {-110,-86},{-82,-86}},color={0,0,127}));
  connect(TWsePre, add0.u1) annotation (Line(points={{-160,-60},{-110,-60},{
          -110,-74},{-82,-74}},
                           color={0,0,127}));
  connect(hys.y, not0.u)
    annotation (Line(points={{-98,-120},{-82,-120}}, color={255,0,255}));
  connect(uTowFanSpeMax, hys.u) annotation (Line(points={{-160,-120},{-122,-120}},
                                   color={0,0,127}));
  connect(uWseSta, and1.u3) annotation (Line(points={{-160,-150},{10,-150},{10,-88},
          {18,-88}}, color={255,0,255}));
  connect(hysTSup.y, and1.u1) annotation (Line(points={{-18,-80},{-10,-80},{-10,
          -72},{18,-72}}, color={255,0,255}));
  connect(uSplrDow, add.u2) annotation (Line(points={{-160,150},{-132,150},{-132,
          164},{-82,164}},       color={0,0,127}));
  connect(uOplrDow, add.u1) annotation (Line(points={{-160,190},{-132,190},{-132,
          176},{-82,176}},       color={0,0,127}));
  connect(faiSafCon.y, not1.u)
    annotation (Line(points={{-58,30},{-42,30}}, color={255,0,255}));
  connect(not1.y, and0.u2) annotation (Line(points={{-18,30},{0,30},{0,62},{18,
          62}},
        color={255,0,255}));
  connect(intGreThr.y, logSwi.u2) annotation (Line(points={{-98,-180},{80,-180},
          {80,0},{98,0}}, color={255,0,255}));
  connect(not0.y, and1.u2) annotation (Line(points={{-58,-120},{0,-120},{0,-80},
          {18,-80}}, color={255,0,255}));
  connect(and1.y, truDel.u)
    annotation (Line(points={{42,-80},{48,-80}}, color={255,0,255}));
  connect(truDel.y, logSwi.u3) annotation (Line(points={{72,-80},{90,-80},{90,
          -8},{98,-8}},
                    color={255,0,255}));
  connect(add.y, hysOplr.u)
    annotation (Line(points={{-58,170},{-42,170}}, color={0,0,127}));
  connect(and0.y, truDel1.u) annotation (Line(points={{42,70},{50,70},{50,30},{
          58,30}}, color={255,0,255}));
  connect(truDel1.y, logSwi.u1) annotation (Line(points={{82,30},{90,30},{90,8},
          {98,8}}, color={255,0,255}));
  connect(hysOplr.y, and0.u1) annotation (Line(points={{-18,170},{0,170},{0,70},
          {18,70}}, color={255,0,255}));
  annotation (defaultComponentName = "staDow",
        Icon(graphics={
        Rectangle(
        extent={{-100,-100},{100,100}},
        lineColor={0,0,127},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
        Text(
          extent={{-120,146},{100,108}},
          lineColor={0,0,255},
          textString="%name"),
        Rectangle(extent={{-80,-10},{-20,-22}}, lineColor={0,0,127}),
        Rectangle(extent={{-80,-28},{-20,-40}}, lineColor={0,0,127}),
        Rectangle(extent={{-76,-22},{-72,-28}}, lineColor={0,0,127}),
        Rectangle(extent={{-28,-22},{-24,-28}}, lineColor={0,0,127}),
        Rectangle(extent={{20,-10},{80,-22}}, lineColor={0,0,127}),
        Rectangle(extent={{20,-28},{80,-40}}, lineColor={0,0,127}),
        Rectangle(extent={{24,-22},{28,-28}}, lineColor={0,0,127}),
        Rectangle(extent={{72,-22},{76,-28}}, lineColor={0,0,127}),
        Rectangle(extent={{-80,30},{-20,18}}, lineColor={0,0,127}),
        Rectangle(extent={{-80,12},{-20,0}}, lineColor={0,0,127}),
        Rectangle(extent={{-76,18},{-72,12}}, lineColor={0,0,127}),
        Rectangle(extent={{-28,18},{-24,12}}, lineColor={0,0,127})}),
                                          Diagram(
        coordinateSystem(preserveAspectRatio=false,
        extent={{-140,-200},{140,200}})),
Documentation(info="<html>
<p>
Outputs the chiller stage change up enable signal.
</p>
</html>",
revisions="<html>
<ul>
<li>
January 28, 2019, by Milica Grahovac:<br/>
First implementation.
</li>
</ul>
</html>"));
end Down;