Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 087713C5D9E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 15:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234923AbhGLNti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 09:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234495AbhGLNth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 09:49:37 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6380C0613DD
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 06:46:48 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id h4so18286011pgp.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 06:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X39Zn6ifNoXfst3hgP/wkM+8Q6BFz1kUsfMCGnikBrY=;
        b=xNpmDaZBWAxNq2+kIatyxLDSK7GsARQSvYe9RergKHCmNPXydjv2qWQpPHIqd0UHk4
         4UCLY3vyajae0MmPLxcnhPf0kjbQF0RxnpW3aqelH0pXfqpEJ5VG1UsLxJ6Q9vbJtvBH
         CjE7oWjZ46zDKL5++656AicjA+G8W+y15F1WkRIyuGa1XA4711FAEvlGAF6BX03Fl1u0
         52pxot4vteN/xePuNEt0wvEqEIGm9OcQMqO0AJ91UWR1NsfmZMf03l3EHLc4pzOIXRpG
         /rZL0fj+UFj6MX+yL6tR5rOkmBayGNgzNmWjNKwRpSxrr5YAL6jW1QNXYEiGdanlfXoO
         CI0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X39Zn6ifNoXfst3hgP/wkM+8Q6BFz1kUsfMCGnikBrY=;
        b=Z8wxa/EKA+es2/uiKHBCgxHlwX5Wezf3Z4tcndoaExabhw6RkOn7fI7v/go+blsixm
         M+BQ9ZvEJTVfhQS56PhpfjIxwmO1qtLa/3/A7YTCi4riHl4sRQRL0CBpgIWf0wmnymSK
         1Y8oL2P4vZStA+vZbQsykdZ6cJVs2ZQacZP6QRoxKLsILAjYWeEBMhwf0JALd0fT6+39
         lnrkas/Gzw7Nyse9ZrLeOu6muDdg2occ1NJN98KcpkBiIoTjPb0L/SojNC9cJwYByHmS
         Tj3hE0amr6r5MOXGk5pmHiVIwPRn0dJuemaF8IwcHufQ7hFOvIDmUcDZbTxFNE/iJuwx
         nhUg==
X-Gm-Message-State: AOAM5320B/kVugH077Setwnoqq8Rm5r3XjQJyTZghmqhSxipd48LMjB1
        fVyxcey0GISYuP+sOCx1ZYz7PA==
X-Google-Smtp-Source: ABdhPJykDczkXUm7BJHsk9Upap4/FqeghsWb8lZnNVFBJKUrtDeA85bKv7LBu4G/gWhEZcAmb4k6kw==
X-Received: by 2002:a63:1244:: with SMTP id 4mr43483908pgs.334.1626097608280;
        Mon, 12 Jul 2021 06:46:48 -0700 (PDT)
Received: from localhost.localdomain ([223.178.210.84])
        by smtp.gmail.com with ESMTPSA id z13sm835405pfn.94.2021.07.12.06.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 06:46:47 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     kgdb-bugreport@lists.sourceforge.net
Cc:     daniel.thompson@linaro.org, jason.wessel@windriver.com,
        dianders@chromium.org, rostedt@goodmis.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v5 2/4] kdb: Get rid of redundant kdb_register_flags()
Date:   Mon, 12 Jul 2021 19:16:18 +0530
Message-Id: <20210712134620.276667-3-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210712134620.276667-1-sumit.garg@linaro.org>
References: <20210712134620.276667-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit e4f291b3f7bb ("kdb: Simplify kdb commands registration")
allowed registration of pre-allocated kdb commands with pointer to
struct kdbtab_t. Lets switch other users as well to register pre-
allocated kdb commands via:
- Changing prototype for kdb_register() to pass a pointer to struct
  kdbtab_t instead.
- Embed kdbtab_t structure in kdb_macro_t rather than individual params.

With these changes kdb_register_flags() becomes redundant and hence
removed. Also, since we have switched all users to register
pre-allocated commands, "is_dynamic" flag in struct kdbtab_t becomes
redundant and hence removed as well.

Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
 include/linux/kdb.h            |  27 ++++--
 kernel/debug/kdb/kdb_main.c    | 167 +++++++++++----------------------
 kernel/debug/kdb/kdb_private.h |  13 ---
 kernel/trace/trace_kdb.c       |  12 ++-
 samples/kdb/kdb_hello.c        |  20 ++--
 5 files changed, 88 insertions(+), 151 deletions(-)

