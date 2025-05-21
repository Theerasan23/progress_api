const mysql = require('mysql2');
const sql = require('mssql');
const oracledb = require('oracledb');
require('dotenv').config();

class Database {
  constructor() {
    this.dbType = process.env.SELECT_DB;
    this.connection = null;
    this.initConnection();
  }

  initConnection() {
    switch (this.dbType) {
      case 'MySQL':
        this.connection = mysql.createConnection({
          host: process.env.MYSQL_HOST,
          user: process.env.MYSQL_USER,
          password: process.env.MYSQL_PASSWORD,
          database: process.env.MYSQL_DATABASE,
        });
        this.connection.connect((err) => {
          if (err) {
            console.error('MySQL connection error:', err);
          } else {
            console.log('Connected to MySQL');
          }
        });
        break;

      case 'SQLServer':
        this.connection = sql.connect({
          user: process.env.SQL_SERVER_USER,
          password: process.env.SQL_SERVER_PASSWORD,
          server: process.env.SQL_SERVER_HOST,
          database: process.env.SQL_SERVER_DATABASE,
          options: {
            encrypt: true,
            trustServerCertificate: true,
          },
        }).then(() => {
          console.log('Connected to SQL Server');
        }).catch(err => {
          console.error('SQL Server connection error:', err);
        });
        break;

      case 'Oracle':
        this.connection = oracledb.getConnection({
          user: process.env.ORACLE_USER,
          password: process.env.ORACLE_PASSWORD,
          connectionString: process.env.ORACLE_CONNECTION_STRING,
        }).then(() => {
          console.log('Connected to Oracle');
        }).catch(err => {
          console.error('Oracle connection error:', err);
        });
        break;

      default:
        throw new Error('Invalid database type specified in .env file');
    }
  }

  async select(query, params) {
    try {
      let result;
      switch (this.dbType) {
        case 'MySQL':
          result = await this.queryMySQL(query, params);
          break;

        case 'SQLServer':
          result = await this.querySQLServer(query, params);
          break;

        case 'Oracle':
          result = await this.queryOracle(query, params);
          break;

        default:
          throw new Error('Invalid database type');
      }
      return result;
    } catch (error) {
      throw error;
    }
  }

  // Other methods (insert, update, delete) remain unchanged...

  queryMySQL(query, params) {
    return new Promise((resolve, reject) => {
      this.connection.query(query, params, (err, results) => {
        if (err) return reject(err);
        resolve(results);
      });
    });
  }

  async querySQLServer(query, params) {
    try {
      const request = new sql.Request();
      if (params) {
        params.forEach((param, index) => {
          request.input(`param${index}`, param);
        });
      }
      const result = await request.query(query);
      return result.recordset;
    } catch (error) {
      throw error;
    }
  }

  async queryOracle(query, params) {
    let connection;
    try {
      connection = await oracledb.getConnection({
        user: process.env.ORACLE_USER,
        password: process.env.ORACLE_PASSWORD,
        connectionString: process.env.ORACLE_CONNECTION_STRING,
      });

      // Ensure params is an array
      const result = await connection.execute(query, Array.isArray(params) ? params : {});
      return result.rows;
    } catch (error) {
      throw error;
    } finally {
      if (connection) {
        try {
          await connection.close();
        } catch (err) {
          console.error(err);
        }
      }
    }
  }
}

module.exports = Database;