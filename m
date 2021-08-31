Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 757FC3FC662
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 13:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241389AbhHaLJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 07:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241371AbhHaLJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 07:09:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF03FC061575;
        Tue, 31 Aug 2021 04:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XyUQxjZHSZSuzp+qRC4DocYyFuEXPwjxTQ+qBgZtJgo=; b=jFem8aE5ANpFoWULnO9Myo5SNO
        SrY3DwoZyTcYitjq+PdhfCGHfGIl8dvtiVATNuyFqZrq6sqa7vbw9jBhvuwuemhzLQD3w2iVGVlez
        O4imjAIRL90uykvHGrpLPdTn0bb4epPI0X+b25dN2kwrj6Db6jQjzIm/pu5c8G4eGWKvy/6PlyPRq
        N9WIT2QrhEyVkVGBVTT1XGdqZb4SUUIBVmjkAvQtMnJxKDxsiX9ZnmfcRiJ5KgXLolkCq9mcPpRYN
        2JqWiVgMZWx4EH9iIArKNRR88QwvE3adZk0fpxTmGElE8yh1TQCnY/qy0Cjqfg5zyBMpmxeCuaqlb
        3R5eS+MQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mL1c0-0017uw-Ov; Tue, 31 Aug 2021 11:07:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A98CA300103;
        Tue, 31 Aug 2021 13:07:27 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6EF802C83EADD; Tue, 31 Aug 2021 13:07:27 +0200 (CEST)
Date:   Tue, 31 Aug 2021 13:07:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     mingo@redhat.com, mgorman@suse.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        achaiken@aurora.tech, lkp@intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v3 3/7] sched: make schedstats helpers independent of
 fair sched class
Message-ID: <YS4Nbzz6Kosfhx5M@hirez.programming.kicks-ass.net>
References: <20210824112946.9324-1-laoar.shao@gmail.com>
 <20210824112946.9324-4-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210824112946.9324-4-laoar.shao@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 11:29:42AM +0000, Yafang Shao wrote:
> diff --git a/kernel/sched/stats.c b/kernel/sched/stats.c
> index 3f93fc3b5648..b2542f4d3192 100644
> --- a/kernel/sched/stats.c
> +++ b/kernel/sched/stats.c
> @@ -4,6 +4,109 @@
>   */
>  #include "sched.h"
>  
> +void __update_stats_wait_start(struct rq *rq, struct task_struct *p,
> +			       struct sched_statistics *stats)
> +{
> +u64 wait_start, prev_wait_start;

indent fail...

> +
> +	wait_start = rq_clock(rq);
> +	prev_wait_start = schedstat_val(stats->wait_start);
> +
> +	if (p && likely(wait_start > prev_wait_start))
> +		wait_start -= prev_wait_start;
> +
> +	__schedstat_set(stats->wait_start, wait_start);
> +}

> diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
> index e6905e369c5d..9ecd81b91f26 100644
> --- a/kernel/sched/stats.h
> +++ b/kernel/sched/stats.h

> @@ -40,6 +42,33 @@ rq_sched_info_dequeue(struct rq *rq, unsigned long long delta)
>  #define   schedstat_val(var)		(var)
>  #define   schedstat_val_or_zero(var)	((schedstat_enabled()) ? (var) : 0)
>  
> +void __update_stats_wait_start(struct rq *rq, struct task_struct *p,
> +			       struct sched_statistics *stats);
> +
> +void __update_stats_wait_end(struct rq *rq, struct task_struct *p,
> +			     struct sched_statistics *stats);
> +void __update_stats_enqueue_sleeper(struct rq *rq, struct task_struct *p,
> +				    struct sched_statistics *stats);
> +
> +static inline void
> +check_schedstat_required(void)
> +{
> +	if (schedstat_enabled())
> +		return;
> +
> +	/* Force schedstat enabled if a dependent tracepoint is active */
> +	if (trace_sched_stat_wait_enabled()    ||
> +		trace_sched_stat_sleep_enabled()   ||
> +		trace_sched_stat_iowait_enabled()  ||
> +		trace_sched_stat_blocked_enabled() ||
> +		trace_sched_stat_runtime_enabled())  {
> +		printk_deferred_once("Scheduler tracepoints stat_sleep, stat_iowait, "
> +					"stat_blocked and stat_runtime require the "
> +					"kernel parameter schedstats=enable or "
> +					"kernel.sched_schedstats=1\n");
> +	}
> +}

If you're moving this, you might as well reflow it to not have broken
indentation.
