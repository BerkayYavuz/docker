const express = require('express');
const app = express();
const PORT = process.env.PORT || 3000;

app.get('/' , (req, res) => {
	res.send('merhaba');


});


app.listen(PORT, () => {

	console.log(`Sunucu ${PORT} portunda çalışıyor`);
});
