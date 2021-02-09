Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBDC1315D20
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 03:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234728AbhBJCVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 21:21:50 -0500
Received: from mail1.windriver.com ([147.11.146.13]:43196 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234483AbhBJBdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 20:33:55 -0500
X-Greylist: delayed 8888 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Feb 2021 20:31:50 EST
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.corp.ad.wrs.com [147.11.82.252])
        by mail1.windriver.com (8.15.2/8.15.2) with ESMTPS id 119N0Ecr026195
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 9 Feb 2021 15:00:24 -0800 (PST)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 9 Feb 2021 14:59:17 -0800
Received: from yow-pgortmak-lx2.corp.ad.wrs.com (128.224.56.62) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Tue, 9 Feb 2021 14:59:16 -0800
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
Subject: [PATCH 4/8] lib: bitmap: move ERANGE check from set_region to check_region
Date:   Tue, 9 Feb 2021 17:59:03 -0500
Message-ID: <20210209225907.78405-5-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210209225907.78405-1-paul.gortmaker@windriver.com>
References: <20210209225907.78405-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It makes sense to do all the checks in check_region() and not 1/2
in check_region and 1/2 in set_region.

Since set_region is called immediately after check_region, the net
effect on runtime is zero, but it gets rid of an if (...) return...

Cc: Yury Norov <yury.norov@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 lib/bitmap.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index 75006c4036e9..9596ba53c36b 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -499,25 +499,22 @@ struct region {
 	unsigned int end;
 };
 
-static int bitmap_set_region(const struct region *r,
-				unsigned long *bitmap, int nbits)
+static void bitmap_set_region(const struct region *r, unsigned long *bitmap)
 {
 	unsigned int start;
 
-	if (r->end >= nbits)
-		return -ERANGE;
-
 	for (start = r->start; start <= r->end; start += r->group_len)
 		bitmap_set(bitmap, start, min(r->end - start + 1, r->off));
-
-	return 0;
 }
 
-static int bitmap_check_region(const struct region *r)
+static int bitmap_check_region(const struct region *r, int nbits)
 {
 	if (r->start > r->end || r->group_len == 0 || r->off > r->group_len)
 		return -EINVAL;
 
+	if (r->end >= nbits)
+		return -ERANGE;
+
 	return 0;
 }
 
@@ -651,13 +648,11 @@ int bitmap_parselist(const char *buf, unsigned long *maskp, int nmaskbits)
 		if (IS_ERR(buf))
 			return PTR_ERR(buf);
 
-		ret = bitmap_check_region(&r);
+		ret = bitmap_check_region(&r, nmaskbits);
 		if (ret)
 			return ret;
 
-		ret = bitmap_set_region(&r, maskp, nmaskbits);
-		if (ret)
-			return ret;
+		bitmap_set_region(&r, maskp);
 	}
 
 	return 0;
-- 
2.17.1

