Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF3633CCEB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 06:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235232AbhCPFI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 01:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233744AbhCPFIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 01:08:24 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297A9C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 22:08:24 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id z13so35840706iox.8
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 22:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iItoyIdOVp9W+euE38EnFQywEn3bJCqdb2PBTcOxqJ8=;
        b=osWOgUznVy730G7dB3WogaazuGmjR/CL5F4t5k/lCshSyVbcZsOH/6Gr3ocPFaYg5m
         18druAxdZA9OchjsNq8TKrZfFm0EUyslksXNZ8BKxl0VN8dsH8JMV47pSw1LCN5yccru
         toAJ24zbOaZg0QmAzU+Yqt+6pk5Q4eXTdHJlPQvJNSX8L6KoWz+TiAuUaEoRG8J3u62A
         hAZlWm/l8+DEagilpR77FNVRpfybn6HeDnsfWzCQrwFM2b1LN5SePFIWQjy2tkuITETg
         2O9Gv4+XZh2UpFyuJpYva1CqAfCA22pWy8KqFfcbKWdi0QS5CWRkJiKuHiTxbqPM7TBq
         A+lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iItoyIdOVp9W+euE38EnFQywEn3bJCqdb2PBTcOxqJ8=;
        b=AUhykoC0KMSJj6ZiKb186jSyvvDOl2hCsINA/SRVtM2BXIrcFe9+VtZQufhG7xpUSm
         +D/xZv98SDpdNdvbZFJZeLs+IYrtZ0w1v7VGqVkUe3wXYBlIGkV6DZbTqJS27aVN9nM0
         WT6kXQMr+Ri2JWltjaWYQ8Ix2EPFwn6PRnX3gcoDHrKnhU6RBDmP/XZ8/N5FfrLOp9//
         nAoD+77OAfmlNI7KuZ/aJOkudv2gTzA49rnKDIxQsgZAIoTRmBIj3/mYk3UER8mvXFqP
         A6+/EBtBtD0o65T2vyreRa9Dll7/BXOQG6qN8+/sYj6y3hzLGR0sAPzt8WZlsGrlRcif
         7adQ==
X-Gm-Message-State: AOAM533RcgN10Y9wzU8h6hIXkzY4QnoaDLbHcpSfkXKxvFkmOv4109TQ
        ntpLN8Dqf2UMUJkwZVa1TVo=
X-Google-Smtp-Source: ABdhPJycJf0TeotkOECja1wVBxAv2+bVqPXv+pl0RMQM6q8AcLMRo5nt47lqlInySGVXrhQjGsI/DA==
X-Received: by 2002:a05:6638:1648:: with SMTP id a8mr12375660jat.25.1615871303659;
        Mon, 15 Mar 2021 22:08:23 -0700 (PDT)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id y9sm8587469ill.15.2021.03.15.22.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 22:08:23 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v3 04/18] dyndbg: accept null site in ddebug_match_site
Date:   Mon, 15 Mar 2021 23:07:47 -0600
Message-Id: <20210316050801.2446401-5-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210316050801.2446401-1-jim.cromie@gmail.com>
References: <20210316050801.2446401-1-jim.cromie@gmail.com>
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

