;; Executes shell thingies for simple project setup

(defun sneaky-execute-in-current-shell (cmd)
  "Execute CMD in the current shell."
  (progn
    (insert cmd)
    (comint-send-input)))

(defun sneaky-prep-shell (shell-name)
  "Checks if shell exists, and creates it in a new window if it does not.
   Then switches to the shell buffer"
  (if (null (get-buffer shell-name))
    (progn
      (split-window-below)
      (shell shell-name))
    (switch-to-buffer-other-window shell-name)
    ))

(defun sneaky-prep-shell-for-command (shell-name)
  "Switches to shell, creating it if it does not exist.
   Then switches to the shell buffer and interrupts the existing command"
  (progn
    (sneaky-prep-shell shell-name)
    (comint-interrupt-subjob)))

(defun sneaky-run-cmd-at-dir-in-shell (shell-name dir cmd)
  "runs command in shell at directory. creating the shell if it does not exist"
  (progn
    (sneaky-prep-shell-for-command shell-name)
    (sneaky-execute-in-current-shell (concat "cd ~/" dir))
    (sneaky-execute-in-current-shell cmd)
    ))

(defun sneaky-init-gaul ()
  (interactive)
  (sneaky-prep-shell "pubsub")
  (sneaky-prep-shell "datastore")
  (sneaky-prep-shell "obelix")
  (sneaky-prep-shell "obelix-app")
  (sneaky-prep-shell "asterix")
  (sneaky-run-cmd-at-dir-in-shell "pubsub" "Development/Simply/src/gaul" "npm run pubsub:start")
  (sneaky-run-cmd-at-dir-in-shell "datastore" "Development/Simply/src/gaul" "npm run datastore:start:linux")
  (sneaky-run-cmd-at-dir-in-shell "obelix" "Development/Simply/src/gaul/obelix" "npm run dev:nobuild")
  (sneaky-run-cmd-at-dir-in-shell "obelix-app" "Development/Simply/src/gaul/obelix/app_cljs" "rlwrap lein figwheel dev")
  (sneaky-run-cmd-at-dir-in-shell "asterix" "Development/Simply/src/gaul/asterix" "npm run dev")
  (dired "~/Development/Simply/src/gaul/")
)

(defun sneaky-update-callcenter-leads ()
  (interactive)
  (sneaky-prep-shell "callcenter-leads")
  (sneaky-run-cmd-at-dir-in-shell "callcenter-leads" "Development/Simply/src/fulliautomatix" "lein run callcentre-lead"))
