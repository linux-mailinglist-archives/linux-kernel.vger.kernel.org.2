Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBF9D33CCF6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 06:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235326AbhCPFJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 01:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235200AbhCPFId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 01:08:33 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB07C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 22:08:33 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id z13so35840940iox.8
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 22:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I/AcfK1gNxzWvvwxEnx/CUNZBEUaTKpUsiDlaZQJDTs=;
        b=enmSuejNpIDDdgtKmfI1+50mrZSqTniMTwZQ1X4+IfBZmwYfBBpBs459YmLrKhFjID
         63yvnu4e+YxlEk924cbWmur6Z+eQAunWI/CQxHb+KPMXf1LdWrBIuAXlAp4uOpIttrtg
         wBq20DKQUbsSsyRx6pzMVNZrqO2ObANYckUbbocCb7KBf3Y6jtBftS1izVITdUlkEVr7
         y0D7Py15vHIW5S+h0R667XOo8LahGHrgKtQZoTiwuannbGEFnnJYVbk7e/svo1e5Yql3
         idpv0BMvzy76kTfg309+n+dSwKtQVBlVfb92bJdJyozu3aN5vymOA+/2RA1WeugX9dIu
         Sd6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I/AcfK1gNxzWvvwxEnx/CUNZBEUaTKpUsiDlaZQJDTs=;
        b=smGjLt79nrmUxYqVhg8rIO70TZaYRziWfvTnx0PrP6kvpcdROVHacDLPawxg8Py1gx
         8wcZFHCPjd/ApnAS558erbaeCLeafAJzjHTNRsllqn19UX5UEgqE+eh7V1CcMgCdKeKd
         28QQfbRase8jshJNiyAfPCZgVf9ertYm+Gn6efuV/myVgNjkF7N9Rp0D8mcpjno3rNt3
         Bni9Y2rB0YDvfOfwmMJ362sd1GJbpLL5EVeHIhDZpA9xk007/PbzBCWV8MY0xgEbulXG
         k0fOAR9XQ8wYckrZ6AUfBayluQda60Lmxi42a0/NFRg1oBR12jfppXy0Ak80cG7PnHVI
         Bk6Q==
X-Gm-Message-State: AOAM533mqDW9wEBZSt1QqSJOCdhK4Sf+Qf0TvAUedFBckmbTQC8ai1rL
        0RpdhugAqUuidpqKSE7QGas=
X-Google-Smtp-Source: ABdhPJxXt30s9sJb2iFfnQ2Ce9Yel/qjpmqmdZQvzOFIM2hZ28poHLdZnCn21KlGDXn9WeS4BvErjw==
X-Received: by 2002:a6b:4411:: with SMTP id r17mr2053331ioa.64.1615871313239;
        Mon, 15 Mar 2021 22:08:33 -0700 (PDT)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id y9sm8587469ill.15.2021.03.15.22.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 22:08:32 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v3 15/18] dyndbg: add _index to struct _ddebug
Date:   Mon, 15 Mar 2021 23:07:58 -0600
Message-Id: <20210316050801.2446401-16-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210316050801.2446401-1-jim.cromie@gmail.com>
References: <20210316050801.2446401-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We currently use dp->site to map: &__dyndbg[N] -> &__dyndbg_sites[N].
We want to drop site, new _ddebug._index provides the N.

The mapping is done in ddebug_site_get():

For builtin modules, a _ddebug *ptr is between __start___dyndbg and
__stop___dyndbg, and we can use &__start___dyndbg_sites[N] directly.
For loadable modules, we still need work, so we print rubbish, and
just return site pointer (which is correct).

ddebug_add_module() handles _index initialization:
Its new task is to number each module consecutively, so it gets new
base arg to pass the next starting index.

To actually drop site, We need both the module's __dyndbg* section
addys, and we need their relative placement to have a base-to-base
offset.

PLAN - a table header connecting 2 tables.

- ddebug_table points to both __dyndbgs & __dyndbg_sites.
  but *ddebugs & *sites are independent.
  no path from ddebugs[n] -> ddebug_sites[n]

