const express = require('express');
const cors = require('cors');
const rateLimit = require('express-rate-limit');
const { Pool } = require('pg');
require('dotenv').config();

const app = express();
const PORT = process.env.API_PORT || 4322;
const application_id = process.env.APPLICATION_ID;
const authentication = process.env.API_AUTHENTICATION_BEARER;

const allowedOrigins = [
  'https://xxxxxxxxxx.th',
  'http://localhost:3000'
];

app.set('trust proxy', 1);
const limiter = rateLimit({
  windowMs: 15 * 60 * 1000,
  max: 300,
  message: 'มีการร้องขอมากเกินไป โปรดลองใหม่ภายหลัง'
});

app.use(limiter);
app.use(cors({
  origin: function (origin, callback) {
    
    if (!origin || allowedOrigins.includes(origin)) {
      callback(null, true);
    } else {
      callback(new Error('Not allowed by CORS'));
    }
  },
  methods: ['GET', 'POST', 'PUT', 'DELETE'],
  allowedHeaders: ['Content-Type', 'Authorization']
}));

app.use(express.json());

const pool = new Pool({
  user: process.env.PG_USER,
  host: process.env.PG_HOST,
  database: process.env.PG_DATABASE,
  password: process.env.PG_PASSWORD,
  port: process.env.PG_PORT || 5432,
});

pool.connect()
  .then(() => {
    console.log('Connected to PostgreSQL');
  })
  .catch(err => {
    console.error('PostgreSQL connection error:', err.stack);
  });


app.get('/', async (req, res) => {
  try {
    const result = await pool.query('SELECT id, name, total, price, d_buy, d_update FROM public.crypto_buy');
    res.json(result.rows);
  } catch (err) {
    console.error('Error executing query:', err);
    res.status(500).json({ error: 'Database query error' });
  }
});

app.get('/get', async (req, res) => {
  try {

    const condition = "SELECT id, name, total, price, d_buy, d_update FROM public.crypto_buy";

    const result = await pool.query(condition);
    res.json(result.rows);
  } catch (err) {
    console.error('Error executing query:', err);
    res.status(500).json({ error: 'Database query error' });
  }
});


app.post('/get', async (req, res) => {
  try {


    
    const condition = "SELECT id, name, total, price, d_buy, d_update FROM public.crypto_buy";

    const result = await pool.query(condition);
    res.json(result.rows);
  } catch (err) {
    console.error('Error executing query:', err);
    res.status(500).json({ error: 'Database query error' });
  }
});


app.post('/post', async (req, res) => {
  try {

    const { id , name } = req.body;
    

    const result = await pool.query('SELECT id, name, total, price, d_buy, d_update FROM public.crypto_buy where id=$1  and name=$2',
      [id,name]);
    res.status(200).json(result.rows);
  } catch (err) {
    console.error('Error executing query:', err);
    res.status(500).json({ error: 'Database query error' });
  }
});

app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});