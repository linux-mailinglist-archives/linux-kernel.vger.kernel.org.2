Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEBFE3C1567
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 16:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbhGHOrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 10:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbhGHOrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 10:47:19 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B80C061574
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 07:44:37 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id v17so2895337qvw.12
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 07:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=X8jsAriZ0FZ/8CoPzjOwm+7OQW7LILKmtYoMcbL8c4E=;
        b=e2XZzMPyEhkQ19tZ3n+3mWUjcOMbSnBskJjC2KQVmxqWe8ZlG3Rf1hN7hQpo3TtBjl
         gtNs3/+NfpoQOM9oeJ/5wugB4rLhj0ez1A+DICXi2h8Q2RdzB7I7yb1F+oRQ2NgtAO+N
         Ij+6c2XFfGioIkw1j+ybxeYios8j/DVRuxqqzM8XW7/1hxoH58A1Zb22g0qFJyZW+geD
         xytaK8lCAlvRnU/55X6GZsYYfKCLw1H44lgbbeh1DEqPsunXSXWdTQucFQ5qS5tXMywn
         LN6s4HDipcOdP0SSFUMGyTZ7T4Ipzy8a5cFd7G31hiARJDGTqoXnht8gKFbcyCT8SIS5
         OBiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=X8jsAriZ0FZ/8CoPzjOwm+7OQW7LILKmtYoMcbL8c4E=;
        b=Ue1wQx1QKDj61dZf1VL95DPLYMwPy6sx4FaeJCJIUNKn5FOdUulcImaqPpd6K0omDD
         5CyE56Lf46/XtvbJQAkbeLXP0FTmkKVrGys/T5wNrth8Z0d9UbaCwkTyxYpnOkCS8WzZ
         1yoC2aBvjuRIZr/ryAlbHqLSZMsmPzhhjBcbIwPdHFWqm3vmn5ULwRU7/zk3GbQEY3Bw
         E9BU5n1UaFVZqXMb7Acwnxp15YABEtStuZE6jkKrEagyJAM2I2CesW499E/+dPeQqc+R
         IBU5TczYO5+nxQ34TSDUrsfIR1yX6jivUfD+0ArW7EEJNWhPxNrjdJtL1aOesyVimt+D
         4qHA==
X-Gm-Message-State: AOAM531rsp+AHj48Pyi95yeWq78XYuuwleEJTViH8+YAAF77Ium+lD2x
        S5essgGnY6f4inraKHUXIgz9sQ==
X-Google-Smtp-Source: ABdhPJzuw8oV0eCDdQ6qh6a2I4jEoDje0ZW3Af08iwnP8+VzOgt3uIuOMDO1yv5hwgwZeFxgFSvQaQ==
X-Received: by 2002:a05:6214:21cf:: with SMTP id d15mr30819565qvh.12.1625755476720;
        Thu, 08 Jul 2021 07:44:36 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id g21sm1040748qtp.81.2021.07.08.07.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 07:44:35 -0700 (PDT)
Date:   Thu, 8 Jul 2021 10:44:34 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Suren Baghdasaryan <surenb@google.com>
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
        Wenju Xu =?utf-8?B?KOiuuOaWh+S4vik=?= <wenju.xu@mediatek.com>,
        Jonathan JMChen =?utf-8?B?KOmZs+WutuaYjik=?= 
        <jonathan.jmchen@mediatek.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        kernel-team <kernel-team@android.com>,
        SH Chen <show-hong.chen@mediatek.com>
Subject: Re: [PATCH v3 1/1] psi: stop relying on timer_pending for poll_work
 rescheduling
Message-ID: <YOcPUs97epJ5VrEf@cmpxchg.org>
References: <20210707023933.1691149-1-surenb@google.com>
 <YOWugYxQ9Yfsqba2@cmpxchg.org>
 <CAJuCfpGx22iTaDGCfOrM_pD6PYZqQrni2+u5jQy+NpNeNg7B9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpGx22iTaDGCfOrM_pD6PYZqQrni2+u5jQy+NpNeNg7B9w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 07, 2021 at 03:43:48PM -0700, Suren Baghdasaryan wrote:
