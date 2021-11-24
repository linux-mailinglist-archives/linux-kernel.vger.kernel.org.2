Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65E0745CBAA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 18:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350134AbhKXSCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 13:02:06 -0500
Received: from foss.arm.com ([217.140.110.172]:41628 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242568AbhKXSCF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 13:02:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 953611FB;
        Wed, 24 Nov 2021 09:58:55 -0800 (PST)
Received: from ubiquitous (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7D8D33F66F;
        Wed, 24 Nov 2021 09:58:54 -0800 (PST)
Date:   Wed, 24 Nov 2021 17:58:48 +0000
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, mgorman@techsingularity.net,
        dietmar.eggemann@arm.com
Subject: Re: [PATCH] sched/fair: Fix per-CPU kthread and wakee stacking for
 asym CPU capacity
Message-ID: <20211124175304.GA3221810@ubiquitous>
References: <20211124141435.3125147-1-vincent.donnefort@arm.com>
 <87fsrlcwcb.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fsrlcwcb.mognet@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2021 at 05:11:32PM +0000, Valentin Schneider wrote:
> On 24/11/21 14:14, Vincent Donnefort wrote:
> > A shortcut has been introduced in select_idle_sibling() to return prev_cpu
> > if the wakee is woken up by a per-CPU kthread. This is an issue for
> > asymmetric CPU capacity systems where the wakee might not fit prev_cpu
> > anymore. Evaluate asym_fits_capacity() for prev_cpu before using that
> > shortcut.
> >
> > Fixes: 52262ee567ad ("sched/fair: Allow a per-CPU kthread waking a task to stack on the same CPU, to fix XFS performance regression")
> 
> Shouldn't that rather be
> 
>   b4c9c9f15649 ("sched/fair: Prefer prev cpu in asymmetric wakeup path")

Yes definitely, my bad!

> 
> ? This is an ulterior commit to the one you point to, and before then
> asymmetric CPU systems wouldn't use any of the sis() heuristics.
> 
> I reportedly reviewed said commit back then, and don't recall anything
> specific about that conditional... The cover-letter for v2 states:
> 
>   https://lore.kernel.org/lkml/20201028174412.680-1-vincent.guittot@linaro.org/
>   """
>   don't check capacity for the per-cpu kthread UC because the assumption is
>   that the wakee queued work for the per-cpu kthread that is now complete and
>   the task was already on this cpu.
>   """
> 
> So the assumption here is that current is gonna sleep right after waking up
> p, so current's utilization doesn't matter, and p was already on prev, so
> it should fit there...

I don't think the assumption that "p was already on prev should fit" is
correct if we take into account uclamp min. That value can change from one
activation to the other and make that task artificially too big for prev_cpu...

> 
> I'm thinking things should actually be OK with your other patch that
> excludes 'current == swapper' from this condition.

...But indeed if we add [1] to the equation, this patch here would only
protect against that specific corner case.

(And probably also against the fact that this same task could have a value
that doesn't fit this CPU anymore but didn't trigger misfit during its previous
activation?)

[1] https://lore.kernel.org/lkml/20211124154239.3191366-1-vincent.donnefort@arm.com/

> 
> > Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 6291876a9d32..b90dc6fd86ca 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -6410,7 +6410,8 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
> >        */
> >       if (is_per_cpu_kthread(current) &&
> >           prev == smp_processor_id() &&
> > -	    this_rq()->nr_running <= 1) {
> > +	    this_rq()->nr_running <= 1 &&
> > +	    asym_fits_capacity(task_util, prev)) {
> >               return prev;
> >       }
> >
> > --
> > 2.25.1
