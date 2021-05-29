Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9B96394DFF
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 22:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbhE2UEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 16:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbhE2UD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 16:03:56 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504C5C06174A
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 13:02:19 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id c31-20020a056830349fb02903a5bfa6138bso49159otu.7
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 13:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VyRXJp6htE6KGEVxutq71HmemF0u/5uG6qw2x18RinI=;
        b=S56wS5tfvRCv74f8oCCpXyRY2Vj3RcS8lB4WWz9hgnTJwErqq+igUPqifqZjZwHiJn
         moLB9VH+niby5LBHuxEsfXia6Sh3/uaaxyHQq3Raxm9zkmjtAShG8Czk20lVgwYx+0uN
         YD4Z+Y1VoJ5VCIg4qORAPhEK9Lb+dqIzzTfx2PqDmgx0AHXsE9ogKdbXjcSJbLJrbLpg
         jDTxaasQO+8ZX/aMh+7zvTWjQzwfQ5McZSKoC6o1uL+m0QC2kJqkuZ/rMkuxPx0Om8/g
         Q0JqiXwK+MZ8hMfTMYgDVBgRwBaEL9mnOxFelShOZddJcs0tdMhGtyM/hPAO61k9rbQf
         5h/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VyRXJp6htE6KGEVxutq71HmemF0u/5uG6qw2x18RinI=;
        b=TPDpH3PzyWJBIA/oni9yluayBxo/e/SPqq5S4iAIOdcHMKGaVVioCpeqRnfyJEeQyv
         X8Ap5NghD/YUfqwCqIrWvfyOxQzYn0LqfAWfkNp7i3EyykSh00x8uObxyG8CIeABykU0
         36U8SJ19U2hlg/FslSRXOrMWjl268hHz022MgjRYHNet48Zetjaz0CCM4fdS04sIDxO3
         fIMDDds3rKLPdurogGd9IX+dsRwzK1FbSnE4CB/EvvNaNsv4yMBB+AofcOVjcItGvQUg
         x0f+5eFEtCtzgWUBXF2BmlGSMP4mjjJNidrlYSLOLknoLQWJvJ4cRvRyju9maTxWN7LC
         djUg==
X-Gm-Message-State: AOAM532JErnCQtrUU4k6pIUax85i/XmP/lfxpyWbOBRerxov5EL/OwIV
        Y1xnh3b6sN1z6UFUPd8mdGA=
X-Google-Smtp-Source: ABdhPJxFXUIwJWyAp8ooRO9Mct5nfehTIirQ+vP1q2o+5sN+2Gk6qEpPA/nzWuQUz9SPVMPPealhsA==
X-Received: by 2002:a9d:4008:: with SMTP id m8mr2731336ote.188.1622318538672;
        Sat, 29 May 2021 13:02:18 -0700 (PDT)
Received: from frodo.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id t39sm1868064ooi.42.2021.05.29.13.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 13:02:18 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v6 05/34] dyndbg: __init iterate over __dyndbg & __dyndbg_site in parallel
Date:   Sat, 29 May 2021 14:00:00 -0600
Message-Id: <20210529200029.205306-6-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210529200029.205306-1-jim.cromie@gmail.com>
References: <20210529200029.205306-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In HEAD~1, a new elf section was added, and dynamic_debug_init() got
minimal adjustments; basically s/iter/iter->site/ where needed.

Now we rework the for-loop for clarity:
. iterate over both sections in parallel (iter & site)
. demote iter->site indirection (1st step towards dropping site)
. add __(start|stop)___dyndbg_sites decls (init'd in vmlinux.lds.h)
. add/rename several iterator/mod_start variables for clarity.
. add BUG_ON(iter->site != site)
. var rename n to site_ct

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 691e43d58eef..f7ece35bc722 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -41,6 +41,8 @@
 
 extern struct _ddebug __start___dyndbg[];
 extern struct _ddebug __stop___dyndbg[];
+extern struct _ddebug_site __start___dyndbg_sites[];
+extern struct _ddebug_site __stop___dyndbg_sites[];
 
 struct ddebug_table {
 	struct list_head link;
@@ -118,6 +120,7 @@ do {								\
 
 #define vpr_info(fmt, ...)	vnpr_info(1, fmt, ##__VA_ARGS__)
 #define v2pr_info(fmt, ...)	vnpr_info(2, fmt, ##__VA_ARGS__)
+#define v3pr_info(fmt, ...)	vnpr_info(3, fmt, ##__VA_ARGS__)
 
 static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
 {
@@ -1086,11 +1089,12 @@ static int __init dynamic_debug_init_control(void)
 
 static int __init dynamic_debug_init(void)
 {
-	struct _ddebug *iter, *iter_start;
+	struct _ddebug *iter, *iter_mod_start;
+	struct _ddebug_site *site, *site_mod_start;
 	const char *modname = NULL;
 	char *cmdline;
 	int ret = 0;
-	int n = 0, entries = 0, modct = 0;
+	int site_ct = 0, entries = 0, modct = 0;
 
 	if (&__start___dyndbg == &__stop___dyndbg) {
 		if (IS_ENABLED(CONFIG_DYNAMIC_DEBUG)) {
@@ -1101,23 +1105,29 @@ static int __init dynamic_debug_init(void)
 		ddebug_init_success = 1;
 		return 0;
 	}
-	iter = __start___dyndbg;
-	modname = iter->site->modname;
-	iter_start = iter;
-	for (; iter < __stop___dyndbg; iter++) {
+
+	iter = iter_mod_start = __start___dyndbg;
+	site = site_mod_start = __start___dyndbg_sites;
+	modname = site->modname;
+
+	for (; iter < __stop___dyndbg; iter++, site++) {
+
+		BUG_ON(site != iter->site);
 		entries++;
-		if (strcmp(modname, iter->site->modname)) {
+
+		if (strcmp(modname, site->modname)) {
 			modct++;
-			ret = ddebug_add_module(iter_start, n, modname);
+			ret = ddebug_add_module(iter_mod_start, site_ct, modname);
 			if (ret)
 				goto out_err;
-			n = 0;
-			modname = iter->site->modname;
-			iter_start = iter;
+			site_ct = 0;
+			modname = site->modname;
+			iter_mod_start = iter;
+			site_mod_start = site;
 		}
-		n++;
+		site_ct++;
 	}
-	ret = ddebug_add_module(iter_start, n, modname);
+	ret = ddebug_add_module(iter_mod_start, site_ct, modname);
 	if (ret)
 		goto out_err;
 
-- 
2.31.1

