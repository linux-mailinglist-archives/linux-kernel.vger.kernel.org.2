Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 834C73A9A78
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 14:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbhFPMdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 08:33:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:50246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231666AbhFPMdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 08:33:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7646161359;
        Wed, 16 Jun 2021 12:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623846674;
        bh=GaASMiuVf3PpMpuP0p95+Gtkk5/Lp7YuwNvCA4UDWL8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=elUDiQS9AZODCuaRaRE7GbvNCj6iNf1GHG7mXx1OI1y8HI5ZB6YRIUwJcMg4O/JPw
         fWJ/jsA7r8YIttWwNF+JMaHp9VKJmQEeBxCEbxGBQjZtRCK+27GfDumewcEkBw0jm+
         OQvVyshLGtyEU83dUF7ZNJdLIR0Z62CRjgnWVysf6fcOa6JXoTzFUtXBBh8jcWzNwq
         Pev8CArgJzA++9lZrEFknZ53hwE6vzG6CALe3ctUNDpTIKixd3o1UKmNfegGbMi7h0
         58ECmU5I85pLDe1F02WWCXPDldhO3cbFhD0oMPUGVxLl5Gdjp3/9nkuBYXxSNuEJNO
         kH7Yre050IN8A==
Date:   Wed, 16 Jun 2021 14:31:11 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "hasegawa-hitomi@fujitsu.com" <hasegawa-hitomi@fujitsu.com>,
        "'mingo@kernel.org'" <mingo@kernel.org>,
        "'fweisbec@gmail.com'" <fweisbec@gmail.com>,
        "'tglx@linutronix.de'" <tglx@linutronix.de>,
        "'juri.lelli@redhat.com'" <juri.lelli@redhat.com>,
        "'vincent.guittot@linaro.org'" <vincent.guittot@linaro.org>,
        "'dietmar.eggemann@arm.com'" <dietmar.eggemann@arm.com>,
        "'rostedt@goodmis.org'" <rostedt@goodmis.org>,
        "'bsegall@google.com'" <bsegall@google.com>,
        "'mgorman@suse.de'" <mgorman@suse.de>,
        "'bristot@redhat.com'" <bristot@redhat.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Utime and stime are less when getrusage (RUSAGE_THREAD) is
 executed on a tickless CPU.
Message-ID: <20210616123111.GD801071@lothringen>
References: <OSBPR01MB21837C8931D90AE55AF4A955EB529@OSBPR01MB2183.jpnprd01.prod.outlook.com>
 <OSBPR01MB2183384B29F6291EB7C0BB81EB2C9@OSBPR01MB2183.jpnprd01.prod.outlook.com>
 <YKN5cQpFSdsgBlBU@hirez.programming.kicks-ass.net>
 <OSBPR01MB21835E55331FCAE6F75E8332EB2B9@OSBPR01MB2183.jpnprd01.prod.outlook.com>
 <YKTZag/E8AaOtVT0@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKTZag/E8AaOtVT0@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 11:24:58AM +0200, Peter Zijlstra wrote:
> On Wed, May 19, 2021 at 06:30:36AM +0000, hasegawa-hitomi@fujitsu.com wrote:
> > Hi Ingo, Peter, Juri, and Vincent.
> > 
> > 
> > > Your email is malformed.
> > 
> > I'm sorry. I was sent in the wrong format. I correct it and resend.
> > Thank you, Peter, for pointing this out.
> > 
> > 
> > I found that when I run getrusage(RUSAGE_THREAD) on a tickless CPU,
> > the utime and stime I get are less than the actual time, unlike when I run
> > getrusage(RUSAGE_SELF) on a single thread.
> > This problem seems to be caused by the fact that se.sum_exec_runtime is not
> > updated just before getting the information from 'current'.
> > In the current implementation, task_cputime_adjusted() calls task_cputime() to
> > get the 'current' utime and stime, then calls cputime_adjust() to adjust the
> > sum of utime and stime to be equal to cputime.sum_exec_runtime. On a tickless
> > CPU, sum_exec_runtime is not updated periodically, so there seems to be a
> > discrepancy with the actual time.
> > Therefore, I think I should include a process to update se.sum_exec_runtime
> > just before getting the information from 'current' (as in other processes
> > except RUSAGE_THREAD). I'm thinking of the following improvement.
> > 
> > @@ void getrusage(struct task_struct *p, int who, struct rusage *r)
> >         if (who == RUSAGE_THREAD) {
> > +               task_sched_runtime(current);
> >                 task_cputime_adjusted(current, &utime, &stime);
> > 
> > Is there any possible problem with this?
> 
> Would be superfluous for CONFIG_VIRT_CPU_ACCOUNTING_NATIVE=y
> architectures at the very least.
> 
> It also doesn't help any of the other callers, like for example procfs.
> 
> Something like the below ought to work and fix all variants I think. But
> it does make the call significantly more expensive.
> 
> Looking at thread_group_cputime() that already does something like this,
> but that's also susceptible to a variant of this very same issue; since
> it doesn't call it unconditionally, nor on all tasks, so if current
> isn't part of the threadgroup and/or another task is on a nohz_full cpu,
> things will go wobbly again.
> 
> There's a note about syscall performance there, so clearly someone seems
> to care about that aspect of things, but it does suck for nohz_full.
> 
> Frederic, didn't we have remote ticks that should help with this stuff?

Only once per second :-s

> 
> And mostly I think the trade-off here is that if you run on nohz_full,
> you're not expected to go do syscalls anyway (because they're sodding
> expensive) and hence the accuracy of these sort of things is mostly
> irrelevant.

I guess you can, before you enter some critical workload.

> 
> So it might be the use-case is just fundamentally bonkers and we
> shouldn't really bother fixing this.
> 
> Anyway?
> 
> ---
> diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
> index 872e481d5098..620871c8e4f8 100644
> --- a/kernel/sched/cputime.c
> +++ b/kernel/sched/cputime.c
> @@ -612,7 +612,7 @@ void cputime_adjust(struct task_cputime *curr, struct prev_cputime *prev,
>  void task_cputime_adjusted(struct task_struct *p, u64 *ut, u64 *st)
>  {
>  	struct task_cputime cputime = {
> -		.sum_exec_runtime = p->se.sum_exec_runtime,
> +		.sum_exec_runtime = task_sched_runtime(p),
>  	};
>  
>  	task_cputime(p, &cputime.utime, &cputime.stime);

Or perhaps just return task_cputime() if the task runs in a
nohz_full CPU? The check for that would be racy though and there
might be jumps between values if the thread goes/leave a nohz_full
CPU.
