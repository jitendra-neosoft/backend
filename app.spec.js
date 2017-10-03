const chai = require('chai');
const expect = chai.expect;
var request = require('supertest');
var app = require('./app');

describe('/get program details', function(){
    this.timeout(25000);
    it('it shoould show program details', function(done){
        request(app)
        .get('/program/getprogram')
        .send({'language':'java'})
        .expect(200)
        .end(function(err, res){
            if(err){
                return done(err);
            }
            console.log(res.body);
            expect(res.body.data);
            done();
        })
    })
})