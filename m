Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA983A9391
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 09:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbhFPHSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 03:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbhFPHSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 03:18:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E02C061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 00:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Nm/O/6WGf8Wxwk4bIaTq5mHG8cnBuV454KMheuOsnFI=; b=Sd7qT4LEl4QVGTXSruESA+QmZQ
        3OS5zEOCVfuZFQnvMhW/9S8sMD0xN0yVxL6A87ZjhJHHOENHLSxY8tMfTEGlW6WVQ64dcklx+dQFN
        b8+ujIJSzOIsKFOGgb1/9OiKcZa0gUBImpoGN7/whQsLYOem+x1pN7QqdgbCD1ik0fE0E756PlEro
        PQR8njayoRXir53PnU+NyYZQuA3KzBgK21if5QIhrgKN6s+RVeSQYbAewS+t8IeQSbLTAZxagHoe0
        geh//y/cs2f0lXXDNPadR0fgACEOReiSwojIn6aXvK1KOs7RqwKQgYDOHT+TuEqYxbzhfaZG2EoZM
        eqxr+Tpg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ltPlZ-007jiE-Up; Wed, 16 Jun 2021 07:15:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8C57F3001E3;
        Wed, 16 Jun 2021 09:15:12 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 39FEE20C169F5; Wed, 16 Jun 2021 09:15:12 +0200 (CEST)
Date:   Wed, 16 Jun 2021 09:15:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yafang Shao <laoar.shao@gmail.com>
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
Subject: Re: [PATCH] sched, fair: try to prevent migration thread from
 preempting non-cfs task
Message-ID: <YMmlAP/QhE6SWhCF@hirez.programming.kicks-ass.net>
References: <20210615121551.31138-1-laoar.shao@gmail.com>
 <20210615203534.GA4272@worktop.programming.kicks-ass.net>
 <CALOAHbBuZJaK+fEg7toRUHJNP8rJKDoADeAUxorUuNU17kdTOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALOAHbBuZJaK+fEg7toRUHJNP8rJKDoADeAUxorUuNU17kdTOA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 09:44:46AM +0800, Yafang Shao wrote:
> On Wed, Jun 16, 2021 at 4:35 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Tue, Jun 15, 2021 at 08:15:51PM +0800, Yafang Shao wrote:
> > > ---
> > >  kernel/sched/fair.c | 14 ++++++++++++++
> > >  1 file changed, 14 insertions(+)
> > >
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index 3248e24a90b0..597c7a940746 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -9797,6 +9797,20 @@ static int load_balance(int this_cpu, struct rq *this_rq,
> > >                       /* Record that we found at least one task that could run on this_cpu */
> > >                       env.flags &= ~LBF_ALL_PINNED;
> > >
> > > +                     /*
> > > +                      * There may be a race between load balance starting migration
> > > +                      * thread to pull the cfs running thread and the RT thread
> > > +                      * waking up and preempting cfs task before migration threads
> > > +                      * which then preempt the RT thread.
> > > +                      * We'd better do the last minute check before starting
> > > +                      * migration thread to avoid preempting latency-sensitive thread.
> > > +                      */
> > > +                     if (busiest->curr->sched_class != &fair_sched_class) {
> > > +                             raw_spin_unlock_irqrestore(&busiest->lock,
> > > +                                                        flags);
> >
> > This won't apply.
> >
> > Also, there's still a race window, you've just shrunk it, not fixed it.
> > Busiest can reschedule between the mandatory rq unlock and doing the
> > stopper wakeup.
> >
> > An actual fix might be to have the active migration done by a FIFO-1
> > task, instead of stopper. The obvious down-side is that that would mean
> > spawning yet another per-cpu kthread.
> >
> 
> The stopper and the migration thread are different threads in the earlier days.
> commit 969c79215a35 ("sched: replace migration_thread with cpu_stop")
> merged them into one thread.

Yes, I know, I was there. But that's not what I'm saying, we need the
migration thread to be super high perio for other cases. That change
still makes sense.

> Regarding the priority of stopper (with highest priority) and
> migration (higher than CFS, but lower than RT) , keeping them in one
> single thread seems not a good way.

I never suggested as such.

Only the active migration of CFS can be done by a FIFO-1 task (the
lowest prio that is higher than CFS) and possible the numa balancing
thing.

Other migrations will still need to use stopper, and as such you'll keep
having interference from stopper.

The suggestion was adding a cfs_migration thread, specifically for
active balance (and maybe numa). Just not sure the cost of carrying yet
another per-cpu kernel thread is worth the benefit.
