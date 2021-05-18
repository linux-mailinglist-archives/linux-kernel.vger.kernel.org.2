Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 873A038702D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 05:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242356AbhERDLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 23:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239670AbhERDLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 23:11:36 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A73EC061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 20:10:17 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id n83so453653ybg.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 20:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FuCr/KUNPd4GDw0TEUpxpj57atQ3Dt8IiPXITq5SL04=;
        b=dFIMbBYS32MfH7+17sPIHMkVUoBkya+G2zgahEK1lQXphLfnG6WHUFL87hqEgZzSUO
         lGLYFBaI8HcteWsrQ1P6ffmzEehsJP+eWcD1m6mnecINip7nsKmBeNsTuSuQqbz3AUO0
         RH8lK4gtQDPOFazWG/Ffk9pGFGYfJfbF3wSDNXBYqXANLwNo1P4yxKsesHYffCJCtIXH
         I/RJRX1/yAJN4grq9W7Fra+/Nn98935udVzOxPsDHJNJahYbqlaE8OeTChf8unWpqN+v
         n2snOFZPZgpAGUQw2OcPuJLjt6uDigb4gCt4Ber/ETJZnPXfWUK98riQsyb68a4WH4aM
         RdMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FuCr/KUNPd4GDw0TEUpxpj57atQ3Dt8IiPXITq5SL04=;
        b=VClxTpoGbMatQcpWXJxpbL/bvi4mYL+TGD+cKzOLGTGF/0yPsWn0xYDfa//g51cJRj
         xHlw3WTioWMiHBSqrZroJs8VUcFrxWR5xaWtGGtZq49SrvoYH3KRxooO8a62zBHjZQuj
         1nQnjptXUzVpnRdNhTfHjpKSba1r6CqPQJwaZNobfgNNK5UHfCWuu/0bSwEuHBVr4fRG
         USxEVceWGGMKmIbCHSqvY2aBUkBcVB+kHiao2RfAM3MwN5g2IU2PdCOYuG9T/RbK8bTX
         ZiyBy8isiix+YAcezB6RbdUesbALMas8iZG5XcD/OY7FBSh8aybQhUhF76+eADn79sZ8
         sSuQ==
X-Gm-Message-State: AOAM530oD8A9QCHDJS8wCZ1El33YM0TpFJFEHRkgH6iO07i9AOHHEBKr
        0asRhAQL1Pw9UuhrDeCDCb2tuoB8DYqY+NnNvPo2ew==
X-Google-Smtp-Source: ABdhPJxVfgcr2XITQZTxH11NWJP7/5ZGQgyeeeHSsQ2yAhqYyqUk3GfNAjZfuVzw35ttNm7MdepQyxPpo3ccg2TKZ14=
X-Received: by 2002:a25:8e0e:: with SMTP id p14mr4604270ybl.84.1621307416524;
 Mon, 17 May 2021 20:10:16 -0700 (PDT)
MIME-Version: 1.0
References: <1621303811-5716-1-git-send-email-huangzhaoyang@gmail.com> <CAGWkznFGmQFieMe6=-APBG=ZAYdpWcc27o+W0s=4ZAF5Pzkvjg@mail.gmail.com>
In-Reply-To: <CAGWkznFGmQFieMe6=-APBG=ZAYdpWcc27o+W0s=4ZAF5Pzkvjg@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 17 May 2021 20:10:05 -0700
Message-ID: <CAJuCfpG6mn2zooujkmWc-Wxv5jyvR+sCM45iyBEYF-6iVOv2RQ@mail.gmail.com>
Subject: Re: [PATCH v2] psi: fix race between psi_trigger_create and psimon
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Ziwei Dai <ziwei.dai@unisoc.com>, Ke Wang <ke.wang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 7:16 PM Zhaoyang Huang <huangzhaoyang@gmail.com> wrote:
>
> resend for adding other maintainers in cc
>
> On Tue, May 18, 2021 at 10:11 AM Huangzhaoyang <huangzhaoyang@gmail.com> wrote:
> >
> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >
> > Race detected between psimon_new and psimon_old as shown below, which
> > cause panic by accessing invalid psi_system->poll_wait->wait_queue_entry
> > and psi_system->poll_timer->entry->next. It is not necessary to reinit
> > resource of psi_system when psi_trigger_create.

