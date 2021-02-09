Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 972FB315D25
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 03:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235353AbhBJCW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 21:22:57 -0500
Received: from mail1.windriver.com ([147.11.146.13]:43196 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234448AbhBJBhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 20:37:52 -0500
X-Greylist: delayed 8888 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Feb 2021 20:31:50 EST
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.corp.ad.wrs.com [147.11.82.252])
        by mail1.windriver.com (8.15.2/8.15.2) with ESMTPS id 119N0L2S026204
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 9 Feb 2021 15:00:27 -0800 (PST)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 9 Feb 2021 14:59:19 -0800
Received: from yow-pgortmak-lx2.corp.ad.wrs.com (128.224.56.62) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Tue, 9 Feb 2021 14:59:18 -0800
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
Subject: [PATCH 6/8] lib: bitmap: support "N" as an alias for size of bitmap
Date:   Tue, 9 Feb 2021 17:59:05 -0500
Message-ID: <20210209225907.78405-7-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210209225907.78405-1-paul.gortmaker@windriver.com>
References: <20210209225907.78405-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While this is done for all bitmaps, the original use case in mind was
for CPU masks and cpulist_parse() as described below.

It seems that a common configuration is to use the 1st couple cores for
housekeeping tasks.  This tends to leave the remaining ones to form a
pool of similarly configured cores to take on the real workload of
interest to the user.

So on machine A - with 32 cores, it could be 0-3 for "system" and then
4-31 being used in boot args like nohz_full=, or rcu_nocbs= as part of
setting up the worker pool of CPUs.

But then newer machine B is added, and it has 48 cores, and so while
the 0-3 part remains unchanged, the pool setup cpu list becomes 4-47.

Multiple deployment becomes easier when we can just simply replace 31
and 47 with "N" and let the system substitute in the actual number at
boot; a number that it knows better than we do.

Cc: Yury Norov <yury.norov@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Suggested-by: Yury Norov <yury.norov@gmail.com> # move it from CPU code
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 .../admin-guide/kernel-parameters.rst         |  7 +++++
 lib/bitmap.c                                  | 27 ++++++++++++++-----
 2 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.rst b/Documentation/admin-guide/kernel-parameters.rst
index 682ab28b5c94..7733a773f5f8 100644
--- a/Documentation/admin-guide/kernel-parameters.rst
+++ b/Documentation/admin-guide/kernel-parameters.rst
@@ -68,6 +68,13 @@ For example one can add to the command line following parameter:
 
 where the final item represents CPUs 100,101,125,126,150,151,...
 
+The value "N" can be used to represent the numerically last CPU on the system,
+i.e "foo_cpus=16-N" would be equivalent to "16-31" on a 32 core system.
+
+Keep in mind that "N" is dynamic, so if system changes cause the bitmap width
+to change, such as less cores in the CPU list, then N and any ranges using N
+will also change.  Use the same on a small 4 core system, and "16-N" becomes
+"16-3" and now the same boot input will be flagged as invalid (start > end).
 
 
 This document may not be entirely up to date and comprehensive. The command
diff --git a/lib/bitmap.c b/lib/bitmap.c
index 6b568f98af3d..cc7cb1fca1ac 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -530,11 +530,17 @@ static int bitmap_check_region(const struct bitmap_region *br)
 	return 0;
 }
 
-static const char *bitmap_getnum(const char *str, unsigned int *num)
+static const char *bitmap_getnum(const char *str, unsigned int *num,
+				 unsigned int lastbit)
 {
 	unsigned long long n;
 	unsigned int len;
 
+	if (str[0] == 'N') {
+		*num = lastbit;
+		return str + 1;
+	}
+
 	len = _parse_integer(str, 10, &n);
 	if (!len)
 		return ERR_PTR(-EINVAL);
@@ -580,9 +586,12 @@ static const char *bitmap_find_region_reverse(const char *start, const char *end
 	return end;
 }
 
-static const char *bitmap_parse_region(const char *str, struct region *r)
+static const char *bitmap_parse_region(const char *str, struct bitmap_region *br)
 {
-	str = bitmap_getnum(str, &r->start);
+	struct region *r = br->r;
+	unsigned int lastbit = br->nbits - 1;
+
+	str = bitmap_getnum(str, &r->start, lastbit);
 	if (IS_ERR(str))
 		return str;
 
@@ -592,7 +601,7 @@ static const char *bitmap_parse_region(const char *str, struct region *r)
 	if (*str != '-')
 		return ERR_PTR(-EINVAL);
 
-	str = bitmap_getnum(str + 1, &r->end);
+	str = bitmap_getnum(str + 1, &r->end, lastbit);
 	if (IS_ERR(str))
 		return str;
 
@@ -602,14 +611,14 @@ static const char *bitmap_parse_region(const char *str, struct region *r)
 	if (*str != ':')
 		return ERR_PTR(-EINVAL);
 
-	str = bitmap_getnum(str + 1, &r->off);
+	str = bitmap_getnum(str + 1, &r->off, lastbit);
 	if (IS_ERR(str))
 		return str;
 
 	if (*str != '/')
 		return ERR_PTR(-EINVAL);
 
-	return bitmap_getnum(str + 1, &r->group_len);
+	return bitmap_getnum(str + 1, &r->group_len, lastbit);
 
 no_end:
 	r->end = r->start;
@@ -636,6 +645,10 @@ static const char *bitmap_parse_region(const char *str, struct region *r)
  * From each group will be used only defined amount of bits.
  * Syntax: range:used_size/group_size
  * Example: 0-1023:2/256 ==> 0,1,256,257,512,513,768,769
+ * The value 'N' can be used as a dynamically substituted token for the
+ * maximum allowed value; i.e (nmaskbits - 1).  Keep in mind that it is
+ * dynamic, so if system changes cause the bitmap width to change, such
+ * as more cores in a CPU list, then any ranges using N will also change.
  *
  * Returns: 0 on success, -errno on invalid input strings. Error values:
  *
@@ -660,7 +673,7 @@ int bitmap_parselist(const char *buf, unsigned long *maskp, int nmaskbits)
 		if (buf == NULL)
 			return 0;
 
-		buf = bitmap_parse_region(buf, &r);
+		buf = bitmap_parse_region(buf, &br);
 		if (IS_ERR(buf))
 			return PTR_ERR(buf);
 
-- 
2.17.1

