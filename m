Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 552913C226F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 12:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbhGIKqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 06:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbhGIKq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 06:46:29 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2512C0613DD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 03:43:46 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id f17so8366380pfj.8
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 03:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4GQqJQ0D7DHcpMP89v1aKCiN7Kt8bURDgsrEepvgmL8=;
        b=u/LwrYY0Has6wwCc22UF5AJhQhXhY63JprqAqTWwuew1jkc5u2Ku4UgXNoPVRn3ykg
         Mq0PtzpHm/FVTmbXmK4tkcFap0WgDRg1AxFh8iUDw1eVMsFwG/UKnufajQw5N3J3amUs
         WjfjPuAmsjRerERs/suvtLWxT94Y2kr+8PtbafQqnLi5H0knxDmSYmkz08MBbNb1CYdq
         6melT7DJZWoiH/7Zj9jOCudpkvy7CBq2COZN2UpJ4yCBTHwNNrTuqta4TVf8q2nPsASI
         3eTHrxhDUQ/MurWJFAhty+cAK3Tm+RZqokzloRQwLK3Agb5czJ7woOfHxf/XWGZCREW8
         lkqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4GQqJQ0D7DHcpMP89v1aKCiN7Kt8bURDgsrEepvgmL8=;
        b=JcPnJ9MohWmycZUWUWU/WnI0cwAGXiavMeaEnTT78SZdJneVzFoScVtT+AeZFG6KKs
         uwZlrdZRL2kwBx1hX8eCHc1ugfziHInthE9zIne/acqmkjOJgVNdt4TXJ92oUEN6rRAm
         Xka64NuQLO7w9GHwznXci8ZD4xMWG8l1gyNOO9dAtHvgOOxPrUWIKzQymLXSeMibrMCc
         OoQgJjJmXk/y3VLBihN/8dTGKiDJy3AptT3Pwe/PExpbycNSxXT564tNZskLwdUZ1DBQ
         dIUVtfP0AjhvipIxnI+xhEw0U5YuEUOXt7QS0KtvGyKoUXRVJxXYGfZ9vC6gbL8R4Iz2
         indg==
X-Gm-Message-State: AOAM530qQsOCCaGP8Nd6/NmZVk28bAWUysurG2W6lwVjN/Ig/hRoRXqQ
        F8ZaKAiSGtGGc3cFkTdwsITHXA==
X-Google-Smtp-Source: ABdhPJxlzG6kwP0QNJvnQDReEJ+f1E+J7JLpoQ6+s0pmlbk7rCwXLCkWu0RdhSKOvucDRjtNOpoi2Q==
X-Received: by 2002:a63:ed0d:: with SMTP id d13mr37943499pgi.258.1625827426249;
        Fri, 09 Jul 2021 03:43:46 -0700 (PDT)
Received: from localhost.localdomain ([223.178.210.84])
        by smtp.gmail.com with ESMTPSA id 1sm17479pfv.138.2021.07.09.03.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 03:43:45 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     kgdb-bugreport@lists.sourceforge.net
Cc:     daniel.thompson@linaro.org, jason.wessel@windriver.com,
        dianders@chromium.org, rostedt@goodmis.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v4 1/4] kdb: Rename struct defcmd_set to struct kdb_macro_t
Date:   Fri,  9 Jul 2021 16:13:17 +0530
Message-Id: <20210709104320.101568-2-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210709104320.101568-1-sumit.garg@linaro.org>
References: <20210709104320.101568-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

as that sounds more appropriate given its purpose.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 kernel/debug/kdb/kdb_main.c | 38 ++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index d8ee5647b732..d4897fbc9d2e 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -654,7 +654,7 @@ static void kdb_cmderror(int diag)
  * Returns:
  *	zero for success, a kdb diagnostic if error
  */
