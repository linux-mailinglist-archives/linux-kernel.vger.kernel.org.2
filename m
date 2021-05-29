Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFDD6394E14
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 22:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbhE2UFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 16:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbhE2UEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 16:04:16 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC71C061761
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 13:02:39 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso6976812otu.10
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 13:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VKKVMCv2jAg8uEHJ5eOSKr+B81KfeT2WIsvHoST3JFU=;
        b=qzbAGR+C84EpetUXBtitcxyZ2uS5OzJyu7R+0TF6/yi/7uOG8D3AUja+v1D0x/Sc9o
         G9/zGOw2iiBi4m8A0eLkrYkIQf0RomQHmS28UZHHW7Vn1uPabS+fFMaX2DV6aTNLi3j7
         70ZoioXlf5HUToaaPwtJOq2yAXpZGF2tAKpBAWjsQVyiimYeulpXDtpRi7Bw8Vuz8fAC
         s0V/8rXm3whJ/FCoEh4lGlWdzrIKZCVN0PSKe/CzMNszqU4npnc6MsfCHufQy6qv86CD
         mOqWIIMMbUFAoT6M4YQ68OE5AHUOEudB8ZHBCrX07Fnpb4rqRExVnhVyo5solgdQp2Hi
         VfXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VKKVMCv2jAg8uEHJ5eOSKr+B81KfeT2WIsvHoST3JFU=;
        b=OLFU2N6XuoI7kRZsmhLi9MVYIoReiGgpJJz8X88XmCMg0P+gJT3nKKs0u1TfLypuTZ
         8bBdGGuIZqTlqh3q8zFkPzBNVBIIZDxiNRhykgaJvkMzO2eEWnjSc6WgOzR233jnLm6F
         gtp2gL2jdA59V/bA4pe9L0ZkPD5xu6rH5PBG9PtTUGXvvF9wZTJTdVNsPkgSWRmyXZRt
         AtLPZPwUynTVHucx3sBS9IjCUls99K6peKpREkv+Zj+O4C+hg4yW02bvBACRde27ZmTS
         WbUj68xR4y5jo9wTjWPk6AnW+es04BRmlsH5jF2xDb7o7hueOpi7fZouj4S2QaupWHYz
         +sGg==
X-Gm-Message-State: AOAM532f1mnuB89PkU/r8iWPNbkJn4WskTrjrTb7W3TCGsa+fbEs3K8g
        ed7eFjiYFaXCcFPLFAYWEO0=
X-Google-Smtp-Source: ABdhPJwPRrKaLakKwFUcFvXyQe0bCXXOXUcPawrI9x43q6Iek17o1GKQQJXTN5lLKfrrd6VaUvMQ0g==
X-Received: by 2002:a9d:7987:: with SMTP id h7mr11516963otm.70.1622318559242;
        Sat, 29 May 2021 13:02:39 -0700 (PDT)
Received: from frodo.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id t39sm1868064ooi.42.2021.05.29.13.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 13:02:38 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v6 25/34] dyndbg: make site pointer and checks on it optional (almost)
Date:   Sat, 29 May 2021 14:00:20 -0600
Message-Id: <20210529200029.205306-26-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210529200029.205306-1-jim.cromie@gmail.com>
References: <20210529200029.205306-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hide declaration and uses of _ddebug.site pointer in SITE_* macros,
defined alternately for SITE_CHK true/undefined.

Mostly, this eliminates all the WARN_ONs in ddebug_site_get(),
which seem to be mostly proven (they were BUG_ONs).

NOTE:

This breaks when !defined SITE_CHK - the header, being just a struct
_ddebug, also loses the .site member.  Need to specialize the header
struct to keep it, then unionize it back into the sites vector.

In DEFINE_DYNAMIC_DEBUG_TABLE, we keep the raw initialization;
we want this init when specialization & unionization is finished.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 18 +++++++++++++++---
 lib/dynamic_debug.c           | 13 ++++++++++---
 2 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index a99973221f94..7acd4c88411d 100644
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
 	__section("__dyndbgs") name = {				\
-		.site = &name##_site,				\
+		SITE_INIT_(name##_site)				\
 		.format = (fmt),				\
 		.lineno = __LINE__,				\
 		.flags = _DPRINTK_FLAGS_DEFAULT,		\
@@ -144,7 +156,7 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 
 /* The header initializations as a distinguishing predicate */
 #define is_dyndbg_header_pair(iter, sitep)			\
-	(sitep == iter->site					\
+	(SITE_COND(iter, sitep)					\
 	 && (!iter->lineno)					\
 	 && (iter->format == sitep->modname)			\
 	 && (sitep->modname == sitep->function)			\
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 9a089b8d2ccd..f333fcb6cf1f 100644
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

