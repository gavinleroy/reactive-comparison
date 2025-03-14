import react from "@vitejs/plugin-react";
import { defineConfig } from "vite";
import elm from "vite-plugin-elm";
import solid from "vite-plugin-solid";

export default defineConfig(({ mode }) => ({
  base: "./",
  define: {
    "process.env.NODE_ENV": JSON.stringify(mode)
  },
  plugins: [
    react({ include: /\.react(-desugared)?.tsx$/ }),
    solid({ include: /\.solid(-desugared)?.tsx$/ }),
    elm()
  ],
  test: {
    environment: "jsdom",
    deps: {
      inline: [/^(?!.*vitest).*$/]
    }
  }
}));
