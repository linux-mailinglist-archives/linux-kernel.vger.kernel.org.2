Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB1137AEB9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 20:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbhEKSwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 14:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbhEKSwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 14:52:33 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42642C061574
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 11:51:26 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id k16so5078842ios.10
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 11:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D992vbjQHx6507pkKz07GBRojC3qb4kG7bKEZ05x9do=;
        b=HD/GXFSooFNbTEqtrlLNxCJxchPcIr385FVGf3X/Plk9rqXjc5RLPbR6I+C9c+dLpp
         6iHhy5WxZx6PXgVl34SoiJtxjfbmrF1R8AGe/sKGy2XmQUjX6q1el3pXa/mJ2RxHACkn
         QR95INsZUwonxFhJvv2M1bLRaNqNruGIfOP4ud3Mo5x/gNBMR0W46yi1xcl/F50vMeGZ
         xwOezAjBWuIMT8X6lhoUDrS1chsFHbfRslaZazA8uFp9XncLnU0fEAeC2zQJkSW18DKq
         f2twe6qNBOcA7QadZTNqASdKtvTqWz0tjd273L6CiVhdwsZqQYhB7B6/HBXmjDW6gsY0
         S9NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D992vbjQHx6507pkKz07GBRojC3qb4kG7bKEZ05x9do=;
        b=ViuNGYU8n8nYFgl6d+t39iSE1VA3cp8S7GbQpAHcNAaz9eQHRkdGFzNGfRCU5mX6iM
         8eyxMlOt5QAdiPDsG1nXrmX1W0bu470yKGrpL5n3Xkfp6Zl+cQVSA/V/UlCTkEZm0+LV
         bPcMrg7BmG+HctlSddznuMzhsnTEB8lm60/GpCzkoEqAB0e5Iruekqz1/SkCqVTKO+wG
         IVtXqKbQzzyCwRfyoJunfRagdlcpzWu2fseEhcaS4gVLkCa1vNUglF6El3d2R19K8Op6
         Adzzpry3YOXP3DRQmScX8x0Qe9qr8ag3NnKXAgJCN2yJDo1fEQ/Wj3DumEXL1g4iKIw/
         jo4Q==
X-Gm-Message-State: AOAM53156Wfl1HbIuZTBPE+sqNn54IRSEQtyjCWv9HFHsE/o9YmsGDLd
        EhIyEFa9ZbaTuZKPLrTlEN0=
X-Google-Smtp-Source: ABdhPJz+/HAjdG2DVizQ9q+xdlKi2ro3RWcx7IQiCkjgVWPiXePtmnS39w0/eb4eV3F1fIvjZKvh6A==
X-Received: by 2002:a05:6638:d15:: with SMTP id q21mr972818jaj.83.1620759085793;
        Tue, 11 May 2021 11:51:25 -0700 (PDT)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id t10sm405096ils.36.2021.05.11.11.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 11:51:25 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     Jason Baron <jbaron@akamai.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v5 06/28] dyndbg: accept null site in ddebug_match_site
Date:   Tue, 11 May 2021 12:50:35 -0600
Message-Id: <20210511185057.3815777-7-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210511185057.3815777-1-jim.cromie@gmail.com>
References: <20210511185057.3815777-1-jim.cromie@gmail.com>
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
index e6e2cb0180e5..47d427b82ae1 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -145,21 +145,7 @@ static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
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
@@ -181,6 +167,29 @@ static int ddebug_match_site(const struct ddebug_query *query,
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
 
@@ -210,7 +219,7 @@ static int ddebug_change(const struct ddebug_query *query,
 
 		for (i = 0; i < dt->num_ddebugs; i++) {
 			struct _ddebug *dp = &dt->ddebugs[i];
-			struct _ddebug_site *dc = dp->site;
+			struct _ddebug_site *dc;
 
 			if (!ddebug_match_site(query, dp))
 				continue;
-- 
2.31.1

