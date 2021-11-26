Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7428545F2CB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 18:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235046AbhKZRXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 12:23:39 -0500
Received: from foss.arm.com ([217.140.110.172]:35924 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230473AbhKZRVi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 12:21:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BADA911D4;
        Fri, 26 Nov 2021 09:18:24 -0800 (PST)
Received: from ubiquitous (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B88683F7B4;
        Fri, 26 Nov 2021 09:18:23 -0800 (PST)
Date:   Fri, 26 Nov 2021 17:18:17 +0000
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     Valentin Schneider <Valentin.Schneider@arm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>, peterz@infradead.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org,
        mgorman@techsingularity.net, dietmar.eggemann@arm.com
Subject: Re: [PATCH] sched/fair: Fix detection of per-CPU kthreads waking a
 task
Message-ID: <20211126171817.GA3798214@ubiquitous>
References: <20211124154239.3191366-1-vincent.donnefort@arm.com>
 <CAKfTPtDX8sOfguZhJt5QV3j5D_JetcgncuF2w+uLa0XDk7UXkw@mail.gmail.com>
 <8735nkcwov.mognet@arm.com>
 <CAKfTPtDPskVdEd-KQ_cwe-R_zVFPQOgdbk9x+3eD12pKs8fGFw@mail.gmail.com>
 <87zgpsb6de.mognet@arm.com>
 <CAKfTPtCnusWJXJLDEudQ_q8MWaZYbPJK-QjAbBYWFW8Nw-J+Ww@mail.gmail.com>
 <87sfvjavqk.mognet@arm.com>
 <CAKfTPtC4iXXaptm9+2bHvX2E3xAWU4M3xN0ZuwpFQ1RyXAyxyA@mail.gmail.com>
 <87pmqmc16f.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pmqmc16f.mognet@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26, 2021 at 04:49:12PM +0000, Valentin Schneider wrote:
> On 26/11/21 15:40, Vincent Guittot wrote:
> > On Fri, 26 Nov 2021 at 14:32, Valentin Schneider
> > <Valentin.Schneider@arm.com> wrote:
> >>         /*
> >> -        * Allow a per-cpu kthread to stack with the wakee if the
> >> -        * kworker thread and the tasks previous CPUs are the same.
> >> -        * The assumption is that the wakee queued work for the
> >> -        * per-cpu kthread that is now complete and the wakeup is
> >> -        * essentially a sync wakeup. An obvious example of this
> >> +        * Allow a per-cpu kthread to stack with the wakee if the kworker thread
> >> +        * and the tasks previous CPUs are the same.  The assumption is that the
> >> +        * wakee queued work for the per-cpu kthread that is now complete and
> >> +        * the wakeup is essentially a sync wakeup. An obvious example of this
> >>          * pattern is IO completions.
> >> +        *
> >> +        * Ensure the wakeup is issued by the kthread itself, and don't match
> >> +        * against the idle task because that could override the
> >> +        * available_idle_cpu(target) check done higher up.
> >>          */
> >> -       if (is_per_cpu_kthread(current) &&
> >> +       if (is_per_cpu_kthread(current) && !is_idle_task(current) &&
> >
> > still i don't see the need of !is_idle_task(current)
> >
> 
> Admittedly, belts and braces. The existing condition checks rq->nr_running <= 1
> which can lead to coscheduling when the wakeup is issued by the idle task
> (or even if rq->nr_running == 0, you can have rq->ttwu_pending without
> having sent an IPI due to polling). Essentially this overrides the first
> check in sis() that uses idle_cpu(target) (prev == smp_processor_id() ==
> target).
> 
> I couldn't prove such wakeups can happen right now, but if/when they do
> (AIUI it would just take someone to add a wake_up_process() down some
> smp_call_function() callback) then we'll need the above. If you're still
> not convinced by now, I won't push it further.

From a quick experiment, even with the asym_fits_capacity(), I can trigger
the following:

[    0.118855] select_idle_sibling: wakee=kthreadd:2 nr_cpus_allowed=8 current=swapper/0:1 in_task=1
[    0.128214] select_idle_sibling: wakee=rcu_gp:3 nr_cpus_allowed=8 current=swapper/0:1 in_task=1
[    0.137327] select_idle_sibling: wakee=rcu_par_gp:4 nr_cpus_allowed=8 current=swapper/0:1 in_task=1
[    0.147221] select_idle_sibling: wakee=kworker/u16:0:7 nr_cpus_allowed=8 current=swapper/0:1 in_task=1
[    0.156994] select_idle_sibling: wakee=mm_percpu_wq:8 nr_cpus_allowed=8 current=swapper/0:1 in_task=1
[    0.171943] select_idle_sibling: wakee=rcu_sched:10 nr_cpus_allowed=8 current=swapper/0:1 in_task=1

So the in_task() condition doesn't appear to be enough to filter wakeups
while we have the swapper as a current.

> 
> >
> >> +           in_task() &&
> >>             prev == smp_processor_id() &&
> >>             this_rq()->nr_running <= 1) {
> >>                 return prev;
> >>
