Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4263A415E48
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 14:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240918AbhIWMZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 08:25:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39717 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240793AbhIWMZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 08:25:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632399850;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7hoNhdPOfuPxMMO6XZ7wpIHpH7AP0ResWRFOF/uS/EE=;
        b=LuxHONYCDEF/aiasRh56Dxc65/H9elaMDqLiABvmPgC4G0Apl2N6018GoHkHxjZOdfoWp9
        MJsJ8NXyrOOuzZr3TCwZ6HciSqBVMs/iFfUKGq7G9pdi69vinChNcfGW3Axr11M1xNdYs0
        B5YWyt3jgEt2ucp3Qw0gG0JiMhfr3c0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-4HFMxr4pNiSqWth-zA3HNQ-1; Thu, 23 Sep 2021 08:24:09 -0400
X-MC-Unique: 4HFMxr4pNiSqWth-zA3HNQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8C1D483DD25;
        Thu, 23 Sep 2021 12:24:07 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.22.16.236])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 61DD45DA2D;
        Thu, 23 Sep 2021 12:24:05 +0000 (UTC)
Date:   Thu, 23 Sep 2021 08:24:03 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Mike Galbraith <efault@gmx.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] sched/fair: Scale wakeup granularity relative to
 nr_running
Message-ID: <YUxx42W3K2Ur7W84@lorien.usersys.redhat.com>
References: <20210921103621.GM3959@techsingularity.net>
 <ea2f9038f00d3b4c0008235079e1868145b47621.camel@gmx.de>
 <20210922132002.GX3959@techsingularity.net>
 <CAKfTPtCxhzz1XgNXM8jaQC2=tGHm0ap88HneUgWTpCSeWVZwsw@mail.gmail.com>
 <20210922150457.GA3959@techsingularity.net>
 <CAKfTPtB3tXwBZ_tVaDdiwMt-=sGH1iV6eUV6Rsnpw7q=tEpBwA@mail.gmail.com>
 <20210922173853.GB3959@techsingularity.net>
 <CAKfTPtDc39fCLbQqA2BhC6dsb+MyYYMdk9HUvrU0fRqULuQB-g@mail.gmail.com>
 <ba60262d15891702cae0d59122388c6a18caaf53.camel@gmx.de>
 <CAKfTPtBBqLghrXrayyoBQQyDqdv6+pdCjiZkmzLaGvdNtN=Aug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtBBqLghrXrayyoBQQyDqdv6+pdCjiZkmzLaGvdNtN=Aug@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2021 at 10:40:48AM +0200 Vincent Guittot wrote:
> On Thu, 23 Sept 2021 at 03:47, Mike Galbraith <efault@gmx.de> wrote:
> >
> > On Wed, 2021-09-22 at 20:22 +0200, Vincent Guittot wrote:
> > > On Wed, 22 Sept 2021 at 19:38, Mel Gorman <mgorman@techsingularity.net> wrote:
> > > >
> > > >
> > > > I'm not seeing an alternative suggestion that could be turned into
> > > > an implementation. The current value for sched_wakeup_granularity
> > > > was set 12 years ago was exposed for tuning which is no longer
> > > > the case. The intent was to allow some dynamic adjustment between
> > > > sysctl_sched_wakeup_granularity and sysctl_sched_latency to reduce
> > > > over-scheduling in the worst case without disabling preemption entirely
> > > > (which the first version did).
> >
> > I don't think those knobs were ever _intended_ for general purpose
> > tuning, but they did get used that way by some folks.
> >
> > > >
> > > > Should we just ignore this problem and hope it goes away or just let
> > > > people keep poking silly values into debugfs via tuned?
> > >
> > > We should certainly not add a bandaid because people will continue to
> > > poke silly value at the end. And increasing
> > > sysctl_sched_wakeup_granularity based on the number of running threads
> > > is not the right solution.
> >
> > Watching my desktop box stack up large piles of very short running
> > threads, I agree, instantaneous load looks like a non-starter.
> >
> > >  According to the description of your
> > > problem that the current task doesn't get enough time to move forward,
> > > sysctl_sched_min_granularity should be part of the solution. Something
> > > like below will ensure that current got a chance to move forward
> >
> > Nah, progress is guaranteed, the issue is a zillion very similar short
> > running threads preempting each other with no win to be had, thus
> > spending cycles in the scheduler that are utterly wasted.  It's a valid
> > issue, trouble is teaching the scheduler to recognize that situation
> > without mucking up other situations where there IS a win for even very
> > short running threads say, doing a synchronous handoff; preemption is
> > cheaper than scheduling off if the waker is going be awakened again in
> > very short order.
> >
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index 9bf540f04c2d..39d4e4827d3d 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -7102,6 +7102,7 @@ static void check_preempt_wakeup(struct rq *rq,
> > > struct task_struct *p, int wake_
> > >         int scale = cfs_rq->nr_running >= sched_nr_latency;
> > >         int next_buddy_marked = 0;
> > >         int cse_is_idle, pse_is_idle;
> > > +       unsigned long delta_exec;
> > >
> > >         if (unlikely(se == pse))
> > >                 return;
> > > @@ -7161,6 +7162,13 @@ static void check_preempt_wakeup(struct rq *rq,
> > > struct task_struct *p, int wake_
> > >                 return;
> > >
> > >         update_curr(cfs_rq_of(se));
> > > +       delta_exec = se->sum_exec_runtime - se->prev_sum_exec_runtime;
> > > +       /*
> > > +        * Ensure that current got a chance to move forward
> > > +        */
> > > +       if (delta_exec < sysctl_sched_min_granularity)
> > > +               return;
> > > +
> > >         if (wakeup_preempt_entity(se, pse) == 1) {
> > >                 /*
> > >                  * Bias pick_next to pick the sched entity that is
> >
> > Yikes!  If you do that, you may as well go the extra nanometer and rip
> > wakeup preemption out entirely, same result, impressive diffstat.
> 
> This patch is mainly there to show that there are other ways to ensure
> progress without using some load heuristic.
> sysctl_sched_min_granularity has the problem of scaling with the
> number of cpus and this can generate large values. At least we should
> use the normalized_sysctl_sched_min_granularity or even a smaller
> value but wakeup preemption still happens with this change. It only
> ensures that we don't waste time preempting each other without any
> chance to do actual stuff.
>

It's capped at 8 cpus, which is pretty easy to reach these days, so the
values don't get too large.  That scaling is almost a no-op these days.


Cheers,
Phil


> a 100us value should even be enough to fix Mel's problem without
> impacting common wakeup preemption cases.
> 
> 
> >
> >         -Mike
> 

-- 

