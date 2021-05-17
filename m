Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2AC386C47
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 23:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237668AbhEQVbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 17:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232924AbhEQVbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 17:31:39 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB77BC061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 14:30:22 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id l7so10442665ybf.8
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 14:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+LNT+i8sxBAQ29yasbLvHo3jYCtI0n7L5FDMGp+BlgE=;
        b=bC65qTkzxp90h8XlL5j92th3GLYe1VdTKZqkthrxokKC23h10GKytlmnKnFP2pmmIh
         BbmPjbnh7FKB+MdSU6ldL9FEwrSGjeb3oZNzElxT3t8qMJCnTDKCAIN9NGXPVDdos2Q8
         014b3paagMkd4cU1gYThIe1uLrcRgxtk5ZORQjuUOj/P9l5iQ/c41pVkgMzKAeqmZ+Pg
         pjVogdfkSrIfl+T8FsauGQlHfSVipqDfepX+fjsBEEb6zIsBiEAmxHBjpeJpP1kaU9/I
         oknVlkHkoLOojJ9SKSCwNDnpnDndlpoQ9AooMFUMbvHaOZulBUGHrDU0n0n4tR6hoYd/
         7ZHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+LNT+i8sxBAQ29yasbLvHo3jYCtI0n7L5FDMGp+BlgE=;
        b=DyHRSg54rhyEQpz87qzyZjMsURuSsZqYAwAtn6eq7O2x4CoxTIwPBJ/zVDHH1hMc2u
         /Zmym3Ivgsjtb5WfJGIkm0ppZegfoVZUjvI5wu/shuhRtK91lVyrwDdWmkXLV20DltET
         tUueqToRa/zeb3r913OOt3JhWXHjmmqmPQkVso4x0MwxpTKD61BOuE27gAM5ozNIMVUS
         OijV4Tf+DXggtTVXlI4ngwX4mlsNnMmQ/Ur/DVxLHQOWyuXhWQc40Rzm8sI9qrccPd4/
         yZvxLUVEXbkDAI4CEr8wdwTUFsqJ8JzOAm4yf0VobNAHcA/NmUykuKQnTBwLeM6pcQ6u
         7rkw==
X-Gm-Message-State: AOAM531gkH/jnYxNbBnIiXWhSbKOgIHapBn8df7RpCTt2EZnt4PS4BWA
        ejM9ov42taGIAiragvFVQYa3qVa7IlwiiOmWVSR39g==
X-Google-Smtp-Source: ABdhPJwFQNGXkTzpV7B88IkJ7le3LPi+S+xvbbN+R8OVemauShTcWwLd6RZYGCmpnSdnodoJGPBjSo4EBaiJxj+/wi0=
X-Received: by 2002:a05:6902:1026:: with SMTP id x6mr2474460ybt.23.1621287021903;
 Mon, 17 May 2021 14:30:21 -0700 (PDT)
MIME-Version: 1.0
References: <1621242249-8314-1-git-send-email-huangzhaoyang@gmail.com>
 <YKK3wgrhqzaiE7rQ@cmpxchg.org> <CAJuCfpGLTkvH6CzQXz4oD39_xtArBt3upk-F=gf4-LPoswagGg@mail.gmail.com>
