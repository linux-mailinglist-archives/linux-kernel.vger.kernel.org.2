Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A032D38C227
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 10:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233232AbhEUInS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 04:43:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:58000 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233093AbhEUInP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 04:43:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DB976AACA;
        Fri, 21 May 2021 08:41:51 +0000 (UTC)
Date:   Fri, 21 May 2021 09:41:47 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     "hasegawa-hitomi@fujitsu.com" <hasegawa-hitomi@fujitsu.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "'fweisbec@gmail.com'" <fweisbec@gmail.com>,
        "'mingo@kernel.org'" <mingo@kernel.org>,
        "'tglx@linutronix.de'" <tglx@linutronix.de>,
        "'juri.lelli@redhat.com'" <juri.lelli@redhat.com>,
        "'vincent.guittot@linaro.org'" <vincent.guittot@linaro.org>,
        "'dietmar.eggemann@arm.com'" <dietmar.eggemann@arm.com>,
        "'rostedt@goodmis.org'" <rostedt@goodmis.org>,
        "'bsegall@google.com'" <bsegall@google.com>,
        "'bristot@redhat.com'" <bristot@redhat.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Utime and stime are less when getrusage (RUSAGE_THREAD) is
 executed on a tickless CPU.
Message-ID: <20210521084147.GG3672@suse.de>
References: <OSBPR01MB21837C8931D90AE55AF4A955EB529@OSBPR01MB2183.jpnprd01.prod.outlook.com>
 <OSBPR01MB2183384B29F6291EB7C0BB81EB2C9@OSBPR01MB2183.jpnprd01.prod.outlook.com>
 <YKN5cQpFSdsgBlBU@hirez.programming.kicks-ass.net>
 <OSBPR01MB21835E55331FCAE6F75E8332EB2B9@OSBPR01MB2183.jpnprd01.prod.outlook.com>
 <YKTZag/E8AaOtVT0@hirez.programming.kicks-ass.net>
 <YKTaNJ7r/sHnwb5W@hirez.programming.kicks-ass.net>
 <OSBPR01MB218357232513BC4EACD0FB59EB299@OSBPR01MB2183.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <OSBPR01MB218357232513BC4EACD0FB59EB299@OSBPR01MB2183.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 06:40:53AM +0000, hasegawa-hitomi@fujitsu.com wrote:
> Hi Peter and Frederic
> 
> 
> > > Would be superfluous for CONFIG_VIRT_CPU_ACCOUNTING_NATIVE=y
> > > architectures at the very least.
> > > 
> > > It also doesn't help any of the other callers, like for example procfs.
> > > 
> > > Something like the below ought to work and fix all variants I think. But
> > > it does make the call significantly more expensive.
> > > 
> > > Looking at thread_group_cputime() that already does something like this,
> > > but that's also susceptible to a variant of this very same issue; since
> > > it doesn't call it unconditionally, nor on all tasks, so if current
> > > isn't part of the threadgroup and/or another task is on a nohz_full cpu,
> > > things will go wobbly again.
> > > 
> > > There's a note about syscall performance there, so clearly someone seems
> > > to care about that aspect of things, but it does suck for nohz_full.
> > > 
> > > Frederic, didn't we have remote ticks that should help with this stuff?
> > > 
> > > And mostly I think the trade-off here is that if you run on nohz_full,
> > > you're not expected to go do syscalls anyway (because they're sodding
> > > expensive) and hence the accuracy of these sort of things is mostly
> > > irrelevant.
> > > 
> > > So it might be the use-case is just fundamentally bonkers and we
> > > shouldn't really bother fixing this.
> > > 
> > > Anyway?
> > 
> > Typing be hard... that should 'obviously' be reading: Anyone?
> 
> 
> I understand that there is a trade-off between performance and accuracy
> and that this issue may have already been discussed.
> However, as Peter mentions, the process of updating sum_exec_runtime
> just before retrieving information is already implemented in
> thread_group_cputime() in the root of RUSAGE_SELF etc. So, I think
> RUSAGE_THREAD should follow suit and implement the same process.
> 

I don't think it's a straight-forward issue. I know we've had to deal with
bugs in the past where the overhead of getting CPU usage statistics was
high enough to dominate workloads that had self-monitoring capabilities to
the extent the self-monitoring was counter-productive. It was particularly
problematic when self-monitoring was being activated to find the source
of a slowdown. I tend to agree with Peter here that the fix may be worse
than the problem ultimately where workloads are not necessarily willing
to pay the cost of accuracy and as he pointed out already, it's expected
nohz_full tasks are avoiding syscalls as much as possible.

-- 
Mel Gorman
SUSE Labs