diff --git a/include/linux/kdb.h b/include/linux/kdb.h
index 0125a677b67f..de858edfb3b8 100644
--- a/include/linux/kdb.h
+++ b/include/linux/kdb.h
@@ -13,6 +13,8 @@
  * Copyright (C) 2009 Jason Wessel <jason.wessel@windriver.com>
  */
 
+#include <linux/list.h>
+
 /* Shifted versions of the command enable bits are be used if the command
  * has no arguments (see kdb_check_flags). This allows commands, such as
  * go, to have different permissions depending upon whether it is called
@@ -64,6 +66,17 @@ typedef enum {
 
 typedef int (*kdb_func_t)(int, const char **);
 
+/* The KDB shell command table */
+typedef struct _kdbtab {
+	char    *cmd_name;		/* Command name */
+	kdb_func_t cmd_func;		/* Function to execute command */
+	char    *cmd_usage;		/* Usage String for this command */
+	char    *cmd_help;		/* Help message for this command */
+	short    cmd_minlen;		/* Minimum legal # cmd chars required */
+	kdb_cmdflags_t cmd_flags;	/* Command behaviour flags */
+	struct list_head list_node;	/* Command list */
+} kdbtab_t;
+
 #ifdef	CONFIG_KGDB_KDB
 #include <linux/init.h>
 #include <linux/sched.h>
@@ -193,19 +206,13 @@ static inline const char *kdb_walk_kallsyms(loff_t *pos)
 #endif /* ! CONFIG_KALLSYMS */
 
 /* Dynamic kdb shell command registration */
-extern int kdb_register(char *, kdb_func_t, char *, char *, short);
-extern int kdb_register_flags(char *, kdb_func_t, char *, char *,
-			      short, kdb_cmdflags_t);
-extern int kdb_unregister(char *);
+extern int kdb_register(kdbtab_t *cmd);
+extern void kdb_unregister(kdbtab_t *cmd);
 #else /* ! CONFIG_KGDB_KDB */
 static inline __printf(1, 2) int kdb_printf(const char *fmt, ...) { return 0; }
 static inline void kdb_init(int level) {}
-static inline int kdb_register(char *cmd, kdb_func_t func, char *usage,
-			       char *help, short minlen) { return 0; }
-static inline int kdb_register_flags(char *cmd, kdb_func_t func, char *usage,
-				     char *help, short minlen,
-				     kdb_cmdflags_t flags) { return 0; }
-static inline int kdb_unregister(char *cmd) { return 0; }
+static inline int kdb_register(kdbtab_t *cmd) { return 0; }
+static inline void kdb_unregister(kdbtab_t *cmd) {}
 #endif	/* CONFIG_KGDB_KDB */
 enum {
 	KDB_NOT_INITIALIZED,
diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index 5cf9867fa118..b2880fad26d4 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -33,7 +33,6 @@
 #include <linux/kallsyms.h>
 #include <linux/kgdb.h>
 #include <linux/kdb.h>
-#include <linux/list.h>
 #include <linux/notifier.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
@@ -657,9 +656,7 @@ static void kdb_cmderror(int diag)
 struct kdb_macro {
 	int count;
 	bool usable;
-	char *name;
-	char *usage;
-	char *help;
+	kdbtab_t cmd;
 	char **command;
 };
 static struct kdb_macro *kdb_macro;
@@ -678,13 +675,7 @@ static int kdb_defcmd2(const char *cmdstr, const char *argv0)
 		if (!s->count)
 			s->usable = false;
 		if (s->usable)
-			/* macros are always safe because when executed each
-			 * internal command re-enters kdb_parse() and is
-			 * safety checked individually.
-			 */
-			kdb_register_flags(s->name, kdb_exec_defcmd, s->usage,
-					   s->help, 0,
-					   KDB_ENABLE_ALWAYS_SAFE);
+			kdb_register(&s->cmd);
 		return 0;
 	}
 	if (!s->usable)
