Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C60203B8597
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 16:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235621AbhF3PBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 11:01:22 -0400
Received: from foss.arm.com ([217.140.110.172]:40286 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235177AbhF3PBV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 11:01:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 480FB1FB;
        Wed, 30 Jun 2021 07:58:52 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (unknown [10.1.195.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B37F73F718;
        Wed, 30 Jun 2021 07:58:50 -0700 (PDT)
Date:   Wed, 30 Jun 2021 15:58:48 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Quentin Perret <qperret@google.com>
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rickyiu@google.com, wvw@google.com,
        patrick.bellasi@matbug.net, xuewen.yan94@gmail.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v3 1/3] sched: Fix UCLAMP_FLAG_IDLE setting
Message-ID: <20210630145848.htb7pnwsl2gao77x@e107158-lin.cambridge.arm.com>
References: <20210623123441.592348-1-qperret@google.com>
 <20210623123441.592348-2-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210623123441.592348-2-qperret@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quentin

On 06/23/21 12:34, Quentin Perret wrote:
> The UCLAMP_FLAG_IDLE flag is set on a runqueue when dequeueing the last
> active task to maintain the last uclamp.max and prevent blocked util
> from suddenly becoming visible.
> 
> However, there is an asymmetry in how the flag is set and cleared which
> can lead to having the flag set whilst there are active tasks on the rq.
> Specifically, the flag is cleared in the uclamp_rq_inc() path, which is
> called at enqueue time, but set in uclamp_rq_dec_id() which is called
> both when dequeueing a task _and_ in the update_uclamp_active() path. As
> a result, when both uclamp_rq_{dec,ind}_id() are called from
> update_uclamp_active(), the flag ends up being set but not cleared,
> hence leaving the runqueue in a broken state.
> 
> Fix this by clearing the flag in uclamp_idle_reset() which is also
> called in both paths to ensure things remain symmetrical.
> 
> Fixes: e496187da710 ("sched/uclamp: Enforce last task's UCLAMP_MAX")
> Reported-by: Rick Yiu <rickyiu@google.com>
> Reviewed-by: Qais Yousef <qais.yousef@arm.com>
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  kernel/sched/core.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 4ca80df205ce..e514a093a0ba 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -980,6 +980,7 @@ static inline void uclamp_idle_reset(struct rq *rq, enum uclamp_id clamp_id,
>  	if (!(rq->uclamp_flags & UCLAMP_FLAG_IDLE))
>  		return;
>  
> +	rq->uclamp_flags &= ~UCLAMP_FLAG_IDLE;

I just realized this needs

	if (clamp_id == UCLAMP_MAX)
		rq->uclamp_flags &= ~UCLAMP_FLAG_IDLE;

The code is only set for UCLAMP_MAX, so should be cleared for UCLAMP_MAX too.

Though there's ugly overload here:

	if (!(rq->uclamp_flags & UCLAMP_FLAG_IDLE))
		return;

This check would fail prematurely if UCLAMP_MAX was reset before UCLAMP_MIN.
The code before your change would reset both then do the clear. But now when we
do it from here, we need to be more careful about that.

Not sure what we can do beside adding a comment. The options I'm thinking about
are too intrusive FWIW.

Cheers

--
Qais Yousef

>  	WRITE_ONCE(rq->uclamp[clamp_id].value, clamp_value);
>  }
>  
> @@ -1252,10 +1253,6 @@ static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p)
>  
>  	for_each_clamp_id(clamp_id)
>  		uclamp_rq_inc_id(rq, p, clamp_id);
> -
> -	/* Reset clamp idle holding when there is one RUNNABLE task */
> -	if (rq->uclamp_flags & UCLAMP_FLAG_IDLE)
> -		rq->uclamp_flags &= ~UCLAMP_FLAG_IDLE;
>  }
>  
>  static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p)
> -- 
> 2.32.0.288.g62a8d224e6-goog
> 
