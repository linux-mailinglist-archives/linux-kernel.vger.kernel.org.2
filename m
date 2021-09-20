Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA736411886
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 17:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238173AbhITPn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 11:43:28 -0400
Received: from foss.arm.com ([217.140.110.172]:49370 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230426AbhITPn1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 11:43:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 216F912FC;
        Mon, 20 Sep 2021 08:42:00 -0700 (PDT)
Received: from [10.57.95.67] (unknown [10.57.95.67])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE7D43F59C;
        Mon, 20 Sep 2021 08:41:57 -0700 (PDT)
Subject: Re: [PATCH 3/5] arm64: mte: CPU feature detection for Asymm MTE
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <20210913081424.48613-1-vincenzo.frascino@arm.com>
 <20210913081424.48613-4-vincenzo.frascino@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <6e6fb454-886e-95ff-fad2-d003a594acbd@arm.com>
Date:   Mon, 20 Sep 2021 16:41:56 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210913081424.48613-4-vincenzo.frascino@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/09/2021 09:14, Vincenzo Frascino wrote:
> Add the cpufeature entries to detect the presence of Asymmetric MTE.
> 
> Note: The tag checking mode is initialized via cpu_enable_mte() ->
> kasan_init_hw_tags() hence to enable it we require asymmetric mode
> to be at least on the boot CPU. If the boot CPU does not have it, it is
> fine for late CPUs to have it as long as the feature is not enabled
> (ARM64_CPUCAP_BOOT_CPU_FEATURE).
> 
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Suzuki K Poulose <Suzuki.Poulose@arm.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>


> ---
>   arch/arm64/kernel/cpufeature.c | 10 ++++++++++
>   arch/arm64/tools/cpucaps       |  1 +
>   2 files changed, 11 insertions(+)
> 
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index f8a3067d10c6..a18774071a45 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -2317,6 +2317,16 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
>   		.sign = FTR_UNSIGNED,
>   		.cpu_enable = cpu_enable_mte,
>   	},
> +	{
> +		.desc = "Asymmetric Memory Tagging Extension",
> +		.capability = ARM64_MTE_ASYMM,
> +		.type = ARM64_CPUCAP_BOOT_CPU_FEATURE,

FWIW, the selected type works for the described use case.

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

> +		.matches = has_cpuid_feature,
> +		.sys_reg = SYS_ID_AA64PFR1_EL1,
> +		.field_pos = ID_AA64PFR1_MTE_SHIFT,
> +		.min_field_value = ID_AA64PFR1_MTE_ASYMM,
> +		.sign = FTR_UNSIGNED,
> +	},
>   #endif /* CONFIG_ARM64_MTE */
>   	{
>   		.desc = "RCpc load-acquire (LDAPR)",
> diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
> index 49305c2e6dfd..74a569bf52d6 100644
> --- a/arch/arm64/tools/cpucaps
> +++ b/arch/arm64/tools/cpucaps
> @@ -39,6 +39,7 @@ HW_DBM
>   KVM_PROTECTED_MODE
>   MISMATCHED_CACHE_TYPE
>   MTE
> +MTE_ASYMM
>   SPECTRE_V2
>   SPECTRE_V3A
>   SPECTRE_V4
> 

