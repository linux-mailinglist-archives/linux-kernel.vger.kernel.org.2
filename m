Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C330D33EA39
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 07:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbhCQGzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 02:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbhCQGyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 02:54:24 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203C2C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 23:54:24 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id t7so508346ilq.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 23:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jQIH9wKql140vH9H12VPFHXEPXeFOPyWx7Jj4ptj1nQ=;
        b=kJiaI17VDEKf1CutdLuQYsPpw0CgO9o2hCGmEAInROOZM+OhNZSAt6oexcrJuffomH
         xhVVXiJ0seweBwXcc/aPih/0gppelJdbZc2Q4mkxzVsJM4lmG5S4L0prbq36etI3UrX0
         HdSThRnjA4aSZtO6pqRJE9mUDwynYnQFjJrk4Yy6Oh6+gCpz7BBvUH9UXmWQUF4TPB1W
         qSeL2+G0K0hYPwrs3gAeir55nf5cHl9gE3GpOWanAlcboFBJY5YOjjvreA/gHKNXuz/A
         UvhOYSF7B6BDAYZSin16LNCZoskZmax86KMtbudySiNywFLuYGAf5Pm+2oQbTpF54TKR
         EmAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jQIH9wKql140vH9H12VPFHXEPXeFOPyWx7Jj4ptj1nQ=;
        b=h3K3zRDKoisik9GTpiWgm+zjkCzAgP3Yv1TAx1bWbgJLDHveblZjOCJu3Xe8DSeAM4
         T7sU6es/2sDGEiUiTNuKgMS9UC9luGUghOBHeFUsUfDYS6Ok9hc6DjMN+qnw9AOYhoWK
         TTi5N4ak031hJq+n/pI/nTb6qj07oXpJaRScfLsmGfh1iONINVle86oyZy9hwlCX08AS
         U/auVExUXFsIDC0T/GiXPoH9ut0sr618pSwmUFEEHoEJPmGEcZAwPXJk5vPlB+KXOc/C
         pZVr9229B7k+wv2Hu+F1g1TL4q5w7N7nkJWRJ+kgWOOvxl3cHsea2x0WFE+pCnGFgsU4
         I6EA==
X-Gm-Message-State: AOAM531rMqu0iJw1dpbysjWFGGevKARE6likkbzDoe2jlH9c1juWKV28
        qKKDmNmSdDdcPHhDAvl1nYM=
X-Google-Smtp-Source: ABdhPJx8vjRv0fvoDozho4nssgeIkFO+Hr9NPk6pYHLtRsgJnvv3+GC/JC7TD3MOp0gWLoHsccKxtg==
X-Received: by 2002:a05:6e02:198a:: with SMTP id g10mr5962872ilf.139.1615964063543;
        Tue, 16 Mar 2021 23:54:23 -0700 (PDT)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id w13sm10583057ilg.48.2021.03.16.23.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 23:54:23 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v4 02/19] dyndbg: __init iterate over __dyndbg & __dyndbg_site in parallel
Date:   Wed, 17 Mar 2021 00:53:55 -0600
Message-Id: <20210317065412.2890414-3-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210317065412.2890414-1-jim.cromie@gmail.com>
References: <20210317065412.2890414-1-jim.cromie@gmail.com>
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

