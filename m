Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8877423935
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 09:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237595AbhJFHyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 03:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237543AbhJFHyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 03:54:15 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45365C061749
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 00:52:23 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id d131so3407038ybd.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 00:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+wjnwOTyG32VkisCgHZRbPw0jqHyuNgEVt1sPC/JUII=;
        b=CULZHzk8S6gYl6dladsQjJfVMkW/GSP7kGJRcaiG2Ae7oB128jczfpVPkKWhZ6kg1G
         ORo6QZfqehou4cQTu2Zx4SWHGhOGH8Ifv0h1M8YGDcHvg/8PaW0/JGhAIOH8+EqdZzxU
         QNJDBtakAFmpxaM4Cja6M10zA/zpU8dLE/ftCOOIueBF9vlhzAk4xXWMh+Js3rEAZg0m
         PMy1VnnikNG84W5T5Zx/kd+nYneB2QilHUUNNm/IF2DmuB9CDaXQXM3kVKCFp9mXo1aY
         YtN1gdPQ3CortEUmfvUOlqVyr/Sdpn4ZbBPX+/dPd3ZVpS1IEs61nTNSE1A3WqNOrtcP
         LV6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+wjnwOTyG32VkisCgHZRbPw0jqHyuNgEVt1sPC/JUII=;
        b=n/rP9Xr1cEMObVgZMYYt0soAKVCIXPRGW5epJD2T5wZnBPq5evWHOGZZo9ZaGEXVuh
         185qBVdrFhUAwDylIF3qnH6jmEW6IRJ7CGmtsaSqQxJn8vYzc8LvxKkt53sblY+OOZEt
         n8yciNjsBvlXf2l/t27aHgfSiIhlslxWEKImGvrbUifQD/dfv79QXaoKRSn6eE/lKOZc
         /HYz1plqNNt6/80ak0m7t6iRrDR7HIVnYVsumzE6OZ2J9cspbgT25RVWxXHhSvrkjO5v
         lt17+Ryh1LQbWG7uK6DI7qCJ6UiEGd4Le43D2Ccy0qWOsUN9WnAnSzwYNO0/fGwXph9W
         j14Q==
X-Gm-Message-State: AOAM5300pAJIPLmsom0EO3x/T/1U53PUvB2uL/cm+W4Z9OhP9RXUCr1U
        Lgoecj4TaLq0e62QPyBapv0w+Yyhd2KXIt2F9PanPA==
X-Google-Smtp-Source: ABdhPJx6D/wXNMni26YstGT/mGm+228T4t0ZbJimlyTDH7o/tV6755PvMNReqWLoQqGihP1lHhlOgffbufXIeTGm3fU=
X-Received: by 2002:a5b:f03:: with SMTP id x3mr26971274ybr.546.1633506742373;
 Wed, 06 Oct 2021 00:52:22 -0700 (PDT)
MIME-Version: 1.0
References: <20211004171451.24090-1-vincent.guittot@linaro.org>
 <20211004171451.24090-2-vincent.guittot@linaro.org> <20211005204026.GD174703@worktop.programming.kicks-ass.net>
In-Reply-To: <20211005204026.GD174703@worktop.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 6 Oct 2021 09:52:11 +0200
Message-ID: <CAKfTPtB1mS5OsFs+46jzWt-KSgkYGHrTyn1u2qt_k1qrf=4RCw@mail.gmail.com>
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

On Tue, 5 Oct 2021 at 22:41, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Oct 04, 2021 at 07:14:50PM +0200, Vincent Guittot wrote:
> > The time spent to update the blocked load can be significant depending of
> > the complexity fo the cgroup hierarchy. Take this time into account when
> > deciding to stop newidle_balance() because it exceeds the expected idle
> > time.
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  kernel/sched/fair.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 8943dbb94365..1f78b2e3b71c 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -10810,7 +10810,7 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
> >       int this_cpu = this_rq->cpu;
> >       struct sched_domain *sd;
> >       int pulled_task = 0;
> > -     u64 curr_cost = 0;
> > +     u64 t0, domain_cost, curr_cost = 0;
> >
> >       update_misfit_status(NULL, this_rq);
> >
> > @@ -10855,11 +10855,14 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
> >
> >       raw_spin_rq_unlock(this_rq);
> >
> > +     t0 = sched_clock_cpu(this_cpu);
> >       update_blocked_averages(this_cpu);
> > +     domain_cost = sched_clock_cpu(this_cpu) - t0;
> > +     curr_cost += domain_cost;
> > +
> >       rcu_read_lock();
> >       for_each_domain(this_cpu, sd) {
> >               int continue_balancing = 1;
> > -             u64 t0, domain_cost;
> >
> >               if (this_rq->avg_idle < curr_cost + sd->max_newidle_lb_cost) {
> >                       update_next_balance(sd, &next_balance);
>
> Does this make sense? It avoids a bunch of clock calls (and thereby
> accounts more actual time).

Originally, I didn't want to modify the current accounting of
sched_domain but only account the sometime large
update_blocked_averages(). but i agree that we can ensure to account
more actual time
>
> Also, perhaps we should some asymmetric IIR instead of a strict MAX
> filter for max_newidle_lb_cost.

Ok. I'm going to look at this and see how all this goes

>
> ---
> Index: linux-2.6/kernel/sched/fair.c
> ===================================================================
> --- linux-2.6.orig/kernel/sched/fair.c
> +++ linux-2.6/kernel/sched/fair.c
> @@ -10759,9 +10759,9 @@ static int newidle_balance(struct rq *th
>  {
>         unsigned long next_balance = jiffies + HZ;
>         int this_cpu = this_rq->cpu;
> +       u64 t0, t1, curr_cost = 0;
>         struct sched_domain *sd;
>         int pulled_task = 0;
> -       u64 t0, domain_cost, curr_cost = 0;
>
>         update_misfit_status(NULL, this_rq);
>
> @@ -10808,8 +10808,9 @@ static int newidle_balance(struct rq *th
>
>         t0 = sched_clock_cpu(this_cpu);
>         update_blocked_averages(this_cpu);
> -       domain_cost = sched_clock_cpu(this_cpu) - t0;
> -       curr_cost += domain_cost;
> +       t1 = sched_clock_cpu(this_cpu);
> +       curr_cost += t1 - t0;
> +       t0 = t1;
>
>         rcu_read_lock();
>         for_each_domain(this_cpu, sd) {
> @@ -10821,17 +10822,19 @@ static int newidle_balance(struct rq *th
>                 }
>
>                 if (sd->flags & SD_BALANCE_NEWIDLE) {
> -                       t0 = sched_clock_cpu(this_cpu);
> +                       u64 domain_cost;
>
>                         pulled_task = load_balance(this_cpu, this_rq,
>                                                    sd, CPU_NEWLY_IDLE,
>                                                    &continue_balancing);
>
> -                       domain_cost = sched_clock_cpu(this_cpu) - t0;
> +                       t1 = sched_clock_cpu(this_cpu);
> +                       domain_cost = t1 - t0;
>                         if (domain_cost > sd->max_newidle_lb_cost)
>                                 sd->max_newidle_lb_cost = domain_cost;
>
>                         curr_cost += domain_cost;
> +                       t0 = t1;
>                 }
>
>                 update_next_balance(sd, &next_balance);
