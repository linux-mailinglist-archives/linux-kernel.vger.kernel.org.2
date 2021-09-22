Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C53F415046
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 20:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237152AbhIVS66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 14:58:58 -0400
Received: from outbound-smtp32.blacknight.com ([81.17.249.64]:56794 "EHLO
        outbound-smtp32.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230407AbhIVS65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 14:58:57 -0400
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp32.blacknight.com (Postfix) with ESMTPS id D0D76D29CA
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 19:57:25 +0100 (IST)
Received: (qmail 24727 invoked from network); 22 Sep 2021 18:57:25 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 22 Sep 2021 18:57:25 -0000
Date:   Wed, 22 Sep 2021 19:57:24 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Mike Galbraith <efault@gmx.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] sched/fair: Scale wakeup granularity relative to
 nr_running
Message-ID: <20210922185724.GD3959@techsingularity.net>
References: <20210920142614.4891-3-mgorman@techsingularity.net>
 <22e7133d674b82853a5ee64d3f5fc6b35a8e18d6.camel@gmx.de>
 <20210921103621.GM3959@techsingularity.net>
 <ea2f9038f00d3b4c0008235079e1868145b47621.camel@gmx.de>
 <20210922132002.GX3959@techsingularity.net>
 <CAKfTPtCxhzz1XgNXM8jaQC2=tGHm0ap88HneUgWTpCSeWVZwsw@mail.gmail.com>
 <20210922150457.GA3959@techsingularity.net>
 <CAKfTPtB3tXwBZ_tVaDdiwMt-=sGH1iV6eUV6Rsnpw7q=tEpBwA@mail.gmail.com>
 <20210922173853.GB3959@techsingularity.net>
 <CAKfTPtDc39fCLbQqA2BhC6dsb+MyYYMdk9HUvrU0fRqULuQB-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAKfTPtDc39fCLbQqA2BhC6dsb+MyYYMdk9HUvrU0fRqULuQB-g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2021 at 08:22:43PM +0200, Vincent Guittot wrote:
> > > > > In
> > > > > your case, you want hackbench threads to not preempt each others
> > > > > because they tries to use same resources so it's probably better to
> > > > > let the current one to move forward but that's not a universal policy.
> > > > >
> > > >
> > > > No, but have you a better suggestion? hackbench might be stupid but it's
> > > > an example of where a workload can excessively preempt itself. While
> > > > overloading an entire machine is stupid, it could also potentially occurs
> > > > for applications running within a constrained cpumask.
> > >
> > > But this is property that is specific to each application. Some can
> > > have a lot of running threads but few wakes up which have to preempt
> > > current threads quickly but others just want the opposite
> > > So because it is a application specific property we should define it
> > > this way instead of trying to guess
> >
> > I'm not seeing an alternative suggestion that could be turned into
> > an implementation. The current value for sched_wakeup_granularity
> > was set 12 years ago was exposed for tuning which is no longer
> > the case. The intent was to allow some dynamic adjustment between
> > sysctl_sched_wakeup_granularity and sysctl_sched_latency to reduce
> > over-scheduling in the worst case without disabling preemption entirely
> > (which the first version did).
> >
> > Should we just ignore this problem and hope it goes away or just let
> > people keep poking silly values into debugfs via tuned?
> 
> We should certainly not add a bandaid because people will continue to
> poke silly value at the end. And increasing
> sysctl_sched_wakeup_granularity based on the number of running threads
> is not the right solution. According to the description of your
> problem that the current task doesn't get enough time to move forward,
> sysctl_sched_min_granularity should be part of the solution. Something
> like below will ensure that current got a chance to move forward
> 

That's a very interesting idea! I've queued it up for further testing
and as a comparison to the bandaid.

-- 
Mel Gorman
SUSE Labs
