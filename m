Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2A344142D2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 09:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233271AbhIVHkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 03:40:22 -0400
Received: from foss.arm.com ([217.140.110.172]:44374 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233059AbhIVHkV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 03:40:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 225D6113E;
        Wed, 22 Sep 2021 00:38:52 -0700 (PDT)
Received: from [10.163.73.113] (unknown [10.163.73.113])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0C2793F40C;
        Wed, 22 Sep 2021 00:38:47 -0700 (PDT)
Subject: Re: [PATCH v2 11/17] arm64: errata: Add workaround for TSB flush
 failures
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, maz@kernel.org,
        catalin.marinas@arm.com, mark.rutland@arm.com, james.morse@arm.com,
        leo.yan@linaro.org, mike.leach@linaro.org,
        mathieu.poirier@linaro.org, will@kernel.org, lcherian@marvell.com,
        coresight@lists.linaro.org
References: <20210921134121.2423546-1-suzuki.poulose@arm.com>
 <20210921134121.2423546-12-suzuki.poulose@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <d4223300-e50a-b1f2-19e7-0ecf844a81c4@arm.com>
Date:   Wed, 22 Sep 2021 13:09:52 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210921134121.2423546-12-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/21/21 7:11 PM, Suzuki K Poulose wrote:
> Arm Neoverse-N2 (#2067961) and Cortex-A710 (#2054223) suffers
> from errata, where a TSB (trace synchronization barrier)
> fails to flush the trace data completely, when executed from
> a trace prohibited region. In Linux we always execute it
> after we have moved the PE to trace prohibited region. So,
> we can apply the workaround everytime a TSB is executed.

s/everytime/every time

> 
> The work around is to issue two TSB consecutively.
> 
> NOTE: This errata is defined as LOCAL_CPU_ERRATUM, implying
> that a late CPU could be blocked from booting if it is the
> first CPU that requires the workaround. This is because we
> do not allow setting a cpu_hwcaps after the SMP boot. The
> other alternative is to use "this_cpu_has_cap()" instead
> of the faster system wide check, which may be a bit of an
> overhead, given we may have to do this in nvhe KVM host
> before a guest entry.
> 
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
> Changes since v1:
>  - Switch to cpus_have_final_cap()
>  - Document the requirements on TSB.
> ---
>  Documentation/arm64/silicon-errata.rst |  4 ++++
>  arch/arm64/Kconfig                     | 31 ++++++++++++++++++++++++++
>  arch/arm64/include/asm/barrier.h       | 16 ++++++++++++-
>  arch/arm64/kernel/cpu_errata.c         | 19 ++++++++++++++++
>  arch/arm64/tools/cpucaps               |  1 +
>  5 files changed, 70 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/arm64/silicon-errata.rst b/Documentation/arm64/silicon-errata.rst
> index 2f99229d993c..569a92411dcd 100644
> --- a/Documentation/arm64/silicon-errata.rst
> +++ b/Documentation/arm64/silicon-errata.rst
> @@ -94,6 +94,8 @@ stable kernels.
>  +----------------+-----------------+-----------------+-----------------------------+
>  | ARM            | Cortex-A710     | #2119858        | ARM64_ERRATUM_2119858       |
>  +----------------+-----------------+-----------------+-----------------------------+
> +| ARM            | Cortex-A710     | #2054223        | ARM64_ERRATUM_2054223       |
> ++----------------+-----------------+-----------------+-----------------------------+
>  | ARM            | Neoverse-N1     | #1188873,1418040| ARM64_ERRATUM_1418040       |
>  +----------------+-----------------+-----------------+-----------------------------+
>  | ARM            | Neoverse-N1     | #1349291        | N/A                         |
> @@ -102,6 +104,8 @@ stable kernels.
>  +----------------+-----------------+-----------------+-----------------------------+
>  | ARM            | Neoverse-N2     | #2139208        | ARM64_ERRATUM_2139208       |
>  +----------------+-----------------+-----------------+-----------------------------+
> +| ARM            | Neoverse-N2     | #2067961        | ARM64_ERRATUM_2067961       |
> ++----------------+-----------------+-----------------+-----------------------------+
>  | ARM            | MMU-500         | #841119,826419  | N/A                         |
>  +----------------+-----------------+-----------------+-----------------------------+
>  +----------------+-----------------+-----------------+-----------------------------+
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index eac4030322df..0764774e12bb 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -705,6 +705,37 @@ config ARM64_ERRATUM_2139208
>  
>  	  If unsure, say Y.
>  
> +config ARM64_WORKAROUND_TSB_FLUSH_FAILURE
> +	bool
> +
> +config ARM64_ERRATUM_2054223
> +	bool "Cortex-A710: 2054223: workaround TSB instruction failing to flush trace"
> +	default y
> +	help
> +	  Enable workaround for ARM Cortex-A710 erratum 2054223
> +
> +	  Affected cores may fail to flush the trace data on a TSB instruction, when
> +	  the PE is in trace prohibited state. This will cause losing a few bytes
> +	  of the trace cached.
> +
> +	  Workaround is to issue two TSB consecutively on affected cores.
> +
> +	  If unsure, say Y.
> +
> +config ARM64_ERRATUM_2067961
> +	bool "Neoverse-N2: 2067961: workaround TSB instruction failing to flush trace"
> +	default y
> +	help
> +	  Enable workaround for ARM Neoverse-N2 erratum 2067961
> +
> +	  Affected cores may fail to flush the trace data on a TSB instruction, when
> +	  the PE is in trace prohibited state. This will cause losing a few bytes
> +	  of the trace cached.
> +
> +	  Workaround is to issue two TSB consecutively on affected cores.

Like I had mentioned in the previous patch, these descriptions here could
be just factored out inside ARM64_WORKAROUND_TSB_FLUSH_FAILURE instead.

> +
> +	  If unsure, say Y.
> +
>  config CAVIUM_ERRATUM_22375
>  	bool "Cavium erratum 22375, 24313"
>  	default y
> diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
> index 451e11e5fd23..1c5a00598458 100644
> --- a/arch/arm64/include/asm/barrier.h
> +++ b/arch/arm64/include/asm/barrier.h
> @@ -23,7 +23,7 @@
>  #define dsb(opt)	asm volatile("dsb " #opt : : : "memory")
>  
>  #define psb_csync()	asm volatile("hint #17" : : : "memory")
> -#define tsb_csync()	asm volatile("hint #18" : : : "memory")
> +#define __tsb_csync()	asm volatile("hint #18" : : : "memory")
>  #define csdb()		asm volatile("hint #20" : : : "memory")
>  
>  #ifdef CONFIG_ARM64_PSEUDO_NMI
> @@ -46,6 +46,20 @@
>  #define dma_rmb()	dmb(oshld)
>  #define dma_wmb()	dmb(oshst)
>  
> +
> +#define tsb_csync()								\
> +	do {									\
> +		/*								\
> +		 * CPUs affected by Arm Erratum 2054223 or 2067961 needs	\
> +		 * another TSB to ensure the trace is flushed. The barriers	\
> +		 * don't have to be strictly back to back, as long as the	\
> +		 * CPU is in trace prohibited state.				\
> +		 */								\
> +		if (cpus_have_final_cap(ARM64_WORKAROUND_TSB_FLUSH_FAILURE))	\
> +			__tsb_csync();						\
> +		__tsb_csync();							\
> +	} while (0)
> +
>  /*
>   * Generate a mask for array_index__nospec() that is ~0UL when 0 <= idx < sz
>   * and 0 otherwise.
> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> index ccd757373f36..bdbeac75ead6 100644
> --- a/arch/arm64/kernel/cpu_errata.c
> +++ b/arch/arm64/kernel/cpu_errata.c
> @@ -352,6 +352,18 @@ static const struct midr_range trbe_overwrite_fill_mode_cpus[] = {
>  };
>  #endif	/* CONFIG_ARM64_WORKAROUND_TRBE_OVERWRITE_FILL_MODE */
>  
> +#ifdef CONFIG_ARM64_WORKAROUND_TSB_FLUSH_FAILURE
> +static const struct midr_range tsb_flush_fail_cpus[] = {
> +#ifdef CONFIG_ARM64_ERRATUM_2067961
> +	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N2),
> +#endif
> +#ifdef CONFIG_ARM64_ERRATUM_2054223
> +	MIDR_ALL_VERSIONS(MIDR_CORTEX_A710),
> +#endif
> +	{},
> +};
> +#endif	/* CONFIG_ARM64_WORKAROUND_TSB_FLUSH_FAILURE */
> +
>  const struct arm64_cpu_capabilities arm64_errata[] = {
>  #ifdef CONFIG_ARM64_WORKAROUND_CLEAN_CACHE
>  	{
> @@ -558,6 +570,13 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
>  		.type = ARM64_CPUCAP_WEAK_LOCAL_CPU_FEATURE,
>  		CAP_MIDR_RANGE_LIST(trbe_overwrite_fill_mode_cpus),
>  	},
> +#endif
> +#ifdef CONFIG_ARM64_WORKAROUND_TSB_FLUSH_FAILRE
> +	{
> +		.desc = "ARM erratum 2067961 or 2054223",
> +		.capability = ARM64_WORKAROUND_TSB_FLUSH_FAILURE,
> +		ERRATA_MIDR_RANGE_LIST(tsb_flush_fail_cpus),
> +	},
>  #endif
>  	{
>  	}
> diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
> index 1ccb92165bd8..2102e15af43d 100644
> --- a/arch/arm64/tools/cpucaps
> +++ b/arch/arm64/tools/cpucaps
> @@ -54,6 +54,7 @@ WORKAROUND_1463225
>  WORKAROUND_1508412
>  WORKAROUND_1542419
>  WORKAROUND_TRBE_OVERWRITE_FILL_MODE
> +WORKAROUND_TSB_FLUSH_FAILURE
>  WORKAROUND_CAVIUM_23154
>  WORKAROUND_CAVIUM_27456
>  WORKAROUND_CAVIUM_30115
> 

This adds all the required bits of these erratas in a single patch,
where as the previous work around had split all the required pieces
into multiple patches. Could we instead follow the same standard in
both the places ?