@@ -705,6 +696,8 @@ static int kdb_defcmd2(const char *cmdstr, const char *argv0)
 static int kdb_defcmd(int argc, const char **argv)
 {
 	struct kdb_macro *save_kdb_macro = kdb_macro, *s;
+	kdbtab_t *mp;
+
 	if (defcmd_in_progress) {
 		kdb_printf("kdb: nested defcmd detected, assuming missing "
 			   "endefcmd\n");
@@ -713,8 +706,8 @@ static int kdb_defcmd(int argc, const char **argv)
 	if (argc == 0) {
 		int i;
 		for (s = kdb_macro; s < kdb_macro + kdb_macro_count; ++s) {
-			kdb_printf("defcmd %s \"%s\" \"%s\"\n", s->name,
-				   s->usage, s->help);
+			kdb_printf("defcmd %s \"%s\" \"%s\"\n", s->cmd.cmd_name,
+				   s->cmd.cmd_usage, s->cmd.cmd_help);
 			for (i = 0; i < s->count; ++i)
 				kdb_printf("%s", s->command[i]);
 			kdb_printf("endefcmd\n");
@@ -736,31 +729,36 @@ static int kdb_defcmd(int argc, const char **argv)
 	s = kdb_macro + kdb_macro_count;
 	memset(s, 0, sizeof(*s));
 	s->usable = true;
-	s->name = kdb_strdup(argv[1], GFP_KDB);
-	if (!s->name)
+
+	mp = &s->cmd;
+	mp->cmd_func = kdb_exec_defcmd;
+	mp->cmd_minlen = 0;
+	mp->cmd_flags = KDB_ENABLE_ALWAYS_SAFE;
+	mp->cmd_name = kdb_strdup(argv[1], GFP_KDB);
+	if (!mp->cmd_name)
 		goto fail_name;
-	s->usage = kdb_strdup(argv[2], GFP_KDB);
-	if (!s->usage)
+	mp->cmd_usage = kdb_strdup(argv[2], GFP_KDB);
+	if (!mp->cmd_usage)
 		goto fail_usage;
-	s->help = kdb_strdup(argv[3], GFP_KDB);
-	if (!s->help)
+	mp->cmd_help = kdb_strdup(argv[3], GFP_KDB);
+	if (!mp->cmd_help)
 		goto fail_help;
-	if (s->usage[0] == '"') {
-		strcpy(s->usage, argv[2]+1);
-		s->usage[strlen(s->usage)-1] = '\0';
+	if (mp->cmd_usage[0] == '"') {
+		strcpy(mp->cmd_usage, argv[2]+1);
+		mp->cmd_usage[strlen(mp->cmd_usage)-1] = '\0';
 	}
-	if (s->help[0] == '"') {
-		strcpy(s->help, argv[3]+1);
-		s->help[strlen(s->help)-1] = '\0';
+	if (mp->cmd_help[0] == '"') {
+		strcpy(mp->cmd_help, argv[3]+1);
+		mp->cmd_help[strlen(mp->cmd_help)-1] = '\0';
 	}
 	++kdb_macro_count;
 	defcmd_in_progress = true;
 	kfree(save_kdb_macro);
 	return 0;
 fail_help:
-	kfree(s->usage);
+	kfree(mp->cmd_usage);
 fail_usage:
-	kfree(s->name);
+	kfree(mp->cmd_name);
 fail_name:
 	kfree(kdb_macro);
 fail_defcmd:
@@ -785,7 +783,7 @@ static int kdb_exec_defcmd(int argc, const char **argv)
 	if (argc != 0)
 		return KDB_ARGCOUNT;
 	for (s = kdb_macro, i = 0; i < kdb_macro_count; ++i, ++s) {
-		if (strcmp(s->name, argv[0]) == 0)
+		if (strcmp(s->cmd.cmd_name, argv[0]) == 0)
 			break;
 	}
 	if (i == kdb_macro_count) {
@@ -797,7 +795,7 @@ static int kdb_exec_defcmd(int argc, const char **argv)
 		/* Recursive use of kdb_parse, do not use argv after
 		 * this point */
 		argv = NULL;
-		kdb_printf("[%s]kdb> %s\n", s->name, s->command[i]);
+		kdb_printf("[%s]kdb> %s\n", s->cmd.cmd_name, s->command[i]);
 		ret = kdb_parse(s->command[i]);
 		if (ret)
 			return ret;
@@ -2613,56 +2611,32 @@ static int kdb_grep_help(int argc, const char **argv)
 	return 0;
 }
 
-/*
- * kdb_register_flags - This function is used to register a kernel
- * 	debugger command.
- * Inputs:
- *	cmd	Command name
- *	func	Function to execute the command
- *	usage	A simple usage string showing arguments
- *	help	A simple help string describing command
- *	repeat	Does the command auto repeat on enter?
- * Returns:
- *	zero for success, one if a duplicate command.
+/**
+ * kdb_register() - This function is used to register a kernel debugger
+ *                  command.
+ * @cmd: pointer to kdb command
+ *
+ * Note that it's the job of the caller to keep the memory for the cmd
+ * allocated until unregister is called.
  */
-int kdb_register_flags(char *cmd,
-		       kdb_func_t func,
-		       char *usage,
-		       char *help,
-		       short minlen,
-		       kdb_cmdflags_t flags)
+int kdb_register(kdbtab_t *cmd)
 {
 	kdbtab_t *kp;
 
 	list_for_each_entry(kp, &kdb_cmds_head, list_node) {
-		if (strcmp(kp->cmd_name, cmd) == 0) {
-			kdb_printf("Duplicate kdb command registered: "
-				"%s, func %px help %s\n", cmd, func, help);
+		if (strcmp(kp->cmd_name, cmd->cmd_name) == 0) {
+			kdb_printf("Duplicate kdb cmd: %s, func %p help %s\n",
+				   cmd->cmd_name, cmd->cmd_func, cmd->cmd_help);
 			return 1;
 		}
 	}
 
-	kp = kmalloc(sizeof(*kp), GFP_KDB);
-	if (!kp) {
-		kdb_printf("Could not allocate new kdb_command table\n");
-		return 1;
-	}
-
-	kp->cmd_name   = cmd;
-	kp->cmd_func   = func;
-	kp->cmd_usage  = usage;
-	kp->cmd_help   = help;
-	kp->cmd_minlen = minlen;
-	kp->cmd_flags  = flags;
-	kp->is_dynamic = true;
-
-	list_add_tail(&kp->list_node, &kdb_cmds_head);
-
+	list_add_tail(&cmd->list_node, &kdb_cmds_head);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(kdb_register_flags);
+EXPORT_SYMBOL_GPL(kdb_register);
 
-/*
+/**
  * kdb_register_table() - This function is used to register a kdb command
  *                        table.
  * @kp: pointer to kdb command table
@@ -2676,55 +2650,15 @@ void kdb_register_table(kdbtab_t *kp, size_t len)
 	}
 }
 
-/*
- * kdb_register - Compatibility register function for commands that do
- *	not need to specify a repeat state.  Equivalent to
- *	kdb_register_flags with flags set to 0.
- * Inputs:
- *	cmd	Command name
- *	func	Function to execute the command
- *	usage	A simple usage string showing arguments
- *	help	A simple help string describing command
- * Returns:
- *	zero for success, one if a duplicate command.
- */
-int kdb_register(char *cmd,
-	     kdb_func_t func,
-	     char *usage,
-	     char *help,
-	     short minlen)
-{
-	return kdb_register_flags(cmd, func, usage, help, minlen, 0);
-}
-EXPORT_SYMBOL_GPL(kdb_register);
-
-/*
- * kdb_unregister - This function is used to unregister a kernel
- *	debugger command.  It is generally called when a module which
- *	implements kdb commands is unloaded.
- * Inputs:
- *	cmd	Command name
- * Returns:
- *	zero for success, one command not registered.
+/**
+ * kdb_unregister() - This function is used to unregister a kernel debugger
+ *                    command. It is generally called when a module which
+ *                    implements kdb command is unloaded.
+ * @cmd: pointer to kdb command
  */
-int kdb_unregister(char *cmd)
+void kdb_unregister(kdbtab_t *cmd)
 {
-	kdbtab_t *kp;
-
-	/*
-	 *  find the command.
-	 */
-	list_for_each_entry(kp, &kdb_cmds_head, list_node) {
-		if (strcmp(kp->cmd_name, cmd) == 0) {
-			list_del(&kp->list_node);
-			if (kp->is_dynamic)
-				kfree(kp);
-			return 0;
-		}
-	}
-
-	/* Couldn't find it.  */
-	return 1;
+	list_del(&cmd->list_node);
 }
 EXPORT_SYMBOL_GPL(kdb_unregister);
 
@@ -2900,6 +2834,11 @@ static kdbtab_t maintab[] = {
 		.cmd_func = kdb_defcmd,
 		.cmd_usage = "name \"usage\" \"help\"",
 		.cmd_help = "Define a set of commands, down to endefcmd",
+		/*
+		 * Macros are always safe because when executed each
+		 * internal command re-enters kdb_parse() and is safety
+		 * checked individually.
+		 */
 		.cmd_flags = KDB_ENABLE_ALWAYS_SAFE,
 	},
 	{	.cmd_name = "kill",
diff --git a/kernel/debug/kdb/kdb_private.h b/kernel/debug/kdb/kdb_private.h
index 8dbc840113c9..629590084a0d 100644
--- a/kernel/debug/kdb/kdb_private.h
+++ b/kernel/debug/kdb/kdb_private.h
@@ -164,19 +164,6 @@ typedef struct _kdb_bp {
 #ifdef CONFIG_KGDB_KDB
 extern kdb_bp_t kdb_breakpoints[/* KDB_MAXBPT */];
 
-/* The KDB shell command table */
-typedef struct _kdbtab {
-	char    *cmd_name;		/* Command name */
-	kdb_func_t cmd_func;		/* Function to execute command */
-	char    *cmd_usage;		/* Usage String for this command */
-	char    *cmd_help;		/* Help message for this command */
-	short    cmd_minlen;		/* Minimum legal # command
-					 * chars required */
-	kdb_cmdflags_t cmd_flags;	/* Command behaviour flags */
-	struct list_head list_node;	/* Command list */
-	bool    is_dynamic;		/* Command table allocation type */
-} kdbtab_t;
-
 extern void kdb_register_table(kdbtab_t *kp, size_t len);
 extern int kdb_bt(int, const char **);	/* KDB display back trace */
 
diff --git a/kernel/trace/trace_kdb.c b/kernel/trace/trace_kdb.c
index 9da76104f7a2..6c4f92c79e43 100644
--- a/kernel/trace/trace_kdb.c
+++ b/kernel/trace/trace_kdb.c
@@ -147,11 +147,17 @@ static int kdb_ftdump(int argc, const char **argv)
 	return 0;
 }
 
+static kdbtab_t ftdump_cmd = {
+	.cmd_name = "ftdump",
+	.cmd_func = kdb_ftdump,
+	.cmd_usage = "[skip_#entries] [cpu]",
+	.cmd_help = "Dump ftrace log; -skip dumps last #entries",
+	.cmd_flags = KDB_ENABLE_ALWAYS_SAFE,
+};
+
 static __init int kdb_ftrace_register(void)
 {
-	kdb_register_flags("ftdump", kdb_ftdump, "[skip_#entries] [cpu]",
-			    "Dump ftrace log; -skip dumps last #entries", 0,
-			    KDB_ENABLE_ALWAYS_SAFE);
+	kdb_register(&ftdump_cmd);
 	return 0;
 }
 
diff --git a/samples/kdb/kdb_hello.c b/samples/kdb/kdb_hello.c
index c1c2fa0f62c2..9ad514a6648b 100644
--- a/samples/kdb/kdb_hello.c
+++ b/samples/kdb/kdb_hello.c
@@ -28,28 +28,26 @@ static int kdb_hello_cmd(int argc, const char **argv)
 	return 0;
 }
 
+static kdbtab_t hello_cmd = {
+	.cmd_name = "hello",
+	.cmd_func = kdb_hello_cmd,
+	.cmd_usage = "[string]",
+	.cmd_help = "Say Hello World or Hello [string]",
+};
 
 static int __init kdb_hello_cmd_init(void)
 {
 	/*
 	 * Registration of a dynamically added kdb command is done with
-	 * kdb_register() with the arguments being:
-	 *   1: The name of the shell command
-	 *   2: The function that processes the command
-	 *   3: Description of the usage of any arguments
-	 *   4: Descriptive text when you run help
-	 *   5: Number of characters to complete the command
-	 *      0 == type the whole command
-	 *      1 == match both "g" and "go" for example
+	 * kdb_register().
 	 */
-	kdb_register("hello", kdb_hello_cmd, "[string]",
-		     "Say Hello World or Hello [string]", 0);
+	kdb_register(&hello_cmd);
 	return 0;
 }
 
 static void __exit kdb_hello_cmd_exit(void)
 {
-	kdb_unregister("hello");
+	kdb_unregister(&hello_cmd);
 }
 
 module_init(kdb_hello_cmd_init);
-- 
2.25.1

