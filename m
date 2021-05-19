Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7E9E388AA1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 11:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345286AbhESJ35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 05:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbhESJ3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 05:29:55 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCFC4C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 02:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=m8Igu3htSBogxAvGoObQUNHWPrJawCttblVwJwn5eC4=; b=UmlvbKUCxdjY+gqGIWpsADx16I
        mpgzzyOxEGZJ8DCURV/bhPNZHCnghuHUB4nSGaxzKKnipuxU0SyYuJiYz8CXpE4TbsrAMyKVuFG3h
        ZS+xwutoRyOMKC8xNHL+uS/3Ta9psr464cNUa7Dv/I/k58fgko5SY72dGac96nCtspPGDu5WAKzi4
        vwPHqCnhEq2NJaYNUztyBFUeppxQac1hUQXjSznwR9v/hhOA8Bhm3buTEaC7f0XUmtRp8H7ikgS4O
        2u1FSKFjnku958ZwmUnlNHyA95e4XznBdEqWx0leZda83UEzGWaKSrr/jkfJith3snVhv0Kvp7z6r
        WbzM6Ldw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1ljIV3-003Rn7-U7; Wed, 19 May 2021 09:28:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 141683001DB;
        Wed, 19 May 2021 11:28:21 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EE80B304D8983; Wed, 19 May 2021 11:28:20 +0200 (CEST)
Date:   Wed, 19 May 2021 11:28:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "hasegawa-hitomi@fujitsu.com" <hasegawa-hitomi@fujitsu.com>
Cc:     "'mingo@kernel.org'" <mingo@kernel.org>,
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
Message-ID: <YKTaNJ7r/sHnwb5W@hirez.programming.kicks-ass.net>
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
> 
> And mostly I think the trade-off here is that if you run on nohz_full,
> you're not expected to go do syscalls anyway (because they're sodding
> expensive) and hence the accuracy of these sort of things is mostly
> irrelevant.
> 
> So it might be the use-case is just fundamentally bonkers and we
> shouldn't really bother fixing this.
> 
> Anyway?

Typing be hard... that should 'obviously' be reading: Anyone?

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
