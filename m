Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFD830F045
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 11:17:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235405AbhBDKPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 05:15:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235310AbhBDKPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 05:15:23 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 416F8C0613D6
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 02:14:43 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id d26so584263pfn.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 02:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ihO1Bw9PZGVXNi4lRJ7ISn0OCRqLi6mJnCqOoIVfBhY=;
        b=VA2luoRv4U/JwrdENGJD9ug/MP4yLZV8jDFJAh0T2PmjYRlgBEkJR+Jj0l/XqOh9lO
         FZWBjiGnj/tPjL2oL/6P+uM5w5djRVMwJoP1hnMbZP+x2ClE5h/YMPQ45+buvnDnsNG0
         wN12wjFVzhQ3fmbfKvaj0NfnGIICyYbhbpBRtR2zS3bcC0OlAny+F5PxJ6NM0KaIi4l1
         MY55bcDYbq/JSoTV9aAm6S79n/mTZf5WjbXnChF26nZJoulE03VfhOZCruHEzrsW0WJU
         B7CP+4fZrLrQ3YornOgHX8a/iWdju7LULoKzLT/F9by4sNfhKLxiHbVFKvz/q9znfCax
         3r3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ihO1Bw9PZGVXNi4lRJ7ISn0OCRqLi6mJnCqOoIVfBhY=;
        b=k/nyVueanMR6GH4eTwVBJhQImk6epWhovP93kERW0D5q/Y7iClPIOJ83RWUrl53oNc
         pxn+9E9eF7gBgWuOHpKS15Mfp0wXl59JEyqfsjFE5iC18lgCrVCX62bPbSg/4qu4Hqar
         MGT69PPFcf+0Vk6yOj6JAzOkhHE/Ti6y/XBAM2a3sGhQxKdSJroWZYOnb36//z7E5/vx
         naoad6WSB1wlEYXW1P+CK7FcTrsTqHScYGN8a04bJDx7X7vrxNJ0HYVlTfbPZX3Ev5T3
         bJinUOxa1OumoXqgpdNVdX9Ffc6fEKoaRwpmbQqbScGuhAC3CgsCahL2VBGaam4OxqjE
         pmlA==
X-Gm-Message-State: AOAM531AEr2cWF6CkfQsbdFKsAoI/8B31kXwDRbd2BwytHHLBP9BF0JC
        Km/DwC6hMf+7ZUOhSi8rWmTteg==
X-Google-Smtp-Source: ABdhPJzr4IVo1KRB0oUmKA8V+67C9Q6qvDs6ikyR9FHb4z/hb2cmdHr7cjgzRjXMyI0gcLTuHoiOYA==
X-Received: by 2002:a63:e50:: with SMTP id 16mr8213310pgo.74.1612433682594;
        Thu, 04 Feb 2021 02:14:42 -0800 (PST)
Received: from localhost.localdomain ([110.226.34.123])
        by smtp.gmail.com with ESMTPSA id g5sm5363771pfm.115.2021.02.04.02.14.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Feb 2021 02:14:41 -0800 (PST)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     kgdb-bugreport@lists.sourceforge.net
Cc:     jason.wessel@windriver.com, daniel.thompson@linaro.org,
        dianders@chromium.org, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v2] kdb: Refactor env variables get/set code
Date:   Thu,  4 Feb 2021 15:44:20 +0530
Message-Id: <1612433660-32661-1-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add two new kdb environment access methods as kdb_setenv() and
kdb_printenv() in order to abstract out environment access code
from kdb command functions.

Also, replace (char *)0 with NULL as an initializer for environment
variables array.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---

Changes in v2:
- Get rid of code motion to separate kdb_env.c file.
- Replace (char *)0 with NULL.
- Use kernel-doc style function comments.
- s/kdb_prienv/kdb_printenv/

 kernel/debug/kdb/kdb_main.c | 166 +++++++++++++++++++++++++-------------------
 1 file changed, 93 insertions(+), 73 deletions(-)

diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index 588062a..b257d35 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -142,40 +142,40 @@ static const int __nkdb_err = ARRAY_SIZE(kdbmsgs);
 
 static char *__env[] = {
 #if defined(CONFIG_SMP)
- "PROMPT=[%d]kdb> ",
+	"PROMPT=[%d]kdb> ",
 #else
- "PROMPT=kdb> ",
+	"PROMPT=kdb> ",
 #endif
- "MOREPROMPT=more> ",
- "RADIX=16",
- "MDCOUNT=8",			/* lines of md output */
- KDB_PLATFORM_ENV,
- "DTABCOUNT=30",
- "NOSECT=1",
- (char *)0,
- (char *)0,
- (char *)0,
- (char *)0,
- (char *)0,
- (char *)0,
- (char *)0,
- (char *)0,
- (char *)0,
- (char *)0,
- (char *)0,
- (char *)0,
- (char *)0,
- (char *)0,
- (char *)0,
- (char *)0,
- (char *)0,
- (char *)0,
- (char *)0,
- (char *)0,
- (char *)0,
- (char *)0,
- (char *)0,
- (char *)0,
+	"MOREPROMPT=more> ",
+	"RADIX=16",
+	"MDCOUNT=8",		/* lines of md output */
+	KDB_PLATFORM_ENV,
+	"DTABCOUNT=30",
+	"NOSECT=1",
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
+	NULL,
 };
 
 static const int __nenv = ARRAY_SIZE(__env);
