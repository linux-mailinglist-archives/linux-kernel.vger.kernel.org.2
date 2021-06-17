Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52EAA3AADE6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 09:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbhFQHqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 03:46:13 -0400
Received: from outbound-smtp24.blacknight.com ([81.17.249.192]:47833 "EHLO
        outbound-smtp24.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229666AbhFQHqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 03:46:12 -0400
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp24.blacknight.com (Postfix) with ESMTPS id 8BE88F228D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 08:44:03 +0100 (IST)
Received: (qmail 6950 invoked from network); 17 Jun 2021 07:44:03 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.255])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 17 Jun 2021 07:44:03 -0000
Date:   Thu, 17 Jun 2021 08:44:02 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] sched/fair: Age the average idle time
Message-ID: <20210617074401.GL30378@techsingularity.net>
References: <20210615111611.GH30378@techsingularity.net>
 <20210615204228.GB4272@worktop.programming.kicks-ass.net>
 <CAKfTPtAZ_Aq_S-O2qh5LPyxExkBq3G0kxh51fT7sSC_z8He4+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAKfTPtAZ_Aq_S-O2qh5LPyxExkBq3G0kxh51fT7sSC_z8He4+w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 05:52:25PM +0200, Vincent Guittot wrote:
> On Tue, 15 Jun 2021 at 22:43, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Tue, Jun 15, 2021 at 12:16:11PM +0100, Mel Gorman wrote:
> > > From: Peter Zijlstra (Intel) <peterz@infradead.org>
> > >
> > > This is a partial forward-port of Peter Ziljstra's work first posted
> > > at https://lore.kernel.org/lkml/20180530142236.667774973@infradead.org/.
> >
> > It's patches 2 and 3 together, right?
> >
> > > His Signed-off has been removed because it is modified but will be restored
> > > if he says it's still ok.
> >
> > I suppose the SoB will auto-magically re-appear if I apply it :-)
> >
> > > The patch potentially matters when a socket was multiple LLCs as the
> > > maximum search depth is lower. However, some of the test results were
> > > suspiciously good (e.g. specjbb2005 gaining 50% on a Zen1 machine) and
> > > other results were not dramatically different to other mcahines.
> > >
> > > Given the nature of the patch, Peter's full series is not being forward
> > > ported as each part should stand on its own. Preferably they would be
> > > merged at different times to reduce the risk of false bisections.
> >
> > I'm tempted to give it a go.. anyone object?
> 
> Just finished running some tests on my large arm64 system.
> Tbench tests are a mixed between small gain and loss
> 

Same for tbench on three x86 machines I reran tests for

https://beta.suse.com/private/mgorman/melt/v5.13-rc5/3-perf-test/sched/sched-avgidle-v1r6/html/network-tbench/bing2/index.html#tbench4
Small gains and losses, gains at higher client counts where search depth
	should be reduced

https://beta.suse.com/private/mgorman/melt/v5.13-rc5/3-perf-test/sched/sched-avgidle-v1r6/html/network-tbench/hardy2/index.html#tbench4
Mostly gains, one counter-example at 4 clients

https://beta.suse.com/private/mgorman/melt/v5.13-rc5/3-perf-test/sched/sched-avgidle-v1r6/html/network-tbench/marvin2/index.html#tbench4
Worst by far, 1 client took a major hit for unknown reasons, otherwise
	mix of gains and losses. I'm not confident that the 1 client
	results are meaningful because for this machine, there should
	have been idle cores so the code the patch adjusts should not
	even be executed.

> hackbench shows significant changes in both direction
> hackbench -g $group
> 
> group  tip/sched/core      + this patch
> 1      13.358(+/- 1.82%)   12.850(+/- 2.21%) +4%
> 4      4.286(+/- 2.77%)    4.114(+/- 2.25%)  +4%
> 16     3.175(+/- 0.55%)    3.559(+/- 0.43%)  -12%
> 32     2.912(+/- 0.79%)    3.165(+/- 0.95%)  -8%
> 64     2.859(+/- 1.12%)    2.937(+/- 0.91%)  -3%
> 128    3.092(+/- 4.75%)    3.003(+/-5.18%)   +3%
> 256    3.233(+/- 3.03%)    2.973(+/- 0.80%)  +8%

Think this is processes and sockets. Of the hackbench results I had,
this one performed the worst

https://beta.suse.com/private/mgorman/melt/v5.13-rc5/3-perf-test/sched/sched-avgidle-v1r6/html/scheduler-unbound/bing2/index.html#hackbench-process-sockets
Small gains and losses

https://beta.suse.com/private/mgorman/melt/v5.13-rc5/3-perf-test/sched/sched-avgidle-v1r6/html/scheduler-unbound/hardy2/index.html#hackbench-process-sockets
Small gains and losses

https://beta.suse.com/private/mgorman/melt/v5.13-rc5/3-perf-test/sched/sched-avgidle-v1r6/html/scheduler-unbound/marvin2/index.html#hackbench-process-sockets
Small gains and losses

One of the better results for hackbench was processes and pipes
https://beta.suse.com/private/mgorman/melt/v5.13-rc5/3-perf-test/sched/sched-avgidle-v1r6/html/scheduler-unbound/bing2/index.html#hackbench-process-pipes
1-12% gains

For your arm machine, how many logical CPUs are online, what is the level
of SMT if any and is the machine NUMA?

Fundamentally though, as the changelog notes "due to the nature of the
patch, this is a regression magnet". There are going to be examples
where a deep search is better even if a machine is fully busy or
overloaded and examples where cutting off the search is better. I think
it's better to have an idle estimate that gets updated if CPUs are fully
busy even if it's not a universal win.

-- 
Mel Gorman
SUSE Labs
