Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF88437586B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 18:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235583AbhEFQ1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 12:27:13 -0400
Received: from foss.arm.com ([217.140.110.172]:37406 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235167AbhEFQ1H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 12:27:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CCFA031B;
        Thu,  6 May 2021 09:26:07 -0700 (PDT)
Received: from ubiquitous (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D34D83F718;
        Thu,  6 May 2021 09:26:05 -0700 (PDT)
Date:   Thu, 6 May 2021 16:26:00 +0000
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     Xuewen Yan <xuewen.yan94@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Ryan Y <xuewyan@foxmail.com>
Subject: Re: [PATCH] sched/pelt: Add UTIL_AVG_UNCHANGED flag for
 last_enqueued_diff
Message-ID: <20210506162600.GA11916@ubiquitous>
References: <20210506110936.8797-1-xuewen.yan94@gmail.com>
 <20210506122823.GA8671@ubiquitous>
 <CAB8ipk-uL4Z1SY5sxhZ8dTtdvg8AzLtPS6QNEQFxuKCDdeBZxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB8ipk-uL4Z1SY5sxhZ8dTtdvg8AzLtPS6QNEQFxuKCDdeBZxQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 06, 2021 at 08:46:08PM +0800, Xuewen Yan wrote:
> Hi
> On Thu, May 6, 2021 at 8:28 PM Vincent Donnefort
> <vincent.donnefort@arm.com> wrote:
> >
> > On Thu, May 06, 2021 at 07:09:36PM +0800, Xuewen Yan wrote:
> > > From: Xuewen Yan <xuewen.yan@unisoc.com>
> > >
> > > The UTIL_AVG_UNCHANGED flag had been cleared when the task util changed.
> > > And the enqueued is equal to task_util with the flag, so it is better
> > > to add the UTIL_AVG_UNCHANGED flag for last_enqueued_diff.

Could we change the description here a bit? I don't think this is accurately
explaning the issue. Would probably be interesting to mention that by not
setting the flag, which is the LSB, we add +1 to the diff. This is therefore
reducing slightly UTIL_EST_MARGIN.

> > >
> > > Fixes: b89997aa88f0b sched/pelt: Fix task util_est update filtering
> > >
> > > Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> > > ---
> > >  kernel/sched/fair.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index e5e457fa9dc8..94d77b4fa601 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -3996,7 +3996,7 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
> > >       if (ue.enqueued & UTIL_AVG_UNCHANGED)
> > >               return;
> > >
> > > -     last_enqueued_diff = ue.enqueued;
> > > +     last_enqueued_diff = (ue.enqueued | UTIL_AVG_UNCHANGED);
> > >
> > >       /*
> > >        * Reset EWMA on utilization increases, the moving average is used only
> > > --
> > > 2.29.0
> > >
> >
> > Hi,
> >
> > We do indeed for the diff use the flag for the value updated and no flag for the
> > value before the update. However, last_enqueued_diff is only used for the margin
> > check which is an heuristic and is not an accurate value (~1%) and as we know
> The last_enqueued_diff is compared with the UTIL_EST_MARGIN which is
> "1024/100 = 10",
> and The LSB may cause ~10% error.

I meant ~1% being the original margin. With the bit set, we would use 0.87% instead
of 0.97%.

> > we already loose the LSB in util_est, I'm not sure this is really necessary.
> I'm also not very sure, maybe the calculation will be more rigorous
> with the flag?
> >
> > --
> > Vincent
> >
