Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2884233EA3A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 07:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbhCQGzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 02:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbhCQGyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 02:54:25 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5051C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 23:54:24 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id z13so39866811iox.8
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 23:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QdQI/+lAb+gYcRJWejMVqh44KMAoB3pFOSAUQhYLugQ=;
        b=T7zVl2JOnYIV/Bsq4L7te15XwB+NKN11FPFFLZyNNFpBAmojejBD26YAsCVpFAzrkY
         lemBgRx2iNvAypJeC8Lz5A0H9HlHWO29AGD3cBejRMR8lpUuXEtYYeCPo0fX/kQZTgSl
         JsqKYJwI7Vn7KwG/u6I+RY/UGpyfCESHf3ih5DAmk8TFSupC2+M40iEt5lxkP/XD3V9R
         HdvKAZpAHdpYLqumQrQiJ8bvDU0bLvKTZOeDJSHTkSb+L0tk4fGCYZnfBkXfqfPLXeAN
         7AtCRWtKt1y6oue47+NaU4qnweua7Tr7vbSBZkSZb9isnoPQMAsUThDjZi+V6C1Awt+O
         REMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QdQI/+lAb+gYcRJWejMVqh44KMAoB3pFOSAUQhYLugQ=;
        b=dDp4oiG7rwVjhM5aZZIDU4IxmBMoT5V6OdtZCI515dXypl9r3N2aT//LgVbonVkSNZ
         kOrAbBgwWSXClLsM+KGIuBmnmAEXDiNVga/3RDHXGGgAlNUCnipIFMCUO/BRrRFx2pyW
         iiyOd/BvXI2yzFY58YSVSL/HvgAyQUmX7+0yz1vR2iT8a0a+DNDA7lnjCR/wSPTRjNtE
         ycBrSNeXWHs6u18hL6EofkaE6EsvoOt9LSRGEysZ7zYSRNy48kMMCDnqMyTtbV21Turp
         tCRvN06eoujzN/1www8GV83x5rd49QOJmepVmMud/AjJ5QRMPhymXPXdv+xlwxOT11fd
         2Tiw==
X-Gm-Message-State: AOAM530L/KDV+XZngBZaV2VXh/hd4gSslM7eM1Vvl6dAf32yMKWrTFxr
        ZBmQi1bU5FrK62x7EQSiKjZ+BBNn9DYwfA==
X-Google-Smtp-Source: ABdhPJyDJqT+IegN9ep3z3BwtNS3hwbWJZFqfCcjFeNleIhBXWlomdnyH80Q6FAPg4ibi0eoFFIbIQ==
X-Received: by 2002:a05:6638:3791:: with SMTP id w17mr1705594jal.91.1615964064242;
        Tue, 16 Mar 2021 23:54:24 -0700 (PDT)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id w13sm10583057ilg.48.2021.03.16.23.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 23:54:23 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v4 03/19] dyndbg: refactor part of ddebug_change to ddebug_match_site
Date:   Wed, 17 Mar 2021 00:53:56 -0600
Message-Id: <20210317065412.2890414-4-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210317065412.2890414-1-jim.cromie@gmail.com>
References: <20210317065412.2890414-1-jim.cromie@gmail.com>
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

