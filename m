Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21D843DD617
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 14:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233788AbhHBM4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 08:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233703AbhHBM4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 08:56:49 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4387C06175F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 05:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Z7zapoqGLH2oFmccAqJHnz47hdvnB+uMaUVb/e6ry+w=; b=D9r+iXrSiZuqB3H1jj89rICtf0
        hlGEp13m9UFtljg8i3DpJ3nBRtDrZ50KpHKsJHvZa+7JIxg26gWOkgalbUwCQqp43NAhJ71auGIh9
        Frjc3chaDCtrLw8ydB0YPbqsyE7XWubJKh3cweRwWxMJZOUPqcLHLDJyayDquxygqP9uu0iiku2Tb
        e+gH5Xh2gzQu5pxyBIuGqPMBlRz18/7JUnaqEhIHbOVbgbkx/KLsCGPR7XrsUqIvEt0beXqxlPyHh
        cj+JeJDzhWSBpylRxFsGFj8Xv8U2BLAXuuTS/gCqOJcBuLveVhgU27IIvzEDzUaLZPQN8L1DR4U9w
        EriXXnDA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mAXUL-0059rJ-6B; Mon, 02 Aug 2021 12:56:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A2DE230027E;
        Mon,  2 Aug 2021 14:56:09 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8D74F2CC6DE9A; Mon,  2 Aug 2021 14:56:09 +0200 (CEST)
Date:   Mon, 2 Aug 2021 14:56:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [patch 58/63] futex: Prevent requeue_pi() lock nesting issue on
 RT
Message-ID: <YQfraWyUYKtWgsQF@hirez.programming.kicks-ass.net>
References: <20210730135007.155909613@linutronix.de>
 <20210730135208.418508738@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210730135208.418508738@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2021 at 03:51:05PM +0200, Thomas Gleixner wrote:
> +static inline bool futex_requeue_pi_prepare(struct futex_q *q,
> +					    struct futex_pi_state *pi_state)
> +{
> +	int cur, res, new;
> +
> +	/*
> +	 * Set state to Q_REQUEUE_PI_IN_PROGRESS unless an early wakeup has
> +	 * already set Q_REQUEUE_PI_IGNORE to signal that requeue should
> +	 * ignore the waiter.
> +	 */
> +	for (cur = atomic_read(&q->requeue_state);; cur = res) {
> +		if (cur == Q_REQUEUE_PI_IGNORE)
> +			return false;
> +
> +		/*
> +		 * futex_proxy_trylock_atomic() might have set it to
> +		 * IN_PROGRESS and a interleaved early wake to WAIT.
> +		 *
> +		 * It was considered to have an extra state for that
> +		 * trylock, but that would just add more conditionals
> +		 * all over the place for a dubious value.
> +		 */
> +		if (cur != Q_REQUEUE_PI_NONE)
> +			break;
> +
> +		new = Q_REQUEUE_PI_IN_PROGRESS;
> +		res = atomic_cmpxchg(&q->requeue_state, cur, new);
> +		if (likely(cur == res))
> +			break;
> +	}
> +	q->pi_state = pi_state;
> +	return true;
> +}
> +
> +static inline void futex_requeue_pi_complete(struct futex_q *q, int locked)
> +{
> +	int cur, res, new;
> +
> +	for (cur = atomic_read(&q->requeue_state);; cur = res) {
> +		if (locked >= 0) {
> +			/* Requeue succeeded. Set DONE or LOCKED */
> +			new = Q_REQUEUE_PI_DONE + locked;
> +		} else if (cur == Q_REQUEUE_PI_IN_PROGRESS) {
> +			/* Deadlock, no early wakeup interleave */
> +			new = Q_REQUEUE_PI_NONE;
> +		} else {
> +			/* Deadlock, early wakeup interleave. */
> +			new = Q_REQUEUE_PI_IGNORE;
> +		}
> +
> +		res = atomic_cmpxchg(&q->requeue_state, cur, new);
> +		if (likely(cur == res))
> +			break;
> +	}
> +
> +#ifdef CONFIG_PREEMPT_RT
> +	/* If the waiter interleaved with the requeue let it know */
> +	if (unlikely(cur == Q_REQUEUE_PI_WAIT))
> +		rcuwait_wake_up(&q->requeue_wait);
> +#endif
> +}
> +
> +static inline int futex_requeue_pi_wakeup_sync(struct futex_q *q)
> +{
> +	int cur, new, res;
> +
> +	for (cur = atomic_read(&q->requeue_state);; cur = res) {
> +		/* Is requeue done already? */
> +		if (cur >= Q_REQUEUE_PI_DONE)
> +			break;
> +
> +		/*
> +		 * If not done, then tell the requeue code to either ignore
> +		 * the waiter or to wake it up once the requeue is done.
> +		 */
> +		new = !cur ? Q_REQUEUE_PI_IGNORE : Q_REQUEUE_PI_WAIT;
> +		res = atomic_cmpxchg(&q->requeue_state, cur, new);
> +		if (likely(cur == res))
> +			break;
> +	}
> +
> +	/* If the requeue was in progress, wait for it to complete */
> +	if (cur == Q_REQUEUE_PI_IN_PROGRESS) {
> +#ifdef CONFIG_PREEMPT_RT
> +		rcuwait_wait_event(&q->requeue_wait,
> +				   atomic_read(&q->requeue_state) != Q_REQUEUE_PI_WAIT,
> +				   TASK_UNINTERRUPTIBLE);
> +#else
> +		while (atomic_read(&q->requeue_state) == Q_REQUEUE_PI_WAIT)
> +			cpu_relax();
> +#endif
> +	}
> +
> +	/*
> +	 * Requeue is now either prohibited or complete. Reread state
> +	 * because during the wait above it might have changed. Nothing
> +	 * will modify q->requeue_state after this point.
> +	 */
> +	return atomic_read(&q->requeue_state);
> +}

