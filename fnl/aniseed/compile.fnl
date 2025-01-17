(module aniseed.compile
  {autoload {a aniseed.core
             fs aniseed.fs
             nvim aniseed.nvim
             fennel aniseed.fennel}})

(defn macros-prefix [code opts]
  (let [macros-module :aniseed.macros
        filename (-?> (a.get opts :filename)
                      (string.gsub
                        (.. (nvim.fn.getcwd) "/")
                        ""))]
    (.. "(local *file* "
        (if filename
          (.. "\"" filename "\"")
          "nil")
        ")"
        "(require-macros \"" macros-module "\")\n" code)))

(defn str [code opts]
  "Compile some Fennel code as a string into Lua. Maps to
  fennel.compileString with some wrapping, returns an (ok? result)
  tuple. Automatically requires the Aniseed macros."

  (let [fnl (fennel.impl)]
    (xpcall
      #(fnl.compileString
         (macros-prefix code opts)
         (a.merge {:allowedGlobals false} opts))
      fnl.traceback)))

(defn file [src dest]
  "Compile the source file into the destination file. Will create any
  required ancestor directories for the destination file to exist."
  (let [code (a.slurp src)]
    (match (str code {:filename src})
      (false err) (nvim.err_writeln err)
      (true result) (do
                      (-> dest fs.basename fs.mkdirp)
                      (a.spit dest result)))))

(defn glob [src-expr src-dir dest-dir]
  "Match all files against the src-expr under the src-dir then compile
  them into the dest-dir as Lua."
  (each [_ path (ipairs (fs.relglob src-dir src-expr))]
    (if (fs.macro-file-path? path)
      ;; Copy macro files without compiling
      (->> (.. src-dir path)
           (a.slurp)
           (a.spit (.. dest-dir path)))

      ;; Compile .fnl files to .lua
      (file
        (.. src-dir path)
        (string.gsub
          (.. dest-dir path)
          ".fnl$" ".lua")))))
