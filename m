Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5402F42398E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 10:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237595AbhJFIS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 04:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbhJFIS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 04:18:57 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C438C061749
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 01:17:05 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id v195so3646809ybb.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 01:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pmmhFOC1eGQqWNdCD2oXeRhxkWl3SVRsiO0O0PRqpR8=;
        b=fV3pbLi/bVGdKBbGI3oJLndMQfVyKVAILPKFng4EZjPWxWvtYnAMn26e3bcWgMmJHR
         8zRo7jsG2HJL3hICyl6iEBlUIEIlAde5uEqv8Opx0H2u8V2NyASlZVVYWYrtQGVe0CJI
         G1aoLZcfHdNze/Ct5B0IRCEy0xkipc8ShJhCwrsFdcvJuwEG/QPRG/T3ADGPWC04YA1j
         dcTOxxYllaXZVUp/zbIykMd7Q7MiaLnJHISTymMH/mQ2ODctHhtvnZ0kmZtrUsYFHjzc
         ExDH2xvV/+ga0XQ6lVy/khouJ6NZ6tmCZCYzU/g/Xq2cue1dcumuLprXaHcV8NMCvoPt
         wmxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pmmhFOC1eGQqWNdCD2oXeRhxkWl3SVRsiO0O0PRqpR8=;
        b=xqJQA/nRvyZcpeDb6jDXN6NX1JpCJSbcWGSbWVmJ8y2HyeC294iqUqaTfD7CqWETjW
         yGKz8JXtl0Aq/V3R1jKjDIyh1oMMmWApWP6vIwcN7j9UoDeoJelNOfYr/UM0ES1hz09D
         ypQnlQLPRlHAPyKSUvpEtdU0eWgViKxCyASk5Paq9gRsg1Pg3EuO2M7aDwyw3H7vYFV+
         pwoG/XmJN+fx6+XFeChQ0smLfFLzYjGUKZny4d29VH3muscopr7D2w7n8D7FSqKWs5pk
         V2j/6079Wj1Z/39YUyBfEZfXZdMBvmQ6xLQPwcDbkUpuvNS6HP6xs8P4fxxd6B+8eKco
         4VYg==
X-Gm-Message-State: AOAM531l9swPLP+Vcg6ragwyLH9zI26TAxQhbYoYVlu9SL3Jqv1Ez/0Z
        EG62mt4PESTV+U+sy5QS9EXnh4vEC4UbDs1IDG0m8g==
X-Google-Smtp-Source: ABdhPJy9zht0Q4YntS6iVFMXYl4metuOo+LD28IKs89NBF6G0Z4RR5a12RyMUP9WXECXCl0bBVal+I53SVITDm6JNp4=
X-Received: by 2002:a25:45d4:: with SMTP id s203mr28976893yba.425.1633508224811;
 Wed, 06 Oct 2021 01:17:04 -0700 (PDT)
MIME-Version: 1.0
References: <20211004171451.24090-1-vincent.guittot@linaro.org>
 <20211004171451.24090-2-vincent.guittot@linaro.org> <20211005204026.GD174703@worktop.programming.kicks-ass.net>
 <CAKfTPtB1mS5OsFs+46jzWt-KSgkYGHrTyn1u2qt_k1qrf=4RCw@mail.gmail.com>
In-Reply-To: <CAKfTPtB1mS5OsFs+46jzWt-KSgkYGHrTyn1u2qt_k1qrf=4RCw@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 6 Oct 2021 10:16:53 +0200
Message-ID: <CAKfTPtA9DWZsG8o3hujD6cLo3m6ZTNraqkp7Za1RPYhsymH7vw@mail.gmail.com>
Subject: Re: [PATCH 1/2] sched/fair: account update_blocked_averages in
 newidle_balance cost
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