-struct defcmd_set {
+struct kdb_macro_t {
 	int count;
 	bool usable;
 	char *name;
@@ -662,8 +662,8 @@ struct defcmd_set {
 	char *help;
 	char **command;
 };
-static struct defcmd_set *defcmd_set;
-static int defcmd_set_count;
+static struct kdb_macro_t *kdb_macro;
+static int kdb_macro_count;
 static bool defcmd_in_progress;
 
 /* Forward references */
@@ -671,7 +671,7 @@ static int kdb_exec_defcmd(int argc, const char **argv);
 
 static int kdb_defcmd2(const char *cmdstr, const char *argv0)
 {
-	struct defcmd_set *s = defcmd_set + defcmd_set_count - 1;
+	struct kdb_macro_t *s = kdb_macro + kdb_macro_count - 1;
 	char **save_command = s->command;
 	if (strcmp(argv0, "endefcmd") == 0) {
 		defcmd_in_progress = false;
@@ -704,7 +704,7 @@ static int kdb_defcmd2(const char *cmdstr, const char *argv0)
 
 static int kdb_defcmd(int argc, const char **argv)
 {
-	struct defcmd_set *save_defcmd_set = defcmd_set, *s;
+	struct kdb_macro_t *save_kdb_macro = kdb_macro, *s;
 	if (defcmd_in_progress) {
 		kdb_printf("kdb: nested defcmd detected, assuming missing "
 			   "endefcmd\n");
@@ -712,7 +712,7 @@ static int kdb_defcmd(int argc, const char **argv)
 	}
 	if (argc == 0) {
 		int i;
-		for (s = defcmd_set; s < defcmd_set + defcmd_set_count; ++s) {
+		for (s = kdb_macro; s < kdb_macro + kdb_macro_count; ++s) {
 			kdb_printf("defcmd %s \"%s\" \"%s\"\n", s->name,
 				   s->usage, s->help);
 			for (i = 0; i < s->count; ++i)
@@ -727,13 +727,13 @@ static int kdb_defcmd(int argc, const char **argv)
 		kdb_printf("Command only available during kdb_init()\n");
 		return KDB_NOTIMP;
 	}
-	defcmd_set = kmalloc_array(defcmd_set_count + 1, sizeof(*defcmd_set),
+	kdb_macro = kmalloc_array(kdb_macro_count + 1, sizeof(*kdb_macro),
 				   GFP_KDB);
-	if (!defcmd_set)
+	if (!kdb_macro)
 		goto fail_defcmd;
-	memcpy(defcmd_set, save_defcmd_set,
-	       defcmd_set_count * sizeof(*defcmd_set));
-	s = defcmd_set + defcmd_set_count;
+	memcpy(kdb_macro, save_kdb_macro,
+	       kdb_macro_count * sizeof(*kdb_macro));
+	s = kdb_macro + kdb_macro_count;
 	memset(s, 0, sizeof(*s));
 	s->usable = true;
 	s->name = kdb_strdup(argv[1], GFP_KDB);
@@ -753,19 +753,19 @@ static int kdb_defcmd(int argc, const char **argv)
 		strcpy(s->help, argv[3]+1);
 		s->help[strlen(s->help)-1] = '\0';
 	}
-	++defcmd_set_count;
+	++kdb_macro_count;
 	defcmd_in_progress = true;
-	kfree(save_defcmd_set);
+	kfree(save_kdb_macro);
 	return 0;
 fail_help:
 	kfree(s->usage);
 fail_usage:
 	kfree(s->name);
 fail_name:
-	kfree(defcmd_set);
+	kfree(kdb_macro);
 fail_defcmd:
-	kdb_printf("Could not allocate new defcmd_set entry for %s\n", argv[1]);
-	defcmd_set = save_defcmd_set;
+	kdb_printf("Could not allocate new kdb_macro entry for %s\n", argv[1]);
+	kdb_macro = save_kdb_macro;
 	return KDB_NOTIMP;
 }
 
@@ -781,14 +781,14 @@ static int kdb_defcmd(int argc, const char **argv)
 static int kdb_exec_defcmd(int argc, const char **argv)
 {
 	int i, ret;
-	struct defcmd_set *s;
+	struct kdb_macro_t *s;
 	if (argc != 0)
 		return KDB_ARGCOUNT;
-	for (s = defcmd_set, i = 0; i < defcmd_set_count; ++i, ++s) {
+	for (s = kdb_macro, i = 0; i < kdb_macro_count; ++i, ++s) {
 		if (strcmp(s->name, argv[0]) == 0)
 			break;
 	}
-	if (i == defcmd_set_count) {
+	if (i == kdb_macro_count) {
 		kdb_printf("kdb_exec_defcmd: could not find commands for %s\n",
 			   argv[0]);
 		return KDB_NOTIMP;
-- 
2.25.1