Please clarify that this fixes a race between psi_trigger_create and
psi_trigger_destroy, when psi_trigger_destroy is destroying the last
trigger in a psi group while racing with psi_trigger_create.

> >
> > psi_trigger_create      psimon_new     psimon_old
> >  init_waitqueue_head                    finish_wait
> >                                           spin_lock(lock_old)
> >         spin_lock_init(lock_new)
> >  wake_up_process(psimon_new)
> >
> >                         finish_wait
> >                           spin_lock(lock_new)
> >                             list_del       list_del

Add:
Fixes: 461daba06bdc ("psi: eliminate kthread_worker from psi trigger
scheduling mechanism")

> >
> > Signed-off-by: ziwei.dai <ziwei.dai@unisoc.com>
> > Signed-off-by: ke.wang <ke.wang@unisoc.com>
> > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > +++
> > v2: change del_timer_sync to del_timer in psi_trigger_destroy

Please see my reply to your original RFC:
https://lore.kernel.org/patchwork/patch/1429498/#1627196
You are still missing:
- removal of timer_setup() in psi_trigger_create()
- removal of an obsolete comment in psi_trigger_destroy()
- you are calling del_timer() from outside of trigger_lock protected
section, which leaves the following race:

psi_trigger_destroy
    mutex_lock(trigger_lock)
    mutex_unlock(trigger_lock)
<preempted>
                       psi_trigger_create
                       psi_group_change
                           psi_schedule_poll_work
                               mod_timer(poll_timer)
<resumes>
    del_timer(poll_timer)

This would lead to deletion of the new poll_timer created by
psi_trigger_create() and would stop periodic psi_poll_work(). This
results in psi trigger not firing when it should. In my suggestion
del_timer() was called under trigger_lock protection which would
prevent psi_trigger_create() from starting a new timer before
psi_trigger_destroy() can call del_timer().

> > +++
> > ---
> >  kernel/sched/psi.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> > index cc25a3c..fe29022 100644
> > --- a/kernel/sched/psi.c
> > +++ b/kernel/sched/psi.c
> > @@ -182,6 +182,8 @@ struct psi_group psi_system = {
> >
> >  static void psi_avgs_work(struct work_struct *work);
> >
> > +static void poll_timer_fn(struct timer_list *t);
> > +
> >  static void group_init(struct psi_group *group)
> >  {
> >         int cpu;
> > @@ -201,6 +203,8 @@ static void group_init(struct psi_group *group)
> >         memset(group->polling_total, 0, sizeof(group->polling_total));
> >         group->polling_next_update = ULLONG_MAX;
> >         group->polling_until = 0;
> > +       init_waitqueue_head(&group->poll_wait);
> > +       timer_setup(&group->poll_timer, poll_timer_fn, 0);
> >         rcu_assign_pointer(group->poll_task, NULL);
> >  }
> >
> > @@ -1157,7 +1161,6 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group,
> >                         return ERR_CAST(task);
> >                 }
> >                 atomic_set(&group->poll_wakeup, 0);
> > -               init_waitqueue_head(&group->poll_wait);
> >                 wake_up_process(task);
> >                 timer_setup(&group->poll_timer, poll_timer_fn, 0);
> >                 rcu_assign_pointer(group->poll_task, task);
> > @@ -1233,7 +1236,7 @@ static void psi_trigger_destroy(struct kref *ref)
> >                  * But it might have been already scheduled before
> >                  * that - deschedule it cleanly before destroying it.
> >                  */
> > -               del_timer_sync(&group->poll_timer);
> > +               del_timer(&group->poll_timer);
> >                 kthread_stop(task_to_destroy);
> >         }
> >         kfree(t);
> > --
> > 1.9.1
> >
