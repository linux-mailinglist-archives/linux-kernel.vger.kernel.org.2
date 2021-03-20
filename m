Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 059B8342CD1
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 13:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbhCTMnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 08:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbhCTMmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 08:42:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60530C061762
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 05:42:55 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616244172;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7nG0hzMmvifdvW36GfQzNegWIXrjZL2bAkzH5Ki82NM=;
        b=J3TEh6avxT2tGhCMj9UP9DdwDg1/4I4X0Ccllx4rY7Xuzg+IlIsn4axvAZr99SEDklXdb5
        fTyl/dJ6mzUJOXLPefDqnFyjdsOfOwlAWyWuFZ5HiYulYZeDfB3XkibIaQIa4jwgqtx5G1
        FI9cfLHPlyvalQ8eCQpdxgd3EI8qFg7xY4PPPrlP5RBTrIC7vX3r7Mf4pB0p05064LksZR
        QwDVP2UTWJ2hhY2jaHoYmR8ixm8smCYaRjdzgrM46DIn7B2DDYNw+naii0nNOeVDXpT/zT
        s7IIp23SdD3ldVbMJpBjSiQN0OQbHjePJwr3eWMJJjp7ZbKochoxtCrl+kL/bw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616244172;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7nG0hzMmvifdvW36GfQzNegWIXrjZL2bAkzH5Ki82NM=;
        b=D5+cU6Ix+zhFJwuj354PLxDJwqIn3I5vCnhdPq8IwYRZsH+OU8x2Or9xa5lEbJEFjl4eV2
        ZNs7AC7dCuzLXvCQ==
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v5 2/3] x86/bus_lock: Handle #DB for bus lock
In-Reply-To: <YFUjVwBg133LN+kS@otcwcpicx3.sc.intel.com>
References: <20210313054910.2503968-1-fenghua.yu@intel.com> <20210313054910.2503968-3-fenghua.yu@intel.com> <871rca6dbp.fsf@nanos.tec.linutronix.de> <YFUjVwBg133LN+kS@otcwcpicx3.sc.intel.com>
Date:   Sat, 20 Mar 2021 13:42:52 +0100
Message-ID: <878s6iatdf.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19 2021 at 22:19, Fenghua Yu wrote:
> On Fri, Mar 19, 2021 at 10:30:50PM +0100, Thomas Gleixner wrote:
>> > +	if (sscanf(arg, "ratelimit:%d", &ratelimit) == 1 && ratelimit > 0) {
>> > +		bld_ratelimit = ratelimit;
>> 
>> So any rate up to INTMAX/s is valid here, right?
>
> Yes. I don't see smaller limitation than INTMX/s. Is that right?

That's a given, but what's the point of limits in that range?

A buslock access locks up the system for X cycles. So the total amount
of allowable damage in cycles per second is:

   limit * stall_cycles_per_bus_lock

ergo the time (in seconds) which the system is locked up is:

   limit * stall_cycles_per_bus_lock / cpufreq

Which means for ~INTMAX/2 on a 2 GHz CPU:

   2 * 10^9 * $CYCLES  / 2 * 10^9  = $CYCLES seconds

Assumed the inflicted damage is only 1 cycle then #LOCK is pretty much
permanently on if there are enough threads. Sure #DB will slow them
down, but it still does not make any sense at all especially as the
damage is certainly greater than a single cycle.

And because the changelogs and the docs are void of numbers I just got
real numbers myself.

With a single thread doing a 'lock inc *mem' accross a cache line
boundary the workload which I measured with perf stat goes from:

     5,940,985,091      instructions              #    0.88  insn per cycle         
       2.780950806 seconds time elapsed
       0.998480000 seconds user
       4.202137000 seconds sys
to

     7,467,979,504      instructions              #    0.10  insn per cycle         
       5.110795917 seconds time elapsed
       7.123499000 seconds user
      37.266852000 seconds sys

The buslock injection rate is ~250k per second.

Even if I ratelimit the locked inc by a delay loop of ~5000 cycles
which is probably more than what the #DB will cost then this single task
still impacts the workload significantly:

     6,496,994,537      instructions              #    0.39  insn per cycle         
       3.043275473 seconds time elapsed
       1.899852000 seconds user
       8.957088000 seconds sys

The buslock injection rate is down to ~150k per second in this case.

And even with throttling the injection rate further down to 25k per
second the impact on the workload is still significant in the 10% range.

And of course the documentation of the ratelimit parameter explains all
of this in great detail so the administrator has a trivial job to tune
that, right?

>> > +	case sld_ratelimit:
>> > +		/* Enforce no more than bld_ratelimit bus locks/sec. */
>> > +		while (!__ratelimit(&get_current_user()->bld_ratelimit))
>> > +			msleep(1000 / bld_ratelimit);

For any ratelimit > 1000 this will loop up to 1000 times with
CONFIG_HZ=1000.

Assume that the buslock producer has tons of threads which all end up
here pretty soon then you launch a mass wakeup in the worst case every
jiffy. Are you sure that the cure is better than the disease?

> If I split this whole patch set into two patch sets:
> 1. Three patches in the first patch set: the enumeration patch, the warn
>    and fatal patch, and the documentation patch.
> 2. Two patches in the second patch set: the ratelimit patch and the
>    documentation patch.
>
> Then I will send the two patch sets separately, you will accept them one
> by one. Is that OK?

That's obviously the right thing to do because #1 should be ready and we
can sort out #2 seperately. See the conversation with Tony.

Thanks,

        tglx
