<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:svg="http://www.w3.org/2000/svg"
	xmlns="http://www.w3.org/2000/svg"
	xmlns:math="http://exslt.org/math">


<xsl:variable name="overlap" select="0"/>
<xsl:variable name="yapinAdvance" select="2 * $thickness + $postGuard"/>
<xsl:variable name="advance" select="$yapinAdvance"/>

<xsl:include href="param.xslt"/>
<xsl:include href="path.xslt"/>

<xsl:variable name="yapinAngle" select="$pi div 8"/>

<xsl:variable name="hatoAngle" select="0.3 * $pi"/>
<xsl:variable name="hatoLength" select="1.5 * $waYOuterRadius * $medialScale"/>
<xsl:variable name="hatoThickness" select="$medialScale * $thickness"/>
<xsl:variable name="hatoIntersectAngle" select="math:asin(math:acos($waXInnerRadius div $waXOuterRadius))"/>
<xsl:variable name="yapinIntersectAngle" select="math:asin($thickness div (2 * $waXOuterRadius*$medialScale))"/>

<xsl:template match="svg:g">
	<xsl:copy use-attribute-sets="gAttribs">
	<xsl:call-template name="u103b_u103d_u103e">
		<xsl:with-param name="xOffset" select="0"/>
		<xsl:with-param name="yOffset" select="0"/>
	</xsl:call-template>
	</xsl:copy>
</xsl:template>

