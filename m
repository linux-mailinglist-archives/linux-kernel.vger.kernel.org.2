Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC5FD394E03
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 22:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbhE2UEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 16:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbhE2UEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 16:04:00 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F234C061574
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 13:02:23 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 66-20020a9d02c80000b02903615edf7c1aso6941694otl.13
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 13:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HWCvDjhV7vWU1en/ShehnzCgz41RpmjZWEvi8KsJf6o=;
        b=JoNk4i/R2/W6L4h4pGyFRlOExDqf2jd8TJqtQcSv596fnqs60s36y4a4txD5Zx0CD1
         r3qyn+9GOXA+amvVBY/tIo5PYYHI+S+2pFc1RLhYS4OTk717bj5Yls2cKV2Yznor07j2
         VuI9lJXHz1hcqf3+2vrZEegWleABDaZnE1znw8/FzD2/4l+NAUG+NduC2GiXrp3b5yr/
         AUBkMrMpD+yY7m0h2P1fPp12OLEp/G6P8qMSI78YAJDTaDVtMPKvS8RYZfi7ISanDmGD
         N02A8nHXTZuhY+w1E1eql0EcdtwGZp6aaM1vgiR8ev4vrL0edM1E+x6DL0thaTcHWQ3t
         4XZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HWCvDjhV7vWU1en/ShehnzCgz41RpmjZWEvi8KsJf6o=;
        b=iayuRz5T/zaWAlv66lvaySKhe1a0tywtLOed2OQ7v3h/MeAfYtWW60iC1rO9cU4EuP
         UhDUo5ebzmdYdS8FlAOCJnsnhd2qSZb1jrNBm6MjBUPg8IBcCKkTdQ5lb30Uy3g4VDdT
         Rav0qB79aonsKRgMbR8pvtCUBrD5yTKpSzV2al2zcZrIznZdT5R0/UhuLd6SsHgjRqcg
         jkunc9wFGxMsYgLHKf+bbJdwWAw4ySBaMJmwUyhrgQH5W6CQ2e5qH23lcXfgik6Vm3FI
         I7v+rZV+SUvvc3rtksDKWDQAIhf5qdB+cEuHwApwgai8ZxKyJuCH0TLWJRQLr7JksSL/
         WJZw==
X-Gm-Message-State: AOAM53385s4iT0ZESzBBI0d7hATt1eRjia4jnnV5hlg199AD+2C0ckSF
        IWSbKsdpwqbs3IZoXNAgBUA=
X-Google-Smtp-Source: ABdhPJx5tNoz3hUwreLe2rjmM7DKRlGyYU1hUZflfJSK237ITPE40cIQAHfxNoGcRuTkTS0RV7xe9Q==
X-Received: by 2002:a05:6830:13c4:: with SMTP id e4mr11246706otq.315.1622318542631;
        Sat, 29 May 2021 13:02:22 -0700 (PDT)
Received: from frodo.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id t39sm1868064ooi.42.2021.05.29.13.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 13:02:22 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v6 09/34] dyndbg: hoist ->site out of ddebug_match_site
Date:   Sat, 29 May 2021 14:00:04 -0600
Message-Id: <20210529200029.205306-10-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210529200029.205306-1-jim.cromie@gmail.com>
References: <20210529200029.205306-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A coming change adds _get/_put abstraction on the site pointer, to
allow managing site info more flexibly.  The get/put pattern is best
done at a single lexical scope, where its more obviously correct, so
hoist the ->site ref out of ddebug_match_site, and pass it in instead.

no functional changes

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index d62dc471bc1f..e40ce438636a 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -144,10 +144,9 @@ static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
 }
 
 static int ddebug_match_site(const struct ddebug_query *query,
-			     const struct _ddebug *dp)
+			     const struct _ddebug *dp,
+			     const struct _ddebug_site *dc)
 {
-	struct _ddebug_site *dc;
-
 	/* match against the format */
 	if (query->format) {
 		if (*query->format == '^') {
@@ -168,7 +167,6 @@ static int ddebug_match_site(const struct ddebug_query *query,
 	    dp->lineno > query->last_lineno)
 		return false;
 
-	dc = dp->site;
 	if (!dc) {
 		/* site info has been dropped, so query cannot test these fields */
 		if (query->filename || query->function)
@@ -220,9 +218,9 @@ static int ddebug_change(const struct ddebug_query *query,
 
 		for (i = 0; i < dt->num_ddebugs; i++) {
 			struct _ddebug *dp = &dt->ddebugs[i];
-			struct _ddebug_site *dc;
+			struct _ddebug_site *dc = dp->site;
 
-			if (!ddebug_match_site(query, dp))
+			if (!ddebug_match_site(query, dp, dc))
 				continue;
 
 			nfound++;
-- 
2.31.1

