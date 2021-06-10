Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2063A28E7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 12:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbhFJKCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 06:02:39 -0400
Received: from foss.arm.com ([217.140.110.172]:55726 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229770AbhFJKCi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 06:02:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A2822D6E;
        Thu, 10 Jun 2021 03:00:42 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (unknown [10.1.195.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 51ABE3F694;
        Thu, 10 Jun 2021 03:00:41 -0700 (PDT)
Date:   Thu, 10 Jun 2021 11:00:39 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Quentin Perret <qperret@google.com>
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rickyiu@google.com, wvw@google.com,
        patrick.bellasi@matbug.net, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH] sched: Fix UCLAMP_FLAG_IDLE setting
Message-ID: <20210610100039.2gvnl3lu6o2hu5yj@e107158-lin.cambridge.arm.com>
References: <20210609143339.1194238-1-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210609143339.1194238-1-qperret@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/09/21 14:33, Quentin Perret wrote:
> The UCLAMP_FLAG_IDLE flag is set on a runqueue when dequeueing the last
> active task to maintain the last uclamp.max and prevent blocked util
> from suddenly becoming visible.
> 
> However, there is an asymmetry in how the flag is set and cleared which
> can lead to having the flag set whilst there are active task on the rq.
> Specifically, the flag is set in the uclamp_rq_inc() path, which is
> called at enqueue time, but cleared in the uclamp_rq_dec_id() which is

It is actually the other way around. It is cleared in uclamp_rq_inc() and
set in uclamp_rq_dec_id().

> called both when dequeueing and task _and_ during cgroup migrations.

Is it cgroup migrations or when cgroup uclamp values are updated you mean?

It is worth being direct and mention that uclamp_update_active() will perform
uclamp_rq_dec/inc_id() when the cgroup uclamp values are updated, which would
end up with the flag set but not cleared in this path.

> 
> Fix this by setting the flag in the uclamp_rq_inc_id() path to ensure
> things remain symmetrical.
> 
> Reported-by: Rick Yiu <rickyiu@google.com>
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---

With the commit message fixed.

Reviewed-by: Qais Yousef <qais.yousef@arm.com>

Thanks!

--
Qais Yousef

>  kernel/sched/core.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 5226cc26a095..3b213402798e 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -980,6 +980,7 @@ static inline void uclamp_idle_reset(struct rq *rq, enum uclamp_id clamp_id,
>  	if (!(rq->uclamp_flags & UCLAMP_FLAG_IDLE))
>  		return;
>  
> +	rq->uclamp_flags &= ~UCLAMP_FLAG_IDLE;
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
> 2.32.0.272.g935e593368-goog
> 
