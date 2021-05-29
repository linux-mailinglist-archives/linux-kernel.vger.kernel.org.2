Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 979F2394E1A
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 22:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbhE2UFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 16:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbhE2UEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 16:04:23 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194CAC061348
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 13:02:46 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id v22so7972213oic.2
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 13:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zM9vLA05BUCYqav0NtZSubdO0OXNsYrh7MVHcByF0nc=;
        b=VXWM8kUtsMvmUTbdf1E/BZt/8BKDP03rh4ER4VXmTkiXWpew6WMoZoWUd+HdF5M2aD
         1nLD+4Pkx5IXa3nEbvPAJSE5ZodE+srWkMXQAuaZ1tuhrtrCQkjW4HapNnpPE/HaFdgM
         APZNPwAAIDSkNpXCV1AXjYmRboOEOmE+dn4C1L/+V7+ABn6YURJ6KUAQ9ocLErhjkZfE
         mrfhoT5PjVBNEuHKB2znE1FiM+LBR8W22oOgwmVm0zjoNF679FBrRFUASKZrhRz1Yb/P
         rTkqBM9xctorDWw00jc/kAxcAies/ypeZW3kCkgH+/FnOJyZCbHoRgyBKUqWK3kE22bI
         d1ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zM9vLA05BUCYqav0NtZSubdO0OXNsYrh7MVHcByF0nc=;
        b=B2IZP8wfRKjUCg0mPlB3aGaDLM9ndg7zvW3ERlfYsDuC22d9i3j/LlLqdyWodrBfrO
         qcK2DoNZtg30fdKWkC5f84QY2Jhg9puTBajCxk9v0Q2csGcixGi1kBKs0J96RMNfCZ0l
         c/LOH6Nrj2ccW4YySUUU6XHgFVQYe8mEqTRuh5jXB+ZECD9uvsplUurjNJyr0/ybb+Rq
         mNrrCoD22/V5+c678TvcXPL31ux+cQFCTbgQwE5uJA9LQzcpOiNOdA3U8Dn9SIQZP2bA
         l9kLWBeSxacSGfBgQy03Gl2iYqTkhT8y+yT/zN9fsQgilnFSWiM7B3nGaDSbPWnLrSJo
         Rhhg==
X-Gm-Message-State: AOAM530pSbRp1Q0IQeOh9Ar70vcXrrr9svcHAMBahEHuLVWvh8xVJA9O
        au3sT5fUZTP7sVv1Q9+QaKo=
X-Google-Smtp-Source: ABdhPJxQTInSQ3743E2EZTjTmHxuPF7kJ6VtIfdlNfycOTivbykpRMhPVGV344FRVfhU98ery9Zt5Q==
X-Received: by 2002:a05:6808:14ce:: with SMTP id f14mr10310328oiw.140.1622318565489;
        Sat, 29 May 2021 13:02:45 -0700 (PDT)
Received: from frodo.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id t39sm1868064ooi.42.2021.05.29.13.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 13:02:45 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v6 31/34] dyndbg: detect repeated site recs in add_module
Date:   Sat, 29 May 2021 14:00:26 -0600
Message-Id: <20210529200029.205306-32-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210529200029.205306-1-jim.cromie@gmail.com>
References: <20210529200029.205306-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the 1st patch in this series, which partitioned into structs
_ddebug & _ddebug_site while leaving lineno in _ddebug, we have had
chunks of repeating site records; every pr_debug in a function
has identical site data.

To avoid reliance on the redundant data, we need:
0. ._map field (added HEAD~1)
1. detection of repeating sites.

In ddebug_add_module(), alter the index initialization loop to recognize
the 1st record in each block of repeats, remember it in "j", and use it
to ._map all the pr_debugs in that block.  To find the block starts,
we can just look for a new .function in each row.

This gives us, for each function; 1st used row, 2nd-Nth unused rows.
To actually reclaim useful memory chunks, we will have to pack the
site records up towards the header.

Heres what booting with dynamic_debug.verbose=3 will show:

1st 3 builtin modules:
- cols 3,4 row 1 - shows +1 due to previous head64
- cols 2,4 - shows repeat detection working

