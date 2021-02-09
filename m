Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC9A3315CE1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 03:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233905AbhBJCHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 21:07:20 -0500
Received: from mail.windriver.com ([147.11.1.11]:59128 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234127AbhBJAxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 19:53:16 -0500
X-Greylist: delayed 6077 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Feb 2021 19:43:53 EST
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.corp.ad.wrs.com [147.11.82.252])
        by mail.windriver.com (8.15.2/8.15.2) with ESMTPS id 119N0Lwc018627
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 9 Feb 2021 15:00:21 -0800 (PST)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 9 Feb 2021 14:59:18 -0800
Received: from yow-pgortmak-lx2.corp.ad.wrs.com (128.224.56.62) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Tue, 9 Feb 2021 14:59:17 -0800
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Li Zefan <lizefan@huawei.com>, Ingo Molnar <mingo@kernel.org>,
        Yury Norov <yury.norov@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Triplett <josh@joshtriplett.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 5/8] lib: bitmap: pair nbits value with region struct
Date:   Tue, 9 Feb 2021 17:59:04 -0500
Message-ID: <20210209225907.78405-6-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210209225907.78405-1-paul.gortmaker@windriver.com>
References: <20210209225907.78405-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A region is a standalone entity to some degree, but it needs to
be paired with a bitmap width in order to set context and determine
if the region even fits into the width of the bitmap.

This will reduce parameter passing and enable using nbits as part
of future dynamic region parameter parsing.

Cc: Yury Norov <yury.norov@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Suggested-by: Yury Norov <yury.norov@gmail.com>
Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 lib/bitmap.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index 9596ba53c36b..6b568f98af3d 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -499,6 +499,16 @@ struct region {
 	unsigned int end;
 };
 
+/*
+ * The region "0-3" is a complete specification, i.e. "the 1st four cores"
+ * for a CPU map, but it needs to be paired to a width in order to have a
+ * meaningful and valid context. (i.e. 4 core region on 4+ core machine...)
+ */
+struct bitmap_region {
+	struct region *r;
+	unsigned int nbits;
+};
+
 static void bitmap_set_region(const struct region *r, unsigned long *bitmap)
 {
 	unsigned int start;
@@ -507,12 +517,14 @@ static void bitmap_set_region(const struct region *r, unsigned long *bitmap)
 		bitmap_set(bitmap, start, min(r->end - start + 1, r->off));
 }
 
-static int bitmap_check_region(const struct region *r, int nbits)
+static int bitmap_check_region(const struct bitmap_region *br)
 {
+	struct region *r = br->r;
+
 	if (r->start > r->end || r->group_len == 0 || r->off > r->group_len)
 		return -EINVAL;
 
-	if (r->end >= nbits)
+	if (r->end >= br->nbits)
 		return -ERANGE;
 
 	return 0;
@@ -635,8 +647,12 @@ static const char *bitmap_parse_region(const char *str, struct region *r)
 int bitmap_parselist(const char *buf, unsigned long *maskp, int nmaskbits)
 {
 	struct region r;
+	struct bitmap_region br;
 	long ret;
 
+	br.r = &r;
+	br.nbits = nmaskbits;
+
 	bitmap_zero(maskp, nmaskbits);
 
 	while (buf) {
@@ -648,7 +664,7 @@ int bitmap_parselist(const char *buf, unsigned long *maskp, int nmaskbits)
 		if (IS_ERR(buf))
 			return PTR_ERR(buf);
 
-		ret = bitmap_check_region(&r, nmaskbits);
+		ret = bitmap_check_region(&br);
 		if (ret)
 			return ret;
 
-- 
2.17.1

