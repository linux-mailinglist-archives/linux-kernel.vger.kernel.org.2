Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24A9B33CCF4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 06:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235310AbhCPFJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 01:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235198AbhCPFIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 01:08:31 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8FE8C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 22:08:31 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id a7so35825146iok.12
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 22:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0XiDLPIZNfQulU2Jq60zc/Wigc5U8DfKdb3VwQxVHwE=;
        b=jWpEnfBHwqmaxhfaswoDuwI+rfV7CPrgUg2fw/obzUic8r3wgox2ZvCjDiuqEvT2me
         QJHowaaDOeorbOPPUEmAns+4+eNhhNNpot/jY5SDeBWB3r5+v/cpq3rhNg4SRQJP0vcR
         HTbIXo6EsJMx1XTRnu1bbAYLwFHdq/gfctAbwmeYvOdk4Wfwp0V/j6IKudqvl9RXPZKQ
         1aE7et4uDsF6QPMGMmWG/op5BDPVnkiymjjWnldgRYihtjmoSNhXi4thAU+Xn/xgk0kR
         wJuOtQcTDH6XTDQZkEcZRiRLKE5nKYnTX70j3t1Vce9lm4NoD0j+sTlrocud096kalwM
         xKyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0XiDLPIZNfQulU2Jq60zc/Wigc5U8DfKdb3VwQxVHwE=;
        b=a2/g3Cb6tEBEBL/Sp1PGQwR/lnI/czshB0XzSE6Qwyfq2fIHT6QbQRo+o8GRFq+LPV
         cR9MIZKK2kUHC/lT8VpIQDTtBX0Ip6Nel3d2JQXXZzztEk28XJ/kRbiep1lFDpyqaZ+t
         AcEg5OUqyWwf6rl+JRNHBlUy1p7LJ6KlwFljh8JYSvkyTRFzkkOr3Sitd+nBJkFi0dM8
         qqD1S+6flqWICS2HL+7iJJ2zKTLxj1OoGLOMk2LK4DOGCAjW1azv3Z8vjaisw8LhI3Ea
         Qh//CJpKtYmIxi5bF4UsrdaYyep97Sq0NKZXbr8CdfDl30VnSdJtbOVsQUPnPK0Y5RRw
         F46A==
X-Gm-Message-State: AOAM532XRc73e8zrAkJQ7lCfapnpeIu7LQkTAz4+pbqxxoQL65cXhcuf
        yaUV2zf13I5rkNmlEXJOook=
X-Google-Smtp-Source: ABdhPJzEnASh2wDwvIPzjMg5OH1Lj2oAOyzYLXhbONo39ObxFyB/3v4dnUg3HcAcN9oHhJELr2fpSQ==
X-Received: by 2002:a05:6602:82:: with SMTP id h2mr2208577iob.20.1615871311096;
        Mon, 15 Mar 2021 22:08:31 -0700 (PDT)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id y9sm8587469ill.15.2021.03.15.22.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 22:08:30 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v3 13/18] dyndbg+module: expose ddebug_sites to modules
Date:   Mon, 15 Mar 2021 23:07:56 -0600
Message-Id: <20210316050801.2446401-14-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210316050801.2446401-1-jim.cromie@gmail.com>
References: <20210316050801.2446401-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to drop the pointer connecting _ddebug's to _ddebug_sites,
we need to elevate the latter; we need to track it in (internal)
ddebug_tables, and set it in ddebug_add_module.  That last part
exposes it by interface to module.c, so we add a field to load_info,
and adjust load_module to initialize it from the elf section.

Its possible that this closes a "hole" created when __dyndbg_sites
section was added, in that the section wasn't "managed" directly, and
could conceivably get lost later.  I never saw any misbehavior loading
i915.ko into a vm, but still..

TBD/RFC:

these 2 vectors should be in a single struct.  if this struct can have
ddebugs[], ie a flex-array, then container_of can get us to the
sites*, yielding &ddebug_sites[N], and allowing to drop _ddebug.site

The trouble with this is that ddebugs* now points to someone elses
memory, and we cant just steal it and stomp on the memory just in
front of it (for the sites ptr).

