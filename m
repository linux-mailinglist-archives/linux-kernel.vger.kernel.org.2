Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC6F63C5DA0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 15:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234959AbhGLNtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 09:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234495AbhGLNtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 09:49:45 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC622C0613DD
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 06:46:56 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id o3-20020a17090a6783b0290173ce472b8aso1659501pjj.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 06:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OnzwxHp7cMjwvjyWxFiyP8uatD6C2HWu2yP99+aGv9Y=;
        b=D1BB3kOzwo4y0ya1jrCX9QRM2CZTOWXZeVd0L/Mo+BWIjE9yFaf4Wfx0P8XDnWHTBp
         63hNrSXx9Ub6lR+pyQiTtDZK7j+30AazEF3dlvv8EsDfniYWbM2O0KTY471/DrgASj0k
         P1NsXfKH15v8Qz06yRuUCjOwIWgoBF4oteT/Rq06WH6u6uCNiZAzc1LUeQ3eVE+O95zx
         6iu4VM8yBoc1nVHbiqZozX57ylxZHxWrqUMVfe7cd7GG5PNbBa8GdY51O/ICDzP2IPwe
         n6nBa/sCkEF3rS714Hn/i3iJ84TVgsAbkhgXTdu53SP2HOXM/8hVnXNSlnUEcDAKiVq0
         PbqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OnzwxHp7cMjwvjyWxFiyP8uatD6C2HWu2yP99+aGv9Y=;
        b=gx3pr4J40G7DpY0ifa936yZHoIFdubyrp9jAj2GwiyqBgavUd0VHwx04a6Qrv/IRdj
         vNtsBIxoXUsIPNwknqwRABuZ+it9AF4lMAwut3tgOFGPLHJRofghBaYCQeBdmVD2N2Dx
         VbqhJJ66tNQrwpX+MbOmaqaETVOWlhkZ7YCR5+wR5S4q+A8mDsK1zfI4BPIMJWu0njqZ
         ed9+et2fJClX1wxJC5gLCCL1UIGE+32yPbPtPaceEsLbM+V2vEV1ZhfnT1l7Y8Ra5xf9
         GdlaI1q7NRZhgPc8owFGBPYRX6xUFDVT9gkzH7UDBnE6z47dUSL9ifnXucMXp+8Ward8
         2M3Q==
X-Gm-Message-State: AOAM530pgsxhWAOi80WUE4Wl93Xc6rkkkHBX8LsPBFwkcrQctYOTXg2O
        wBQTVzOKSc1+ZtwYPePPaExKhQ==
X-Google-Smtp-Source: ABdhPJzepLEwAlkOuVL9gKv+Al2/KxrAakfeeHCxKq/Keb6IySksKU0k5w885Cwl0q2XNSzH+Pk1yg==
X-Received: by 2002:a17:90a:bd04:: with SMTP id y4mr14461655pjr.127.1626097616434;
        Mon, 12 Jul 2021 06:46:56 -0700 (PDT)
Received: from localhost.localdomain ([223.178.210.84])
        by smtp.gmail.com with ESMTPSA id z13sm835405pfn.94.2021.07.12.06.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 06:46:55 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     kgdb-bugreport@lists.sourceforge.net
Cc:     daniel.thompson@linaro.org, jason.wessel@windriver.com,
        dianders@chromium.org, rostedt@goodmis.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v5 4/4] kdb: Rename members of struct kdbtab_t
Date:   Mon, 12 Jul 2021 19:16:20 +0530
Message-Id: <20210712134620.276667-5-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210712134620.276667-1-sumit.garg@linaro.org>
References: <20210712134620.276667-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove redundant prefix "cmd_" from name of members in struct kdbtab_t
for better readibility.

Suggested-by: Doug Anderson <dianders@chromium.org>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
 include/linux/kdb.h         |  12 +-
 kernel/debug/kdb/kdb_bp.c   |  72 +++----
 kernel/debug/kdb/kdb_main.c | 404 ++++++++++++++++++------------------
 kernel/trace/trace_kdb.c    |  10 +-
 samples/kdb/kdb_hello.c     |   8 +-
 5 files changed, 252 insertions(+), 254 deletions(-)

