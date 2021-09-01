Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA483FD726
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 11:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243793AbhIAJqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 05:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232817AbhIAJqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 05:46:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4807CC061575;
        Wed,  1 Sep 2021 02:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=k1RzsA9ErlX2jNhfneocokO9I5omkExG/b8o+TpO1bc=; b=qklzu5CvDw4KdO5Bdyuu7PgltM
        EDca4yGxzqoOc84F4GcDv4VLsRBeqf0yZ5rIJBgGwiEPiyvPmH6GqSEbFGLTzKpRfbSfXzPBBRCR8
        jygXPbbWVdixdXw/M4iyLVPW1njEt4rUPoNfLTbiTJIeSuYzDr59q3pay4ZcR4czhXyIP+Epnf8Mt
        bh/Xn8TMr8AzbbLrxSplO2dIQHtAgxOOx8InjUAv6YbbxcNB+wAXxH3Tme9ozJznWaggwcCB10eAX
        H3yaIz9bysRLRdUYeoXcJq0B+qq/xsbz0/0l2siLwrhHPSYB+y/fjPYBlMMv+eaRJMmcRlGYfKGZR
        /YjlklDg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mLMn0-0026nB-Li; Wed, 01 Sep 2021 09:44:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id ABA203002C1;
        Wed,  1 Sep 2021 11:44:11 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 697862DE1078E; Wed,  1 Sep 2021 11:44:11 +0200 (CEST)
Date:   Wed, 1 Sep 2021 11:44:11 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kernel-janitors@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] locking/rtmutex: Fix ww_mutex deadlock check
Message-ID: <YS9La56fHMiCCo75@hirez.programming.kicks-ass.net>
References: <20210831082152.GC9846@kili>
 <YS81R45p7mYbhmrT@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YS81R45p7mYbhmrT@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2021 at 10:09:43AM +0200, Peter Zijlstra wrote:
> On Tue, Aug 31, 2021 at 11:21:52AM +0300, Dan Carpenter wrote:
> > Hello Peter Zijlstra,
> 
> Hi Dan :-)
> 
> > This is a semi-automatic email about new static checker warnings.
> > 
> > The patch a055fcc132d4: "locking/rtmutex: Return success on deadlock
> > for ww_mutex waiters" from Aug 26, 2021, leads to the following
> > Smatch complaint:
> > 
> >     kernel/locking/rtmutex.c:756 rt_mutex_adjust_prio_chain()
> >     error: we previously assumed 'orig_waiter' could be null (see line 644)
> > 
> > kernel/locking/rtmutex.c
> >    643		 */
> >    644		if (orig_waiter && !rt_mutex_owner(orig_lock))
> >                     ^^^^^^^^^^^
> > A lot of this code assumes "orig_waiter" can be NULL.
> > 
> 
> >    735		/*
> >    736		 * [6] check_exit_conditions_2() protected by task->pi_lock and
> >    737		 * lock->wait_lock.
> >    738		 *
> >    739		 * Deadlock detection. If the lock is the same as the original
> >    740		 * lock which caused us to walk the lock chain or if the
> >    741		 * current lock is owned by the task which initiated the chain
> >    742		 * walk, we detected a deadlock.
> >    743		 */
> >    744		if (lock == orig_lock || rt_mutex_owner(lock) == top_task) {
> >                     ^^^^^^^^^^^^^^^^^
> > This might mean it's a false positive, but Smatch isn't clever enough to
> > figure it out.  And I'm stupid too!  Plus lazy...  and ugly.
> > 
> >    745			ret = -EDEADLK;
> >    746	
> >    747			/*
> >    748			 * When the deadlock is due to ww_mutex; also see above. Don't
> >    749			 * report the deadlock and instead let the ww_mutex wound/die
> >    750			 * logic pick which of the contending threads gets -EDEADLK.
> >    751			 *
> >    752			 * NOTE: assumes the cycle only contains a single ww_class; any
> >    753			 * other configuration and we fail to report; also, see
> >    754			 * lockdep.
> >    755			 */
> >    756			if (IS_ENABLED(CONFIG_PREEMPT_RT) && orig_waiter->ww_ctx)
> >                                                              ^^^^^^^^^^^^^^^^^^^
> > Unchecked dereference.
> 
> 
> This is difficult... and I'm glad you flagged it. The normal de-boost
> path is through rt_mutex_adjust_prio() and that has: .orig_lock == NULL
> && .orig_waiter == NULL. And as such it would never trigger the above
> case.
> 
> However, there is remove_waiter() which is called on rt_mutex_lock()'s
> failure paths and that doesn't have .orig_lock == NULL, and as such
> *could* conceivably trigger this.
> 
> Let me figure out what the right thing to do is.
> 
> Thanks!

I think something like this ought to do.

---
Subject: locking/rtmutex: Fix ww_mutex deadlock check

Dan reported that rt_mutex_adjust_prio_chain() can be called with
.orig_waiter == NULL however commit a055fcc132d4 ("locking/rtmutex:
Return success on deadlock for ww_mutex waiters") unconditionally
dereferences it.

Since both call-sites that have .orig_waiter == NULL don't care for the
return value, simply disable the deadlock squash by adding the NULL
check.

Notably, both callers use the deadlock condition as a termination
condition for the iteration; once detected, we're sure (de)boosting is
done. Arguably [3] would be a more natural termination point, but I'm
not sure adding a third deadlock detection state would improve the code.

Fixes: a055fcc132d4 ("locking/rtmutex: Return success on deadlock for ww_mutex waiters")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/locking/rtmutex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 8eabdc79602b..6bb116c559b4 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -753,7 +753,7 @@ static int __sched rt_mutex_adjust_prio_chain(struct task_struct *task,
 		 * other configuration and we fail to report; also, see
 		 * lockdep.
 		 */
-		if (IS_ENABLED(CONFIG_PREEMPT_RT) && orig_waiter->ww_ctx)
+		if (IS_ENABLED(CONFIG_PREEMPT_RT) && orig_waiter && orig_waiter->ww_ctx)
 			ret = 0;
 
 		raw_spin_unlock(&lock->wait_lock);
