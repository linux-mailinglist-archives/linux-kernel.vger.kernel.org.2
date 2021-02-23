Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3576322359
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 02:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbhBWA7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 19:59:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbhBWA7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 19:59:37 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE6FC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 16:58:57 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id w6so3326269qti.6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 16:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iyB89RKBO7L+gSLQuS4sTB8Yvi5nARaZXNkFcKd9HCo=;
        b=fhG9oECZwDS+aG8JbizDALlWHYZUwNwF+TKpbBPatOJG+Kl1BHJpXXo2Jsm+EuGaQM
         oYn2dpII9axrEuxca5U0NMLrYDDhzTFiLMHK5kC/fwjBsuq/cjBbbkm7Jfdp25mpzqvK
         wgBAfl6XJS06Y2jYvPeFrpviYYbycMY45fzEHlQTFcqgpdMwMH2+IhIT7WlbFDilMCFa
         BD1uIISRai7Ee60bAadumSbMTfTB6BlMk2aoz+i/3NtEdR6vW6bJWbVW6rE52K3JUeWw
         JzSma9H604OF+R50oqNZQ3OtxWtX6PVDfZrsqsBcY01qnE49+XWkuuLFAhcuotgpf4aR
         6MsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iyB89RKBO7L+gSLQuS4sTB8Yvi5nARaZXNkFcKd9HCo=;
        b=N0MwIjHNa9bB5XFowdbIJOzeitN/WwXWAs/YxmsfUs+cmtdtZOi1vHPctBqLORMURI
         V3U9Zh+ydYL7NtqtstGr/tVV4Pci6b5WeveuWomYULDGK1ApFI+7XGB0q+f3bdl0RccI
         rp3wQ0ghSPRgeDpz2PAyxbYNLqeNiH9cSWtSMZb6bk1azYphUvaTcOg4WOp7DhUjKsXv
         TJ7mUBaLpey7dXJmrdpbxMw+xX3QvgXAzIJ9yFFlfT+fOM7Rlw0SZMExfjIR4z1CjB1x
         Oc0F0ZDhlBpfQthSBTsjBbGnHIvl98tCbbKicOAUbZAL8bztD4qSZkI56F/R6qg22FAk
         iKcA==
X-Gm-Message-State: AOAM533XdKHPvNVrabnBWymFAwAdVOYqCMNadvnKw6b5wKySOkvCuWDr
        zlJActKECV0ciBlwSwIe7FR3g0ER3WUEmvHY4ZBP4A==
X-Google-Smtp-Source: ABdhPJwymyLVO0mUgGR7R+0cXQlIQ7CMJUcJpLlF6UjB04tEUwjIv8JkvJHQg+6SMLh5sZckvqS+TI9tF5S4brVJG+o=
X-Received: by 2002:ac8:4f4f:: with SMTP id i15mr21320488qtw.101.1614041936494;
 Mon, 22 Feb 2021 16:58:56 -0800 (PST)
MIME-Version: 1.0
References: <20210214000611.2169820-1-zzyiwei@android.com> <YC+ZQAwwb4RGgjDf@alley>
 <CAKB3++YB3xftQFgSGQXKQucuid9sFywjN1E7nQ6QrqR96+heEg@mail.gmail.com>
In-Reply-To: <CAKB3++YB3xftQFgSGQXKQucuid9sFywjN1E7nQ6QrqR96+heEg@mail.gmail.com>
From:   =?UTF-8?B?WWl3ZWkgWmhhbmfigI4=?= <zzyiwei@android.com>
Date:   Mon, 22 Feb 2021 16:58:46 -0800
Message-ID: <CAKB3++b4wnsh+Kbgk4U200hLQmudM28sK=s9e6mARpM-eZ2ZZw@mail.gmail.com>
Subject: Re: [PATCH] kthread: add kthread_mod_pending_delayed_work api
To:     Petr Mladek <pmladek@suse.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jens Axboe <axboe@kernel.dk>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Ilias Stamatis <stamatis.iliass@gmail.com>,
        Rob Clark <robdclark@chromium.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Liang Chen <cl@rock-chips.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since you awesome guys are here, I do have another kthread related
question, and hopefully to get some suggestions:

Below are the conditions:
1. The caller threads queuing the work are normal threads(non-RT).
2. The worker thread is a realtime kernel thread with relatively high prio.
3. We are not allowed to pin caller threads to fixed cpu clusters.

Sometimes when the CPU is busy, the worker thread starts preempting
the caller thread, which is not cool because it will make the
asynchronous effort a no-op. Is there a way we can include caller
thread metadata(task_struct pointer?) when it enqueues the work so
that the RT worker thread won't preempt the caller thread when that
queued work gets scheduled? Probably require the CPU scheduler to poke
at the next work...or any other ideas will be very appreciated,
thanks!

Best regards,
Yiwei

