Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3DA315D1D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 03:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234239AbhBJCU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 21:20:56 -0500
Received: from mail1.windriver.com ([147.11.146.13]:43196 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235053AbhBJBcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 20:32:42 -0500
X-Greylist: delayed 8888 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Feb 2021 20:31:50 EST
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.corp.ad.wrs.com [147.11.82.252])
        by mail1.windriver.com (8.15.2/8.15.2) with ESMTPS id 119N0OT9026207
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 9 Feb 2021 15:00:35 -0800 (PST)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 9 Feb 2021 14:59:21 -0800
Received: from yow-pgortmak-lx2.corp.ad.wrs.com (128.224.56.62) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Tue, 9 Feb 2021 14:59:20 -0800
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
Subject: [PATCH 7/8] lib: test_bitmap: add tests for "N" alias
Date:   Tue, 9 Feb 2021 17:59:06 -0500
Message-ID: <20210209225907.78405-8-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210209225907.78405-1-paul.gortmaker@windriver.com>
References: <20210209225907.78405-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are copies of existing tests, with just 31 --> N.  This ensures
the recently added "N" alias transparently works in any normally
numeric fields of a region specification.

Cc: Yury Norov <yury.norov@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 lib/test_bitmap.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 9c6a88c480c1..a6048278d027 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -354,6 +354,16 @@ static const struct test_bitmap_parselist parselist_tests[] __initconst = {
 	{0, "16-31:16/31",		&exp1[3 * step], 32, 0},
 	{0, "31-31:31/31",		&exp1[14 * step], 32, 0},
 
+	{0, "N-N",			&exp1[14 * step], 32, 0},
+	{0, "0-0:1/N",			&exp1[0], 32, 0},
+	{0, "0-0:N/N",			&exp1[0], 32, 0},
+	{0, "0-15:16/N",		&exp1[2 * step], 32, 0},
+	{0, "15-15:N/N",		&exp1[13 * step], 32, 0},
+	{0, "15-N:1/N",			&exp1[13 * step], 32, 0},
+	{0, "16-N:16/N",		&exp1[3 * step], 32, 0},
+	{0, "N-N:N/N",			&exp1[14 * step], 32, 0},
+
+	{0, "0-N:1/3,1-N:1/3,2-N:1/3",		&exp1[8 * step], 32, 0},
 	{0, "0-31:1/3,1-31:1/3,2-31:1/3",	&exp1[8 * step], 32, 0},
 	{0, "1-10:8/12,8-31:24/29,0-31:0/3",	&exp1[9 * step], 32, 0},
 
-- 
2.17.1

