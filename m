Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2303E06F1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 19:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238296AbhHDRuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 13:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbhHDRuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 13:50:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD13C0613D5
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 10:49:59 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628099397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qqRttOyqAIJ+Hf5wxxzP7SWcoUH4TPpXSQNKqt43lrA=;
        b=zKK9SQQXV9TXrFCbujnF+6zKp6d/ZdMxjHAKVmCjP/tt6L5boCgx3Rb53eKj3GuB/eRBQn
        SnXdEWY3sqSmFXnMhN3mLvp1fwf4YuwSdnAy5bPzGwu2NJiK6kAbo3gD2BcsZqjx6FYr46
        rPBgS+C7EQq3Ek9zbYyH6auSc6KdUWp9zBhvuH5qhU0GjkEbIfRpiGE7WpfX8vJ8OQ1YDs
        I9smDF66IWzTXFwxf0GolOovFSOR8VxDwC0Bz7o1XvA7nWCHwmfG8NwpGz1UjpodJM1SPY
        Rx+In4BN09Bv/LwWGPzu9AHvkzSJCz6+kRzejVYb2AlqMBjZraCr/eb5/BDm5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628099397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qqRttOyqAIJ+Hf5wxxzP7SWcoUH4TPpXSQNKqt43lrA=;
        b=yMGOSfVwNsG601jxWcEZCABiu7vnxZKiXvWT9JSVABtH53+MI9cWFfo/bUWTiG+piq1new
        0vfcaWBs3OigkQCQ==
To:     Peter Zijlstra <peterz@infradead.org>
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
In-Reply-To: <20210804123030.GD8057@worktop.programming.kicks-ass.net>
References: <20210730135007.155909613@linutronix.de>
 <20210730135208.637100512@linutronix.de>
 <20210804123030.GD8057@worktop.programming.kicks-ass.net>
Date:   Wed, 04 Aug 2021 19:49:56 +0200
Message-ID: <87y29h14mz.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 04 2021 at 14:30, Peter Zijlstra wrote:
> On Fri, Jul 30, 2021 at 03:51:09PM +0200, Thomas Gleixner wrote:
>> From: Steven Rostedt <rostedt@goodmis.org>
>> 
>> Going to sleep when a spinlock or rwlock is contended can be quite
>> inefficient when the contention time is short and the lock owner is running
>> on a different CPU. The MCS mechanism is not applicable to rtmutex based
>> locks, so provide a simple adaptive spinwait mechanism for the RT specific
>> spin/rwlock implementations.
>
> A better Changelog would explain *why* OSQ does not apply. I'm thinking
> this ie because the (spin) waiters can be of different priorities and we
> need to ensure the highest prio waiter gets to win?
>
> AFAICT that isn't true even without OSQ, you just get a thundering herd
> and the higher prio waiter has a better chance of winning the race but
> all bets are off either way around.

Will do.

>> +#ifdef CONFIG_SMP
>
> Existing convention would make that:
>
> #ifdef CONFIG_RTMUTEX_SPIN_ON_OWNER
>
> But I suppose that's indeed not required if we don't use OSQ.

Right.

>> +/*
>> + * Note that owner is a speculative pointer and dereferencing relies
>> + * on rcu_read_lock() and the check against the lock owner.
>> + */
>> +static bool rtlock_adaptive_spinwait(struct rt_mutex_base *lock,
>> +				     struct task_struct *owner)
>
> similarly, this would be:
>
>   rt_mutex_spin_on_owner()

Duh.
>
> Esp. when this will be on rtmutex unconditionally, you want to mirror
> the full set of conditions we also have on mutex_spin_on_owner():
>
> 	|| need_resched() || vcpu_is_preempted(task_cpu(owner))

Sure.

>> +			res = false;
>> +			break;
>> +		}
>> +		cpu_relax();
>> +	}
>> +	rcu_read_unlock();
>> +	return res;
>> +}
>
> Additionally, we could consider adding something that would compare the
> current prio to the top_waiter prio and terminate the loop if we're
> found to be of lower prio, but lifetime issues are probably going to
> make that 'interesting'.

It's only the top priority waiter which can spin. If all of them start
spinning then everything goes down the drain.

Thanks,

        tglx
