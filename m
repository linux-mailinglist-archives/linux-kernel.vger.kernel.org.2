Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8C433C2276
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 12:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbhGIKqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 06:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbhGIKqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 06:46:38 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3CE3C0613DD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 03:43:54 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id j9so2700209pfc.5
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 03:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PHXBUu5eC6wZWYpwhsqB0JiIUWM07vx9lGh/1SjVYjg=;
        b=wbTykxNsEwOE7vaZM3EmJm3xHtkk38JCcMj9fPGeuM4UnD1+K3YRqojUP32sZWXb+G
         A68RH9Mhq+Ctoco0CQyezhbWq0DMZS2ok6FRW9jzcFxJtkePtBCqtLaF0A3+Ju2ffjNO
         0fd825zkdl6EjaH5kWNq3RIZ69/gwQ96KVBP8Bw5NsiiU5fb8rWIEDTrzy3HeKuY7Vyt
         JXoaMezgOcB1os5NzaZcNiqd/oFJvGHVS7toch2SuYk0c4P1IrYHr95fkP8MP7HF1NGg
         koVMICmTGHbTVCcmiB/67G71DYtbSX6mS6UW/aTrlvtBG2VovoHZ1rVrTsXzfmgAE+Tl
         9sBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PHXBUu5eC6wZWYpwhsqB0JiIUWM07vx9lGh/1SjVYjg=;
        b=jDbEBNPBM7guiSeVuYMQGm6YpgMcu088IUZxicgZJ19Ui89lonQfvTjLRBYy6dTeXF
         u6N1pPkSLa7o0EJAbp9Nxk//zhUsaqfPvVll/B6dftV6o1MepV0cJeYUM58MMrsQtdsr
         eQ98cealE6ZH4rcBfL39liOUeRbifaktVfl0ZKP/Tc4d5pudjjQUDRGjB+dv4mc7ZIfJ
         ywh70BpGt997rJLV3M89IHzRG9WE9mQ0GJb/vWZubAYuVPCYolQCJv1jh8ByMu9Z0tsj
         25viYnNt9pfM5Augw73YHjqDk8x4E48FdM9+rwt3QbxsVYpvjB3ezmYX8Mzqzvcpprly
         l7FQ==
X-Gm-Message-State: AOAM532Vd5HwNx4IkRD3LvbnxdH+xwMZ81eME8Y7me83Q6S7SPRY7kHT
        4BWXIlNIm8iRPZTI4Ky2DsNx6g==
X-Google-Smtp-Source: ABdhPJyTz3sqWHtamWBm4jB2QNNM0u84E9cgr/7iTS8Wg8uH361W3OTA7MN7Vi2j7LFvKisdJfpYTQ==
X-Received: by 2002:a65:638e:: with SMTP id h14mr37748349pgv.330.1625827434543;
        Fri, 09 Jul 2021 03:43:54 -0700 (PDT)
Received: from localhost.localdomain ([223.178.210.84])
        by smtp.gmail.com with ESMTPSA id 1sm17479pfv.138.2021.07.09.03.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 03:43:53 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     kgdb-bugreport@lists.sourceforge.net
Cc:     daniel.thompson@linaro.org, jason.wessel@windriver.com,
        dianders@chromium.org, rostedt@goodmis.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v4 3/4] kdb: Simplify kdb_defcmd macro logic
Date:   Fri,  9 Jul 2021 16:13:19 +0530
Message-Id: <20210709104320.101568-4-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210709104320.101568-1-sumit.garg@linaro.org>
References: <20210709104320.101568-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to use a linked list instead of dynamic array which makes
allocation of kdb macro and traversing the kdb macro commands list
simpler.

Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 kernel/debug/kdb/kdb_main.c | 107 +++++++++++++++++++-----------------
 1 file changed, 58 insertions(+), 49 deletions(-)

diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index 6d9ff4048e7d..371983c03223 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -654,13 +654,16 @@ static void kdb_cmderror(int diag)
  *	zero for success, a kdb diagnostic if error
  */
 struct kdb_macro_t {
-	int count;
-	bool usable;
-	kdbtab_t cmd;
-	char **command;
+	kdbtab_t cmd;			/* Macro command */
+	struct list_head statements;	/* Associated statement list */
 };
+
+struct kdb_macro_statement_t {
+	char *statement;		/* Statement name */
+	struct list_head list_node;	/* Statement list node */
+};
+
 static struct kdb_macro_t *kdb_macro;
-static int kdb_macro_count;
 static bool defcmd_in_progress;
 
 /* Forward references */
@@ -668,34 +671,33 @@ static int kdb_exec_defcmd(int argc, const char **argv);
 
 static int kdb_defcmd2(const char *cmdstr, const char *argv0)
 {
-	struct kdb_macro_t *s = kdb_macro + kdb_macro_count - 1;
-	char **save_command = s->command;
+	struct kdb_macro_statement_t *kmc;
+
+	if (!kdb_macro)
+		return KDB_NOTIMP;
+
 	if (strcmp(argv0, "endefcmd") == 0) {
 		defcmd_in_progress = false;
-		if (!s->count)
-			s->usable = false;
-		if (s->usable)
-			kdb_register(&s->cmd);
+		if (!list_empty(&kdb_macro->statements))
+			kdb_register(&kdb_macro->cmd);
 		return 0;
 	}
-	if (!s->usable)
-		return KDB_NOTIMP;
-	s->command = kcalloc(s->count + 1, sizeof(*(s->command)), GFP_KDB);
-	if (!s->command) {
-		kdb_printf("Could not allocate new kdb_defcmd table for %s\n",
+
+	kmc = kmalloc(sizeof(*kmc), GFP_KDB);
+	if (!kmc) {
+		kdb_printf("Could not allocate new kdb macro command: %s\n",
 			   cmdstr);
-		s->usable = false;
 		return KDB_NOTIMP;
 	}
-	memcpy(s->command, save_command, s->count * sizeof(*(s->command)));
-	s->command[s->count++] = kdb_strdup(cmdstr, GFP_KDB);
-	kfree(save_command);
+
+	kmc->statement = kdb_strdup(cmdstr, GFP_KDB);
+	list_add_tail(&kmc->list_node, &kdb_macro->statements);
+
 	return 0;
 }
 
 static int kdb_defcmd(int argc, const char **argv)
 {
-	struct kdb_macro_t *save_kdb_macro = kdb_macro, *s;
 	kdbtab_t *mp;
 
 	if (defcmd_in_progress) {
@@ -704,13 +706,21 @@ static int kdb_defcmd(int argc, const char **argv)
 		kdb_defcmd2("endefcmd", "endefcmd");
 	}
 	if (argc == 0) {
-		int i;
-		for (s = kdb_macro; s < kdb_macro + kdb_macro_count; ++s) {
-			kdb_printf("defcmd %s \"%s\" \"%s\"\n", s->cmd.cmd_name,
-				   s->cmd.cmd_usage, s->cmd.cmd_help);
-			for (i = 0; i < s->count; ++i)
-				kdb_printf("%s", s->command[i]);
-			kdb_printf("endefcmd\n");
+		kdbtab_t *kp;
+		struct kdb_macro_t *kmp;
+		struct kdb_macro_statement_t *kmc;
+
+		list_for_each_entry(kp, &kdb_cmds_head, list_node) {
+			if (kp->cmd_func == kdb_exec_defcmd) {
+				kdb_printf("defcmd %s \"%s\" \"%s\"\n",
+					   kp->cmd_name, kp->cmd_usage,
+					   kp->cmd_help);
+				kmp = container_of(kp, struct kdb_macro_t, cmd);
+				list_for_each_entry(kmc, &kmp->statements,
+						    list_node)
+					kdb_printf("%s", kmc->statement);
+				kdb_printf("endefcmd\n");
+			}
 		}
 		return 0;
 	}
@@ -720,17 +730,11 @@ static int kdb_defcmd(int argc, const char **argv)
 		kdb_printf("Command only available during kdb_init()\n");
 		return KDB_NOTIMP;
 	}
-	kdb_macro = kmalloc_array(kdb_macro_count + 1, sizeof(*kdb_macro),
-				   GFP_KDB);
+	kdb_macro = kzalloc(sizeof(*kdb_macro), GFP_KDB);
 	if (!kdb_macro)
 		goto fail_defcmd;
-	memcpy(kdb_macro, save_kdb_macro,
-	       kdb_macro_count * sizeof(*kdb_macro));
-	s = kdb_macro + kdb_macro_count;
-	memset(s, 0, sizeof(*s));
-	s->usable = true;
 
-	mp = &s->cmd;
+	mp = &kdb_macro->cmd;
 	mp->cmd_func = kdb_exec_defcmd;
 	mp->cmd_minlen = 0;
 	mp->cmd_flags = KDB_ENABLE_ALWAYS_SAFE;
@@ -751,9 +755,9 @@ static int kdb_defcmd(int argc, const char **argv)
 		strcpy(mp->cmd_help, argv[3]+1);
 		mp->cmd_help[strlen(mp->cmd_help)-1] = '\0';
 	}
-	++kdb_macro_count;
+
+	INIT_LIST_HEAD(&kdb_macro->statements);
 	defcmd_in_progress = true;
-	kfree(save_kdb_macro);
 	return 0;
 fail_help:
 	kfree(mp->cmd_usage);
@@ -763,7 +767,6 @@ static int kdb_defcmd(int argc, const char **argv)
 	kfree(kdb_macro);
 fail_defcmd:
 	kdb_printf("Could not allocate new kdb_macro entry for %s\n", argv[1]);
-	kdb_macro = save_kdb_macro;
 	return KDB_NOTIMP;
 }
 
@@ -778,25 +781,31 @@ static int kdb_defcmd(int argc, const char **argv)
  */
 static int kdb_exec_defcmd(int argc, const char **argv)
 {
-	int i, ret;
-	struct kdb_macro_t *s;
+	int ret;
+	kdbtab_t *kp;
+	struct kdb_macro_t *kmp;
+	struct kdb_macro_statement_t *kmc;
+
 	if (argc != 0)
 		return KDB_ARGCOUNT;
-	for (s = kdb_macro, i = 0; i < kdb_macro_count; ++i, ++s) {
-		if (strcmp(s->cmd.cmd_name, argv[0]) == 0)
+
+	list_for_each_entry(kp, &kdb_cmds_head, list_node) {
+		if (strcmp(kp->cmd_name, argv[0]) == 0)
 			break;
 	}
-	if (i == kdb_macro_count) {
+	if (list_entry_is_head(kp, &kdb_cmds_head, list_node)) {
 		kdb_printf("kdb_exec_defcmd: could not find commands for %s\n",
 			   argv[0]);
 		return KDB_NOTIMP;
 	}
-	for (i = 0; i < s->count; ++i) {
-		/* Recursive use of kdb_parse, do not use argv after
-		 * this point */
+	kmp = container_of(kp, struct kdb_macro_t, cmd);
+	list_for_each_entry(kmc, &kmp->statements, list_node) {
+		/*
+		 * Recursive use of kdb_parse, do not use argv after this point.
+		 */
 		argv = NULL;
-		kdb_printf("[%s]kdb> %s\n", s->cmd.cmd_name, s->command[i]);
-		ret = kdb_parse(s->command[i]);
+		kdb_printf("[%s]kdb> %s\n", kmp->cmd.cmd_name, kmc->statement);
+		ret = kdb_parse(kmc->statement);
 		if (ret)
 			return ret;
 	}
-- 
2.25.1

