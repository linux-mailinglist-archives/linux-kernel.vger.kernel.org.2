Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1553D3B80C5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 12:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234111AbhF3KYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 06:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbhF3KYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 06:24:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF8CC061756
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 03:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RzHMjvvEyN0rvuw1i76cbiN/8lpVMpbe6dkowiHqxQc=; b=WCdIBPgXp42HszgyF7ud/Ae0cz
        Ev2hfHhZChIwJ9gPgEhSVzUGq1fz+KRevszAqWM2ue4lQAuDfY5qJo6LZr2B0wSTpam6Qa8umU0Cn
        bWVaDvu4qjEtAVueC2eZ/MsdNWRksxygKaoGYzyTi7lPwZOL/d2B1YAK3YW2qabbd0omIzzE9eJpV
        Hcdbdi8GumlkOW56aJOnwdhuMbdgfxrGX9TDUNJ2USIYmSlR2puaFjBOEza4yVn/jFVuKBvbHivzi
        jtMr1iqGWCKQuKhGTygvRsrtLLz8uoh6QFmpweKa9w1kNewAIwWkXrA/5DfmQQAuUYRnEnhNtGSbZ
        uKoa7nVw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lyXLA-005DMZ-2e; Wed, 30 Jun 2021 10:21:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 00CA6300242;
        Wed, 30 Jun 2021 12:21:04 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D42A520412F60; Wed, 30 Jun 2021 12:21:04 +0200 (CEST)
Date:   Wed, 30 Jun 2021 12:21:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org,
        "Xu, Yanfei" <yanfei.xu@windriver.com>
Subject: Re: [PATCH] locking/mutex: Reduce chance of setting HANDOFF bit on
 unlocked mutex
Message-ID: <YNxFkD8qzex9MvQp@hirez.programming.kicks-ass.net>
References: <20210629201138.31507-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210629201138.31507-1-longman@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 29, 2021 at 04:11:38PM -0400, Waiman Long wrote:

> diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
> index d2df5e68b503..472ab21b5b8e 100644
> --- a/kernel/locking/mutex.c
> +++ b/kernel/locking/mutex.c
> @@ -118,9 +118,9 @@ static inline struct task_struct *__mutex_trylock_or_owner(struct mutex *lock)
>  		}
>  
>  		/*
> -		 * We set the HANDOFF bit, we must make sure it doesn't live
> -		 * past the point where we acquire it. This would be possible
> -		 * if we (accidentally) set the bit on an unlocked mutex.
> +		 * Always clear the HANDOFF bit before acquiring the lock.
> +		 * Note that if the bit is accidentally set on an unlocked
> +		 * mutex, anyone can acquire it.
>  		 */
>  		flags &= ~MUTEX_FLAG_HANDOFF;
>  
> @@ -180,6 +180,11 @@ static inline void __mutex_set_flag(struct mutex *lock, unsigned long flag)
>  	atomic_long_or(flag, &lock->owner);
>  }
>  
> +static inline long __mutex_fetch_set_flag(struct mutex *lock, unsigned long flag)
> +{
> +	return atomic_long_fetch_or_relaxed(flag, &lock->owner);
> +}
> +
>  static inline void __mutex_clear_flag(struct mutex *lock, unsigned long flag)
>  {

Hurmph, so we already have a cmpxchg loop in trylock, might as well make
that do exactly what we want without holes on.

How's something like the below? Boot tested, but please verify.

---
 kernel/locking/mutex.c | 89 ++++++++++++++++++++++++++------------------------
 1 file changed, 46 insertions(+), 43 deletions(-)

diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index d2df5e68b503..53f7fcadce85 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -91,44 +91,54 @@ static inline unsigned long __owner_flags(unsigned long owner)
 	return owner & MUTEX_FLAGS;
 }
 
+#ifdef CONFIG_DEBUG_MUTEXES
+#define MUTEX_WARN_ON(cond) DEBUG_LOCKS_WARN_ON(cond)
+#else
+#define MUTEX_WARN_ON(cond)
+#endif
+
 /*
  * Trylock variant that returns the owning task on failure.
  */
