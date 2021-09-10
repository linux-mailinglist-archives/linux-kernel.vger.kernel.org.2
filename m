Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC1B406CC2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 15:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233437AbhIJNRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 09:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbhIJNRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 09:17:38 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C9DC061574
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 06:16:27 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id m21so1824366qkm.13
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 06:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FknGQ9U1stlutagos+WV3Ucyd5NnLYRQGwrPVMjtmBo=;
        b=TbDff5UwK7jL2WwkG+GpBV/pmTYT/Z3CRM36LIrpLo2uiLmBvGcqRynJGEz+5ChF9n
         BDKLGC/lw4VrqwYqS30YQsnGhabPphs/iYBG7KRV0mgjfd2DZV9HqhaCmOQ46z+sTjB1
         V8absrSqMTXPy4pyf/wjrFz6QJVk3GTjNO2E8w9AkrJGU/RxAELS+GsdEnay71s4sI2C
         L/aboAIR6xkIQ029f5ZL5WPjcmz/ekQ/09bLeOCGTHtBZw/SendhYlOkZ6Jt/bhQi0Ne
         1MTKrRhcUqQkjdwjj0aJy51gKh9KmgjtKKVFK3I1Pq66TnMQSdg2jCQe54lM/K8Z9nAE
         cr8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FknGQ9U1stlutagos+WV3Ucyd5NnLYRQGwrPVMjtmBo=;
        b=617hSMhw3O4sNf6uFXJa33MQJNW3rq/+rQ9kDbiNCasGZbYHG5VyDvdJWrwf/2vwwn
         fhPURXbAWOu3jlTRjtfbGv0+dMfz7IKFF7SJGA8D+xd9YkbiB12tY/qnrldo+vGeDHxp
         njLkpWWEF5HB5M8SdM0edSJNDY/p75VdWD2ocL5lRasa0NxhxMAS+2Bdian/HAXzIFgI
         PemCZo3TIJDXRGTHlVghxQFErzzwS4Rf64I4ju3H4fsZNUiK5GgfuzziBz1IrEdudfDp
         Id6/YK/iKq3RBve06HMFI8TY4+OuIy61ZJs327ykX5mZFiQ6kKSB+T+vFLV9Q1R2+XKZ
         dELQ==
X-Gm-Message-State: AOAM533D5t19T//soRIv2UEvLRrlV3v8VuABXewFxnS28cGQpXGK/uIV
        2dG6iyCSG6kEmFAVxLRtH5hQcA==
X-Google-Smtp-Source: ABdhPJylSD2bI37pKEr+yNoLv5WZcg/wQ9gQeAkSZnF6j1d6YwzMa5GWH4ADys4uzJ4DQswDQp9EpQ==
X-Received: by 2002:a05:620a:1658:: with SMTP id c24mr7540497qko.354.1631279786462;
        Fri, 10 Sep 2021 06:16:26 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id s6sm3593907qkf.80.2021.09.10.06.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 06:16:26 -0700 (PDT)
Date:   Fri, 10 Sep 2021 09:18:18 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Huangzhaoyang <huangzhaoyang@gmail.com>
Cc:     Zhaoyang Huang <zhaoyang.huang@unisoc.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, xuewen.yan@unisoc.com,
        ke.wang@unisoc.com
Subject: Re: [PATCH] psi : calc cfs task  memstall time more precisely
Message-ID: <YTtbGpE8/1ZxjtP2@cmpxchg.org>
References: <1631260486-6735-1-git-send-email-huangzhaoyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1631260486-6735-1-git-send-email-huangzhaoyang@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please don't send new revisions without replying to previous feedback.

On Fri, Sep 10, 2021 at 03:54:46PM +0800, Huangzhaoyang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> cfs task's memstall time is counted as simple as exit - entry so far, which
> ignore the preempted time by rt, dl and irq time. Eliminating them by calc the
> time growth via the proportion of cfs_rq's utilization on the whole rq.
> 
> eg.
> Here is the scenario which this commit want to fix, that is the rt and irq consume
> some utilization of the whole rq. This scenario could be typical in a core
> which is assigned to deal with all irqs. Furthermore, the rt task used to run on
> little core under EAS.
> 
> Binder:305_3-314    [002] d..1   257.880195: psi_memtime_fixup: original:30616,adjusted:25951,se:89,cfs:353,rt:139,dl:0,irq:18
> droid.phone-1525    [001] d..1   265.145492: psi_memtime_fixup: original:61616,adjusted:53492,se:55,cfs:225,rt:121,dl:0,irq:15
> 
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> ---
>  kernel/sched/psi.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index cc25a3c..754a836 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -182,6 +182,8 @@ struct psi_group psi_system = {
>  
>  static void psi_avgs_work(struct work_struct *work);
>  
> +static unsigned long psi_memtime_fixup(u32 growth);
> +
>  static void group_init(struct psi_group *group)
>  {
>  	int cpu;
> @@ -492,6 +494,21 @@ static u64 window_update(struct psi_window *win, u64 now, u64 value)
>  	return growth;
>  }
>  
> +static unsigned long psi_memtime_fixup(u32 growth)
> +{
> +	struct rq *rq = task_rq(current);
> +	unsigned long growth_fixed = (unsigned long)growth;
> +
> +	if (!(current->policy == SCHED_NORMAL || current->policy == SCHED_BATCH))
> +		return growth_fixed;
> +
> +	if (current->in_memstall)
> +		growth_fixed = div64_ul((1024 - rq->avg_rt.util_avg - rq->avg_dl.util_avg
> +					- rq->avg_irq.util_avg + 1) * growth, 1024);
> +
> +	return growth_fixed;
> +}
> +
>  static void init_triggers(struct psi_group *group, u64 now)
>  {
>  	struct psi_trigger *t;
> @@ -658,6 +675,7 @@ static void record_times(struct psi_group_cpu *groupc, u64 now)
>  	}
>  
>  	if (groupc->state_mask & (1 << PSI_MEM_SOME)) {
> +		delta = psi_memtime_fixup(delta);
>  		groupc->times[PSI_MEM_SOME] += delta;
>  		if (groupc->state_mask & (1 << PSI_MEM_FULL))
>  			groupc->times[PSI_MEM_FULL] += delta;
> @@ -928,8 +946,8 @@ void psi_memstall_leave(unsigned long *flags)
>  	 */
>  	rq = this_rq_lock_irq(&rf);
>  
> -	current->in_memstall = 0;
>  	psi_task_change(current, TSK_MEMSTALL, 0);
> +	current->in_memstall = 0;
>  
>  	rq_unlock_irq(rq, &rf);
>  }
> -- 
> 1.9.1
> 
