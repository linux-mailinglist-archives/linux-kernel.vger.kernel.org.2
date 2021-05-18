Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 090EF386E67
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 02:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345074AbhERAnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 20:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239351AbhERAnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 20:43:02 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCEAC061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 17:41:45 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id a22so7713830qkl.10
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 17:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IL6fo34EfWMFpnXZyScGEY1OCLmf06KwslOAvmhdV5c=;
        b=G13cJxBFuuNgvISCw8xxLOag94s2okvsuzL+kzN4+ws7FqqzaDrXDULXB5qCg5liPg
         Tn6UwulUnZdlCqFumOFrO1zCPse8AfhTKPenPMi/XO+iuv8njI6x70mlskr9FOD0aQt0
         381x/NbMxn5MztIEqeWl+ZSWgaJ4GeK0UDYRlP8UHwO5nBOXiTFGAuu4y249gNeG3M1h
         PDrM/Lqm9IVBSOMzVShJzlN1KdWE+3+pGweeTsFIbuP+CZ0LtiW8hn9Ii2g9wpxga7IR
         vaf6ZRU7uN2vUdBvbg5oLxqvQD2a8K9L1eoETYA60KZyzO4WIUcc2JUkH92ITUhq/dNp
         QQeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IL6fo34EfWMFpnXZyScGEY1OCLmf06KwslOAvmhdV5c=;
        b=EEmBQr6+ykEa9PINnZ1jdNxEUjYkybHZTWHzaj7sE113ygv/nVWg1gkcw3ooQ7SLrw
         FxbmI5v3VHgQR1eH7WCZI+rdqp6uN6GkvpTaAhyc2vAPoCk3GCgYV5/7lBLLTXe0MTFY
         yRTg+qpWeMhhQjMawk0M0tCvzdQ2RKQrs3szMOmcxMbXVvEWI6hHVB12hokCCbQqjfl8
         FSAW9JoR363S6oOGkXyVzUapQcnVvlPqpGrbvbzdVYYf0NXIrikXmSFXZqtVV6HFjpAF
         C0fwzB+N8SSg6pupffjBNx36KcGPEz20VAwn7auECrqZrh72x7KUB4kwHXYR805Soa8Z
         LVBQ==
X-Gm-Message-State: AOAM530xLxf4q5VJNXoJdf2f5gr8edIwqLurjet/0IzEnriKTI4ok16Z
        EvDLo3PxZ4TlghAsLRyAfG5cGjANItbT4A+zoko=
X-Google-Smtp-Source: ABdhPJwfBRXk2quNlV7JBYmG5T0z4omsGq7/g4AmjifWPU2aB2qj9CeY1Qn2+BavAv4y8i8rVgK7HjSn2rquZRiEP0g=
X-Received: by 2002:a05:620a:1036:: with SMTP id a22mr2761386qkk.186.1621298505213;
 Mon, 17 May 2021 17:41:45 -0700 (PDT)
MIME-Version: 1.0
References: <1621242249-8314-1-git-send-email-huangzhaoyang@gmail.com>
 <YKK3wgrhqzaiE7rQ@cmpxchg.org> <CAJuCfpGLTkvH6CzQXz4oD39_xtArBt3upk-F=gf4-LPoswagGg@mail.gmail.com>
 <CAJuCfpE+Z3O_5PfDg8rEB7Cj+nMbsGPp_eWF6rRz8h2YJhy+PA@mail.gmail.com>
