Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A20AE3B90FC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 13:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236195AbhGALKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 07:10:38 -0400
Received: from foss.arm.com ([217.140.110.172]:51590 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236052AbhGALKh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 07:10:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C56BC6D;
        Thu,  1 Jul 2021 04:08:06 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (unknown [10.1.195.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A1783F718;
        Thu,  1 Jul 2021 04:08:05 -0700 (PDT)
Date:   Thu, 1 Jul 2021 12:08:03 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Quentin Perret <qperret@google.com>
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rickyiu@google.com, wvw@google.com,
        patrick.bellasi@matbug.net, xuewen.yan94@gmail.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v3 1/3] sched: Fix UCLAMP_FLAG_IDLE setting
Message-ID: <20210701110803.2lka3eaoukbb6b4p@e107158-lin.cambridge.arm.com>
References: <20210623123441.592348-1-qperret@google.com>
 <20210623123441.592348-2-qperret@google.com>
 <20210630145848.htb7pnwsl2gao77x@e107158-lin.cambridge.arm.com>
 <YNyRisb3bNhDR0Rh@google.com>
 <YN2T1qnalRUKNcXt@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YN2T1qnalRUKNcXt@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/01/21 10:07, Quentin Perret wrote:
> On Wednesday 30 Jun 2021 at 15:45:14 (+0000), Quentin Perret wrote:
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index b094da4c5fea..c0b999a8062a 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -980,7 +980,6 @@ static inline void uclamp_idle_reset(struct rq *rq, enum uclamp_id clamp_id,
> >         if (!(rq->uclamp_flags & UCLAMP_FLAG_IDLE))
> >                 return;
> > 
> > -       rq->uclamp_flags &= ~UCLAMP_FLAG_IDLE;
> >         WRITE_ONCE(rq->uclamp[clamp_id].value, clamp_value);
> >  }
> > 
> > @@ -1253,6 +1252,10 @@ static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p)
> > 
> >         for_each_clamp_id(clamp_id)
> >                 uclamp_rq_inc_id(rq, p, clamp_id);
> > +
> > +       /* Reset clamp idle holding when there is one RUNNABLE task */
> > +       if (rq->uclamp_flags & UCLAMP_FLAG_IDLE)
> > +               rq->uclamp_flags &= ~UCLAMP_FLAG_IDLE;
> >  }
> > 
> >  static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p)
> > @@ -1300,6 +1303,13 @@ uclamp_update_active(struct task_struct *p, enum uclamp_id clamp_id)
> >         if (p->uclamp[clamp_id].active) {
> >                 uclamp_rq_dec_id(rq, p, clamp_id);
> >                 uclamp_rq_inc_id(rq, p, clamp_id);
> > +
> > +               /*
> > +                * Make sure to clear the idle flag if we've transiently reached
> > +                * 0 uclamp active tasks on the rq.
> > +                */
> > +               if (rq->uclamp_flags & UCLAMP_FLAG_IDLE)
> > +                       rq->uclamp_flags &= ~UCLAMP_FLAG_IDLE;
> 
> Bah, now that I had coffee I realize this has the exact same problem.
> Let me look at this again ...

Hehe uclamp has this effect. It's all obvious, until it's not :-)

Yes this needs to be out of the loop.

Thanks for looking at this!

Cheers

--
Qais Yousef