I did:

 - atomic_cmpxchg() -> atomic_try_cmpxchg()
 - atomic_read() -> atomic_read_acquire(); which I think is required for
   at least the futex_requeue_pi_wakeup_sync() >= Q_REQUEUE_PI_DONE case
   to ensure we observe the state as per whoever set DONE/LOCKED.
 - use atomic_cond_read_relaxed()
 - removed one ternary operator for (IMO) clearer code.

--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1853,15 +1853,16 @@ enum {
 static inline bool futex_requeue_pi_prepare(struct futex_q *q,
 					    struct futex_pi_state *pi_state)
 {
-	int cur, res, new;
+	int old, new;
 
 	/*
 	 * Set state to Q_REQUEUE_PI_IN_PROGRESS unless an early wakeup has
 	 * already set Q_REQUEUE_PI_IGNORE to signal that requeue should
 	 * ignore the waiter.
 	 */
-	for (cur = atomic_read(&q->requeue_state);; cur = res) {
-		if (cur == Q_REQUEUE_PI_IGNORE)
+	old = atomic_read_acquire(&q->requeue_state);
+	do {
+		if (old == Q_REQUEUE_PI_IGNORE)
 			return false;
 
 		/*
@@ -1872,74 +1873,68 @@ static inline bool futex_requeue_pi_prep
 		 * trylock, but that would just add more conditionals
 		 * all over the place for a dubious value.
 		 */
-		if (cur != Q_REQUEUE_PI_NONE)
+		if (old != Q_REQUEUE_PI_NONE)
 			break;
 
 		new = Q_REQUEUE_PI_IN_PROGRESS;
-		res = atomic_cmpxchg(&q->requeue_state, cur, new);
-		if (likely(cur == res))
-			break;
-	}
+	} while (!atomic_try_cmpxchg(&q->requeue_state, &old, new));
+
 	q->pi_state = pi_state;
 	return true;
 }
 
 static inline void futex_requeue_pi_complete(struct futex_q *q, int locked)
 {
-	int cur, res, new;
+	int old, new;
 
-	for (cur = atomic_read(&q->requeue_state);; cur = res) {
+	old = atomic_read_acquire(&q->requeue_state);
+	do {
 		if (locked >= 0) {
 			/* Requeue succeeded. Set DONE or LOCKED */
 			new = Q_REQUEUE_PI_DONE + locked;
-		} else if (cur == Q_REQUEUE_PI_IN_PROGRESS) {
+		} else if (old == Q_REQUEUE_PI_IN_PROGRESS) {
 			/* Deadlock, no early wakeup interleave */
 			new = Q_REQUEUE_PI_NONE;
 		} else {
 			/* Deadlock, early wakeup interleave. */
 			new = Q_REQUEUE_PI_IGNORE;
 		}
-
-		res = atomic_cmpxchg(&q->requeue_state, cur, new);
-		if (likely(cur == res))
-			break;
-	}
+	} while (!atomic_try_cmpxchg(&q->requeue_state, &old, new));
 
 #ifdef CONFIG_PREEMPT_RT
 	/* If the waiter interleaved with the requeue let it know */
-	if (unlikely(cur == Q_REQUEUE_PI_WAIT))
+	if (unlikely(old == Q_REQUEUE_PI_WAIT))
 		rcuwait_wake_up(&q->requeue_wait);
 #endif
 }
 
 static inline int futex_requeue_pi_wakeup_sync(struct futex_q *q)
 {
-	int cur, new, res;
+	int old, new;
 
-	for (cur = atomic_read(&q->requeue_state);; cur = res) {
+	old = atomic_read_acquire(&q->requeue_state);
+	do {
 		/* Is requeue done already? */
-		if (cur >= Q_REQUEUE_PI_DONE)
+		if (old >= Q_REQUEUE_PI_DONE)
 			break;
 
 		/*
 		 * If not done, then tell the requeue code to either ignore
 		 * the waiter or to wake it up once the requeue is done.
 		 */
-		new = !cur ? Q_REQUEUE_PI_IGNORE : Q_REQUEUE_PI_WAIT;
-		res = atomic_cmpxchg(&q->requeue_state, cur, new);
-		if (likely(cur == res))
-			break;
-	}
+		new = Q_REQUEUE_PI_WAIT;
+		if (old == Q_REQUEUE_PI_NONE)
+			new = Q_REQUEUE_PI_IGNORE;
+	} while (!atomic_try_cmpxchg(&q->requeue_state, &old, new));
 
 	/* If the requeue was in progress, wait for it to complete */
-	if (cur == Q_REQUEUE_PI_IN_PROGRESS) {
+	if (old == Q_REQUEUE_PI_IN_PROGRESS) {
 #ifdef CONFIG_PREEMPT_RT
 		rcuwait_wait_event(&q->requeue_wait,
 				   atomic_read(&q->requeue_state) != Q_REQUEUE_PI_WAIT,
 				   TASK_UNINTERRUPTIBLE);
 #else
-		while (atomic_read(&q->requeue_state) == Q_REQUEUE_PI_WAIT)
-			cpu_relax();
+		(void)atomic_cond_read_relaxed(&q->requeue_state, VAL != Q_REQUEUE_PI_WAIT);
 #endif
 	}
 
