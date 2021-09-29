Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66AED41CBFB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 20:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346305AbhI2Sji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 14:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346298AbhI2Sjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 14:39:33 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5CBC061765
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 11:37:52 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id d18so4326520iof.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 11:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DtaQmnYxZ0qqBCuTYKefIwzGpp07ymsLBorFT9oF+WE=;
        b=SxOoGN53QrPvDMhwVdV/5ExVJjWDY3LJAi3UwWN8sUkt++RPJOK4bBulE3f4PPtOTV
         lQxFLSO+ocpwQ38M/RLwz9PbyzdvSqI9nAkYStuORhJYb96CxYyAnTmp7DrZu4xShzTn
         JDDCfW3TXFJf3zQhrhLUrEyvV4d/HoBoEnBmllqPlmYU0jE5HgzysMWxBfgIbhq7CSyE
         ukLUlaQjaUsRBVHztLp88eqO4FZPxU94IVq/4xJ3AiZtUs7s9sFiBrnGX/8o+zDZXgFz
         kMCdzIeYlOaYnr9tDNrfyP5RDJBFCg9+bk9f+awlgcoidtLZrhhcaY8ZEO7UXjA0DMrJ
         7p/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DtaQmnYxZ0qqBCuTYKefIwzGpp07ymsLBorFT9oF+WE=;
        b=h5AM6hUcqxndXvWEYmCDULAfy7JmT3kWCUmtsHx0bP+Ee4cHa0NsVKUjk/85RoBHQl
         ZDIwFG/wLvB5YjLNDP/Jw2I4Mdr1eQ22D7PWGviRE1pTNSwOKsBxAjRaX6LEg81pMPcj
         dB3yl5eWuPBz3wyuOmMX8xxeDlvujrDy1Mf5TRywGFXiQEtgU10vMDuyO3BM/tqpW7Dw
         CdgxxAIxsiBlBPAjVcPB60BpCi3KhNRBq5+spEB9jhYPmUf/CSz6fwZ/zXPAZ/pEgGnz
         wqPkvYpWNKIUZHkUG3/YrgTyU0i4gOxCluMVhEI/YHNJX2WZ2O4OAuf6RjAoj0NnP9Id
         bxzQ==
X-Gm-Message-State: AOAM531UlMJEgIa4/r54Oy9JUD4hu75rimy3J0w3IgBlVwAxsSqMOyLZ
        D79ASX5NuAE8PdERarGjRzg=
X-Google-Smtp-Source: ABdhPJyOnRYbICxMWROH0uXFBgHNHcWiDqKTjxy4u3W0i9UFQo/whdb34kWhQWnViy2APYSjh+tVKg==
X-Received: by 2002:a05:6602:240d:: with SMTP id s13mr934287ioa.94.1632940671821;
        Wed, 29 Sep 2021 11:37:51 -0700 (PDT)
Received: from samwise.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id y2sm317041ioj.12.2021.09.29.11.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 11:37:51 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 3/6] dyndbg: rationalize verbosity
Date:   Wed, 29 Sep 2021 12:37:32 -0600
Message-Id: <20210929183735.6630-4-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210929183735.6630-1-jim.cromie@gmail.com>
References: <20210929183735.6630-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

change current v*pr_info() calls to fit this new scheme:

-1 module level activity: add/remove, etc
-2 command ingest, splitting
   per >control write
-3 command parsing - many v1s here now
-4 per-site changes - was v2

-2 is new, to isolate a problem where a stress-test script (which
feeds large multi-command strings) would produce short writes,
truncating last command and causing parsing errors, which confused
test results.  The 1st fix was to use syswrite in the script, to
deliver full proper commands.

-4 gets per-callsite "changed:" pr-infos, which are very noisy during
stress tests, and obscure v1-3 messages.

Update docs verbose example to 3 per its comment (potential conflict here)

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 .../admin-guide/dynamic-debug-howto.rst       |  2 +-
 lib/dynamic_debug.c                           | 22 ++++++++++---------
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index b119b8277b3e..ab28d200f016 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -358,7 +358,7 @@ Examples
   // boot-args example, with newlines and comments for readability
   Kernel command line: ...
     // see whats going on in dyndbg=value processing
