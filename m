Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3053730F65A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 16:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237376AbhBDPbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 10:31:51 -0500
Received: from foss.arm.com ([217.140.110.172]:60456 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237258AbhBDPba (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 10:31:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D99F11D4;
        Thu,  4 Feb 2021 07:30:45 -0800 (PST)
Received: from e107158-lin (e107158-lin.cambridge.arm.com [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 109A73F718;
        Thu,  4 Feb 2021 07:30:42 -0800 (PST)
Date:   Thu, 4 Feb 2021 15:30:40 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org,
        bigeasy@linutronix.de, swood@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vincent.donnefort@arm.com,
        tj@kernel.org
Subject: Re: [RFC PATCH] sched/core: Fix premature p->migration_pending
 completion
Message-ID: <20210204153040.qqkoa5sjztqeskoc@e107158-lin>
References: <20210127193035.13789-1-valentin.schneider@arm.com>
 <20210203172344.uzq2iod4g46ffame@e107158-lin>
 <jhjft2d2d1f.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <jhjft2d2d1f.mognet@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/03/21 18:59, Valentin Schneider wrote:
> On 03/02/21 17:23, Qais Yousef wrote:
> > On 01/27/21 19:30, Valentin Schneider wrote:
> >> Fiddling some more with a TLA+ model of set_cpus_allowed_ptr() & friends
> >> unearthed one more outstanding issue. This doesn't even involve
> >> migrate_disable(), but rather affinity changes and execution of the stopper
> >> racing with each other.
> >> 
> >> My own interpretation of the (lengthy) TLA+ splat (note the potential for
> >> errors at each level) is:
> >> 
> >>   Initial conditions:
> >>     victim.cpus_mask = {CPU0, CPU1}
> >> 
> >>   CPU0                             CPU1                             CPU<don't care>
> >> 
> >>   switch_to(victim)
> >> 								    set_cpus_allowed(victim, {CPU1})
> >> 								      kick CPU0 migration_cpu_stop({.dest_cpu = CPU1})
> >>   switch_to(stopper/0)
> >> 								    // e.g. CFS load balance
> >> 								    move_queued_task(CPU0, victim, CPU1);
> >> 				   switch_to(victim)
> >> 								    set_cpus_allowed(victim, {CPU0});
> >> 								      task_rq_unlock();
> >>   migration_cpu_stop(dest_cpu=CPU1)
> >
> > This migration stop is due to set_cpus_allowed(victim, {CPU1}), right?
> >
> 
> Right
> 
> >>     task_rq(p) != rq && pending
> >>       kick CPU1 migration_cpu_stop({.dest_cpu = CPU1})
> >> 
> >> 				   switch_to(stopper/1)
> >> 				   migration_cpu_stop(dest_cpu=CPU1)
> >
> > And this migration stop is due to set_cpus_allowed(victim, {CPU0}), right?
> >
> 
> Nein! This is a retriggering of the "current" stopper (triggered by
> set_cpus_allowed(victim, {CPU1})), see the tail of that
> 
>   else if (dest_cpu < 0 || pending)
> 
> branch in migration_cpu_stop(), is what I'm trying to hint at with that 
> 
> task_rq(p) != rq && pending

Okay I see. But AFAIU, the work will be queued in order. So we should first
handle the set_cpus_allowed_ptr(victim, {CPU0}) before the retrigger, no?

So I see migration_cpu_stop() running 3 times

	1. because of set_cpus_allowed(victim, {CPU1}) on CPU0
	2. because of set_cpus_allowed(victim, {CPU0}) on CPU1
	3. because of retrigger of '1' on CPU0

Thanks

--
Qais Yousef