In-Reply-To: <CAJuCfpGLTkvH6CzQXz4oD39_xtArBt3upk-F=gf4-LPoswagGg@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 17 May 2021 14:30:10 -0700
Message-ID: <CAJuCfpE+Z3O_5PfDg8rEB7Cj+nMbsGPp_eWF6rRz8h2YJhy+PA@mail.gmail.com>
Subject: Re: [[RFC]PATCH] psi: fix race between psi_trigger_create and psimon
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Huangzhaoyang <huangzhaoyang@gmail.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Ziwei Dai <ziwei.dai@unisoc.com>, Ke Wang <ke.wang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 12:33 PM Suren Baghdasaryan <surenb@google.com> wrote:
>
> On Mon, May 17, 2021 at 11:36 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > CC Suren
>
> Thanks!
>
> >
> > On Mon, May 17, 2021 at 05:04:09PM +0800, Huangzhaoyang wrote:
> > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > >
> > > Race detected between psimon_new and psimon_old as shown below, which
> > > cause panic by accessing invalid psi_system->poll_wait->wait_queue_entry
> > > and psi_system->poll_timer->entry->next. It is not necessary to reinit
> > > resource of psi_system when psi_trigger_create.
>
> resource of psi_system will not be reinitialized because
> init_waitqueue_head(&group->poll_wait) and friends are initialized
> only during the creation of the first trigger for that group (see this
> condition: https://elixir.bootlin.com/linux/latest/source/kernel/sched/psi.c#L1119).
>
> > >
> > > psi_trigger_create      psimon_new     psimon_old
> > >  init_waitqueue_head                    finish_wait
> > >                                           spin_lock(lock_old)
> > >       spin_lock_init(lock_new)
> > >  wake_up_process(psimon_new)
> > >
> > >                         finish_wait
> > >                           spin_lock(lock_new)
> > >                             list_del       list_del
>
> Could you please clarify this race a bit? I'm having trouble
> deciphering this diagram. I'm guessing psimon_new/psimon_old refer to
> a new trigger being created while an old one is being deleted, so it
> seems like a race between psi_trigger_create/psi_trigger_destroy. The
> combination of trigger_lock and RCU should be protecting us from that
> but maybe I missed something?
> I'm excluding a possibility of a race between psi_trigger_create with
> another existing trigger on the same group because the codepath
> calling init_waitqueue_head(&group->poll_wait) happens only when the
> first trigger for that group is created. Therefore if there is an
> existing trigger in that group that codepath will not be taken.

Ok, looking at the current code I think you can hit the following race
when psi_trigger_destroy is destroying the last trigger in a psi group
while racing with psi_trigger_create:

psi_trigger_destroy                      psi_trigger_create
mutex_lock(trigger_lock);
rcu_assign_pointer(poll_task, NULL);
mutex_unlock(trigger_lock);
                                                    mutex_lock(trigger_lock);
                                                    if
(!rcu_access_pointer(group->poll_task)) {

timer_setup(poll_timer, poll_timer_fn, 0);

rcu_assign_pointer(poll_task, task);
                                                    }
                                                    mutex_unlock(trigger_lock);

synchronize_rcu();
del_timer_sync(poll_timer); <-- poll_timer has been reinitialized by
psi_trigger_create

So, trigger_lock/RCU correctly protects destruction of
group->poll_task but misses this race affecting poll_timer and
poll_wait.
Let me think if we can handle this without moving initialization into
group_init().

>
> > >
> > > Signed-off-by: ziwei.dai <ziwei.dai@unisoc.com>
> > > Signed-off-by: ke.wang <ke.wang@unisoc.com>
> > > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > > ---
> > >  kernel/sched/psi.c | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> > > index cc25a3c..d00e585 100644
> > > --- a/kernel/sched/psi.c
> > > +++ b/kernel/sched/psi.c
> > > @@ -182,6 +182,8 @@ struct psi_group psi_system = {
> > >
> > >  static void psi_avgs_work(struct work_struct *work);
> > >
> > > +static void poll_timer_fn(struct timer_list *t);
> > > +
> > >  static void group_init(struct psi_group *group)
> > >  {
> > >       int cpu;
> > > @@ -201,6 +203,8 @@ static void group_init(struct psi_group *group)
> > >       memset(group->polling_total, 0, sizeof(group->polling_total));
> > >       group->polling_next_update = ULLONG_MAX;
> > >       group->polling_until = 0;
> > > +     init_waitqueue_head(&group->poll_wait);
> > > +     timer_setup(&group->poll_timer, poll_timer_fn, 0);
> >
> > This makes sense.
>
> Well, this means we initialize resources for triggers in each psi
> group even if the user never creates any triggers. Current logic
> initializes them when the first trigger in the group gets created.
>
> >
> > >       rcu_assign_pointer(group->poll_task, NULL);
> > >  }
> > >
> > > @@ -1157,7 +1161,6 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group,
> > >                       return ERR_CAST(task);
> > >               }
> > >               atomic_set(&group->poll_wakeup, 0);
> > > -             init_waitqueue_head(&group->poll_wait);
> > >               wake_up_process(task);
> > >               timer_setup(&group->poll_timer, poll_timer_fn, 0);
> >
> > This looks now unncessary?
> >
> > >               rcu_assign_pointer(group->poll_task, task);
> > > @@ -1233,7 +1236,6 @@ static void psi_trigger_destroy(struct kref *ref)
> > >                * But it might have been already scheduled before
> > >                * that - deschedule it cleanly before destroying it.
> > >                */
> > > -             del_timer_sync(&group->poll_timer);
> >
> > And this looks wrong. Did you mean to delete the timer_setup() line
> > instead?
>
> I would like to get more details about this race before trying to fix
> it. Please clarify.
> Thanks!
