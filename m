Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 275293B9F8C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 13:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbhGBLPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 07:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbhGBLPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 07:15:37 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA68DC061762
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jul 2021 04:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=n3ZL5mkrhEYr2VcrInZbn1X+Tb8h0bzNV1DESPBO+fc=; b=WBW0uF5BM+0qp8Znl7C1Wo9Fpl
        BERgSS7E1WNTyeeAvjFVMBkgJVoiyDZpufRVlBS89q7mQGzwHvUmSknN8RZpYBHridZBDoOP6rqyD
        WtT16R4K6TY5ahPazEpqwhBLcz7bnxcIVVXHpUevvpuiegENchvg1UYodS+MhoXmY5gmUkeeFfP2X
        G2NhoF7+RdbqUS184XdRu+WPi5Uri2XoNvEWQrqwiaNFQe8gBVIWNXDQVYvLsVzKc7t33NGvAHlP2
        gIVcT+R+u384gXs3dZL8zxx8PZ8a3fJU+0NiixSh1W5QKMZdTUzoYVCeCiZHjJXRsKXBZeVkXF+Di
        o6jHApDQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lzH6I-00DqH9-A0; Fri, 02 Jul 2021 11:12:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 83485300091;
        Fri,  2 Jul 2021 13:12:49 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4CC4620195214; Fri,  2 Jul 2021 13:12:49 +0200 (CEST)
Date:   Fri, 2 Jul 2021 13:12:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Xuewen Yan <xuewen.yan94@gmail.com>
Cc:     valentin.schneider@arm.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        patrick.bellasi@matbug.net, qais.yousef@arm.com, qperret@google.com
Subject: Re: [PATCH v2] sched/uclamp: Avoid getting unreasonable ucalmp value
 when rq is idle
Message-ID: <YN70sbUGh2pViWEQ@hirez.programming.kicks-ass.net>
References: <20210630141204.8197-1-xuewen.yan94@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210630141204.8197-1-xuewen.yan94@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 30, 2021 at 10:12:04PM +0800, Xuewen Yan wrote:
> From: Xuewen Yan <xuewen.yan@unisoc.com>
> 
> Now in uclamp_rq_util_with(), when the task != NULL, the uclamp_max as following:
> uc_rq_max = rq->uclamp[UCLAMP_MAX].value;
> uc_eff_max = uclamp_eff_value(p, UCLAMP_MAX);
> uclamp_max = max{uc_rq_max, uc_eff_max};
> 
> Consider the following scenario:
> (1)the rq is idle, the uc_rq_max is last runnable task's UCLAMP_MAX;
> (2)the p's uc_eff_max < uc_rq_max.
> 
> As a result, the uclamp_max = uc_rq_max instead of uc_eff_max, it is unreasonable.
> 
> The scenario often happens in find_energy_efficient_cpu(), when the task has smaller UCLAMP_MAX.
> 
> When rq has UCLAMP_FLAG_IDLE flag, enqueuing the task will lift UCLAMP_FLAG_IDLE
> and set the rq clamp as the task's via uclamp_idle_reset(). It doesn't need
> to read the rq clamp. And it can also avoid the problems described above.
> 
> Fixes: 9d20ad7dfc9a ("sched/uclamp: Add uclamp_util_with()")
> 
> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>

Valentin, Qais, can either of you write a Changelog/comment for this, I
can't seem to make any sense of it.

Is this about wake-from-idle, where the first task's uclamp goes amis
because the rq->uclamp values haven't been updated yet?


> ---
>  kernel/sched/sched.h | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index c80d42e9589b..14a41a243f7b 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2818,20 +2818,27 @@ static __always_inline
>  unsigned long uclamp_rq_util_with(struct rq *rq, unsigned long util,
>  				  struct task_struct *p)
>  {
> -	unsigned long min_util;
> -	unsigned long max_util;
> +	unsigned long min_util = 0;
> +	unsigned long max_util = 0;
>  
>  	if (!static_branch_likely(&sched_uclamp_used))
>  		return util;
>  
> -	min_util = READ_ONCE(rq->uclamp[UCLAMP_MIN].value);
> -	max_util = READ_ONCE(rq->uclamp[UCLAMP_MAX].value);
> -
>  	if (p) {
> -		min_util = max(min_util, uclamp_eff_value(p, UCLAMP_MIN));
> -		max_util = max(max_util, uclamp_eff_value(p, UCLAMP_MAX));
> +		min_util = uclamp_eff_value(p, UCLAMP_MIN);
> +		max_util = uclamp_eff_value(p, UCLAMP_MAX);
> +
> +		/*
> +		 * Ignore last runnable task's max clamp, as this task will
> +		 * reset it. Similarly, no need to read the rq's min clamp.
> +		 */
> +		if (rq->uclamp_flags & UCLAMP_FLAG_IDLE)
> +			goto out;
>  	}
>  
> +	min_util = max_t(unsigned long, min_util, READ_ONCE(rq->uclamp[UCLAMP_MIN].value));
> +	max_util = max_t(unsigned long, max_util, READ_ONCE(rq->uclamp[UCLAMP_MAX].value));
> +out:
>  	/*
>  	 * Since CPU's {min,max}_util clamps are MAX aggregated considering
>  	 * RUNNABLE tasks with _different_ clamps, we can end up with an
> -- 
> 2.25.1
> 
