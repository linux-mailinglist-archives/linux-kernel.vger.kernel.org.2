Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4314D414728
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 12:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235213AbhIVK7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 06:59:37 -0400
Received: from foss.arm.com ([217.140.110.172]:47078 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234760AbhIVK7g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 06:59:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0DFF111B3;
        Wed, 22 Sep 2021 03:58:06 -0700 (PDT)
Received: from [10.163.73.113] (unknown [10.163.73.113])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 80BEA3F719;
        Wed, 22 Sep 2021 03:58:02 -0700 (PDT)
Subject: Re: [PATCH v2 15/17] arm64: Add erratum detection for TRBE write to
 out-of-range
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, maz@kernel.org,
        catalin.marinas@arm.com, mark.rutland@arm.com, james.morse@arm.com,
        leo.yan@linaro.org, mike.leach@linaro.org,
        mathieu.poirier@linaro.org, will@kernel.org, lcherian@marvell.com,
        coresight@lists.linaro.org
References: <20210921134121.2423546-1-suzuki.poulose@arm.com>
 <20210921134121.2423546-16-suzuki.poulose@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <1d76b1bf-d14f-ed99-f558-706a97a32254@arm.com>
Date:   Wed, 22 Sep 2021 16:29:09 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210921134121.2423546-16-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/21/21 7:11 PM, Suzuki K Poulose wrote:
> Arm Neoverse-N2 and Cortex-A710 cores are affected by an erratum where the
> trbe, under some circumstances, might write upto 64bytes to an address after
> the Limit as programmed by the TRBLIMITR_EL1.LIMIT. This might -
> 
>   - Corrupt a page in the ring buffer, which may corrupt trace from a
>     previous session, consumed by userspace.
>   - Hit the guard page at the end of the vmalloc area and raise a fault.
> 
> To keep the handling simpler, we always leave the last page from the
> range, which TRBE is allowed to write. This can be achieved by ensuring
> that we always have more than a PAGE worth space in the range, while
> calculating the LIMIT for TRBE. And then the LIMIT pointer can be adjusted
> to leave the PAGE (TRBLIMITR.LIMIT -= PAGE_SIZE), out of the TRBE range
> while enabling it. This makes sure that the TRBE will only write to an area
> within its allowed limit (i.e, [head-head+size]) and we do not have to handle
> address faults within the driver.
> 
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Leo Yan <leo.yan@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

> ---
>  arch/arm64/kernel/cpu_errata.c | 20 ++++++++++++++++++++
>  arch/arm64/tools/cpucaps       |  1 +
>  2 files changed, 21 insertions(+)
> 
> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> index bdbeac75ead6..e2978b89d4b8 100644
> --- a/arch/arm64/kernel/cpu_errata.c
> +++ b/arch/arm64/kernel/cpu_errata.c
> @@ -364,6 +364,18 @@ static const struct midr_range tsb_flush_fail_cpus[] = {
>  };
>  #endif	/* CONFIG_ARM64_WORKAROUND_TSB_FLUSH_FAILURE */
>  
> +#ifdef CONFIG_ARM64_WORKAROUND_TRBE_WRITE_OUT_OF_RANGE
> +static struct midr_range trbe_write_out_of_range_cpus[] = {
> +#ifdef CONFIG_ARM64_ERRATUM_2253138
> +	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N2),
> +#endif
> +#ifdef CONFIG_ARM64_ERRATUM_2224489
> +	MIDR_ALL_VERSIONS(MIDR_CORTEX_A710),
> +#endif
> +	{},
> +};
> +#endif /* CONFIG_ARM64_WORKAROUND_TRBE_WRITE_OUT_OF_RANGE */
> +
>  const struct arm64_cpu_capabilities arm64_errata[] = {
>  #ifdef CONFIG_ARM64_WORKAROUND_CLEAN_CACHE
>  	{
> @@ -577,6 +589,14 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
>  		.capability = ARM64_WORKAROUND_TSB_FLUSH_FAILURE,
>  		ERRATA_MIDR_RANGE_LIST(tsb_flush_fail_cpus),
>  	},
> +#endif
> +#ifdef CONFIG_ARM64_WORKAROUND_TRBE_WRITE_OUT_OF_RANGE
> +	{
> +		.desc = "ARM erratum 2253138 or 2224489",
> +		.capability = ARM64_WORKAROUND_TRBE_WRITE_OUT_OF_RANGE,
> +		.type = ARM64_CPUCAP_WEAK_LOCAL_CPU_FEATURE,
> +		CAP_MIDR_RANGE_LIST(trbe_write_out_of_range_cpus),
> +	},
>  #endif
>  	{
>  	}
> diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
> index 2102e15af43d..90628638e0f9 100644
> --- a/arch/arm64/tools/cpucaps
> +++ b/arch/arm64/tools/cpucaps
> @@ -55,6 +55,7 @@ WORKAROUND_1508412
>  WORKAROUND_1542419
>  WORKAROUND_TRBE_OVERWRITE_FILL_MODE
>  WORKAROUND_TSB_FLUSH_FAILURE
> +WORKAROUND_TRBE_WRITE_OUT_OF_RANGE
>  WORKAROUND_CAVIUM_23154
>  WORKAROUND_CAVIUM_27456
>  WORKAROUND_CAVIUM_30115
> 
