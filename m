Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA35337653C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 14:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236539AbhEGMgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 08:36:36 -0400
Received: from foss.arm.com ([217.140.110.172]:57920 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231179AbhEGMgf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 08:36:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 43BF4106F;
        Fri,  7 May 2021 05:35:35 -0700 (PDT)
Received: from e120877-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 66FCF3F718;
        Fri,  7 May 2021 05:35:33 -0700 (PDT)
Date:   Fri, 7 May 2021 13:35:28 +0100
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     Xuewen Yan <xuewen.yan94@gmail.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        zhang.lyra@gmail.com, xuewyan@foxmail.com
Subject: Re: [PATCH v2] sched/pelt: Keep UTIL_AVG_UNCHANGED flag in sync when
 calculating last_enqueued_diff
Message-ID: <20210507123528.GA106818@e120877-lin.cambridge.arm.com>
References: <20210507112031.23073-1-xuewen.yan94@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210507112031.23073-1-xuewen.yan94@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 07, 2021 at 07:20:31PM +0800, Xuewen Yan wrote:
> From: Xuewen Yan <xuewen.yan@unisoc.com>
> 
> Last_enqueued_diff's meaning: "diff = util_est.enqueued(p) - task_util(p)".
> When calculating last_enqueued_diff, we add UTIL_AVG_UNCHANGED flag, which
> is the LSB, for task_util, but don't add the flag for util_est.enqueued.
> However the enqueued's flag had been cleared when the task util changed.
> As a result, we add +1 to the diff, this is therefore reducing slightly
> UTIL_EST_MARGIN.

Unless I miss something it actually depends on the situation, doesn't it?

if ue.enqueued > task_util(), we remove 1 from the diff => UTIL_EST_MARGIN + 1

if ue.enqueued < task_util(), we add 1 to the diff => UTIL_EST_MARGIN -1

> 
> Add the flag for util_est.enqueued to have a accurate computation.
> 
> Fixes: b89997aa88f0b sched/pelt: Fix task util_est update filtering
> 
> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> ---
>  kernel/sched/fair.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index e5e457fa9dc8..94d77b4fa601 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3996,7 +3996,7 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
>  	if (ue.enqueued & UTIL_AVG_UNCHANGED)
>  		return;
>  
> -	last_enqueued_diff = ue.enqueued;
> +	last_enqueued_diff = (ue.enqueued | UTIL_AVG_UNCHANGED);
>  
>  	/*
>  	 * Reset EWMA on utilization increases, the moving average is used only
> -- 
> 2.29.0
>