> On Wed, Jul 7, 2021 at 6:39 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > This looks good to me now code wise. Just a comment on the comments:
> >
> > On Tue, Jul 06, 2021 at 07:39:33PM -0700, Suren Baghdasaryan wrote:
> > > @@ -559,18 +560,14 @@ static u64 update_triggers(struct psi_group *group, u64 now)
> > >       return now + group->poll_min_period;
> > >  }
> > >
> > > -/* Schedule polling if it's not already scheduled. */
> > > -static void psi_schedule_poll_work(struct psi_group *group, unsigned long delay)
> > > +/* Schedule polling if it's not already scheduled or forced. */
> > > +static void psi_schedule_poll_work(struct psi_group *group, unsigned long delay,
> > > +                                bool force)
> > >  {
> > >       struct task_struct *task;
> > >
> > > -     /*
> > > -      * Do not reschedule if already scheduled.
> > > -      * Possible race with a timer scheduled after this check but before
> > > -      * mod_timer below can be tolerated because group->polling_next_update
> > > -      * will keep updates on schedule.
> > > -      */
> > > -     if (timer_pending(&group->poll_timer))
> > > +     /* xchg should be called even when !force to set poll_scheduled */
> > > +     if (atomic_xchg(&group->poll_scheduled, 1) && !force)
> > >               return;
> >
> > This explains what the code does, but not why. It would be good to
> > explain the ordering with poll_work, here or there. But both sides
> > should mention each other.
> 
> How about this:
> 
> /*
>  * atomic_xchg should be called even when !force to always set poll_scheduled
>  * and to provide a memory barrier (see the comment inside psi_poll_work).
>  */

The memory barrier part makes sense, but the first part says what the
code does and the message is unclear to me. Are you worried somebody
might turn this around in the future and only conditionalize on
poll_scheduled when !force? Essentially, I don't see the downside of
dropping that. But maybe I'm missing something.

	/*
	 * The xchg implies a full barrier that matches the one
	 * in psi_poll_work() (see corresponding comment there).
	 */

> > > @@ -595,6 +595,28 @@ static void psi_poll_work(struct psi_group *group)
> > >
> > >       now = sched_clock();
> > >
> > > +     if (now > group->polling_until) {
> > > +             /*
> > > +              * We are either about to start or might stop polling if no
> > > +              * state change was recorded. Resetting poll_scheduled leaves
> > > +              * a small window for psi_group_change to sneak in and schedule
> > > +              * an immegiate poll_work before we get to rescheduling. One
> > > +              * potential extra wakeup at the end of the polling window
> > > +              * should be negligible and polling_next_update still keeps
> > > +              * updates correctly on schedule.
> > > +              */
> > > +             atomic_set(&group->poll_scheduled, 0);
> > > +             /*
> > > +              * Ensure that operations of clearing group->poll_scheduled and
> > > +              * obtaining changed_states are not reordered.
> > > +              */
> > > +             smp_mb();
> >
> > Same here, it would be good to explain that this is ordering the
> > scheduler with the timer such that no events are missed. Feel free to
> > reuse my race diagram from the other thread - those are better at
> > conveying the situation than freeform text.
> 
> I tried to make your diagram a bit less abstract by using the actual
> names. How about this?
> 
> /*
>  * We need to enforce ordering between poll_scheduled and psi_group_cpu.times
>  * reads and writes in psi_poll_work and psi_group_change functions.
> Otherwise we
>  * might fail to reschedule the timer when monitored states change:
>  *
>  * psi_poll_work:
>  *     poll_scheduled = 0
>  *     smp_mb()
>  *     changed_states = collect_percpu_times()
>  *     if changed_states && xchg(poll_scheduled, 1) == 0
>  *         mod_timer()

Those last two lines aren't relevant for the race, right? I'd leave
those out to not distract from it.

>  * psi_group_change:
>  *     record_times()
>  *     smp_mb()
>  *     if xchg(poll_scheduled, 1) == 0
>  *         mod_timer()

The reason I tend to keep these more abstract is because 1) the names
of the functions change (I had already sent out patches to rename half
the variable and function names in this diagram), while the
architecture (task change vs poll worker) likely won't, and 2) because
it's easy to drown out what the reads, writes, and thus the race
condition is with code details and function call indirections.

How about a compromise?

/*
 * A task change can race with the poll worker that is supposed to
 * report on it. To avoid missing events, ensure ordering between
 * poll_scheduled and the task state accesses, such that if the poll
 * worker misses the state update, the task change is guaranteed to
 * reschedule the poll worker:
 *
 * poll worker:
 *   atomic_set(poll_scheduled, 0)
 *   smp_mb()
 *   LOAD states
 *
 * task change:
 *   STORE states
 *   if atomic_xchg(poll_scheduled, 1) == 0:
 *     schedule poll worker
 *
 * The atomic_xchg() implies a full barrier.
 */
 smp_mb();

This gives a high-level view of what's happening but it can still be
mapped to the code by following the poll_scheduled variable.

> If we remove smp_mb barriers then there are the following possible
> reordering cases:
> 
> Case1: reordering in psi_poll_work
> psi_poll_work                    psi_group_change
>   changed_states = collect_percpu_times()
>                                               record_times()
>                                               if xchg(poll_scheduled,
> 1) == 0 <-- false
>                                                   mod_timer()
>   poll_scheduled = 0
>   if changed_states && xchg(poll_scheduled, 1) == 0 <-- changed_states is false
>       mod_timer()
> 
> Case2: reordering in psi_group_change
> psi_poll_work                    psi_group_change
>                                               if xchg(poll_scheduled,
> 1) == 0 <-- false
>                                                   mod_timer()
>   poll_scheduled = 0
>   changed_states = collect_percpu_times()
>                                                   record_times()
>   if changed_states && xchg(poll_scheduled, 1) == 0 <-- changed_states is false
>       mod_timer()
> 
> In both cases mod_timer() is not called, poll update is missed. But
> describing this all in the comments would be an overkill IMHO.
> WDYT?

Yeah, I also think that's overkill. The failure cases can be derived
from the concurrency diagram and explanation.

Thanks
