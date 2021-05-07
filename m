Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F08F7376954
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 19:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236032AbhEGRPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 13:15:48 -0400
Received: from foss.arm.com ([217.140.110.172]:36700 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230499AbhEGRPp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 13:15:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C35A11FB;
        Fri,  7 May 2021 10:14:45 -0700 (PDT)
Received: from e120877-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ABEA73F718;
        Fri,  7 May 2021 10:14:43 -0700 (PDT)
Date:   Fri, 7 May 2021 18:14:38 +0100
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Xuewen Yan <xuewen.yan94@gmail.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        linux-kernel@vger.kernel.org, zhang.lyra@gmail.com,
        xuewyan@foxmail.com
Subject: Re: [PATCH v2] sched/pelt: Keep UTIL_AVG_UNCHANGED flag in sync when
 calculating last_enqueued_diff
Message-ID: <20210507171438.GA326455@e120877-lin.cambridge.arm.com>
References: <20210507112031.23073-1-xuewen.yan94@gmail.com>
 <20210507123528.GA106818@e120877-lin.cambridge.arm.com>
 <da0fe50a-f419-e6a1-d67f-76fbe5cbf520@arm.com>
 <20210507153827.GA176408@e120877-lin.cambridge.arm.com>
 <c265d9ab-f06f-692f-df43-464bf4f2ea68@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c265d9ab-f06f-692f-df43-464bf4f2ea68@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

> > 
> > But we take the abs() of last_enqueued_diff.
> > 
> > If we consider the following examples:
> > 
> >    enqueued_old = 5, enqueued_new = 9
> >    diff = 5 - (9 + 1) => 5 - 10 => -5
> > 
> >    enqueued_old = 9, enqueued_new = 5
> >    diff = 9 - (5 + 1) => 9 - 6 => 3
> > 
> > In both cases the delta is supposed to be 4. But in the first case we end-up
> > with 5. In the second, we end-up with 3. That's why I meant the effect on the
> > diff depends on who's greater, ue.enqueued or task_util().
> 
> Ah, OK, due to the abs() in within_margin(). But util's LSB is lost due
> to the flag anyway. Hence I assume e.g. enqueued_new = 9 should be
> (task_util() = 8) + 1 (| flag) in the example.

Yeah, I should have used an even number for the demonstration :-) 

> 
> OTHA, implementing UTIL_AVG_UNCHANGED as LSB and making this visible on
> the util_est 'API' has other issues too. The condition
> `!task_util_est(p)` can never be true in find_energy_efficient_cpu()
> because of UTIL_AVG_UNCHANGED.
> 
> So why not use `UTIL_AVG_UNCHANGED = 0x80000000` and just keep its use
> internal (between cfs_se_util_change() and util_est_update()), i.e. not
> exporting it (via _task_util_est()) and not eclipsing util_est's LSB
> value?

As this would be fixing two issues at once, it's probably preferable.

[...]

>  kernel/sched/fair.c |  5 +++--
>  kernel/sched/pelt.h | 11 ++++++-----
>  2 files changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 1d75af1ecfb4..dd30e362c3cc 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3902,7 +3902,7 @@ static inline unsigned long _task_util_est(struct task_struct *p)
>  {
>  	struct util_est ue = READ_ONCE(p->se.avg.util_est);
>  
> -	return (max(ue.ewma, ue.enqueued) | UTIL_AVG_UNCHANGED);
> +	return max(ue.ewma, (ue.enqueued & ~UTIL_AVG_UNCHANGED));
>  }
>  
>  static inline unsigned long task_util_est(struct task_struct *p)
> @@ -4002,7 +4002,7 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
>  	 * Reset EWMA on utilization increases, the moving average is used only
>  	 * to smooth utilization decreases.
>  	 */

Needs to be updated to add:

 	last_enqueued_diff = ue.enqueued & ~UTIL_AVG_UNCHANGED;

> -	ue.enqueued = (task_util(p) | UTIL_AVG_UNCHANGED);
> +	ue.enqueued = task_util(p);
>  	if (sched_feat(UTIL_EST_FASTUP)) {
>  		if (ue.ewma < ue.enqueued) {
>  			ue.ewma = ue.enqueued;
> @@ -4051,6 +4051,7 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
>  	ue.ewma  += last_ewma_diff;
>  	ue.ewma >>= UTIL_EST_WEIGHT_SHIFT;
>  done:
> +	ue.enqueued |= UTIL_AVG_UNCHANGED;
>  	WRITE_ONCE(p->se.avg.util_est, ue);
>  
>  	trace_sched_util_est_se_tp(&p->se);
> diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
> index 1462846d244e..476faf61f14a 100644
