Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0AE33EA44
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 07:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbhCQGzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 02:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbhCQGyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 02:54:33 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CA5C061762
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 23:54:33 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id t18so509495iln.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 23:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t6LmNxQOq+SJXyguku9+rAZS3C4ziMBvNb56xqvs0B0=;
        b=YCfg5KX/6sbXwnmglQlxt/Co3/cRjxA1WLwlShDxX3MSYKWXHkQJXSCqtYrGGWXPuD
         6xmRb5eXx3iKsTj3+OGvhmivre6Sm5Yqb6P6P6JVsnMq6esoP3OHvxnGbFn5Kb9uO0U4
         7WD5BcwmVY5Ouf4cIwUCU5mISyBfShHLkCPpOS4SEkVi8fts1lkDlBykAgOdEzSqHyRa
         tF2/lXDPbwiiAu3BXy+5oZiE47w5Z89jT3Rjs2ZQrvm/IevoRghRHzlgl8eCPm+Za8se
         GxeB0yNwh9RQxVe5RwyDyFzXdYiCCVe/7syrusV6uHHI7O0OXPk7MzSTcs3ZBNCa0mKa
         /qOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t6LmNxQOq+SJXyguku9+rAZS3C4ziMBvNb56xqvs0B0=;
        b=fedNhDqj1yAmdU0ZuokrogWaj/SS9P2XD7B5Pk1FGva6vsUcYLpTcsAbTWZKLTRLPE
         DFsASTtZghXMwOI8fMzlzH34aG6nd1sPYe/YG82+lF7KFl5pZtkQ1Hc2oVEjNHbWVqER
         nlJ01i2fQaOy8mjBQAUfCRI6HrFvCetHmPonPYaVWiGavXBghkrOzebt+p+V+C7upGFF
         1k12FSdAp9+x0kHLSq3otlmlj4vi59dCo/4AM0uFOKabb9tGpkVQWAixY8wyzNcQULmO
         /i2TtT4vgH2Uh35QcllOvBqsUeHjOdWrVQPT6NKhcTXmv+onUZHpkqIGgKBGvyRtSQ2u
         L1CQ==
X-Gm-Message-State: AOAM53077Pgi7v1afEZutK9DEwxH5H8/W5G5Y/Gc0BsE/S8T/qOLitb5
        Xj5110ZiKa7AlxIJRfewawQ=
X-Google-Smtp-Source: ABdhPJyhBXwCZ3hcMshSBhbmxKa62zHanteFaPM6nroJzNAS8+fR1OrBvLFMLTbAlKq+8dDC9c0qGA==
X-Received: by 2002:a92:c6ca:: with SMTP id v10mr6692669ilm.195.1615964072892;
        Tue, 16 Mar 2021 23:54:32 -0700 (PDT)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id w13sm10583057ilg.48.2021.03.16.23.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 23:54:32 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v4 13/19] dyndbg+module: expose ddebug_sites to modules
Date:   Wed, 17 Mar 2021 00:54:06 -0600
Message-Id: <20210317065412.2890414-14-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210317065412.2890414-1-jim.cromie@gmail.com>
References: <20210317065412.2890414-1-jim.cromie@gmail.com>
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
 lib/dynamic_debug.c           | 20 ++++++++++++--------
 4 files changed, 21 insertions(+), 13 deletions(-)

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
index fdc2d0e15731..be2e97ae2da9 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -49,6 +49,7 @@ struct ddebug_table {
 	const char *mod_name;
 	unsigned int num_ddebugs;
 	struct _ddebug *ddebugs;
+	struct _ddebug_site *sites;
 };
 
 struct ddebug_query {
@@ -1014,14 +1015,14 @@ static const struct proc_ops proc_fops = {
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

