Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2117737AEBA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 20:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbhEKSwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 14:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbhEKSwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 14:52:33 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5BDC06175F
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 11:51:25 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id k16so5078801ios.10
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 11:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=edbAM8pNMWrl0Zd/ZLYzgEM9CPxsCooD0s2Yg5J4Xik=;
        b=o/q+Qpd8wiM+S8VNNw4FvN68R7MMHEnj/9Ar6ooVy951E9qwyvXpjNdNe6zHpoINlX
         z8jVJttCTZID7um6zsJ+n0OW+nJopY7tyGHK+MLvHPu7q8vs7bNAF9Xv69u8nkotqCCb
         C5N+zUy/fNd2GMp+AWXgAiG1lfMWCZUDMUlxZhbqTzS7FQV89yLDLqCKs2WUPFBVGGNA
         6e8JJv/VAIZO5s67UhGLW6bX0jtoFgp9toRKUtIycKrgDuG/I/XFJUC5EcJflkB7IDNv
         Jmy0id6oXOLXFxubtjCqMj8S7j0iioSSRecsnuA3GUjAadfl84PbZdJuNSBr7FfJ3Ddf
         0PtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=edbAM8pNMWrl0Zd/ZLYzgEM9CPxsCooD0s2Yg5J4Xik=;
        b=PXiQIiH5g7opCXHvRkFiN7f1RmvVr0c5Yt8YYhmQuculyUrIR2dNVnnlDLBbq5+efD
         7ma81oNIOaBRKJfHWns0nCcv+QcKsgeT3zcim7RXZsQ9Dq6IRhvgIQj9nLUhexOvlSLO
         D1HzlpCR5fIexc1W8FRR09rSovodayKioQP+Z/0RkPtH/zCAjZyvIHCm26zvd7pL3b1r
         mpZfUHYqPTEOPb8wzviO83ihh4SoYuO/sxWRSHnEq8iYOVAaMvmIOc+Gh3N2CCcOFdVz
         h+5DPHrk6V7kQ86dfq9icXLOsaMlO+RQ1VnezPQEOFPP8knIk9GepJ2l3ck6WnqoYdrt
         ZVJw==
X-Gm-Message-State: AOAM530/ikOpRd4FNmYE5iCFVE/0tr7qt5hVqXFBH634fvBJ9LVpL5jd
        +Ek8uWCmde+ELLZuQQHULFw=
X-Google-Smtp-Source: ABdhPJy/LBlcvLqRCMyyl1Jzgkwgsb71H5OvnqlkY4P+e1/3kWWKv5zaTdow/4t+NTf857Bnd4iIaQ==
X-Received: by 2002:a02:54c1:: with SMTP id t184mr19223588jaa.79.1620759084933;
        Tue, 11 May 2021 11:51:24 -0700 (PDT)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id t10sm405096ils.36.2021.05.11.11.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 11:51:24 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     Jason Baron <jbaron@akamai.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v5 05/28] dyndbg: refactor part of ddebug_change to ddebug_match_site
Date:   Tue, 11 May 2021 12:50:34 -0600
Message-Id: <20210511185057.3815777-6-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210511185057.3815777-1-jim.cromie@gmail.com>
References: <20210511185057.3815777-1-jim.cromie@gmail.com>
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
index 5a33143215a4..e6e2cb0180e5 100644
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
2.31.1

