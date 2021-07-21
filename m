Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7513D18B3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 23:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbhGUU1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 16:27:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:35820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229535AbhGUU1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 16:27:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A2D97613E4;
        Wed, 21 Jul 2021 21:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626901694;
        bh=iOchJCD/NBpiRUmXfbuUZRyVhT8/pig0uAgZm8MIq34=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cx/40X+a4rGhW6+LdmeVunW/z+q7T5KBIhALZxk+aG5n8rcBwnmWIw4Pu+1Vb/0dE
         WErmL3FTEisaAJNZItjCyQcqtbBa2cUEwslgsrU2bW8gjr+zl7ieaQrxovfSQYyelf
         AGm7o95YsSuT/JMoO8IBgr3sEIWZLLQyS7J79plWdIQxh3EwqG1RKQ86MtQNyaUZls
         1/Iunfu4IR6BwhzWTvKjnVYxWfsZXdwyPMQa41ll6Di+ZMnXm7ubMIO5doFd4a5uld
         l8SiK4yfdwUhNbPXbatbbjFz3n3Pd+XWdHGCNRf9NGwpf8qBJrp4jhTSD4spe+hGsK
         uXWeo0CTdsf/Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 627CB5C0A2D; Wed, 21 Jul 2021 14:08:14 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        Mark Rutland <mark.rutland@arm.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH kcsan 4/8] kcsan: Reduce get_ctx() uses in kcsan_found_watchpoint()
Date:   Wed, 21 Jul 2021 14:08:08 -0700
Message-Id: <20210721210812.844740-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210721210726.GA828672@paulmck-ThinkPad-P17-Gen-1>
References: <20210721210726.GA828672@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Elver <elver@google.com>

There are a number get_ctx() calls that are close to each other, which
results in poor codegen (repeated preempt_count loads).

Specifically in kcsan_found_watchpoint() (even though it's a slow-path)
it is beneficial to keep the race-window small until the watchpoint has
actually been consumed to avoid missed opportunities to report a race.

Let's clean it up a bit before we add more code in
kcsan_found_watchpoint().

Signed-off-by: Marco Elver <elver@google.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/kcsan/core.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index d92977ede7e17..906100923b888 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -301,9 +301,9 @@ static inline void reset_kcsan_skip(void)
 	this_cpu_write(kcsan_skip, skip_count);
 }
 
-static __always_inline bool kcsan_is_enabled(void)
+static __always_inline bool kcsan_is_enabled(struct kcsan_ctx *ctx)
 {
-	return READ_ONCE(kcsan_enabled) && get_ctx()->disable_count == 0;
+	return READ_ONCE(kcsan_enabled) && !ctx->disable_count;
 }
 
 /* Introduce delay depending on context and configuration. */
@@ -353,10 +353,17 @@ static noinline void kcsan_found_watchpoint(const volatile void *ptr,
 					    atomic_long_t *watchpoint,
 					    long encoded_watchpoint)
 {
+	struct kcsan_ctx *ctx = get_ctx();
 	unsigned long flags;
 	bool consumed;
 
-	if (!kcsan_is_enabled())
+	/*
+	 * We know a watchpoint exists. Let's try to keep the race-window
+	 * between here and finally consuming the watchpoint below as small as
+	 * possible -- avoid unneccessarily complex code until consumed.
+	 */
+
+	if (!kcsan_is_enabled(ctx))
 		return;
 
 	/*
@@ -364,14 +371,12 @@ static noinline void kcsan_found_watchpoint(const volatile void *ptr,
 	 * reporting a race where e.g. the writer set up the watchpoint, but the
 	 * reader has access_mask!=0, we have to ignore the found watchpoint.
 	 */
-	if (get_ctx()->access_mask != 0)
+	if (ctx->access_mask)
 		return;
 
 	/*
-	 * Consume the watchpoint as soon as possible, to minimize the chances
-	 * of !consumed. Consuming the watchpoint must always be guarded by
-	 * kcsan_is_enabled() check, as otherwise we might erroneously
-	 * triggering reports when disabled.
+	 * Consuming the watchpoint must be guarded by kcsan_is_enabled() to
+	 * avoid erroneously triggering reports if the context is disabled.
 	 */
 	consumed = try_consume_watchpoint(watchpoint, encoded_watchpoint);
 
@@ -409,6 +414,7 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 	unsigned long access_mask;
 	enum kcsan_value_change value_change = KCSAN_VALUE_CHANGE_MAYBE;
 	unsigned long ua_flags = user_access_save();
+	struct kcsan_ctx *ctx = get_ctx();
 	unsigned long irq_flags = 0;
 
 	/*
@@ -417,7 +423,7 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 	 */
 	reset_kcsan_skip();
 
-	if (!kcsan_is_enabled())
+	if (!kcsan_is_enabled(ctx))
 		goto out;
 
 	/*
@@ -489,7 +495,7 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 	 * Re-read value, and check if it is as expected; if not, we infer a
 	 * racy access.
 	 */
-	access_mask = get_ctx()->access_mask;
+	access_mask = ctx->access_mask;
 	new = 0;
 	switch (size) {
 	case 1:
-- 
2.31.1.189.g2e36527f23

