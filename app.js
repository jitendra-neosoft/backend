const express = require('express');
const app = express();
const bodyParser = require('body-parser');
const mysql = require('mysql');
const async = require('async');

const fs = require('fs');
const path = require('path');
const swaggerTools = require('swagger-tools');
const jsyaml = require('js-yaml');

let spec = fs.readFileSync(path.join(__dirname,'api_docs/swagger.yaml'), 'utf8');
let swaggerDoc = jsyaml.safeLoad(spec);

swaggerTools.initializeMiddleware(swaggerDoc, function (middleware) {
    app.use(middleware.swaggerUi());
})

var conection = mysql.createConnection({
    host: process.env.host || "localhost",
    user: process.env.user || "root",
    password: process.env.password || "",
    database: process.env.database || "seqdb"
});
conection.connect(function (err) {
    if (err) throw err;
    console.log("Connected!");
});

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));

app.use(function (req, res, next) {
    let log = (req.method === 'POST') ? req.body : req.query;
    let id = log.id;
    let versionno = log.versionno;
    let client = log.client;
    let appname = log.appname;
    let language = log.language;
    let timestamp = log.timestamp;
    conection.query("insert into requestlogs (id, versionno, client, appname, language, timestamp) values (?, ?, ?, ?, ?, ?)", [id, versionno, client, appname, language, new Date()], function (err, result, fields) {
        next();
    });
})

app.post('/program/saveprogram', function (req, res) {

    let programname = req.body.programname;
    let programdescription = req.body.programdescription;
    let programcategory = req.body.programcategory;
    let Descimagebase64 = req.body.Descimagebase64;
    let Descimageurl = req.body.Descimageurl;
    let code = req.body.code;
    let exampleoutput = req.body.exampleoutput;
    let difficultyleve = req.body.difficultyleve;
    let input = req.body.input;
    let output = req.body.output;
    let Isrunnable = req.body.Isrunnable;

    async.waterfall([
        function (done) {
            conection.query("SELECT max(id) as max FROM categories", function (err, result, fields) {
                if (err) {
                    return done(err);
                }
                var cat_id = result[0].max + 1;
                done(null, cat_id);
            })
        },
        function (cat_id, done) {
            conection.query("insert into categories (id, cat_name, category_sequence, featureid) values (?, ?, ?, ?)", [cat_id, programcategory, 1, 1], function (err, result, fields) {
                if (err) {
                    return done(err);
                }
                done(null, cat_id);
            })
        },
        function (cat_id, done) {
            conection.query("SELECT max(id) as max FROM programs", function (err, result, fields) {
                if (err) {
                    return done(err);
                }
                var prog_id = result[0].max + 1;
                done(null, cat_id, prog_id);
            });
        },
        function (cat_id, prog_id, done) {
            conection.query("insert into programs(id, program_name, program_description, program_category, description_image_base64, description_image_url) values (?, ?, ?, ?, ?, ?)", [prog_id, programname, programdescription, cat_id, Descimagebase64, Descimageurl], function (err, result, fields) {
                if (err) {
                    return done(err);
                }
                done(null, cat_id, prog_id);
            })
        },
        function (cat_id, prog_id, done) {
            conection.query("SELECT max(id) as max FROM program_details", function (err, result, fields) {
                if (err) {
                    return done(err);
                }
                var prog_det_id = result[0].max + 1;
                done(null, cat_id, prog_id, prog_det_id);
            });
        },
        function (cat_id, prog_id, prog_det_id, done) {
            conection.query("insert into program_details(id, lang_id, prog_id, code, codewithoutcomments, codewithoutlogic, exampleoutput, difficultylevel, exampleoutputtype, isrunnable, canbeusedforchallenges) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", [prog_det_id, '1', prog_id, code, '', '', exampleoutput, difficultyleve, '', Isrunnable, ''], function (err, result, fields) {
                if (err) {
                    return done(err);
                }
                done(null, cat_id, prog_id, prog_det_id);
            })
        },
        function (cat_id, prog_id, prog_det_id, done) {
            conection.query("SELECT max(id) as max FROM program_ios", function (err, result, fields) {
                if (err) {
                    return done(err);
                }
                var io_id = result[0].max + 1;
                done(null, cat_id, prog_id, prog_det_id, io_id);
            });
        },
        function (cat_id, prog_id, prog_det_id, io_id, done) {
            conection.query("insert into program_ios(id, prog_id, input, output) values (?, ?, ?, ?)", [io_id, prog_det_id, input, output], function (err, result, fields) {
                if (err) {
                    return done(err);
                }
                done();
            });
        }
    ], function (err) {
        if (err) {
            return res.status(500).send({ "message": "ERROR", "reason": err });
        }
        return res.status(200).send({ "message": "SUCCESS", "reason": "" });
    });
});

app.get('/program/getprogram', function (req, res) {

    let language = req.query.language;

    let send_data = {
        language: language,
        category: [],
        name: [],
        desc: [],
        program: [],
        output: [],
        input: [],
        runnable: [],
        message: '',
        reason: ''
    };

    let query = "select program_details.id as prog_det_id, program_details.isrunnable as runnable, program_details.code, programs.program_name, programs.program_description, categories.cat_name, program_ios.input, program_ios.output from program_details INNER JOIN languages ON  languages.id=program_details.lang_id INNER JOIN programs ON program_details.prog_id=programs.id INNER JOIN categories ON categories.id=programs.program_category INNER JOIN program_ios ON program_ios.prog_id=program_details.id where languages.lang_name=?";
    conection.query(query, [language], function (err, result, fields) {
        if(err){
            send_data.language = "";
            send_data.message = "FAILURE";
            send_data.reason = err;
            return res.status(500).send(send_data);
        }
        for (var i = 0; i < result.length; i++) {
            var row = result[i];
            send_data.category.push(row.cat_name);
            send_data.name.push(row.program_name);
            send_data.desc.push(row.program_description);
            send_data.program.push(row.code);
            send_data.output.push(row.output);
            send_data.input.push(row.input);
            send_data.runnable.push(row.runnable);
        }
        res.status(200).send(send_data);
    });
});

app.get('/program/getprogramwithproc', function (req, res) {

    let language = req.query.language;

    let send_data = {
        language: language,
        category: [],
        name: [],
        desc: [],
        program: [],
        output: [],
        input: [],
        runnable: [],
        message: '',
        reason: ''
    };

    let query = "CALL getprogram(?)";
    conection.query(query, [language], function (err, result, fields) {
        if (err) {
            send_data.language = "";
            send_data.message = "FAILURE";
            send_data.reason = err;
            return res.status(500).send(send_data);
        }
        for (var i = 0; i < result[0].length; i++) {
            var row = result[0][i];
            send_data.category.push(row.cat_name);
            send_data.name.push(row.program_name);
            send_data.desc.push(row.program_description);
            send_data.program.push(row.code);
            send_data.output.push(row.output);
            send_data.input.push(row.input);
            send_data.runnable.push(row.runnable);
        }
        res.status(200).send(send_data);
    });
});
    

app.listen(3000, function () {
    console.log('App is listening on port 3000');
});

module.exports = app;