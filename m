Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9689C3B84C6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 16:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235038AbhF3OOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 10:14:03 -0400
Received: from foss.arm.com ([217.140.110.172]:39244 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234851AbhF3ONz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 10:13:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6EAABED1;
        Wed, 30 Jun 2021 07:11:26 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (unknown [10.1.195.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8AFFF3F718;
        Wed, 30 Jun 2021 07:11:24 -0700 (PDT)
Date:   Wed, 30 Jun 2021 15:11:22 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Xuewen Yan <xuewen.yan94@gmail.com>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Quentin Perret <qperret@google.com>
Subject: Re: [PATCH] sched/uclamp: Fix getting unreasonable ucalmp_max when
 rq is idle
Message-ID: <20210630141122.h5tktnx6kdnlmd32@e107158-lin.cambridge.arm.com>
References: <20210618072349.503-1-xuewen.yan94@gmail.com>
 <87fsx093vm.mognet@arm.com>
 <CAB8ipk9TMTbw2WGrbLuewk_CaYxrvMOp2Ui5xiHiwYB4NmoRhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAB8ipk9TMTbw2WGrbLuewk_CaYxrvMOp2Ui5xiHiwYB4NmoRhA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the CC.

On 06/30/21 09:24, Xuewen Yan wrote:
> On Tue, Jun 29, 2021 at 9:50 PM Valentin Schneider
> <valentin.schneider@arm.com> wrote:
> >
> >
> > +Cc Patrick's current address
> >
> > On 18/06/21 15:23, Xuewen Yan wrote:
> > > From: Xuewen Yan <xuewen.yan@unisoc.com>
> > >
> > > Now in uclamp_rq_util_with(), when the task != NULL, the uclamp_max as following:
> > > uc_rq_max = rq->uclamp[UCLAMP_MAX].value;
> > > uc_eff_max = uclamp_eff_value(p, UCLAMP_MAX);
> > > uclamp_max = max{uc_rq_max, uc_eff_max};
> > >
> > > Consider the following scenario:
> > > (1)the rq is idle, the uc_rq_max is last task's UCLAMP_MAX;
> > > (2)the p's uc_eff_max < uc_rq_max.
> > >
> > > The result is the uclamp_max = uc_rq_max instead of uc_eff_max, it is unreasonable.
> > >
> > > The scenario often happens in find_energy_efficient_cpu(), when the task has smaller UCLAMP_MAX.
> > >
> > > Inserts whether the rq is idle in the uclamp_rq_util_with().
> > >
> > > Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> > > ---
> > >  kernel/sched/sched.h | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > > index a189bec13729..0feef6af89f2 100644
> > > --- a/kernel/sched/sched.h
> > > +++ b/kernel/sched/sched.h
> > > @@ -2550,7 +2550,10 @@ unsigned long uclamp_rq_util_with(struct rq *rq, unsigned long util,
> > >
> > >       if (p) {
> > >               min_util = max(min_util, uclamp_eff_value(p, UCLAMP_MIN));
> > > -             max_util = max(max_util, uclamp_eff_value(p, UCLAMP_MAX));
> > > +             if (rq->uclamp_flags & UCLAMP_FLAG_IDLE)
> > > +                     max_util = uclamp_eff_value(p, UCLAMP_MAX);
> > > +             else
> > > +                     max_util = max(max_util, uclamp_eff_value(p, UCLAMP_MAX));
> >
> > That makes sense to me - enqueuing the task will lift UCLAMP_FLAG_IDLE and
> > set the rq clamp as the task's via uclamp_idle_reset().
> >
> > Does this want a
> >
> >   Fixes: 9d20ad7dfc9a ("sched/uclamp: Add uclamp_util_with()")
> >
> > ?
> 
> Yes，add it.

+1

> 
> >
> > Also, when we have UCLAMP_FLAG_IDLE, we don't even need to read the rq max
> > - and I'm pretty sure the same applies to the rq min. What about something like:

uclamp_min is fine since it defaults to 0. But the suggested improvement looks
good to me.

Thanks

--
Qais Yousef
