Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBF6740D0EF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 02:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233892AbhIPAdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 20:33:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:35428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233592AbhIPAdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 20:33:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2188E6120E;
        Thu, 16 Sep 2021 00:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631752308;
        bh=lbZh6wT0Y4xOOzCKb35GZNRZtlMAm95k2sJ54b7w2/E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P2EtT6TzHxasO8ctFVLWk+7dUU1JV+VqRA/Z61AwieFRT1EJgV/w5tGEUQznbmBt/
         SrTpf0wm3yNC4lw6iajjJgcXgjl2Mi0mHES0xuTDFX/ij1S+fVs+os8p030TnOBjab
         4iqx/qOS4nPe+4CWoJHcPF5s0Tl1Ewrr9lYMS2T8MCUFsAYbTo+tYY859xKDOJkU2k
         rVUAUJcunBiufyRTO3ipT7dsJUm/Eqt0j+/JaeJX3TZp8a/C0fQ3VG3qt/qKipSO10
         LCc3hlKA9F6jdndimLihu5iWHry8ANzOV5JwvBYtxZRCabGa7Ev88/1yFjq/6s5miI
         G0LT2WYYcnKWw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B9B785C0AD4; Wed, 15 Sep 2021 17:31:47 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH kcsan 8/9] kcsan: Move ctx to start of argument list
Date:   Wed, 15 Sep 2021 17:31:45 -0700
Message-Id: <20210916003146.3910358-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210916003126.GA3910257@paulmck-ThinkPad-P17-Gen-1>
References: <20210916003126.GA3910257@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Elver <elver@google.com>

It is clearer if ctx is at the start of the function argument list;
it'll be more consistent when adding functions with varying arguments
but all requiring ctx.

No functional change intended.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/kcsan/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index 8b20af541776..4b84c8e7884b 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -222,7 +222,7 @@ static noinline void kcsan_check_scoped_accesses(void)
 
 /* Rules for generic atomic accesses. Called from fast-path. */
 static __always_inline bool
-is_atomic(const volatile void *ptr, size_t size, int type, struct kcsan_ctx *ctx)
+is_atomic(struct kcsan_ctx *ctx, const volatile void *ptr, size_t size, int type)
 {
 	if (type & KCSAN_ACCESS_ATOMIC)
 		return true;
@@ -259,7 +259,7 @@ is_atomic(const volatile void *ptr, size_t size, int type, struct kcsan_ctx *ctx
 }
 
 static __always_inline bool
-should_watch(const volatile void *ptr, size_t size, int type, struct kcsan_ctx *ctx)
+should_watch(struct kcsan_ctx *ctx, const volatile void *ptr, size_t size, int type)
 {
 	/*
 	 * Never set up watchpoints when memory operations are atomic.
@@ -268,7 +268,7 @@ should_watch(const volatile void *ptr, size_t size, int type, struct kcsan_ctx *
 	 * should not count towards skipped instructions, and (2) to actually
 	 * decrement kcsan_atomic_next for consecutive instruction stream.
 	 */
-	if (is_atomic(ptr, size, type, ctx))
+	if (is_atomic(ctx, ptr, size, type))
 		return false;
 
 	if (this_cpu_dec_return(kcsan_skip) >= 0)
@@ -637,7 +637,7 @@ check_access(const volatile void *ptr, size_t size, int type, unsigned long ip)
 	else {
 		struct kcsan_ctx *ctx = get_ctx(); /* Call only once in fast-path. */
 
-		if (unlikely(should_watch(ptr, size, type, ctx)))
+		if (unlikely(should_watch(ctx, ptr, size, type)))
 			kcsan_setup_watchpoint(ptr, size, type, ip);
 		else if (unlikely(ctx->scoped_accesses.prev))
 			kcsan_check_scoped_accesses();
-- 
2.31.1.189.g2e36527f23

