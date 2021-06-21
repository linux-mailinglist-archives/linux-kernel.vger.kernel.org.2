Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA2C33AF24C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 19:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbhFURwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 13:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbhFURwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 13:52:18 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79742C061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 10:50:03 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id f70so32543683qke.13
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 10:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0QYGl9t3B61p3R4Pfjr060utSFzWiSQkdLXIYb/zDdU=;
        b=vQO+htf2wJiurDmp/ETx8qrS2CmegvFArWxmNRlTd53GO3BL2uXW+476bbAtRdYUFv
         fEsY6OoIVJs10HLvz23S12dlzvHszeIwF6GO551jBl8WEE+LGFCY7K4xbrULjQ/Eq0hY
         NXaMinlAkA+NgtTuTBLv5PhO6a/Bxa9YBt1PJvuzJb4dAg3K9Gyv5UU8olcIf7JWUgFl
         69/W4pCrc6556Y/QNohnlHZXxki8z5KuEdyZcgDRHWO3HZzxC+ey0bB1MM1veRGQSxth
         SMmpPWf5ouZ09Rqa4V/LpyEa23oS1ztdts+Dr9DtZhKOjLI3zoTu1ygx5Xy1VhcsT5oK
         huzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0QYGl9t3B61p3R4Pfjr060utSFzWiSQkdLXIYb/zDdU=;
        b=kyZ3s7db+sPo+GDUAOmc/IMAsMKc7sVQIrVd8sfaLxjcW2Dt0trITRj3dP1zgUYaaD
         /In5znWxV52QQ3t/ZsI3c7DHVVE1FvvcDDwzvWXCvaAPMilQj1vsh/gWP6Nwgi+dWeuq
         Y9rnCbEezq81J9yp6AHerHUmfVBiS7lHEwieQ9kkBqh0+TUCMBLuEDuJKk9sRJUQaKOx
         qAyRLKPe/PtLNKcIQd8ubeTS9kctfnhap9y6QViq76MqrUJTFUuVqL4QfzL6xKQedQru
         WwvoZxq92bo1WIM5bq+Aa1w6G0E4n+8jueClFNDysX/dJZb9DeH/v1P45Ig3JKoKPP44
         nV7A==
X-Gm-Message-State: AOAM530U+Qn/4BQiXfD9gFaVt4CUnP1XaTcB+fpyQnpp1uLx15+iNKdv
        1/eGWmAGTxI04VAWLfV/iaDmD6vbSktlNs2uq1EtsQ==
X-Google-Smtp-Source: ABdhPJxVCgsHJS4z4r6vdeC54bjfTB0TRyEX/a1svKHT+Uo7aj0C2k0zBLHPm78uBc2TVzQuxec9cJOeWBPq7YilNes=
X-Received: by 2002:a25:4181:: with SMTP id o123mr12807053yba.23.1624297802325;
 Mon, 21 Jun 2021 10:50:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210617212654.1529125-1-surenb@google.com> <bc8128a17df82dcd0440a9d5a1a7e33135c2a2d3.camel@mediatek.com>
In-Reply-To: <bc8128a17df82dcd0440a9d5a1a7e33135c2a2d3.camel@mediatek.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 21 Jun 2021 10:49:51 -0700
Message-ID: <CAJuCfpGZrwj=4iDyLqzdHNQxb1UxtcQ5wzWim67V+B3BxWsT7A@mail.gmail.com>
Subject: Re: [PATCH 1/1] psi: stop relying on timer_pending for poll_work rescheduling
To:     YT Chang <yt.chang@mediatek.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
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
        =?UTF-8?B?V2VuanUgWHUgKOiuuOaWh+S4vik=?= <wenju.xu@mediatek.com>,
        =?UTF-8?B?Sm9uYXRoYW4gSk1DaGVuICjpmbPlrrbmmI4p?= 
        <jonathan.jmchen@mediatek.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        kernel-team <kernel-team@android.com>,
        show-hong.chen@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 21, 2021 at 5:31 AM YT Chang <yt.chang@mediatek.com> wrote:
