Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6326B3B90F6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 13:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236165AbhGALJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 07:09:09 -0400
Received: from foss.arm.com ([217.140.110.172]:51550 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236015AbhGALJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 07:09:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 07FFA6D;
        Thu,  1 Jul 2021 04:06:37 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (unknown [10.1.195.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8F9573F718;
        Thu,  1 Jul 2021 04:06:35 -0700 (PDT)
Date:   Thu, 1 Jul 2021 12:06:33 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Quentin Perret <qperret@google.com>
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rickyiu@google.com, wvw@google.com,
        patrick.bellasi@matbug.net, xuewen.yan94@gmail.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v3 1/3] sched: Fix UCLAMP_FLAG_IDLE setting
Message-ID: <20210701110633.kxkv2wc2hu2nqiss@e107158-lin.cambridge.arm.com>
References: <20210623123441.592348-1-qperret@google.com>
 <20210623123441.592348-2-qperret@google.com>
 <20210630145848.htb7pnwsl2gao77x@e107158-lin.cambridge.arm.com>
 <YNyRisb3bNhDR0Rh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YNyRisb3bNhDR0Rh@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/30/21 15:45, Quentin Perret wrote:
> Hi Qais,
> 
> On Wednesday 30 Jun 2021 at 15:58:48 (+0100), Qais Yousef wrote:
> > I just realized this needs
> > 
> > 	if (clamp_id == UCLAMP_MAX)
> > 		rq->uclamp_flags &= ~UCLAMP_FLAG_IDLE;
> > 
> > The code is only set for UCLAMP_MAX, so should be cleared for UCLAMP_MAX too.
> > 
> > Though there's ugly overload here:
> > 
> > 	if (!(rq->uclamp_flags & UCLAMP_FLAG_IDLE))
> > 		return;
> > 
> > This check would fail prematurely if UCLAMP_MAX was reset before UCLAMP_MIN.
> > The code before your change would reset both then do the clear. But now when we
> > do it from here, we need to be more careful about that.
> 
> Right, although this should all work fine as-is, I agree that relying on
> the calling order is a bit dodgy and might cause issues in the long run.
> 
> What do you think of this instead?

I can't objectively say one way is better than the other, this has the drawback
of having to remember to clear the flag after each call to uclamp_rq_inc_id().
So it's pick your pain type of situation :-)

We can move the flag to struct uclamp_se. But this looks unnecessary churn to
me..

Cheers

--
Qais Yousef

> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index b094da4c5fea..c0b999a8062a 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -980,7 +980,6 @@ static inline void uclamp_idle_reset(struct rq *rq, enum uclamp_id clamp_id,
>         if (!(rq->uclamp_flags & UCLAMP_FLAG_IDLE))
>                 return;
> 
> -       rq->uclamp_flags &= ~UCLAMP_FLAG_IDLE;
>         WRITE_ONCE(rq->uclamp[clamp_id].value, clamp_value);
>  }
> 
> @@ -1253,6 +1252,10 @@ static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p)
> 
>         for_each_clamp_id(clamp_id)
>                 uclamp_rq_inc_id(rq, p, clamp_id);
> +
> +       /* Reset clamp idle holding when there is one RUNNABLE task */
> +       if (rq->uclamp_flags & UCLAMP_FLAG_IDLE)
> +               rq->uclamp_flags &= ~UCLAMP_FLAG_IDLE;
>  }
> 
>  static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p)
> @@ -1300,6 +1303,13 @@ uclamp_update_active(struct task_struct *p, enum uclamp_id clamp_id)
>         if (p->uclamp[clamp_id].active) {
>                 uclamp_rq_dec_id(rq, p, clamp_id);
>                 uclamp_rq_inc_id(rq, p, clamp_id);
> +
> +               /*
> +                * Make sure to clear the idle flag if we've transiently reached
> +                * 0 uclamp active tasks on the rq.
> +                */
> +               if (rq->uclamp_flags & UCLAMP_FLAG_IDLE)
> +                       rq->uclamp_flags &= ~UCLAMP_FLAG_IDLE;
>         }
> 
>         task_rq_unlock(rq, p, &rf);
