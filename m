Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 744823C5D9F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 15:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234950AbhGLNtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 09:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234935AbhGLNtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 09:49:41 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C94C0613E9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 06:46:52 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id i16-20020a17090acf90b02901736d9d2218so17102pju.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 06:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7lndx/Q0BSeWXmTJRjg5t/KTDSpkqtinldnSc918fkk=;
        b=qEqy9k9IeisSsqXkaFSZtlkp+CGUn0VvlDhwX9bQMDjSsvmJlwAQeulrovlh7I+Le+
         cKt4ENIJQnfOiHrsTB+nh+weIj6ktK7ZKp31rf5rLOzGUeFBc8G8LXNy9uQrQl55eBOb
         ZebUdcI9fX/UYrcm3fOE5zEAWOxp3koBcwoA+lSIjKljfSh4n7mn8vRZj+SjU39L9AiW
         L/uRVGS3jum+ihJjExjPWZCNaypNYeQdFr62psAeXh9foq8k15AfcpCezx6rx71GzItZ
         xA6dMUQjRmkbYwB4SnBjIlbSycCnMvsoSETEHTJK6Dv+ugBr3DbO0DR5YVsoz5OxDdP0
         I7Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7lndx/Q0BSeWXmTJRjg5t/KTDSpkqtinldnSc918fkk=;
        b=Dj9wQl4Jty6DmqwIDV7eMtWqLg8MqwORLGm0GSngALwMwnKjVv10NZuH9VXHPg72mT
         r4Xqp/3Tfxr6AFrDBuGrsjZp+1ybZkeQln2DhOhskNhluySNYylLHP0/+6ozvfqgaVe0
         djwG3wiNT1eQimqBRJJ6mGvojq6SfpLafgKBscCz5+HZBMmspEic7izwqmdYTvOb2g7A
         B4mq64jFskH46N6d2sckbrQrzqXe2eu4M1+jPqtDrQPe/xJyi0+gAA8juZkTaUf8gNbW
         S4uUvevSB+7DHwsD2m8Ng4rDeaxo6XegdhxsQCxwu3eBLTKJIGrn8EJgVxUvUKQ/WJh9
         eeUw==
X-Gm-Message-State: AOAM531NcEktDsUd+DOysJKzFHxhpnEqNp/dGwu9odfbylvna/rJ5Xve
        4Trg3Czo4OnxciPl5CLgJD3HAQ==
X-Google-Smtp-Source: ABdhPJzjQx81QNJb//yoI/tavQ7MCWXT0XlgOGV16bjbtPy/fAH3Ce7u/rt4O4Hva7MVVjbNE/sfHg==
X-Received: by 2002:a17:90b:10a:: with SMTP id p10mr10112212pjz.189.1626097612162;
        Mon, 12 Jul 2021 06:46:52 -0700 (PDT)
Received: from localhost.localdomain ([223.178.210.84])
        by smtp.gmail.com with ESMTPSA id z13sm835405pfn.94.2021.07.12.06.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 06:46:51 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     kgdb-bugreport@lists.sourceforge.net
Cc:     daniel.thompson@linaro.org, jason.wessel@windriver.com,
        dianders@chromium.org, rostedt@goodmis.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v5 3/4] kdb: Simplify kdb_defcmd macro logic
Date:   Mon, 12 Jul 2021 19:16:19 +0530
Message-Id: <20210712134620.276667-4-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210712134620.276667-1-sumit.garg@linaro.org>
References: <20210712134620.276667-1-sumit.garg@linaro.org>
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
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
 kernel/debug/kdb/kdb_main.c | 107 +++++++++++++++++++-----------------
 1 file changed, 58 insertions(+), 49 deletions(-)

diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index b2880fad26d4..7c7a2ef834fc 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -654,13 +654,16 @@ static void kdb_cmderror(int diag)
  *	zero for success, a kdb diagnostic if error
  */
 struct kdb_macro {
-	int count;
-	bool usable;
-	kdbtab_t cmd;
-	char **command;
+	kdbtab_t cmd;			/* Macro command */
+	struct list_head statements;	/* Associated statement list */
 };
+
+struct kdb_macro_statement {
+	char *statement;		/* Statement text */
+	struct list_head list_node;	/* Statement list node */
+};
+
 static struct kdb_macro *kdb_macro;
-static int kdb_macro_count;
 static bool defcmd_in_progress;
 
 /* Forward references */
@@ -668,34 +671,33 @@ static int kdb_exec_defcmd(int argc, const char **argv);
 
 static int kdb_defcmd2(const char *cmdstr, const char *argv0)
 {
-	struct kdb_macro *s = kdb_macro + kdb_macro_count - 1;
-	char **save_command = s->command;
+	struct kdb_macro_statement *kms;
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
+	kms = kmalloc(sizeof(*kms), GFP_KDB);
+	if (!kms) {
+		kdb_printf("Could not allocate new kdb macro command: %s\n",
 			   cmdstr);
-		s->usable = false;
 		return KDB_NOTIMP;
 	}
-	memcpy(s->command, save_command, s->count * sizeof(*(s->command)));
-	s->command[s->count++] = kdb_strdup(cmdstr, GFP_KDB);
-	kfree(save_command);
+
+	kms->statement = kdb_strdup(cmdstr, GFP_KDB);
+	list_add_tail(&kms->list_node, &kdb_macro->statements);
+
 	return 0;
 }
 
 static int kdb_defcmd(int argc, const char **argv)
 {
-	struct kdb_macro *save_kdb_macro = kdb_macro, *s;
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
+		struct kdb_macro *kmp;
+		struct kdb_macro_statement *kms;
+
+		list_for_each_entry(kp, &kdb_cmds_head, list_node) {
+			if (kp->cmd_func == kdb_exec_defcmd) {
+				kdb_printf("defcmd %s \"%s\" \"%s\"\n",
+					   kp->cmd_name, kp->cmd_usage,
+					   kp->cmd_help);
+				kmp = container_of(kp, struct kdb_macro, cmd);
+				list_for_each_entry(kms, &kmp->statements,
+						    list_node)
+					kdb_printf("%s", kms->statement);
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
-				  GFP_KDB);
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
-	struct kdb_macro *s;
+	int ret;
+	kdbtab_t *kp;
+	struct kdb_macro *kmp;
+	struct kdb_macro_statement *kms;
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
+	kmp = container_of(kp, struct kdb_macro, cmd);
+	list_for_each_entry(kms, &kmp->statements, list_node) {
+		/*
+		 * Recursive use of kdb_parse, do not use argv after this point.
+		 */
 		argv = NULL;
-		kdb_printf("[%s]kdb> %s\n", s->cmd.cmd_name, s->command[i]);
-		ret = kdb_parse(s->command[i]);
+		kdb_printf("[%s]kdb> %s\n", kmp->cmd.cmd_name, kms->statement);
+		ret = kdb_parse(kms->statement);
 		if (ret)
 			return ret;
 	}
-- 
2.25.1

