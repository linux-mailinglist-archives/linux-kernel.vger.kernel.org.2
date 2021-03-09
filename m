Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6D51332548
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 13:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbhCIMSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 07:18:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbhCIMSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 07:18:04 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C47C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 04:18:04 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id j6-20020a17090adc86b02900cbfe6f2c96so5097765pjv.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 04:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YMe1Reipq+pUMVMRE0+FPXbOWOU/b1ED4qcuTqK1ghc=;
        b=Y19ZHseAo6Hf+XdFmH7G5u/kWcQ4ebnMvUX6r09EJ9aqY9k/NwFkPobPVlUCn5qOvI
         57C3uzWoJHrcbgUg9oWpAm25++WM7LFK9OZa1uubE8w7B+9YsoykbAHh2KYyMDds6n10
         oToGKC1wwGZm5EWe30wo9Szge/KP/0hthWBcYV1OVpfIxNpnzp7uZezHLPudJjw7wenP
         H5wdXe1ev44I3XyucVKdZwzIClnKqV5j300tqkUH3HDfot0I+tsov7UmBxp2sQg0B5QN
         mE9meH3F5f7YWhVeQDVCg1IOr2e2xPoZQtennF7irnxKXbLOTggXndXQElv0T3PxFNKr
         +1qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YMe1Reipq+pUMVMRE0+FPXbOWOU/b1ED4qcuTqK1ghc=;
        b=r08xLP+q6w1ME/7L8R9x3QfarHEhxPqlKMpmq3bENe2x55amyl34q+kz8fhkm58cMD
         1aKfKjdY8HH1wcA4yMFrVANl3ZSDF/V0pRW7fHg9ZIEmrr3teiAi+tCmu+pErpmPBM3x
         C3e88TM/zXUV10WIORtfKmxve0Yz0b+aPUKoebQ2gfvIo6ns1FdtYR+S1hONiIVrJr4x
         9gy3kqg9twvFM0zGedcv9/HLh7PBQGfTcKqBfyhnfUwaJLwQpPvlQ4m9rdeenLwk65IL
         mF4c3UfgPYteKOjI16iGLLIVeSfdOWZTGbnVfG4iaS15BniHc95tq8RD3DbnzrwTBHjw
         PdOw==
X-Gm-Message-State: AOAM5339QXPME+f6WQK9GfomCMpd/62TR1d71YdBAk6z4rFMCTZJu8cw
        0c2dbEEJMGTHiZFLWABTKymh8g==
X-Google-Smtp-Source: ABdhPJyy5HCirQAKbPH84rJgbw/RcNuoEn37oDc5e3m8yWMb2Cy5JXXi3yOxfCIoRnM9B4hQacBZ3A==
X-Received: by 2002:a17:90a:4381:: with SMTP id r1mr4769515pjg.20.1615292284114;
        Tue, 09 Mar 2021 04:18:04 -0800 (PST)
Received: from localhost.localdomain ([27.56.151.62])
        by smtp.gmail.com with ESMTPSA id x190sm13338787pfx.166.2021.03.09.04.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 04:18:03 -0800 (PST)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     kgdb-bugreport@lists.sourceforge.net
Cc:     daniel.thompson@linaro.org, jason.wessel@windriver.com,
        dianders@chromium.org, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH] kdb: Refactor kdb_defcmd implementation
Date:   Tue,  9 Mar 2021 17:47:47 +0530
Message-Id: <20210309121747.859823-1-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to use kdbtab_t instead of separate struct defcmd_set since
now we have kdb_register_table() to register pre-allocated kdb commands.

Also, switch to use a linked list for sub-commands instead of dynamic
array which makes traversing the sub-commands list simpler.

Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 kernel/debug/kdb/kdb_main.c    | 136 +++++++++++++++------------------
 kernel/debug/kdb/kdb_private.h |   7 ++
 2 files changed, 70 insertions(+), 73 deletions(-)

diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index 9d69169582c6..2f54e81fd9f7 100644
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
@@ -678,16 +677,7 @@ static void kdb_cmderror(int diag)
  * Returns:
  *	zero for success, a kdb diagnostic if error
  */
-struct defcmd_set {
-	int count;
-	bool usable;
-	char *name;
-	char *usage;
-	char *help;
-	char **command;
-};
-static struct defcmd_set *defcmd_set;
-static int defcmd_set_count;
+static kdbtab_t *defcmd_set;
 static bool defcmd_in_progress;
 
 /* Forward references */
