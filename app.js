var express = require("express");
var app = express();
app.use("/logos", express.static(__dirname + '/logos'));
app.use("/css", express.static(__dirname + '/css'));
app.use("/css/images", express.static(__dirname + '/css/images'));

/* module de base de données créé par nous */
var db = require("db");

var fs = require('fs');

/* Base X server */
var session = db.getSession();

/* XSLT */
var xslt = require('node_xslt');

/* middlewares */
app.use(express.bodyParser());

/* Routing */
app.get("/", function(req, res) {	
	var title = "Handisport à Caen";
	var content = transform("welcome", "<void></void>");	
	end(title, content, res);
});

// affichage d'un seul sport
app.get("/sport/:slug", function(req, res) {
	var slug = req.params.slug;
	db.getSport(slug, function(xml){		
		var content = transform("sport", xml);		
		end("Sport", content, res);		
	});
});

// formulaire ajout
app.get("/update", function(req, res) {
	updateForm(req, res);
});

// formulaire mise à jour
app.get("/update/:slug", function(req, res) {
	updateForm(req, res);
});

function updateForm(req, res) {
	var slug = req.params.slug;
	if(slug) {
		db.getSport(slug, function(sport){
			var content = transform("update", sport);			
			end("Formulaire mise à jour", content, res);
		});		
	} else {
		var content = transform("update", "<sport><description>Insérez une description</description></sport>");
		end("Formulaire mise à jour", content, res);
	}
}

// ajout en base
app.post("/update", function(req, res) {
	updateSport(req, res);
});

// mise à jour en base
app.post("/update/:slug", function(req, res) {
	updateSport(req, res);
});

function updateSport(req, res) {	
	fs.readFile(req.files.logo.path, function (err, data) {
			var imageName = req.files.logo.name;
			var type = req.files.logo.type;
			var image = req.files.logo;
			var newPath = __dirname + "/logos/"+imageName;

		var oldSlug = (req.params.slug) ? req.params.slug : false;		
		db.updateSport(oldSlug, image, req.body, function(err, reply){
			if(err) {
				end("Erreurs", printErrors(reply), res);
			} 
			else {
				  fs.writeFile(newPath, data, function (err) {
	  		});
				res.redirect('/sport/' + reply);
			}	
		});

	}); //fin de l'upload
}

// confirmation avant suppression
app.get("/remove/:slug", function(req, res) {
	var slug = req.params.slug;
	db.deleteSport(slug, function(html){
		//fs.unlinkSync('/tmp/hello');
		res.redirect('/');		
	});
});

// suppression
app.post("/remove", function(req, res) {
	res.send(200, "pas encore implémenté");
});

app.use(function(req, res, next){
	res.send(404, 'page introuvable !');
});

// prend une feuille xslt, du xml et retourne le résultat de la transformation
var transform = function(stylesheetName, xmlString) {
	var stylesheet = xslt.readXsltFile("xslt/" + stylesheetName + ".xslt");
	var doc = xslt.readXmlString(xmlString);
	var transformedString = xslt.transform(stylesheet, doc, []);
	// suppression du prologue xml qui rend invalide le code html
	// transformedString = transformedString.replace(/<\?.*\?>/, "");		
	return transformedString;
}

function end(title, content, res) {
	db.getList(function(list){
		var menu = transform("menu", list);
		res.render("page.ejs", {title : title, content : content, menu : menu});
	});	
}

function printErrors(errors) {
	var ret = "<ul>";
	for(var i=0; i < errors.length; i++) {
		ret += "<li>" + errors[i] + "</li>";
	}
	return ret + "</ul>";
}

app.listen(8080);