diff --git a/include/linux/kdb.h b/include/linux/kdb.h
index de858edfb3b8..ea0f5e580fac 100644
--- a/include/linux/kdb.h
+++ b/include/linux/kdb.h
@@ -68,12 +68,12 @@ typedef int (*kdb_func_t)(int, const char **);
 
 /* The KDB shell command table */
 typedef struct _kdbtab {
-	char    *cmd_name;		/* Command name */
-	kdb_func_t cmd_func;		/* Function to execute command */
-	char    *cmd_usage;		/* Usage String for this command */
-	char    *cmd_help;		/* Help message for this command */
-	short    cmd_minlen;		/* Minimum legal # cmd chars required */
-	kdb_cmdflags_t cmd_flags;	/* Command behaviour flags */
+	char    *name;			/* Command name */
+	kdb_func_t func;		/* Function to execute command */
+	char    *usage;			/* Usage String for this command */
+	char    *help;			/* Help message for this command */
+	short    minlen;		/* Minimum legal # cmd chars required */
+	kdb_cmdflags_t flags;		/* Command behaviour flags */
 	struct list_head list_node;	/* Command list */
 } kdbtab_t;
 
diff --git a/kernel/debug/kdb/kdb_bp.c b/kernel/debug/kdb/kdb_bp.c
index 2168f8dacb99..372025cf1ca3 100644
--- a/kernel/debug/kdb/kdb_bp.c
+++ b/kernel/debug/kdb/kdb_bp.c
@@ -523,51 +523,51 @@ static int kdb_ss(int argc, const char **argv)
 }
 
 static kdbtab_t bptab[] = {
-	{	.cmd_name = "bp",
-		.cmd_func = kdb_bp,
-		.cmd_usage = "[<vaddr>]",
-		.cmd_help = "Set/Display breakpoints",
-		.cmd_flags = KDB_ENABLE_FLOW_CTRL | KDB_REPEAT_NO_ARGS,
+	{	.name = "bp",
+		.func = kdb_bp,
+		.usage = "[<vaddr>]",
+		.help = "Set/Display breakpoints",
+		.flags = KDB_ENABLE_FLOW_CTRL | KDB_REPEAT_NO_ARGS,
 	},
-	{	.cmd_name = "bl",
-		.cmd_func = kdb_bp,
-		.cmd_usage = "[<vaddr>]",
-		.cmd_help = "Display breakpoints",
-		.cmd_flags = KDB_ENABLE_FLOW_CTRL | KDB_REPEAT_NO_ARGS,
+	{	.name = "bl",
+		.func = kdb_bp,
+		.usage = "[<vaddr>]",
+		.help = "Display breakpoints",
+		.flags = KDB_ENABLE_FLOW_CTRL | KDB_REPEAT_NO_ARGS,
 	},
-	{	.cmd_name = "bc",
-		.cmd_func = kdb_bc,
-		.cmd_usage = "<bpnum>",
-		.cmd_help = "Clear Breakpoint",
-		.cmd_flags = KDB_ENABLE_FLOW_CTRL,
+	{	.name = "bc",
+		.func = kdb_bc,
+		.usage = "<bpnum>",
+		.help = "Clear Breakpoint",
+		.flags = KDB_ENABLE_FLOW_CTRL,
 	},
-	{	.cmd_name = "be",
-		.cmd_func = kdb_bc,
-		.cmd_usage = "<bpnum>",
-		.cmd_help = "Enable Breakpoint",
-		.cmd_flags = KDB_ENABLE_FLOW_CTRL,
+	{	.name = "be",
+		.func = kdb_bc,
+		.usage = "<bpnum>",
+		.help = "Enable Breakpoint",
+		.flags = KDB_ENABLE_FLOW_CTRL,
 	},
-	{	.cmd_name = "bd",
-		.cmd_func = kdb_bc,
-		.cmd_usage = "<bpnum>",
-		.cmd_help = "Disable Breakpoint",
-		.cmd_flags = KDB_ENABLE_FLOW_CTRL,
+	{	.name = "bd",
+		.func = kdb_bc,
+		.usage = "<bpnum>",
+		.help = "Disable Breakpoint",
+		.flags = KDB_ENABLE_FLOW_CTRL,
 	},
-	{	.cmd_name = "ss",
-		.cmd_func = kdb_ss,
-		.cmd_usage = "",
-		.cmd_help = "Single Step",
-		.cmd_minlen = 1,
-		.cmd_flags = KDB_ENABLE_FLOW_CTRL | KDB_REPEAT_NO_ARGS,
+	{	.name = "ss",
+		.func = kdb_ss,
+		.usage = "",
+		.help = "Single Step",
+		.minlen = 1,
+		.flags = KDB_ENABLE_FLOW_CTRL | KDB_REPEAT_NO_ARGS,
 	},
 };
 
 static kdbtab_t bphcmd = {
-	.cmd_name = "bph",
-	.cmd_func = kdb_bp,
-	.cmd_usage = "[<vaddr>]",
-	.cmd_help = "[datar [length]|dataw [length]]   Set hw brk",
-	.cmd_flags = KDB_ENABLE_FLOW_CTRL | KDB_REPEAT_NO_ARGS,
+	.name = "bph",
+	.func = kdb_bp,
+	.usage = "[<vaddr>]",
+	.help = "[datar [length]|dataw [length]]   Set hw brk",
+	.flags = KDB_ENABLE_FLOW_CTRL | KDB_REPEAT_NO_ARGS,
 };
 
 /* Initialize the breakpoint table and register	breakpoint commands. */
diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index 7c7a2ef834fc..fa6deda894a1 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -711,10 +711,9 @@ static int kdb_defcmd(int argc, const char **argv)
 		struct kdb_macro_statement *kms;
 
 		list_for_each_entry(kp, &kdb_cmds_head, list_node) {
-			if (kp->cmd_func == kdb_exec_defcmd) {
+			if (kp->func == kdb_exec_defcmd) {
 				kdb_printf("defcmd %s \"%s\" \"%s\"\n",
-					   kp->cmd_name, kp->cmd_usage,
-					   kp->cmd_help);
+					   kp->name, kp->usage, kp->help);
 				kmp = container_of(kp, struct kdb_macro, cmd);
 				list_for_each_entry(kms, &kmp->statements,
 						    list_node)
@@ -735,34 +734,34 @@ static int kdb_defcmd(int argc, const char **argv)
 		goto fail_defcmd;
 
 	mp = &kdb_macro->cmd;
-	mp->cmd_func = kdb_exec_defcmd;
-	mp->cmd_minlen = 0;
-	mp->cmd_flags = KDB_ENABLE_ALWAYS_SAFE;
-	mp->cmd_name = kdb_strdup(argv[1], GFP_KDB);
-	if (!mp->cmd_name)
+	mp->func = kdb_exec_defcmd;
+	mp->minlen = 0;
+	mp->flags = KDB_ENABLE_ALWAYS_SAFE;
+	mp->name = kdb_strdup(argv[1], GFP_KDB);
+	if (!mp->name)
 		goto fail_name;
-	mp->cmd_usage = kdb_strdup(argv[2], GFP_KDB);
-	if (!mp->cmd_usage)
+	mp->usage = kdb_strdup(argv[2], GFP_KDB);
+	if (!mp->usage)
 		goto fail_usage;
-	mp->cmd_help = kdb_strdup(argv[3], GFP_KDB);
-	if (!mp->cmd_help)
+	mp->help = kdb_strdup(argv[3], GFP_KDB);
+	if (!mp->help)
 		goto fail_help;
-	if (mp->cmd_usage[0] == '"') {
-		strcpy(mp->cmd_usage, argv[2]+1);
-		mp->cmd_usage[strlen(mp->cmd_usage)-1] = '\0';
+	if (mp->usage[0] == '"') {
+		strcpy(mp->usage, argv[2]+1);
+		mp->usage[strlen(mp->usage)-1] = '\0';
 	}
-	if (mp->cmd_help[0] == '"') {
-		strcpy(mp->cmd_help, argv[3]+1);
-		mp->cmd_help[strlen(mp->cmd_help)-1] = '\0';
+	if (mp->help[0] == '"') {
+		strcpy(mp->help, argv[3]+1);
+		mp->help[strlen(mp->help)-1] = '\0';
 	}
 
 	INIT_LIST_HEAD(&kdb_macro->statements);
 	defcmd_in_progress = true;
 	return 0;
 fail_help:
-	kfree(mp->cmd_usage);
+	kfree(mp->usage);
 fail_usage:
-	kfree(mp->cmd_name);
+	kfree(mp->name);
 fail_name:
 	kfree(kdb_macro);
 fail_defcmd:
@@ -790,7 +789,7 @@ static int kdb_exec_defcmd(int argc, const char **argv)
 		return KDB_ARGCOUNT;
 
 	list_for_each_entry(kp, &kdb_cmds_head, list_node) {
-		if (strcmp(kp->cmd_name, argv[0]) == 0)
+		if (strcmp(kp->name, argv[0]) == 0)
 			break;
 	}
 	if (list_entry_is_head(kp, &kdb_cmds_head, list_node)) {
@@ -804,7 +803,7 @@ static int kdb_exec_defcmd(int argc, const char **argv)
 		 * Recursive use of kdb_parse, do not use argv after this point.
 		 */
 		argv = NULL;
-		kdb_printf("[%s]kdb> %s\n", kmp->cmd.cmd_name, kms->statement);
+		kdb_printf("[%s]kdb> %s\n", kmp->cmd.name, kms->statement);
 		ret = kdb_parse(kms->statement);
 		if (ret)
 			return ret;
@@ -1016,11 +1015,11 @@ int kdb_parse(const char *cmdstr)
 		 * If this command is allowed to be abbreviated,
 		 * check to see if this is it.
 		 */
-		if (tp->cmd_minlen && (strlen(argv[0]) <= tp->cmd_minlen) &&
-		    (strncmp(argv[0], tp->cmd_name, tp->cmd_minlen) == 0))
+		if (tp->minlen && (strlen(argv[0]) <= tp->minlen) &&
+		    (strncmp(argv[0], tp->name, tp->minlen) == 0))
 			break;
 
-		if (strcmp(argv[0], tp->cmd_name) == 0)
+		if (strcmp(argv[0], tp->name) == 0)
 			break;
 	}
 
@@ -1031,8 +1030,7 @@ int kdb_parse(const char *cmdstr)
 	 */
 	if (list_entry_is_head(tp, &kdb_cmds_head, list_node)) {
 		list_for_each_entry(tp, &kdb_cmds_head, list_node) {
-			if (strncmp(argv[0], tp->cmd_name,
-				    strlen(tp->cmd_name)) == 0)
+			if (strncmp(argv[0], tp->name, strlen(tp->name)) == 0)
 				break;
 		}
 	}
@@ -1040,19 +1038,19 @@ int kdb_parse(const char *cmdstr)
 	if (!list_entry_is_head(tp, &kdb_cmds_head, list_node)) {
 		int result;
 
-		if (!kdb_check_flags(tp->cmd_flags, kdb_cmd_enabled, argc <= 1))
+		if (!kdb_check_flags(tp->flags, kdb_cmd_enabled, argc <= 1))
 			return KDB_NOPERM;
 
 		KDB_STATE_SET(CMD);
-		result = (*tp->cmd_func)(argc-1, (const char **)argv);
+		result = (*tp->func)(argc-1, (const char **)argv);
 		if (result && ignore_errors && result > KDB_CMD_GO)
 			result = 0;
 		KDB_STATE_CLEAR(CMD);
 
-		if (tp->cmd_flags & KDB_REPEAT_WITH_ARGS)
+		if (tp->flags & KDB_REPEAT_WITH_ARGS)
 			return result;
 
-		argc = tp->cmd_flags & KDB_REPEAT_NO_ARGS ? 1 : 0;
+		argc = tp->flags & KDB_REPEAT_NO_ARGS ? 1 : 0;
 		if (argv[argc])
 			*(argv[argc]) = '\0';
 		return result;
@@ -2419,12 +2417,12 @@ static int kdb_help(int argc, const char **argv)
 		char *space = "";
 		if (KDB_FLAG(CMD_INTERRUPT))
 			return 0;
-		if (!kdb_check_flags(kt->cmd_flags, kdb_cmd_enabled, true))
+		if (!kdb_check_flags(kt->flags, kdb_cmd_enabled, true))
 			continue;
-		if (strlen(kt->cmd_usage) > 20)
+		if (strlen(kt->usage) > 20)
 			space = "\n                                    ";
-		kdb_printf("%-15.15s %-20s%s%s\n", kt->cmd_name,
-			   kt->cmd_usage, space, kt->cmd_help);
+		kdb_printf("%-15.15s %-20s%s%s\n", kt->name,
+			   kt->usage, space, kt->help);
 	}
 	return 0;
 }
@@ -2633,9 +2631,9 @@ int kdb_register(kdbtab_t *cmd)
 	kdbtab_t *kp;
 
 	list_for_each_entry(kp, &kdb_cmds_head, list_node) {
-		if (strcmp(kp->cmd_name, cmd->cmd_name) == 0) {
+		if (strcmp(kp->name, cmd->name) == 0) {
 			kdb_printf("Duplicate kdb cmd: %s, func %p help %s\n",
-				   cmd->cmd_name, cmd->cmd_func, cmd->cmd_help);
+				   cmd->name, cmd->func, cmd->help);
 			return 1;
 		}
 	}
@@ -2672,218 +2670,218 @@ void kdb_unregister(kdbtab_t *cmd)
 EXPORT_SYMBOL_GPL(kdb_unregister);
 
 static kdbtab_t maintab[] = {
-	{	.cmd_name = "md",
-		.cmd_func = kdb_md,
-		.cmd_usage = "<vaddr>",
-		.cmd_help = "Display Memory Contents, also mdWcN, e.g. md8c1",
-		.cmd_minlen = 1,
-		.cmd_flags = KDB_ENABLE_MEM_READ | KDB_REPEAT_NO_ARGS,
+	{	.name = "md",
+		.func = kdb_md,
+		.usage = "<vaddr>",
+		.help = "Display Memory Contents, also mdWcN, e.g. md8c1",
+		.minlen = 1,
+		.flags = KDB_ENABLE_MEM_READ | KDB_REPEAT_NO_ARGS,
 	},
-	{	.cmd_name = "mdr",
-		.cmd_func = kdb_md,
-		.cmd_usage = "<vaddr> <bytes>",
-		.cmd_help = "Display Raw Memory",
-		.cmd_flags = KDB_ENABLE_MEM_READ | KDB_REPEAT_NO_ARGS,
+	{	.name = "mdr",
+		.func = kdb_md,
+		.usage = "<vaddr> <bytes>",
+		.help = "Display Raw Memory",
+		.flags = KDB_ENABLE_MEM_READ | KDB_REPEAT_NO_ARGS,
 	},
-	{	.cmd_name = "mdp",
-		.cmd_func = kdb_md,
-		.cmd_usage = "<paddr> <bytes>",
-		.cmd_help = "Display Physical Memory",
-		.cmd_flags = KDB_ENABLE_MEM_READ | KDB_REPEAT_NO_ARGS,
+	{	.name = "mdp",
+		.func = kdb_md,
+		.usage = "<paddr> <bytes>",
+		.help = "Display Physical Memory",
+		.flags = KDB_ENABLE_MEM_READ | KDB_REPEAT_NO_ARGS,
 	},
-	{	.cmd_name = "mds",
-		.cmd_func = kdb_md,
-		.cmd_usage = "<vaddr>",
-		.cmd_help = "Display Memory Symbolically",
-		.cmd_flags = KDB_ENABLE_MEM_READ | KDB_REPEAT_NO_ARGS,
+	{	.name = "mds",
+		.func = kdb_md,
+		.usage = "<vaddr>",
+		.help = "Display Memory Symbolically",
+		.flags = KDB_ENABLE_MEM_READ | KDB_REPEAT_NO_ARGS,
 	},
-	{	.cmd_name = "mm",
-		.cmd_func = kdb_mm,
-		.cmd_usage = "<vaddr> <contents>",
-		.cmd_help = "Modify Memory Contents",
-		.cmd_flags = KDB_ENABLE_MEM_WRITE | KDB_REPEAT_NO_ARGS,
+	{	.name = "mm",
+		.func = kdb_mm,
+		.usage = "<vaddr> <contents>",
+		.help = "Modify Memory Contents",
+		.flags = KDB_ENABLE_MEM_WRITE | KDB_REPEAT_NO_ARGS,
 	},
-	{	.cmd_name = "go",
-		.cmd_func = kdb_go,
-		.cmd_usage = "[<vaddr>]",
-		.cmd_help = "Continue Execution",
-		.cmd_minlen = 1,
-		.cmd_flags = KDB_ENABLE_REG_WRITE |
+	{	.name = "go",
+		.func = kdb_go,
+		.usage = "[<vaddr>]",
+		.help = "Continue Execution",
+		.minlen = 1,
+		.flags = KDB_ENABLE_REG_WRITE |
 			     KDB_ENABLE_ALWAYS_SAFE_NO_ARGS,
 	},
-	{	.cmd_name = "rd",
-		.cmd_func = kdb_rd,
-		.cmd_usage = "",
-		.cmd_help = "Display Registers",
-		.cmd_flags = KDB_ENABLE_REG_READ,
+	{	.name = "rd",
+		.func = kdb_rd,
+		.usage = "",
+		.help = "Display Registers",
+		.flags = KDB_ENABLE_REG_READ,
 	},
-	{	.cmd_name = "rm",
-		.cmd_func = kdb_rm,
-		.cmd_usage = "<reg> <contents>",
-		.cmd_help = "Modify Registers",
-		.cmd_flags = KDB_ENABLE_REG_WRITE,
+	{	.name = "rm",
+		.func = kdb_rm,
+		.usage = "<reg> <contents>",
+		.help = "Modify Registers",
+		.flags = KDB_ENABLE_REG_WRITE,
 	},
-	{	.cmd_name = "ef",
-		.cmd_func = kdb_ef,
-		.cmd_usage = "<vaddr>",
-		.cmd_help = "Display exception frame",
-		.cmd_flags = KDB_ENABLE_MEM_READ,
+	{	.name = "ef",
+		.func = kdb_ef,
+		.usage = "<vaddr>",
+		.help = "Display exception frame",
+		.flags = KDB_ENABLE_MEM_READ,
 	},
-	{	.cmd_name = "bt",
-		.cmd_func = kdb_bt,
-		.cmd_usage = "[<vaddr>]",
-		.cmd_help = "Stack traceback",
-		.cmd_minlen = 1,
-		.cmd_flags = KDB_ENABLE_MEM_READ | KDB_ENABLE_INSPECT_NO_ARGS,
+	{	.name = "bt",
+		.func = kdb_bt,
+		.usage = "[<vaddr>]",
+		.help = "Stack traceback",
+		.minlen = 1,
+		.flags = KDB_ENABLE_MEM_READ | KDB_ENABLE_INSPECT_NO_ARGS,
 	},
-	{	.cmd_name = "btp",
-		.cmd_func = kdb_bt,
-		.cmd_usage = "<pid>",
-		.cmd_help = "Display stack for process <pid>",
-		.cmd_flags = KDB_ENABLE_INSPECT,
+	{	.name = "btp",
+		.func = kdb_bt,
+		.usage = "<pid>",
+		.help = "Display stack for process <pid>",
+		.flags = KDB_ENABLE_INSPECT,
 	},
-	{	.cmd_name = "bta",
-		.cmd_func = kdb_bt,
-		.cmd_usage = "[D|R|S|T|C|Z|E|U|I|M|A]",
-		.cmd_help = "Backtrace all processes matching state flag",
-		.cmd_flags = KDB_ENABLE_INSPECT,
+	{	.name = "bta",
+		.func = kdb_bt,
+		.usage = "[D|R|S|T|C|Z|E|U|I|M|A]",
+		.help = "Backtrace all processes matching state flag",
+		.flags = KDB_ENABLE_INSPECT,
 	},
-	{	.cmd_name = "btc",
-		.cmd_func = kdb_bt,
-		.cmd_usage = "",
-		.cmd_help = "Backtrace current process on each cpu",
-		.cmd_flags = KDB_ENABLE_INSPECT,
+	{	.name = "btc",
+		.func = kdb_bt,
+		.usage = "",
+		.help = "Backtrace current process on each cpu",
+		.flags = KDB_ENABLE_INSPECT,
 	},
-	{	.cmd_name = "btt",
-		.cmd_func = kdb_bt,
-		.cmd_usage = "<vaddr>",
-		.cmd_help = "Backtrace process given its struct task address",
-		.cmd_flags = KDB_ENABLE_MEM_READ | KDB_ENABLE_INSPECT_NO_ARGS,
+	{	.name = "btt",
+		.func = kdb_bt,
+		.usage = "<vaddr>",
+		.help = "Backtrace process given its struct task address",
+		.flags = KDB_ENABLE_MEM_READ | KDB_ENABLE_INSPECT_NO_ARGS,
 	},
-	{	.cmd_name = "env",
-		.cmd_func = kdb_env,
-		.cmd_usage = "",
-		.cmd_help = "Show environment variables",
-		.cmd_flags = KDB_ENABLE_ALWAYS_SAFE,
+	{	.name = "env",
+		.func = kdb_env,
+		.usage = "",
+		.help = "Show environment variables",
+		.flags = KDB_ENABLE_ALWAYS_SAFE,
 	},
-	{	.cmd_name = "set",
-		.cmd_func = kdb_set,
-		.cmd_usage = "",
-		.cmd_help = "Set environment variables",
-		.cmd_flags = KDB_ENABLE_ALWAYS_SAFE,
+	{	.name = "set",
+		.func = kdb_set,
+		.usage = "",
+		.help = "Set environment variables",
+		.flags = KDB_ENABLE_ALWAYS_SAFE,
 	},
-	{	.cmd_name = "help",
-		.cmd_func = kdb_help,
-		.cmd_usage = "",
-		.cmd_help = "Display Help Message",
-		.cmd_minlen = 1,
-		.cmd_flags = KDB_ENABLE_ALWAYS_SAFE,
+	{	.name = "help",
+		.func = kdb_help,
+		.usage = "",
+		.help = "Display Help Message",
+		.minlen = 1,
+		.flags = KDB_ENABLE_ALWAYS_SAFE,
 	},
-	{	.cmd_name = "?",
-		.cmd_func = kdb_help,
-		.cmd_usage = "",
-		.cmd_help = "Display Help Message",
-		.cmd_flags = KDB_ENABLE_ALWAYS_SAFE,
+	{	.name = "?",
+		.func = kdb_help,
+		.usage = "",
+		.help = "Display Help Message",
+		.flags = KDB_ENABLE_ALWAYS_SAFE,
 	},
-	{	.cmd_name = "cpu",
-		.cmd_func = kdb_cpu,
-		.cmd_usage = "<cpunum>",
-		.cmd_help = "Switch to new cpu",
-		.cmd_flags = KDB_ENABLE_ALWAYS_SAFE_NO_ARGS,
+	{	.name = "cpu",
+		.func = kdb_cpu,
+		.usage = "<cpunum>",
+		.help = "Switch to new cpu",
+		.flags = KDB_ENABLE_ALWAYS_SAFE_NO_ARGS,
 	},
-	{	.cmd_name = "kgdb",
-		.cmd_func = kdb_kgdb,
-		.cmd_usage = "",
-		.cmd_help = "Enter kgdb mode",
-		.cmd_flags = 0,
+	{	.name = "kgdb",
+		.func = kdb_kgdb,
+		.usage = "",
+		.help = "Enter kgdb mode",
+		.flags = 0,
 	},
-	{	.cmd_name = "ps",
-		.cmd_func = kdb_ps,
-		.cmd_usage = "[<flags>|A]",
-		.cmd_help = "Display active task list",
-		.cmd_flags = KDB_ENABLE_INSPECT,
+	{	.name = "ps",
+		.func = kdb_ps,
+		.usage = "[<flags>|A]",
+		.help = "Display active task list",
+		.flags = KDB_ENABLE_INSPECT,
 	},
-	{	.cmd_name = "pid",
-		.cmd_func = kdb_pid,
-		.cmd_usage = "<pidnum>",
-		.cmd_help = "Switch to another task",
-		.cmd_flags = KDB_ENABLE_INSPECT,
+	{	.name = "pid",
+		.func = kdb_pid,
+		.usage = "<pidnum>",
+		.help = "Switch to another task",
+		.flags = KDB_ENABLE_INSPECT,
 	},
-	{	.cmd_name = "reboot",
-		.cmd_func = kdb_reboot,
-		.cmd_usage = "",
-		.cmd_help = "Reboot the machine immediately",
-		.cmd_flags = KDB_ENABLE_REBOOT,
+	{	.name = "reboot",
+		.func = kdb_reboot,
+		.usage = "",
+		.help = "Reboot the machine immediately",
+		.flags = KDB_ENABLE_REBOOT,
 	},
 #if defined(CONFIG_MODULES)
-	{	.cmd_name = "lsmod",
-		.cmd_func = kdb_lsmod,
-		.cmd_usage = "",
-		.cmd_help = "List loaded kernel modules",
-		.cmd_flags = KDB_ENABLE_INSPECT,
+	{	.name = "lsmod",
+		.func = kdb_lsmod,
+		.usage = "",
+		.help = "List loaded kernel modules",
+		.flags = KDB_ENABLE_INSPECT,
 	},
 #endif
 #if defined(CONFIG_MAGIC_SYSRQ)
-	{	.cmd_name = "sr",
-		.cmd_func = kdb_sr,
-		.cmd_usage = "<key>",
-		.cmd_help = "Magic SysRq key",
-		.cmd_flags = KDB_ENABLE_ALWAYS_SAFE,
+	{	.name = "sr",
+		.func = kdb_sr,
+		.usage = "<key>",
+		.help = "Magic SysRq key",
+		.flags = KDB_ENABLE_ALWAYS_SAFE,
 	},
 #endif
 #if defined(CONFIG_PRINTK)
-	{	.cmd_name = "dmesg",
-		.cmd_func = kdb_dmesg,
-		.cmd_usage = "[lines]",
-		.cmd_help = "Display syslog buffer",
-		.cmd_flags = KDB_ENABLE_ALWAYS_SAFE,
+	{	.name = "dmesg",
+		.func = kdb_dmesg,
+		.usage = "[lines]",
+		.help = "Display syslog buffer",
+		.flags = KDB_ENABLE_ALWAYS_SAFE,
 	},
 #endif
-	{	.cmd_name = "defcmd",
-		.cmd_func = kdb_defcmd,
-		.cmd_usage = "name \"usage\" \"help\"",
-		.cmd_help = "Define a set of commands, down to endefcmd",
+	{	.name = "defcmd",
+		.func = kdb_defcmd,
+		.usage = "name \"usage\" \"help\"",
+		.help = "Define a set of commands, down to endefcmd",
 		/*
 		 * Macros are always safe because when executed each
 		 * internal command re-enters kdb_parse() and is safety
 		 * checked individually.
 		 */
-		.cmd_flags = KDB_ENABLE_ALWAYS_SAFE,
+		.flags = KDB_ENABLE_ALWAYS_SAFE,
 	},
-	{	.cmd_name = "kill",
-		.cmd_func = kdb_kill,
-		.cmd_usage = "<-signal> <pid>",
-		.cmd_help = "Send a signal to a process",
-		.cmd_flags = KDB_ENABLE_SIGNAL,
+	{	.name = "kill",
+		.func = kdb_kill,
+		.usage = "<-signal> <pid>",
+		.help = "Send a signal to a process",
+		.flags = KDB_ENABLE_SIGNAL,
 	},
-	{	.cmd_name = "summary",
-		.cmd_func = kdb_summary,
-		.cmd_usage = "",
-		.cmd_help = "Summarize the system",
-		.cmd_minlen = 4,
-		.cmd_flags = KDB_ENABLE_ALWAYS_SAFE,
+	{	.name = "summary",
+		.func = kdb_summary,
+		.usage = "",
+		.help = "Summarize the system",
+		.minlen = 4,
+		.flags = KDB_ENABLE_ALWAYS_SAFE,
 	},
-	{	.cmd_name = "per_cpu",
-		.cmd_func = kdb_per_cpu,
-		.cmd_usage = "<sym> [<bytes>] [<cpu>]",
-		.cmd_help = "Display per_cpu variables",
-		.cmd_minlen = 3,
-		.cmd_flags = KDB_ENABLE_MEM_READ,
+	{	.name = "per_cpu",
+		.func = kdb_per_cpu,
+		.usage = "<sym> [<bytes>] [<cpu>]",
+		.help = "Display per_cpu variables",
+		.minlen = 3,
+		.flags = KDB_ENABLE_MEM_READ,
 	},
-	{	.cmd_name = "grephelp",
-		.cmd_func = kdb_grep_help,
-		.cmd_usage = "",
-		.cmd_help = "Display help on | grep",
-		.cmd_flags = KDB_ENABLE_ALWAYS_SAFE,
+	{	.name = "grephelp",
+		.func = kdb_grep_help,
+		.usage = "",
+		.help = "Display help on | grep",
+		.flags = KDB_ENABLE_ALWAYS_SAFE,
 	},
 };
 
 static kdbtab_t nmicmd = {
-	.cmd_name = "disable_nmi",
-	.cmd_func = kdb_disable_nmi,
-	.cmd_usage = "",
-	.cmd_help = "Disable NMI entry to KDB",
-	.cmd_flags = KDB_ENABLE_ALWAYS_SAFE,
+	.name = "disable_nmi",
+	.func = kdb_disable_nmi,
+	.usage = "",
+	.help = "Disable NMI entry to KDB",
+	.flags = KDB_ENABLE_ALWAYS_SAFE,
 };
 
 /* Initialize the kdb command table. */
diff --git a/kernel/trace/trace_kdb.c b/kernel/trace/trace_kdb.c
index 6c4f92c79e43..59857a1ee44c 100644
--- a/kernel/trace/trace_kdb.c
+++ b/kernel/trace/trace_kdb.c
@@ -148,11 +148,11 @@ static int kdb_ftdump(int argc, const char **argv)
 }
 
 static kdbtab_t ftdump_cmd = {
-	.cmd_name = "ftdump",
-	.cmd_func = kdb_ftdump,
-	.cmd_usage = "[skip_#entries] [cpu]",
-	.cmd_help = "Dump ftrace log; -skip dumps last #entries",
-	.cmd_flags = KDB_ENABLE_ALWAYS_SAFE,
+	.name = "ftdump",
+	.func = kdb_ftdump,
+	.usage = "[skip_#entries] [cpu]",
+	.help = "Dump ftrace log; -skip dumps last #entries",
+	.flags = KDB_ENABLE_ALWAYS_SAFE,
 };
 
 static __init int kdb_ftrace_register(void)
diff --git a/samples/kdb/kdb_hello.c b/samples/kdb/kdb_hello.c
index 9ad514a6648b..82736e5a5e32 100644
--- a/samples/kdb/kdb_hello.c
+++ b/samples/kdb/kdb_hello.c
@@ -29,10 +29,10 @@ static int kdb_hello_cmd(int argc, const char **argv)
 }
 
 static kdbtab_t hello_cmd = {
-	.cmd_name = "hello",
-	.cmd_func = kdb_hello_cmd,
-	.cmd_usage = "[string]",
-	.cmd_help = "Say Hello World or Hello [string]",
+	.name = "hello",
+	.func = kdb_hello_cmd,
+	.usage = "[string]",
+	.help = "Say Hello World or Hello [string]",
 };
 
 static int __init kdb_hello_cmd_init(void)
-- 
2.25.1

