Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8103F35B332
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 12:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235267AbhDKKeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 06:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbhDKKeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 06:34:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B86CC061574
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 03:33:46 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618137225;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oG/+qQ7023AoRp4DuxOK3xmrqTaajAa1aRC3lHVYvts=;
        b=bELgFZ8k7sF4DZIjpYByd+h6StD+B3nQg+R6qPGwUT1Pt7xWT9ZGr2BVq0CXL3fdyyPG6F
        GVozytppsmLuOlPUkoZen7MNBl7MRk0okDdjQu2YsoKw2oK1geFTo1DvT1e+7VitMOhkZL
        hwXJpVaLoL8h9R02G+z3KPWtOT/3lg7kcc0NN76mKa5MfOjWDF/wODTKYp9VhAzNOfXEs6
        +3Oh7Bxq2v1SIfhaCH0WUGmH0I1YdNc0IMv+Nu1/6flMC5gKa2L6Km9SldTf3RLxbcEf4R
        P5gLnOMstoSz9Rqkv6bj8Po+rjKig5q5MgX42+OfeHyk4bbLhCPNXQeoZp/ZLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618137225;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oG/+qQ7023AoRp4DuxOK3xmrqTaajAa1aRC3lHVYvts=;
        b=uHV6AWJ7A1tFkH5kvf5Ub1+pTaMR2fQEu41DGeeLsNf337Lj6ZjskFyjAAN7AqKXzrnMve
        PGVLop1uILHNnHCg==
To:     paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@fb.com, neeraju@codeaurora.org,
        ak@linux.intel.com
Subject: Re: [PATCH v7 clocksource 3/5] clocksource: Check per-CPU clock synchronization when marked unstable
In-Reply-To: <20210411002020.GV4510@paulmck-ThinkPad-P17-Gen-1>
References: <20210402224828.GA3683@paulmck-ThinkPad-P72> <20210402224906.3912-3-paulmck@kernel.org> <87blam4iqe.ffs@nanos.tec.linutronix.de> <20210411002020.GV4510@paulmck-ThinkPad-P17-Gen-1>
Date:   Sun, 11 Apr 2021 12:33:44 +0200
Message-ID: <878s5p2jqv.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 10 2021 at 17:20, Paul E. McKenney wrote:
> On Sat, Apr 10, 2021 at 11:00:25AM +0200, Thomas Gleixner wrote:
>> > +	if (WARN_ON_ONCE(!cs))
>> > +		return;
>> > +	pr_warn("Checking clocksource %s synchronization from CPU %d.\n",
>> > +		cs->name, smp_processor_id());
>> > +	cpumask_clear(&cpus_ahead);
>> > +	cpumask_clear(&cpus_behind);
>> > +	csnow_begin = cs->read(cs);
>> 
>> So this is invoked via work and the actual clocksource change is done
>> via work too. Once the clocksource is not longer actively used for
>> timekeeping it can go away. What's guaranteeing that this runs prior to
>> the clocksource change and 'cs' is valid throughout this function?
>
> From what I can see, cs->read() doesn't care whether or not the
> clocksource has been marked unstable.  So it should be OK to call
> cs->read() before, during, or after the call to __clocksource_unstable().
>
> Also, this is only done on clocksources marked CLOCK_SOURCE_VERIFY_PERCPU,
> so any clocksource that did not like cs->read() being invoked during
> or after the call to __clocksource_unstable() should leave off the
> CLOCK_SOURCE_VERIFY_PERCPU bit.
>
> Or did I take a wrong turn somewhere in the pointers to functions?

Right. cs->read() does not care, but what guarantees that cs is valid
and not freed yet? It's not an issue with TSC and KVMCLOCK, but
conceptually the following is possible:

watchdog()   
  queue_work(synccheck);
  queue_work(clocksource_change);

work:                                   
  synccheck()                             clocksource_change()
    preemption                            ...
                                          ...
                                          some_other_code():
                                             unregister_clocksource(cs)
                                             free(cs)
  cs->read()   <- UAF

>> > +	queue_work(system_highpri_wq, &clocksource_verify_work);
>> 
>> This does not guarantee anything. So why does this need an extra work
>> function which is scheduled seperately?
>
> Because I was concerned about doing smp_call_function() while holding
> watchdog_lock, which is also acquired elsewhere using spin_lock_irqsave().
> And it still looks like on x86 that spin_lock_irqsave() spins with irqs
> disabled, which could result in deadlock.  The smp_call_function_single()
> would wait for the target CPU to enable interrupts, which would not
> happen until after the smp_call_function_single() returned due to its
> caller holding watchdog_lock.
>
> Or is there something that I am missing that prevents this deadlock
> from occurring?

The unstable mechanism is:

watchdog()
  __clocksource_unstable()
    schedule_work(&watchdog_work);

watchdog_work()
  kthread_run(clocksource_watchdog_thread);

cs_watchdog_thread()
  mutex_lock(&clocksource_mutex);
  if (__clocksource_watchdog_kthread())
	clocksource_select();
  mutex_unlock(&clocksource_mutex);

So what prevents you from doing that right in watchdog_work() or even in
cs_watchdog_thread() properly ordered against the actual clocksource
switch?

Hmm?

Thanks,

        tglx