In-Reply-To: <CAJuCfpE+Z3O_5PfDg8rEB7Cj+nMbsGPp_eWF6rRz8h2YJhy+PA@mail.gmail.com>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Tue, 18 May 2021 08:40:17 +0800
Message-ID: <CAGWkznEMxa7BL3hih+adOEhOg5p5qiSgNaERdLjDqk_JNMv1Hg@mail.gmail.com>
Subject: Re: [[RFC]PATCH] psi: fix race between psi_trigger_create and psimon
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Ziwei Dai <ziwei.dai@unisoc.com>, Ke Wang <ke.wang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 5:30 AM Suren Baghdasaryan <surenb@google.com> wrote:
>
> On Mon, May 17, 2021 at 12:33 PM Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > On Mon, May 17, 2021 at 11:36 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > >
> > > CC Suren
> >
> > Thanks!
> >
> > >
> > > On Mon, May 17, 2021 at 05:04:09PM +0800, Huangzhaoyang wrote:
> > > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > > >
> > > > Race detected between psimon_new and psimon_old as shown below, which
> > > > cause panic by accessing invalid psi_system->poll_wait->wait_queue_entry
> > > > and psi_system->poll_timer->entry->next. It is not necessary to reinit
> > > > resource of psi_system when psi_trigger_create.
> >
> > resource of psi_system will not be reinitialized because
> > init_waitqueue_head(&group->poll_wait) and friends are initialized
> > only during the creation of the first trigger for that group (see this
> > condition: https://elixir.bootlin.com/linux/latest/source/kernel/sched/psi.c#L1119).
> >
> > > >
> > > > psi_trigger_create      psimon_new     psimon_old
> > > >  init_waitqueue_head                    finish_wait
> > > >                                           spin_lock(lock_old)
> > > >       spin_lock_init(lock_new)
> > > >  wake_up_process(psimon_new)
> > > >
> > > >                         finish_wait
> > > >                           spin_lock(lock_new)
> > > >                             list_del       list_del
> >
> > Could you please clarify this race a bit? I'm having trouble
> > deciphering this diagram. I'm guessing psimon_new/psimon_old refer to
> > a new trigger being created while an old one is being deleted, so it
> > seems like a race between psi_trigger_create/psi_trigger_destroy. The
> > combination of trigger_lock and RCU should be protecting us from that
> > but maybe I missed something?
> > I'm excluding a possibility of a race between psi_trigger_create with
> > another existing trigger on the same group because the codepath
> > calling init_waitqueue_head(&group->poll_wait) happens only when the
> > first trigger for that group is created. Therefore if there is an
> > existing trigger in that group that codepath will not be taken.
>
> Ok, looking at the current code I think you can hit the following race
> when psi_trigger_destroy is destroying the last trigger in a psi group
> while racing with psi_trigger_create:
>
> psi_trigger_destroy                      psi_trigger_create
> mutex_lock(trigger_lock);
> rcu_assign_pointer(poll_task, NULL);
> mutex_unlock(trigger_lock);
>                                                     mutex_lock(trigger_lock);
>                                                     if
> (!rcu_access_pointer(group->poll_task)) {
>
> timer_setup(poll_timer, poll_timer_fn, 0);
>
> rcu_assign_pointer(poll_task, task);
>                                                     }
>                                                     mutex_unlock(trigger_lock);
>
> synchronize_rcu();
> del_timer_sync(poll_timer); <-- poll_timer has been reinitialized by
> psi_trigger_create
>
> So, trigger_lock/RCU correctly protects destruction of
> group->poll_task but misses this race affecting poll_timer and
> poll_wait.
> Let me think if we can handle this without moving initialization into
> group_init().
Right, this is exactly what we met during a monkey test on an android
system, where the psimon will be destroyed/recreated by unref/recreate
the psi_trigger. IMHO,  poll_timer and poll_wait should exist during
whole period
>
> >
> > > >
> > > > Signed-off-by: ziwei.dai <ziwei.dai@unisoc.com>
> > > > Signed-off-by: ke.wang <ke.wang@unisoc.com>
> > > > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > > > ---
> > > >  kernel/sched/psi.c | 6 ++++--
> > > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> > > > index cc25a3c..d00e585 100644
> > > > --- a/kernel/sched/psi.c
> > > > +++ b/kernel/sched/psi.c
> > > > @@ -182,6 +182,8 @@ struct psi_group psi_system = {
> > > >
> > > >  static void psi_avgs_work(struct work_struct *work);
> > > >
> > > > +static void poll_timer_fn(struct timer_list *t);
> > > > +
> > > >  static void group_init(struct psi_group *group)
> > > >  {
> > > >       int cpu;
> > > > @@ -201,6 +203,8 @@ static void group_init(struct psi_group *group)
> > > >       memset(group->polling_total, 0, sizeof(group->polling_total));
> > > >       group->polling_next_update = ULLONG_MAX;
> > > >       group->polling_until = 0;
> > > > +     init_waitqueue_head(&group->poll_wait);
> > > > +     timer_setup(&group->poll_timer, poll_timer_fn, 0);
> > >
> > > This makes sense.
> >
> > Well, this means we initialize resources for triggers in each psi
> > group even if the user never creates any triggers. Current logic
> > initializes them when the first trigger in the group gets created.
> >
> > >
> > > >       rcu_assign_pointer(group->poll_task, NULL);
> > > >  }
> > > >
> > > > @@ -1157,7 +1161,6 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group,
> > > >                       return ERR_CAST(task);
> > > >               }
> > > >               atomic_set(&group->poll_wakeup, 0);
> > > > -             init_waitqueue_head(&group->poll_wait);
> > > >               wake_up_process(task);
> > > >               timer_setup(&group->poll_timer, poll_timer_fn, 0);
> > >
> > > This looks now unncessary?
> > >
> > > >               rcu_assign_pointer(group->poll_task, task);
> > > > @@ -1233,7 +1236,6 @@ static void psi_trigger_destroy(struct kref *ref)
> > > >                * But it might have been already scheduled before
> > > >                * that - deschedule it cleanly before destroying it.
> > > >                */
> > > > -             del_timer_sync(&group->poll_timer);
> > >
> > > And this looks wrong. Did you mean to delete the timer_setup() line
> > > instead?
> >
> > I would like to get more details about this race before trying to fix
> > it. Please clarify.
> > Thanks!
