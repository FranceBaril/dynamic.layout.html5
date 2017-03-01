<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   exclude-result-prefixes="xs"
   version="2.0">
   <xsl:param name="dita-css" select="'customltr.css'"/> <!-- left to right languages -->
   <xsl:param name="bidi-dita-css" select="'customrtl.css'"/> <!-- bidirectional languages -->
   <xsl:param name="js-path" select="'js/'"></xsl:param>
   <xsl:param name="nav-js" select="'nav.js'"></xsl:param>
   
    <xsl:template match="*" mode="chapterHead">
    <head>
      <!-- initial meta information -->
      <xsl:call-template name="generateCharset"/>   <!-- Set the character set to UTF-8 -->
      <xsl:call-template name="generateDefaultCopyright"/> <!-- Generate a default copyright, if needed -->
      <xsl:call-template name="generateDefaultMeta"/> <!-- Standard meta for security, robots, etc -->
      <xsl:call-template name="getMeta"/>           <!-- Process metadata from topic prolog -->
      <xsl:call-template name="copyright"/>         <!-- Generate copyright, if specified manually -->
      <xsl:call-template name="generateCssLinks"/>  <!-- Generate links to CSS files -->
      <xsl:call-template name="generateChapterTitle"/> <!-- Generate the <title> element -->
      <xsl:call-template name="gen-user-head" />    <!-- include user's XSL HEAD processing here -->
      <xsl:call-template name="gen-user-scripts" /> <!-- include user's XSL javascripts here -->
      <xsl:call-template name="chapterJs"></xsl:call-template>
      <xsl:call-template name="gen-user-styles" />  <!-- include user's XSL style element and content here -->
      <xsl:call-template name="processHDF"/>        <!-- Add user HDF file, if specified -->
    </head>
  </xsl:template>
   
   <xsl:template name="chapterJs">
      <script src="{$PATH2PROJ}{$js-path}{$nav-js}" type="text/javascript"/>
      <!--script>function openNav(){alert('yo');}</script-->
   </xsl:template>
   
   
   <!-- Moving header to main area to keep menu expansion -->
   <xsl:template name="chapterBody">
    <xsl:apply-templates select="." mode="chapterBody"/>
  </xsl:template>
  <xsl:template match="*" mode="chapterBody">
    <body>
      <xsl:apply-templates select="." mode="addAttributesToHtmlBodyElement"/>
      <xsl:call-template name="setaname"/>  <!-- For HTML4 compatibility, if needed -->
      <!--xsl:apply-templates select="." mode="addHeaderToHtmlBodyElement"/-->

      <!-- Include a user's XSL call here to generate a toc based on what's a child of topic -->
      <xsl:call-template name="gen-user-sidetoc"/>

      <xsl:apply-templates select="." mode="addContentToHtmlBodyElement"/>
      <xsl:apply-templates select="." mode="addFooterToHtmlBodyElement"/>
    </body>
  </xsl:template>
   
   <!-- *** Added to change how banner is processed: Not conditional: always shows menu icon *** -->
   <xsl:template match="*" mode="addHeaderToHtmlBodyElement">
    <xsl:variable name="header-content" as="node()*">
      <xsl:call-template name="generateBreadcrumbs"/>
      <xsl:call-template name="gen-user-header"/>  <!-- include user's XSL running header here -->
      <xsl:call-template name="processHDR"/>
      <xsl:if test="$INDEXSHOW = 'yes'">
        <xsl:apply-templates select="/*/*[contains(@class, ' topic/prolog ')]/*[contains(@class, ' topic/metadata ')]/*[contains(@class, ' topic/keywords ')]/*[contains(@class, ' topic/indexterm ')] |
                                     /dita/*[1]/*[contains(@class, ' topic/prolog ')]/*[contains(@class, ' topic/metadata ')]/*[contains(@class, ' topic/keywords ')]/*[contains(@class, ' topic/indexterm ')]"/>
      </xsl:if>
    </xsl:variable>

      <!-- &#160l near closenav is do header doesn't disappear from emptyness -->
      <header role="banner">
         <span id="opennav" href="JavaScript:void(0);" style="font-size:30px;cursor:pointer" onclick="openNav()">&#9776;</span><span>&#160;</span>
         <xsl:if test="exists($header-content)">
        <xsl:sequence select="$header-content"/>
         </xsl:if>
      </header>
    
  </xsl:template>
   
   <!-- Adding id because js love those -->
   <xsl:template match="*" mode="addContentToHtmlBodyElement">
    <main id="main" role="main">
       <xsl:apply-templates select="." mode="addHeaderToHtmlBodyElement"/>
      <article role="article">
        <xsl:attribute name="aria-labelledby">
          <xsl:apply-templates select="*[contains(@class,' topic/title ')] |
                                       self::dita/*[1]/*[contains(@class,' topic/title ')]" mode="return-aria-label-id"/>
        </xsl:attribute>
        <xsl:apply-templates select="*[contains(@class, ' ditaot-d/ditaval-startprop ')]" mode="out-of-line"/>
        <xsl:apply-templates/> 
        <xsl:call-template name="gen-endnotes"/> 
        <xsl:apply-templates select="*[contains(@class, ' ditaot-d/ditaval-endprop ')]" mode="out-of-line"/>
      </article>
    </main>
  </xsl:template>
</xsl:stylesheet>