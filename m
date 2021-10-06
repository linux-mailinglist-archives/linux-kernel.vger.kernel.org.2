Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCB3E42397E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 10:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237804AbhJFIO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 04:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237620AbhJFIO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 04:14:57 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358A7C061749
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 01:13:05 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id s64so3434073yba.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 01:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mrWi2f85xU1vwxPgVcufsqkChpl6Q7lP2sAlGH+NLkA=;
        b=sCibBKKAVL38wgrfDbr1Pu9dFmi8YrPAScC8Y4vJkv5Y8GO8BWgRzAZDP1s8a5s4Mu
         hEQTxk+UWyM3/3Ep7cUObJHm3fcHD2+rRY8pHtK+lVrbkvk2f9mV1D8CDHxqL/8XMA8z
         e2CWI3I6w34Q+fMbJUAShrZ/qKzQT6qKojY3elxMc5xcjazsesiSJ2ZrSbZbb3sl8ncH
         ogODsMJVeY/4StfPE1BINLt/dBlagtdJ/Oyu0R+fzkbkcBGRmZ82ouSUyRPGX1ICyXYw
         CDbMY0p2fOppD0q5bPwkXApfav/xWfyA7O8/E0u30bGpUzBApz+CDJtvKdopkjJ5eohY
         bAPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mrWi2f85xU1vwxPgVcufsqkChpl6Q7lP2sAlGH+NLkA=;
        b=6irZX7mE31VE4jvy93oJjQVz7yFgj+X1iUfQOjPoPSu1m61o8eUCq/TUdj/8qxsJ+v
         UAJyc37AlkeaE1Hh32YzeMkOctY1HND1gY/LRL10w6En6A0aAQHSjCoxtLMTcKQBGecA
         CngwSI9dDxN+IycmPpGzyIdmNqPM4m3dnh56vy/M0lrkpLmd0b+TAucv4dpIb3J0JgtU
         Dic7glXV0CUNVWVFHoOEzOY41Cw/8AKAT7/gb7rQfK1gmQ4687GjTklIb8E3BEqasVC/
         5VpdiqXzNsiaTffMJnh7Qfb29RwUgblwgBGgnoaA8XnxDtrMJ5dHZjPrHPrvLCb3STw9
         ODBw==
X-Gm-Message-State: AOAM531Py8PVutguImf3EdaY8VBx57SAXc1etYoQbkHIX5MRt6oS8sXp
        h+XmyPgLTkyw2ejOPpvJUaGaKyIfXdtOYxNrCJecOQ==
X-Google-Smtp-Source: ABdhPJzQFUVqad5MuoN/Fl0N9sSKqmjYU8Rdq1SBAysTEfD15BrZ14j06iBbH3Wo8qlCQOI8TQF1VVHvtfJWTBwQxpo=
X-Received: by 2002:a25:2f8e:: with SMTP id v136mr26653797ybv.350.1633507984359;
 Wed, 06 Oct 2021 01:13:04 -0700 (PDT)
MIME-Version: 1.0
References: <20211004171451.24090-1-vincent.guittot@linaro.org>
 <20211004171451.24090-3-vincent.guittot@linaro.org> <20211005204927.GE174703@worktop.programming.kicks-ass.net>
In-Reply-To: <20211005204927.GE174703@worktop.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 6 Oct 2021 10:12:53 +0200
Message-ID: <CAKfTPtB18AeemQ9pybwmx3gS9tedYLCUT8xSMM7TzHZY-qzwHQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] sched/fair: Skip update_blocked_averages if we are
 defering load balance
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Oct 2021 at 22:49, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Oct 04, 2021 at 07:14:51PM +0200, Vincent Guittot wrote:
> > In newidle_balance(), the scheduler skips load balance to the new idle cpu
> > when the 1st sd of this_rq is:
> >
> >    this_rq->avg_idle < sd->max_newidle_lb_cost
> >
> > Doing a costly call to update_blocked_averages() will not be useful and
> > simply adds overhead when this condition is true.
> >
> > Check the condition early in newidle_balance() to skip
> > update_blocked_averages() when possible.
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> > ---
> >  kernel/sched/fair.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 1f78b2e3b71c..1294b78503d9 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -10841,17 +10841,20 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
> >        */
> >       rq_unpin_lock(this_rq, rf);
> >
> > +     rcu_read_lock();
> > +     sd = rcu_dereference_check_sched_domain(this_rq->sd);
> > +
> >       if (this_rq->avg_idle < sysctl_sched_migration_cost ||
> > -         !READ_ONCE(this_rq->rd->overload)) {
> > +             !READ_ONCE(this_rq->rd->overload) ||
> > +             (sd && this_rq->avg_idle < sd->max_newidle_lb_cost)) {
>
> set cino=(0:0, please.
>
> Also, people have, in the past, tried to get rid of the first clause
> here, perhaps this can replace it instead of augment it?

Yes, that's a good point.
either sd->max_newidle_lb_cost >= sysctl_sched_migration_cost and the
current condition is covered by the new condition
or sd->max_newidle_lb_cost < sysctl_sched_migration_cost and we will
run newidle balance. But this also means that we have time to run the
newly idle LB

>
> >
> > -             rcu_read_lock();
> > -             sd = rcu_dereference_check_sched_domain(this_rq->sd);
> >               if (sd)
> >                       update_next_balance(sd, &next_balance);
> >               rcu_read_unlock();
> >
> >               goto out;
> >       }
> > +     rcu_read_unlock();
>
> There's another rcu_read_lock section right below this, at the very
> least we can merge them.

we release the rq lock in between which adds more conditions to check
to all situations

>
> Also, IIRC we're running all this with premption disabled, and since
> rcu-sched got folded into rcu, all that rcu_read_*lock() stuff isn't
> strictly required anymore.
>
> (we're full circle there, back in the day RCU implied RCU-sched and the
> scheduler relied on preempt-disable for lots of this stuff, then Paul
> split them, and I spend a fair amount of time adding all this
> rcu_read_*lock() crud, and now he's merge them again, and it can go
> again).
>
> Except of course, I think we need to make rcu_dereference_check happy
> first :/