If we have a header record in-situ, which keeps the site pointer we
seek to eliminate from _ddebug, and its in element[0] of both vectors,
we can go:

  ddebugs[n] -> ddebugs[0] -> containerof -> site[n]

  union ddebug_table_header {
  	struct ddebug_table *owner;
	struct _ddebug item;
  }
  and
  struct ddebug_table_vector {
  	 struct ddebug_table *owner;
	 struct _ddebug vector[];
  }

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h |  2 ++
 lib/dynamic_debug.c           | 43 +++++++++++++++++++++++++++++------
 2 files changed, 38 insertions(+), 7 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 7d33475d226a..18689db0e2c0 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -29,6 +29,7 @@ struct _ddebug {
 	/* format is always needed, lineno shares word with flags */
 	const char *format;
 	const unsigned lineno:18;
+	unsigned _index:14;
 	/*
 	 * The flags field controls the behaviour at the callsite.
 	 * The bits here are changed dynamically when the user
@@ -56,6 +57,7 @@ struct _ddebug {
 #define _DPRINTK_FLAGS_DEFAULT 0
 #endif
 	unsigned int flags:8;
+
 #ifdef CONFIG_JUMP_LABEL
 	union {
 		struct static_key_true dd_key_true;
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 34329e323ed5..3b53035d63d6 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -123,6 +123,8 @@ do {								\
 #define vpr_info(fmt, ...)	vnpr_info(1, fmt, ##__VA_ARGS__)
 #define v2pr_info(fmt, ...)	vnpr_info(2, fmt, ##__VA_ARGS__)
 #define v3pr_info(fmt, ...)	vnpr_info(3, fmt, ##__VA_ARGS__)
+#define v4pr_info(fmt, ...)	vnpr_info(4, fmt, ##__VA_ARGS__)
+#define v5pr_info(fmt, ...)	vnpr_info(5, fmt, ##__VA_ARGS__)
 
 static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
 {
@@ -146,7 +148,17 @@ static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
 
 static struct _ddebug_site *ddebug_site_get(struct _ddebug *dp)
 {
-	return dp->site; /* passthru abstraction */
+	v4pr_info("get %d: %s.%s.%d\n", dp->_index, dp->site->modname,
+		  dp->site->function, dp->lineno);
+
+	if (dp >= __start___dyndbg && dp < __stop___dyndbg) {
+		v4pr_info(" is builtin: %d %ld\n", dp->_index, dp - __start___dyndbg);
+		return &__start___dyndbg_sites[ dp - __start___dyndbg ];
+	} else {
+		v3pr_info(" is loaded: %d %ld\n", dp->_index, dp - __start___dyndbg);
+		return dp->site;
+	}
+	return dp->site;
 }
 static inline void ddebug_site_put(struct _ddebug *dp)
 {
@@ -1034,14 +1046,16 @@ static const struct proc_ops proc_fops = {
  * Allocate a new ddebug_table for the given module
  * and add it to the global list.
  */
-int ddebug_add_module(struct _ddebug *tab, struct _ddebug_site *sites,
-		      unsigned int numdbgs, const char *modname)
+static int __ddebug_add_module(struct _ddebug *tab, struct _ddebug_site *sites,
+			       unsigned numdbgs, unsigned base,
+			       const char *modname)
 {
 	struct ddebug_table *dt;
+	int i;
 
 	dt = kzalloc(sizeof(*dt), GFP_KERNEL);
 	if (dt == NULL) {
-		pr_err("error adding module: %s\n", name);
+		pr_err("error adding module: %s\n", modname);
 		return -ENOMEM;
 	}
 	/*
@@ -1055,6 +1069,13 @@ int ddebug_add_module(struct _ddebug *tab, struct _ddebug_site *sites,
 	dt->ddebugs = tab;
 	dt->sites = sites;
 
+	v3pr_info("add-module: %s\n", modname);
+	for (i = 0; i < numdbgs; i++) {
+		tab[i]._index = base++;
+		v3pr_info(" %d %d %s.%s.%d\n", i, tab[i]._index, modname,
+			  tab[i].site->function, tab[i].lineno);
+	}
+
 	mutex_lock(&ddebug_lock);
 	list_add(&dt->link, &ddebug_tables);
 	mutex_unlock(&ddebug_lock);
@@ -1063,6 +1084,12 @@ int ddebug_add_module(struct _ddebug *tab, struct _ddebug_site *sites,
 	return 0;
 }
 
+int ddebug_add_module(struct _ddebug *tab, struct _ddebug_site *sites,
+		      unsigned int numdbgs, const char *modname)
+{
+	return __ddebug_add_module(tab, sites, numdbgs, 0, modname);
+}
+
 /* helper for ddebug_dyndbg_(boot|module)_param_cb */
 static int ddebug_dyndbg_param_cb(char *param, char *val,
 				const char *modname, int on_err)
@@ -1177,6 +1204,7 @@ static int __init dynamic_debug_init(void)
 	char *cmdline;
 	int ret = 0;
 	int site_ct = 0, entries = 0, modct = 0;
+	int mod_index = 0;
 
 	if (&__start___dyndbg == &__stop___dyndbg) {
 		if (IS_ENABLED(CONFIG_DYNAMIC_DEBUG)) {
@@ -1200,8 +1228,8 @@ static int __init dynamic_debug_init(void)
 		if (strcmp(modname, site->modname)) {
 			modct++;
 
-			ret = ddebug_add_module(iter_mod_start, site_mod_start,
-						site_ct, modname);
+			ret = __ddebug_add_module(iter_mod_start, site_mod_start,
+						  site_ct, mod_index, modname);
 			if (ret)
 				goto out_err;
 			site_ct = 0;
@@ -1210,8 +1238,9 @@ static int __init dynamic_debug_init(void)
 			site_mod_start = site;
 		}
 		site_ct++;
+		iter->_index = index++;
 	}
-	ret = ddebug_add_module(iter_mod_start, site_mod_start, site_ct, modname);
+	ret = __ddebug_add_module(iter_mod_start, site_mod_start, site_ct, mod_index, modname);
 	if (ret)
 		goto out_err;
 
-- 
2.29.2

