Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 909E93C5D9D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 15:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234887AbhGLNtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 09:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234495AbhGLNtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 09:49:33 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F92C0613E8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 06:46:44 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id x21-20020a17090aa395b029016e25313bfcso14174pjp.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 06:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lVA4RIwddIInyvljcC9awXaNo+KOHgwq2Y543zdH9qE=;
        b=EnYhOidupO3mexnBQ6v/6rHN/ritOgXUIJ2n23oA3qrg6MsI8E+sL+ZYvrhh+XPuaX
         R3Z4+ZsF7Ovom/3NPpswmS+gR84N61qCTp5XH/ekg0EBrtVH8N17xC2znb3Jt5dBEXWj
         rjzaL1kMGgjP47o4cSBUpqFRlMEDx377OmEohV3cCPL29uqiG0uYnNXTlBnlxe/OoNGX
         Pk905lp1Rq825DwZ4MmZ/5oWv4LqwMRmlxyC6YNeLgE0ZpFwxIsrrqEH6AjKSyFRpuDz
         7xutnpzkIVe3toPQYtH7MGFu98+3GcJndx8wR2vBoE2xpZrfO3OsCy+uryX14gP8X+Zt
         CT8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lVA4RIwddIInyvljcC9awXaNo+KOHgwq2Y543zdH9qE=;
        b=Mc4UrpimZUONpcYsxmoXRo4DkmJXFjUApOjInrVtJBKsnpBBDL2dXBgGcmZt5XAFqz
         Q23U2XNrZHyNW62MysAVJscwNlmvDYRIKMiKq9EOn7P8CJCtgaLf+Mx+thKlb8lvq6Ye
         ld2+nQlu6mbr/BMHVgBW4A8ihapaUZpHWX53mxfNSUbhrpg+uExV0kNIHAeqLQrx+6in
         eOyPfXwWWifLYvdWhKIVGoDP1id3tfUaw3gUMg231+Xy5jsrdnztX7pSqj2TMGXpE1de
         RxHxeAjtB4t9zI+bqpuF2AuL7Vz9aAG9IZSPoPGnH8f2e0iZoQlEPY/V6lOWv1AeNFG4
         iwPQ==
X-Gm-Message-State: AOAM5322VTeh9TLS3PBglgMoqHec798q8ITrNA+IrpS7stz9ZBLs8dJH
        HUuQzyT9F9LlDbgwRqxAOn8Y/g==
X-Google-Smtp-Source: ABdhPJy2kSH6h6y9kkTcPgQWy0D7QzOanh5Co0AHDyoZrjssYOOafrgCTehrot5KsrApLFYbMOts4g==
X-Received: by 2002:a17:903:2c2:b029:101:9c88:d928 with SMTP id s2-20020a17090302c2b02901019c88d928mr43694689plk.62.1626097604364;
        Mon, 12 Jul 2021 06:46:44 -0700 (PDT)
Received: from localhost.localdomain ([223.178.210.84])
        by smtp.gmail.com with ESMTPSA id z13sm835405pfn.94.2021.07.12.06.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 06:46:43 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     kgdb-bugreport@lists.sourceforge.net
Cc:     daniel.thompson@linaro.org, jason.wessel@windriver.com,
        dianders@chromium.org, rostedt@goodmis.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v5 1/4] kdb: Rename struct defcmd_set to struct kdb_macro
Date:   Mon, 12 Jul 2021 19:16:17 +0530
Message-Id: <20210712134620.276667-2-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210712134620.276667-1-sumit.garg@linaro.org>
References: <20210712134620.276667-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename struct defcmd_set to struct kdb_macro as that sounds more
appropriate given its purpose.

Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
 kernel/debug/kdb/kdb_main.c | 40 ++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index d8ee5647b732..5cf9867fa118 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -654,7 +654,7 @@ static void kdb_cmderror(int diag)
  * Returns:
  *	zero for success, a kdb diagnostic if error
  */
-struct defcmd_set {
+struct kdb_macro {
 	int count;
 	bool usable;
 	char *name;
@@ -662,8 +662,8 @@ struct defcmd_set {
 	char *help;
 	char **command;
 };
-static struct defcmd_set *defcmd_set;
-static int defcmd_set_count;
+static struct kdb_macro *kdb_macro;
+static int kdb_macro_count;
 static bool defcmd_in_progress;
 
 /* Forward references */
@@ -671,7 +671,7 @@ static int kdb_exec_defcmd(int argc, const char **argv);
 
 static int kdb_defcmd2(const char *cmdstr, const char *argv0)
 {
-	struct defcmd_set *s = defcmd_set + defcmd_set_count - 1;
+	struct kdb_macro *s = kdb_macro + kdb_macro_count - 1;
 	char **save_command = s->command;
 	if (strcmp(argv0, "endefcmd") == 0) {
 		defcmd_in_progress = false;
@@ -704,7 +704,7 @@ static int kdb_defcmd2(const char *cmdstr, const char *argv0)
 
 static int kdb_defcmd(int argc, const char **argv)
 {
-	struct defcmd_set *save_defcmd_set = defcmd_set, *s;
+	struct kdb_macro *save_kdb_macro = kdb_macro, *s;
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
-				   GFP_KDB);
-	if (!defcmd_set)
+	kdb_macro = kmalloc_array(kdb_macro_count + 1, sizeof(*kdb_macro),
+				  GFP_KDB);
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
+	struct kdb_macro *s;
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

