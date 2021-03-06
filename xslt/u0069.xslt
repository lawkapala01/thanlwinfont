<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:svg="http://www.w3.org/2000/svg"
	xmlns="http://www.w3.org/2000/svg"
	xmlns:math="http://exslt.org/math">

<xsl:include href="param.xslt"/>
<xsl:include href="path.xslt"/>

<xsl:variable name="advance">
<xsl:choose>
    <xsl:when test="$fixedWidth &gt; 0">
    <xsl:value-of select="$fixedWidth"/>
    </xsl:when>
    <xsl:otherwise>
    <xsl:value-of select="round($preGuard + $thickness + $postGuard)"/>
    </xsl:otherwise>
</xsl:choose>
</xsl:variable>

<xsl:variable name="overlap" select="0"/>

<xsl:template match="svg:g">
	<xsl:copy use-attribute-sets="gAttribs">
	<xsl:call-template name="u0069"/>
	</xsl:copy>
</xsl:template>

<xsl:template name="u0069">
	<xsl:param name="xOffset" select="0"/>
	<xsl:param name="yOffset" select="0"/>
    <xsl:element name="path" use-attribute-sets="pathAttribs">
    <xsl:attribute name="d">
    <xsl:choose>
        <xsl:when test="$fixedWidth &gt; 0">
            <xsl:call-template name="Move">
                <xsl:with-param name="x" select="$xOffset + round(.5 * $fixedWidth - .5 * $thickness)"/>
                <xsl:with-param name="y" select="$yOffset + 2*$waYOuterRadius"/>
            </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
            <xsl:call-template name="Move">
                <xsl:with-param name="x" select="$xOffset + $preGuard"/>
                <xsl:with-param name="y" select="$yOffset + 2*$waYOuterRadius"/>
            </xsl:call-template>
        </xsl:otherwise>
    </xsl:choose>
    <xsl:text>l</xsl:text><xsl:value-of select="$thickness"/>
    <xsl:text>,0</xsl:text>
    <xsl:text>l0,</xsl:text><xsl:value-of select="-$waYOuterRadius * 2"/>
    <xsl:text>l</xsl:text><xsl:value-of select="-$thickness"/>
    <xsl:text>,0</xsl:text>
	<xsl:text>l0,</xsl:text><xsl:value-of select="$waYOuterRadius * 2"/>
    
	<xsl:call-template name="end"/>
	
	<xsl:choose>
        <xsl:when test="$fixedWidth &gt; 0">
            <xsl:call-template name="Move">
                <xsl:with-param name="x" select="$xOffset + round(.5 * $fixedWidth)"/>
                <xsl:with-param name="y" select="$yOffset + 2*$waYOuterRadius + $upperPad + $latinDotRadius"/>
            </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
            <xsl:call-template name="Move">
                <xsl:with-param name="x" select="$xOffset + $preGuard + .5 * $thickness"/>
                <xsl:with-param name="y" select="$yOffset + 2*$waYOuterRadius + $upperPad + $latinDotRadius"/>
            </xsl:call-template>
        </xsl:otherwise>
    </xsl:choose>
	<xsl:call-template name="arc">
        <xsl:with-param name="rx" select="$latinDotRadius"/>
        <xsl:with-param name="ry" select="$latinDotRadius"/>
        <xsl:with-param name="axisRotation" select="0"/>
        <xsl:with-param name="large" select="1"/>
        <xsl:with-param name="clockwise" select="1"/>
        <xsl:with-param name="x" select="-1"/>
        <xsl:with-param name="y" select="0"/>
    </xsl:call-template>
    
    <xsl:call-template name="end"/>
    
	
    </xsl:attribute>
    </xsl:element>
</xsl:template>

</xsl:stylesheet>
