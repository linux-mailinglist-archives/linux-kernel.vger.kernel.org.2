Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C96E045B12E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 02:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233972AbhKXBpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 20:45:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:46412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229729AbhKXBpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 20:45:11 -0500
Received: from rorschach.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 386BF6023E;
        Wed, 24 Nov 2021 01:42:02 +0000 (UTC)
Date:   Tue, 23 Nov 2021 20:42:00 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Aili Yao <yaoaili126@gmail.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, linux-kernel@vger.kernel.org,
        yaoaili@kingsoft.com
Subject: Re: [PATCH] sched/isolation: delete redundant
 housekeeping_overridden check
Message-ID: <20211123204200.0976e065@rorschach.local.home>
In-Reply-To: <20211124092103.64e93376@gmail.com>
References: <20211123154535.48be4399@gmail.com>
        <20211123123852.11a84a9e@gandalf.local.home>
        <20211124092103.64e93376@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Nov 2021 09:21:03 +0800
Aili Yao <yaoaili126@gmail.com> wrote:

> On Tue, 23 Nov 2021 12:38:52 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Tue, 23 Nov 2021 15:45:35 +0800
> > Aili Yao <yaoaili126@gmail.com> wrote:
> >   
> > > From: Aili Yao <yaoaili@kingsoft.com>
> > > 
> > > housekeeping_test_cpu is only called by housekeeping_cpu(),
> > > and in housekeeping_cpu(), there is already one same check;
> > > 
> > > So delete the redundant check.
> > > 
> > > Signed-off-by: Aili Yao <yaoaili@kingsoft.com>
> > > ---
> > >  kernel/sched/isolation.c | 5 ++---
> > >  1 file changed, 2 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> > > index 7f06eaf..5c4d533 100644
> > > --- a/kernel/sched/isolation.c
> > > +++ b/kernel/sched/isolation.c
> > > @@ -56,9 +56,8 @@ void housekeeping_affine(struct task_struct *t, enum
> > > hk_flags flags) 
> > >  bool housekeeping_test_cpu(int cpu, enum hk_flags flags)
> > >  {
> > > -	if (static_branch_unlikely(&housekeeping_overridden))
> > > -		if (housekeeping_flags & flags)
> > > -			return cpumask_test_cpu(cpu,
> > > housekeeping_mask);    
> > 
> > Not only is your email client broken, you don't seem to understand what
> > static_branch_unlikely() is.  
> 
> Yes, My mail client is not properly configured, sorry for that, I will make it work.
> 
> And Yes again, I have limited knowledge about static key, But still don't understand why we
> need two same check(jump or nop instruction?) here, could you be kindly to explain this?


The static branch is a jump and a nop, and the two conditions are not
the same. So nothing above is redundant.

The static_branch_unlikely(&housekeeping_overridden) is a switch that
is either a nop which being an unlikely, is the fast path, and the
content of the if block is the out-of-band condition. That is, the
static branch keeps the expensive if conditional from ever being tested
(because it is "overridden").

Now when it's not overridden, that static branch turns into a jump to
the flags test. Which then performs the expensive conditional compare
against flags to see if it should do the cpumask_test_cpu().

I state "expensive" because compared to a jmp or nop, any branch based
on a test causes cache speculation to be executed. Which means branch
prediction, etc.  The jmp and nop are just like any other atomic
instruction that goes through the pipeline and is considered 100%
predictable, hence it doesn't need the extra logic in the CPU to figure
it out.

The only thing your patch does is remove the optimization of the static
branch logic.

-- Steve
