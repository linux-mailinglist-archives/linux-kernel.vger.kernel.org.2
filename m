Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 456CB394E04
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 22:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbhE2UEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 16:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbhE2UEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 16:04:00 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55376C06174A
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 13:02:22 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id c31-20020a056830349fb02903a5bfa6138bso49230otu.7
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 13:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5BWTKJqrrf/kNw/3F6fFg2m/DKJ7sDuPUp8KcuaUwDI=;
        b=sQZWCrwVmZmovix4zivtx3AdYm57/J+aeEvBMkwqnyp+865ReCVbVcVNjKsJqPCjoR
         4eh9tZkStPmxuZ82UrOfnFXx0X4fbnOdCrge8urNaeFdg52Zxd8TtgNeMXtli8NIIlYM
         yQXAIu1oOP/mtzZxwhlymGRtRQoQ1EzfDCR9rtAnJcylClPs4QIMv22Abb+WMt4s8G9E
         dKzfGzv28L2CuxI2z2vL+u8uC2o4MZgO/MLD40que/C5XR2Dfb9SZ9go/T6GCsEDy7O3
         y8Ao27GzhjAFmYg1ILSLqKAml3PQfClcf8tIuDTgOTjrBYYtbH0UI18gOR06ua92kciW
         oObA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5BWTKJqrrf/kNw/3F6fFg2m/DKJ7sDuPUp8KcuaUwDI=;
        b=VVjZcp6ASFbncNGlkVN94RGnKTgMxoVDInIWQUVW3nv9CN1hZb37HZy4Pkk48th8sN
         UdOrG+NS6TFOPHZlS0lWgA4L4pBtVIHesGnq2YfjxmTYvGLeRXf+jN+Y7UZre554/8Wg
         Q1V0qLqkhJWbMhiUNc4MNkpXZyKX36vtrCxAgIF4Ky1i62rfxc9eeelQXM6aEtSOcpKK
         OVjGzR9ZuSiLisdBfAjvuljad6m70O5JZtEC4xKbzdbG0vmcuixOX8hRgWQOcMDd8JTZ
         KYmkVy579MEEKJLiqve7OjHqDwWXI0+Nk1oqnwh7pstCZJ74pZr/IFHOqZG3nga7Y1x4
         DXyg==
X-Gm-Message-State: AOAM533ip9DJP6QD5408iSsKFdPfj60v99C4J/kP7foeeesVJpjwpzUb
        XcTT2XBrJSIirQuXd4FIeQk=
X-Google-Smtp-Source: ABdhPJw5aTifIxcZ+/H/kJmnLfbcLbWyD+es65hVPOkQNZ1qVxM19sRDDuFJ5W3p5tK/blSMfyRzaA==
X-Received: by 2002:a05:6830:2707:: with SMTP id j7mr1155137otu.171.1622318541716;
        Sat, 29 May 2021 13:02:21 -0700 (PDT)
Received: from frodo.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id t39sm1868064ooi.42.2021.05.29.13.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 13:02:21 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v6 08/34] dyndbg: accept null site in ddebug_match_site
Date:   Sat, 29 May 2021 14:00:03 -0600
Message-Id: <20210529200029.205306-9-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210529200029.205306-1-jim.cromie@gmail.com>
References: <20210529200029.205306-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since all query terms must be satisfied, we can reorder for clarity,
moving !!site dependent checks after those on _ddebug itself.

1- move format and line-number check code to the top of the function,
   since they don't use/check site info.

2- test site pointer:
   If its null, we return early, skipping 3:
      If the query tests against missing site info, fail the match.
      otherwize site matches.

3- rest of function (checking site vs query) is unchanged.

ddebug_match_site ignores module, because it's tested already
by the caller, where it is known from debug_tables.

no functional changes

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 41 +++++++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 839dd128ba20..d62dc471bc1f 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -146,21 +146,7 @@ static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
 static int ddebug_match_site(const struct ddebug_query *query,
 			     const struct _ddebug *dp)
 {
-	struct _ddebug_site *dc = dp->site;
-
-	/* match against the source filename */
-	if (query->filename &&
-	    !match_wildcard(query->filename, dc->filename) &&
-	    !match_wildcard(query->filename,
-			    kbasename(dc->filename)) &&
-	    !match_wildcard(query->filename,
-			    trim_prefix(dc->filename)))
-		return false;
-
-	/* match against the function */
-	if (query->function &&
-	    !match_wildcard(query->function, dc->function))
-		return false;
+	struct _ddebug_site *dc;
 
 	/* match against the format */
 	if (query->format) {
@@ -182,6 +168,29 @@ static int ddebug_match_site(const struct ddebug_query *query,
 	    dp->lineno > query->last_lineno)
 		return false;
 
+	dc = dp->site;
+	if (!dc) {
+		/* site info has been dropped, so query cannot test these fields */
+		if (query->filename || query->function)
+			return false;
+		else
+			return true;
+	}
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
 	return true;
 }
 
@@ -211,7 +220,7 @@ static int ddebug_change(const struct ddebug_query *query,
 
 		for (i = 0; i < dt->num_ddebugs; i++) {
 			struct _ddebug *dp = &dt->ddebugs[i];
-			struct _ddebug_site *dc = dp->site;
+			struct _ddebug_site *dc;
 
 			if (!ddebug_match_site(query, dp))
 				continue;
-- 
2.31.1

