Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39BB833CCE9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 06:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235211AbhCPFIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 01:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235166AbhCPFIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 01:08:22 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF19C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 22:08:22 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id f20so35809266ioo.10
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 22:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jQIH9wKql140vH9H12VPFHXEPXeFOPyWx7Jj4ptj1nQ=;
        b=T/S/MFFbtnQ8LMNovkQTnmyJdJJ6TaYGXtH9lc0BS8wxXQedY223v/JCObUTJYyc/m
         dPzdVWvMuGmVuMdmvA/sBJlIeY9MR+0KXsgsL0N7a5uG2fEBSvc8K2/mrLIW5CbvQeD8
         oPWXyzlgFNVzCzW6l2Cz0noIBVK+vXtx3aT6oOD/+2GLljkiYo+G2GIPhcZFPKJOP/7F
         2IS19vVg5Jyzi6S5lwTBfNxzOTXQ4fS0HG3+LFdVsTnlMXzVkGTE4r0YeO4t0dtmSHU+
         K5mfgdqZyfBoBRL+lhXnVKI4/32pSJ7OF1wx1bpRQJ87hQCVC20v+vl0W1yny6ZsmTLS
         glFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jQIH9wKql140vH9H12VPFHXEPXeFOPyWx7Jj4ptj1nQ=;
        b=PBGpq+wrx7M5qv3d7VYfd9D9AOp37ZvJLb41b6D9j+AUaLorNQjT0eoqGlMkypjBWr
         Yl1YddFx+nUXA+MJ3oABOGRR8bUzRnYbc0zZIb8k66X7c53OfWGgM2QuJetdMjZzYB5S
         mN2JpvpkTxFOgWxNmFBpywQchF2QLMK5asr/KFIr8cvClT3QMRB9sJ/Q7suyz2Hbqh7m
         Y0Ac2pMm1U+vwYOWWdRjhQk6M3JyaLvdIw6U8TmTsuDQCYTxKA/dYogq0+MWz8l6RPRm
         Hxjnk8X0YQH79ED4FdyhCTy2XMiAii0+53UHr5zyRIabzdMf88gLi5iB7UCuEVqlLSyB
         BUCQ==
X-Gm-Message-State: AOAM530GQRQElYGfgmXVHt9+2fuYoFYDEzt8VF5IwQfMx6f3GFug8hCy
        UG5MYFUlrqjvJlgJWu3RGP8=
X-Google-Smtp-Source: ABdhPJwq1x2nhZlzev4idoRPUjCeojx9KZ3z9NeD8bF6j+1u4meCzQulhgyFRPBwNhhT1QWtCchIaw==
X-Received: by 2002:a05:6638:238c:: with SMTP id q12mr12715558jat.114.1615871301657;
        Mon, 15 Mar 2021 22:08:21 -0700 (PDT)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id y9sm8587469ill.15.2021.03.15.22.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 22:08:21 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v3 02/18] dyndbg: __init iterate over __dyndbg & __dyndbg_site in parallel
Date:   Mon, 15 Mar 2021 23:07:45 -0600
Message-Id: <20210316050801.2446401-3-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210316050801.2446401-1-jim.cromie@gmail.com>
References: <20210316050801.2446401-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In dynamic_debug_init(), rework for-loop; add 2nd 'site' var, and
iterate over both __dyndbg* sections in parallel.  Replace uses of
iter->site with the new 'site' iter, add a BUG_ON to enforce the
invariant given by HEAD~1's DECLARE_DYNAMIC_DEBUG_METADATA base->site
initialization.

0- declare the new elf section start/stop, named in vmlinux.lds.h
   I disregarded a checkpatch warning about externs in c-files, stuck
   with current practice.

1- clean up use of 4 iterators for clarity:
   (iter, site), and ((iter, site)_mod_start) block markers.

2- iterate over __dyndbg_sites in parallel with __dyndbg
   s/iter->site/site/g;

3- add BUG_ON(iter->site != site)
   DECLARE_DYNAMIC_DEBUG_METADATA + linker insure this now.
   Maybe we can drop pointer, still get order.

4- var rename n to site_ct

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 738c4ce28046..c3c35dcc6a59 100644
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
@@ -1082,11 +1085,12 @@ static int __init dynamic_debug_init_control(void)
 
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
@@ -1097,23 +1101,29 @@ static int __init dynamic_debug_init(void)
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
2.29.2

