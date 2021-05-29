Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDB06394E0A
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 22:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbhE2UEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 16:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbhE2UEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 16:04:07 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35E3C061574
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 13:02:29 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so7003226otl.3
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 13:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OTpoh91bAxiqtddycznwQFFnSpeFEWhlLYw6zGL5QJQ=;
        b=oORKX0rKq6NQ5WQSIZwlwYj/WWHXIP1bmYE17CfelXcg7guZo1qj+cHE8enY3KtG3O
         d9tEe7HGWDZw1rguqF4NEm5K3nCzDoSxMGbUoPpmo77csofx8PPE5yMHlu5u+1EydxYH
         RsJpU+pfzPYPDn37sWncmoAXwaPeFxn8v4poPqiq396s0o8uAG6QqArE2XMaLttlL1pI
         5je+/YzAGIj+1vzJ8uYoh+R4L46Ly2CP7ROqcufediOwCNOCqT7/Wwa1D1HhIf/e2Kyj
         jYRZKdyV1NdcJCTJDBTHNKM8U0GIGTce+pB2HUtM7LpUMbOScUk3vlolRigIABDcvqvQ
         svmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OTpoh91bAxiqtddycznwQFFnSpeFEWhlLYw6zGL5QJQ=;
        b=gvJfiRk5TlvbYz3zreBztcXWeI2cQVEkx3YwMvgWPtlZCjZDkMRCy6sv/Bo33hbgRS
         7hJx1MH4q42X/BOfd3vKQ2U2PdcIKikYbaYeR0IaP5b4wQUO+DNz+1ovpS10svSdvXr8
         6p9lRzdUw2zgkGgp5G8Gdj0V4kuWZgCDur/q5msPbjCFnF1Kz4Vzi2Pi1KHpY5Mkh5RI
         uuHOKI2eAbBn4K5RQWGCW/RJvqEWYWwhiujNaiAun8qkgOqAGKkh11utE5r4g7RsjxvK
         35wCz3bGoLXgmpUGuSAmt2HHc4LwaXk7W3Vgmr4hxk0QBqK6zMYQXtXR3W3J9be/Yzqd
         BPwg==
X-Gm-Message-State: AOAM533E/kVk/F9ZGakEb8ak1f06X6+W81q9AeTu0A0xSSOPmCuVKmyM
        gjXHUaT4mFHdEXob40K+NTU=
X-Google-Smtp-Source: ABdhPJzcktqmSqaowpd6CaRWX7/AlsjEKDcrsRUICpvAnGdDSopLwnfvgTCgxXwggNDCIGe1WadHRg==
X-Received: by 2002:a9d:4b0e:: with SMTP id q14mr11240783otf.254.1622318549283;
        Sat, 29 May 2021 13:02:29 -0700 (PDT)
Received: from frodo.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id t39sm1868064ooi.42.2021.05.29.13.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 13:02:28 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v6 15/34] dyndbg: add ddebug_site(_get|_put) abstraction
Date:   Sat, 29 May 2021 14:00:10 -0600
Message-Id: <20210529200029.205306-16-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210529200029.205306-1-jim.cromie@gmail.com>
References: <20210529200029.205306-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace direct ->site refs with _get(),_put() internal API.  Right
now, _get() just returns ->site and _put() does nothing.  Later we can
replace this implementation with one using ->_index to fetch site data
then forget or keep it selectively.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index a4cb048357fb..7a15216e6bef 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -144,6 +144,14 @@ static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
 		 query->first_lineno, query->last_lineno);
 }
 
+static struct _ddebug_site *ddebug_site_get(struct _ddebug *dp)
+{
+	return dp->site; /* passthru abstraction */
+}
+static inline void ddebug_site_put(struct _ddebug *dp)
+{
+}
+
 static int ddebug_match_site(const struct ddebug_query *query,
 			     const struct _ddebug *dp,
 			     const struct _ddebug_site *dc)
@@ -239,16 +247,18 @@ static int ddebug_change(const struct ddebug_query *query,
 
 		for (i = 0; i < dt->num_ddebugs; i++) {
 			struct _ddebug *dp = &dt->ddebugs[i];
-			struct _ddebug_site *dc = dp->site;
+			struct _ddebug_site *dc;
+
+			dc = ddebug_site_get(dp);
 
 			if (!ddebug_match_site(query, dp, dc))
-				continue;
+				goto skipsite;
 
 			nfound++;
 
 			newflags = (dp->flags & modifiers->mask) | modifiers->flags;
 			if (newflags == dp->flags)
-				continue;
+				goto skipsite;
 
 			ddebug_alter_site(dp, modifiers);
 
@@ -264,6 +274,9 @@ static int ddebug_change(const struct ddebug_query *query,
 					  dt->mod_name, dp->lineno,
 					  ddebug_describe_flags(dp->flags, &fbuf),
 					  dp->format);
+
+skipsite:
+			ddebug_site_put(dp);
 		}
 	}
 	mutex_unlock(&ddebug_lock);
@@ -633,11 +646,11 @@ static int remaining(int wrote)
 	return 0;
 }
 
-static char *__dynamic_emit_prefix(const struct _ddebug *dp, char *buf)
+static char *__dynamic_emit_prefix(struct _ddebug *dp, char *buf)
 {
 	int pos_after_tid;
 	int pos = 0;
-	const struct _ddebug_site *desc = dp->site;
+	const struct _ddebug_site *desc;
 
 	if (dp->flags & _DPRINTK_FLAGS_INCL_TID) {
 		if (in_interrupt())
@@ -648,6 +661,7 @@ static char *__dynamic_emit_prefix(const struct _ddebug *dp, char *buf)
 	}
 	pos_after_tid = pos;
 
+	desc = ddebug_site_get(dp);
 	if (desc) {
 		if (dp->flags & _DPRINTK_FLAGS_INCL_MODNAME)
 			pos += snprintf(buf + pos, remaining(pos), "%s:",
@@ -665,6 +679,8 @@ static char *__dynamic_emit_prefix(const struct _ddebug *dp, char *buf)
 	if (pos >= PREFIX_SIZE)
 		buf[PREFIX_SIZE - 1] = '\0';
 
+	ddebug_site_put(dp);
+
 	return buf;
 }
 
@@ -947,7 +963,8 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 		return 0;
 	}
 
-	dc = dp->site;
+	dc = ddebug_site_get(dp);
+
 	if (dc) {
 		seq_printf(m, "%s:%u [%s]%s =%s \"",
 			   trim_prefix(dc->filename), dp->lineno,
@@ -963,6 +980,8 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 		seq_puts(m, "\"\n");
 	}
 
+	ddebug_site_put(dp);
+
 	return 0;
 }
 
-- 
2.31.1