rcu: Hierarchical SRCU implementation.
dyndbg: add-module: head64.1 sites
dyndbg:  skip header head64
dyndbg: add-module: main.6 sites
Callback from call_rcu_tasks_trace() invoked.
dyndbg:  0 0 1 1 main.run_init_process.1358
dyndbg:  1 0 2 1 main.run_init_process.1356
dyndbg:  2 0 3 1 main.run_init_process.1355
dyndbg:  3 0 4 1 main.run_init_process.1353
dyndbg:  4 4 5 5 main.initcall_blacklisted.1142
dyndbg:  5 5 6 6 main.initcall_blacklist.1103
dyndbg:   6 debug prints in module main (in 3 functions)
dyndbg: add-module: initramfs.1 sites
dyndbg:  0 0 7 7 initramfs.unpack_to_rootfs.496
dyndbg:   1 debug prints in module initramfs (in 1 functions)
dyndbg: add-module: ibs.3 sites
dyndbg:  0 0 8 8 ibs.force_ibs_eilvt_setup.926
dyndbg:  1 1 9 9 ibs.setup_ibs_ctl.897
dyndbg:  2 1 10 9 ibs.setup_ibs_ctl.890
dyndbg:   3 debug prints in module ibs (in 2 functions)

for a loaded module:
- row 0000 - is the header (function==module) - lineno is garbage
- cols 2,4 - show repeat detect
- 9 functions - over by 1, due to counting the header

dyndbg: add-module: intel_rapl_common.13 sites
dyndbg:  0 0 0 0 intel_rapl_common.intel_rapl_common.16928
dyndbg:  1 1 1 1 intel_rapl_common.rapl_remove_package.1279
dyndbg:  2 2 2 2 intel_rapl_common.rapl_detect_domains.1245
dyndbg:  3 2 3 2 intel_rapl_common.rapl_detect_domains.1242
dyndbg:  4 4 4 4 intel_rapl_common.rapl_package_register_powercap.1159
dyndbg:  5 4 5 4 intel_rapl_common.rapl_package_register_powercap.1145
dyndbg:  6 4 6 4 intel_rapl_common.rapl_package_register_powercap.1114
dyndbg:  7 4 7 4 intel_rapl_common.rapl_package_register_powercap.1108
dyndbg:  8 8 8 8 intel_rapl_common.rapl_update_domain_data.1083
dyndbg:  9 9 9 9 intel_rapl_common.rapl_check_unit_atom.824
dyndbg:  10 10 10 10 intel_rapl_common.rapl_check_unit_core.796
dyndbg:  11 11 11 11 intel_rapl_common.rapl_read_data_raw.722
dyndbg:  12 12 12 12 intel_rapl_common.contraint_to_pl.303
dyndbg:  13 debug prints in module intel_rapl_common (in 9 functions)
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 524303a04462..e12538640b51 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1073,7 +1073,7 @@ static int __ddebug_add_module(struct _ddebug *tab, struct _ddebug_site *sites,
 {
 	struct ddebug_table *dt;
 	union _ddebug_header *dh = (union _ddebug_header *) &tab[0];
-	int i;
+	int i, j, ct;
 
 	v3pr_info("add-module: %s.%d sites\n", modname, numdbgs);
 
@@ -1107,10 +1107,22 @@ static int __ddebug_add_module(struct _ddebug *tab, struct _ddebug_site *sites,
 	dt->ddebugs = tab;
 	dt->sites = sites;
 
-	for (i = 0; i < numdbgs; i++) {
-		tab[i]._back = base + i;
-		tab[i]._map = base + i;
-		v3pr_info(" %d %d %d %s.%s.%d\n", i, tab[i]._back, tab[i]._map,
+	/*
+	 * Since sites don't have lineno (thats in struct _ddebug),
+	 * all pr_debugs in a function have identical site data.  So
+	 * we watch for repeats on site.function, and reuse the index
+	 * of the 1st site record in a repeating block.
+	 */
+	for (ct = i = j = 0; i < numdbgs; i++) {
+		tab[i]._back = base + i; /* index back to header */
+
+		if (sites[i].function != sites[j].function) {
+			j = i; /* remember 1st row with new fn */
+			ct++;
+		}
+		tab[i]._map = base + j;
+
+		v3pr_info(" %d %d %d %d %s.%s.%d\n", i, j, tab[i]._back, tab[i]._map,
 			  modname, sites[i].function, tab[i].lineno);
 	}
 
@@ -1118,7 +1130,9 @@ static int __ddebug_add_module(struct _ddebug *tab, struct _ddebug_site *sites,
 	list_add(&dt->link, &ddebug_tables);
 	mutex_unlock(&ddebug_lock);
 
-	v2pr_info("%3u debug prints in module %s\n", numdbgs, modname);
+	v2pr_info("%3u debug prints in module %s (in %d functions)\n",
+		  numdbgs, modname, ++ct);
+
 	return 0;
 }
 
-- 
2.31.1

