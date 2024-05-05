/// <reference types="vitest" />
/// <reference types="vite/client" />

import { defineConfig } from "vite";
import createReactPlugin from "@vitejs/plugin-react";
import createReScriptPlugin from "@jihchi/vite-plugin-rescript";
import path from "path";

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [createReactPlugin(), createReScriptPlugin()],
  resolve: {
    alias: {
      "@": path.resolve(__dirname, "./"),
    },
  },
});
