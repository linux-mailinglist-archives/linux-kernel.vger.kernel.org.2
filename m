Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E43AD36C75F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 15:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236435AbhD0N4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 09:56:02 -0400
Received: from foss.arm.com ([217.140.110.172]:53136 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236470AbhD0Nzz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 09:55:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D12AD6E;
        Tue, 27 Apr 2021 06:55:12 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.31.135])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 92B363F70D;
        Tue, 27 Apr 2021 06:55:09 -0700 (PDT)
Date:   Tue, 27 Apr 2021 14:55:06 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH] arm64: perf: Ensure EL0 access is disabled at reset
Message-ID: <20210427135506.GC37475@C02TD0UTHF1T.local>
References: <20210427134852.1411642-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210427134852.1411642-1-robh@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 08:48:52AM -0500, Rob Herring wrote:
> The ER, SW, and EN bits in the PMUSERENR_EL0 register are UNKNOWN at
> reset and the register is never initialized, so EL0 access could be
> enabled by default on some implementations. Let's initialize
> PMUSERENR_EL0 to a known state with EL0 access disabled.

We reset PMUSERENR_EL0 via the reset_pmuserenr_el0 macro, called from
__cpu_setup when a CPU is onlined and from cpu_do_resume() when a CPU
returns from a context-destructive idle state. We do it there so that
it's handled even if a kernel isn't built with perf support.

AFAICT, that *should* do the right thing -- are you seeing UNKNOWN
values, or was this found by inspection?

Thanks,
Mark.

> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  arch/arm64/kernel/perf_event.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
> index 4658fcf88c2b..c32778ae5117 100644
> --- a/arch/arm64/kernel/perf_event.c
> +++ b/arch/arm64/kernel/perf_event.c
> @@ -450,6 +450,11 @@ static inline void armv8pmu_pmcr_write(u32 val)
>  	write_sysreg(val, pmcr_el0);
>  }
>  
> +static void armv8pmu_clear_pmuserenr(void)
> +{
> +	write_sysreg(0, pmuserenr_el0);
> +}
> +
>  static inline int armv8pmu_has_overflowed(u32 pmovsr)
>  {
>  	return pmovsr & ARMV8_PMU_OVERFLOWED_MASK;
> @@ -933,6 +938,9 @@ static void armv8pmu_reset(void *info)
>  	armv8pmu_disable_counter(U32_MAX);
>  	armv8pmu_disable_intens(U32_MAX);
>  
> +	/* User access is unknown at reset. */
> +	armv8pmu_clear_pmuserenr();
> +
>  	/* Clear the counters we flip at guest entry/exit */
>  	kvm_clr_pmu_events(U32_MAX);
>  
> -- 
> 2.27.0
> 
