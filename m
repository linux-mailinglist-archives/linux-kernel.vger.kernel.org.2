Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0531B3C16AC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 17:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbhGHP5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 11:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbhGHP5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 11:57:51 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5AEC061574
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 08:55:08 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id g19so9673982ybe.11
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 08:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6UdkOmJakgL6063lK1x5OJ+9bILb67jEBJSct2Tiyn8=;
        b=eaPCqjssketnN5rcQLUSWjDvRGpF6oO3dJ1xJVgD8FabxO6oIBvzFsHhHN9dnJw6Uv
         4Jka7MrqpRDLVfQKWAntEr2fjDPnojnKDY83XlsUDZlPkTDd0qndi+tmpqQraYDImEvn
         pDQpdBr5WznvEabCqJ8SI9LR5EvC7TmVpWhwzW6t0+/28xIcmn+M4wT1EcbnzwKkGZep
         XEdJtmQl28GDBAAyVym9Wa725bjHP+NEZ6bqbIVkX6E5+PJRLapypmvkE2Z6gGpGaRoJ
         D+E6jFvDSp0Bv3faEEKpZNJrjlbtiQHQg1EqbUTNvReu3qzuiPxT1KnGErgeCL72dVkM
         uRSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6UdkOmJakgL6063lK1x5OJ+9bILb67jEBJSct2Tiyn8=;
        b=OkWmUBPyyb+zccSUm2K/3qjvnuwncHtWgsbkbTf7AjjfiPlSWE4pbV9tvsjH3NZnKw
         f/lgthhKiGxSwoJgGFAPP55P/wYL639qs4ezWu3HJNr2Lqg0fici5d7U/rTZtfS468VB
         1T9FzLfZJNRWdreEUZF71InXXgnK8rV2doNij0x+2PU9lWNEDVffJ9+7sURs8LuAkHtz
         LBK/U+lpg3WIYxgLSbLxxcLKgv2V9+xRke8qXET9NYQFhfuAO7IhDYt6UjKUahdyGZq2
         C/VfFPGbZTkKe2kCDHd+lv4e696dFnXKCoKL7ZUbFlHB2BjiY/xPYLliNTQaenFHeKr8
         cqCg==
X-Gm-Message-State: AOAM531hy1ZLj6y7lnYhgIOXsuUjVGxQ7R/t6+EwFI9V1rwEMIYA82F/
        MnUqo1jwIJJ0RiRUbtnye1RhfRNru25uZxcXXynWWw==
X-Google-Smtp-Source: ABdhPJwwYOeIjOxVMM4ucNHcKJaI3EruSvnu73J6ySxh3Gu3vHUzq8ZicQy+g1ddtn1UGOnk8q/XGE31GxROTVekW+A=
X-Received: by 2002:a25:4102:: with SMTP id o2mr38235336yba.23.1625759707575;
 Thu, 08 Jul 2021 08:55:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210707023933.1691149-1-surenb@google.com> <YOWugYxQ9Yfsqba2@cmpxchg.org>
 <CAJuCfpGx22iTaDGCfOrM_pD6PYZqQrni2+u5jQy+NpNeNg7B9w@mail.gmail.com> <YOcPUs97epJ5VrEf@cmpxchg.org>
In-Reply-To: <YOcPUs97epJ5VrEf@cmpxchg.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 8 Jul 2021 08:54:56 -0700
Message-ID: <CAJuCfpFCi6fa+Ke4bvP9hbMeC82VaT6twNWC3+ckXz6yD0qCtQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] psi: stop relying on timer_pending for poll_work rescheduling
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        matthias.bgg@gmail.com, Minchan Kim <minchan@google.com>,
        Tim Murray <timmurray@google.com>,
        YT Chang <yt.chang@mediatek.com>,
        =?UTF-8?B?V2VuanUgWHUgKOiuuOaWh+S4vik=?= <wenju.xu@mediatek.com>,
        =?UTF-8?B?Sm9uYXRoYW4gSk1DaGVuICjpmbPlrrbmmI4p?= 
        <jonathan.jmchen@mediatek.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        kernel-team <kernel-team@android.com>,
        SH Chen <show-hong.chen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 t

