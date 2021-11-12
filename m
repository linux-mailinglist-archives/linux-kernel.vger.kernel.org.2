Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1AA44EA14
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 16:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235204AbhKLPcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 10:32:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbhKLPct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 10:32:49 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690B6C061766
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 07:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/ucJNr9en1kUex0u9pFrxrq7QZytj7K1+9+CvK6pDA0=; b=l2V+g7WM9QG/HYWjyCOcMPJord
        p6JXS9+f+JYz65wcPPdHfFF8lpBOErA8tpyxJfD1cA57O2gqhc2LL9EwZDDJqaOVl6MlKkACsoiLJ
        SjyYP5LKhXBetCM06LrGAwKTbSHFpSgsXD6rQTnqhTF97ZknP2HyFYr6jHTohITPqUgoUSqxGYM8m
        xqn6SuinPRltGzjfKCQBV0o9qDvSaVV+TEpoNVsGxYTwqUjCvghwH7H1BfdvMsj5PRyddjAtJeqHO
        Mkt9QHdX4dv/YCGpwN7FKMSSIjN2vGNcNEKElBVwN/sXu+dlbTE7yFl1zyCoeOSsjoDJud7NknS+9
        p72yDmJA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mlYUo-003cvi-Sc; Fri, 12 Nov 2021 15:29:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D6D1630001B;
        Fri, 12 Nov 2021 16:29:41 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B8C552BAEA085; Fri, 12 Nov 2021 16:29:41 +0100 (CET)
Date:   Fri, 12 Nov 2021 16:29:41 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        tim.c.chen@linux.intel.com, joel@joelfernandes.org
Subject: Re: [PATCH 1/2] sched/fair: skip newidle update stats
Message-ID: <YY6IZZWuuNN12187@hirez.programming.kicks-ass.net>
References: <20211112095857.7016-1-vincent.guittot@linaro.org>
 <20211112095857.7016-2-vincent.guittot@linaro.org>
 <YY56RBQR912S6ScC@hirez.programming.kicks-ass.net>
 <CAKfTPtCGnQc+knLbm=zR-a5T2yEJOZo3CWTJcwHgGdZQ0uYyog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtCGnQc+knLbm=zR-a5T2yEJOZo3CWTJcwHgGdZQ0uYyog@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 12, 2021 at 03:47:21PM +0100, Vincent Guittot wrote:
> On Fri, 12 Nov 2021 at 15:29, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Fri, Nov 12, 2021 at 10:58:56AM +0100, Vincent Guittot wrote:
> > > In case we skip the newly idle LB entirely or we abort it because we are
> > > going to exceed the avg_idle, we have to make sure to not start an update
> > > of the blocked load when entering idle
> > >
> > > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > ---
> > >  kernel/sched/fair.c | 18 ++++++++++++++----
> > >  1 file changed, 14 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index 13950beb01a2..a162b0ec8963 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -10861,7 +10861,7 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
> > >       int this_cpu = this_rq->cpu;
> > >       u64 t0, t1, curr_cost = 0;
> > >       struct sched_domain *sd;
> > > -     int pulled_task = 0;
> > > +     int pulled_task = 0, early_stop = 0;
> > >
> > >       update_misfit_status(NULL, this_rq);
> > >
> > > @@ -10898,8 +10898,16 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
> > >       if (!READ_ONCE(this_rq->rd->overload) ||
> > >           (sd && this_rq->avg_idle < sd->max_newidle_lb_cost)) {
> > >
> > > -             if (sd)
> > > +             if (sd) {
> > >                       update_next_balance(sd, &next_balance);
> > > +
> > > +                     /*
> > > +                      * We skip new idle LB because there is not enough
> > > +                      * time before next wake up. Make sure that we will
> > > +                      * not kick NOHZ_NEWILB_KICK
> > > +                      */
> > > +                     early_stop = 1;
> > > +             }
> > >               rcu_read_unlock();
> > >
> > >               goto out;

> > Anyway, does nohz_newidle_balance() want to loose it's ->avg_idle test
> > with this on?
> 
> This test still covers cases with short newly idle balance. Being
> conservative, people never complained that the update of blocked load
> average of idle CPUs doesn't happen often enough. It's most often the
> opposite

Well, per commit c5b0a7eefc70 ("sched/fair: Remove
sysctl_sched_migration_cost condition") combined with the above change,
we no longer call nohz_newidle_balance() in exactly that condition,
right?

Or are we worried about that !overload case?
