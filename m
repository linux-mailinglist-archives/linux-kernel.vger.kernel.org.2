Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF7940D0F1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 02:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233933AbhIPAdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 20:33:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:35430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233615AbhIPAdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 20:33:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2195B6120F;
        Thu, 16 Sep 2021 00:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631752308;
        bh=xyJ8smTbjvLz5M6HxqmvgiD2/tzoJpgT9PfZl8DdLmQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ri/yOdIvWHkmTImHUzlltyXINeplUiYT/OIByFlzFx7C5k8yS2pda14YZEH9QoSE8
         zeC8+HiAOm4KdVNspIs1HIwUcNj2Phpq4PKH0iANjeAs0WCZV02OQYrDOmwA6256Hp
         kerDZ2eWCdwuy05b4oZcwV6/8IOuXremldxqntvJ4IH3xEHv0NiwTGMfMBzsE3f4yp
         SS9hacxSb05he4Tkwr2JagAZYp1+zfwN88KNLZlrRGrheIOSmai5hExZCnqFiJFDuT
         Yk3yNEsovbO/mtnqjXiOMn1rSzNs541ba+q81J08f6WGm2/mTl3yzqMRS2aepPaZIl
         z1zDgnV3P1BEw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id BBBB55C0B1B; Wed, 15 Sep 2021 17:31:47 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH kcsan 9/9] kcsan: selftest: Cleanup and add missing __init
Date:   Wed, 15 Sep 2021 17:31:46 -0700
Message-Id: <20210916003146.3910358-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210916003126.GA3910257@paulmck-ThinkPad-P17-Gen-1>
References: <20210916003126.GA3910257@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Elver <elver@google.com>

Make test_encode_decode() more readable and add missing __init.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/kcsan/selftest.c | 72 +++++++++++++++++------------------------
 1 file changed, 30 insertions(+), 42 deletions(-)

diff --git a/kernel/kcsan/selftest.c b/kernel/kcsan/selftest.c
index 7f29cb0f5e63..b4295a3892b7 100644
--- a/kernel/kcsan/selftest.c
+++ b/kernel/kcsan/selftest.c
@@ -18,7 +18,7 @@
 #define ITERS_PER_TEST 2000
 
 /* Test requirements. */
-static bool test_requires(void)
+static bool __init test_requires(void)
 {
 	/* random should be initialized for the below tests */
 	return prandom_u32() + prandom_u32() != 0;
@@ -28,14 +28,18 @@ static bool test_requires(void)
  * Test watchpoint encode and decode: check that encoding some access's info,
  * and then subsequent decode preserves the access's info.
  */
-static bool test_encode_decode(void)
+static bool __init test_encode_decode(void)
 {
 	int i;
 
 	for (i = 0; i < ITERS_PER_TEST; ++i) {
 		size_t size = prandom_u32_max(MAX_ENCODABLE_SIZE) + 1;
 		bool is_write = !!prandom_u32_max(2);
+		unsigned long verif_masked_addr;
+		long encoded_watchpoint;
+		bool verif_is_write;
 		unsigned long addr;
+		size_t verif_size;
 
 		prandom_bytes(&addr, sizeof(addr));
 		if (addr < PAGE_SIZE)
@@ -44,53 +48,37 @@ static bool test_encode_decode(void)
 		if (WARN_ON(!check_encodable(addr, size)))
 			return false;
 
-		/* Encode and decode */
-		{
-			const long encoded_watchpoint =
-				encode_watchpoint(addr, size, is_write);
-			unsigned long verif_masked_addr;
-			size_t verif_size;
-			bool verif_is_write;
-
-			/* Check special watchpoints */
-			if (WARN_ON(decode_watchpoint(
-				    INVALID_WATCHPOINT, &verif_masked_addr,
-				    &verif_size, &verif_is_write)))
-				return false;
-			if (WARN_ON(decode_watchpoint(
-				    CONSUMED_WATCHPOINT, &verif_masked_addr,
-				    &verif_size, &verif_is_write)))
-				return false;
-
-			/* Check decoding watchpoint returns same data */
-			if (WARN_ON(!decode_watchpoint(
-				    encoded_watchpoint, &verif_masked_addr,
-				    &verif_size, &verif_is_write)))
-				return false;
-			if (WARN_ON(verif_masked_addr !=
-				    (addr & WATCHPOINT_ADDR_MASK)))
-				goto fail;
-			if (WARN_ON(verif_size != size))
-				goto fail;
-			if (WARN_ON(is_write != verif_is_write))
-				goto fail;
-
-			continue;
-fail:
-			pr_err("%s fail: %s %zu bytes @ %lx -> encoded: %lx -> %s %zu bytes @ %lx\n",
-			       __func__, is_write ? "write" : "read", size,
-			       addr, encoded_watchpoint,
-			       verif_is_write ? "write" : "read", verif_size,
-			       verif_masked_addr);
+		encoded_watchpoint = encode_watchpoint(addr, size, is_write);
+
+		/* Check special watchpoints */
+		if (WARN_ON(decode_watchpoint(INVALID_WATCHPOINT, &verif_masked_addr, &verif_size, &verif_is_write)))
 			return false;
-		}
+		if (WARN_ON(decode_watchpoint(CONSUMED_WATCHPOINT, &verif_masked_addr, &verif_size, &verif_is_write)))
+			return false;
+
+		/* Check decoding watchpoint returns same data */
+		if (WARN_ON(!decode_watchpoint(encoded_watchpoint, &verif_masked_addr, &verif_size, &verif_is_write)))
+			return false;
+		if (WARN_ON(verif_masked_addr != (addr & WATCHPOINT_ADDR_MASK)))
+			goto fail;
+		if (WARN_ON(verif_size != size))
+			goto fail;
+		if (WARN_ON(is_write != verif_is_write))
+			goto fail;
+
+		continue;
+fail:
+		pr_err("%s fail: %s %zu bytes @ %lx -> encoded: %lx -> %s %zu bytes @ %lx\n",
+		       __func__, is_write ? "write" : "read", size, addr, encoded_watchpoint,
+		       verif_is_write ? "write" : "read", verif_size, verif_masked_addr);
+		return false;
 	}
 
 	return true;
 }
 
 /* Test access matching function. */
-static bool test_matching_access(void)
+static bool __init test_matching_access(void)
 {
 	if (WARN_ON(!matching_access(10, 1, 10, 1)))
 		return false;
-- 
2.31.1.189.g2e36527f23

