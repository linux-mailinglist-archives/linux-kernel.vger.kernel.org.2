Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2B633DA163
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 12:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236778AbhG2Klx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 06:41:53 -0400
Received: from foss.arm.com ([217.140.110.172]:44534 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237148AbhG2KlY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 06:41:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CDF346D;
        Thu, 29 Jul 2021 03:41:20 -0700 (PDT)
Received: from [10.57.86.111] (unknown [10.57.86.111])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA1703F73D;
        Thu, 29 Jul 2021 03:41:18 -0700 (PDT)
Subject: Re: [PATCH 10/10] arm64: errata: Add workaround for TSB flush
 failures
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, anshuman.khandual@arm.com,
        will@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        leo.yan@linaro.org, mark.rutland@arm.com
References: <20210728135217.591173-1-suzuki.poulose@arm.com>
 <20210728135217.591173-11-suzuki.poulose@arm.com>
 <87mtq5a1gs.wl-maz@kernel.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <c41330d9-c2a2-afbe-624f-77c1e94f0490@arm.com>
Date:   Thu, 29 Jul 2021 11:41:17 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <87mtq5a1gs.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/07/2021 10:55, Marc Zyngier wrote:
> On Wed, 28 Jul 2021 14:52:17 +0100,
> Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>>
>> Arm Neoverse-N2 (#2067961) and Cortex-A710 (#2054223) suffers
>> from errata, where a TSB (trace synchronization barrier)
>> fails to flush the trace data completely, when executed from
>> a trace prohibited region. In Linux we always execute it
>> after we have moved the PE to trace prohibited region. So,
>> we can apply the workaround everytime a TSB is executed.
>>
>> The work around is to issue two TSB consecutively.
>>
>> NOTE: This errata is defined as LOCAL_CPU_ERRATUM, implying
>> that a late CPU could be blocked from booting if it is the
>> first CPU that requires the workaround. This is because we
>> do not allow setting a cpu_hwcaps after the SMP boot. The
>> other alternative is to use "this_cpu_has_cap()" instead
>> of the faster system wide check, which may be a bit of an
>> overhead, given we may have to do this in nvhe KVM host
>> before a guest entry.
>>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Cc: Mike Leach <mike.leach@linaro.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
>> Cc: Marc Zyngier <maz@kernel.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>   Documentation/arm64/silicon-errata.rst |  4 ++++
>>   arch/arm64/Kconfig                     | 31 ++++++++++++++++++++++++++
>>   arch/arm64/include/asm/barrier.h       | 17 +++++++++++++-
>>   arch/arm64/kernel/cpu_errata.c         | 19 ++++++++++++++++
>>   arch/arm64/tools/cpucaps               |  1 +
>>   5 files changed, 71 insertions(+), 1 deletion(-)
> 
> [...]
> 
>> diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
>> index 451e11e5fd23..3bc1ed436e04 100644
>> --- a/arch/arm64/include/asm/barrier.h
>> +++ b/arch/arm64/include/asm/barrier.h
>> @@ -23,7 +23,7 @@
>>   #define dsb(opt)	asm volatile("dsb " #opt : : : "memory")
>>   
>>   #define psb_csync()	asm volatile("hint #17" : : : "memory")
>> -#define tsb_csync()	asm volatile("hint #18" : : : "memory")
>> +#define __tsb_csync()	asm volatile("hint #18" : : : "memory")
>>   #define csdb()		asm volatile("hint #20" : : : "memory")
>>   
>>   #ifdef CONFIG_ARM64_PSEUDO_NMI
>> @@ -46,6 +46,21 @@
>>   #define dma_rmb()	dmb(oshld)
>>   #define dma_wmb()	dmb(oshst)
>>   
>> +
>> +#define tsb_csync()								\
>> +	do {									\
>> +		/*								\
>> +		 * CPUs affected by Arm Erratum 2054223 or 2067961 needs	\
>> +		 * another TSB to ensure the trace is flushed.			\
>> +		 */								\
>> +		if (cpus_have_const_cap(ARM64_WORKAROUND_TSB_FLUSH_FAILURE)) {	\
> 
> Could this be made a final cap instead? Or do you expect this to be
> usable before caps have been finalised?

Good point. This can be final cap.

> 
>> +			__tsb_csync();						\
>> +			__tsb_csync();						\
>> +		} else {							\
>> +			__tsb_csync();						\
>> +		}								\
> 
> nit: You could keep one unconditional __tsb_csync().

I thought about that, I was worried if the CPU expects them back to back
without any other instructions in between them. Thinking about it a bit
more, it doesn't look like that is the case. I will confirm this and
change it accordingly.

Thanks
Suzuki

> 
> Thanks,
> 
> 	M.
> 

