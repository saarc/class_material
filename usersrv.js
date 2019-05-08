const express = require('express');
const bodyParser = require('body-parser');
const querystring = require('querystring');

const app = express();
app.listen(8080, () => {
    console.log('Server is Running at http://localhost:8080');
});

app.use(bodyParser.urlencoded({
    extended:false
}));

let userCounter = 0;
const users = [];

app.get('/user', (req, res) => {
    res.send(users);
});

app.post('/user', (req, res) =>{
    const body = req.body;

    if(!body.name)
        return res.status(400).send('name is required');
    else if(!body.region)
        return res.status(400).send('region  is required');
    
    const name = body.name;
    const region = body.region;

    const data = {
        id: userCounter++,
        name: name,
        region: region
    };
    users.push(data);

    res.send(data);
});

app.get('/user/:id', (req, res) => {
    const id = req.params.id;
    const filtered = users.filter((user) => user.id == id);

    if(filtered.length == 1)
        res.send(filtered[0])
    else
        res.status(404).send('data is not found');
});

app.put('/user/:id', (req, res) => {
    const id = req.params.id;
    let isExist = false;
    //body = querystring.parse(req.body);

    users.forEach((user) => {
        if(user.id == id) {
            isExist = true;
            if (req.body.name)
                users[id].name = req.body.name;
            if (req.body.region)
                users[id].region = req.body.region;
            console.error('exist');
            res.send(user);
        }
    });

    if(!isExist)
        res.status(404).send('data is not found');
});

app.delete('/user/:id', (req, res) => {
    const id = req.params.id;
    let deleteUser = null;

    for(let i = users.length -1; i >= 0; i--){
        if(users[i].id == id){
            deletedUser = users[i].name;
            users.splice(i, 1);
            break;
        }
    }

    if(deletedUser)
        res.send(deletedUser+" is deleted");
    else
        res.status(404).send('data is not found');
});
