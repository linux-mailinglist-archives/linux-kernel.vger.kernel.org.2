Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEF2394E19
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 22:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbhE2UFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 16:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbhE2UEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 16:04:22 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D90C06138D
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 13:02:45 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id c31-20020a056830349fb02903a5bfa6138bso49856otu.7
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 13:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sK/P+4H0sYY14z3pIJRgwy4xGuY7WGwxwaq9XeGY66I=;
        b=ryvc0voSh9tbmE8HYLdq4XnqpptC4rfl+7ItUgzFHFQE//YP54pubBhoSRCUHW7htP
         Y4SqZokidIOjHwAkIYoVPu7T/YzKiV+jw/mC658fDEWksVxfnlB6aVHMEOMTz5AAn1Qn
         kps80V/BuOr/1uFf8c2tQzwqjSbYuxkBObxDO/oVMaq68/3/fp5BLCaBGdKiyWn7NKSV
         KAhPwV64g8tGXXTFYj3ZKczYrLtFrWf85rtwM72YLxImErU8pZY5jd0w+1InwXaRzfPu
         /l3BYkFofkRecY1bPh+scPb/L5tffi6MyaCcuCupGB5an+1+bHjQBhC0Z6gVR6M3YS9U
         mf4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sK/P+4H0sYY14z3pIJRgwy4xGuY7WGwxwaq9XeGY66I=;
        b=XqLqVUyXDadBcccN2nF1rEU2FuZIHgYNoMlaWn7S5lk/Qud0wMh4Bg4b1EbA/P75RV
         /C7pxwzBcaQGK4tIteD0j5xPVPgCuJRoquHmsjI4SrPBQYjd8pb57Se7otc8v7RuSshO
         Lno6uOvkxsIfAQO1uUM0n3fM2vNXLxJempqGLXjMYHe/K1aKHc5yOtMxncrHqs3otm4C
         100eUC+NE/lGJ7YrIWlzBLp5/8hE56ciVz//PPUr7VzCUVT7wmMO+PQiMe8KhKilHekH
         RzIhjItyJ6eeB4uiPDOdTWiQQNqUJ+W9/NdDFh591P/tWfvnRQJbw+fLkBI8csEDcTPD
         6F+Q==
X-Gm-Message-State: AOAM5325gMbTPwG94lQEEUHUW+J565qRG1ZtJ49URL1Sklsnq3UFmw6A
        mBC4SC1Tj8ALZpUjT52RJqA=
X-Google-Smtp-Source: ABdhPJwL89IT5cH4ECsCFNccOLoWTSVjV4WxW0HnS/dke9vQz1ArSszonUM6zUyEzq4KLoPYXfyu2g==
X-Received: by 2002:a05:6830:2707:: with SMTP id j7mr1156180otu.171.1622318564385;
        Sat, 29 May 2021 13:02:44 -0700 (PDT)
Received: from frodo.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id t39sm1868064ooi.42.2021.05.29.13.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 13:02:44 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v6 30/34] dyndbg: split/copy ._index into 2 new fields: ._back, ._map
Date:   Sat, 29 May 2021 14:00:25 -0600
Message-Id: <20210529200029.205306-31-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210529200029.205306-1-jim.cromie@gmail.com>
References: <20210529200029.205306-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to do:
  __dyndbgs[-N].site->__dyndbg_sites[N]

._index had 2 jobs:
  provide index back to __dyndbgs[0]
  provide index out to __dyndbg_sites[N]

So rename ._index to ._back & ._map, adjust ddebug_add_module()
to init both fields identically, and replace other ._index's
with the "correct" replacement.

NOTES:

._map is a better name better than ._out.  Since ._map is a
separate field, it can map arbitrarily.  It now maps ddebugs->sites
1->1, but it can/will-soon map N->1; all a function's pr_debugs
will share a single _ddebug_site, and we can reclaim redundant rows.

The "correct" choice of ._map/._back cannot be tested properly now,
since ._map == ._back.  Once N->1 is done, we can re-define SITE_CHK
and validate (or correct) the ._map/._back choices made here.

