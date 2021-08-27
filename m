Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 499353F95A0
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 09:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244476AbhH0H5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 03:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244468AbhH0H5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 03:57:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BFCCC061757
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 00:56:50 -0700 (PDT)
Date:   Fri, 27 Aug 2021 09:56:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630051008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=igsL9WOnCyIdph9NgMc0fnb9ayJ2bfZdfib8exWlhEw=;
        b=qO5swBc7phDBW/WYjVsiHOnDLQHm2GLOi8NqRMp8F/yT2tYO1DOHHtvUG+l8qhw3UGZmKT
        WIH8QdDC2btcMdnItNo/DeIgldMqbjgQmuh/zstPEIM0awgApbySeP4l9CgGvzJHRZswaP
        NQEJduoQJcuXhde9O59sitLWtrwQadm2sRnYungLzQ4U0BV7L97Mh+a3KEV05JOmuRvMAP
        9IuJKudDcqn8WDaPZw94rAHq6hNfagZSrE6PjvcuPxvZScBjKrRBEV/gTbc6yD15fEJs6j
        AHCvGGE3lUvGsFWVkCW//1heQTuBsBqiYuItazWhdMSXx9R1nhh1WCb0dyN79w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630051008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=igsL9WOnCyIdph9NgMc0fnb9ayJ2bfZdfib8exWlhEw=;
        b=OPOT0ZaYnE91ishkrmh6yy0tExpf1xp+UxP4fBorNJPUsoegjvMQTRy1ie1F399ocDRCq8
        zlnoIbtuhntZ+xDg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Waiman Long <longman@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [patch 0/2] locking/rtmutex: Cure two subtle bugs
Message-ID: <20210827075646.jlop3ud27l4osmxs@linutronix.de>
References: <20210825101857.420032248@linutronix.de>
 <YSeWjCHoK4v5OcOt@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YSeWjCHoK4v5OcOt@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-26 15:26:36 [+0200], Peter Zijlstra wrote:
> On Wed, Aug 25, 2021 at 12:33:11PM +0200, Thomas Gleixner wrote:
> > The fixes are straight forward, but the rtmutex based ww_mutex
> > implementation still has some more rough egdes which need to be ironed out.
> 
> Something like the below (which should be two patches).

tglx suggested to put an ifdef RT around the two checks since it is only
needed by ww-mutex on RT. The patch below is what I committed to my RT
tree.

From: Peter Zijlstra <peterz@infradead.org>
Date: Thu, 26 Aug 2021 16:39:51 +0200
Subject: [PATCH] locking/rtmutex: Let ww-mutex handle deadlock detection.

There's two issues at hand:

 - 'spurious' -EDEADLK reports due to prior loops
 - actual deadlock detection that will/should be resolved by ww_mutex
   instead.

Both stem from the fact that ww_mutex can legitimately create cycles in
the lock graph. The first issue is because a blocker (P3 blow) can get
trapped in a cycle it didn't cause and hit the iteration depth.

The latter can be observed when we suppose P2 to be the highest priority
and thus should win progress rights over P1, but P2 would also be 'late'
and be the one to close the cycle. In that case PI-walk would report
-EDEADLK to P2, even though w/w would pick and wake P1 to receive
-EDEADLK.

Now; afaict these conditions below capture the above, but then fail to
adequately handle more complex locking chains where, for example, two
w/w classes are inverted, which is a geniune deadlock, which the below
will suppress.

Luckily w/w stuff is in-kernel only and lockdep should capture them; any
user chains should be unaffected.

famous last words etc..

Link: https://lkml.kernel.org/r/YSeWjCHoK4v5OcOt@hirez.programming.kicks-ass.net
Signed-off-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/locking/rtmutex.c | 43 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 8b14f9a958415..884d4dd9d81e2 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -656,6 +656,33 @@ static int __sched rt_mutex_adjust_prio_chain(struct task_struct *task,
 	if (next_lock != waiter->lock)
 		goto out_unlock_pi;
 
+#ifdef CONFIG_PREEMPT_RT
+	/*
+	 * There could be 'spurious' loops in the lock graph due to ww_mutex,
+	 * consider:
+	 *
+	 *   P1: A, ww_A, ww_B
+	 *   P2: ww_B, ww_A
+	 *   P3: A
+	 *
+	 * P3 should not return -EDEADLK because it gets trapped in the cycle
+	 * created by P1 and P2 (which will resolve -- and runs into
+	 * max_lock_depth above). Therefore disable detect_deadlock such that
+	 * the below termination condition can trigger once all relevant tasks
+	 * are boosted.
+	 *
+	 * Even when we start with ww_mutex we can disable deadlock detection,
+	 * since we would supress a ww_mutex induced deadlock at [6] anyway.
+	 * Supressing it here however is not sufficient since we might still
+	 * hit [6] due to adjustment driven iteration.
+	 *
+	 * NOTE: if someone were to create a deadlock between 2 ww_classes we'd
+	 * utterly fail to report it; lockdep should.
+	 */
+	if (waiter->ww_ctx && detect_deadlock)
+		detect_deadlock = false;
+#endif
+
 	/*
 	 * Drop out, when the task has no waiters. Note,
 	 * top_waiter can be NULL, when we are in the deboosting
@@ -717,8 +744,22 @@ static int __sched rt_mutex_adjust_prio_chain(struct task_struct *task,
 	 * walk, we detected a deadlock.
 	 */
 	if (lock == orig_lock || rt_mutex_owner(lock) == top_task) {
-		raw_spin_unlock(&lock->wait_lock);
 		ret = -EDEADLK;
+
+#ifdef CONFIG_PREEMPT_RT
+		/*
+		 * When the deadlock is due to ww_mutex; also see above. Don't
+		 * report the deadlock and instead let the ww_mutex wound/die
+		 * logic pick which of the contending threads gets -EDEADLK.
+		 *
+		 * NOTE: assumes the cycle only contains a single ww_class; any
+		 * other configuration and we fail to report; also, see
+		 * lockdep.
+		 */
+		if (orig_waiter->ww_ctx)
+			ret = 0;
+#endif
+		raw_spin_unlock(&lock->wait_lock);
 		goto out_unlock_pi;
 	}
 
-- 
2.33.0

