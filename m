Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B554C33CCEA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 06:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235220AbhCPFI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 01:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235175AbhCPFIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 01:08:23 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111EDC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 22:08:23 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id f10so11547025ilq.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 22:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QdQI/+lAb+gYcRJWejMVqh44KMAoB3pFOSAUQhYLugQ=;
        b=jtkvB2ltluYh1BosT97AZN1OmiWdWbz9UsrAiukNrr5OV5E0vdKZpCR+ceM047RpoP
         3WkA6pxQSsLD3tj7H6HBB3wqbTU5I2oDtrwrfz9elihXtn3LKbNr7bb+lD0wUu83Chi0
         wXS6XK3kt0dSmNXr2qsNtkUxzPWSSpW0+VU716B10hd6p1kOcw2Q6qGRutwYdbnzG343
         jW+SUb+SEnkVZ0bY3udgzBKL8eBtDgcnrfVFCB0bc3F2AWersEWfHrrTdVK3Br9j++8o
         psmNIwLb0vzvNd9ppbc8di/7S+d35AvZxl2TMI6pUT6PuydfwgCt2PGCV3W6Z1gUQy5y
         yv9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QdQI/+lAb+gYcRJWejMVqh44KMAoB3pFOSAUQhYLugQ=;
        b=eatMa6YTbz5vlJr/kEg1fIip+dp9t9tMRCkGHu0akfYLRjL9AbZRtJvAPFBwM8sRb7
         eE+ItEgEfPE+TiGxPIWHpG/JL9Ypq6nYJF27ZlVGARMdt/HZbPOmgvfpwoaHdHatClf/
         IbvxY120YZpZRdkvjXXKhS84K/tLgUSFBlkct7GoU6fRF7c7PgDIQABTzuOCPvZdIh31
         edir6WnJty0bxSRsmH0zR7Zv7+BquG5TdISQPG2HLr6eP8HtgnI65NlOIkc0beF2rWt/
         0BFv0dG2haMJeKkP5OJPVNsGQ+Rk/9ZXqGXIjPNg831iQDPJYFZKqCjGuahyPmZ+zxLP
         xI5A==
X-Gm-Message-State: AOAM530cKr4VPL4zL8/6VQHrNh8a7SSMkAXwhh/DzeNoWN1kJSWx1j4O
        CrEzd2tvvbprQ6mf2GnPjzs=
X-Google-Smtp-Source: ABdhPJyrypU6QZiKYhOJgZhxA/xhoaNAo2mDOHRemRFN4D8PeV1xEieyunIF4xnpNhEu6RUkj4UMnw==
X-Received: by 2002:a05:6e02:c7:: with SMTP id r7mr2352742ilq.288.1615871302522;
        Mon, 15 Mar 2021 22:08:22 -0700 (PDT)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id y9sm8587469ill.15.2021.03.15.22.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 22:08:22 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v3 03/18] dyndbg: refactor part of ddebug_change to ddebug_match_site
Date:   Mon, 15 Mar 2021 23:07:46 -0600
Message-Id: <20210316050801.2446401-4-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210316050801.2446401-1-jim.cromie@gmail.com>
References: <20210316050801.2446401-1-jim.cromie@gmail.com>
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
index c3c35dcc6a59..9cff9db15937 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -142,6 +142,48 @@ static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
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
@@ -170,38 +212,7 @@ static int ddebug_change(const struct ddebug_query *query,
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
2.29.2

