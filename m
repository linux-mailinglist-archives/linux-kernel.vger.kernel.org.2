Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 725E7394E0C
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 22:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbhE2UEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 16:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbhE2UEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 16:04:09 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD72C061761
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 13:02:31 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id u25-20020a0568302319b02902ac3d54c25eso7007135ote.1
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 13:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IrgGhlFUqp240MhiRoMTnNhWE1HeM9Fjs61p8hN67HA=;
        b=IXNs8WbBhqg0cs48BxCo/St6Nmq2dreSNK1YLNwSiG/HoXp+wa5vBRPl4MDZT7JlWL
         drpss69ezhcEWGx1zvj4tPr+CUT4tNHekxIdoLwZqtZNg9SY2nse2YEPnDQMEcJPt/ey
         JrqHnXglnimvyc/Yvh1ZxMm2lPgQwIg/z8NriZJ5itdTCQtXT8YmUgAgw0T0ie3nbB0M
         T0ZpZnGquD8T7lSG3Z1ihW69vQrasXTBvVUi5MbE/QgVf2AfsyvMqOiotK0gIkOZZsSy
         ULKDOacHsCS9dPorm+s3rZ/j2YHP2ZXqBggvgF+1e+2QxV0fucPviQf1/hvV3OpDU18v
         1Pxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IrgGhlFUqp240MhiRoMTnNhWE1HeM9Fjs61p8hN67HA=;
        b=F2KFvceuqkeW8zXbFZWcq8nTyMDrR6go/+dv3ot9nUvzoXJaTEXV4ytdiS2NJUg6Yw
         MdG/YDhYGVQGbMfizWo6Y2RZ8w1SsUWlyr/cEq/PR+yqgwk8ivD0uaWNLtheMduZq7mm
         xgVp80iFuJS6yne41I/j4S5vTMnkZJ+UOUyvSlFlS4KdNTusIQeWjeIBM77vsMb2aRCR
         JVcSiwUyKDE91b4fvzbfCuQxedrjfBjYoGNHoNRAcTODYl8mkf2KP6osByOPlIRIFVsR
         Z+Uyj8i7skqenslCq+5PQKyflLLPC/H0AdlJnsYgOuKkOk2YmGkfGVCrEPbSe+bXh5bz
         VY8Q==
X-Gm-Message-State: AOAM532W8dsbrKo+F4vuKc/wc+Pjm6I9VB5PFZB2SjEmhEbUHPqRHHBP
        HSZOkbOdYEZsl2DKZJRdc4Q=
X-Google-Smtp-Source: ABdhPJwNElEs2xajEtKDZP1ZXD2aR6SkLQAgs/5xwWZ4KQe7uHLZ+QtT9cU0sLumbe4ZhU20NXNiJg==
X-Received: by 2002:a9d:7a99:: with SMTP id l25mr11634164otn.97.1622318551133;
        Sat, 29 May 2021 13:02:31 -0700 (PDT)
Received: from frodo.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id t39sm1868064ooi.42.2021.05.29.13.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 13:02:30 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v6 17/34] dyndbg: add _index to struct _ddebug
Date:   Sat, 29 May 2021 14:00:12 -0600
Message-Id: <20210529200029.205306-18-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210529200029.205306-1-jim.cromie@gmail.com>
References: <20210529200029.205306-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

we have: dp->site doing mapping: &__dyndbgs[N] -> &__dyndbg_sites[N].

We want to drop site, and do an indirect "up-over-down" maneuver (or
"back-over-and-map") to access sites[N]; this new _ddebug._index field
is that "N" above.  This is a debug/unlikely path, so access cost is
unimportant compared to memory savings.

Once we can go from any N to 0, we have &array, and can use it in
container_of(), along with array-member name, to get the containing
struct (which doesnt exist yet).

The ._index is free, from unused padding in struct _ddebug (at least
on 64 bit machines).  This commit just adds the ._index member, and
initializes it.  That job falls to ddebug_add_module(). 2 cases:

loadable modules: ddebug_add_module( &whole-elf-section )
builtin modules:  ddebug_add_module( &slice-of-DATA ), iteratively.

Previously, it didnt care which slice of "__dyndbgs" it was working,
but now we need to know the origin of the allocated memory, to
initialize our way back to it.  Simplest way is to pass in the base
index of the current slice.

Since ddebug_add_module() is used indirectly by module.c, the new arg
is hidden in __ddebug_add_module(), and defaults to 0 in the wrapper.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h |  2 ++
 lib/dynamic_debug.c           | 25 ++++++++++++++++++++-----
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index f789608ab935..c866b4a9760a 100644
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
@@ -52,6 +53,7 @@ struct _ddebug {
 #define _DPRINTK_FLAGS_DEFAULT 0
 #endif
 	unsigned int flags:8;
+
 #ifdef CONFIG_JUMP_LABEL
 	union {
 		struct static_key_true dd_key_true;
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index db7563a88d8a..ce134c939f01 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1028,10 +1028,12 @@ static const struct proc_ops proc_fops = {
  * Allocate a new ddebug_table for the given module
  * and add it to the global list.
  */
-int ddebug_add_module(struct _ddebug *tab, struct _ddebug_site *sites,
-		      unsigned int numdbgs, const char *modname)
+static int __ddebug_add_module(struct _ddebug *tab, struct _ddebug_site *sites,
+			       unsigned int numdbgs, unsigned int base,
+			       const char *modname)
 {
 	struct ddebug_table *dt;
+	int i;
 
 	v3pr_info("add-module: %s.%d sites\n", modname, numdbgs);
 	if (!numdbgs) {
@@ -1055,6 +1057,12 @@ int ddebug_add_module(struct _ddebug *tab, struct _ddebug_site *sites,
 	dt->ddebugs = tab;
 	dt->sites = sites;
 
+	for (i = 0; i < numdbgs; i++) {
+		tab[i]._index = base + i;
+		v3pr_info(" %d %d %s.%s.%d\n", i, tab[i]._index,
+			  modname, sites[i].function, tab[i].lineno);
+	}
+
 	mutex_lock(&ddebug_lock);
 	list_add(&dt->link, &ddebug_tables);
 	mutex_unlock(&ddebug_lock);
@@ -1063,6 +1071,12 @@ int ddebug_add_module(struct _ddebug *tab, struct _ddebug_site *sites,
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
@@ -1177,6 +1191,7 @@ static int __init dynamic_debug_init(void)
 	char *cmdline;
 	int ret = 0;
 	int site_ct = 0, entries = 0, modct = 0;
+	int mod_index = 0;
 
 	if (&__start___dyndbg == &__stop___dyndbg) {
 		if (IS_ENABLED(CONFIG_DYNAMIC_DEBUG)) {
@@ -1200,8 +1215,8 @@ static int __init dynamic_debug_init(void)
 		if (strcmp(modname, site->modname)) {
 			modct++;
 
-			ret = ddebug_add_module(iter_mod_start, site_mod_start,
-						site_ct, modname);
+			ret = __ddebug_add_module(iter_mod_start, site_mod_start,
+						  site_ct, mod_index, modname);
 			if (ret)
 				goto out_err;
 			site_ct = 0;
@@ -1211,7 +1226,7 @@ static int __init dynamic_debug_init(void)
 		}
 		site_ct++;
 	}
-	ret = ddebug_add_module(iter_mod_start, site_mod_start, site_ct, modname);
+	ret = __ddebug_add_module(iter_mod_start, site_mod_start, site_ct, mod_index, modname);
 	if (ret)
 		goto out_err;
 
-- 
2.31.1

