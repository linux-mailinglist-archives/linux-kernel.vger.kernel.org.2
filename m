Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B110B321307
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 10:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbhBVJZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 04:25:49 -0500
Received: from foss.arm.com ([217.140.110.172]:36840 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230044AbhBVJZQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 04:25:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 68B51D6E;
        Mon, 22 Feb 2021 01:24:28 -0800 (PST)
Received: from e124901.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DB5A43F73B;
        Mon, 22 Feb 2021 01:24:26 -0800 (PST)
Date:   Mon, 22 Feb 2021 09:24:26 +0000
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: Re: [PATCH] sched/pelt: Fix task util_est update filtering
Message-ID: <20210222092426.GA5716@e124901.cambridge.arm.com>
References: <20210216163921.572228-1-vincent.donnefort@arm.com>
 <CAKfTPtDC1GYV_7zoUtZa5MNLdt0Lx=X_UgB=Q8UtsGf8=Kd3iQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtDC1GYV_7zoUtZa5MNLdt0Lx=X_UgB=Q8UtsGf8=Kd3iQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 19, 2021 at 11:48:28AM +0100, Vincent Guittot wrote:
> On Tue, 16 Feb 2021 at 17:39, <vincent.donnefort@arm.com> wrote:
> >
> > From: Vincent Donnefort <vincent.donnefort@arm.com>
> >
> > Being called for each dequeue, util_est reduces the number of its updates
> > by filtering out when the EWMA signal is different from the task util_avg
> > by less than 1%. It is a problem for a sudden util_avg ramp-up. Due to the
> > decay from a previous high util_avg, EWMA might now be close enough to
> > the new util_avg. No update would then happen while it would leave
> > ue.enqueued with an out-of-date value.
> >
> > Taking into consideration the two util_est members, EWMA and enqueued for
> > the filtering, ensures, for both, an up-to-date value.
> >
> > This is for now an issue only for the trace probe that might return the
> > stale value. Functional-wise, it isn't (yet) a problem, as the value is
> 
> What do you mean by "it isn't (yet) a problem" ? How could this become
> a problem ?

I wrote "yet" as nothing prevents anyone from using the ue.enqueued signal.

> 
> > always accessed through max(enqueued, ewma).
> >
> 
> This adds more tests and or update of  struct avg.util_est. It would
> be good to have an idea of the perf impact. Especially because this
> only fixes a tracing problem

I ran hackbench on the big cores of a SD845C board. After 100 iterations of
100 loops runs, the geometric mean of the hackbench test is 0.1% lower
with this patch applied (2.0833s vs 2.0858s). The p-value, computed with
the ks_2samp [1] is 0.37. We can't conclude that the two distributions are
different. This patch, in this scenario seems completely harmless.

Shall I include those results in the commit message?

[1] https://docs.scipy.org/doc/scipy/reference/generated/scipy.stats.ks_2samp.html

> 
> 
> > This problem has been observed using LISA's UtilConvergence:test_means on
> > the sd845c board.
> >
> > Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 794c2cb945f8..9008e0c42def 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -3941,24 +3941,27 @@ static inline void util_est_dequeue(struct cfs_rq *cfs_rq,
> >         trace_sched_util_est_cfs_tp(cfs_rq);
> >  }
> >
> > +#define UTIL_EST_MARGIN (SCHED_CAPACITY_SCALE / 100)
> > +
> >  /*
> > - * Check if a (signed) value is within a specified (unsigned) margin,
> > + * Check if a (signed) value is within the (unsigned) util_est margin,
> >   * based on the observation that:
> >   *
> >   *     abs(x) < y := (unsigned)(x + y - 1) < (2 * y - 1)
> >   *
> > - * NOTE: this only works when value + maring < INT_MAX.
> > + * NOTE: this only works when value + UTIL_EST_MARGIN < INT_MAX.
> >   */
> > -static inline bool within_margin(int value, int margin)
> > +static inline bool util_est_within_margin(int value)
> >  {
> > -       return ((unsigned int)(value + margin - 1) < (2 * margin - 1));
> > +       return ((unsigned int)(value + UTIL_EST_MARGIN - 1) <
> > +               (2 * UTIL_EST_MARGIN - 1));
> >  }
> >
> >  static inline void util_est_update(struct cfs_rq *cfs_rq,
> >                                    struct task_struct *p,
> >                                    bool task_sleep)
> >  {
> > -       long last_ewma_diff;
> > +       long last_ewma_diff, last_enqueued_diff;
> >         struct util_est ue;
> >
> >         if (!sched_feat(UTIL_EST))
> > @@ -3979,6 +3982,8 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
> >         if (ue.enqueued & UTIL_AVG_UNCHANGED)
> >                 return;
> >
> > +       last_enqueued_diff = ue.enqueued;
> > +
> >         /*
> >          * Reset EWMA on utilization increases, the moving average is used only
> >          * to smooth utilization decreases.
> > @@ -3992,12 +3997,19 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
> >         }
> >
> >         /*
> > -        * Skip update of task's estimated utilization when its EWMA is
> > +        * Skip update of task's estimated utilization when its members are
> >          * already ~1% close to its last activation value.
> >          */
> >         last_ewma_diff = ue.enqueued - ue.ewma;
> > -       if (within_margin(last_ewma_diff, (SCHED_CAPACITY_SCALE / 100)))
> > +       last_enqueued_diff -= ue.enqueued;
> > +       if (util_est_within_margin(last_ewma_diff)) {
> > +               if (!util_est_within_margin(last_enqueued_diff)) {
> > +                       ue.ewma = ue.enqueued;
> > +                       goto done;
> > +               }
> > +
> >                 return;
> > +       }
> >
> >         /*
> >          * To avoid overestimation of actual task utilization, skip updates if
> > --
> > 2.25.1
> >
