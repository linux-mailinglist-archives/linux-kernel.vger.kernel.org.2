Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5697A3E0137
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 14:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238058AbhHDMc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 08:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237177AbhHDMc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 08:32:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94531C0613D5
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 05:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WAtd0bMm+QJTC6OmCzQe2owPEYP0icmuK9JKTFVEuSg=; b=ZwEpRshGGfuGOlZhZXbT9HcJNm
        X9alfZ8hDTf2jrZkdvvRtXPjNhXFz9UWybV+EXrBs4vUZezKosu/k9e+5+wYME1wUHhcWDIoLniAQ
        VB/4jL9ctmrZacQ4Of5KWkAM8Ges6Kki76GhjDZiCaowTdKVgPI0hf7cWO9tLyqrfASb3/Bd17lOM
        efc2TSgYRDyGNcDBbIXfoMiscYkMmEJERwe8AgK4EqBken0K10MRgWAtDIZHgCYSMdvPik7786WwR
        SVXEJiYkQU/lAp/JmoyUnD5WkmemCwss8Ht/lVWWmNerY9QEbiinH4uMDrlx7fOcXVAIkmLN87j20
        GxRHJXIw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mBG2a-005pdS-Oj; Wed, 04 Aug 2021 12:30:37 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 64C019862B0; Wed,  4 Aug 2021 14:30:30 +0200 (CEST)
Date:   Wed, 4 Aug 2021 14:30:30 +0200
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
Subject: Re: [patch 62/63] locking/rtmutex: Add adaptive spinwait mechanism
Message-ID: <20210804123030.GD8057@worktop.programming.kicks-ass.net>
References: <20210730135007.155909613@linutronix.de>
 <20210730135208.637100512@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210730135208.637100512@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2021 at 03:51:09PM +0200, Thomas Gleixner wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> Going to sleep when a spinlock or rwlock is contended can be quite
> inefficient when the contention time is short and the lock owner is running
> on a different CPU. The MCS mechanism is not applicable to rtmutex based
> locks, so provide a simple adaptive spinwait mechanism for the RT specific
> spin/rwlock implementations.

A better Changelog would explain *why* OSQ does not apply. I'm thinking
this ie because the (spin) waiters can be of different priorities and we
need to ensure the highest prio waiter gets to win?

AFAICT that isn't true even without OSQ, you just get a thundering herd
and the higher prio waiter has a better chance of winning the race but
all bets are off either way around.

> [ tglx: Provide a contemporary changelog ]

It might be best to squash this and the next patch, this back and forth
doesn't make much sense at this point.

> +#ifdef CONFIG_SMP

Existing convention would make that:

#ifdef CONFIG_RTMUTEX_SPIN_ON_OWNER

But I suppose that's indeed not required if we don't use OSQ.

> +/*
> + * Note that owner is a speculative pointer and dereferencing relies
> + * on rcu_read_lock() and the check against the lock owner.
> + */
> +static bool rtlock_adaptive_spinwait(struct rt_mutex_base *lock,
> +				     struct task_struct *owner)

similarly, this would be:

  rt_mutex_spin_on_owner()

> +{
> +	bool res = true;
> +
> +	rcu_read_lock();
> +	for (;;) {
> +		/* Owner changed. Trylock again */
> +		if (owner != rt_mutex_owner(lock))
> +			break;
> +		/*
> +		 * Ensure that owner->on_cpu is dereferenced _after_
> +		 * checking the above to be valid.
> +		 */
> +		barrier();
> +		if (!owner->on_cpu) {

Esp. when this will be on rtmutex unconditionally, you want to mirror
the full set of conditions we also have on mutex_spin_on_owner():

	|| need_resched() || vcpu_is_preempted(task_cpu(owner))

> +			res = false;
> +			break;
> +		}
> +		cpu_relax();
> +	}
> +	rcu_read_unlock();
> +	return res;
> +}

Additionally, we could consider adding something that would compare the
current prio to the top_waiter prio and terminate the loop if we're
found to be of lower prio, but lifetime issues are probably going to
make that 'interesting'.
