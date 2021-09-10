Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07F0C40662F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 05:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbhIJDeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 23:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbhIJDeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 23:34:17 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3489EC061574
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 20:33:07 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id e21so1300279ejz.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 20:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iI90zD1qVT/+25eIKw7HUAPf+1bR/UKPrJbiCOOPBx0=;
        b=Z1OUGHZuyluftZ/37sJCQjD5WcRGKKRmwu54rwUrrFWqXvPIGxK0fEuNao2XN240yX
         yZJK+ZSScJE0jt3BDIQGY5iIN1K7k+DYEw2+jrPbAlEzcmd3YwGBmZ+x8A+lIk0gHGyC
         YvZhpUA5eFKUPmOth9SjogCMcnNFbLFsn8RHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iI90zD1qVT/+25eIKw7HUAPf+1bR/UKPrJbiCOOPBx0=;
        b=S5jo1ERaTXRN4u/XrzY4iUBpaKFsWILAkZWsrNYmsS1XuwxR4o++sCGe7VCEKzCjgm
         DFPHJtwp2Y1AEyM83csy/Ori8Wl+pupzJPoEqc6WRuhOHGmc2frHzWMGtcZYz669JHJW
         00FJ5/7X7EMOstWR/KzJ7sONQHOLFyVmjxEwSwW6qzJm3fRy6aRfXmjgirTj6Wrtyxmq
         9YNqFAL0H58OY0T/nM0YtYOTByeY39G3w7BI8S8z1EBoXeowx8Me/FAWxc9h8Sw1Z9fV
         Hkmgz7OnkeLGEYWLh+EfPdB4QUBT/m0jt06y/rEpRC7JO0BqZUwWj5s3h68pZKuN8gn6
         YnsQ==
X-Gm-Message-State: AOAM530kP3Vv7ZxXiwM6q6icTBLcxuBLbn6F1XS9BgPAa+yvg+XP3pLo
        3bB3FWIELC62B+idOvtCkc7UrHQH/TL4WK2sVj+OUw==
X-Google-Smtp-Source: ABdhPJz7XgWC0WFRlN+779dykVD1yYNQ9vOQRF04tNwZkzSoscJQ4EloSV7QKfU8wfgcWRsmDovBYPHumdL7vy5cEaw=
X-Received: by 2002:a17:907:9854:: with SMTP id jj20mr4630906ejc.133.1631244785787;
 Thu, 09 Sep 2021 20:33:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210909232141.2489691-1-dualli@chromium.org> <20210909232141.2489691-2-dualli@chromium.org>
 <CAHRSSExGF3teN83P4jJJ1_ibzEvxTScm2-KMo5+kLZ7xCaMhSw@mail.gmail.com>
In-Reply-To: <CAHRSSExGF3teN83P4jJJ1_ibzEvxTScm2-KMo5+kLZ7xCaMhSw@mail.gmail.com>
From:   Li Li <dualli@chromium.org>
Date:   Thu, 9 Sep 2021 20:32:55 -0700
Message-ID: <CANBPYPjEDV33CuC=RUVt_KyPuu+3ua+N+BDhSTHwuFtc4pEFjg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] binder: fix freeze race
To:     Todd Kjos <tkjos@google.com>
Cc:     Li Li <dualli@google.com>, Greg KH <gregkh@linuxfoundation.org>,
        Christian Brauner <christian@brauner.io>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Martijn Coenen <maco@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Todd,

Thanks for reviewing the patch! Please see my reply below.

And I'll send out v2 soon addressing your concerns.

On Thu, Sep 9, 2021 at 4:54 PM Todd Kjos <tkjos@google.com> wrote:
>
> On Thu, Sep 9, 2021 at 4:21 PM Li Li <dualli@chromium.org> wrote:
> >
> > From: Li Li <dualli@google.com>
> >
> > Currently cgroup freezer is used to freeze the application threads, and
> > BINDER_FREEZE is used to freeze binder interface. There's already a
> > mechanism for BINDER_FREEZE to wait for any existing transactions to
> > drain out before actually freezing the binder interface.
> >
> > But freezing an app requires 2 steps, freezing the binder interface with
> > BINDER_FREEZEwhich and then freezing the application main threads with
> > cgroupfs. This is not an atomic operation. The following race issue
> > might happen.
> >
> > 1) Binder interface is frozen by ioctl(BINDER_FREEZE);
> > 2) Main thread initiates a new sync binder transaction;
> > 3) Main thread is frozen by "echo 1 > cgroup.freeze";
> > 4) The response reaches the frozen thread, which will unexpectedly fail.
> >
> > This patch provides a mechanism for user space freezer manager to check
> > if there's any new pending transaction happening between BINDER_FREEZE
> > and freezing main thread. If there's any, the main thread freezing
> > operation can be rolled back.
> >
> > Furthermore, the response might reach the binder driver before the
> > rollback actually happens. That will also cause failed transaction.
> >
> > As the other process doesn't wait for another response of the response,
> > the failed response transaction can be fixed by treating the response
> > transaction like an oneway/async one, allowing it to reach the frozen
> > thread. And it will be consumed when the thread gets unfrozen later.
> >
> > Bug: 198493121
>
> Please remove "Bug: " tag. Replace it with a "Fixes:" tag that cites
> the patch that introduced the race.
>
Done in v2.

