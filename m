Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11C0533473A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 19:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233629AbhCJSyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 13:54:41 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34198 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233135AbhCJSyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 13:54:19 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615402458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0iNw37OZ2ZhZJKJTEJoGD7BWVe6v0EH55gixCYpf2IA=;
        b=H6H4P0rIm+vwtGQrNDQ3B2t0PbvmbDMUDRGKbG3yF86ZG71OzqilaUwjemRuUCl15jBk6O
        zagD2zuf1N9nDsm49K5a1sh9GPf5E/I2cORs8rcx7iFszvhNGA56odrEgDbxUzZJlThjDs
        yTay7g/DF0Sj3dnpo+V7LAhlVh5xWVWj5prE6OxvUkcenspwXC2F9MswnX3hN5dG0QYCDB
        2sUAFbBs/hu7GwDP5/60/STYIpscKs3BhnrB+CLOcZ5SInt3vqHDYpFIepEqnAXjywE9y4
        YQcRTWs2cbIwCu6HTcLdgppzRoUqAr0UApVGurQX9sb+o/jkTmAFMrUknoeItw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615402458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0iNw37OZ2ZhZJKJTEJoGD7BWVe6v0EH55gixCYpf2IA=;
        b=LxzWOGXfZIwCvWt7cQ/FabVQC5hMG6JG78YCtDeyvAPaiE4gUa3y1nak74lteBBNhK3bCa
        TLCPb3rGT3t+LmAg==
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Matt Fleming <matt@codeblueprint.co.uk>
Subject: Re: [PATCH] signal: Allow RT tasks to cache one sigqueue struct
In-Reply-To: <87lfb263h2.fsf@nanos.tec.linutronix.de>
References: <20210303142025.wbbt2nnr6dtgwjfi@linutronix.de> <m1zgzj7uv2.fsf@fess.ebiederm.org> <20210304081142.digtkddajkadwwq5@linutronix.de> <87tupr55ea.fsf@nanos.tec.linutronix.de> <m11rcu7nbr.fsf@fess.ebiederm.org> <87lfb263h2.fsf@nanos.tec.linutronix.de>
Date:   Wed, 10 Mar 2021 19:54:18 +0100
Message-ID: <87sg524z6t.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04 2021 at 21:58, Thomas Gleixner wrote:
> On Thu, Mar 04 2021 at 13:04, Eric W. Biederman wrote:
>> Thomas Gleixner <tglx@linutronix.de> writes:
>>>
>>> We could of course do the caching unconditionally for all tasks.
>>
>> Is there any advantage to only doing this for realtime tasks?
>
> It was mostly to avoid tons of cached entries hanging around all over
> the place. So I limited it to the case which the RT users deeply cared
> about. Also related to the accounting question below.
>
>> If not it probably makes sense to do the caching for all tasks.
>>
>> I am wondering if we want to count the cached sigqueue structure to the
>> users rt signal rlimit?
>
> That makes some sense, but that's a user visible change as a single
> signal will up the count for a tasks lifetime while today it is removed
> from accounting again once the signal is delivered. So that needs some
> thought.

Thought more about it. To make this accounting useful we'd need:

  - a seperate user::sigqueue_cached counter
  - a seperate RLIMIT_SIGQUEUE_CACHED

Then you need to think about the defaults. Any signal heavy application
will want this enabled and obviously automagically.

Also there is an argument not to have this due to possible pointless
memory consumption.

But what are we talking about? 80 bytes worth of memory per task in the
worst case. Which is compared to the rest of a task's memory consumption
just noise.

Looking at some statistics from a devel system there are less than 10
items cached when the machine is fully idle after boot. During a kernel
compile the cache utilization goes up to ~150 at max (make -j128 and 64
CPUs). What's interesting is the allocation statistics after boot and
full kernel compile:

  from slab:            23996
  from task cache:	52223

A typical pattern there is:

    <ls>-58490   [010] d..2  7765.664198: __sigqueue_alloc: 58488 from slab ffff8881132df460 10
    <ls>-58488   [002] d..1  7765.664294: __sigqueue_free.part.35: cache ffff8881132df460 10
    <ls>-58488   [002] d..2  7765.665146: __sigqueue_alloc: 1149 from cache ffff8881103dc550 10
     bash-1149   [000] d..2  7765.665220: exit_task_sighand: free ffff8881132df460 8 9
     bash-1149   [000] d..1  7765.665662: __sigqueue_free.part.35: cache ffff8881103dc550 9

58488 grabs the sigqueue from bash's task cache and bash sticks it back
in. Lather, rinse and repeat. 

IMO, not bothering with an extra counter and rlimit plus the required
atomic operations is just fine and having this for all tasks
unconditionally looks like a clear win.

I'll post an updated version of this soonish.

Thanks,

        tglx
