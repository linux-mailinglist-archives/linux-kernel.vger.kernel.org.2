Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9605428AB0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 12:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235787AbhJKKWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 06:22:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:33714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235714AbhJKKWo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 06:22:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 43AA660F21;
        Mon, 11 Oct 2021 10:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633947644;
        bh=xhpP6IpwKmMLfMf/iD0wu7dLSxahEymbWAGMYYio3f4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JzlH3ntRel9wS9czUacDksUifXTzL3SHBb9Kb6HXD5yUQhbFvT9ngo/w0gBcbQXur
         tfwBaqKWLb7EPtKAXM+YaG4CToWKchAJ3fShe4NE4ioBeLrCPkGGGLiLtFuFH+xTC4
         7b0MtsRbWVTOI1ip207H4xPYi+gexZ4xJf0BweH6IMJ8ghR5kpp/nc8nzjaKuT4LB7
         DLY2ZpWMvW+M6rsp348RyN/9b3tRI02U/sFH9YFXcLS2fs//wiiKcAjT32CeFSOv9h
         x+WVxl1RFWRtNTE2JjP8sI6uVkxVcVfiV2ivX5dyMXOpNRlbsxvL9MSzkAjgpRoz3l
         STtGVhb6d6Awg==
Date:   Mon, 11 Oct 2021 11:20:38 +0100
From:   Will Deacon <will@kernel.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, leo.yan@linaro.org,
        anshuman.khandual@arm.com, coresight@lists.linaro.org,
        maz@kernel.org, james.morse@arm.com, mark.rutland@arm.com,
        lcherian@marvell.com
Subject: Re: [PATCH v3 03/16] arm64: errata: Add workaround for TSB flush
 failures
Message-ID: <20211011102038.GD3681@willie-the-truck>
References: <20211008182906.1688009-1-suzuki.poulose@arm.com>
 <20211008182906.1688009-4-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211008182906.1688009-4-suzuki.poulose@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08, 2021 at 07:28:53PM +0100, Suzuki K Poulose wrote:
> Arm Neoverse-N2 (#2067961) and Cortex-A710 (#2054223) suffers
> from errata, where a TSB (trace synchronization barrier)
> fails to flush the trace data completely, when executed from
> a trace prohibited region. In Linux we always execute it
> after we have moved the PE to trace prohibited region. So,
> we can apply the workaround every time a TSB is executed.
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
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
> Changes since v2:
>  - Split the Kconfig/erratum list update to a later patch
>    I have retained the tags, as there were no changes to
>    the patches as such, except for split and move
> ---
>  arch/arm64/include/asm/barrier.h | 16 +++++++++++++++-
>  arch/arm64/kernel/cpu_errata.c   | 19 +++++++++++++++++++
>  arch/arm64/tools/cpucaps         |  1 +
>  3 files changed, 35 insertions(+), 1 deletion(-)
> 
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

:/

So I think maybe we should revisit my suggestion to put the Kconfig stuff
at the end and instead let's keep all the arm64 changes together so the
arm64 parts can be built in isolation. Make 'em depend on COMPILE_TEST or
something, then remove that at the end?

Will
