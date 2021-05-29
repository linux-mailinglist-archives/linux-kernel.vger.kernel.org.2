Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02B81394E18
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 22:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbhE2UFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 16:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbhE2UEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 16:04:21 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16812C061574
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 13:02:44 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id a13so2554206oid.9
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 13:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lLcoqD8Z5LUtJpDq0UaiguZ2uVOHvR1wGoJHuDbPgRk=;
        b=uqkJwl/GwmWcX+OfQkIcr6Ul+myVVOXo6rTnEa5pNtlMo4bVKLk5iQbRl3NCaK2JpV
         aU25uQsjV1Luy6rOCfwKUtjU637Y0ZXLNfox5XG+Lkg9pfNRQem6lzCJv3Ckr9xedmSd
         SkocrAiGbG/LjZZcrPmjX/4kxeOF4kEzi+sP06ZlsVC2Ri6JcKbTb2iray53XeSWmtNZ
         gKccrhXFOHm5gWnfMTCRCSotlctOPSaFMDzXDIDkZi9oECg5CbFZ45UEeCuSseM6eUNi
         wq4VwIvV6prPJ0W4wnJrPzh1ufO9WT6p38sH0LOOE2JBGquWdJ0V0XXAe3GTjRSnDsez
         Jntw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lLcoqD8Z5LUtJpDq0UaiguZ2uVOHvR1wGoJHuDbPgRk=;
        b=EaKR1L5DkknMqMKM4XT+1fgoD0Lt/5JgiL27hYckwYmFMWByJ0i9nvfQOuGVMcK6ea
         KSFZS6quR+Z6w9rTaaBVUkZ3fgAZT0BnQveTyJ2C0qW4UM4PoYeaPwIthvQPw2fQbRHu
         Vtbl6jYicTUKDYEcc5RBRmK0WzQjBLMBuIL1ItvER+X1gR8KwZGDpwY+kLpxRc8X+drV
         SHsRmRlAI9MMr/rt97dcWaoMmf3dd//X1dWHMRYWquP1MKioYhlqGLKvndLIDVkW5z1O
         G6Lp+FR0vEhDkoURcMq7MqfmkkHfjmlMMtzSk2+kxxHXW5HgWgLwzI7iOK2k4nJ1Sl0M
         YRDQ==
X-Gm-Message-State: AOAM530wCtDzJXpnqe/G+ibCRs/34MqbRCtTw+f98dqACGWNOPJKnjmF
        3HSfiO3prJUm/tJSs0UWz5M=
X-Google-Smtp-Source: ABdhPJwUiVoezMoxm75j9yUT2015032ZPW7qmJhT/oIOPXytJ6ocxIQhK39SxOMlfLhc1+pDQleGmQ==
X-Received: by 2002:aca:3b07:: with SMTP id i7mr9910181oia.171.1622318563482;
        Sat, 29 May 2021 13:02:43 -0700 (PDT)
Received: from frodo.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id t39sm1868064ooi.42.2021.05.29.13.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 13:02:43 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v6 29/34] dyndbg: RFC drop _ddebug.site pointer
Date:   Sat, 29 May 2021 14:00:24 -0600
Message-Id: <20210529200029.205306-30-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210529200029.205306-1-jim.cromie@gmail.com>
References: <20210529200029.205306-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Flip the switch on #define SITE_CHK.  This finally removes the
_ddebug.site pointer, and almost all uses of it.  Due to this, the
.site cross-link done by DEFINE_DYNAMIC_DEBUG_METADATA() is lost to
the compiler, so suppress the resulting warnings by adding a "__used"
to the _ddebug_site records initialized there.

In .c, use the union header types introduced in ~HEAD~1,
with some casts sprinkled in.

This seems to work, but should be cleaner.  RFC

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h |  4 ++--
 lib/dynamic_debug.c           | 16 ++++++++--------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index c9c568a698a8..b2189ff94fda 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -6,7 +6,7 @@
 #include <linux/jump_label.h>
 #endif
 
-#define SITE_CHK /* include .site pointer and checks on it */
+// #define SITE_CHK /* include .site pointer and checks on it */
 
 #ifdef SITE_CHK
 #define SITE_CHK_(...)		__VA_ARGS__
@@ -135,7 +135,7 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 			 const char *fmt, ...);
 
 #define DEFINE_DYNAMIC_DEBUG_METADATA(name, fmt)		\
-	static struct _ddebug_site  __aligned(8)		\
+	static struct _ddebug_site  __aligned(8) __used		\
 	__section("__dyndbg_sites") name##_site = {		\
 		.modname = KBUILD_MODNAME,			\
 		.filename = __FILE__,				\
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index f2f6f2b20d01..0e2e082b487b 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -148,9 +148,11 @@ static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
 
 static struct _ddebug_site *ddebug_site_get(struct _ddebug *dp)
 {
-	struct _ddebug *dh = dp - (dp->_index);
+	union _ddebug_header *dh = (union _ddebug_header *) (dp - dp->_index);
+
+	if (!is_dyndbg_header_pair(dh, dh->site))
+		v3pr_info("get: header fail on %d-%d\n", dp->_index, dp->lineno);
 
-	BUG_ON(!is_dyndbg_header_pair(dh, dh->site));
 #ifdef SITE_CHK
 	if (dp >= __start___dyndbg && dp < __stop___dyndbg) {
 
@@ -178,7 +180,7 @@ static struct _ddebug_site *ddebug_site_get(struct _ddebug *dp)
 
 	return dp->site;
 #else
-	return &dh->site[dp->_index];
+	return (struct _ddebug_site *) &dh->site[dp->_index];
 #endif
 }
 static inline void ddebug_site_put(struct _ddebug *dp)
@@ -1070,16 +1072,14 @@ static int __ddebug_add_module(struct _ddebug *tab, struct _ddebug_site *sites,
 			       const char *modname)
 {
 	struct ddebug_table *dt;
+	union _ddebug_header *dh = (union _ddebug_header *) &tab[0];
 	int i;
 
 	v3pr_info("add-module: %s.%d sites\n", modname, numdbgs);
 
-	if (numdbgs && is_dyndbg_header_pair(tab, sites)) {
-
-		v3pr_info(" header: %d %s.%s.%d\n", tab[0]._index, modname,
-			  tab[0].site->function, tab[0].lineno);
+	if (numdbgs && is_dyndbg_header_pair(dh, sites)) {
 
-		SITE_CHK_(BUG_ON(tab[0].site != &sites[0]));
+		BUG_ON((void *) &dh->site[0] != (void *) &sites[0]);
 
 		if (numdbgs <= 1) {
 			v3pr_info(" skip header %s\n", modname);
-- 
2.31.1

