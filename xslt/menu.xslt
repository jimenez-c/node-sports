<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="yes"/>
	<xsl:template match="/liste">
		<div class="menu">
			<ul>
				<xsl:for-each select="sport">
					<li>
						<a>
							<xsl:attribute name="href">/sport/<xsl:value-of select="slug" /></xsl:attribute>
							<xsl:value-of select="title" />
						</a>
					</li>
				</xsl:for-each>	
			</ul>
		</div>
	</xsl:template>
</xsl:stylesheet>