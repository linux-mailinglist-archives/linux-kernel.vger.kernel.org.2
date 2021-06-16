Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2F353A9676
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 11:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbhFPJsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 05:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbhFPJsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 05:48:19 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92AC1C061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 02:46:13 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id d9so2363634ioo.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 02:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U+Gs03wvW6c/WwKnd+unjaXrg4+9H4GYXNYD6S00VbY=;
        b=pa+RC4PTnAa0KziAfR6VIxWd3jmeElFWd86Sg1P+z4cEzk4NZziyNSk7cbS4HfbYQm
         2pYNzMW60DZV9c2Ka/o1mNTXLh6qtLfYVGgZdxatPpHaHlDwaO/oT9xP+qFahubOg8fZ
         yDWg4S8+Op6LcFtCUfb0SWH7lPnTOqbx2SARQGoO70YkmELiLjTjdx7J+GgejlVqADXe
         cGtTtBMe1N351hI/OyPGXxEREqkd3pLCreC8/d1quaFrV6lqpf26D2PXMkimGKwd1ePi
         euWdlkpQHxDz+ZEic2c+uV3MwwM6pAz5X2vnLFKPz1f9ocANHDwDB3xTtFC9IbdmPQvt
         r87g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U+Gs03wvW6c/WwKnd+unjaXrg4+9H4GYXNYD6S00VbY=;
        b=jJe6n9idyA+hVE3PkK5LsR8dJHATGbssgr558A6uKndr/IGC/ddHxIokdpZDrCnIwB
         bzRfYIdS6nZdUOwU9IUNVwRUh6230ZekXbEHNQ6bEwluzG72913XanFCPVFzQD2X18vA
         nKVzTu1Cr9jp2R0E5JLe1iPPVeZONTotZW3Kv1dlfyoBftxX58ubAlvvVxjiVC6+rRI3
         xv3+Ed2NxCBg1tzLc1HIQE4GKQHNt6LtJVMGzhaNQBJX1tl2RuSmqjM94JH8MbHRtuLO
         cXLt2B+Du42TrFBe+QeyrNfqXsi8bz6BsLzHTUHMOKnMs4Iy4d57QCE/Np+dG3Y7LoIN
         tOMg==
X-Gm-Message-State: AOAM532lmR2sWxQnjhjPLQWG2DHP77AOucBQwEm+YS7QMKZnuEzsMVGk
        CdfAjTq+v+MBwMcCSNZi73/xIHhtxFwCKO2JYVHlezXltLoWIPvk
X-Google-Smtp-Source: ABdhPJzaZebP2vUIupR7kX7xhs+7BS6LJIEz1wi07kGZ9pzcqtYMhZcIbYQM+Vq9BcDJZqZ1mcWt6EplamLjTQRG6/o=
X-Received: by 2002:a02:6f5e:: with SMTP id b30mr3409126jae.94.1623836772998;
 Wed, 16 Jun 2021 02:46:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210615121551.31138-1-laoar.shao@gmail.com> <20210615203534.GA4272@worktop.programming.kicks-ass.net>
 <CALOAHbBuZJaK+fEg7toRUHJNP8rJKDoADeAUxorUuNU17kdTOA@mail.gmail.com> <YMmlAP/QhE6SWhCF@hirez.programming.kicks-ass.net>
In-Reply-To: <YMmlAP/QhE6SWhCF@hirez.programming.kicks-ass.net>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Wed, 16 Jun 2021 17:45:36 +0800
Message-ID: <CALOAHbDPXjcgw37_yrR_A6kgJOuopjr409YnHKcMrgwN=uazpg@mail.gmail.com>
Subject: Re: [PATCH] sched, fair: try to prevent migration thread from
 preempting non-cfs task
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
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

On Wed, Jun 16, 2021 at 3:15 PM Peter Zijlstra <peterz@infradead.org> wrote:
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

Thanks for the clarification.

-- 
Thanks
Yafang