@@ -318,6 +318,65 @@ int kdbgetintenv(const char *match, int *value)
 }
 
 /*
+ * kdb_setenv() - Alter an existing environment variable or create a new one.
+ * @var: Name of the variable
+ * @val: Value of the variable
+ *
+ * Return: Zero on success, a kdb diagnostic on failure.
+ */
+static int kdb_setenv(const char *var, const char *val)
+{
+	int i;
+	char *ep;
+	size_t varlen, vallen;
+
+	varlen = strlen(var);
+	vallen = strlen(val);
+	ep = kdballocenv(varlen + vallen + 2);
+	if (ep == (char *)0)
+		return KDB_ENVBUFFULL;
+
+	sprintf(ep, "%s=%s", var, val);
+
+	ep[varlen+vallen+1] = '\0';
+
+	for (i = 0; i < __nenv; i++) {
+		if (__env[i]
+		 && ((strncmp(__env[i], var, varlen) == 0)
+		   && ((__env[i][varlen] == '\0')
+		    || (__env[i][varlen] == '=')))) {
+			__env[i] = ep;
+			return 0;
+		}
+	}
+
+	/*
+	 * Wasn't existing variable.  Fit into slot.
+	 */
+	for (i = 0; i < __nenv-1; i++) {
+		if (__env[i] == (char *)0) {
+			__env[i] = ep;
+			return 0;
+		}
+	}
+
+	return KDB_ENVFULL;
+}
+
+/*
+ * kdb_printenv() - Display the current environment variables.
+ */
+static void kdb_printenv(void)
+{
+	int i;
+
+	for (i = 0; i < __nenv; i++) {
+		if (__env[i])
+			kdb_printf("%s\n", __env[i]);
+	}
+}
+
+/*
  * kdbgetularg - This function will convert a numeric string into an
  *	unsigned long value.
  * Parameters:
@@ -374,10 +433,6 @@ int kdbgetu64arg(const char *arg, u64 *value)
  */
 int kdb_set(int argc, const char **argv)
 {
-	int i;
-	char *ep;
-	size_t varlen, vallen;
-
 	/*
 	 * we can be invoked two ways:
 	 *   set var=value    argv[1]="var", argv[2]="value"
@@ -422,37 +477,7 @@ int kdb_set(int argc, const char **argv)
 	 * Tokenizer squashed the '=' sign.  argv[1] is variable
 	 * name, argv[2] = value.
 	 */
-	varlen = strlen(argv[1]);
-	vallen = strlen(argv[2]);
-	ep = kdballocenv(varlen + vallen + 2);
-	if (ep == (char *)0)
-		return KDB_ENVBUFFULL;
-
-	sprintf(ep, "%s=%s", argv[1], argv[2]);
-
-	ep[varlen+vallen+1] = '\0';
-
-	for (i = 0; i < __nenv; i++) {
-		if (__env[i]
-		 && ((strncmp(__env[i], argv[1], varlen) == 0)
-		   && ((__env[i][varlen] == '\0')
-		    || (__env[i][varlen] == '=')))) {
-			__env[i] = ep;
-			return 0;
-		}
-	}
-
-	/*
-	 * Wasn't existing variable.  Fit into slot.
-	 */
-	for (i = 0; i < __nenv-1; i++) {
-		if (__env[i] == (char *)0) {
-			__env[i] = ep;
-			return 0;
-		}
-	}
-
-	return KDB_ENVFULL;
+	return kdb_setenv(argv[1], argv[2]);
 }
 
 static int kdb_check_regs(void)
@@ -2055,12 +2080,7 @@ static int kdb_lsmod(int argc, const char **argv)
 
 static int kdb_env(int argc, const char **argv)
 {
-	int i;
-
-	for (i = 0; i < __nenv; i++) {
-		if (__env[i])
-			kdb_printf("%s\n", __env[i]);
-	}
+	kdb_printenv();
 
 	if (KDB_DEBUG(MASK))
 		kdb_printf("KDBDEBUG=0x%x\n",
-- 
2.7.4

