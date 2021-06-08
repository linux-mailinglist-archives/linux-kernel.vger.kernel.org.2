Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7A839FAD0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 17:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232790AbhFHPgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 11:36:22 -0400
Received: from foss.arm.com ([217.140.110.172]:33758 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231842AbhFHPgV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 11:36:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 328426D;
        Tue,  8 Jun 2021 08:34:28 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.5.29])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5BCC13F73D;
        Tue,  8 Jun 2021 08:34:27 -0700 (PDT)
Date:   Tue, 8 Jun 2021 16:34:24 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] arm64: perf: Correct per-thread mode if the event
 is not supported
Message-ID: <20210608153424.GD16585@C02TD0UTHF1T.local>
References: <20210608145228.36595-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608145228.36595-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2021 at 10:52:27PM +0800, Leo Yan wrote:
> When the perf tool runs in per-thread mode, armpmu_event_init() defers
> to handle events in armpmu_add(), the main reason is the selected PMU in
> the init phase can mismatch with the CPUs when the profiled task
> is scheduled on.
> 
> For example, on an Arm big.LTTILE platform with two clusters, every
> cluster has its dedicated PMU; the event initialization happens on the
> LITTLE cluster and its corresponding PMU is selected, but the profiled
> task is scheduled on big cluster, it's deferred to handle this case in
> armpmu_add().
> 
> Usually, we should report failure in the first place so this can allow
> users to easily locate the issue they are facing.  For the per-thread
> mode, the profiled task can be migrated on any CPU, therefore the event
> can be enabled on any CPU.  In other words, if a PMU detects it fails to
> support the process-following event, it can directly returns -EOPNOTSUPP
> so can stop profiling.
> 
> This patch adds the checking for per-thread mode, if the event is not
> supported, return -EOPNOTSUPP.

I don't understand the rationale for this patch. We call
armpmu_event_init() from perf_try_init_event(), and if we return *any*
error code that will be returned to userspace, or at least that used to
be the case.

What problem are you trying to solve here?

Is this some fallout of commit:

  55bcf6ef314ae8ba ("perf: Extend PERF_TYPE_HARDWARE and PERF_TYPE_HW_CACHE")

... ?

Thanks,
Mark.

> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  drivers/perf/arm_pmu.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
> index d4f7f1f9cc77..aedea060ca8b 100644
> --- a/drivers/perf/arm_pmu.c
> +++ b/drivers/perf/arm_pmu.c
> @@ -502,9 +502,9 @@ static int armpmu_event_init(struct perf_event *event)
>  	/*
>  	 * Reject CPU-affine events for CPUs that are of a different class to
>  	 * that which this PMU handles. Process-following events (where
> -	 * event->cpu == -1) can be migrated between CPUs, and thus we have to
> -	 * reject them later (in armpmu_add) if they're scheduled on a
> -	 * different class of CPU.
> +	 * event->cpu == -1) can be migrated between CPUs, and thus we will
> +	 * reject them when map_event() detects absent entry at below or later
> +	 * (in armpmu_add) if they're scheduled on a different class of CPU.
>  	 */
>  	if (event->cpu != -1 &&
>  		!cpumask_test_cpu(event->cpu, &armpmu->supported_cpus))
> @@ -514,8 +514,16 @@ static int armpmu_event_init(struct perf_event *event)
>  	if (has_branch_stack(event))
>  		return -EOPNOTSUPP;
>  
> -	if (armpmu->map_event(event) == -ENOENT)
> +	if (armpmu->map_event(event) == -ENOENT) {
> +		/*
> +		 * Process-following event is not supported on current PMU,
> +		 * returns -EOPNOTSUPP to stop perf at the initialization
> +		 * phase.
> +		 */
> +		if (event->cpu == -1)
> +			return -EOPNOTSUPP;
>  		return -ENOENT;
> +	}
>  
>  	return __hw_perf_event_init(event);
>  }
> -- 
> 2.25.1
> 