On Wed, 6 Oct 2021 at 09:52, Vincent Guittot <vincent.guittot@linaro.org> wrote:
>
> On Tue, 5 Oct 2021 at 22:41, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Mon, Oct 04, 2021 at 07:14:50PM +0200, Vincent Guittot wrote:
> > > The time spent to update the blocked load can be significant depending of
> > > the complexity fo the cgroup hierarchy. Take this time into account when
> > > deciding to stop newidle_balance() because it exceeds the expected idle
> > > time.
> > >
> > > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > ---
> > >  kernel/sched/fair.c | 7 +++++--
> > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index 8943dbb94365..1f78b2e3b71c 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -10810,7 +10810,7 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
> > >       int this_cpu = this_rq->cpu;
> > >       struct sched_domain *sd;
> > >       int pulled_task = 0;
> > > -     u64 curr_cost = 0;
> > > +     u64 t0, domain_cost, curr_cost = 0;
> > >
> > >       update_misfit_status(NULL, this_rq);
> > >
> > > @@ -10855,11 +10855,14 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
> > >
> > >       raw_spin_rq_unlock(this_rq);
> > >
> > > +     t0 = sched_clock_cpu(this_cpu);
> > >       update_blocked_averages(this_cpu);
> > > +     domain_cost = sched_clock_cpu(this_cpu) - t0;
> > > +     curr_cost += domain_cost;
> > > +
> > >       rcu_read_lock();
> > >       for_each_domain(this_cpu, sd) {
> > >               int continue_balancing = 1;
> > > -             u64 t0, domain_cost;
> > >
> > >               if (this_rq->avg_idle < curr_cost + sd->max_newidle_lb_cost) {
> > >                       update_next_balance(sd, &next_balance);
> >
> > Does this make sense? It avoids a bunch of clock calls (and thereby
> > accounts more actual time).
>
> Originally, I didn't want to modify the current accounting of
> sched_domain but only account the sometime large
> update_blocked_averages(). but i agree that we can ensure to account
> more actual time
> >
> > Also, perhaps we should some asymmetric IIR instead of a strict MAX
> > filter for max_newidle_lb_cost.
>
> Ok. I'm going to look at this and see how all this goes
>
> >
> > ---
> > Index: linux-2.6/kernel/sched/fair.c
> > ===================================================================
> > --- linux-2.6.orig/kernel/sched/fair.c
> > +++ linux-2.6/kernel/sched/fair.c
> > @@ -10759,9 +10759,9 @@ static int newidle_balance(struct rq *th
> >  {
> >         unsigned long next_balance = jiffies + HZ;
> >         int this_cpu = this_rq->cpu;
> > +       u64 t0, t1, curr_cost = 0;
> >         struct sched_domain *sd;
> >         int pulled_task = 0;
> > -       u64 t0, domain_cost, curr_cost = 0;
> >
> >         update_misfit_status(NULL, this_rq);
> >
> > @@ -10808,8 +10808,9 @@ static int newidle_balance(struct rq *th
> >
> >         t0 = sched_clock_cpu(this_cpu);
> >         update_blocked_averages(this_cpu);
> > -       domain_cost = sched_clock_cpu(this_cpu) - t0;

I wonder if we should not include the duration of
update_blocked_averages() in the 1st domain cost ?
To make sure that we will not update it but finally abort before
running the 1st domain because there is not enough remaining time

> > -       curr_cost += domain_cost;
> > +       t1 = sched_clock_cpu(this_cpu);
> > +       curr_cost += t1 - t0;
> > +       t0 = t1;
> >
> >         rcu_read_lock();
> >         for_each_domain(this_cpu, sd) {
> > @@ -10821,17 +10822,19 @@ static int newidle_balance(struct rq *th
> >                 }
> >
> >                 if (sd->flags & SD_BALANCE_NEWIDLE) {
> > -                       t0 = sched_clock_cpu(this_cpu);
> > +                       u64 domain_cost;
> >
> >                         pulled_task = load_balance(this_cpu, this_rq,
> >                                                    sd, CPU_NEWLY_IDLE,
> >                                                    &continue_balancing);
> >
> > -                       domain_cost = sched_clock_cpu(this_cpu) - t0;
> > +                       t1 = sched_clock_cpu(this_cpu);
> > +                       domain_cost = t1 - t0;
> >                         if (domain_cost > sd->max_newidle_lb_cost)
> >                                 sd->max_newidle_lb_cost = domain_cost;
> >
> >                         curr_cost += domain_cost;
> > +                       t0 = t1;
> >                 }
> >
> >                 update_next_balance(sd, &next_balance);
