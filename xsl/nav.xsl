<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   exclude-result-prefixes="xs"
   version="2.0">
   
   
   <!-- Adding @id to nav toc because .js likes to work with ids. -->
   <xsl:template match="*" mode="gen-user-sidetoc">
    <xsl:if test="$nav-toc = ('partial', 'full')">
      <nav id="navtoc" role="toc">
        <div><span id="closenav" onclick="closeNav()">X</span></div>
        <ul>
          <xsl:choose>
            <xsl:when test="$nav-toc = 'partial'">
              <xsl:apply-templates select="$current-topicrefs[1]" mode="toc-pull">
                <xsl:with-param name="pathFromMaplist" select="$PATH2PROJ" as="xs:string"/>
                <xsl:with-param name="children" as="element()*">
                  <xsl:apply-templates select="$current-topicrefs[1]/*[contains(@class, ' map/topicref ')]" mode="toc">
                    <xsl:with-param name="pathFromMaplist" select="$PATH2PROJ" as="xs:string"/>
                  </xsl:apply-templates>
                </xsl:with-param>
              </xsl:apply-templates>
            </xsl:when>
            <xsl:when test="$nav-toc = 'full'">
              <xsl:apply-templates select="$input.map" mode="toc">
                <xsl:with-param name="pathFromMaplist" select="$PATH2PROJ" as="xs:string"/>
              </xsl:apply-templates>
            </xsl:when>
          </xsl:choose>
        </ul>
      </nav>
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>