@@ -695,53 +685,52 @@ static int kdb_exec_defcmd(int argc, const char **argv);
 
 static int kdb_defcmd2(const char *cmdstr, const char *argv0)
 {
-	struct defcmd_set *s = defcmd_set + defcmd_set_count - 1;
-	char **save_command = s->command;
+	struct kdb_subcmd *ks;
+
+	if (!defcmd_set)
+		return KDB_NOTIMP;
+
 	if (strcmp(argv0, "endefcmd") == 0) {
 		defcmd_in_progress = false;
-		if (!s->count)
-			s->usable = false;
-		if (s->usable)
-			/* macros are always safe because when executed each
-			 * internal command re-enters kdb_parse() and is
-			 * safety checked individually.
-			 */
-			kdb_register_flags(s->name, kdb_exec_defcmd, s->usage,
-					   s->help, 0,
-					   KDB_ENABLE_ALWAYS_SAFE);
+		if (!list_empty(&defcmd_set->kdb_scmds_head))
+			kdb_register_table(defcmd_set, 1);
 		return 0;
 	}
-	if (!s->usable)
-		return KDB_NOTIMP;
-	s->command = kcalloc(s->count + 1, sizeof(*(s->command)), GFP_KDB);
-	if (!s->command) {
+
+	ks = kmalloc(sizeof(*ks), GFP_KDB);
+	if (!ks) {
 		kdb_printf("Could not allocate new kdb_defcmd table for %s\n",
 			   cmdstr);
-		s->usable = false;
 		return KDB_NOTIMP;
 	}
-	memcpy(s->command, save_command, s->count * sizeof(*(s->command)));
-	s->command[s->count++] = kdb_strdup(cmdstr, GFP_KDB);
-	kfree(save_command);
+
+	ks->scmd_name = kdb_strdup(cmdstr, GFP_KDB);
+	list_add_tail(&ks->list_node, &defcmd_set->kdb_scmds_head);
+
 	return 0;
 }
 
 static int kdb_defcmd(int argc, const char **argv)
 {
-	struct defcmd_set *save_defcmd_set = defcmd_set, *s;
 	if (defcmd_in_progress) {
 		kdb_printf("kdb: nested defcmd detected, assuming missing "
 			   "endefcmd\n");
 		kdb_defcmd2("endefcmd", "endefcmd");
 	}
 	if (argc == 0) {
-		int i;
-		for (s = defcmd_set; s < defcmd_set + defcmd_set_count; ++s) {
-			kdb_printf("defcmd %s \"%s\" \"%s\"\n", s->name,
-				   s->usage, s->help);
-			for (i = 0; i < s->count; ++i)
-				kdb_printf("%s", s->command[i]);
-			kdb_printf("endefcmd\n");
+		kdbtab_t *kp;
+		struct kdb_subcmd *ks;
+
+		list_for_each_entry(kp, &kdb_cmds_head, list_node) {
+			if (kp->cmd_func == kdb_exec_defcmd) {
+				kdb_printf("defcmd %s \"%s\" \"%s\"\n",
+					   kp->cmd_name, kp->cmd_usage,
+					   kp->cmd_help);
+				list_for_each_entry(ks, &kp->kdb_scmds_head,
+						    list_node)
+					kdb_printf("%s", ks->scmd_name);
+				kdb_printf("endefcmd\n");
+			}
 		}
 		return 0;
 	}
@@ -751,45 +740,42 @@ static int kdb_defcmd(int argc, const char **argv)
 		kdb_printf("Command only available during kdb_init()\n");
 		return KDB_NOTIMP;
 	}
-	defcmd_set = kmalloc_array(defcmd_set_count + 1, sizeof(*defcmd_set),
-				   GFP_KDB);
+	defcmd_set = kzalloc(sizeof(*defcmd_set), GFP_KDB);
 	if (!defcmd_set)
 		goto fail_defcmd;
-	memcpy(defcmd_set, save_defcmd_set,
-	       defcmd_set_count * sizeof(*defcmd_set));
-	s = defcmd_set + defcmd_set_count;
-	memset(s, 0, sizeof(*s));
-	s->usable = true;
-	s->name = kdb_strdup(argv[1], GFP_KDB);
-	if (!s->name)
+
+	defcmd_set->cmd_func = kdb_exec_defcmd;
+	defcmd_set->cmd_minlen = 0;
+	defcmd_set->cmd_flags = KDB_ENABLE_ALWAYS_SAFE;
+	defcmd_set->cmd_name = kdb_strdup(argv[1], GFP_KDB);
+	if (!defcmd_set->cmd_name)
 		goto fail_name;
-	s->usage = kdb_strdup(argv[2], GFP_KDB);
-	if (!s->usage)
+	defcmd_set->cmd_usage = kdb_strdup(argv[2], GFP_KDB);
+	if (!defcmd_set->cmd_usage)
 		goto fail_usage;
-	s->help = kdb_strdup(argv[3], GFP_KDB);
-	if (!s->help)
+	defcmd_set->cmd_help = kdb_strdup(argv[3], GFP_KDB);
+	if (!defcmd_set->cmd_help)
 		goto fail_help;
-	if (s->usage[0] == '"') {
-		strcpy(s->usage, argv[2]+1);
-		s->usage[strlen(s->usage)-1] = '\0';
+	if (defcmd_set->cmd_usage[0] == '"') {
+		strcpy(defcmd_set->cmd_usage, argv[2]+1);
+		defcmd_set->cmd_usage[strlen(defcmd_set->cmd_usage)-1] = '\0';
 	}
-	if (s->help[0] == '"') {
-		strcpy(s->help, argv[3]+1);
-		s->help[strlen(s->help)-1] = '\0';
+	if (defcmd_set->cmd_help[0] == '"') {
+		strcpy(defcmd_set->cmd_help, argv[3]+1);
+		defcmd_set->cmd_help[strlen(defcmd_set->cmd_help)-1] = '\0';
 	}
-	++defcmd_set_count;
+
+	INIT_LIST_HEAD(&defcmd_set->kdb_scmds_head);
 	defcmd_in_progress = true;
-	kfree(save_defcmd_set);
 	return 0;
 fail_help:
-	kfree(s->usage);
+	kfree(defcmd_set->cmd_usage);
 fail_usage:
-	kfree(s->name);
+	kfree(defcmd_set->cmd_name);
 fail_name:
 	kfree(defcmd_set);
 fail_defcmd:
 	kdb_printf("Could not allocate new defcmd_set entry for %s\n", argv[1]);
-	defcmd_set = save_defcmd_set;
 	return KDB_NOTIMP;
 }
 
@@ -804,25 +790,29 @@ static int kdb_defcmd(int argc, const char **argv)
  */
 static int kdb_exec_defcmd(int argc, const char **argv)
 {
-	int i, ret;
-	struct defcmd_set *s;
+	int ret;
+	kdbtab_t *kp;
+	struct kdb_subcmd *ks;
+
 	if (argc != 0)
 		return KDB_ARGCOUNT;
-	for (s = defcmd_set, i = 0; i < defcmd_set_count; ++i, ++s) {
-		if (strcmp(s->name, argv[0]) == 0)
+
+	list_for_each_entry(kp, &kdb_cmds_head, list_node) {
+		if (strcmp(kp->cmd_name, argv[0]) == 0)
 			break;
 	}
-	if (i == defcmd_set_count) {
+	if (list_entry_is_head(kp, &kdb_cmds_head, list_node)) {
 		kdb_printf("kdb_exec_defcmd: could not find commands for %s\n",
 			   argv[0]);
 		return KDB_NOTIMP;
 	}
-	for (i = 0; i < s->count; ++i) {
-		/* Recursive use of kdb_parse, do not use argv after
-		 * this point */
+	list_for_each_entry(ks, &kp->kdb_scmds_head, list_node) {
+		/*
+		 * Recursive use of kdb_parse, do not use argv after this point.
+		 */
 		argv = NULL;
-		kdb_printf("[%s]kdb> %s\n", s->name, s->command[i]);
-		ret = kdb_parse(s->command[i]);
+		kdb_printf("[%s]kdb> %s\n", kp->cmd_name, ks->scmd_name);
+		ret = kdb_parse(ks->scmd_name);
 		if (ret)
 			return ret;
 	}
diff --git a/kernel/debug/kdb/kdb_private.h b/kernel/debug/kdb/kdb_private.h
index ec91d7e02334..a8bda278c9c1 100644
--- a/kernel/debug/kdb/kdb_private.h
+++ b/kernel/debug/kdb/kdb_private.h
@@ -13,6 +13,7 @@
  */
 
 #include <linux/kgdb.h>
+#include <linux/list.h>
 #include "../debug_core.h"
 
 /* Kernel Debugger Command codes.  Must not overlap with error codes. */
@@ -164,6 +165,11 @@ typedef struct _kdb_bp {
 #ifdef CONFIG_KGDB_KDB
 extern kdb_bp_t kdb_breakpoints[/* KDB_MAXBPT */];
 
+struct kdb_subcmd {
+	char    *scmd_name;		/* Sub-command name */
+	struct  list_head list_node;	/* Sub-command node */
+};
+
 /* The KDB shell command table */
 typedef struct _kdbtab {
 	char    *cmd_name;		/* Command name */
@@ -175,6 +181,7 @@ typedef struct _kdbtab {
 	kdb_cmdflags_t cmd_flags;	/* Command behaviour flags */
 	struct list_head list_node;	/* Command list */
 	bool    is_dynamic;		/* Command table allocation type */
+	struct list_head kdb_scmds_head; /* Sub-commands list */
 } kdbtab_t;
 
 extern void kdb_register_table(kdbtab_t *kp, size_t len);
-- 
2.25.1

