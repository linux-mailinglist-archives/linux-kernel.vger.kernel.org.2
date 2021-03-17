Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7453E33EA3B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 07:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbhCQGzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 02:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbhCQGyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 02:54:25 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911EDC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 23:54:25 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id m7so20832906iow.7
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 23:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iItoyIdOVp9W+euE38EnFQywEn3bJCqdb2PBTcOxqJ8=;
        b=DIXMSfCzxpwS6th1XQlr+ytLFO/vHcGHE9NH6x7gpMcEliHIS2NQ2r9V0e3fudnN0c
         8vkCCKVNneDhoyqvz/9ExYqfvz+/kRq0dv6JPoXH06hZLHoOJqwVasg1W7dw6/TjCeLV
         e1v/0u4XnkA44l6QlEYK2zDIZN8BiHbYKZhXY6D4/woriIA3hdPyUWuoO5Ukg8Yufxmj
         nkUrPE6gCIFpG50trkNCm8QabJdyUodgvuuiKMLVk+xbAfDRuxd6UAVd8AySKoz7rWoJ
         W5GET5C5B8r19t1hcM+DvCprbRtCDk9Lsws3B21BEeyC3b22Y9ntL3oSuQasWI74lLvu
         4kQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iItoyIdOVp9W+euE38EnFQywEn3bJCqdb2PBTcOxqJ8=;
        b=CARJCly30q9ag3PoA/n1b1ls4r7uMcYJzagKmQwt1O7A+rLrDy+jzCOBjns7XX3bry
         AY4LAKwYB5PcckDTuX8GwP+JXFzWZixvO4Bg/oCHzk/UipqeyB7WTywD1Bj9A/HnaN+A
         O1iYig9lqUZCl5p5T45f+Ls3+fUgELp8mMpw6IBacRt85XHLZLTTLm2BGMYyVuT/0GtG
         ZcVRqDs0VeD6OZHkPzDZbKOItvo8Od9m0TPqPHKbRA9W781G0NkjhfSMynjXuh17a4KZ
         BSKn/6ImIHJf1m6iaXbDv8ZkzXgNSlrcFWM3MCL/dt4b4ACnWowKfzNm2dgJntlOf1Ie
         Xinw==
X-Gm-Message-State: AOAM531AqDUMtSiBFmHg7lw6yjeQcN8IxqZwbl9rDKjXbhP4PD0aK6LF
        qTN9AlFGc8/AT9hckdBYxSY=
X-Google-Smtp-Source: ABdhPJzrnKMuD/BgXp0CqVfFuWaDJbQMaa5sHnPqC665ovP6ls6RV0RxQfWISICbmbPJji5qTqVrog==
X-Received: by 2002:a6b:4f09:: with SMTP id d9mr5997283iob.60.1615964065075;
        Tue, 16 Mar 2021 23:54:25 -0700 (PDT)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id w13sm10583057ilg.48.2021.03.16.23.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 23:54:24 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v4 04/19] dyndbg: accept null site in ddebug_match_site
Date:   Wed, 17 Mar 2021 00:53:57 -0600
Message-Id: <20210317065412.2890414-5-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210317065412.2890414-1-jim.cromie@gmail.com>
References: <20210317065412.2890414-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

basically, reorder the elements to minimize data fetches.

1- move format and line-number check code to the top of the function,
   since they don't use/check site info.

2- test site pointer:
   If its null, we return early, skipping 3:
      If the query tests against missing site info, fail the match.
      otherwize site matches.

3- rest of function (checking site vs query) is unchanged.

ddebug_match_site ignores module, because it's tested already
by the caller, where it is known from debug_tables.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 41 +++++++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 9cff9db15937..da732e0c56e3 100644
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
2.29.2

