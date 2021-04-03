Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3763531D2
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 03:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235689AbhDCBEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 21:04:41 -0400
Received: from mga05.intel.com ([192.55.52.43]:53264 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234488AbhDCBEk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 21:04:40 -0400
IronPort-SDR: BfDYRQJXcN0GquLZvX8Lnvd5+m/5xkVTP1KhWfyyuMhsDTn4qgj4+G6Vj6izhl+VKeKrWMgAVv
 suvChSjG0dpQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9942"; a="277753829"
X-IronPort-AV: E=Sophos;i="5.81,300,1610438400"; 
   d="scan'208";a="277753829"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2021 18:04:36 -0700
IronPort-SDR: j8GuiEv3ShdYN+WV1AhirlSuWppvNV9WY9hmhkpvuu1v/WxTHD14PCb+5GJQFm1Ghtu6F2ZCYr
 oWwMcohpmgZw==
X-IronPort-AV: E=Sophos;i="5.81,300,1610438400"; 
   d="scan'208";a="611474473"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2021 18:04:36 -0700
Date:   Sat, 3 Apr 2021 01:04:35 +0000
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v5 2/3] x86/bus_lock: Handle #DB for bus lock
Message-ID: <YGe/IwJSNHnuhU2d@otcwcpicx3.sc.intel.com>
References: <20210313054910.2503968-1-fenghua.yu@intel.com>
 <20210313054910.2503968-3-fenghua.yu@intel.com>
 <871rca6dbp.fsf@nanos.tec.linutronix.de>
 <YFUjVwBg133LN+kS@otcwcpicx3.sc.intel.com>
 <878s6iatdf.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878s6iatdf.fsf@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Thomas,

On Sat, Mar 20, 2021 at 01:42:52PM +0100, Thomas Gleixner wrote:
> On Fri, Mar 19 2021 at 22:19, Fenghua Yu wrote:
> > On Fri, Mar 19, 2021 at 10:30:50PM +0100, Thomas Gleixner wrote:
> >> > +	if (sscanf(arg, "ratelimit:%d", &ratelimit) == 1 && ratelimit > 0) {
> >> > +		bld_ratelimit = ratelimit;
> >> 
> >> So any rate up to INTMAX/s is valid here, right?
> >
> > Yes. I don't see smaller limitation than INTMX/s. Is that right?
> 
> That's a given, but what's the point of limits in that range?
> 
> A buslock access locks up the system for X cycles. So the total amount
> of allowable damage in cycles per second is:
> 
>    limit * stall_cycles_per_bus_lock
> 
> ergo the time (in seconds) which the system is locked up is:
> 
>    limit * stall_cycles_per_bus_lock / cpufreq
> 
> Which means for ~INTMAX/2 on a 2 GHz CPU:
> 
>    2 * 10^9 * $CYCLES  / 2 * 10^9  = $CYCLES seconds
> 
> Assumed the inflicted damage is only 1 cycle then #LOCK is pretty much
> permanently on if there are enough threads. Sure #DB will slow them
> down, but it still does not make any sense at all especially as the
> damage is certainly greater than a single cycle.
> 
> And because the changelogs and the docs are void of numbers I just got
> real numbers myself.
> 
> With a single thread doing a 'lock inc *mem' accross a cache line
> boundary the workload which I measured with perf stat goes from:
> 
>      5,940,985,091      instructions              #    0.88  insn per cycle         
>        2.780950806 seconds time elapsed
>        0.998480000 seconds user
>        4.202137000 seconds sys
> to
> 
>      7,467,979,504      instructions              #    0.10  insn per cycle         
>        5.110795917 seconds time elapsed
>        7.123499000 seconds user
>       37.266852000 seconds sys
> 
> The buslock injection rate is ~250k per second.
> 
> Even if I ratelimit the locked inc by a delay loop of ~5000 cycles
> which is probably more than what the #DB will cost then this single task
> still impacts the workload significantly:
> 
>      6,496,994,537      instructions              #    0.39  insn per cycle         
>        3.043275473 seconds time elapsed
>        1.899852000 seconds user
>        8.957088000 seconds sys
> 
> The buslock injection rate is down to ~150k per second in this case.
> 
> And even with throttling the injection rate further down to 25k per
> second the impact on the workload is still significant in the 10% range.

Thank you for your insight!

So I can change the ratelimit to system wide and call usleep_range()
to sleep: 
               while (!__ratelimit(&global_bld_ratelimit))
                       usleep_range(1000000 / bld_ratelimit,
                                    1000000 / bld_ratelimit);

The max bld_ratelimit is 1000,000/s because the max sleeping time is 1 usec.
The min bld_ratelimit is 1/s.

> 
> And of course the documentation of the ratelimit parameter explains all
> of this in great detail so the administrator has a trivial job to tune
> that, right?

I will explain how to tune the parameter in buslock.rst doc.

> 
> >> > +	case sld_ratelimit:
> >> > +		/* Enforce no more than bld_ratelimit bus locks/sec. */
> >> > +		while (!__ratelimit(&get_current_user()->bld_ratelimit))
> >> > +			msleep(1000 / bld_ratelimit);
> 
> For any ratelimit > 1000 this will loop up to 1000 times with
> CONFIG_HZ=1000.
> 
> Assume that the buslock producer has tons of threads which all end up
> here pretty soon then you launch a mass wakeup in the worst case every
> jiffy. Are you sure that the cure is better than the disease?

if using usleep_range() to sleep, the threads will not sleep and wakeup,
right? Maybe I can use msleep() for msec (bigger bld_ratelimit) and
usleep_range() for usec (smaller bld_ratelimit)?

Even if there is mass wakeup, throttling the threads can avoid the system
wide performance degradation (e.g. 7x slower dd command in another user).
Is that a good justification for throttling the threads?

> 
> > If I split this whole patch set into two patch sets:
> > 1. Three patches in the first patch set: the enumeration patch, the warn
> >    and fatal patch, and the documentation patch.
> > 2. Two patches in the second patch set: the ratelimit patch and the
> >    documentation patch.
> >
> > Then I will send the two patch sets separately, you will accept them one
> > by one. Is that OK?
> 
> That's obviously the right thing to do because #1 should be ready and we
> can sort out #2 seperately. See the conversation with Tony.

Thank you for picking up the first patch set!

-Fenghua
