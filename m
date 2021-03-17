Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88C9733EA4C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 07:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbhCQGzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 02:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbhCQGys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 02:54:48 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBEFEC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 23:54:37 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id h1so508970ilr.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 23:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3pZWtkoB8DoemlBsewaLIuFeiMW4g/7X4YUir/I2wAU=;
        b=V4s1o3CxnHOoDQD4wNW+MqT+SPnmbouny7Ed5jI8uTYQjFUjGgDAWelqc9tVCdFcil
         EvRLBQFPGPHP9flckUQ0wtLE/kxcmazFSlPwEAKBJdotgBiN9miFB9uyQx4W5WecA2m+
         X+ygEI5FEvQ0nenJmOwe/QwtCFxALouBK/aw3fkoKGP519Mr6zw5Pc/iAh0QjDY5MQlw
         sq0AdFj1cNgP5p5DQeKViJygUJPdWNbExoS/jQCnwo5OY9WQfLzvzqCyrVphigqCZdwT
         Tgt2O/iXa2dGEJNMXftqxbeG/msKa9Y+lnxyeviTNx5pmVTBP7+RLaT2KvNI5On7EZ84
         vmfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3pZWtkoB8DoemlBsewaLIuFeiMW4g/7X4YUir/I2wAU=;
        b=s/zRqsdwvQZVCRlplWrDPc/fRLKPW/nUC1G6uAoLYlQGgUW56U/K0vvH5qs2+DrhSX
         LinhnY4AAUV62MnHrzsdpnL+xzzZBFvQlcwFAzs27HPaWHNRRDXrl6RiFcyJFDcx2Vgr
         Hd853LHdJ07t0I9Iyeu6JtU4XZMFV5XN7sdCtongZ2L4Jpg+pyki2M5e6Db2kpdJyp7N
         hbbzVfuXhjni6FdDGIItX6VTbyCp2X9fKP2bFt22YfIBn5hPb+cFLIxgijkWIFpzA6IZ
         LSr/KUf9tijxVYKgPE2uAH2W1r0gRJyy0aWNRSsSSB1CcCQdTuzn1QMY6HHr6GNxEPrF
         apCg==
X-Gm-Message-State: AOAM533WHwEiuHhVPJ6P7Q+VuGapEOuXQmV5V1al/dmC3CV0nAgbXc3E
        ljMPui47X1FtcbtMyh+SZrM=
X-Google-Smtp-Source: ABdhPJyjc368tVSuGUyejOGb4chxW2nx+d8iJiMUEKqRSJIGy2jG6k415M29F8LT3Jbs70eLo6x2Zw==
X-Received: by 2002:a92:6b10:: with SMTP id g16mr6714741ilc.26.1615964077254;
        Tue, 16 Mar 2021 23:54:37 -0700 (PDT)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id w13sm10583057ilg.48.2021.03.16.23.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 23:54:36 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v4 18/19] dyndbg: shuffle ddebug_table fields
Date:   Wed, 17 Mar 2021 00:54:11 -0600
Message-Id: <20210317065412.2890414-19-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210317065412.2890414-1-jim.cromie@gmail.com>
References: <20210317065412.2890414-1-jim.cromie@gmail.com>
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

