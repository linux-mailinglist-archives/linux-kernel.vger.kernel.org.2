Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4690832C52F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444404AbhCDATk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 19:19:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:39412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352586AbhCDAHI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 19:07:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E2CAC64F44;
        Wed,  3 Mar 2021 23:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614815779;
        bh=3Gb3GiZpHrzq0CQisU0ovLCOUcvPqMKtN8rs++El1QA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dwKF1VdjqXR7KTjyhhYazdeBUSGW6SiH93DzJjeHZUY9x3yOmIfoSz6fU1wJo1q/B
         L6caOJT8xNvcKbY3ctaHdi62+D93TUEGiVKw7SFv58OVTEOA4dmn6tcp+/To138nND
         QwMgdLdGAbhiZN5d5A96ni1y+C1tZbeQ6Clg9SrFY7eqEOFM6/o9YJm1nhfs5LbEah
         ho9yXcJ0UwE/zHJ7MxiKYw+XaikiNRLhJTqAF2MosfQlTRUbDvicYRPq0+oXklE//x
         ysziW3BrxFAiW8LpWMRJSbSE49wycathDwLSpFMVVndMRvJE1dnuCz76Pr5sUvje+u
         YGDxa53PP6/uw==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        paul.gortmaker@windriver.com, Yury Norov <yury.norov@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH lib/bitmap 2/9] lib: test_bitmap: add tests to trigger ERANGE case.
Date:   Wed,  3 Mar 2021 15:56:09 -0800
Message-Id: <20210303235616.22093-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210303235526.GA21868@paulmck-ThinkPad-P72>
References: <20210303235526.GA21868@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Gortmaker <paul.gortmaker@windriver.com>

Add tests that specify a valid range, but one that is outside the
width of the bitmap for which it is to be applied to.  These should
trigger an -ERANGE response from the code.

Cc: Yury Norov <yury.norov@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Yury Norov <yury.norov@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 lib/test_bitmap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 853a3a6..0f2e91d 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -337,6 +337,8 @@ static const struct test_bitmap_parselist parselist_tests[] __initconst = {
 	{-EINVAL, "-1",	NULL, 8, 0},
 	{-EINVAL, "-0",	NULL, 8, 0},
 	{-EINVAL, "10-1", NULL, 8, 0},
+	{-ERANGE, "8-8", NULL, 8, 0},
+	{-ERANGE, "0-31", NULL, 8, 0},
 	{-EINVAL, "0-31:", NULL, 32, 0},
 	{-EINVAL, "0-31:0", NULL, 32, 0},
 	{-EINVAL, "0-31:0/", NULL, 32, 0},
-- 
2.9.5

