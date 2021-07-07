Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0EB3BF233
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 00:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbhGGWqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 18:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbhGGWqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 18:46:42 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D53FC061574
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 15:44:00 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id g19so5705625ybe.11
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 15:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JzJsy1Gwb/DpffhxPKiomTMCjSp1XUEhZNn7jP3X0B8=;
        b=fuza8TZG/+wORlx+skCd5tjI1UPpjBQQUA2jFWQg/Oh7e01Dp71R2yZOxJvJLhUGAp
         IglrsozoUeOmc5G9oOAbtLOxiCVc9ofA7T9xmP1zQqUKEuI50+yIsXkqoLyFMYjfLFYu
         vm2JylA/vj+/dNWLUu/XXVy/1e6zIR4xYl48x9A9LkonYmYqw05SB8T6U3RoCfdVAOR6
         Kg4q4L4UkKszzidWs+1OUtf3oEkSWWUIpimNRSDBu8dSid7zqxDgroM7XpjFpI/jhecd
         kIJIRSU43TwvStlVOCs4j837YU79qT1l6Vxix0jq3//bNzfFucfr8h7fuJQjUERfKKD2
         hsXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JzJsy1Gwb/DpffhxPKiomTMCjSp1XUEhZNn7jP3X0B8=;
        b=WDIQ/5kM4/pol85LEZJv94StCoD/J4B+SLhO99HQtH4Ggc6lPowOX49ywQNIJPcEsb
         nG4uH95LNJNvolpN117rpDhXDr3yFAMtQ8BhWxzn/2VkdJLLQtpNSjOYVkvapxUTDjv3
         Y4Ln3e2DFpy7gKLm3KthWpZtsER1ehuQ9fWM37FOXXyR748+W1xsKrusFUhxh5/1S443
         AOExDK+FodmDOjxggWnKkKvsfmQ7BCbfOiYQ+cfXOwMAuXCeU3yL+mnxOw+dvyYZTWTF
         x9SbDT++7gbJXFvwXL9xWepo2k2kL6w4QC2P3unrAR9YUmd/ib+7T4XuE6L55GBNIEzo
         RK6Q==
X-Gm-Message-State: AOAM5316A77VHO1Z26HF9vtHSU3jgGbCr0C4GBSuhMk5GYm4xRurYmFf
        OtoGSCWcWd55XhSYVjO4wOZIwiEjMN0arWlplyE2qLSkR1gbYjZ+
X-Google-Smtp-Source: ABdhPJzjWRdscMuHWjaEPoeIecZQx43oo8ZD+Vf/VQroZQghr+QBugm9G0OPkAw3ywmF0ah7ilDJM/3M9Wex+Mcoki8=
X-Received: by 2002:a25:4102:: with SMTP id o2mr33355128yba.23.1625697839576;
 Wed, 07 Jul 2021 15:43:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210707023933.1691149-1-surenb@google.com> <YOWugYxQ9Yfsqba2@cmpxchg.org>
In-Reply-To: <YOWugYxQ9Yfsqba2@cmpxchg.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 7 Jul 2021 15:43:48 -0700
Message-ID: <CAJuCfpGx22iTaDGCfOrM_pD6PYZqQrni2+u5jQy+NpNeNg7B9w@mail.gmail.com>
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

On Wed, Jul 7, 2021 at 6:39 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> This looks good to me now code wise. Just a comment on the comments:
>
> On Tue, Jul 06, 2021 at 07:39:33PM -0700, Suren Baghdasaryan wrote:
> > @@ -559,18 +560,14 @@ static u64 update_triggers(struct psi_group *group, u64 now)
> >       return now + group->poll_min_period;
> >  }
> >
> > -/* Schedule polling if it's not already scheduled. */
> > -static void psi_schedule_poll_work(struct psi_group *group, unsigned long delay)
> > +/* Schedule polling if it's not already scheduled or forced. */
> > +static void psi_schedule_poll_work(struct psi_group *group, unsigned long delay,
> > +                                bool force)
> >  {
> >       struct task_struct *task;
> >
> > -     /*
> > -      * Do not reschedule if already scheduled.
> > -      * Possible race with a timer scheduled after this check but before
> > -      * mod_timer below can be tolerated because group->polling_next_update
> > -      * will keep updates on schedule.
> > -      */
> > -     if (timer_pending(&group->poll_timer))
> > +     /* xchg should be called even when !force to set poll_scheduled */
> > +     if (atomic_xchg(&group->poll_scheduled, 1) && !force)
> >               return;
>
> This explains what the code does, but not why. It would be good to
> explain the ordering with poll_work, here or there. But both sides
> should mention each other.

How about this:

/*
 * atomic_xchg should be called even when !force to always set poll_scheduled
 * and to provide a memory barrier (see the comment inside psi_poll_work).
 */

>
> > @@ -595,6 +595,28 @@ static void psi_poll_work(struct psi_group *group)
> >
> >       now = sched_clock();
> >
> > +     if (now > group->polling_until) {
> > +             /*
> > +              * We are either about to start or might stop polling if no
> > +              * state change was recorded. Resetting poll_scheduled leaves
> > +              * a small window for psi_group_change to sneak in and schedule
> > +              * an immegiate poll_work before we get to rescheduling. One
> > +              * potential extra wakeup at the end of the polling window
> > +              * should be negligible and polling_next_update still keeps
> > +              * updates correctly on schedule.
> > +              */
> > +             atomic_set(&group->poll_scheduled, 0);
> > +             /*
> > +              * Ensure that operations of clearing group->poll_scheduled and
> > +              * obtaining changed_states are not reordered.
> > +              */
> > +             smp_mb();
>
> Same here, it would be good to explain that this is ordering the
> scheduler with the timer such that no events are missed. Feel free to
> reuse my race diagram from the other thread - those are better at
> conveying the situation than freeform text.

I tried to make your diagram a bit less abstract by using the actual
names. How about this?

/*
 * We need to enforce ordering between poll_scheduled and psi_group_cpu.times
 * reads and writes in psi_poll_work and psi_group_change functions.
Otherwise we
 * might fail to reschedule the timer when monitored states change:
 *
 * psi_poll_work:
 *     poll_scheduled = 0
 *     smp_mb()
 *     changed_states = collect_percpu_times()
 *     if changed_states && xchg(poll_scheduled, 1) == 0
 *         mod_timer()
 *
 * psi_group_change:
 *     record_times()
 *     smp_mb()
 *     if xchg(poll_scheduled, 1) == 0
 *         mod_timer()
 *
 * atomic_xchg in psi_schedule_poll_work implements an implicit memory
barrier but
 * we need an explicit one here.
 */

If we remove smp_mb barriers then there are the following possible
reordering cases:

Case1: reordering in psi_poll_work
psi_poll_work                    psi_group_change
  changed_states = collect_percpu_times()
                                              record_times()
                                              if xchg(poll_scheduled,
1) == 0 <-- false
                                                  mod_timer()
  poll_scheduled = 0
  if changed_states && xchg(poll_scheduled, 1) == 0 <-- changed_states is false
      mod_timer()

Case2: reordering in psi_group_change
psi_poll_work                    psi_group_change
                                              if xchg(poll_scheduled,
1) == 0 <-- false
                                                  mod_timer()
  poll_scheduled = 0
  changed_states = collect_percpu_times()
                                                  record_times()
  if changed_states && xchg(poll_scheduled, 1) == 0 <-- changed_states is false
      mod_timer()

In both cases mod_timer() is not called, poll update is missed. But
describing this all in the comments would be an overkill IMHO.
WDYT?

>
> Thanks