No functional changes.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h |  6 ++++--
 lib/dynamic_debug.c           | 35 ++++++++++++++++++-----------------
 2 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index b2189ff94fda..fe70dda704d2 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -51,7 +51,8 @@ struct _ddebug {
 	/* format is always needed, lineno shares word with flags */
 	const char *format;
 	const unsigned lineno:18;
-	unsigned _index:14;
+	unsigned _back:14;
+	unsigned _map:14;
 	/*
 	 * The flags field controls the behaviour at the callsite.
 	 * The bits here are changed dynamically when the user
@@ -95,7 +96,8 @@ union _ddebug_header {
 		union _ddebug_site_header *site;
 		const char *format;
 		const unsigned lineno:18;
-		unsigned _index:14;
+		unsigned _back:14;
+		unsigned _map:14;
 		unsigned int flags:8;
 	};
 };
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 0e2e082b487b..524303a04462 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -148,39 +148,39 @@ static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
 
 static struct _ddebug_site *ddebug_site_get(struct _ddebug *dp)
 {
-	union _ddebug_header *dh = (union _ddebug_header *) (dp - dp->_index);
+	union _ddebug_header *dh = (union _ddebug_header *) (dp - dp->_back);
 
 	if (!is_dyndbg_header_pair(dh, dh->site))
-		v3pr_info("get: header fail on %d-%d\n", dp->_index, dp->lineno);
+		v3pr_info("get: header fail on %d-%d\n", dp->_back, dp->lineno);
 
 #ifdef SITE_CHK
 	if (dp >= __start___dyndbg && dp < __stop___dyndbg) {
 
 		v5pr_info("get: %s is builtin: %d %s:%s:%d\n",
-			  dh->site[dp->_index].modname, dp->_index,
-			  dh->site[dp->_index].filename,
-			  dh->site[dp->_index].function, dp->lineno);
+			  dh->site[dp->_map].modname, dp->_back,
+			  dh->site[dp->_map].filename,
+			  dh->site[dp->_map].function, dp->lineno);
 
-		BUG_ON(dp != &__start___dyndbg[dp->_index]);
+		BUG_ON(dp != &__start___dyndbg[dp->_back]);
 
-		BUG_ON(!(dp->_index == (dp - dh) &&
-			 dp->_index == (dp - __start___dyndbg) &&
-			 dp->_index == (&__start___dyndbg_sites[dp->_index]
+		BUG_ON(!(dp->_back == (dp - dh) &&
+			 dp->_back == (dp - __start___dyndbg) &&
+			 dp->_back == (&__start___dyndbg_sites[dp->_back]
 					- &__start___dyndbg_sites[0])));
 		if (dp->site)
-			BUG_ON(&__start___dyndbg_sites[dp->_index] != dp->site);
+			BUG_ON(&__start___dyndbg_sites[dp->_map] != dp->site);
 	} else {
 		v4pr_info("get: %s is loaded: %d %s:%s:%d\n",
-			  dh->site[dp->_index].modname, dp->_index,
-			  dh->site[dp->_index].filename,
-			  dh->site[dp->_index].function, dp->lineno);
+			  dh->site[dp->_map].modname, dp->_back,
+			  dh->site[dp->_map].filename,
+			  dh->site[dp->_map].function, dp->lineno);
 	}
 	if (dp->site)
-		BUG_ON(&dh->site[dp->_index] != dp->site);
+		BUG_ON(&dh->site[dp->_map] != dp->site);
 
 	return dp->site;
 #else
-	return (struct _ddebug_site *) &dh->site[dp->_index];
+	return (struct _ddebug_site *) &dh->site[dp->_map];
 #endif
 }
 static inline void ddebug_site_put(struct _ddebug *dp)
@@ -1108,8 +1108,9 @@ static int __ddebug_add_module(struct _ddebug *tab, struct _ddebug_site *sites,
 	dt->sites = sites;
 
 	for (i = 0; i < numdbgs; i++) {
-		tab[i]._index = base + i;
-		v3pr_info(" %d %d %s.%s.%d\n", i, tab[i]._index,
+		tab[i]._back = base + i;
+		tab[i]._map = base + i;
+		v3pr_info(" %d %d %d %s.%s.%d\n", i, tab[i]._back, tab[i]._map,
 			  modname, sites[i].function, tab[i].lineno);
 	}
 
-- 
2.31.1