On Mon, Feb 22, 2021 at 4:39 PM Yiwei Zhang=E2=80=8E <zzyiwei@android.com> =
wrote:
>
> On Fri, Feb 19, 2021 at 2:56 AM Petr Mladek <pmladek@suse.com> wrote:
> >
> > On Sun 2021-02-14 00:06:11, Yiwei Zhang wrote:
> > > The existing kthread_mod_delayed_work api will queue a new work if
> > > failing to cancel the current work due to no longer being pending.
> > > However, there's a case that the same work can be enqueued from both
> > > an async request and a delayed work, and a racing could happen if the
> > > async request comes right after the timeout delayed work gets schedul=
ed,
> > > because the clean up work may not be safe to run twice.
> >
> > Please, provide more details about the use case. Why the work is
> > originally sheduled with a delay. And and why it suddenly can/should
> > be proceed immediately.
> >
> > >
> > > Signed-off-by: Yiwei Zhang <zzyiwei@android.com>
> > > ---
> > >  include/linux/kthread.h |  3 +++
> > >  kernel/kthread.c        | 48 +++++++++++++++++++++++++++++++++++++++=
++
> > >  2 files changed, 51 insertions(+)
> > >
> > > --- a/kernel/kthread.c
> > > +++ b/kernel/kthread.c
> > > @@ -1142,6 +1142,54 @@ bool kthread_mod_delayed_work(struct kthread_w=
orker *worker,
> > >  }
> > >  EXPORT_SYMBOL_GPL(kthread_mod_delayed_work);
> > >
> > > +/**
> > > + * kthread_mod_pending_delayed_work - modify delay of a pending dela=
yed work
> > > + * @worker: kthread worker to use
> > > + * @dwork: kthread delayed work to queue
> > > + * @delay: number of jiffies to wait before queuing
> > > + *
> > > + * If @dwork is still pending modify @dwork's timer so that it expir=
es after
> > > + * @delay. If @dwork is still pending and @delay is zero, @work is g=
uaranteed to
> > > + * be queued immediately.
> > > + *
> > > + * Return: %true if @dwork was pending and its timer was modified,
> > > + * %false otherwise.
> > > + *
> > > + * A special case is when the work is being canceled in parallel.
> > > + * It might be caused either by the real kthread_cancel_delayed_work=
_sync()
> > > + * or yet another kthread_mod_delayed_work() call. We let the other =
command
> > > + * win and return %false here. The caller is supposed to synchronize=
 these
> > > + * operations a reasonable way.
> > > + *
> > > + * This function is safe to call from any context including IRQ hand=
ler.
> > > + * See __kthread_cancel_work() and kthread_delayed_work_timer_fn()
> > > + * for details.
> > > + */
> > > +bool kthread_mod_pending_delayed_work(struct kthread_worker *worker,
> > > +                                   struct kthread_delayed_work *dwor=
k,
> > > +                                   unsigned long delay)
> > > +{
> >
> > kthread_worker API tries to follow the workqueue API. It helps to use a=
nd
> > switch between them easily.
> >
> > workqueue API does not provide this possibility. Instead it has
> > flush_delayed_work(). It queues the work when it was pending and
> > waits until the work is procced. So, we might do:
> >
> > bool kthread_flush_delayed_work(struct kthread_delayed_work *dwork)
> >
> >
> > > +     struct kthread_work *work =3D &dwork->work;
> > > +     unsigned long flags;
> > > +     int ret =3D true;
> > > +
> > > +     raw_spin_lock_irqsave(&worker->lock, flags);
> > > +     if (!work->worker || work->canceling ||
> > > +         !__kthread_cancel_work(work, true, &flags)) {
> > > +             ret =3D false;
> > > +             goto out;
> > > +     }
> >
> > Please, use separate checks with comments as it is done, for example,
> > in kthread_mod_delayed_work()
> >
> >         struct kthread_work *work =3D &dwork->work;
> >         unsigned long flags;
> >         int ret;
> >
> >         raw_spin_lock_irqsave(&worker->lock, flags);
> >
> >         /* Do not bother with canceling when never queued. */
> >         if (!work->worker)
> >                 goto nope;
> >
> >         /* Do not fight with another command that is canceling this wor=
k. */
> >         if (work->canceling)
> >                 goto nope;
> >
> >         /* Nope when the work was not pending. */
> >         ret =3D __kthread_cancel_work(work, true, &flags);
> >         if (!ret)
> >                 nope;
> >
> >         /* Queue the work immediately. */
> >         kthread_insert_work(worker, work, &worker->work_list);
> >         raw_spin_unlock_irqrestore(&worker->lock, flags);
> >
> >         return kthread_flush_work(work);
> > nope:
> >         raw_spin_unlock_irqrestore(&worker->lock, flags);
> >         return false;
> >
> >
> > Will this work for you?
> >
> > Best Regards,
> > Petr
>
> Thanks for your comments and reviews, Petr! I completely understand
> Christoph's pushback regarding no upstream use case here. Just want to
> see if this is a missing use case in kthread. I'll propose again if
> later I find a use case in any upstream drivers.
>
> Best,
> Yiwei
