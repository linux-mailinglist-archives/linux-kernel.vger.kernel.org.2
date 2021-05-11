Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D962937AED2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 20:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbhEKSxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 14:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbhEKSxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 14:53:03 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1907EC061350
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 11:51:53 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id k16so5080037ios.10
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 11:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O0BJdtccf2yAr6b2uo1yZDvtVjzorNp/j0upe7RkRXg=;
        b=in7nJsUIXuQhI9wTQ88x1zOvaDu7RnqR0Q8idpyFRjxJGrqbIzbZtc1fRGAQ8tcJOb
         Z5YdMYEvZRsqoq0hSkVmr0YjYhyPXqgh/0tp3c/fPeYWiQcloama1HgWn83/bONGOJJX
         UwXIiLLRaUs54LNNBnqUFGiBzfT3YdXXDTtAR1K9WrkoE+y+C5XQc2VJ2IMPUv8kd1HZ
         oTMG0EXWQkg9DTT+NsV3+zu/OmyPkcMTrDfOyUin+sXG0vHwFwFsA/mwVHYkZe0rX4rV
         +9zh3b4H9ATeAllwC/8iT3Dg6siH2zXbAYuTaAWys1VocRPWUbgEIsBGEOVoXs0xiLnT
         4Zaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O0BJdtccf2yAr6b2uo1yZDvtVjzorNp/j0upe7RkRXg=;
        b=InUWDixuZi+n6Wz9TTWNpUaav3vaeaC+rixnVWLz3KjiD2oibJQNfEBjOWqdwhzx+n
         E7WZ+wXMcFLrRlg9IqnS0pIDUr0MFuT1at6tHUmMRklvXbgMGu2OrOUWa+FGD0ccw1mR
         hDsOD4Acbmok48NyANWKQF2M9HsLprOFk/zU43U3VJstEcyZzPo/UevdM0yfz7ltsYtx
         hfdwYwxUPHkWEzRF2yuUHU019VnzmV+rUdSKvxhC2lZqWsL4Cynes+Q01EbUjx1a6C83
         I9iNAg5GWhNRwg1ECOo4nXW/Ilx39ksy8bqzcXHXcD+Xo0WAsXXtJXTP+ctmipup7XOW
         yv7w==
X-Gm-Message-State: AOAM5331GIhSdUCyAzsttGVn335InrPn/tIhBX3/CZQGFPYhMFcNQdi2
        BfLS3vpV4WPIy5Z7QcRqDFc=
X-Google-Smtp-Source: ABdhPJz85XfrSMdeQNwF8K/Ub1WdvZ+s3Hf15DIDmS9kxaJYqeQ4vTjfWj1GV0Z3rzimZH5IsK5q3w==
X-Received: by 2002:a05:6602:2002:: with SMTP id y2mr8570269iod.70.1620759112554;
        Tue, 11 May 2021 11:51:52 -0700 (PDT)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id t10sm405096ils.36.2021.05.11.11.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 11:51:52 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     Jason Baron <jbaron@akamai.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v5 24/28] dyndbg: make site pointer and checks on it optional (not quite)
Date:   Tue, 11 May 2021 12:50:53 -0600
Message-Id: <20210511185057.3815777-25-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210511185057.3815777-1-jim.cromie@gmail.com>
References: <20210511185057.3815777-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wrap declaration and uses of _ddebug.site pointer in ifdefs.
Mostly, this eliminates all the WARN_ONs in ddebug_site_get(),
which seem to be mostly proven (they were BUG_ONs).

This adds macro indirection around ifdef SITE_CHK; adding SITE_INIT_
to adjust the .site initializations, and SITE_COND, which abstracts a
logic test used by is_dyndbg_header_pair(i,s).

TODO: breaks when !defined SITE_CHK - the header, being just a struct
_ddebug, also lost the .site member.  Need to specialize the header
struct, then unionize it back in.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 20 ++++++++++++++++----
 lib/dynamic_debug.c           | 13 ++++++++++---
 2 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 06ae1d8d8c10..46901b5348ee 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -6,6 +6,18 @@
 #include <linux/jump_label.h>
 #endif
 
