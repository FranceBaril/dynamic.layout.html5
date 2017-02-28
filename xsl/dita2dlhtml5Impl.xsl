<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">

  <!-- Start with HTML5 plugin -->
  <xsl:import href="plugin:org.dita.html5:xsl/dita2html5Impl.xsl"/>
  <xsl:import href="topic.xsl"/>

  <!-- root rule -->
  <xsl:template xmlns:dita="http://dita-ot.sourceforge.net" match="/">
    <xsl:apply-templates/>
  </xsl:template>
  
</xsl:stylesheet>