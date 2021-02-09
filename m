Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0043315CDC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 03:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235305AbhBJCFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 21:05:51 -0500
Received: from mail.windriver.com ([147.11.1.11]:59128 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233954AbhBJAsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 19:48:47 -0500
X-Greylist: delayed 6077 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Feb 2021 19:43:53 EST
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.corp.ad.wrs.com [147.11.82.252])
        by mail.windriver.com (8.15.2/8.15.2) with ESMTPS id 119MxvYI018473
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 9 Feb 2021 14:59:57 -0800 (PST)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 9 Feb 2021 14:59:15 -0800
Received: from yow-pgortmak-lx2.corp.ad.wrs.com (128.224.56.62) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Tue, 9 Feb 2021 14:59:14 -0800
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
Subject: [PATCH 3/8] lib: test_bitmap: add more start-end:offset/len tests
Date:   Tue, 9 Feb 2021 17:59:02 -0500
Message-ID: <20210209225907.78405-4-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210209225907.78405-1-paul.gortmaker@windriver.com>
References: <20210209225907.78405-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are inputs to bitmap_parselist() that would probably never
be entered manually by a person, but might result from some kind of
automated input generator.  Things like ranges of length 1, or group
lengths longer than nbits, overlaps, or offsets of zero.

Adding these tests serve two purposes:

1) document what might seem odd but nonetheless valid input.

2) don't regress from what we currently accept as valid.

Cc: Yury Norov <yury.norov@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Yury Norov <yury.norov@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 lib/test_bitmap.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 172ffbfa83c4..9c6a88c480c1 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -35,6 +35,8 @@ static const unsigned long exp1[] __initconst = {
 	BITMAP_FROM_U64(0x3333333311111111ULL),
 	BITMAP_FROM_U64(0xffffffff77777777ULL),
 	BITMAP_FROM_U64(0),
+	BITMAP_FROM_U64(0x00008000),
+	BITMAP_FROM_U64(0x80000000),
 };
 
 static const unsigned long exp2[] __initconst = {
@@ -335,6 +337,26 @@ static const struct test_bitmap_parselist parselist_tests[] __initconst = {
 	{0, " ,  ,,  , ,   ",		&exp1[12 * step], 8, 0},
 	{0, " ,  ,,  , ,   \n",		&exp1[12 * step], 8, 0},
 
+	{0, "0-0",			&exp1[0], 32, 0},
+	{0, "1-1",			&exp1[1 * step], 32, 0},
+	{0, "15-15",			&exp1[13 * step], 32, 0},
+	{0, "31-31",			&exp1[14 * step], 32, 0},
+
+	{0, "0-0:0/1",			&exp1[12 * step], 32, 0},
+	{0, "0-0:1/1",			&exp1[0], 32, 0},
+	{0, "0-0:1/31",			&exp1[0], 32, 0},
+	{0, "0-0:31/31",		&exp1[0], 32, 0},
+	{0, "1-1:1/1",			&exp1[1 * step], 32, 0},
+	{0, "0-15:16/31",		&exp1[2 * step], 32, 0},
+	{0, "15-15:1/2",		&exp1[13 * step], 32, 0},
+	{0, "15-15:31/31",		&exp1[13 * step], 32, 0},
+	{0, "15-31:1/31",		&exp1[13 * step], 32, 0},
+	{0, "16-31:16/31",		&exp1[3 * step], 32, 0},
+	{0, "31-31:31/31",		&exp1[14 * step], 32, 0},
+
+	{0, "0-31:1/3,1-31:1/3,2-31:1/3",	&exp1[8 * step], 32, 0},
+	{0, "1-10:8/12,8-31:24/29,0-31:0/3",	&exp1[9 * step], 32, 0},
+
 	{-EINVAL, "-1",	NULL, 8, 0},
 	{-EINVAL, "-0",	NULL, 8, 0},
 	{-EINVAL, "10-1", NULL, 8, 0},
-- 
2.17.1

