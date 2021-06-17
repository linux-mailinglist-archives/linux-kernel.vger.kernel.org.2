Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B90873AB7DF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 17:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233485AbhFQPuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 11:50:10 -0400
Received: from outbound-smtp44.blacknight.com ([46.22.136.52]:42101 "EHLO
        outbound-smtp44.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233371AbhFQPuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 11:50:09 -0400
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp44.blacknight.com (Postfix) with ESMTPS id 1D2D0F8483
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 16:48:01 +0100 (IST)
Received: (qmail 11209 invoked from network); 17 Jun 2021 15:48:00 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.255])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 17 Jun 2021 15:48:00 -0000
Date:   Thu, 17 Jun 2021 16:47:59 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] sched/fair: Age the average idle time
Message-ID: <20210617154759.GR30378@techsingularity.net>
References: <20210615111611.GH30378@techsingularity.net>
 <20210615204228.GB4272@worktop.programming.kicks-ass.net>
 <CAKfTPtAZ_Aq_S-O2qh5LPyxExkBq3G0kxh51fT7sSC_z8He4+w@mail.gmail.com>
 <20210617074401.GL30378@techsingularity.net>
 <CAKfTPtC8d37ZrXfDF2jkgg=tDPb1qAvFQQGXHhTf9LLR59hd8Q@mail.gmail.com>
 <20210617094040.GM30378@techsingularity.net>
 <CAKfTPtB-UCduEiQ5e8NxbOwsfjYGj3ron5rAg4_5ag2Fne7v3A@mail.gmail.com>
 <20210617110548.GN30378@techsingularity.net>
 <CAKfTPtBJkpSMFFGwgdFLyO5aSnGuzQSPrtpwOFckMQa4xaex=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAKfTPtBJkpSMFFGwgdFLyO5aSnGuzQSPrtpwOFckMQa4xaex=Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2021 at 05:03:54PM +0200, Vincent Guittot wrote:
> On Thu, 17 Jun 2021 at 13:05, Mel Gorman <mgorman@techsingularity.net> wrote:
> >
> > On Thu, Jun 17, 2021 at 12:02:56PM +0200, Vincent Guittot wrote:
> > > > > >
> > > > > > Fundamentally though, as the changelog notes "due to the nature of the
> > > > > > patch, this is a regression magnet". There are going to be examples
> > > > > > where a deep search is better even if a machine is fully busy or
> > > > > > overloaded and examples where cutting off the search is better. I think
> > > > > > it's better to have an idle estimate that gets updated if CPUs are fully
> > > > > > busy even if it's not a universal win.
> > > > >
> > > > > Although I agree that using a stall average idle time value of local
> > > > > is not good, I'm not sure this proposal is better. The main problem is
> > > > > that we use the avg_idle of the local CPU to estimate how many times
> > > > > we should loop and try to find another idle CPU. But there is no
> > > > > direct relation between both.
> > > >
> > > > This is true. The idle time of the local CPU is used to estimate the
> > > > idle time of the domain which is inevitably going to be inaccurate but
> > >
> > > I'm more and more convinced that using average idle time  (of the
> > > local cpu or the full domain) is not the right metric. In
> > > select_idle_cpu(), we looks for an idle CPU but we don't care about
> > > how long it will be idle.
> >
> > Can we predict that accurately? cpufreq for intel_pstate used to try
> > something like that but it was a bit fuzzy and I don't know if the
> > scheduler could do much better. There is some idle prediction stuff but
> > it's related to nohz which does not really help us if a machine is nearly
> > fully busy or overloaded.
> >
> > I guess for tracking idle that revisiting
> > https://lore.kernel.org/lkml/1615872606-56087-1-git-send-email-aubrey.li@intel.com/
> > is an option now that the scan is somewhat unified. A two-pass scan
> > could be used to check potentially idle CPUs first and if there is
> > sufficient search depth left, scan other CPUs. There were some questions
> 
> I think it's the other way around:
> a CPU is busy for sure if it is not set in the cpuidle_mask and we
> don't need to check it. But a cpu might not be idle even if it is set
> in the idle mask might because it's cleared during the tick
> 

Tick is a long time so scan depth may still be a problem.

> > Selecting based on avg idle time could be interesting but hazardous. If
> > for example, we prioritised selecting a CPU that is mostly idle, it'll
> > also pick CPUs that are potentially in a deep idle state incurring a
> > larger wakeup cost. Right now we are not much better because we just
> > select an idle CPU and hope for the best but always targetting the most
> > idle CPU could have problems. There would also be the cost of tracking
> > idle CPUs in priority order. It would eliminate the scan depth cost
> > calculations but the overall cost would be much worse.
> >
> > Hence, I still think we can improve the scan depth costs in the short
> > term until a replacement is identified that works reasonably well.
> >
> > > Even more, we can scan all CPUs whatever the
> > > avg idle time if there is a chance that there is an idle core.
> > >
> >
> > That is an important, but separate topic. It's known that the idle core
> > detection can yield false positives. Putting core scanning under SIS_PROP
> > had mixed results when we last tried but things change. Again, it doesn't
> > help with scan depth calculations.
> 
> my point was mainly to highlight that the path can take opposite
> decision for the same avg_idle value:
> - scan all cpus if has_idle_core is true whatever avg_idle
> - limit the depth if has_idle_core is false and avg_idle is short
> 

I do understand the point but the idle core scan anomaly was not
intended to be addressed in the patch because putting the idle scan
under SIS_PROP potentially means using cpus with active idle siblings
prematurely.

> >
> > > > tracking idle time for the domain will be cache write intensive and
> > > > potentially very expensive. I think this was discussed before but maybe
> > > > it is my imaginaction.
> > > >
> > > > > Typically, a short average idle time on
> > > > > the local CPU doesn't mean that there are less idle CPUs and that's
> > > > > why we have a mix a gain and loss
> > > > >
> > > >
> > > > Can you evaluate if scanning proportional to cores helps if applied on
> > > > top? The patch below is a bit of pick&mix and has only seen a basic build
> > >
> > > I will queue it for some test later today
> > >
> >
> > Thanks. The proposed patch since passed a build and boot test,
> > performance evaluation is under way but as it's x86 and SMT2, I'm mostly
> > just checking that it's neutral.
> 
> Results stay similar:
> group  tip/sched/core      + this patch             + latest addon
> 1      13.358(+/- 1.82%)   12.850(+/- 2.21%) +4%    13.411(+/- 2.47%) -0%
> 4      4.286(+/- 2.77%)    4.114(+/- 2.25%)  +4%    4.163(+/- 1.88%)  +3%
> 16     3.175(+/- 0.55%)    3.559(+/- 0.43%)  -12%   3.535(+/- 0.52%)  -11%
> 32     2.912(+/- 0.79%)    3.165(+/- 0.95%)  -8%    3.153(+/- 0.76%)  -10%
> 64     2.859(+/- 1.12%)    2.937(+/- 0.91%)  -3%    2.919(+/- 0.73%)  -2%
> 128    3.092(+/- 4.75%)    3.003(+/-5.18%)   +3%    2.973(+/- 0.90%)  +4%
> 256    3.233(+/- 3.03%)    2.973(+/- 0.80%)  +8%    3.036(+/- 1.05%)  +6%
> 

Ok, accounting for SMT4 didn't help.

-- 
Mel Gorman
SUSE Labs
