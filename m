Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8415F4334CB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 13:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235349AbhJSLjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 07:39:05 -0400
Received: from foss.arm.com ([217.140.110.172]:48032 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230097AbhJSLjE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 07:39:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4E873D6E;
        Tue, 19 Oct 2021 04:36:51 -0700 (PDT)
Received: from [10.57.25.70] (unknown [10.57.25.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A3AE03F70D;
        Tue, 19 Oct 2021 04:36:49 -0700 (PDT)
Subject: Re: [PATCH v5 03/15] arm64: errata: Add workaround for TSB flush
 failures
To:     Will Deacon <will@kernel.org>
Cc:     mathieu.poirier@linaro.org, catalin.marinas@arm.com,
        anshuman.khandual@arm.com, mike.leach@linaro.org,
        leo.yan@linaro.org, maz@kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>
References: <20211014223125.2605031-1-suzuki.poulose@arm.com>
 <20211014223125.2605031-4-suzuki.poulose@arm.com>
 <20211019110233.GD13251@willie-the-truck>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <850c67de-a656-7515-e575-d47d2af78200@arm.com>
Date:   Tue, 19 Oct 2021 12:36:48 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211019110233.GD13251@willie-the-truck>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/10/2021 12:02, Will Deacon wrote:
> On Thu, Oct 14, 2021 at 11:31:13PM +0100, Suzuki K Poulose wrote:
>> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
>> index ccd757373f36..bdbeac75ead6 100644
>> --- a/arch/arm64/kernel/cpu_errata.c
>> +++ b/arch/arm64/kernel/cpu_errata.c
>> @@ -352,6 +352,18 @@ static const struct midr_range trbe_overwrite_fill_mode_cpus[] = {
>>   };
>>   #endif	/* CONFIG_ARM64_WORKAROUND_TRBE_OVERWRITE_FILL_MODE */
>>   
>> +#ifdef CONFIG_ARM64_WORKAROUND_TSB_FLUSH_FAILURE
>> +static const struct midr_range tsb_flush_fail_cpus[] = {
>> +#ifdef CONFIG_ARM64_ERRATUM_2067961
>> +	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N2),
>> +#endif
>> +#ifdef CONFIG_ARM64_ERRATUM_2054223
>> +	MIDR_ALL_VERSIONS(MIDR_CORTEX_A710),
>> +#endif
>> +	{},
>> +};
>> +#endif	/* CONFIG_ARM64_WORKAROUND_TSB_FLUSH_FAILURE */
>> +
>>   const struct arm64_cpu_capabilities arm64_errata[] = {
>>   #ifdef CONFIG_ARM64_WORKAROUND_CLEAN_CACHE
>>   	{
>> @@ -558,6 +570,13 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
>>   		.type = ARM64_CPUCAP_WEAK_LOCAL_CPU_FEATURE,
>>   		CAP_MIDR_RANGE_LIST(trbe_overwrite_fill_mode_cpus),
>>   	},
>> +#endif
>> +#ifdef CONFIG_ARM64_WORKAROUND_TSB_FLUSH_FAILRE
> 
> You still haven't fixed this typo...
> 

Sorry about that. I thought it was about selecting the
Kconfig entries, which was fixed. I will fix this.

> Seriously, I get compile warnings from this -- are you not seeing them?

No, I don't get any warnings. Is there something that I am missing ?

--8>--

suzuki@ewhatever:coresight$ grep "WERROR\|TSB" .config
CONFIG_WERROR=y
CONFIG_ARM64_WORKAROUND_TSB_FLUSH_FAILURE=y
suzuki@ewhatever:coresight$ grep TSB arch/arm64/kernel/cpu_errata.c
#ifdef CONFIG_ARM64_WORKAROUND_TSB_FLUSH_FAILURE
#endif  /* CONFIG_ARM64_WORKAROUND_TSB_FLUSH_FAILURE */
#ifdef CONFIG_ARM64_WORKAROUND_TSB_FLUSH_FAILRE
                 .capability = ARM64_WORKAROUND_TSB_FLUSH_FAILURE,


suzuki@ewhatever:coresight$ touch arch/arm64/kernel/cpu_errata.c
suzuki@ewhatever:coresight$ make -j16
   CALL    scripts/atomic/check-atomics.sh
   CALL    scripts/checksyscalls.sh
   CHK     include/generated/compile.h
   CC      arch/arm64/kernel/cpu_errata.o
   AR      arch/arm64/kernel/built-in.a
   AR      arch/arm64/built-in.a
   GEN     .version
   CHK     include/generated/compile.h
   UPD     include/generated/compile.h
   CC      init/version.o
   AR      init/built-in.a
   LD      vmlinux.o
   MODPOST vmlinux.symvers
   MODINFO modules.builtin.modinfo
   GEN     modules.builtin
   LD      .tmp_vmlinux.kallsyms1
   KSYMS   .tmp_vmlinux.kallsyms1.S
   AS      .tmp_vmlinux.kallsyms1.S
   LD      .tmp_vmlinux.kallsyms2
   KSYMS   .tmp_vmlinux.kallsyms2.S
   AS      .tmp_vmlinux.kallsyms2.S
   LD      vmlinux
   SORTTAB vmlinux
   SYSMAP  System.map
   MODPOST modules-only.symvers
   OBJCOPY arch/arm64/boot/Image
   GEN     Module.symvers
   GZIP    arch/arm64/boot/Image.gz

Suzuki
> 
> Will
> 

