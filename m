Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB2C32EF30
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 16:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbhCEPmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 10:42:07 -0500
Received: from foss.arm.com ([217.140.110.172]:55830 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229631AbhCEPly (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 10:41:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 847F711FB;
        Fri,  5 Mar 2021 07:41:53 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 635BF3F73B;
        Fri,  5 Mar 2021 07:41:51 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Qais Yousef <qais.yousef@arm.com>
Cc:     tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, swood@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vincent.donnefort@arm.com, tj@kernel.org,
        ouwen210@hotmail.com
Subject: Re: [PATCH v4 15/19] sched: Fix migrate_disable() vs rt/dl balancing
In-Reply-To: <YEJGq3aKM9lfYked@hirez.programming.kicks-ass.net>
References: <20201023101158.088940906@infradead.org> <20201023102347.499155098@infradead.org> <20201226135445.gkxfn5lmbxhblnj4@e107158-lin> <YEJGq3aKM9lfYked@hirez.programming.kicks-ass.net>
User-Agent: Notmuch/0.21 (http://notmuchmail.org) Emacs/26.3 (x86_64-pc-linux-gnu)
Date:   Fri, 05 Mar 2021 15:41:46 +0000
Message-ID: <jhjblbx7glh.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/03/21 15:56, Peter Zijlstra wrote:
> On Sat, Dec 26, 2020 at 01:54:45PM +0000, Qais Yousef wrote:
>>
>> > +static inline struct task_struct *get_push_task(struct rq *rq)
>> > +{
>> > +	struct task_struct *p = rq->curr;
>>
>> Shouldn't we verify the class of the task here? The RT task in migration
>> disabled could have been preempted by a dl or stopper task. Similarly, the dl
>> task could have been preempted by a stopper task.
>>
>> I don't think an RT task should be allowed to push a dl task under any
>> circumstances?
>
> Hmm, quite. Fancy doing a patch?

Last time we talked about this, I looked into

  push_rt_task() + find_lowest_rq()

IIRC, with how

  find_lowest_rq() + cpupri_find_fitness()

currently work, find_lowest_rq() should return -1 in push_rt_task() if
rq->curr is DL (CPUPRI_INVALID). IOW, Migration-Disabled RT tasks shouldn't
actually interfere with DL tasks (unless a DL task gets scheduled after we
drop the rq lock and kick the stopper, but we have that problem everywhere
including CFS active balance).


Now, for some blabbering. Re SMP invariant; wouldn't we actually want this
to happen? Consider:

  MD := Migration-Disabled.

  rq
           DL
           RT3
           RT2 (MD)   RT1

  current  DL         RT1        idle
           CPU0       CPU1       CPU2

If we were to ignore MD, the best spread for this would be something
like:

  rq
                                 RT1
           DL         RT3        RT2

  current  DL         RT3        RT2
           CPU0       CPU1       CPU2

Now, with Migration-Disabled we can't move RT2 to CPU2 - it has to stay
on CPU0 for as long as it is Migration-Disabled. Thus, a possible spread
would be:

  rq
           RT1
           RT2 (MD)   DL         RT3

  current  RT2        DL         RT3
           CPU0       CPU1       CPU

If you look closely, this is exactly the same as the previous spread
modulo CPU numbers. IOW, this is (again) a CPU renumbering exercise.

To respect the aforementioned scheduling invariant, we've had to move
that DL task, and while it does add interference, it's similar as to why we
push higher RT priority tasks to make room for lower RT priority, migration
disabled tasks. You get interference caused by a lower-priority entity for
the sake of your SMP scheduling invariant.
