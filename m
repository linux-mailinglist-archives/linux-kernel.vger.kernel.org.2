Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A23CD322334
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 01:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbhBWAkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 19:40:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbhBWAkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 19:40:02 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A998DC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 16:39:22 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id 204so9725452qke.11
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 16:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nqgu04mTLzhxhyHjMA8wctzBbpKR3LvqV8MdPEXn3yQ=;
        b=V2uo0EKxRvj/W4ys4rRpgi2PylcZ7CfH2F5O3hwXwufHSPEyc37PnZpN2tv7xjfyVG
         aqbptmSe8W+7sSCLHKPqFXxNvnSFtmXQhXRfFa96IRWe5txrZJ1bz9eLUBoujOBb15G+
         bL8zJr7hBlzvzu9jVWVjRCdHdCPiq9DuTTVfLoQJY67P4rf0d7ZsdqKqkQmKHUPXC5zA
         0Q+Y6liqHcIZHqynLbBkamTZjqo0GbAtHVh4IAFRr57mWqQs3e2OlApoOb9n7q3rWGoh
         D1juX5AWpep99+ubVNBtQ43pqAOKS/aYrpU2hFx5lYG26uX6863SzD9Y8wALtBrQrlb5
         Y3VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nqgu04mTLzhxhyHjMA8wctzBbpKR3LvqV8MdPEXn3yQ=;
        b=rTYwUkG2K/exlTRyN1wOJ/PO2xg+8v7Ez7ELFvr3c52FFRdF0dwhXqVHO3c0Tgyl/J
         InbD3QScX3YlXBw5w4GnI801elv5LGaKLZqHy41BX037v9WWEXylh36s/pHMG0olTief
         Wt9JDouMFXK4bT3IvgvnjYU8e3IR4u/g6XAywnsG4kLSumRzmne+c6IRT4cZ069Xd2p2
         I6l4kbU3FjWAPoxp1dZZydWbr4oUp273NUdCgNXdHBmCCe50xpDB8Zo2BlMznOmpG/Gm
         XhD4Z/MxeQg2a78Gj5rsvxDW/soAp60P22k2lGEcU3fN1n2h60sbVcXe/+fMS14byzyo
         Jtjw==
X-Gm-Message-State: AOAM533os39cqOWBZbgzBtws9wLoXCgDakRUSgw27nyNubK2hw8pMEJM
        23vcOXuKolGjDEPA4Q3i5h2NFaStIpS6ve3/yGqAtQ==
X-Google-Smtp-Source: ABdhPJz4WcIzskb/mtmF088ETrVZJgLCaLa2j2nmKFwh2/i5zEqNDfwsjG4Tf57SotRN2In9P66jnpWZHw0CMYuWQSY=
X-Received: by 2002:a37:9fd5:: with SMTP id i204mr24086233qke.499.1614040761779;
 Mon, 22 Feb 2021 16:39:21 -0800 (PST)
