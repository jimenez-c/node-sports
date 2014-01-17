<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="yes"/>
	<xsl:template match="/sport">

		<h2><xsl:value-of select="title" /></h2>

		<p class="description"><xsl:value-of select="description" /></p>

		<xsl:if test="count(links/link) &gt; 0">
			<ul>
				<xsl:for-each select="links/link">
					<li>
						<a href="{.}"><xsl:value-of select="." /></a>					
					</li>
				</xsl:for-each>
			</ul>
		</xsl:if>		

		<xsl:if test="count(clubs/club) &gt; 0">
			<h4>Plus d'informations :</h4>
			<div class="clubs">
				<xsl:for-each select="clubs/club">
					<h3><xsl:value-of select="name" /></h3>
					<xsl:if test="count(logo) = 1">
						<img src="/logos/{logo}" alt="Logo du {name}" class="tailleImg" />						
					</xsl:if>
					<dl>
					<xsl:if test="manager">
						<dt>Responsable</dt><dd><xsl:value-of select="manager" /></dd>
					</xsl:if>
					<xsl:if test="address">
						<dt>Adresse</dt><dd><xsl:value-of select="address" /></dd>
					</xsl:if>	
					<xsl:if test="phone">
						<dt>Téléphone</dt>
						<dd>
							<xsl:choose>
								<xsl:when test="count(phone) = 1">
									<xsl:value-of select="phone" />
								</xsl:when>
								<xsl:otherwise>
									<ul>
										<xsl:for-each select="phone">
											<li><xsl:value-of select="." /></li>
										</xsl:for-each>
									</ul>
								</xsl:otherwise>
							</xsl:choose>
						</dd>
					</xsl:if>
					<xsl:if test="mail">
						<dt>Adresse e-mail</dt><dd><xsl:value-of select="mail" /></dd>
					</xsl:if>
					<xsl:if test="website"> 
					 <dt>Site internet</dt><dd><a href="{website}"><xsl:value-of select="website" /></a></dd>
					</xsl:if>

						
					</dl>
				</xsl:for-each>
			</div>
		</xsl:if>

		<div class="actions">
			<a href="/update/{slug}" class="modif">Modifier</a>				
			<a href="/remove/{slug}" class="supp" onclick="return confirm('Voulez-vous vraiment supprimer ce sport ?')">Supprimer</a>				
		</div>	
	</xsl:template>
</xsl:stylesheet>