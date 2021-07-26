Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 974BD3D6468
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 18:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239773AbhGZP6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 11:58:01 -0400
Received: from foss.arm.com ([217.140.110.172]:54952 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237333AbhGZPmO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 11:42:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE4D51042;
        Mon, 26 Jul 2021 09:22:39 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (unknown [10.1.195.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2938A3F66F;
        Mon, 26 Jul 2021 09:22:38 -0700 (PDT)
Date:   Mon, 26 Jul 2021 17:22:35 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Quentin Perret <qperret@google.com>
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rickyiu@google.com, wvw@google.com,
        patrick.bellasi@matbug.net, xuewen.yan94@gmail.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Morten Rasmussen <morten.rasmussen@arm.com>
Subject: Re: [PATCH v3 3/3] sched: Introduce RLIMIT_UCLAMP
Message-ID: <20210726162235.5x6prj2jlj2wmdig@e107158-lin.cambridge.arm.com>
References: <20210623123441.592348-1-qperret@google.com>
 <20210623123441.592348-4-qperret@google.com>
 <20210701105014.ewrg4nt5sn3eg57o@e107158-lin.cambridge.arm.com>
 <YN2vj8OeZI7PBdzU@google.com>
 <20210701175248.qxnoo6cu7ts2dpys@e107158-lin.cambridge.arm.com>
 <YN8GaVjWXJp5IL06@google.com>
 <20210708113602.sjb4krzvs7xjmtt4@e107158-lin.cambridge.arm.com>
 <YPVltxfROeSYuahM@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YPVltxfROeSYuahM@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Quentin

On 07/19/21 12:44, Quentin Perret wrote:
> Hi Qais,
> 
> On Thursday 08 Jul 2021 at 12:36:02 (+0100), Qais Yousef wrote:
> > Hi Quentin
> > 
> > Apologies about the delayed response.
> 
> It's my turn to apologize -- the last few days have been a pretty busy :/
> 
> > After I replied to most of your email I discovered the cause of the confusion,
> > but left my reply intact. So please read till the end before you reply ;-)
> > 
> > On 07/02/21 12:28, Quentin Perret wrote:
> > > > There are several thoughts actually. A bit hard to articulate at this time of
> > > > day, but let me try.
> > > > 
> > > > /proc/sys/kernel/sched_util_clamp_min/max are system wide limits. RLIMIT_UCLAMP
> > > > seems to want to mimic it, so it makes sense for both to behave similarly.
> > > > Preventing task from requesting a boost (raising UCLAMP_MIN) is different from
> > > > preventing a task going above performance point (raising UCLAMP_MAX).
> > > 
> > > I don't really see why -- as you've already explained tasks can just
> > > busy loop to inflate their util values. So limiting the min clamp of
> > > task alone will never be an effective mechanism to limit how much
> > > capacity a task can ask for.
> > 
> > It's about what the API means and how ultimately the end user should be use and
> > benefit from it. I don't think we're on the same page here. Let me try to
> > explain better (hopefully) :)
> > 
> > The system wide controls already split the uclamp min and uclamp max. Each
> > request delivers a different meaning is what I'm saying. So lumping them under
> > one control needs at least more explanation of what is the big picture behind
> > it to warrant contradicting how the system wide limits already behave. And what
> > this single system knob means from user perspective; outside your specific use
> > case.
> > 
> > For instance, why this scenario is not allowed?
> > 
> > 	RLIMIT_UCLAMP_MIN = 200
> > 	RLIMIT_UCLAMP_MAX = 1024
> > 
> > 	This task can boost itself up to 200 then must 'suffer' DVFS/migration
> > 	delays to reach maximum performance point.
> 
> I just don't see how this would help at all. IMO the rlimit stuff is
> only useful to allow root to limit how much a task can ask for itself,
> and it doesn't really matter if the task inflates its request via
> uclamp.min, or by increasing it's uclamp.max and spinning on the CPU.
> That is, I just can't imagine how having different values for
> RLIMIT_UCLAMP_MIN and RLIMIT_UCLAMP_MAX would be useful in practice.

The way I see it is that we already have a sysctl that behaves like a limit for
UCLAMP_MIN and UCLAMP_MAX. The above scenario is something you can do with the
global sysctl. So you think system wide sysctl should be a single limit too
then?

> 
> > Which is basically what you can do with the sysctl_sched_util_clamp_min/max but
> > they apply globally (and impact the effective uclamp value).
> > 
> > It's a valid way to control resource requests. Uclamp doesn't guarantee any
> > allocations anyway; it's just a hint that hopefully will work most of the time
> > and will be limited by thermal issues or oversubscribed system type of
> > problems.
> > 
> > A more realistic use case would be
> > 
> > 	RLIMIT_UCLAMP_MIN = 0
> > 	RLIMIT_UCLAMP_MAX = 512
> >
> > So a task can't boost itself but allowed to run at half the system performance
> > point if it becomes busy.
> 
> That's not really what this would mean. What the above means is that a
> task is allowed to override the uclamp max set by root as long as it
> stays below 512. The actual uclamp.max set by root could be different
> from 512.
> 
> And IMO the only realistic configurations would be either
> 
>  	RLIMIT_UCLAMP_MIN = 0
>  	RLIMIT_UCLAMP_MAX = 0
> 
> which means that tasks can never increase their clamps, root decides
> their importance, but they're free to opt out.
> 
> Or:
> 
>  	RLIMIT_UCLAMP_MIN = 512
>  	RLIMIT_UCLAMP_MAX = 512
> 
> Which means that root allows this task to ask for anything in the 0-512
> range. The use case I'd see for this is: root sets the uclamp.max of the
> task to 512 and the rlimit to the same value. With that root is
> guaranteed that the clamped util of the task will never exceed 512. The
> task can do whatever it wants in that range (spin on the CPU or boost
> itself via uclamp min) it doesn't matter: it can't escape the limit.
> 
> This is what I feel is the use for the rlimit stuff: it allows root to
> put restrictions, and to have guarantees about those restrictions
> being respected. So, I don't see how separate rlimits for uclamp min
> and max would help really.

Fair enough. I still can't see why system wide can set these limits separately
but not rlimit though. The rlimit just applies them to a specifc task(s) rather
than every task on the system. I appreciate the way you envisage it to work,
but what I can't connect it is why it's fine for system wide uclamp limits but
not for the per-task rlimits?

> 
> > Which effectively will prevent short bursty tasks
> > from achieving high performance points, but allow long running ones to achieve
> > higher performance points to meet their demand and would be capped at 512.
> 
> I doubt anybody could make use of this TBH. I can imaging the framework
> saying "I don't want this task to ask for more than X of capacity", but I
> can't really see how it could reason about allowing long running tasks
> but not short ones, or anything like that...

This for me is an argument against RLIMIT, or the current design of the system
wide uclamp limits.

Ultimately this interface tries to regulate an application that tries to use
uclamp to boost/cap some tasks but there's a system wide framework that tries
to regulate these tasks too. The application can certainly reason about long
running vs short running tasks. The framework can reason on what is allowed to
be achieved by this app via uclamp. That's the way I see it at least :)

[...]

> Alright, I feel like this rlimit stuff is going to need a bit more
> discussion, so I'll re-post patches 01 and and 02 separately as they're
> really just fixes, and we can continue bike-shedding on this one in the
> meantime :)

:)

I'm sorry if I'm being painful, but I honestly just think the story lacks
clarity still. I am working on a uclamp doc and explaining what the current
interfaces are and how they are related to each others and how they should be
used and what they mean is hard enough. When I think of where this RLIMIT sits
in the story; especially it massively resembles how the system wide uclamp
sysctl behave, my mind keeps tripping over..

The most coherent story IMHO is to always have UCLAMP_MIN and UCLAMP_MAX and
always make UCLAMP_MIN behave as a protection and UCLAMP_MAX as a limit. Then
we'd have a very consistent story across all layers of control. It would just
mean we'd need to change how the system wide UCLAMP_MIN behaves, which could be
an ABI problem.

If we go down this route, I would see the RLIMIT then directly impacting the
effective uclamp value of the task rather than cause -EPERM. The same way the
rest of the layers work. ie: we'll have the following hierarchy to get the
effective uclamp of a task

	per-task request -> rlimit -> cgroup -> system

Would be good to hear what others have to say.

Cheers

--
Qais Yousef
