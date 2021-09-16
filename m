Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9886940D0E8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 02:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233602AbhIPAdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 20:33:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:35278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233356AbhIPAdH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 20:33:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CB55260F6D;
        Thu, 16 Sep 2021 00:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631752307;
        bh=+A2TcrBK6umeUcb6ilLMO3seGjNWJa6VtHUkQa1H3j0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IR0lq1JIIc23sibNTIpXqmQq3q2hOP/PuGZ2YsRQ9wMEN7DApEAKVImxdARKeMB6U
         plUTdT9e0icQXkFYU+SbZL8PBADacNFqXEmEnfb4s/bY/+7s0wEhFPbOsc6COsjUfk
         EskBsHxSSOU376xucFebJcpF7qkp31EtxrsYpGZi4x8WD+JvJWCuIsW53aX6fmGGu4
         dNZ7rPVs7FS1RQRjYZG86sW7I/GuCLYwYT6DzN1Ik1dzrGCXeuGcfXAQt17GF3Re0n
         lamIJjKdMK9lgmzIiocOH9ZLsI2BPbaRH6byWQo0XbVkqH5Itx5dnPi3O1vBQwtP5p
         5TP4ybvO8Rtrw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id AE0BB5C06B9; Wed, 15 Sep 2021 17:31:47 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH kcsan 2/9] kcsan: test: Use kunit_skip() to skip tests
Date:   Wed, 15 Sep 2021 17:31:39 -0700
Message-Id: <20210916003146.3910358-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210916003126.GA3910257@paulmck-ThinkPad-P17-Gen-1>
References: <20210916003126.GA3910257@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Elver <elver@google.com>

Use the new kunit_skip() to skip tests if requirements were not met.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/kcsan/kcsan_test.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/kcsan/kcsan_test.c b/kernel/kcsan/kcsan_test.c
index df041bdb6088..d93f226327af 100644
--- a/kernel/kcsan/kcsan_test.c
+++ b/kernel/kcsan/kcsan_test.c
@@ -29,6 +29,11 @@
 #include <linux/types.h>
 #include <trace/events/printk.h>
 
+#define KCSAN_TEST_REQUIRES(test, cond) do {			\
+	if (!(cond))						\
+		kunit_skip((test), "Test requires: " #cond);	\
+} while (0)
+
 #ifdef CONFIG_CC_HAS_TSAN_COMPOUND_READ_BEFORE_WRITE
 #define __KCSAN_ACCESS_RW(alt) (KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_WRITE)
 #else
@@ -642,8 +647,7 @@ static void test_read_plain_atomic_write(struct kunit *test)
 	};
 	bool match_expect = false;
 
-	if (IS_ENABLED(CONFIG_KCSAN_IGNORE_ATOMICS))
-		return;
+	KCSAN_TEST_REQUIRES(test, !IS_ENABLED(CONFIG_KCSAN_IGNORE_ATOMICS));
 
 	begin_test_checks(test_kernel_read, test_kernel_write_atomic);
 	do {
@@ -665,8 +669,7 @@ static void test_read_plain_atomic_rmw(struct kunit *test)
 	};
 	bool match_expect = false;
 
-	if (IS_ENABLED(CONFIG_KCSAN_IGNORE_ATOMICS))
-		return;
+	KCSAN_TEST_REQUIRES(test, !IS_ENABLED(CONFIG_KCSAN_IGNORE_ATOMICS));
 
 	begin_test_checks(test_kernel_read, test_kernel_atomic_rmw);
 	do {
-- 
2.31.1.189.g2e36527f23

