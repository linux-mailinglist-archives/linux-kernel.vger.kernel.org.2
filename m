Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0129533CCF9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 06:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235350AbhCPFJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 01:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235203AbhCPFIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 01:08:37 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0F0C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 22:08:36 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id g27so35874876iox.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 22:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3pZWtkoB8DoemlBsewaLIuFeiMW4g/7X4YUir/I2wAU=;
        b=GXinR+TVojmhGEKYmawP4Agn2RkrgvqG7/c4UPjDKE7uPdqZsDCZfbCjnxc4SOvwqx
         PlKEYimacdVm1PeEQT+nYDOliOH5GVmNMq7u5kFWqQIMGKDyGwpa5tGF4uOHCIEDSZrA
         rjeSN+q+yObcjr5ELMmRn2BYCAQRWYRISOagSJMrE66HS95bG0GKpyalHOS4iH6NHczl
         gH4MvGvzuj9TASe+kxCaR1p80yIWSecSF5ofbaSRsj3B9Xac1vsvjQ2hrtyMLhdCQySX
         iZg1cmsskYAozqIX+GLEnhD7ID7G3qJNzpquAor/bqSBFTMdBieD4s2Bly9EdohKCTwO
         O9tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3pZWtkoB8DoemlBsewaLIuFeiMW4g/7X4YUir/I2wAU=;
        b=o+Pjpyog8PU2gD6UG2HozvnK8dCETE643onIKTJHmjO+YJuBPR5JfFaHHpXmwlrBdx
         otJ43N3GlljNmy2hAx8WNJ4RnK4+S1sQ2KE8Cpc73zWJ1LsWirzyYzOTpouMLNkFBqtN
         a4JweRi6l0CsxMFgvpHYEDmNIdSJPvQfyxmfQOrBqwsoOsvvb+uclWwKcc4B96tx7BJ8
         jG1yAlWvg761nvN6AFLSSUcRdPE2O0g1ZU3wYeOlumhG3Le0hpbAP8s+gEM5JV+nKdt8
         BIigq14TYZwCWz+4ve7PQucLMWDcSm0JFsUvs96Jp6xDybiX95BtSQab5FSs0+NBBVvm
         eXUQ==
X-Gm-Message-State: AOAM533DeD3mOmwmBdiNrT6dk1peBwh4b/zBxwkj+yUUwCyOvkz7bCyr
        5cGQXCW/yoch0KRJtxXI6lU=
X-Google-Smtp-Source: ABdhPJx4K9kmbPgsVjGqiJJs30KqCjjZLPiJrpRaIMaADpYjceY42DfBHV9TJey7LQUnzENenvYVVQ==
X-Received: by 2002:a05:6602:2ac4:: with SMTP id m4mr2094116iov.41.1615871316397;
        Mon, 15 Mar 2021 22:08:36 -0700 (PDT)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id y9sm8587469ill.15.2021.03.15.22.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 22:08:35 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v3 18/18] dyndbg: shuffle ddebug_table fields
Date:   Mon, 15 Mar 2021 23:08:01 -0600
Message-Id: <20210316050801.2446401-19-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210316050801.2446401-1-jim.cromie@gmail.com>
References: <20210316050801.2446401-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to unionize structs _ddebug & ddebug_table, shuffle
fields in latter so they match the layout of the former.  This MAY
simplify initialization of the header field, in particular by
preserving *sites.

It also sets up a later conversion to a flex-array ddebugs[].

This step is mostly to isolate/prove no breakage before HEAD++

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 29 +++++++++++++++++++++++++++++
 lib/dynamic_debug.c           |  2 +-
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 229cfd81ffb3..22f11218047f 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -66,6 +66,35 @@ struct _ddebug {
 #endif
 } __aligned(8);
 
+/* this pair of header structs correspond quite deeply to struct
+ * _ddebug(|_site)s above; they are also created into __dyndbg*
+ * sections (by DEFINE_DYNAMIC_DEBUG_TABLE), and should be unionized
+ * with them to reinforce this.
+ *
+ * struct _ddebug_header is the important one, it has enough space to
+ * take struct ddebug_table's job, ie: link together into a list, and
+ * keep track of the modname & _ddebug(|_sites) vectors.
+ *
+ * Its other job is handled by its placement in the front of a
+ * module's _ddebug[N] entries.  Each _ddebug knows its N, so the
+ * header's address is computable, and its site pointer is available
+ * to get _ddebug_sites[N].  Then we can drop _ddebug.sites, regaining
+ * parity with original _ddebug footprint.
+ *
+ * Eventually, N will index a fetch from a compressed block, or for
+ * enabled callsites, a hash.  A global hash is probably adequate, if
+ * ~5k elements doesnt degrade access time.
+ */
+struct _ddebug_site_header {
+	/* we have 24 bytes total here, all currently unused */
+} __aligned(8);
+
+struct _ddebug_header {
+	struct _ddebug_site* sites;
+	struct list_head link;
+	const char* mod_name;
+	unsigned num_ddebugs;
+} __aligned(8);
 
 #if defined(CONFIG_DYNAMIC_DEBUG_CORE)
 
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index c1a7345277eb..5d1ce7f21c30 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -45,11 +45,11 @@ extern struct _ddebug_site __start___dyndbg_sites[];
 extern struct _ddebug_site __stop___dyndbg_sites[];
 
 struct ddebug_table {
+	struct _ddebug_site *sites;
 	struct list_head link;
 	const char *mod_name;
 	unsigned int num_ddebugs;
 	struct _ddebug *ddebugs;
-	struct _ddebug_site *sites;
 };
 
 struct ddebug_query {
-- 
2.29.2