>
> On Thu, 2021-06-17 at 14:26 -0700, Suren Baghdasaryan wrote:
> > Psi polling mechanism is trying to minimize the number of wakeups to
> > run psi_poll_work and is currently relying on timer_pending() to
> > detect
> > when this work is already scheduled. This provides a window of
> > opportunity
> > for psi_group_change to schedule an immediate psi_poll_work after
> > poll_timer_fn got called but before psi_poll_work could reschedule
> > itself.
> > Below is the depiction of this entire window:
> >
> > poll_timer_fn
> >   wake_up_interruptible(&group->poll_wait);
> >
> > psi_poll_worker
> >   wait_event_interruptible(group->poll_wait, ...)
> >   psi_poll_work
> >     psi_schedule_poll_work
> >       if (timer_pending(&group->poll_timer)) return;
> >       ...
> >       mod_timer(&group->poll_timer, jiffies + delay);
> >
> > Prior to 461daba06bdc we used to rely on poll_scheduled atomic which
> > was
> > reset and set back inside psi_poll_work and therefore this race
> > window
> > was much smaller.
> > The larger window causes increased number of wakeups and our partners
> > report visible power regression of ~10mA after applying 461daba06bdc.
> > Bring back the poll_scheduled atomic and make this race window even
> > narrower by resetting poll_scheduled only when we reach polling
> > expiration
> > time. This does not completely eliminate the possibility of extra
> > wakeups
> > caused by a race with psi_group_change however it will limit it to
> > the
> > worst case scenario of one extra wakeup per every tracking window
> > (0.5s
> > in the worst case).
> > By tracing the number of immediate rescheduling attempts performed by
> > psi_group_change and the number of these attempts being blocked due
> > to
> > psi monitor being already active, we can assess the effects of this
> > change:
> >
> > Before the patch:
> >                                            Run#1    Run#2      Run#3
> > Immediate reschedules
> > attempted:           684365   1385156    1261240
> > Immediate reschedules
> > blocked:             682846   1381654    1258682
> > Immediate reschedules (delta):             1519     3502       2558
> > Immediate reschedules (% of attempted):    0.22%    0.25%      0.20%
> >
> > After the patch:
> >                                            Run#1    Run#2      Run#3
> > Immediate reschedules attempted:           882244   770298    426218
> > Immediate reschedules blocked:             881996   769796    426074
> > Immediate reschedules (delta):             248      502       144
> > Immediate reschedules (% of attempted):    0.03%    0.07%     0.03%
> >
> > The number of non-blocked immediate reschedules dropped from 0.22-
> > 0.25%
> > to 0.03-0.07%. The drop is attributed to the decrease in the race
> > window
> > size and the fact that we allow this race only when psi monitors
> > reach
> > polling window expiration time.
> >
>
>
> The regression power data points of Android phone in home screen idle:
> Original        :baseline
> Original+ Patch : -21.5% (-11.5mA)

