Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42CA73531CF
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 02:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235908AbhDCAuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 20:50:23 -0400
Received: from mga12.intel.com ([192.55.52.136]:50390 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234488AbhDCAuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 20:50:22 -0400
IronPort-SDR: bVCDS3zPgWMG4l7eViwX/miVE5TUtRZa9eSWMyKL3F5QJMt4XUciaTgpKaBAyPSEYxuZqIs6Ij
 eSGvyhSnzedw==
X-IronPort-AV: E=McAfee;i="6000,8403,9942"; a="171979213"
X-IronPort-AV: E=Sophos;i="5.81,300,1610438400"; 
   d="scan'208";a="171979213"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2021 17:50:20 -0700
IronPort-SDR: kq0XoCpYQPQAhb68210iHji3yAyMiZkLNTm+pJwfgVnpMhr6Qg07/SslbQomqNQ2vOwBpozoJz
 RD6yJCgJTWyg==
X-IronPort-AV: E=Sophos;i="5.81,300,1610438400"; 
   d="scan'208";a="419878504"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2021 17:50:19 -0700
Date:   Sat, 3 Apr 2021 00:50:14 +0000
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Luck, Tony" <tony.luck@intel.com>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Li, Xiaoyao" <xiaoyao.li@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v5 2/3] x86/bus_lock: Handle #DB for bus lock
Message-ID: <YGe7xglCHNH9J3Cb@otcwcpicx3.sc.intel.com>
References: <20210313054910.2503968-1-fenghua.yu@intel.com>
 <20210313054910.2503968-3-fenghua.yu@intel.com>
 <871rca6dbp.fsf@nanos.tec.linutronix.de>
 <d98d86f9f5824573b2441089e0c2ae91@intel.com>
 <87k0q2bpu1.fsf@nanos.tec.linutronix.de>
 <874kh6apwf.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874kh6apwf.fsf@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Thomas,

On Sat, Mar 20, 2021 at 02:57:52PM +0100, Thomas Gleixner wrote:
> On Sat, Mar 20 2021 at 02:01, Thomas Gleixner wrote:
> 
> > On Fri, Mar 19 2021 at 21:50, Tony Luck wrote:
> >>>  What is the justifucation for making this rate limit per UID and not
> >>>  per task, per process or systemwide?
> >>
> >> The concern is that a malicious user is running a workload that loops
> >> obtaining the buslock. This brings the whole system to its knees.
> >>
> >> Limiting per task doesn't help. The user can just fork(2) a whole bunch
> >> of tasks for a distributed buslock attack..
> >
> > Fair enough.
> >
> >> Systemwide might be an interesting alternative. Downside would be accidental
> >> rate limit of non-malicious tasks that happen to grab a bus lock periodically
> >> but in the same window with other buslocks from other users.
> >>
> >> Do you think that a risk worth taking to make the code simpler?
> >
> > I'd consider it low risk, but I just looked for the usage of the
> > existing ratelimit in struct user and the related commit. Nw it's dawns
> > on me where you are coming from.
> 
> So after getting real numbers myself, I have more thoughts on
> this. Setting a reasonable per user limit might be hard when you want to
> protect e.g. against an orchestrated effort by several users
> (containers...). If each of them stays under the limit which is easy
> enough to figure out then you still end up with significant accumulated
> damage.
> 
> So systemwide might not be the worst option after all.

Indeed.

> 
> The question is how wide spread are bus locks in existing applications?
> I haven't found any on a dozen machines with random variants of
> workloads so far according to perf ... -e sq_misc.split_lock.

We have been running various tests widely inside Intel (and also outside)
after enabling split lock and captured a few split lock issues in firmware,
kernel, drivers, and apps. As you know, we have submitted a few patches to
fix the split lock issues in the kernel and drivers (e.g. split lock
in bit ops) and fixed a few split lock issues in firmware.

But so far I'm not aware of any split lock issues in user space yet.
I guess compilers do good cache line alignment good job to avoid this
issue. But inline asm in user apps can easily hit this issue (on purpose).

> 
> What's the actual scenario in the real world where a buslock access
> might be legitimate?

I did a simple experiment: looping on a split locked instruction on
one core in one user can slow down "dd" command running on another core
in another user by 7 times. A malicious user can do similar things to
slow down the whole system performance, right?

> 
> And what's the advice, recommendation for a system administrator how to
> analyze the situation and what kind of parameter to set?
> 
> I tried to get answers from Documentation/x86/buslock.rst, but ....

Can I change the sleep code in the handle_bus_lock() to the following?

               while (!__ratelimit(&global_bld_ratelimit))
                       usleep_range(1000000 / bld_ratelimit,
                                    1000000 / bld_ratelimit);

Maybe the system wide bus lock ratelimit can be set to default value
1000,000/s which is also the max ratelimit value.

The max sleep in the kernel is 1 us which means max bld_ratelimit
can be up to 1000,000.

If the system administrator think bus locks are less tolerant and wants
to throttle bus lock further, bld_ratelimit can be set as a smaller number.
The smallest bld_ratelimit is 1.

When I gradually decreases bld_ratelimit value, I can see less bus locks
can be issued per second systemwide and "dd" command or other memory
benchmarks are less impacted by the bus locks.

If this works, I will have the buslock.rst doc to explain the situation
and how to set the parameter.

Thanks.

-Fenghua