> > Signed-off-by: Li Li <dualli@google.com>
> > ---
> >  drivers/android/binder.c          | 32 +++++++++++++++++++++++++++----
> >  drivers/android/binder_internal.h |  2 ++
> >  2 files changed, 30 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> > index d9030cb6b1e4..f9713a97578c 100644
> > --- a/drivers/android/binder.c
> > +++ b/drivers/android/binder.c
> > @@ -3038,9 +3038,8 @@ static void binder_transaction(struct binder_proc *proc,
> >         if (reply) {
> >                 binder_enqueue_thread_work(thread, tcomplete);
> >                 binder_inner_proc_lock(target_proc);
> > -               if (target_thread->is_dead || target_proc->is_frozen) {
> > -                       return_error = target_thread->is_dead ?
> > -                               BR_DEAD_REPLY : BR_FROZEN_REPLY;
> > +               if (target_thread->is_dead) {
> > +                       return_error = BR_DEAD_REPLY;
> >                         binder_inner_proc_unlock(target_proc);
> >                         goto err_dead_proc_or_thread;
> >                 }
> > @@ -4648,6 +4647,22 @@ static int binder_ioctl_get_node_debug_info(struct binder_proc *proc,
> >         return 0;
> >  }
> >
> > +static int binder_txns_pending(struct binder_proc *proc)
> > +{
> > +       struct rb_node *n;
> > +       struct binder_thread *thread;
> > +
> > +       if (proc->outstanding_txns > 0)
> > +               return 1;
> > +
> > +       for (n = rb_first(&proc->threads); n; n = rb_next(n)) {
> > +               thread = rb_entry(n, struct binder_thread, rb_node);
> > +               if (thread->transaction_stack)
> > +                       return 1;
> > +       }
> > +       return 0;
> > +}
> > +
> >  static int binder_ioctl_freeze(struct binder_freeze_info *info,
> >                                struct binder_proc *target_proc)
> >  {
> > @@ -4682,6 +4697,14 @@ static int binder_ioctl_freeze(struct binder_freeze_info *info,
> >         if (!ret && target_proc->outstanding_txns)
> >                 ret = -EAGAIN;
> >
> > +       /* Also check pending transactions that wait for reply */
> > +       if (ret >= 0) {
> > +               binder_inner_proc_lock(target_proc);
> > +               if (binder_txns_pending(target_proc))
>
> The convention in the binder driver is to append "_ilocked" to the
> function name if the function expects the inner proc lock to be held
> (so "binder_txns_pending_ilocked(target_proc) in this case)".
>
Done in v2.

> > +                       ret = -EAGAIN;
> > +               binder_inner_proc_unlock(target_proc);
> > +       }
> > +
> >         if (ret < 0) {
> >                 binder_inner_proc_lock(target_proc);
> >                 target_proc->is_frozen = false;
> > @@ -4705,7 +4728,8 @@ static int binder_ioctl_get_freezer_info(
> >                 if (target_proc->pid == info->pid) {
> >                         found = true;
> >                         binder_inner_proc_lock(target_proc);
> > -                       info->sync_recv |= target_proc->sync_recv;
> > +                       info->sync_recv |= target_proc->sync_recv |
> > +                                       (binder_txns_pending(target_proc) << 1);
> >                         info->async_recv |= target_proc->async_recv;
> >                         binder_inner_proc_unlock(target_proc);
> >                 }
> > diff --git a/drivers/android/binder_internal.h b/drivers/android/binder_internal.h
> > index 810c0b84d3f8..402c4d4362a8 100644
> > --- a/drivers/android/binder_internal.h
> > +++ b/drivers/android/binder_internal.h
> > @@ -378,6 +378,8 @@ struct binder_ref {
> >   *                        binder transactions
> >   *                        (protected by @inner_lock)
> >   * @sync_recv:            process received sync transactions since last frozen
> > + *                        bit 0: received sync transaction after being frozen
> > + *                        bit 1: new pending sync transaction during freezing
>
> Should these bit assignments be documented in binder.h since these bit
> assignments end up being relevant in struct binder_frozen_status_info?
>
Done in v2.

>
> >   *                        (protected by @inner_lock)
> >   * @async_recv:           process received async transactions since last frozen
> >   *                        (protected by @inner_lock)
> > --
> > 2.33.0.309.g3052b89438-goog
> >