rename n to numdbgs

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h |  4 ++--
 kernel/module-internal.h      |  1 +
 kernel/module.c               |  9 ++++++---
 lib/dynamic_debug.c           | 18 +++++++++++-------
 4 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index d811273c8484..7d33475d226a 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -70,8 +70,8 @@ struct _ddebug {
 /* exported for module authors to exercise >control */
 int dynamic_debug_exec_queries(const char *query, const char *modname);
 
-int ddebug_add_module(struct _ddebug *tab, unsigned int n,
-				const char *modname);
+int ddebug_add_module(struct _ddebug *tab, struct _ddebug_site *sites,
+		      unsigned int numdbgs, const char *modname);
 extern int ddebug_remove_module(const char *mod_name);
 extern __printf(2, 3)
 void __dynamic_pr_debug(struct _ddebug *descriptor, const char *fmt, ...);
diff --git a/kernel/module-internal.h b/kernel/module-internal.h
index 33783abc377b..fb61eb2f8032 100644
--- a/kernel/module-internal.h
+++ b/kernel/module-internal.h
@@ -18,6 +18,7 @@ struct load_info {
 	char *secstrings, *strtab;
 	unsigned long symoffs, stroffs, init_typeoffs, core_typeoffs;
 	struct _ddebug *debug;
+	struct _ddebug_site *sites;
 	unsigned int num_debug;
 	bool sig_ok;
 #ifdef CONFIG_KALLSYMS
diff --git a/kernel/module.c b/kernel/module.c
index 30479355ab85..792903230acd 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2780,11 +2780,12 @@ static void add_kallsyms(struct module *mod, const struct load_info *info)
 }
 #endif /* CONFIG_KALLSYMS */
 
-static void dynamic_debug_setup(struct module *mod, struct _ddebug *debug, unsigned int num)
+static void dynamic_debug_setup(struct module *mod, struct _ddebug *debug,
+				struct _ddebug_site *sites, unsigned int num)
 {
 	if (!debug)
 		return;
-	ddebug_add_module(debug, num, mod->name);
+	ddebug_add_module(debug, sites, num, mod->name);
 }
 
 static void dynamic_debug_remove(struct module *mod, struct _ddebug *debug)
@@ -3333,6 +3334,8 @@ static int find_module_sections(struct module *mod, struct load_info *info)
 
 	info->debug = section_objs(info, "__dyndbg",
 				   sizeof(*info->debug), &info->num_debug);
+	info->sites = section_objs(info, "__dyndbg_sites",
+				   sizeof(*info->sites), &info->num_debug);
 
 	return 0;
 }
@@ -4004,7 +4007,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
 		goto free_arch_cleanup;
 	}
 
-	dynamic_debug_setup(mod, info->debug, info->num_debug);
+	dynamic_debug_setup(mod, info->debug, info->sites, info->num_debug);
 
 	/* Ftrace init must be called in the MODULE_STATE_UNFORMED state */
 	ftrace_module_init(mod);
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index fdc2d0e15731..5529b17461ae 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -49,6 +49,7 @@ struct ddebug_table {
 	const char *mod_name;
 	unsigned int num_ddebugs;
 	struct _ddebug *ddebugs;
+	struct _ddebug_site *sites;
 };
 
 struct ddebug_query {
@@ -1014,8 +1015,8 @@ static const struct proc_ops proc_fops = {
  * Allocate a new ddebug_table for the given module
  * and add it to the global list.
  */
-int ddebug_add_module(struct _ddebug *tab, unsigned int n,
-			     const char *name)
+int ddebug_add_module(struct _ddebug *tab, struct _ddebug_site *sites,
+		      unsigned int numdbgs, const char *modname)
 {
 	struct ddebug_table *dt;
 
@@ -1030,15 +1031,16 @@ int ddebug_add_module(struct _ddebug *tab, unsigned int n,
 	 * member of struct module, which lives at least as long as
 	 * this struct ddebug_table.
 	 */
-	dt->mod_name = name;
-	dt->num_ddebugs = n;
+	dt->mod_name = modname;
+	dt->num_ddebugs = numdbgs;
 	dt->ddebugs = tab;
+	dt->sites = sites;
 
 	mutex_lock(&ddebug_lock);
 	list_add(&dt->link, &ddebug_tables);
 	mutex_unlock(&ddebug_lock);
 
-	v2pr_info("%3u debug prints in module %s\n", n, dt->mod_name);
+	v2pr_info("%3u debug prints in module %s\n", numdbgs, modname);
 	return 0;
 }
 
@@ -1178,7 +1180,9 @@ static int __init dynamic_debug_init(void)
 
 		if (strcmp(modname, site->modname)) {
 			modct++;
-			ret = ddebug_add_module(iter_mod_start, site_ct, modname);
+
+			ret = ddebug_add_module(iter_mod_start, site_mod_start,
+						site_ct, modname);
 			if (ret)
 				goto out_err;
 			site_ct = 0;
@@ -1188,7 +1192,7 @@ static int __init dynamic_debug_init(void)
 		}
 		site_ct++;
 	}
-	ret = ddebug_add_module(iter_mod_start, site_ct, modname);
+	ret = ddebug_add_module(iter_mod_start, site_mod_start, site_ct, modname);
 	if (ret)
 		goto out_err;
 
-- 
2.29.2