On Thu, Jul 8, 2021 at 7:44 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Wed, Jul 07, 2021 at 03:43:48PM -0700, Suren Baghdasaryan wrote:
> > On Wed, Jul 7, 2021 at 6:39 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > >
> > > This looks good to me now code wise. Just a comment on the comments:
> > >
> > > On Tue, Jul 06, 2021 at 07:39:33PM -0700, Suren Baghdasaryan wrote:
> > > > @@ -559,18 +560,14 @@ static u64 update_triggers(struct psi_group *group, u64 now)
> > > >       return now + group->poll_min_period;
> > > >  }
> > > >
> > > > -/* Schedule polling if it's not already scheduled. */
> > > > -static void psi_schedule_poll_work(struct psi_group *group, unsigned long delay)
> > > > +/* Schedule polling if it's not already scheduled or forced. */
> > > > +static void psi_schedule_poll_work(struct psi_group *group, unsigned long delay,
> > > > +                                bool force)
> > > >  {
> > > >       struct task_struct *task;
> > > >
> > > > -     /*
> > > > -      * Do not reschedule if already scheduled.
> > > > -      * Possible race with a timer scheduled after this check but before
> > > > -      * mod_timer below can be tolerated because group->polling_next_update
> > > > -      * will keep updates on schedule.
> > > > -      */
> > > > -     if (timer_pending(&group->poll_timer))
> > > > +     /* xchg should be called even when !force to set poll_scheduled */
> > > > +     if (atomic_xchg(&group->poll_scheduled, 1) && !force)
> > > >               return;
> > >
> > > This explains what the code does, but not why. It would be good to
> > > explain the ordering with poll_work, here or there. But both sides
> > > should mention each other.
> >
> > How about this:
> >
> > /*
> >  * atomic_xchg should be called even when !force to always set poll_scheduled
> >  * and to provide a memory barrier (see the comment inside psi_poll_work).
> >  */
>
> The memory barrier part makes sense, but the first part says what the
> code does and the message is unclear to me. Are you worried somebody
> might turn this around in the future and only conditionalize on
> poll_scheduled when !force? Essentially, I don't see the downside of
> dropping that. But maybe I'm missing something.

Actually you are right. Originally I was worried that there might be a
case when poll_scheduled==0 and force==true and if someone flips the
conditions we will reschedule the timer but will not set
poll_scheduled back to 1. However I don't think this condition is
possible. We set force=true only when we skipped resetting
poll_schedule to 0 and on initial wakeup we always reset
poll_schedule. How about changing the comment to this:

 /*
  * atomic_xchg should be called even when !force to provide a
  * full memory barrier (see the comment inside psi_poll_work).
  */

>         /*
>          * The xchg implies a full barrier that matches the one
>          * in psi_poll_work() (see corresponding comment there).
>          */
>
> > > > @@ -595,6 +595,28 @@ static void psi_poll_work(struct psi_group *group)
> > > >
> > > >       now = sched_clock();
> > > >
> > > > +     if (now > group->polling_until) {
> > > > +             /*
> > > > +              * We are either about to start or might stop polling if no
> > > > +              * state change was recorded. Resetting poll_scheduled leaves
> > > > +              * a small window for psi_group_change to sneak in and schedule
> > > > +              * an immegiate poll_work before we get to rescheduling. One
> > > > +              * potential extra wakeup at the end of the polling window
> > > > +              * should be negligible and polling_next_update still keeps
> > > > +              * updates correctly on schedule.
> > > > +              */
> > > > +             atomic_set(&group->poll_scheduled, 0);
> > > > +             /*
> > > > +              * Ensure that operations of clearing group->poll_scheduled and
> > > > +              * obtaining changed_states are not reordered.
> > > > +              */
> > > > +             smp_mb();
> > >
> > > Same here, it would be good to explain that this is ordering the
> > > scheduler with the timer such that no events are missed. Feel free to
> > > reuse my race diagram from the other thread - those are better at
> > > conveying the situation than freeform text.
> >
> > I tried to make your diagram a bit less abstract by using the actual
> > names. How about this?
> >
> > /*
> >  * We need to enforce ordering between poll_scheduled and psi_group_cpu.times
> >  * reads and writes in psi_poll_work and psi_group_change functions.
> > Otherwise we
> >  * might fail to reschedule the timer when monitored states change:
> >  *
> >  * psi_poll_work:
> >  *     poll_scheduled = 0
> >  *     smp_mb()
> >  *     changed_states = collect_percpu_times()
> >  *     if changed_states && xchg(poll_scheduled, 1) == 0
> >  *         mod_timer()
>
> Those last two lines aren't relevant for the race, right? I'd leave
> those out to not distract from it.

They did help me illustrate the two failure cases but yeah, someone
who can read the code can derive the rest :)

>
> >  * psi_group_change:
> >  *     record_times()
> >  *     smp_mb()
> >  *     if xchg(poll_scheduled, 1) == 0
> >  *         mod_timer()
>
> The reason I tend to keep these more abstract is because 1) the names
> of the functions change (I had already sent out patches to rename half
> the variable and function names in this diagram), while the
> architecture (task change vs poll worker) likely won't, and 2) because
> it's easy to drown out what the reads, writes, and thus the race
> condition is with code details and function call indirections.

Got it.

>
> How about a compromise?
>
> /*
>  * A task change can race with the poll worker that is supposed to
>  * report on it. To avoid missing events, ensure ordering between
>  * poll_scheduled and the task state accesses, such that if the poll
>  * worker misses the state update, the task change is guaranteed to
>  * reschedule the poll worker:
>  *
>  * poll worker:
>  *   atomic_set(poll_scheduled, 0)
>  *   smp_mb()
>  *   LOAD states
>  *
>  * task change:
>  *   STORE states
>  *   if atomic_xchg(poll_scheduled, 1) == 0:
>  *     schedule poll worker
>  *
>  * The atomic_xchg() implies a full barrier.
>  */
>  smp_mb();
>
> This gives a high-level view of what's happening but it can still be
> mapped to the code by following the poll_scheduled variable.

This looks really good to me.
If you agree on the first comment modification, should I respin the
next version?

>
> > If we remove smp_mb barriers then there are the following possible
> > reordering cases:
> >
> > Case1: reordering in psi_poll_work
> > psi_poll_work                    psi_group_change
> >   changed_states = collect_percpu_times()
> >                                               record_times()
> >                                               if xchg(poll_scheduled,
> > 1) == 0 <-- false
> >                                                   mod_timer()
> >   poll_scheduled = 0
> >   if changed_states && xchg(poll_scheduled, 1) == 0 <-- changed_states is false
> >       mod_timer()
> >
> > Case2: reordering in psi_group_change
> > psi_poll_work                    psi_group_change
> >                                               if xchg(poll_scheduled,
> > 1) == 0 <-- false
> >                                                   mod_timer()
> >   poll_scheduled = 0
> >   changed_states = collect_percpu_times()
> >                                                   record_times()
> >   if changed_states && xchg(poll_scheduled, 1) == 0 <-- changed_states is false
> >       mod_timer()
> >
> > In both cases mod_timer() is not called, poll update is missed. But
> > describing this all in the comments would be an overkill IMHO.
> > WDYT?
>
> Yeah, I also think that's overkill. The failure cases can be derived
> from the concurrency diagram and explanation.
>
> Thanks
