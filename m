Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51FE13753D8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 14:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbhEFM3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 08:29:35 -0400
Received: from foss.arm.com ([217.140.110.172]:33992 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231190AbhEFM3a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 08:29:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6BBD6106F;
        Thu,  6 May 2021 05:28:32 -0700 (PDT)
Received: from ubiquitous (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A18363F73B;
        Thu,  6 May 2021 05:28:30 -0700 (PDT)
Date:   Thu, 6 May 2021 12:28:23 +0000
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     Xuewen Yan <xuewen.yan94@gmail.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        zhang.lyra@gmail.com, xuewyan@foxmail.com
Subject: Re: [PATCH] sched/pelt: Add UTIL_AVG_UNCHANGED flag for
 last_enqueued_diff
Message-ID: <20210506122823.GA8671@ubiquitous>
References: <20210506110936.8797-1-xuewen.yan94@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210506110936.8797-1-xuewen.yan94@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 06, 2021 at 07:09:36PM +0800, Xuewen Yan wrote:
> From: Xuewen Yan <xuewen.yan@unisoc.com>
> 
> The UTIL_AVG_UNCHANGED flag had been cleared when the task util changed.
> And the enqueued is equal to task_util with the flag, so it is better
> to add the UTIL_AVG_UNCHANGED flag for last_enqueued_diff.
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

Hi,

We do indeed for the diff use the flag for the value updated and no flag for the
value before the update. However, last_enqueued_diff is only used for the margin
check which is an heuristic and is not an accurate value (~1%) and as we know
we already loose the LSB in util_est, I'm not sure this is really necessary.

-- 
Vincent

