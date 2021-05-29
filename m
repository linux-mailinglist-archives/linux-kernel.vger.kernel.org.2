Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5967394E02
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 22:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbhE2UEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 16:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbhE2UD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 16:03:58 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73BF3C061574
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 13:02:20 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso6976271otu.10
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 13:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j/valDv1AwMQ/fCkZ53yMD4oG/s7fubFLEVjzGaQwgg=;
        b=WRE2pQYNJSlxK4pDtSByl+Pd9/8FRBkgpva9IGfWgalJRLl1xECMo3YJ8ek8ue+v++
         RthSDv+8zaCQ3w23OOtVZ7TZEGG6yO0+bYTA/RM6Aropp22OBvAqVuVFENqBgsLK0RKn
         TlAHi9FWQDcYEpkyRYbhfw9JBoEGt/xyKrLni4MOxDABvlm/khBidYkU7hQtfpgRta+B
         IQOfxcAEZjI6HS6Yuqv9SVre3snZNiQJx+JATAepPyekN5TcWpzrRvqEJfYfRVqizk/u
         cUkoe5gRxp7FnL1szuoc9eFhSIqHGlBKhedTAIBeESsQoRczu6R2JHm23rKYO39Yk5MJ
         +pwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j/valDv1AwMQ/fCkZ53yMD4oG/s7fubFLEVjzGaQwgg=;
        b=GGXY/XJ8uxtmaiC+Vpr/5hy922Qhk8Lp8ehdaT9wPy3tbYgd5dI6REHoKslBHtn3sW
         NXVjxRKGeaxA3Y6NLPO8w9LIwgP6DzdWqehhSda8Da8Y/kzCnPopYgzT2lw543U5A7h/
         hv+Su1hXuNlPzeuTblMRLrC+R6GgrErz/iTTEvbgfkjZJfch4v1jUPAr1/PE6K00PGJw
         44ksaecfYDyRYl+/vCRXV0OcWaU5egmtGg1icXh8MDyTZ0ihg7dyHiL4RFZ5tO00hozg
         1TJmckL9OI9StvxWSQrLX2wTJYHnskESIQDIDxeOLyEwIV49KXjK77uiiQuEc+wpRpAM
         4I2A==
X-Gm-Message-State: AOAM530LBJcq0xEXgRVOnuEtaY6TKk6PiidHp1e2VdVX+Wuk9NpzZKaV
        LJKsWh/3Adnwk6nJxSgOzJrbVdFGUxoeJA==
X-Google-Smtp-Source: ABdhPJw3S9dUtsujStx07yTXZ1LlXKBBFhBeX4L+gYf6ZvPxu/R/p7ZIabwrebu9WA66sBnzHud0Uw==
X-Received: by 2002:a9d:554b:: with SMTP id h11mr11581446oti.4.1622318539812;
        Sat, 29 May 2021 13:02:19 -0700 (PDT)
Received: from frodo.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id t39sm1868064ooi.42.2021.05.29.13.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 13:02:19 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [RFC PATCH v6 06/34] dyndbg+module: expose ddebug_sites to modules
Date:   Sat, 29 May 2021 14:00:01 -0600
Message-Id: <20210529200029.205306-7-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210529200029.205306-1-jim.cromie@gmail.com>
References: <20210529200029.205306-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Up until now, the "__dyndbg_sites" section was kinda dangling.

Unlike the "__dyndbgs" section, it was not explicitly loaded by
module.c:load_info(); but it came along quietly, perhaps because of
the per .site initialization (by DEFINE_DYNAMIC_DEBUG_METADATA) across
the section boundary.  ISTM we need to treat "__dyndbg_sites" section
just like "__dyndbg", on basic principles.

Doing so starts in module.c:load_info(), which attaches "__dyndbgs"
section, and now does "__dyndbg_sites" too.  These changes propagated
out to ddebug_add_module's prototype, which needs to pass the 2nd
section like the 1st.

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
index 130d5b36e08e..40ea086853ff 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -65,8 +65,8 @@ struct _ddebug {
 /* exported for module authors to exercise >control */
 int dynamic_debug_exec_queries(const char *query, const char *modname);
 
-int ddebug_add_module(struct _ddebug *tab, unsigned int n,
-				const char *modname);
+int ddebug_add_module(struct _ddebug *tab, struct _ddebug_site *sites,
+		      unsigned int numdbgs, const char *modname);
 extern int ddebug_remove_module(const char *mod_name);
 extern __printf(2, 3)
 void __dynamic_pr_debug(struct _ddebug *descriptor, const char *fmt, ...);
@@ -198,8 +198,8 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
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
index 592e71f9f99d..c4f8c0b5cf07 100644
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
 
 	info->debug = section_objs(info, "__dyndbgs",
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
index f7ece35bc722..78d4a9020600 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -49,6 +49,7 @@ struct ddebug_table {
 	const char *mod_name;
 	unsigned int num_ddebugs;
 	struct _ddebug *ddebugs;
+	struct _ddebug_site *sites;
 };
 
 struct ddebug_query {
@@ -953,14 +954,14 @@ static const struct proc_ops proc_fops = {
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
@@ -969,15 +970,16 @@ int ddebug_add_module(struct _ddebug *tab, unsigned int n,
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
 
@@ -1117,7 +1119,9 @@ static int __init dynamic_debug_init(void)
 
 		if (strcmp(modname, site->modname)) {
 			modct++;
-			ret = ddebug_add_module(iter_mod_start, site_ct, modname);
+
+			ret = ddebug_add_module(iter_mod_start, site_mod_start,
+						site_ct, modname);
 			if (ret)
 				goto out_err;
 			site_ct = 0;
@@ -1127,7 +1131,7 @@ static int __init dynamic_debug_init(void)
 		}
 		site_ct++;
 	}
-	ret = ddebug_add_module(iter_mod_start, site_ct, modname);
+	ret = ddebug_add_module(iter_mod_start, site_mod_start, site_ct, modname);
 	if (ret)
 		goto out_err;
 
-- 
2.31.1

