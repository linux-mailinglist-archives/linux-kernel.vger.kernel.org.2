Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E47113AE58F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 11:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbhFUJFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 05:05:45 -0400
Received: from foss.arm.com ([217.140.110.172]:58904 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230409AbhFUJFj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 05:05:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A81F31FB;
        Mon, 21 Jun 2021 02:03:25 -0700 (PDT)
Received: from e120877-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 895913F718;
        Mon, 21 Jun 2021 02:03:24 -0700 (PDT)
Date:   Mon, 21 Jun 2021 10:03:13 +0100
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] sched/rt: Fix RT utilization tracking during policy
 change
Message-ID: <20210621090312.GA193194@e120877-lin.cambridge.arm.com>
References: <1624023139-66147-1-git-send-email-vincent.donnefort@arm.com>
 <CAKfTPtDgLRYdFNY_A3=yXk-LXi-eH21xApAaYfYk_RbG4k61EQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtDgLRYdFNY_A3=yXk-LXi-eH21xApAaYfYk_RbG4k61EQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

> >         /*
> > -        * If we are already running, then there's nothing
> > -        * that needs to be done. But if we are not running
> > -        * we may need to preempt the current running task.
> > -        * If that current running task is also an RT task
> > +        * If we are not running we may need to preempt the current
> > +        * running task. If that current running task is also an RT task
> >          * then see if we can move to another run queue.
> >          */
> >         if (task_on_rq_queued(p) && rq->curr != p) {
> > @@ -2355,6 +2353,13 @@ static void switched_to_rt(struct rq *rq, struct task_struct *p)
> >                 if (p->prio < rq->curr->prio && cpu_online(cpu_of(rq)))
> >                         resched_curr(rq);
> >         }
> > +
> > +       /*
> > +        * If we are running, update the avg_rt tracking, as the running time
> > +        * will now on be accounted into the latter.
> > +        */
> > +       if (task_current(rq, p))
> 
> task_current(rq,p) equals the "rq->curr != p" above. Having 2
> different ways to get the same value in the function is a bit
> confusing.
> 
> And call it once
> 
> Otherwise, the fix looks good to me

I can change it to something like:

if (task_current(rq, p)) {
    update_rt_rq_load_avg()
    return;
}

if (task_on_rq_queued(p) {
        ...
	if (p->prio ...)
		resched_curr(rq);
}

?

> 
> > +               update_rt_rq_load_avg(rq_clock_pelt(rq), rq, 0);
> >  }
> >
> >  /*
> > --
> > 2.7.4
> >
