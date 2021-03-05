Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70E9432F0E2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 18:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbhCERLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 12:11:43 -0500
Received: from foss.arm.com ([217.140.110.172]:57376 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231520AbhCERLR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 12:11:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8310711FB;
        Fri,  5 Mar 2021 09:11:17 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (unknown [10.1.195.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6835C3F766;
        Fri,  5 Mar 2021 09:11:15 -0800 (PST)
Date:   Fri, 5 Mar 2021 17:11:13 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
        mingo@kernel.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, swood@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vincent.donnefort@arm.com, tj@kernel.org,
        ouwen210@hotmail.com
Subject: Re: [PATCH v4 15/19] sched: Fix migrate_disable() vs rt/dl balancing
Message-ID: <20210305171113.lumrv4m5zdaqhxwn@e107158-lin.cambridge.arm.com>
References: <20201023101158.088940906@infradead.org>
 <20201023102347.499155098@infradead.org>
 <20201226135445.gkxfn5lmbxhblnj4@e107158-lin>
 <YEJGq3aKM9lfYked@hirez.programming.kicks-ass.net>
 <jhjblbx7glh.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <jhjblbx7glh.mognet@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/05/21 15:41, Valentin Schneider wrote:
> On 05/03/21 15:56, Peter Zijlstra wrote:
> > On Sat, Dec 26, 2020 at 01:54:45PM +0000, Qais Yousef wrote:
> >>
> >> > +static inline struct task_struct *get_push_task(struct rq *rq)
> >> > +{
> >> > +	struct task_struct *p = rq->curr;
> >>
> >> Shouldn't we verify the class of the task here? The RT task in migration
> >> disabled could have been preempted by a dl or stopper task. Similarly, the dl
> >> task could have been preempted by a stopper task.
> >>
> >> I don't think an RT task should be allowed to push a dl task under any
> >> circumstances?
> >
> > Hmm, quite. Fancy doing a patch?
> 
> Last time we talked about this, I looked into
> 
>   push_rt_task() + find_lowest_rq()
> 
> IIRC, with how
> 
>   find_lowest_rq() + cpupri_find_fitness()
> 
> currently work, find_lowest_rq() should return -1 in push_rt_task() if
> rq->curr is DL (CPUPRI_INVALID). IOW, Migration-Disabled RT tasks shouldn't

[...]

> If you look closely, this is exactly the same as the previous spread
> modulo CPU numbers. IOW, this is (again) a CPU renumbering exercise.

I don't see it a re-numbering exercise. The way I understand it a system
designer doesn't expect their DL task to move because of an RT task. I think we
should try to keep it this way, that's why I asked.

To be fair, I need to look at the code again and understand where I missed that
3rd condition Peter mentioned.

Thanks

--
Qais Yousef
