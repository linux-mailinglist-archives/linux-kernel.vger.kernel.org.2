Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44B67394E01
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 22:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbhE2UEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 16:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbhE2UD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 16:03:58 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7CDC06174A
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 13:02:21 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id u25-20020a0568302319b02902ac3d54c25eso7006856ote.1
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 13:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LQuVxRAcjK8t/Sazz0aajGG1OlfHP3rRgE9A+ESecds=;
        b=NY61Xmp3mEWcjAoc4o4oX2i5B2pZjMfZkyVBRN9PaA+RryaZbwjo6NHTk7dpsyoRHp
         b33vfvng039quAsJwtyw815nVWGGmMHakMU1Tla6ylL0YA0vvCGwKbDPLUlCJRKdjVhm
         KYzpPVlG6kTZceNI00KYs5NFtMQ4i1/BgJ+YvE0SGsI7r8j1NrGLXevNlZhBNVd40WQl
         PThG4yNsV9VmawcqEJA+18q937FJkM/69r938nXlhZKX7fugHHxLigX+ewVURLXGgIG+
         8ApTnLzpwMUdGN0/JcEAQ+uRi83b1Eejv94gWDYTeTg1PzKiv1ElkgfYHfzwIOV5koYN
         Jd4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LQuVxRAcjK8t/Sazz0aajGG1OlfHP3rRgE9A+ESecds=;
        b=gBMbbld2UysWGP/EdI8+y2K/lI9L4Xg/54h69Ikw32uwXptyRjaYKJVHXh3cCfY09R
         rKcrXoP5Ef+EM7sn8Smr7kpmw15IODrPtgnwcfSG+2ovGjc8v7All87N0re6QSiKKkcX
         ZjC0ixffOt7ZY1GmEnRZ3XoMwhQGQ01f39WgJKs+pCUm9UxR4NR4phG8ng6ZvbrRyUNq
         VFUSBjOXdFrVKG3t/g3ZlVB1gq3me+reGrb5cciEj/vcmGzk9V3yawhdUE8V5jgHTkX1
         y3zZzCLGoDIC/YvAsL3L62GMF3lYkro62LgeIjXr55brAab5IAfXHiKqJW5c68EScC31
         JZOg==
X-Gm-Message-State: AOAM5330CcZGZNjheSbJgpkaPVfn7TXbHrGGxWH08tNE85zr2WJakrAc
        NFMjYBXTx4K28QTh+cabO7s=
X-Google-Smtp-Source: ABdhPJwhsh/nALZT64owHsZWHab5VRHuhFM/PwwlAE1uPyfYArtl8i58OyR5y2flcwM4qFpcJ7Y8QQ==
X-Received: by 2002:a9d:6655:: with SMTP id q21mr11771536otm.185.1622318540699;
        Sat, 29 May 2021 13:02:20 -0700 (PDT)
Received: from frodo.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id t39sm1868064ooi.42.2021.05.29.13.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 13:02:20 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v6 07/34] dyndbg: refactor part of ddebug_change to ddebug_match_site
Date:   Sat, 29 May 2021 14:00:02 -0600
Message-Id: <20210529200029.205306-8-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210529200029.205306-1-jim.cromie@gmail.com>
References: <20210529200029.205306-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move all the site-match logic into a separate function, reindent the
code, and replace the continues with return falses.

No functional changes.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 75 ++++++++++++++++++++++++++-------------------
 1 file changed, 43 insertions(+), 32 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 78d4a9020600..839dd128ba20 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -143,6 +143,48 @@ static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
 		 query->first_lineno, query->last_lineno);
 }
 
+static int ddebug_match_site(const struct ddebug_query *query,
+			     const struct _ddebug *dp)
+{
+	struct _ddebug_site *dc = dp->site;
+
+	/* match against the source filename */
+	if (query->filename &&
+	    !match_wildcard(query->filename, dc->filename) &&
+	    !match_wildcard(query->filename,
+			    kbasename(dc->filename)) &&
+	    !match_wildcard(query->filename,
+			    trim_prefix(dc->filename)))
+		return false;
+
+	/* match against the function */
+	if (query->function &&
+	    !match_wildcard(query->function, dc->function))
+		return false;
+
+	/* match against the format */
+	if (query->format) {
+		if (*query->format == '^') {
+			char *p;
+			/* anchored search. match must be at beginning */
+			p = strstr(dp->format, query->format+1);
+			if (p != dp->format)
+				return false;
+		} else if (!strstr(dp->format, query->format))
+			return false;
+	}
+
+	/* match against the line number range */
+	if (query->first_lineno &&
+	    dp->lineno < query->first_lineno)
+		return false;
+	if (query->last_lineno &&
+	    dp->lineno > query->last_lineno)
+		return false;
+
+	return true;
+}
+
 /*
  * Search the tables for _ddebug's which match the given `query' and
  * apply the `flags' and `mask' to them.  Returns number of matching
@@ -171,38 +213,7 @@ static int ddebug_change(const struct ddebug_query *query,
 			struct _ddebug *dp = &dt->ddebugs[i];
 			struct _ddebug_site *dc = dp->site;
 
-			/* match against the source filename */
-			if (query->filename &&
-			    !match_wildcard(query->filename, dc->filename) &&
-			    !match_wildcard(query->filename,
-					   kbasename(dc->filename)) &&
-			    !match_wildcard(query->filename,
-					   trim_prefix(dc->filename)))
-				continue;
-
-			/* match against the function */
-			if (query->function &&
-			    !match_wildcard(query->function, dc->function))
-				continue;
-
-			/* match against the format */
-			if (query->format) {
-				if (*query->format == '^') {
-					char *p;
-					/* anchored search. match must be at beginning */
-					p = strstr(dp->format, query->format+1);
-					if (p != dp->format)
-						continue;
-				} else if (!strstr(dp->format, query->format))
-					continue;
-			}
-
-			/* match against the line number range */
-			if (query->first_lineno &&
-			    dp->lineno < query->first_lineno)
-				continue;
-			if (query->last_lineno &&
-			    dp->lineno > query->last_lineno)
+			if (!ddebug_match_site(query, dp))
 				continue;
 
 			nfound++;
-- 
2.31.1

