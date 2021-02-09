Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7935315CCE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 03:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235334AbhBJCD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 21:03:27 -0500
Received: from mail.windriver.com ([147.11.1.11]:59128 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234023AbhBJAnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 19:43:53 -0500
X-Greylist: delayed 6077 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Feb 2021 19:43:53 EST
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.corp.ad.wrs.com [147.11.82.252])
        by mail.windriver.com (8.15.2/8.15.2) with ESMTPS id 119Mxkbv018427
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 9 Feb 2021 14:59:53 -0800 (PST)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 9 Feb 2021 14:59:14 -0800
Received: from yow-pgortmak-lx2.corp.ad.wrs.com (128.224.56.62) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Tue, 9 Feb 2021 14:59:13 -0800
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
Subject: [PATCH 2/8] lib: test_bitmap: add tests to trigger ERANGE case.
Date:   Tue, 9 Feb 2021 17:59:01 -0500
Message-ID: <20210209225907.78405-3-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210209225907.78405-1-paul.gortmaker@windriver.com>
References: <20210209225907.78405-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add tests that specify a valid range, but one that is outside the
width of the bitmap for which it is to be applied to.  These should
trigger an -ERANGE response from the code.

Cc: Yury Norov <yury.norov@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 lib/test_bitmap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 589f2a34ceba..172ffbfa83c4 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -338,6 +338,8 @@ static const struct test_bitmap_parselist parselist_tests[] __initconst = {
 	{-EINVAL, "-1",	NULL, 8, 0},
 	{-EINVAL, "-0",	NULL, 8, 0},
 	{-EINVAL, "10-1", NULL, 8, 0},
+	{-ERANGE, "8-8", NULL, 8, 0},
+	{-ERANGE, "0-31", NULL, 8, 0},
 	{-EINVAL, "0-31:", NULL, 32, 0},
 	{-EINVAL, "0-31:0", NULL, 32, 0},
 	{-EINVAL, "0-31:0/", NULL, 32, 0},
-- 
2.17.1