-static inline struct task_struct *__mutex_trylock_or_owner(struct mutex *lock)
+static inline struct task_struct *__mutex_trylock_or_owner(struct mutex *lock, bool handoff)
 {
 	unsigned long owner, curr = (unsigned long)current;
 
 	owner = atomic_long_read(&lock->owner);
 	for (;;) { /* must loop, can race against a flag */
-		unsigned long old, flags = __owner_flags(owner);
+		unsigned long flags = __owner_flags(owner);
 		unsigned long task = owner & ~MUTEX_FLAGS;
 
 		if (task) {
-			if (likely(task != curr))
-				break;
+			if (flags & MUTEX_FLAG_PICKUP) {
 
-			if (likely(!(flags & MUTEX_FLAG_PICKUP)))
-				break;
+				if (task != curr)
+					break;
+
+				flags &= ~MUTEX_FLAG_PICKUP;
+
+			} else if (handoff) {
 
-			flags &= ~MUTEX_FLAG_PICKUP;
+				if (flags & MUTEX_FLAG_HANDOFF)
+					break;
+
+				flags |= MUTEX_FLAG_HANDOFF;
+
+			} else {
+
+				break;
+			}
 		} else {
-#ifdef CONFIG_DEBUG_MUTEXES
-			DEBUG_LOCKS_WARN_ON(flags & MUTEX_FLAG_PICKUP);
-#endif
+			MUTEX_WARN_ON(flags & (MUTEX_FLAG_HANDOFF | MUTEX_FLAG_PICKUP));
+			task = curr;
 		}
 
-		/*
-		 * We set the HANDOFF bit, we must make sure it doesn't live
-		 * past the point where we acquire it. This would be possible
-		 * if we (accidentally) set the bit on an unlocked mutex.
-		 */
-		flags &= ~MUTEX_FLAG_HANDOFF;
+		if (atomic_long_try_cmpxchg_acquire(&lock->owner, &owner, task | flags)) {
+			if (task == curr)
+				return NULL;
 
-		old = atomic_long_cmpxchg_acquire(&lock->owner, owner, curr | flags);
-		if (old == owner)
-			return NULL;
-
-		owner = old;
+			break;
+		}
 	}
 
 	return __owner_task(owner);
@@ -139,7 +149,7 @@ static inline struct task_struct *__mutex_trylock_or_owner(struct mutex *lock)
  */
 static inline bool __mutex_trylock(struct mutex *lock)
 {
-	return !__mutex_trylock_or_owner(lock);
+	return !__mutex_trylock_or_owner(lock, false);
 }
 
 #ifndef CONFIG_DEBUG_LOCK_ALLOC
@@ -226,7 +236,7 @@ static void __mutex_handoff(struct mutex *lock, struct task_struct *task)
 	unsigned long owner = atomic_long_read(&lock->owner);
 
 	for (;;) {
-		unsigned long old, new;
+		unsigned long new;
 
 #ifdef CONFIG_DEBUG_MUTEXES
 		DEBUG_LOCKS_WARN_ON(__owner_task(owner) != current);
@@ -238,11 +248,8 @@ static void __mutex_handoff(struct mutex *lock, struct task_struct *task)
 		if (task)
 			new |= MUTEX_FLAG_PICKUP;
 
-		old = atomic_long_cmpxchg_release(&lock->owner, owner, new);
-		if (old == owner)
+		if (atomic_long_try_cmpxchg_release(&lock->owner, &owner, new))
 			break;
-
-		owner = old;
 	}
 }
 
@@ -662,7 +669,7 @@ mutex_optimistic_spin(struct mutex *lock, struct ww_acquire_ctx *ww_ctx,
 		struct task_struct *owner;
 
 		/* Try to acquire the mutex... */
-		owner = __mutex_trylock_or_owner(lock);
+		owner = __mutex_trylock_or_owner(lock, false);
 		if (!owner)
 			break;
 
@@ -928,7 +935,6 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 		    struct ww_acquire_ctx *ww_ctx, const bool use_ww_ctx)
 {
 	struct mutex_waiter waiter;
-	bool first = false;
 	struct ww_mutex *ww;
 	int ret;
 
@@ -1007,6 +1013,8 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 
 	set_current_state(state);
 	for (;;) {
+		bool first;
+
 		/*
 		 * Once we hold wait_lock, we're serialized against
 		 * mutex_unlock() handing the lock off to us, do a trylock
@@ -1035,23 +1043,18 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 		spin_unlock(&lock->wait_lock);
 		schedule_preempt_disabled();
 
-		/*
-		 * ww_mutex needs to always recheck its position since its waiter
-		 * list is not FIFO ordered.
-		 */
-		if (ww_ctx || !first) {
-			first = __mutex_waiter_is_first(lock, &waiter);
-			if (first)
-				__mutex_set_flag(lock, MUTEX_FLAG_HANDOFF);
-		}
-
 		set_current_state(state);
+
+		first = __mutex_waiter_is_first(lock, &waiter);
+
 		/*
-		 * Here we order against unlock; we must either see it change
-		 * state back to RUNNING and fall through the next schedule(),
-		 * or we must see its unlock and acquire.
+		 * We got woken up, see if we can acquire the mutex now. If
+		 * not, and we're the first waiter, make sure to mark the mutex
+		 * for HANDOFF to avoid starvation.
+		 *
+		 * XXX spin-wait vs sigpending
 		 */
-		if (__mutex_trylock(lock) ||
+		if (!__mutex_trylock_or_owner(lock, first) ||
 		    (first && mutex_optimistic_spin(lock, ww_ctx, &waiter)))
 			break;
 