+#define SITE_CHK /* include .site pointer and checks on it */
+
+#ifdef SITE_CHK
+#define SITE_CHK_(...)		__VA_ARGS__
+#define SITE_COND(_i, _s)	(_s == _i->site)
+#define SITE_INIT_(_name)	.site = &_name,
+#else
+#define SITE_CHK_(...)
+#define SITE_COND(_i, _s)	(true)
+#define SITE_INIT_(name)
+#endif
+
 /*
  * A pair of these structs are created in 2 special ELF sections
  * (__dyndbg, __dyndbg_sites) for every dynamic debug callsite.
@@ -25,7 +37,7 @@ struct _ddebug_site {
 } __aligned(8);
 
 struct _ddebug {
-	struct _ddebug_site *site;
+	SITE_CHK_(struct _ddebug_site *site;)
 	/* format is always needed, lineno shares word with flags */
 	const char *format;
 	const unsigned lineno:18;
@@ -106,7 +118,7 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 	};							\
 	static struct _ddebug  __aligned(8)			\
 	__section("__dyndbg") name = {				\
-		.site = &name##_site,				\
+		SITE_INIT_(name##_site)				\
 		.format = (fmt),				\
 		.lineno = __LINE__,				\
 		.flags = _DPRINTK_FLAGS_DEFAULT,		\
@@ -138,13 +150,13 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 	__weak struct _ddebug __used __aligned(8)		\
 		__section(".gnu.linkonce.dyndbg")		\
 	_LINKONCE_dyndbg_header = {				\
-		.site = &_LINKONCE_dyndbg_site_header,		\
+		SITE_INIT_(_LINKONCE_dyndbg_site_header)	\
 		.format = KBUILD_MODNAME			\
 	}
 
 /* The header initializations as a distinguishing predicate */
 #define is_dyndbg_header_pair(iter, sitep)			\
-	(sitep == iter->site					\
+	(SITE_COND(iter, sitep)					\
 	 && (!iter->lineno)					\
 	 && (iter->format == sitep->modname)			\
 	 && (sitep->modname == sitep->function)			\
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index b83187e72ee0..9551c0d406b6 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -151,7 +151,7 @@ static struct _ddebug_site *ddebug_site_get(struct _ddebug *dp)
 	struct _ddebug *dh = dp - (dp->_index);
 
 	WARN_ON(!is_dyndbg_header_pair(dh, dh->site));
-
+#ifdef SITE_CHK
 	if (dp >= __start___dyndbg && dp < __stop___dyndbg) {
 
 		v5pr_info("get: %s is builtin: %d %s:%s:%d\n",
@@ -177,6 +177,9 @@ static struct _ddebug_site *ddebug_site_get(struct _ddebug *dp)
 		WARN_ON(&dh->site[dp->_index] != dp->site);
 
 	return dp->site;
+#else
+	return &dh->site[dp->_index];
+#endif
 }
 static inline void ddebug_site_put(struct _ddebug *dp)
 {
@@ -241,6 +244,7 @@ static void ddebug_alter_site(struct _ddebug *dp,
 	} else if (modifiers->flags & _DPRINTK_FLAGS_PRINT)
 		static_branch_enable(&dp->key.dd_key_true);
 #endif
+#ifdef SITE_CHK
 	/* delete site info for this callsite */
 	if (modifiers->flags & _DPRINTK_FLAGS_DELETE_SITE) {
 		if (dp->site) {
@@ -249,6 +253,7 @@ static void ddebug_alter_site(struct _ddebug *dp,
 			dp->site = NULL;
 		}
 	}
+#endif
 }
 
 /*
@@ -1073,7 +1078,9 @@ static int __ddebug_add_module(struct _ddebug *tab, struct _ddebug_site *sites,
 
 		v3pr_info(" header: %d %s.%s.%d\n", tab[0]._index, modname,
 			  tab[0].site->function, tab[0].lineno);
-		WARN_ON(tab[0].site != &sites[0]);
+
+		SITE_CHK_(BUG_ON(tab[0].site != &sites[0]));
+
 		if (numdbgs <= 1) {
 			v3pr_info(" skip header %s\n", modname);
 			return 0;
@@ -1251,7 +1258,7 @@ static int __init dynamic_debug_init(void)
 
 	for (i = 0; iter < __stop___dyndbg; iter++, site++, i++) {
 
-		WARN_ON(site != iter->site);
+		SITE_CHK_(WARN_ON(site != iter->site));
 
 		if (strcmp(modname, site->modname)) {
 			modct++;
-- 
2.31.1

