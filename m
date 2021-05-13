Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB2BD37F6B3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 13:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233371AbhEMLaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 07:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233341AbhEMLaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 07:30:24 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61737C061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 04:29:14 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id a11so14193626plh.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 04:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XQmvefvqDAIM2m93Dqn+5OWuAmfoCSh4wprgQC9L5y4=;
        b=bARh98kdNIeWnUNdR7lZ7iMKaVe74TlDxAqQ501voh9Xfkfvy8QsAdaf6es4rUKVRW
         sjEsQcfLVAQci28C4at1ySWCbVLgBnjhGU6WaOa4THw/8gvJCGiO5FDCLEwgLigIW1cp
         KUFKEyF6MOBboBzIEKU+peJBkKRqd4/O7woaf79OlQLNxgOD2IvL2YUtSiCuko+ADUvZ
         tjSgrnERr6Su3OTdj+drqKzQrTt9B5639sivIa/acE3Yx39a95/IGeh6EjI66ybGixC/
         gl4SttTMS2KgcsWBFVDJ3IJ3yKGYHdEFbLdE72ci3In304zmbV9xUkpgS3IHNZvQPVMI
         Di8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XQmvefvqDAIM2m93Dqn+5OWuAmfoCSh4wprgQC9L5y4=;
        b=SyLFaEKVKI9tel+mL0Z+Dsgu/Pr0nrwLN/mNene+B4yyOqRcSP07rANgHjVmMexYtl
         bfbTdSZgKJ95aAAY8PjPW6sEPRjl5RQZJaO39HMiAn/cIXW1uXpPne0MFGz+r96P3/Xl
         41l1JLRj8UmoJKZtb0GYCu3l2N117949FhmZuSSUw4lYqXxINI1h0Hd6lY+FPaHIrbQV
         DM5YxpNc3acVAR6PV6crTFEzerCvLNk9asrROaphTnA6JqkZu7RCgCAJpIPFToVJbU6q
         EiyggB4PAH08lTuaD1xFk2/ZD/JEJz35OmnrVvDpqxVDfqqrFUB7MqXJMkoE7z47zlrG
         dqAw==
X-Gm-Message-State: AOAM533vYTGCx+/m/8CR0LQWNklux11RrDnc4a2z3va+AG1i0ihW9F5r
        XQmgROVuj0vKdezn71+JhA7bzA==
X-Google-Smtp-Source: ABdhPJzml5y1gkHqZOUNmAha0jFdJl552EWmqHBbPSYZeLlK6GGMVDhEbLVKy/tHPMM2dGpM3V0wfg==
X-Received: by 2002:a17:902:f203:b029:ee:e32f:2a28 with SMTP id m3-20020a170902f203b02900eee32f2a28mr38903392plc.45.1620905353950;
        Thu, 13 May 2021 04:29:13 -0700 (PDT)
Received: from localhost.localdomain ([223.236.157.188])
        by smtp.gmail.com with ESMTPSA id p9sm6768807pjb.32.2021.05.13.04.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 04:29:13 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     kgdb-bugreport@lists.sourceforge.net
Cc:     daniel.thompson@linaro.org, jason.wessel@windriver.com,
        dianders@chromium.org, rostedt@goodmis.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v3 2/2] kdb: Simplify kdb_defcmd macro logic
Date:   Thu, 13 May 2021 16:58:42 +0530
Message-Id: <20210513112842.707103-3-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210513112842.707103-1-sumit.garg@linaro.org>
References: <20210513112842.707103-1-sumit.garg@linaro.org>
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
index de685b2a8ce7..ce7f4c71992d 100644
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
+	kdbtab_t cmd;			/* Macro command name */
+	struct list_head commands;	/* Associated command list */
 };
+
+struct kdb_macro_cmd_t {
+	char *cmd;			/* Command name */
+	struct list_head list_node;	/* Command list node */
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
+	struct kdb_macro_cmd_t *kmc;
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
+		if (!list_empty(&kdb_macro->commands))
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
+	kmc->cmd = kdb_strdup(cmdstr, GFP_KDB);
+	list_add_tail(&kmc->list_node, &kdb_macro->commands);
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
+		struct kdb_macro_cmd_t *kmc;
+
+		list_for_each_entry(kp, &kdb_cmds_head, list_node) {
+			if (kp->cmd_func == kdb_exec_defcmd) {
+				kdb_printf("defcmd %s \"%s\" \"%s\"\n",
+					   kp->cmd_name, kp->cmd_usage,
+					   kp->cmd_help);
+				kmp = container_of(kp, struct kdb_macro_t, cmd);
+				list_for_each_entry(kmc, &kmp->commands,
+						    list_node)
+					kdb_printf("%s", kmc->cmd);
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
+	INIT_LIST_HEAD(&kdb_macro->commands);
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
+	struct kdb_macro_cmd_t *kmc;
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
+	list_for_each_entry(kmc, &kmp->commands, list_node) {
+		/*
+		 * Recursive use of kdb_parse, do not use argv after this point.
+		 */
 		argv = NULL;
-		kdb_printf("[%s]kdb> %s\n", s->cmd.cmd_name, s->command[i]);
-		ret = kdb_parse(s->command[i]);
+		kdb_printf("[%s]kdb> %s\n", kmp->cmd.cmd_name, kmc->cmd);
+		ret = kdb_parse(kmc->cmd);
 		if (ret)
 			return ret;
 	}
-- 
2.25.1

