Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF14437B280
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 01:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbhEKXZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 19:25:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:52544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229994AbhEKXZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 19:25:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EA61E61288;
        Tue, 11 May 2021 23:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620775447;
        bh=+XXDUQSgM6zd6Dpxi3ONSqy1SgysxRa34Ip60zn8ANg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R0Lrq5exfMbh4R7dlnIi3HGM3iYn2GnRE9GYE83Zfi4oBnUqMgevtS6y+7572pvdt
         VbKqb8+BwQWEaUmlwjtOgl40/ojKKa0kOccAP23j8ekyiqrsLTT6rVEda8P1wKbevl
         Wq0qCeZAD7vHe9shGvlu/bmXeWczzKFW1a2n1PZXTkM18MDqItJBQp9CpKO2gatdBb
         boIxUUF/Kb1P0fRcNo7/qjGQFE8n/06593kQNvy0EdROOpgfs4OE6jhb6BHNAh0I2x
         lGkH+9Lv85hLOsVCKhdJocT6Lz1bnKCf3sAPlYNTGva96vpcDSTsvgMIYlaAdX8gcQ
         SaMOO7PMbjsPg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 9CB6A5C014E; Tue, 11 May 2021 16:24:06 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        Mark Rutland <mark.rutland@arm.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 02/10] kcsan: Simplify value change detection
Date:   Tue, 11 May 2021 16:23:53 -0700
Message-Id: <20210511232401.2896217-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210511231149.GA2895263@paulmck-ThinkPad-P17-Gen-1>
References: <20210511231149.GA2895263@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Rutland <mark.rutland@arm.com>

In kcsan_setup_watchpoint() we store snapshots of a watched value into a
union of u8/u16/u32/u64 sized fields, modify this in place using a
consistent field, then later check for any changes via the u64 field.

We can achieve the safe effect more simply by always treating the field
as a u64, as smaller values will be zero-extended. As the values are
zero-extended, we don't need to truncate the access_mask when we apply
it, and can always apply the full 64-bit access_mask to the 64-bit
value.

Finally, we can store the two snapshots and calculated difference
separately, which makes the code a little easier to read, and will
permit reporting the old/new values in subsequent patches.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/kcsan/core.c | 40 ++++++++++++++++------------------------
 1 file changed, 16 insertions(+), 24 deletions(-)

diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index 45c821d4e8bd..d360183002d6 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -407,12 +407,7 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 	const bool is_write = (type & KCSAN_ACCESS_WRITE) != 0;
 	const bool is_assert = (type & KCSAN_ACCESS_ASSERT) != 0;
 	atomic_long_t *watchpoint;
-	union {
-		u8 _1;
-		u16 _2;
-		u32 _4;
-		u64 _8;
-	} expect_value;
+	u64 old, new, diff;
 	unsigned long access_mask;
 	enum kcsan_value_change value_change = KCSAN_VALUE_CHANGE_MAYBE;
 	unsigned long ua_flags = user_access_save();
@@ -468,19 +463,19 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 	 * Read the current value, to later check and infer a race if the data
 	 * was modified via a non-instrumented access, e.g. from a device.
 	 */
-	expect_value._8 = 0;
+	old = 0;
 	switch (size) {
 	case 1:
-		expect_value._1 = READ_ONCE(*(const u8 *)ptr);
+		old = READ_ONCE(*(const u8 *)ptr);
 		break;
 	case 2:
-		expect_value._2 = READ_ONCE(*(const u16 *)ptr);
+		old = READ_ONCE(*(const u16 *)ptr);
 		break;
 	case 4:
-		expect_value._4 = READ_ONCE(*(const u32 *)ptr);
+		old = READ_ONCE(*(const u32 *)ptr);
 		break;
 	case 8:
-		expect_value._8 = READ_ONCE(*(const u64 *)ptr);
+		old = READ_ONCE(*(const u64 *)ptr);
 		break;
 	default:
 		break; /* ignore; we do not diff the values */
@@ -506,33 +501,30 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 	 * racy access.
 	 */
 	access_mask = get_ctx()->access_mask;
+	new = 0;
 	switch (size) {
 	case 1:
-		expect_value._1 ^= READ_ONCE(*(const u8 *)ptr);
-		if (access_mask)
-			expect_value._1 &= (u8)access_mask;
+		new = READ_ONCE(*(const u8 *)ptr);
 		break;
 	case 2:
-		expect_value._2 ^= READ_ONCE(*(const u16 *)ptr);
-		if (access_mask)
-			expect_value._2 &= (u16)access_mask;
+		new = READ_ONCE(*(const u16 *)ptr);
 		break;
 	case 4:
-		expect_value._4 ^= READ_ONCE(*(const u32 *)ptr);
-		if (access_mask)
-			expect_value._4 &= (u32)access_mask;
+		new = READ_ONCE(*(const u32 *)ptr);
 		break;
 	case 8:
-		expect_value._8 ^= READ_ONCE(*(const u64 *)ptr);
-		if (access_mask)
-			expect_value._8 &= (u64)access_mask;
+		new = READ_ONCE(*(const u64 *)ptr);
 		break;
 	default:
 		break; /* ignore; we do not diff the values */
 	}
 
+	diff = old ^ new;
+	if (access_mask)
+		diff &= access_mask;
+
 	/* Were we able to observe a value-change? */
-	if (expect_value._8 != 0)
+	if (diff != 0)
 		value_change = KCSAN_VALUE_CHANGE_TRUE;
 
 	/* Check if this access raced with another. */
-- 
2.31.1.189.g2e36527f23

