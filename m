Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2FC315118
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 15:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbhBIN7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 08:59:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbhBIN6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 08:58:55 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8578DC061786
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 05:58:14 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id h26so2132596lfm.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 05:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bvMNYMa56+JIxS32AeHgVqDy9+iOn3UZSpfo8P5gArs=;
        b=AFn7FCe/X0upq89VDeUCMiUzJrgUxb0NlJ7qXlPyIXhgAbXBjzr+3IT/nf83PCH2eP
         1OiDZo1kuZYYZQaiLwjb8MPPZhd0Grz+v46iT5fgDU4kfL2P1neb6HMZBRp+VKt9aD8Q
         JJJrqpmlD7RAwFy9K4jNvZarr29pMNQaQNUKGuFi0gIibMfhAtaFfDjlQgaCTgM3v0Qq
         V712leLnPerkMoL4+wDWzCbg0SegV0lG2usjPnXOQ2vp86Be7A970YwaxzoKiVFRBWm4
         9iKuX2/YO46Oco88A1H6O1/+A4DIyXh2KeP8/cnw/mICF412dYVOH1rINh6jT3yN4zfb
         ouRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bvMNYMa56+JIxS32AeHgVqDy9+iOn3UZSpfo8P5gArs=;
        b=ORRm1tcGM5tjrOrrDk6opb8sAku4uIuQSOOQ4SuCjdg91yAc/nTRrOq7cGHfsxBheq
         P5ykpK2CE8GfiXPhEV6saPVeNA0uuA5834iRkoeK7Zua6c6PA6wTdyFPbE8/4jznVTxe
         bkGtB0MfdVqs4Vbss+uoRybpfgZj5FXsgB8gfRLtMp5oZolf2sPpo3x81xZBh/drqVWi
         Py7SeWu40z/btkWLJmyIqfI0YVvn5lOFJOFr+zkM273/x3Khh6smyF/ve5z7DZvcbsga
         EMD4TSz0ktcTxYZYs+dKC8DoifBRLIn8umKWnBDCDNHlQN3ZFmpO4iU+aGHOpN6IY8nv
         WN7g==
X-Gm-Message-State: AOAM5325iWWQhOvwyIY1QLrSiVA/8Cu7F78gXipMkRDWrE4ClLy1NuJk
        5sISFcV+ht+H8XIQ3sOvOZ5n+IGwclfel8ueO5Xn2g==
X-Google-Smtp-Source: ABdhPJw9MIrg8CuBNdHGRAEP7RIJzpVt/iXnRhsBRjHvPHB/wWIJlqT2P4quBOY5BVUD52/K1idEfWRtCrV/mGXd6dA=
X-Received: by 2002:ac2:5452:: with SMTP id d18mr5107149lfn.233.1612879091222;
 Tue, 09 Feb 2021 05:58:11 -0800 (PST)
MIME-Version: 1.0
References: <20210205114830.781-1-vincent.guittot@linaro.org>
 <20210205114830.781-6-vincent.guittot@linaro.org> <jhjsg65tmju.mognet@arm.com>
In-Reply-To: <jhjsg65tmju.mognet@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 9 Feb 2021 14:57:59 +0100
Message-ID: <CAKfTPtBshO4kq4EvoOLdo+Dx30fVhKQKUiGGqw13-gtNbK14mA@mail.gmail.com>
Subject: Re: [RFC PATCH 5/6] sched/fair: trigger the update of blocked load on
 newly idle cpu
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Qais Yousef <qais.yousef@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Feb 2021 at 14:09, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> On 05/02/21 12:48, Vincent Guittot wrote:
> > Instead of waking up a random and already idle CPU, we can take advantage
> > of this_cpu being about to enter idle to run the ILB and update the
> > blocked load.
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  include/linux/sched/nohz.h |  2 ++
> >  kernel/sched/fair.c        | 11 ++++++++---
> >  kernel/sched/idle.c        |  6 ++++++
> >  3 files changed, 16 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/linux/sched/nohz.h b/include/linux/sched/nohz.h
> > index 6d67e9a5af6b..74cdc4e87310 100644
> > --- a/include/linux/sched/nohz.h
> > +++ b/include/linux/sched/nohz.h
> > @@ -9,8 +9,10 @@
> >  #if defined(CONFIG_SMP) && defined(CONFIG_NO_HZ_COMMON)
> >  extern void nohz_balance_enter_idle(int cpu);
> >  extern int get_nohz_timer_target(void);
> > +extern void nohz_run_idle_balance(int cpu);
> >  #else
> >  static inline void nohz_balance_enter_idle(int cpu) { }
> > +static inline void nohz_run_idle_balance(int cpu) { }
> >  #endif
> >
> >  #ifdef CONFIG_NO_HZ_COMMON
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 935594cd5430..3d2ab28d5736 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -10461,6 +10461,11 @@ static bool nohz_idle_balance(struct rq *this_rq, enum cpu_idle_type idle)
> >       return true;
> >  }
> >
> > +void nohz_run_idle_balance(int cpu)
> > +{
> > +     nohz_idle_balance(cpu_rq(cpu), CPU_IDLE);
> > +}
> > +
> >  static void nohz_newidle_balance(struct rq *this_rq)
> >  {
> >       int this_cpu = this_rq->cpu;
> > @@ -10482,10 +10487,10 @@ static void nohz_newidle_balance(struct rq *this_rq)
> >               return;
> >
> >       /*
> > -      * Blocked load of idle CPUs need to be updated.
> > -      * Kick an ILB to update statistics.
> > +      * Set the need to trigger ILB in order to update blocked load
> > +      * before entering idle state.
> >        */
> > -     kick_ilb(NOHZ_STATS_KICK);
> > +     this_rq->nohz_idle_balance = NOHZ_STATS_KICK;
> >  }
> >
> >  #else /* !CONFIG_NO_HZ_COMMON */
> > diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> > index 305727ea0677..52a4e9ce2f9b 100644
> > --- a/kernel/sched/idle.c
> > +++ b/kernel/sched/idle.c
> > @@ -261,6 +261,12 @@ static void cpuidle_idle_call(void)
> >  static void do_idle(void)
> >  {
> >       int cpu = smp_processor_id();
> > +
> > +     /*
> > +      * Check if we need to update some blocked load
> > +      */
> > +     nohz_run_idle_balance(cpu);
> > +
>
> What do we gain from doing this here vs having a stats update in
> newidle_balance()?

As mentioned by Joel, newidle_balance is called in the schedule
context with preempt and irq off  which prevent any local activity
like irq/timer. Whereas in this new place, we have the same condition
as during ILB with only preemptoff and _nohz_idle_balance() regularly
checks if it has to abort because something has been scheduled on the
cpu.


>
> The current approach is to have a combined load_balance() + blocked load
> update during newidle, and I get that this can take too long. But then,
> we could still have what you're adding to do_idle() in the tail of
> newidle_balance() itself, no? i.e.
>
>   newidle_balance()
>     ...
>     for_each_domain(this_cpu, sd) {
>        ...
>        pulled_task = load_balance(...);
>        ...
>     }
>     ...
>     if (!pulled_task && !this_rq->nr_running) {
>       this_rq->nohz_idle_balance = NOHZ_STATS_KICK;
>       _nohz_idle_balance();
>     }
>
> or somesuch.
>
> >       /*
> >        * If the arch has a polling bit, we maintain an invariant:
> >        *
> > --
> > 2.17.1
