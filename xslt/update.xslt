<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:template match="/sport">
		<div class="post">			

			<h1>Ajouter un sport</h1>

			<form action="/update/{slug}" method="post" enctype="multipart/form-data">
				<p>
					<label for="title">Nom du sport</label>
					<input id="title" type="text" name="title" value="{title}" />
				</p>
				
				<p><label for="description">Description</label>
					<textarea id="description" name="description" cols="60" rows="20"><xsl:value-of select="description"/></textarea>
				</p>

				<p>
					<label for="link">Lien (un seul pr l'instant)</label>
					<input id="link" type="text" name="link" value="{links/link}"/>
				</p>

				<p>Information sur les clubs : (un seul pr l'instant) </p>

				<p>
					<label for="name">Nom du club</label>
					<input id="name" type="text" name="name" value="{clubs/club/name}" />
				</p>

				<p>
					<label for="manager">Responsable</label>
					<input id="manager" type="text" name="manager" value="{clubs/club/manager}" />
				</p>

				<p>
					<label for="address">Adresse</label>
					<input id="address" type="text" name="address" value="{clubs/club/address}" />
				</p>

				<p>
					<label for="phone">Téléphone</label>
					<input id="phone" type="text" name="phone" value="{clubs/club/phone}" />
				</p>

				<p>
					<label for="mail">Adresse e-mail</label>
					<input id="mail" type="text" name="mail" value="{clubs/club/mail}" />
				</p>

				<p>
					<label for="website">Site internet</label>
					<input id="website" type="text" name="website" value="{clubs/club/website}"/>
				</p>

				<p>
					<input id="imgLogo" type="hidden" name="imgLogo" value="{clubs/club/logo}" />
				</p>
				<p>
					<xsl:if test="clubs/club/logo">
						<img src="/logos/{clubs/club/logo}" alt="{clubs/club/name}" width="170"/>
					</xsl:if>	
					<label for="logo">Logo du club</label>
					<input id="logo" type="file" name="logo"/>
				</p>

				<input type="submit" />
				
			</form>	
		</div>			
	</xsl:template>
</xsl:stylesheet>