Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F15FE37AEC7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 20:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbhEKSxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 14:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232198AbhEKSwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 14:52:46 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C27EC06138B
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 11:51:34 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id v13so18058188ilj.8
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 11:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aWjz67jruSBa3AfnJK6T0K+rhp52me264VjeXl1/Rrw=;
        b=tcmZbpv4N7BmdgE/VhMdKYX5VajzQkXZ9HM9JhHaPQegrpCIW6+E8YvZtCfgkdj/1q
         uCKZCSoPJb84nkdfmWQpXyFsga/opJNb0sc0Lm1lPgBD83G7Ab964HZMQxHXmk9g3NBY
         Csth1IFzOhyIUsjpkJ6BBIriMaY8S5e4meZjdOoOfCbIKa9/OTa5NImaId8UNpVh1GRq
         YTjVInNQ7c7romCCF2Pj0ujgveX/KhTfhzZJ8OdPY6ECAo+4PbszxPqjbhlPMQRDAYR8
         8C1aQWMs7JJ2qqOmzjb7HRUXiBwTTtzviJ99li2XUuJ7wSQrTgSVTRiaT0hxXNF8zMsD
         7Fzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aWjz67jruSBa3AfnJK6T0K+rhp52me264VjeXl1/Rrw=;
        b=kUFC5KknAcgU7ygERyO+w7w0r1s2qR4zYDv3c/NJyaYgIvi0glAdK7c5VYshHEBoE5
         W5LjXgyshpchlVAuLw03Re0KHHEPvhra+3T5BoBcHnxNDMM69oTq1XiDceh8CMOw1ifT
         DnoQCNONCOZyZTkTno3duLiejzy/maGDp24n4k6hZrhHtQVDzyelZc+a2YAFc19OaKaQ
         cYxsuyUPx0vw9g82WPZCAlbsBigrDpVOw5BD3AKePGyIR67/G7slaxtVlIblfXIrgbXl
         vU3KyVQz2p46q0ppIu4OEETjZjnglH4TSsb1yvnTwFGkPBKgrD5V4Z5LolLR3+SZEKyf
         JtFA==
X-Gm-Message-State: AOAM533vgT2bv9F9oQRQNp5D51jvzWoCIuY+GTTY4Ruh0us+4z0INn3J
        6VLuxs5tap+5p4ESRmbOClw=
X-Google-Smtp-Source: ABdhPJyHyeXZ+uUGCw0gMpIlqjjffT+dvi62Suw1jrSBFF3VZEqbivUlNjZAqyX6XfY4bgsVNK6m/g==
X-Received: by 2002:a92:c7a9:: with SMTP id f9mr26182241ilk.255.1620759093805;
        Tue, 11 May 2021 11:51:33 -0700 (PDT)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id t10sm405096ils.36.2021.05.11.11.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 11:51:33 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     Jason Baron <jbaron@akamai.com>, Jessica Yu <jeyu@kernel.org>,
        "GitAuthor: Jim Cromie" <jim.cromie@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, kernel test robot <lkp@intel.com>
Subject: [RFC PATCH v5 13/28] dyndbg+module: expose ddebug_sites to modules
Date:   Tue, 11 May 2021 12:50:42 -0600
Message-Id: <20210511185057.3815777-14-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210511185057.3815777-1-jim.cromie@gmail.com>
References: <20210511185057.3815777-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Up until now, the "__dyndbg_sites" section was kinda dangling.

Unlike the "__dyndbg" section, it was not explicitly loaded by
module.c:load_info(); but it came along quietly, perhaps because of
the per .site initialization (by DEFINE_DYNAMIC_DEBUG_METADATA)
across the section boundary, or maybe because x86 is more permissive.
ISTM we need to treat "__dyndbg_sites" section just like "__dyndbg",
on basic principles.  (And maybe do this with commit that splits the
sections, if robot tests indicate problems between).

The changes to load_info propagated out to ddebug_add_module's
prototype, which needs to manage the 2nd section like the 1st.

RFC: Maybe the 2 sections/arrays should be a single item/tuple, but I
didn't see any real benefit to adding something; recapitulating the
previous pattern was straightforward.

-v5 fix !CONFIG_DYNAMIC_DEBUG fn-stub
Reported-by: kernel test robot <lkp@intel.com>

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h |  8 ++++----
 kernel/module-internal.h      |  1 +
 kernel/module.c               |  9 ++++++---
 lib/dynamic_debug.c           | 20 ++++++++++++--------
 4 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index bc4e778b755c..868e0769b72d 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -66,8 +66,8 @@ struct _ddebug {
 /* exported for module authors to exercise >control */
 int dynamic_debug_exec_queries(const char *query, const char *modname);
 
-int ddebug_add_module(struct _ddebug *tab, unsigned int n,
-				const char *modname);
+int ddebug_add_module(struct _ddebug *tab, struct _ddebug_site *sites,
+		      unsigned int numdbgs, const char *modname);
 extern int ddebug_remove_module(const char *mod_name);
 extern __printf(2, 3)
 void __dynamic_pr_debug(struct _ddebug *descriptor, const char *fmt, ...);
@@ -199,8 +199,8 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 #include <linux/errno.h>
 #include <linux/printk.h>
 
-static inline int ddebug_add_module(struct _ddebug *tab, unsigned int n,
-				    const char *modname)
+static inline int ddebug_add_module(struct _ddebug *tab, struct _ddebug_site *sites,
+				    unsigned int numdbgs, const char *modname)
 {
 	return 0;
 }
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
index 76315d20672a..1441b31915e7 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -49,6 +49,7 @@ struct ddebug_table {
 	const char *mod_name;
 	unsigned int num_ddebugs;
 	struct _ddebug *ddebugs;
+	struct _ddebug_site *sites;
 };
 
 struct ddebug_query {
@@ -1008,14 +1009,14 @@ static const struct proc_ops proc_fops = {
  * Allocate a new ddebug_table for the given module
  * and add it to the global list.
  */
-int ddebug_add_module(struct _ddebug *tab, unsigned int n,
-			     const char *name)
+int ddebug_add_module(struct _ddebug *tab, struct _ddebug_site *sites,
+		      unsigned int numdbgs, const char *modname)
 {
 	struct ddebug_table *dt;
 
 	dt = kzalloc(sizeof(*dt), GFP_KERNEL);
 	if (dt == NULL) {
-		pr_err("error adding module: %s\n", name);
+		pr_err("error adding module: %s\n", modname);
 		return -ENOMEM;
 	}
 	/*
@@ -1024,15 +1025,16 @@ int ddebug_add_module(struct _ddebug *tab, unsigned int n,
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
 
@@ -1172,7 +1174,9 @@ static int __init dynamic_debug_init(void)
 
 		if (strcmp(modname, site->modname)) {
 			modct++;
-			ret = ddebug_add_module(iter_mod_start, site_ct, modname);
+
+			ret = ddebug_add_module(iter_mod_start, site_mod_start,
+						site_ct, modname);
 			if (ret)
 				goto out_err;
 			site_ct = 0;
@@ -1182,7 +1186,7 @@ static int __init dynamic_debug_init(void)
 		}
 		site_ct++;
 	}
-	ret = ddebug_add_module(iter_mod_start, site_ct, modname);
+	ret = ddebug_add_module(iter_mod_start, site_mod_start, site_ct, modname);
 	if (ret)
 		goto out_err;
 
-- 
2.31.1

