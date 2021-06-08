Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16A1639FA43
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 17:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbhFHPXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 11:23:36 -0400
Received: from foss.arm.com ([217.140.110.172]:33388 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231338AbhFHPXe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 11:23:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0BC266D;
        Tue,  8 Jun 2021 08:21:41 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.5.29])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C2983F73D;
        Tue,  8 Jun 2021 08:21:40 -0700 (PDT)
Date:   Tue, 8 Jun 2021 16:21:37 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] arm64: perf: Report error if PMU fails to support
 current CPU
Message-ID: <20210608152137.GC16585@C02TD0UTHF1T.local>
References: <20210608145228.36595-1-leo.yan@linaro.org>
 <20210608145228.36595-2-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608145228.36595-2-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo,

On Tue, Jun 08, 2021 at 10:52:28PM +0800, Leo Yan wrote:
> When run perf command on the Arm big.LITTLE system (Juno-r2 board):
> 
>   perf record -e cycles --per-thread program
> 
> The command executes normally without any errors; but when report the
> result with "perf report", it fails to parse the symbols.  This is
> because the perf data file doesn't contain MMAP2 events, thus it cannot
> find the correct object file for parsing symbols.
> 
> On the big.LITTLE system, if the initialized PMU doesn't match with the
> CPU the profiled task is scheduled on; for example, the initialized PMU
> is on CPU0 in the LITTLE cluster, when invoke the function
> perf_event_mmap_event() on CPU2 in the big cluster, the event is always
> filtered out due to the CPU2 is not supported by the initialized PMU.
> Finally, there have no any MMAP2 samples are generated for the
> profiling.
> 
> This patch doesn't fix for this issue, alternatively, it simply reports
> an error when detect the current CPU is not supported by PMU, so can
> remind the user for the abnormal situation.

This behaviour is by design, and is not a kernel error, so it isn't
appropriate to use pr_err() here. NAK to adding the pr_err().

I agree that the behaviour for PERF_TYPE_HARDWARE is confusing and not
all that great, but as it's ABI it's not something that we can change.

What really needs to happen here is for userspace to gain some awareness
of big.LITTLE. For example, for the command:

$ perf record -e cycles --per-thread program

... what we should do is have userspace identify the set of CPU PMUs
(based on the `cpus` attribute in sysfs), and open a per-thread event on
each of those, which we can then summarize together.

Either that, or print a warning that the system is big.LITTLE and an
event will not count on all CPUs.

Thanks,
Mark.

 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  drivers/perf/arm_pmu.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
> index aedea060ca8b..99ddc8bf6466 100644
> --- a/drivers/perf/arm_pmu.c
> +++ b/drivers/perf/arm_pmu.c
> @@ -565,6 +565,9 @@ static int armpmu_filter_match(struct perf_event *event)
>  	int ret;
>  
>  	ret = cpumask_test_cpu(cpu, &armpmu->supported_cpus);
> +	if (!ret)
> +		pr_err("PMU doesn't support current CPU %d\n", cpu);
> +
>  	if (ret && armpmu->filter_match)
>  		return armpmu->filter_match(event);
>  
> -- 
> 2.25.1
> 