MIME-Version: 1.0
References: <20210214000611.2169820-1-zzyiwei@android.com> <YC+ZQAwwb4RGgjDf@alley>
In-Reply-To: <YC+ZQAwwb4RGgjDf@alley>
From:   =?UTF-8?B?WWl3ZWkgWmhhbmfigI4=?= <zzyiwei@android.com>
Date:   Mon, 22 Feb 2021 16:39:12 -0800
Message-ID: <CAKB3++YB3xftQFgSGQXKQucuid9sFywjN1E7nQ6QrqR96+heEg@mail.gmail.com>
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 19, 2021 at 2:56 AM Petr Mladek <pmladek@suse.com> wrote:
>
> On Sun 2021-02-14 00:06:11, Yiwei Zhang wrote:
> > The existing kthread_mod_delayed_work api will queue a new work if
> > failing to cancel the current work due to no longer being pending.
> > However, there's a case that the same work can be enqueued from both
> > an async request and a delayed work, and a racing could happen if the
> > async request comes right after the timeout delayed work gets scheduled,
> > because the clean up work may not be safe to run twice.
>
> Please, provide more details about the use case. Why the work is
> originally sheduled with a delay. And and why it suddenly can/should
> be proceed immediately.
>
> >
> > Signed-off-by: Yiwei Zhang <zzyiwei@android.com>
> > ---
> >  include/linux/kthread.h |  3 +++
> >  kernel/kthread.c        | 48 +++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 51 insertions(+)
> >
> > --- a/kernel/kthread.c
> > +++ b/kernel/kthread.c
> > @@ -1142,6 +1142,54 @@ bool kthread_mod_delayed_work(struct kthread_worker *worker,
> >  }
> >  EXPORT_SYMBOL_GPL(kthread_mod_delayed_work);
> >
> > +/**
> > + * kthread_mod_pending_delayed_work - modify delay of a pending delayed work
> > + * @worker: kthread worker to use
> > + * @dwork: kthread delayed work to queue
> > + * @delay: number of jiffies to wait before queuing
> > + *
> > + * If @dwork is still pending modify @dwork's timer so that it expires after
> > + * @delay. If @dwork is still pending and @delay is zero, @work is guaranteed to
> > + * be queued immediately.
> > + *
> > + * Return: %true if @dwork was pending and its timer was modified,
> > + * %false otherwise.
> > + *
> > + * A special case is when the work is being canceled in parallel.
> > + * It might be caused either by the real kthread_cancel_delayed_work_sync()
> > + * or yet another kthread_mod_delayed_work() call. We let the other command
> > + * win and return %false here. The caller is supposed to synchronize these
> > + * operations a reasonable way.
> > + *
> > + * This function is safe to call from any context including IRQ handler.
> > + * See __kthread_cancel_work() and kthread_delayed_work_timer_fn()
> > + * for details.
> > + */
> > +bool kthread_mod_pending_delayed_work(struct kthread_worker *worker,
> > +                                   struct kthread_delayed_work *dwork,
> > +                                   unsigned long delay)
> > +{
>
> kthread_worker API tries to follow the workqueue API. It helps to use and
> switch between them easily.
>
> workqueue API does not provide this possibility. Instead it has
> flush_delayed_work(). It queues the work when it was pending and
> waits until the work is procced. So, we might do:
>
> bool kthread_flush_delayed_work(struct kthread_delayed_work *dwork)
>
>
> > +     struct kthread_work *work = &dwork->work;
> > +     unsigned long flags;
> > +     int ret = true;
> > +
> > +     raw_spin_lock_irqsave(&worker->lock, flags);
> > +     if (!work->worker || work->canceling ||
> > +         !__kthread_cancel_work(work, true, &flags)) {
> > +             ret = false;
> > +             goto out;
> > +     }
>
> Please, use separate checks with comments as it is done, for example,
> in kthread_mod_delayed_work()
>
>         struct kthread_work *work = &dwork->work;
>         unsigned long flags;
>         int ret;
>
>         raw_spin_lock_irqsave(&worker->lock, flags);
>
>         /* Do not bother with canceling when never queued. */
>         if (!work->worker)
>                 goto nope;
>
>         /* Do not fight with another command that is canceling this work. */
>         if (work->canceling)
>                 goto nope;
>
>         /* Nope when the work was not pending. */
>         ret = __kthread_cancel_work(work, true, &flags);
>         if (!ret)
>                 nope;
>
>         /* Queue the work immediately. */
>         kthread_insert_work(worker, work, &worker->work_list);
>         raw_spin_unlock_irqrestore(&worker->lock, flags);
>
>         return kthread_flush_work(work);
> nope:
>         raw_spin_unlock_irqrestore(&worker->lock, flags);
>         return false;
>
>
> Will this work for you?
>
> Best Regards,
> Petr

Thanks for your comments and reviews, Petr! I completely understand
Christoph's pushback regarding no upstream use case here. Just want to
see if this is a missing use case in kthread. I'll propose again if
later I find a use case in any upstream drivers.

Best,
Yiwei
