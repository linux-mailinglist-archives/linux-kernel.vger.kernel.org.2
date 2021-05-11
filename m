Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB6237AEC9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 20:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbhEKSxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 14:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232230AbhEKSwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 14:52:49 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE48C06138E
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 11:51:35 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id n10so19157804ion.8
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 11:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=be8g977AZ5bDeKF0B08Lx0EuPmyTmMUIPQ9/ceBeosg=;
        b=Gza6ZZPlOYH97az7teoGtiOBvrypZ4gz6Tq+qYV+S8QHwAQaCNulTaH2rSWVCpxiWP
         qtSkgTVNXomxSj0Y+DmNarQrJb7SaAitApc+zebdIuEl1BQsDE+76uSoFjKRYRT+M9fx
         hM1G8Z+UGi7f7W5+4ZW/w3ghxFXMxL2sH6jW+zO9lHXUzorUbaJMuHRgubxpWYKSX9HM
         FQge0xqiMm/vma34WvNR5JNXrFdem0pvvc4GiAW6p4xd4b6A0eTt0OhQ+c1GF3/AxEcJ
         RO1ntb1Osnr1f2Ge1F91Dl01j2YPFowmGLQqj2GrKwekrldxmzBn68GM8MlxKtBzAzsE
         Tsxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=be8g977AZ5bDeKF0B08Lx0EuPmyTmMUIPQ9/ceBeosg=;
        b=RKwGfcFaewWR4TWvMiFGQzE/Tdg8ZWX17yAf67JAxfLOloageO21rBEZ+br6qlci+4
         hEJeY7egAzxPkSDjHCo6fcQJQAEgBVJQgVafx566iFqc05SxfngTHP0dTROMQFswl7D9
         qsULROPscwYyY0xRD3cMB+fmeF53N1WY/gZm+MujtduG121VsbVMXrCJkFjy9oTA+WYl
         Thz1AmzgdmAknETpR4n+kbl7fPnDetZ+wmyZtXIDtsCEEDSinKqK+sCK/IXJhZ9XgTUd
         NU+8iJ0rMxgDxdTAx/fWbqGL5Bvh3JnQZuVHKmwnk/chpAp5BRsd8jNWvoRDt+2Nxked
         szDA==
X-Gm-Message-State: AOAM530xSuxh/0rzvf3Tm1ZNMqa0U/GPRsIY0hTEYtofKYkFYI8is7V2
        03pC9gmWdFbkyUNnPaI6Z0I=
X-Google-Smtp-Source: ABdhPJwJEnJHsn2AEinRleOhYeJoPFdY8E7nfKDfQwU6fZnspnBCl/X3CxKfV0FIu2/z9S8AG6OguA==
X-Received: by 2002:a05:6638:3c8:: with SMTP id r8mr27928630jaq.112.1620759094788;
        Tue, 11 May 2021 11:51:34 -0700 (PDT)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id t10sm405096ils.36.2021.05.11.11.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 11:51:34 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     Jason Baron <jbaron@akamai.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v5 14/28] dyndbg: add ddebug_site(_get|_put) abstraction
Date:   Tue, 11 May 2021 12:50:43 -0600
Message-Id: <20210511185057.3815777-15-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210511185057.3815777-1-jim.cromie@gmail.com>
References: <20210511185057.3815777-1-jim.cromie@gmail.com>
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
index 1441b31915e7..90bea97c0da1 100644
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

