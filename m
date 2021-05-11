Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A88E237AED7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 20:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbhEKSx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 14:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232296AbhEKSxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 14:53:05 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84D6C061346
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 11:51:56 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id j12so18079564ils.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 11:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w/MStH6rleojLv6FsPubLujifVnUutNTi0UTvEWgL70=;
        b=n0w1LLoKmwiskrevRxDlHMcMz0ItQvFgP4Mm/+gUC3Hp2n1gu9Wu8t1tjnP2fFWVdF
         MCf/6W3GMlxHEjyKcSIeRZqJGegNFHbpGto8pZz8nrjz8BSQt6E2Ndv1wiQfIvz5SDN4
         C0tuwP/5MfQ4mkeailcv+3URknXWfvSTiXqz1962+ABfNbpXUMJiH6o9B3+E7t3FM1n+
         wlEoObEB5kWpLDoyBKGnByn6Aw4Ui9eoBwWwqY4HRrrlroXY0PKfVQYHcScf7ExTPOVf
         GE2BaTLnwq6vJwG7/NS9Ule3fb1rqoIw23Ki3j6GFKDU/xsAEuWixpSZJ6jnlNAHJv30
         jmDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w/MStH6rleojLv6FsPubLujifVnUutNTi0UTvEWgL70=;
        b=nOlrJm/W5YaTHFH+6RJ8g3cw0Zg+nU/BP7OR9goA7xqI+WBdnZPuc8vZ4u6ikhsYcs
         CAAeJaqqo+bHFuZBx+N2DPR5Leh7018ZQoAQU5k+VoLn0yC7E70K3mnGT8S4KVdcdMVa
         7R7Q7XPpjCc84u6DKfHLZGsgVNbc7YN7kQdyj67MdzHgDEzdKkcv+i5n+n51NjZzP9AB
         4+9UFDPyVdb97wV1ETJSCldweVxt+ubodNU1PBMlM2gc2IZiRDpRNnYIwd7UirtuMciw
         JHIxBOvJCXN1G13OPGSC9MWD77AAraxRQQzEsbt7u1gebRzEPNxnD42t/1WEaEdPcLQ/
         yP4g==
X-Gm-Message-State: AOAM531f8COc0dEYsfYL+u2uTgsQvGAXP14mNZPO5DytL+2A/5kOdgEr
        spCSvSBwrZQ3aiddS1dxFkP5krKrMcUFmT5e
X-Google-Smtp-Source: ABdhPJxZIho9S9YRnlHrZ1rQU5B1tlKuVPPKUeHaGibAuu93uqCrmR1pZxVkYnI/ke59YOgpp2ttqA==
X-Received: by 2002:a92:c846:: with SMTP id b6mr23449530ilq.68.1620759116365;
        Tue, 11 May 2021 11:51:56 -0700 (PDT)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id t10sm405096ils.36.2021.05.11.11.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 11:51:56 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     Jason Baron <jbaron@akamai.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v5 28/28] dyndbg: RFC drop _ddebug.site pointer
Date:   Tue, 11 May 2021 12:50:57 -0600
Message-Id: <20210511185057.3815777-29-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210511185057.3815777-1-jim.cromie@gmail.com>
References: <20210511185057.3815777-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In .h, flip the switch on #define SITE_CHK.  This finally removes the
_ddebug.site pointer, and all uses of it.  Due to this, the .site
cross-link done by DEFINE_DYNAMIC_DEBUG_METADATA() is lost to the
compiler, so suppress the resulting warnings by adding a "__used" to
the _ddebug_site records initialized there.

In .c, fix a bunch of fallout:
- mostly casts from struct to/from union
- convert a BUG_ON to a WARN,
  it happens ~20x per `cat control`, probably headers on loaded modules
- fixup missing _ddebug_header.site,
  bad initialization of some sort.

This seems to work, but should be cleaner.  RFC

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h |  4 ++--
 lib/dynamic_debug.c           | 25 +++++++++++++++++--------
 2 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 9ca413985fb2..7f2b255a25ae 100644
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
index aa4a476d70ad..db759c998c54 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -148,9 +148,12 @@ static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
 
 static struct _ddebug_site *ddebug_site_get(struct _ddebug *dp)
 {
-	struct _ddebug *dh = dp - (dp->_index);
+	union _ddebug_header *dh = (union _ddebug_header *) (dp - dp->_index);
+
+	if (!is_dyndbg_header_pair(dh, dh->site)) {
+		v3pr_info("get: header fail\n");
+	}
 
-	BUG_ON(!is_dyndbg_header_pair(dh, dh->site));
 #ifdef SITE_CHK
 	if (dp >= __start___dyndbg && dp < __stop___dyndbg) {
 
@@ -178,7 +181,7 @@ static struct _ddebug_site *ddebug_site_get(struct _ddebug *dp)
 
 	return dp->site;
 #else
-	return &dh->site[dp->_index];
+	return (struct _ddebug_site *) &dh->site[dp->_index];
 #endif
 }
 static inline void ddebug_site_put(struct _ddebug *dp)
@@ -1070,17 +1073,23 @@ static int __ddebug_add_module(struct _ddebug *tab, struct _ddebug_site *sites,
 			       const char *modname)
 {
 	struct ddebug_table *dt;
+	union _ddebug_header *dh = (union _ddebug_header *) &tab[0];
 	int i;
 
 	v3pr_info("add-module: %s.%d sites\n", modname, numdbgs);
 
-	if (numdbgs && is_dyndbg_header_pair(tab, sites)) {
+	if (numdbgs && is_dyndbg_header_pair(dh, sites)) {
 
-		v3pr_info(" header: %d %s.%s.%d\n", tab[0]._index, modname,
-			  tab[0].site->function, tab[0].lineno);
+		v3pr_info(" header: %d %s.\n", dh->_index, modname);
 
-		SITE_CHK_(BUG_ON(tab[0].site != &sites[0]));
+		SITE_CHK_(BUG_ON(dh->site[0] != &sites[0]));
 
+		/* for !SITE_CHK, need to set site ptr, fixup missed init! */
+		if (!dh->site) {
+			dh->site = (union _ddebug_site_header *) sites;
+			v3pr_info(" header: %d %s.%s.%d\n", dh->_index, modname,
+				  dh->site->function, dh->lineno);
+		}
 		if (numdbgs <= 1) {
 			v3pr_info(" skip header %s\n", modname);
 			return 0;
@@ -1110,7 +1119,7 @@ static int __ddebug_add_module(struct _ddebug *tab, struct _ddebug_site *sites,
 	for (i = 0; i < numdbgs; i++, base++) {
 		tab[i]._index = base;
 		v3pr_info(" %d %d %s.%s.%d\n", i, base, modname,
-			  tab[i].site->function, tab[i].lineno);
+			  sites[i].function, tab[i].lineno);
 	}
 
 	mutex_lock(&ddebug_lock);
-- 
2.31.1