-    dynamic_debug.verbose=1
+    dynamic_debug.verbose=3
     // enable pr_debugs in 2 builtins, #cmt is stripped
     dyndbg="module params +p #cmt ; module sys +p"
     // enable pr_debugs in 2 functions in a module loaded later
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 5403a4515a4a..47286a73fff4 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -118,6 +118,8 @@ do {								\
 
 #define vpr_info(fmt, ...)	vnpr_info(1, fmt, ##__VA_ARGS__)
 #define v2pr_info(fmt, ...)	vnpr_info(2, fmt, ##__VA_ARGS__)
+#define v3pr_info(fmt, ...)	vnpr_info(3, fmt, ##__VA_ARGS__)
+#define v4pr_info(fmt, ...)	vnpr_info(4, fmt, ##__VA_ARGS__)
 
 static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
 {
@@ -130,7 +132,7 @@ static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
 			fmtlen--;
 	}
 
-	vpr_info("%s: func=\"%s\" file=\"%s\" module=\"%s\" format=\"%.*s\" lineno=%u-%u\n",
+	v3pr_info("%s: func=\"%s\" file=\"%s\" module=\"%s\" format=\"%.*s\" lineno=%u-%u\n",
 		 msg,
 		 query->function ?: "",
 		 query->filename ?: "",
@@ -213,7 +215,7 @@ static int ddebug_change(const struct ddebug_query *query,
 				static_branch_enable(&dp->key.dd_key_true);
 #endif
 			dp->flags = newflags;
-			v2pr_info("changed %s:%d [%s]%s =%s\n",
+			v4pr_info("changed %s:%d [%s]%s =%s\n",
 				 trim_prefix(dp->filename), dp->lineno,
 				 dt->mod_name, dp->function,
 				 ddebug_describe_flags(dp->flags, &fbuf));
@@ -273,7 +275,7 @@ static int ddebug_tokenize(char *buf, char *words[], int maxwords)
 		buf = end;
 	}
 
-	if (verbose) {
+	if (verbose >= 3) {
 		int i;
 		pr_info("split into words:");
 		for (i = 0; i < nwords; i++)
@@ -333,7 +335,7 @@ static int parse_linerange(struct ddebug_query *query, const char *first)
 	} else {
 		query->last_lineno = query->first_lineno;
 	}
-	vpr_info("parsed line %d-%d\n", query->first_lineno,
+	v3pr_info("parsed line %d-%d\n", query->first_lineno,
 		 query->last_lineno);
 	return 0;
 }
@@ -447,7 +449,7 @@ static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
 		pr_err("bad flag-op %c, at start of %s\n", *str, str);
 		return -EINVAL;
 	}
-	vpr_info("op='%c'\n", op);
+	v3pr_info("op='%c'\n", op);
 
 	for (; *str ; ++str) {
 		for (i = ARRAY_SIZE(opt_array) - 1; i >= 0; i--) {
@@ -461,7 +463,7 @@ static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
 			return -EINVAL;
 		}
 	}
-	vpr_info("flags=0x%x\n", modifiers->flags);
+	v3pr_info("flags=0x%x\n", modifiers->flags);
 
 	/* calculate final flags, mask based upon op */
 	switch (op) {
@@ -477,7 +479,7 @@ static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
 		modifiers->flags = 0;
 		break;
 	}
-	vpr_info("*flagsp=0x%x *maskp=0x%x\n", modifiers->flags, modifiers->mask);
+	v3pr_info("*flagsp=0x%x *maskp=0x%x\n", modifiers->flags, modifiers->mask);
 
 	return 0;
 }
@@ -540,7 +542,7 @@ static int ddebug_exec_queries(char *query, const char *modname)
 		}
 		i++;
 	}
-	vpr_info("processed %d queries, with %d matches, %d errs\n",
+	v2pr_info("processed %d queries, with %d matches, %d errs\n",
 		 i, nfound, errs);
 
 	if (exitcode)
@@ -781,7 +783,7 @@ static ssize_t ddebug_proc_write(struct file *file, const char __user *ubuf,
 	tmpbuf = memdup_user_nul(ubuf, len);
 	if (IS_ERR(tmpbuf))
 		return PTR_ERR(tmpbuf);
-	vpr_info("read %d bytes from userspace\n", (int)len);
+	v2pr_info("read %zu bytes from userspace <\n%s>\n", len, tmpbuf);
 
 	ret = ddebug_exec_queries(tmpbuf, NULL);
 	kfree(tmpbuf);
@@ -969,7 +971,7 @@ int ddebug_add_module(struct _ddebug *tab, unsigned int n,
 	list_add(&dt->link, &ddebug_tables);
 	mutex_unlock(&ddebug_lock);
 
-	v2pr_info("%3u debug prints in module %s\n", n, dt->mod_name);
+	vpr_info("%3u debug prints in module %s\n", n, dt->mod_name);
 	return 0;
 }
 
-- 
2.31.1

