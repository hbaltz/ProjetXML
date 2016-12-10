<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:tsi2016="http://www.ensg.eu/tsi2016">

  <xsl:output method="kml" encoding="UTF-8" indent="yes" /> 

  <!-- Starting with the root element -->
  <xsl:template match="/">

    <kml xmlns="http://www.opengis.net/kml/2.2">

      <!-- create a Placemark for each of the Personne in tsi2016 -->
      <Document>
        <xsl:apply-templates select=".//tsi2016:Personne"/>
      </Document>
     

    </kml>
  </xsl:template>
    

  <!-- Calculation for each Personne: -->
  <xsl:template match="tsi2016:Personne">
    
    <!-- We recover the Employeur's id  -->
    <xsl:variable name="idEmp" select="./@employeur"/>
    <!-- We recover the Service's id -->
    <xsl:variable name="idSer" select="./@service"/>
    <!-- We recover the Lieu's id  -->
    <xsl:variable name="idLie" select="./@lieu"/>

    <!-- We recover the Employeur -->
    <xsl:variable name="e" select="../tsi2016:Employeur[@nom=$idEmp]"/>
    <!-- We recover the Direction that contains the Service -->
    <xsl:variable name="d" select="$e/tsi2016:Direction[tsi2016:Service/@nom=$idSer]"/>
    <!-- We recover the Service of the Personne : -->
    <xsl:variable name="s" select="$d/tsi2016:Service[@nom=$idSer]"/>
    <!-- We recover the Lieu  : -->
    <xsl:variable name="l" select="../tsi2016:Lieu[@nom=$idLie]"/>

    <Placemark>
      <name><xsl:value-of select="./@nom"/>&#160;<xsl:value-of select="./@prenom"/></name>
      <description>
        Employeur: <xsl:value-of select="$e/@nom"/>
        Direction: <xsl:value-of select="$d/@nom"/>
        Service: <xsl:value-of select="$s/@nom"/>
        Fonction: <xsl:value-of select="./tsi2016:Fonction/@role"/>
        Lieu: <xsl:value-of select="$l/@nom"/>
        Adresse: <xsl:value-of select="$l/tsi2016:Adresse/@no"/>&#160;<xsl:value-of select="$l/tsi2016:Adresse/@rue" />&#160;<xsl:value-of select="$l/tsi2016:Adresse/@codePostal" />&#160;<xsl:value-of select="$l/tsi2016:Adresse/@ville" />
      </description>

      <Point>
        <coordinates><xsl:value-of select="$l/tsi2016:Coordonnee/@long"/>,<xsl:value-of select="$l/tsi2016:Coordonnee/@lat"/></coordinates>
      </Point>
    </Placemark>
 
  </xsl:template>

</xsl:stylesheet>

