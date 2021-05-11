Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A84B537AED0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 20:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbhEKSxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 14:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232228AbhEKSxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 14:53:01 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329E2C06134B
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 11:51:50 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id o21so18778463iow.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 11:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rRjPVWmA3B6C3BJqW3B7XKo1gt0YfFP4dH6JiUaATHk=;
        b=PxeRlSJXRM39kgpoN6KeFxTZQAnoUhXeu+nclS/M+2kxRYVMqnKV0q8mPVXhZsy5vg
         Yh5sYX9MBGW2y9AcFZ1bjKw0Bs/7nwpSP8BAgVB0s/YKybhdHVLjCmQj+uVzTw2E8gSA
         /GwV9kAgYQQmSAG+DHbj9PSZbx273IZBKQ8+WG1K3d1YXJdJNytgE5kvae5mzsALEye8
         JKZseRGPK1ajmwV/iBiUZ/uF9J3xUpjr9wkJRgYmuw2LQGuN0zCQXZhnr4Tnmh81BNZR
         mam5/awoKWy/ovmIvCTSJk5OUHvJ2dVKAkjd4ZmIythBwqosCB89Z8+mXi5quEVICiiX
         3GYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rRjPVWmA3B6C3BJqW3B7XKo1gt0YfFP4dH6JiUaATHk=;
        b=iXt64bQaR4YUdtSUvRjQVBqQGjU8nOBc6PdsDgxqWShAAXGdOVPBEcfTwO8EBQJP+N
         A93caSeeEg6HOm9Ynluq+n6ybKnJB9eZXzLqrst/x6nacOQopVj3Qb3dUUMQIE4yyva2
         b5/t2ntlnGjSZ6C/J8LLG4wrgCcJClKl8AM8LXHpMZrsvUHFrGRobNogz0/y6OKl5Pon
         pL+c7JhwVvK1+NzzThLrC69Aai8nWxAedAuE+YZqFMsPWhW/PH0wezwXRkGUU9DlyOaa
         OlMHNyEZvZSf+OnYXj90VB+tG63FF1GvRGe8JtsM1WBygRiLbDZQK3VLfIDGFWN+HJiR
         unNQ==
X-Gm-Message-State: AOAM531xyJmIp4MeI8iXVg6VYObqQrQlQD3IQYNmWPSDHeqlfv/oksnS
        Mhhm26P6Cj6AIKHhBC/NRtZ/ag9vIJjJtxNv
X-Google-Smtp-Source: ABdhPJyYx+0zjnNjAY7ZVIA6NDghAsc2PTRQ2e1Uh8OdgjONUFgEIByJt6OJJDrVBkkKQIx3aU/Cug==
X-Received: by 2002:a02:ac05:: with SMTP id a5mr28620682jao.89.1620759109684;
        Tue, 11 May 2021 11:51:49 -0700 (PDT)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id t10sm405096ils.36.2021.05.11.11.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 11:51:49 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     Jason Baron <jbaron@akamai.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v5 21/28] dyndbg: validate ddebug_site_get invariants
Date:   Tue, 11 May 2021 12:50:50 -0600
Message-Id: <20210511185057.3815777-22-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210511185057.3815777-1-jim.cromie@gmail.com>
References: <20210511185057.3815777-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds several BUG_ONs to assert all the invariants needed
to support the reliance on the "back-N-to-header-overto-site-out-N"
use of the 2 __dyndbg* vectors (with their included headers).

RFC: I don't think we want this permanently; BUG_ON/panic seems kinda
overkill, but its useful to know if it survives lkp auto-testing.

- dp is (struct _ddebug*) to the callsite, passed in.
- dh is (struct _ddebug*) to the header. derived from dp & _index.
  known by BUG_ON(!is_dyndbg_header(dh))
  this is the "up-N-to-header" from dp.
- dh has good site pointer, to __dyndbg_sites[]
  by BUG_ON(!is_dyndbg_header_pair())

There are 2 main cases to validate: builtin and loadable modules.

For loadable modules, we will depend upon the headers presence, and
its site pointer to the vector of _ddebug_sites[], expressed as:

  BUG_ON(&dh->site[dp->_index] != dp->site);

Builtin pr-debugs have the additional property:

  !!(&__start___dyndbg <= dp < __stop___dyndbg),

We could use this property directly to return site, but since builtin
modules also have a header record, we can use that instead.  So the
1st BUG_ON is hoisted out of the !builtin branch, and asserted just
before return.  Also hoist dh derivation, making it a declaration +
initialization + BUG_ON instead.

NB: grep -- '->site' will confirm that site is now used just for
BUG_ON assertions, so we are close to the drop.

NEXT

To drop site pointer from struct _ddebug, we need:

- recast header as a different struct, unionized with _ddebug.
- preserve site pointer there.
- drop from struct _ddebug.
- fix and fold back any fallout from size reduction.

OR defer that, and proceed with compressing __dyndbg_sites[], then
replacing ddebug_site_get's guts (with all the BUG_ONs) with a
decompress and _index.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 462d364fc788..af9791258f8f 100644
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
@@ -146,7 +148,34 @@ static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
 
 static struct _ddebug_site *ddebug_site_get(struct _ddebug *dp)
 {
-	return dp->site; /* passthru abstraction */
+	struct _ddebug *dh = dp - (dp->_index);
+
+	WARN_ON(!is_dyndbg_header_pair(dh, dh->site));
+
+	if (dp >= __start___dyndbg && dp < __stop___dyndbg) {
+
+		v5pr_info("get: %s is builtin: %d %d %s:%s:%d\n",
+			  dp->site->modname, dp->_index, (int)(dp - dh),
+			  dh->site[dp->_index].filename,
+			  dh->site[dp->_index].function, dp->lineno);
+
+		WARN_ON(dp != &__start___dyndbg[dp->_index]);
+
+		WARN_ON(!(dp->_index == (dp - dh) &&
+			 dp->_index == (dp - __start___dyndbg) &&
+			 dp->_index == (&__start___dyndbg_sites[dp->_index]
+					- &__start___dyndbg_sites[0])));
+
+		WARN_ON(&__start___dyndbg_sites[dp->_index] != dp->site);
+	} else {
+		v4pr_info("get: %s is loaded: %d %s:%s:%d\n",
+			  dp->site->modname, dp->_index,
+			  dh->site[dp->_index].filename,
+			  dh->site[dp->_index].function, dp->lineno);
+	}
+	WARN_ON(&dh->site[dp->_index] != dp->site);
+
+	return dp->site;
 }
 static inline void ddebug_site_put(struct _ddebug *dp)
 {
-- 
2.31.1

