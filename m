Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F92C315CD7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 03:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235253AbhBJCFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 21:05:21 -0500
Received: from mail.windriver.com ([147.11.1.11]:59128 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234331AbhBJAqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 19:46:21 -0500
X-Greylist: delayed 6077 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Feb 2021 19:43:53 EST
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.corp.ad.wrs.com [147.11.82.252])
        by mail.windriver.com (8.15.2/8.15.2) with ESMTPS id 119MxGW3018293
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 9 Feb 2021 14:59:16 -0800 (PST)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 9 Feb 2021 14:59:13 -0800
Received: from yow-pgortmak-lx2.corp.ad.wrs.com (128.224.56.62) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Tue, 9 Feb 2021 14:59:12 -0800
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
Subject: [PATCH 1/8] lib: test_bitmap: clearly separate ERANGE from EINVAL tests.
Date:   Tue, 9 Feb 2021 17:59:00 -0500
Message-ID: <20210209225907.78405-2-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210209225907.78405-1-paul.gortmaker@windriver.com>
References: <20210209225907.78405-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This block of tests was meant to find/flag incorrect use of the ":"
and "/" separators (syntax errors) and invalid (zero) group len.

However they were specified with an 8 bit width and 32 bit operations,
so they really contained two errors (EINVAL and ERANGE).

Promote them to 32 bit so it is clear what they are meant to target.
Then we can add tests specific for ERANGE (no syntax errors, just
doing 32bit op on 8 bit width, plus a typical 9-on-8 fencepost error).

Cc: Yury Norov <yury.norov@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 lib/test_bitmap.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 4425a1dd4ef1..589f2a34ceba 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -338,12 +338,12 @@ static const struct test_bitmap_parselist parselist_tests[] __initconst = {
 	{-EINVAL, "-1",	NULL, 8, 0},
 	{-EINVAL, "-0",	NULL, 8, 0},
 	{-EINVAL, "10-1", NULL, 8, 0},
-	{-EINVAL, "0-31:", NULL, 8, 0},
-	{-EINVAL, "0-31:0", NULL, 8, 0},
-	{-EINVAL, "0-31:0/", NULL, 8, 0},
-	{-EINVAL, "0-31:0/0", NULL, 8, 0},
-	{-EINVAL, "0-31:1/0", NULL, 8, 0},
-	{-EINVAL, "0-31:10/1", NULL, 8, 0},
+	{-EINVAL, "0-31:", NULL, 32, 0},
+	{-EINVAL, "0-31:0", NULL, 32, 0},
+	{-EINVAL, "0-31:0/", NULL, 32, 0},
+	{-EINVAL, "0-31:0/0", NULL, 32, 0},
+	{-EINVAL, "0-31:1/0", NULL, 32, 0},
+	{-EINVAL, "0-31:10/1", NULL, 32, 0},
 	{-EOVERFLOW, "0-98765432123456789:10/1", NULL, 8, 0},
 
 	{-EINVAL, "a-31", NULL, 8, 0},
-- 
2.17.1

