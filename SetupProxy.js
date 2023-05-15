import { BACKEND_URL } from "./src/config/config";

// src/SetupProxy.js
const { createProxyMiddleware } = require("http-proxy-middleware");
module.exports = (app) => {
  app.use(
    "/wss",
    createProxyMiddleware({ target: `http://${BACKEND_URL}`, ws: true })
  );
};