<xsl:template name="u103b_u103d_u103e">
	<xsl:param name="xOffset" select="0"/>
	<xsl:param name="yOffset" select="0"/>
	<xsl:variable name="yapinWidth" select="$waXOuterRadius + $preGuard + $thickness + $postGuard"/>
	<xsl:variable name="yapinArmDx" select="$yapinWidth - $waXOuterRadius * $medialScale * math:cos($yapinAngle)"/>
	<xsl:variable name="yapinArmDxAbove" select="$yapinArmDx - $thickness * (1 + .5 * math:sin($yapinAngle))"/>
	<xsl:variable name="yapinArmDxBelow" select="$yapinArmDx + $thickness * (.5 * math:sin($yapinAngle))"/>
	<xsl:variable name="yapinHeight" select="2 * $waYOuterRadius + $medialPad + (1 + math:sin($yapinAngle + $yapinIntersectAngle)) * $waYOuterRadius* $medialScale + $yapinArmDxBelow * math:tan($yapinAngle)"/>
    <xsl:element name="path" use-attribute-sets="pathAttribs">
    <xsl:attribute name="d">
    <xsl:call-template name="Move">
        <xsl:with-param name="x" select="$xOffset - $postGuard - $waXOuterRadius - $waXOuterRadius * $medialScale * math:cos(.5*$pi - $hatoAngle - $hatoIntersectAngle)"/>
        <xsl:with-param name="y" select="$yOffset - $medialPad - (1 - math:sin(.5 * $pi - $hatoAngle - $hatoIntersectAngle)) * $waYOuterRadius * $medialScale"/>
    </xsl:call-template>

	<xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXOuterRadius* $medialScale"/>
        <xsl:with-param name="ry" select="$waYOuterRadius* $medialScale"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="0"/>
        <xsl:with-param name="clockwise" select="1"/>
        <xsl:with-param name="x" select="$waXOuterRadius * $medialScale * (math:cos(.5 * $pi - $hatoAngle - $hatoIntersectAngle) + math:cos($yapinAngle + $yapinIntersectAngle))"/>
        <xsl:with-param name="y" select="(- math:sin(.5 * $pi - $hatoAngle - $hatoIntersectAngle) - math:sin($yapinAngle + $yapinIntersectAngle)) * $waYOuterRadius * $medialScale"/>
    </xsl:call-template>
    
    
    <xsl:call-template name="corner">
		<xsl:with-param name="x" select="$yapinArmDxBelow"/>
        <xsl:with-param name="y" select="-$yapinArmDxBelow * math:tan($yapinAngle)"/>
		<xsl:with-param name="r" select="$cornerInnerRadius"/>
		<xsl:with-param name="nextX" select="0"/>
        <xsl:with-param name="nextY" select="$yapinHeight"/>
	</xsl:call-template>
	<xsl:text>l</xsl:text><xsl:value-of select="-$thickness"/><xsl:text>,0</xsl:text>
	<xsl:call-template name="corner">
		<xsl:with-param name="x" select="0"/>
        <xsl:with-param name="y" select="-$yapinHeight+$thickness * (1 div math:cos($yapinAngle) + math:tan($yapinAngle))"/>
		<xsl:with-param name="r" select="$cornerInnerRadius"/>
		<xsl:with-param name="nextX" select="-$yapinArmDxAbove"/>
        <xsl:with-param name="nextY" select="$yapinArmDxAbove * math:tan($yapinAngle)"/>
	</xsl:call-template>
    
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXOuterRadius* $medialScale"/>
        <xsl:with-param name="ry" select="$waYOuterRadius* $medialScale"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="0"/>
        <xsl:with-param name="clockwise" select="1"/>
        <xsl:with-param name="x" select="-$waXOuterRadius * $medialScale * (math:cos($yapinAngle - $yapinIntersectAngle) + math:cos(.5 * $pi - $hatoAngle))"/>
        <xsl:with-param name="y" select="(math:sin($yapinAngle - $yapinIntersectAngle) + math:sin(.5 * $pi - $hatoAngle)) * $waYOuterRadius * $medialScale"/>
    </xsl:call-template>
    
    
    <xsl:call-template name="corner">
		<xsl:with-param name="x" select="-($hatoLength - $hatoThickness) * math:cos($hatoAngle)"/>
        <xsl:with-param name="y" select="-($hatoLength - $hatoThickness) * math:sin($hatoAngle)"/>
		<xsl:with-param name="r" select="$cornerInnerRadius"/>
		<xsl:with-param name="nextX" select="- $hatoThickness * math:sin($hatoAngle)"/>
        <xsl:with-param name="nextY" select="$hatoThickness * math:cos($hatoAngle)"/>
    </xsl:call-template>
    <xsl:text>l</xsl:text><xsl:value-of select="-$hatoThickness * math:cos($hatoAngle)"/>
	<xsl:text>,</xsl:text><xsl:value-of select="-$hatoThickness * math:sin($hatoAngle)"/>
	<xsl:call-template name="corner">
		<xsl:with-param name="x" select="2 * $hatoThickness * math:sin($hatoAngle)"/>
        <xsl:with-param name="y" select="-2 * $hatoThickness * math:cos($hatoAngle)"/>
        <xsl:with-param name="r" select="$cornerInnerRadius"/>
        <xsl:with-param name="nextX" select="($hatoLength - $waXOuterRadius * $medialScale * math:sin($hatoIntersectAngle)) * math:cos($hatoAngle)"/>
        <xsl:with-param name="nextY" select="($hatoLength - $waXOuterRadius * $medialScale * math:sin($hatoIntersectAngle)) * math:sin($hatoAngle)"/>
    </xsl:call-template>
	<xsl:call-template name="end" />    
    
	<xsl:call-template name="Move">
        <xsl:with-param name="x" select="$xOffset - $postGuard - $waXOuterRadius"/>
        <xsl:with-param name="y" select="$yOffset - $medialPad - $hatoThickness"/>
    </xsl:call-template>
    <xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$waXInnerRadius* $medialScale"/>
        <xsl:with-param name="ry" select="$waYInnerRadius* $medialScale"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="1"/>
        <xsl:with-param name="clockwise" select="0"/>
        <xsl:with-param name="x" select="-1"/>
        <xsl:with-param name="y" select="0"/>
    </xsl:call-template>
	<xsl:call-template name="end" />
	
    </xsl:attribute>
    </xsl:element>
</xsl:template>

</xsl:stylesheet>

