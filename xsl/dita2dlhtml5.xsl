<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   exclude-result-prefixes="xs"
   version="2.0">
   
   <xsl:import href="dita2dlhtml5Impl.xsl"/>
  <xsl:import href="topic.xsl"/>
  
  <xsl:output method="html"
              encoding="UTF-8"
              indent="no"
              doctype-system="about:legacy-compat"
              omit-xml-declaration="yes"/>

  <!-- root rule -->
  <xsl:template match="/">
    <xsl:apply-templates/>
  </xsl:template>
   
   <!--xsl:template match="*[contains(@class, 'topic/p')]">
      <p style="color:pink"><xsl:apply-templates></xsl:apply-templates></p>
   </xsl:template-->
</xsl:stylesheet>