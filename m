Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ACC840D0EB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 02:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233751AbhIPAdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 20:33:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:35318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233600AbhIPAdH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 20:33:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E03AB611C1;
        Thu, 16 Sep 2021 00:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631752308;
        bh=1LR6DeJKbN72Ksu5xvYOrWAH0N/XPjw8lwG71q0LTEI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DFYIMOmQudAxFPpLJS6jBGHKWRi/4BWULTYmGfG042yooVl6+GAj4SF/Jfg5e6eXQ
         X2Lr3SU9KABd5alBqZvaaZQ9JBoby+vA+ZQrDIpKFQ6QRpT4ow+6/Qfhh/ampABvK7
         AYOXIQwBXDjVd8z+bynbQ/yZkAhIBY99ZijY3j7oZF1UA6LnwlODM1ImP4WgUhN/D2
         aEoV4kCV6ABLXW08gcFgdeJ7Er+cNRHhjyLt0snNXozVVgXMAOEfRhCNe6rxmKiYnj
         L4VUw95blxXSzoEViK7ragrP7Ffzbx7VObOMWTsjBJ75EqAZ1VBe2+76Q1sBZKlxv5
         BFzlX1kFO1NTA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B44265C0926; Wed, 15 Sep 2021 17:31:47 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH kcsan 5/9] kcsan: Save instruction pointer for scoped accesses
Date:   Wed, 15 Sep 2021 17:31:42 -0700
Message-Id: <20210916003146.3910358-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210916003126.GA3910257@paulmck-ThinkPad-P17-Gen-1>
References: <20210916003126.GA3910257@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Elver <elver@google.com>

Save the instruction pointer for scoped accesses, so that it becomes
possible for the reporting code to construct more accurate stack traces
that will show the start of the scope.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/kcsan-checks.h |  3 +++
 kernel/kcsan/core.c          | 12 +++++++++---
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/include/linux/kcsan-checks.h b/include/linux/kcsan-checks.h
index 9fd0ad80fef6..5f5965246877 100644
--- a/include/linux/kcsan-checks.h
+++ b/include/linux/kcsan-checks.h
@@ -100,9 +100,12 @@ void kcsan_set_access_mask(unsigned long mask);
 /* Scoped access information. */
 struct kcsan_scoped_access {
 	struct list_head list;
+	/* Access information. */
 	const volatile void *ptr;
 	size_t size;
 	int type;
+	/* Location where scoped access was set up. */
+	unsigned long ip;
 };
 /*
  * Automatically call kcsan_end_scoped_access() when kcsan_scoped_access goes
diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index bffd1d95addb..8b20af541776 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -202,6 +202,9 @@ static __always_inline struct kcsan_ctx *get_ctx(void)
 	return in_task() ? &current->kcsan_ctx : raw_cpu_ptr(&kcsan_cpu_ctx);
 }
 
+static __always_inline void
+check_access(const volatile void *ptr, size_t size, int type, unsigned long ip);
+
 /* Check scoped accesses; never inline because this is a slow-path! */
 static noinline void kcsan_check_scoped_accesses(void)
 {
@@ -210,8 +213,10 @@ static noinline void kcsan_check_scoped_accesses(void)
 	struct kcsan_scoped_access *scoped_access;
 
 	ctx->scoped_accesses.prev = NULL;  /* Avoid recursion. */
-	list_for_each_entry(scoped_access, &ctx->scoped_accesses, list)
-		__kcsan_check_access(scoped_access->ptr, scoped_access->size, scoped_access->type);
+	list_for_each_entry(scoped_access, &ctx->scoped_accesses, list) {
+		check_access(scoped_access->ptr, scoped_access->size,
+			     scoped_access->type, scoped_access->ip);
+	}
 	ctx->scoped_accesses.prev = prev_save;
 }
 
@@ -767,6 +772,7 @@ kcsan_begin_scoped_access(const volatile void *ptr, size_t size, int type,
 	sa->ptr = ptr;
 	sa->size = size;
 	sa->type = type;
+	sa->ip = _RET_IP_;
 
 	if (!ctx->scoped_accesses.prev) /* Lazy initialize list head. */
 		INIT_LIST_HEAD(&ctx->scoped_accesses);
@@ -798,7 +804,7 @@ void kcsan_end_scoped_access(struct kcsan_scoped_access *sa)
 
 	ctx->disable_count--;
 
-	__kcsan_check_access(sa->ptr, sa->size, sa->type);
+	check_access(sa->ptr, sa->size, sa->type, sa->ip);
 }
 EXPORT_SYMBOL(kcsan_end_scoped_access);
 
-- 
2.31.1.189.g2e36527f23

