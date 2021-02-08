Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBAF312B70
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 09:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbhBHID5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 03:03:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbhBHIDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 03:03:25 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23548C061756
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 00:02:44 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id q131so9180795pfq.10
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 00:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=+fQMr/aWmvkb1F5+ZUar0gqCKuXntBn/7P21Qz1XhdU=;
        b=XL5pl6h6S5sdi7FHBEN9AblYYdRHALT5fKHT4cBqeoMBNsqGg0pKWRUgEO5UZvA2Mu
         lTOqFaa2yAwLSPDb8dd4WgxDWDhsO2KiEVkRU8QT4UhNtt0OlxXfp84BUxbLT4XqoSEJ
         3e/fBrruIFZhBD0Ma7Rwn1/airOkq8KC4IRv39pEJ6kYBJnX0eQlM2mJef7uz5fy1Evw
         N1SQhSg8/KdTsduBl/BCadKwJfbCnG5P2iUv3w+16xvbxo1yMRYxyhCnbu3h1qfdlTwU
         ovGaJ6Vu0RZOQhhkU45zv9wSm59UniGToTd6U/1GcOiV4IJ94SXKq4jDogRe9ufD4JWq
         /6uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+fQMr/aWmvkb1F5+ZUar0gqCKuXntBn/7P21Qz1XhdU=;
        b=P9p6Oyc1w8iacJYykpsztz/vZRWxaKELBaTx2scE6oiHu1G8XUUFls7Age4bZ9qvs8
         EKEWVtzesBycP5oRj/rwadGLlwxAaQc5a6Go7LKe/apiZo9d/ydXqVsSNrQWxZf0TNhs
         RdynRRZfoFQzwNIR/JA3/2/j1Zb1ZAago3TAE0vpwgmMVAfuiaxfkzuW8K5W+sQw8rF2
         X5Rdp6Ydeq+2HyNGFkFMU9PlUOy+jCcxihF++ax+NZRrrpcTr6T/nOohK+lO3a/MC/Le
         zFLXsK4ocsFADiLtryN2cq6yV8ehPamtRJCPh55158LrmPNd3Krt6KSt5VrnD/RPVWGT
         pAfA==
X-Gm-Message-State: AOAM533IYJdXnNCQVeuMm/2VodWEH73iF6/TJB6qhEKlL/sVj7vUqPHe
        Dt3qvn9rMOFinRQADRnsK2uZcg==
X-Google-Smtp-Source: ABdhPJxMW+K+z4Xvhnqd+px5TwsN/RVFGfV86Uy014rjXfgrS9M5BnwSQ0HfsnLvFyB4P8WwdRCsJQ==
X-Received: by 2002:a63:505d:: with SMTP id q29mr15785019pgl.89.1612771363525;
        Mon, 08 Feb 2021 00:02:43 -0800 (PST)
Received: from localhost.localdomain ([110.226.34.123])
        by smtp.gmail.com with ESMTPSA id 62sm16029223pfg.160.2021.02.08.00.02.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Feb 2021 00:02:42 -0800 (PST)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     kgdb-bugreport@lists.sourceforge.net
Cc:     jason.wessel@windriver.com, daniel.thompson@linaro.org,
        dianders@chromium.org, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v3] kdb: Refactor env variables get/set code
Date:   Mon,  8 Feb 2021 13:32:22 +0530
Message-Id: <1612771342-16883-1-git-send-email-sumit.garg@linaro.org>
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
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v3:
- Remove redundant '\0' char assignment.
- Pick up Doug's review tag.

Changes in v2:
- Get rid of code motion to separate kdb_env.c file.
- Replace (char *)0 with NULL.
- Use kernel-doc style function comments.
- s/kdb_prienv/kdb_printenv/

 kernel/debug/kdb/kdb_main.c | 164 ++++++++++++++++++++++++--------------------
 1 file changed, 91 insertions(+), 73 deletions(-)

diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index 588062a..69b8f55 100644
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
@@ -318,6 +318,63 @@ int kdbgetintenv(const char *match, int *value)
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
@@ -374,10 +431,6 @@ int kdbgetu64arg(const char *arg, u64 *value)
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
@@ -422,37 +475,7 @@ int kdb_set(int argc, const char **argv)
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
@@ -2055,12 +2078,7 @@ static int kdb_lsmod(int argc, const char **argv)
 
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

