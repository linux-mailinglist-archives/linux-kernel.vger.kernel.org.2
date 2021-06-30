Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9C7F3B8667
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 17:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235845AbhF3Poo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 11:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235565AbhF3Pom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 11:44:42 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB1AC061756
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 08:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=0ZQW9RmJYoJQ9offoDck8WWZVpIsVVWht51pM8dPL/Y=; b=qfwEiDBYC6Obk23wiAiKHI/sSx
        0seuIR+cgqVoHNd2vhRBnKiEanEuI/xaj5bTSY35GA3iUuLGE1qMKCA8OUaPDC4tPQe4eWA3fixsQ
        IGDGz1Ojze9j/EZVnPKO68mnRGKuTGq9hZGAWenElpf7EgsvPj30y1t525PmzTpZq27EcF+qSv6bf
        OliCKL0yuYNSyE9DqA4qh5c1kvc6PRujC10FN1HGjJUnVyU6Zn+s9EHZBUfaLu0iQKGocc/RVSukx
        RXPrwvKuG/QClmZT17MK6214S7B3G8vAOi8rnzOMIrERppPx2OFea1E0QN3qT01NXjtcSbdgJhuqW
        S/+7C7Iw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lycLo-00DD5b-9B; Wed, 30 Jun 2021 15:42:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4F5E93002EC;
        Wed, 30 Jun 2021 17:42:06 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 373BE2C66CADD; Wed, 30 Jun 2021 17:42:06 +0200 (CEST)
Message-ID: <20210630154114.958507900@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 30 Jun 2021 17:35:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@redhat.com, longman@redhat.com, boqun.feng@gmail.com,
        will@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        yanfei.xu@windriver.com
Subject: [RFC][PATCH 3/4] locking/mutex: Introduce __mutex_trylock_or_handoff()
References: <20210630153516.832731403@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yanfei reported that it is possible to loose HANDOFF when we race with
mutex_unlock() and end up setting HANDOFF on an unlocked mutex. At
that point anybody can steal it, loosing HANDOFF in the process.

If this happens often enough, we can in fact starve the top waiter.

Solve this by folding the 'set HANDOFF' operation into the trylock
operation, such that either we acquire the lock, or it gets HANDOFF
set. This avoids having HANDOFF set on an unlocked mutex.

Reported-by: Yanfei Xu <yanfei.xu@windriver.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/locking/mutex.c |   58 +++++++++++++++++++++++++++++--------------------
 1 file changed, 35 insertions(+), 23 deletions(-)

--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -91,10 +91,7 @@ static inline unsigned long __owner_flag
 	return owner & MUTEX_FLAGS;
 }
 
-/*
- * Trylock variant that returns the owning task on failure.
- */
-static inline struct task_struct *__mutex_trylock_or_owner(struct mutex *lock)
+static inline struct task_struct *__mutex_trylock_common(struct mutex *lock, bool handoff)
 {
 	unsigned long owner, curr = (unsigned long)current;
 
@@ -104,39 +101,56 @@ static inline struct task_struct *__mute
 		unsigned long task = owner & ~MUTEX_FLAGS;
 
 		if (task) {
-			if (likely(task != curr))
+			if (flags & MUTEX_FLAG_PICKUP) {
+				if (task != curr)
+					break;
+				flags &= ~MUTEX_FLAG_HANDOFF;
+			} else if (handoff) {
+				if (flags & MUTEX_FLAG_HANDOFF)
+					break;
+				flags |= MUTEX_FLAG_HANDOFF;
+			} else {
 				break;
-
-			if (likely(!(flags & MUTEX_FLAG_PICKUP)))
-				break;
-
-			flags &= ~MUTEX_FLAG_PICKUP;
+			}
 		} else {
 #ifdef CONFIG_DEBUG_MUTEXES
 			DEBUG_LOCKS_WARN_ON(flags & MUTEX_FLAG_PICKUP);
 #endif
+			task = curr;
 		}
 
-		/*
-		 * We set the HANDOFF bit, we must make sure it doesn't live
-		 * past the point where we acquire it. This would be possible
-		 * if we (accidentally) set the bit on an unlocked mutex.
-		 */
-		flags &= ~MUTEX_FLAG_HANDOFF;
-
-		if (atomic_long_try_cmpxchg_acquire(&lock->owner, &owner, curr | flags))
-			return NULL;
+		if (atomic_long_try_cmpxchg_acquire(&lock->owner, &owner, task | flags)) {
+			if (task == curr)
+				return NULL;
+			break;
+		}
 	}
 
 	return __owner_task(owner);
 }
 
 /*
+ * Trylock or set HANDOFF
+ */
+static inline bool __mutex_trylock_or_handoff(struct mutex *lock, bool handoff)
+{
+	return !__mutex_trylock_common(lock, handoff);
+}
+
+/*
+ * Trylock variant that returns the owning task on failure.
+ */
+static inline struct task_struct *__mutex_trylock_or_owner(struct mutex *lock)
+{
+	return __mutex_trylock_common(lock, false);
+}
+
+/*
  * Actual trylock that will work on any unlocked state.
  */
 static inline bool __mutex_trylock(struct mutex *lock)
 {
-	return !__mutex_trylock_or_owner(lock);
+	return !__mutex_trylock_common(lock, false);
 }
 
 #ifndef CONFIG_DEBUG_LOCK_ALLOC
@@ -1028,8 +1042,6 @@ __mutex_lock_common(struct mutex *lock,
 		schedule_preempt_disabled();
 
 		first = __mutex_waiter_is_first(lock, &waiter);
-		if (first)
-			__mutex_set_flag(lock, MUTEX_FLAG_HANDOFF);
 
 		set_current_state(state);
 		/*
@@ -1037,7 +1049,7 @@ __mutex_lock_common(struct mutex *lock,
 		 * state back to RUNNING and fall through the next schedule(),
 		 * or we must see its unlock and acquire.
 		 */
-		if (__mutex_trylock(lock) ||
+		if (__mutex_trylock_or_handoff(lock, first) ||
 		    (first && mutex_optimistic_spin(lock, ww_ctx, &waiter)))
 			break;
 


