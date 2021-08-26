Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C38B3F88F0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 15:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242830AbhHZN20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 09:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242829AbhHZN15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 09:27:57 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB3DC0613C1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 06:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZvXaASOkzLWr6IlIMVLtOQkE9DhzOG0fxY7CFT03qZU=; b=NakCp1drYMHqOhnEGrCPkPaZKw
        btfkT2M6BcntxvvAHyqRnGrBiAyaYKWPKkoYzxTX8nRm0oZTJuwZZkhLXJoaLrq7mKMe9TgP54e5W
        ZOqSz1UI9ThX/OL/yULMM29nOUr+W7WvgRwKiC6Wpb+piMkaVVAfYGEXOXrlLxEhzPwx9elfbCBOQ
        gdwweoFP4pxoiNmAC6v2EZlnrvx/JrWmDyJlhWQ1bzVmIWHuw0i3aROOTDFg8aLDIwLhvwYzjAAaD
        8zfq6cD0b6Wq5U5xhnpDyDkeltWlkxWAAA9OdFZhZED0ShxXCvNSO233eUfrTAAbizbypdp1C0s5X
        Bn59jj3Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mJFOv-00DCOy-MF; Thu, 26 Aug 2021 13:26:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B1CF4300969;
        Thu, 26 Aug 2021 15:26:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6EE1E28B5DCF2; Thu, 26 Aug 2021 15:26:36 +0200 (CEST)
Date:   Thu, 26 Aug 2021 15:26:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Waiman Long <longman@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [patch 0/2] locking/rtmutex: Cure two subtle bugs
Message-ID: <YSeWjCHoK4v5OcOt@hirez.programming.kicks-ass.net>
References: <20210825101857.420032248@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210825101857.420032248@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2021 at 12:33:11PM +0200, Thomas Gleixner wrote:
> The fixes are straight forward, but the rtmutex based ww_mutex
> implementation still has some more rough egdes which need to be ironed out.

Something like the below (which should be two patches).

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

---
 kernel/locking/rtmutex.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index c8fe74ef8db9..b7145d724b5f 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -656,6 +656,31 @@ static int __sched rt_mutex_adjust_prio_chain(struct task_struct *task,
 	if (next_lock != waiter->lock)
 		goto out_unlock_pi;
 
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
+
 	/*
 	 * Drop out, when the task has no waiters. Note,
 	 * top_waiter can be NULL, when we are in the deboosting
@@ -717,8 +742,21 @@ static int __sched rt_mutex_adjust_prio_chain(struct task_struct *task,
 	 * walk, we detected a deadlock.
 	 */
 	if (lock == orig_lock || rt_mutex_owner(lock) == top_task) {
-		raw_spin_unlock(&lock->wait_lock);
 		ret = -EDEADLK;
+
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
+
+		raw_spin_unlock(&lock->wait_lock);
 		goto out_unlock_pi;
 	}
 
