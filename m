Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27EC33A93E7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 09:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbhFPHcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 03:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbhFPHcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 03:32:15 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70684C061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 00:30:08 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id r16so2396239ljk.9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 00:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S8zyEx2HVNKV9gfs780mEzvjp/0sCSr6lmLeOKGp7XY=;
        b=yHwHq5il5OFaMmLjNOdGvS7SpVNQzUDtir4HiFJ4Ngb8qcgcdvjz5B/4/ErR/yva9W
         FsAs8FpidUks1DtsWEJRARm2aoVIowBvsWqPD12JOZtJLdp7MKDUnhtZJICXeotF2Ya1
         w0mdEV14uCzwJNusUeK3O6nd/QI7JfNaBXNvSUPCyfmQGPrvrlrmHMC8TUwPHD3SfLxr
         K6JV0zJciFPVGtkAyzTU+bkAgA64lBTXwi2cP8wgN8SiDICv/lGW+QLODw5qA/lZCbyG
         gbIUp/FrrALnLQ7Io/pI3Ti+ePj9zbV5ZgSSzwozwKygCw3blH8CbbE1WCZYxU/7AR/8
         hMVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S8zyEx2HVNKV9gfs780mEzvjp/0sCSr6lmLeOKGp7XY=;
        b=ia7pOCb+PdNcWLbozMuPletNmoh+ToyB+Nulw20f50P59v4riCWCapI+FhmAmMapAv
         0lHWzCrEdZFOkJj3KVLoGtu5GtHGwL0+rBk0GRKmsq7FoL8eRLXGiDAwzQHlBKoAr5E7
         +sOBAq8B5LltYGqnbLUBkci8G2NEzDWph9OiOlIzIBea1KTCj+C903M7ZfVhuCzR4CJt
         bWSGs29gFwvq9vmyFnPgQB0gzvV00f8Q9/X6Xp2zOWhX+zuV1cQECUkNhz4qMCSx7Y42
         DtAnOBz6aYqoHSuB1O2MQ/0Gmg4R/1aop9hLDX9enGpK74s0VXPQafGtiHSHTsLlSO5x
         498A==
X-Gm-Message-State: AOAM532WBjYiWLtwW/QKb4ziRAKJVloBZDZceFzCXN/611aF4jj1P3OY
        YoOta8nWCvfuCOzivouBoNCH0whJSCFcAzQlsqhrjQ==
X-Google-Smtp-Source: ABdhPJze2KC/pT2VLTITUq9xM33zAzrJZWQzhTzV7aJAt+h7uWNE2xO6+YuNjg8X2im0zVLz/ZXk95qE+kK5XEjA7SY=
X-Received: by 2002:a2e:9f4c:: with SMTP id v12mr3204376ljk.176.1623828606791;
 Wed, 16 Jun 2021 00:30:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210615121551.31138-1-laoar.shao@gmail.com> <20210615203534.GA4272@worktop.programming.kicks-ass.net>
 <CALOAHbBuZJaK+fEg7toRUHJNP8rJKDoADeAUxorUuNU17kdTOA@mail.gmail.com> <YMmlAP/QhE6SWhCF@hirez.programming.kicks-ass.net>
In-Reply-To: <YMmlAP/QhE6SWhCF@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 16 Jun 2021 09:29:55 +0200
Message-ID: <CAKfTPtAh3eOtzZUPqmhkw6FAOjOietZrB_qMOfOprp0oWO+CvA@mail.gmail.com>
Subject: Re: [PATCH] sched, fair: try to prevent migration thread from
 preempting non-cfs task
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Yafang Shao <laoar.shao@gmail.com>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jun 2021 at 09:15, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Jun 16, 2021 at 09:44:46AM +0800, Yafang Shao wrote:
> > On Wed, Jun 16, 2021 at 4:35 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Tue, Jun 15, 2021 at 08:15:51PM +0800, Yafang Shao wrote:
> > > > ---
> > > >  kernel/sched/fair.c | 14 ++++++++++++++
> > > >  1 file changed, 14 insertions(+)
> > > >
> > > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > > index 3248e24a90b0..597c7a940746 100644
> > > > --- a/kernel/sched/fair.c
> > > > +++ b/kernel/sched/fair.c
> > > > @@ -9797,6 +9797,20 @@ static int load_balance(int this_cpu, struct rq *this_rq,
> > > >                       /* Record that we found at least one task that could run on this_cpu */
> > > >                       env.flags &= ~LBF_ALL_PINNED;
> > > >
> > > > +                     /*
> > > > +                      * There may be a race between load balance starting migration
> > > > +                      * thread to pull the cfs running thread and the RT thread
> > > > +                      * waking up and preempting cfs task before migration threads
> > > > +                      * which then preempt the RT thread.
> > > > +                      * We'd better do the last minute check before starting
> > > > +                      * migration thread to avoid preempting latency-sensitive thread.
> > > > +                      */
> > > > +                     if (busiest->curr->sched_class != &fair_sched_class) {
> > > > +                             raw_spin_unlock_irqrestore(&busiest->lock,
> > > > +                                                        flags);
> > >
> > > This won't apply.
> > >
> > > Also, there's still a race window, you've just shrunk it, not fixed it.
> > > Busiest can reschedule between the mandatory rq unlock and doing the
> > > stopper wakeup.
> > >
> > > An actual fix might be to have the active migration done by a FIFO-1
> > > task, instead of stopper. The obvious down-side is that that would mean
> > > spawning yet another per-cpu kthread.
> > >
> >
> > The stopper and the migration thread are different threads in the earlier days.
> > commit 969c79215a35 ("sched: replace migration_thread with cpu_stop")
> > merged them into one thread.
>
> Yes, I know, I was there. But that's not what I'm saying, we need the
> migration thread to be super high perio for other cases. That change
> still makes sense.
>
> > Regarding the priority of stopper (with highest priority) and
> > migration (higher than CFS, but lower than RT) , keeping them in one
> > single thread seems not a good way.
>
> I never suggested as such.
>
> Only the active migration of CFS can be done by a FIFO-1 task (the
> lowest prio that is higher than CFS) and possible the numa balancing
> thing.
>
> Other migrations will still need to use stopper, and as such you'll keep
> having interference from stopper.
>
> The suggestion was adding a cfs_migration thread, specifically for
> active balance (and maybe numa). Just not sure the cost of carrying yet
> another per-cpu kernel thread is worth the benefit.

Also, this will not completely remove the problem but only further
reduce the race window because the rq is locked and the irq disable in
active_load_balance_cpu_stop().