Ok, so this fixes the regression and then some (original regression
was +10mA and with the patch we've got -11.5mA). This must be the
contribution of the additional logic I added to avoid resetting
poll_scheduled when we know that the polling window is not yet over
(line with  /* Polling window is not over, keep rescheduling */
comment).

> Tested-by: SH Chen <show-hong.chen@mediatek.com>

Thanks!

>
> > Fixes: 461daba06bdc ("psi: eliminate kthread_worker from psi trigger
> > scheduling mechanism")
> > Reported-by: Kathleen Chang <yt.chang@mediatek.com>
> > Reported-by: Wenju Xu <wenju.xu@mediatek.com>
> > Reported-by: Jonathan Chen <jonathan.jmchen@mediatek.com>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  include/linux/psi_types.h |  1 +
> >  kernel/sched/psi.c        | 41 ++++++++++++++++++++++++++++---------
> > --
> >  2 files changed, 31 insertions(+), 11 deletions(-)
> >
> > diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
> > index 0a23300d49af..ef8bd89d065e 100644
> > --- a/include/linux/psi_types.h
> > +++ b/include/linux/psi_types.h
> > @@ -158,6 +158,7 @@ struct psi_group {
> >       struct timer_list poll_timer;
> >       wait_queue_head_t poll_wait;
> >       atomic_t poll_wakeup;
> > +     atomic_t poll_scheduled;
> >
> >       /* Protects data used by the monitor */
> >       struct mutex trigger_lock;
> > diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> > index cc25a3cff41f..fed7c9c2b276 100644
> > --- a/kernel/sched/psi.c
> > +++ b/kernel/sched/psi.c
> > @@ -193,6 +193,7 @@ static void group_init(struct psi_group *group)
> >       INIT_DELAYED_WORK(&group->avgs_work, psi_avgs_work);
> >       mutex_init(&group->avgs_lock);
> >       /* Init trigger-related members */
> > +     atomic_set(&group->poll_scheduled, 0);
> >       mutex_init(&group->trigger_lock);
> >       INIT_LIST_HEAD(&group->triggers);
> >       memset(group->nr_triggers, 0, sizeof(group->nr_triggers));
> > @@ -551,18 +552,14 @@ static u64 update_triggers(struct psi_group
> > *group, u64 now)
> >       return now + group->poll_min_period;
> >  }
> >
> > -/* Schedule polling if it's not already scheduled. */
> > -static void psi_schedule_poll_work(struct psi_group *group, unsigned
> > long delay)
> > +/* Schedule polling if it's not already scheduled or forced. */
> > +static void psi_schedule_poll_work(struct psi_group *group, unsigned
> > long delay,
> > +                                bool force)
> >  {
> >       struct task_struct *task;
> >
> > -     /*
> > -      * Do not reschedule if already scheduled.
> > -      * Possible race with a timer scheduled after this check but
> > before
> > -      * mod_timer below can be tolerated because group-
> > >polling_next_update
> > -      * will keep updates on schedule.
> > -      */
> > -     if (timer_pending(&group->poll_timer))
> > +     /* cmpxchg should be called even when !force to set
> > poll_scheduled */
> > +     if (atomic_cmpxchg(&group->poll_scheduled, 0, 1) != 0 &&
> > !force)
> >               return;
> >
> >       rcu_read_lock();
> > @@ -574,12 +571,15 @@ static void psi_schedule_poll_work(struct
> > psi_group *group, unsigned long delay)
> >        */
> >       if (likely(task))
> >               mod_timer(&group->poll_timer, jiffies + delay);
> > +     else
> > +             atomic_set(&group->poll_scheduled, 0);
> >
> >       rcu_read_unlock();
> >  }
> >
> >  static void psi_poll_work(struct psi_group *group)
> >  {
> > +     bool force_reschedule = false;
> >       u32 changed_states;
> >       u64 now;
> >
> > @@ -587,6 +587,23 @@ static void psi_poll_work(struct psi_group
> > *group)
> >
> >       now = sched_clock();
> >
> > +     if (now > group->polling_until) {
> > +             /*
> > +              * We are either about to start or might stop polling
> > if no
> > +              * state change was recorded. Resetting poll_scheduled
> > leaves
> > +              * a small window for psi_group_change to sneak in and
> > schedule
> > +              * an immegiate poll_work before we get to
> > rescheduling. One
> > +              * potential extra wakeup at the end of the polling
> > window
> > +              * should be negligible and polling_next_update still
> > keeps
> > +              * updates correctly on schedule.
> > +              */
> > +             atomic_set(&group->poll_scheduled, 0);
> > +     } else {
> > +             /* Polling window is not over, keep rescheduling */
> > +             force_reschedule = true;
> > +     }
> > +
> > +
> >       collect_percpu_times(group, PSI_POLL, &changed_states);
> >
> >       if (changed_states & group->poll_states) {
> > @@ -612,7 +629,8 @@ static void psi_poll_work(struct psi_group
> > *group)
> >               group->polling_next_update = update_triggers(group,
> > now);
> >
> >       psi_schedule_poll_work(group,
> > -             nsecs_to_jiffies(group->polling_next_update - now) +
> > 1);
> > +             nsecs_to_jiffies(group->polling_next_update - now) + 1,
> > +             force_reschedule);
> >
> >  out:
> >       mutex_unlock(&group->trigger_lock);
> > @@ -736,7 +754,7 @@ static void psi_group_change(struct psi_group
> > *group, int cpu,
> >       write_seqcount_end(&groupc->seq);
> >
> >       if (state_mask & group->poll_states)
> > -             psi_schedule_poll_work(group, 1);
> > +             psi_schedule_poll_work(group, 1, false);
> >
> >       if (wake_clock && !delayed_work_pending(&group->avgs_work))
> >               schedule_delayed_work(&group->avgs_work, PSI_FREQ);
> > @@ -1235,6 +1253,7 @@ static void psi_trigger_destroy(struct kref
> > *ref)
> >                */
> >               del_timer_sync(&group->poll_timer);
> >               kthread_stop(task_to_destroy);
> > +             atomic_set(&group->poll_scheduled, 0);
> >       }
> >       kfree(t);
> >  }
