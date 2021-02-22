Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D50FC3214D5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 12:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbhBVLLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 06:11:20 -0500
Received: from foss.arm.com ([217.140.110.172]:41454 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230171AbhBVLLQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 06:11:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1CF701FB;
        Mon, 22 Feb 2021 03:10:30 -0800 (PST)
Received: from [10.37.8.9] (unknown [10.37.8.9])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ADCBB3F73B;
        Mon, 22 Feb 2021 03:10:26 -0800 (PST)
Subject: Re: [PATCH v13 1/7] arm64: mte: Add asynchronous mode support
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <20210211153353.29094-1-vincenzo.frascino@arm.com>
 <20210211153353.29094-2-vincenzo.frascino@arm.com>
 <CAAeHK+xM1VHvSF_9ELf=_nDwJsUV2S1=LQy-rU-O0oyrNexzXw@mail.gmail.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <d20e596b-f9b0-8f55-43a8-aacc3c0cb88f@arm.com>
Date:   Mon, 22 Feb 2021 11:14:38 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAAeHK+xM1VHvSF_9ELf=_nDwJsUV2S1=LQy-rU-O0oyrNexzXw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/12/21 9:21 PM, Andrey Konovalov wrote:
> On Thu, Feb 11, 2021 at 4:34 PM Vincenzo Frascino
> <vincenzo.frascino@arm.com> wrote:
>>
>> MTE provides an asynchronous mode for detecting tag exceptions. In
>> particular instead of triggering a fault the arm64 core updates a
>> register which is checked by the kernel after the asynchronous tag
>> check fault has occurred.
>>
>> Add support for MTE asynchronous mode.
>>
>> The exception handling mechanism will be added with a future patch.
>>
>> Note: KASAN HW activates async mode via kasan.mode kernel parameter.
>> The default mode is set to synchronous.
>> The code that verifies the status of TFSR_EL1 will be added with a
>> future patch.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
>> Reviewed-by: Andrey Konovalov <andreyknvl@google.com>
>> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
>> ---
>>  arch/arm64/include/asm/memory.h    |  3 ++-
>>  arch/arm64/include/asm/mte-kasan.h |  9 +++++++--
>>  arch/arm64/kernel/mte.c            | 19 ++++++++++++++++---
>>  3 files changed, 25 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
>> index c759faf7a1ff..91515383d763 100644
>> --- a/arch/arm64/include/asm/memory.h
>> +++ b/arch/arm64/include/asm/memory.h
>> @@ -243,7 +243,8 @@ static inline const void *__tag_set(const void *addr, u8 tag)
>>  }
>>
>>  #ifdef CONFIG_KASAN_HW_TAGS
>> -#define arch_enable_tagging()                  mte_enable_kernel()
>> +#define arch_enable_tagging_sync()             mte_enable_kernel_sync()
>> +#define arch_enable_tagging_async()            mte_enable_kernel_async()
> 
> We need to update KASAN usage of arch_enable_tagging() to
> arch_enable_tagging_sync() in this patch as well. Otherwise, this
> leaves KASAN broken between this patch and the next one.
>

Yes you are right, still can't explain why it did bysect cleanly though.
I will introduce temporarily here:

#define arch_enable_tagging() arch_enable_tagging_sync()

and remove it again in the respective kasan patch.

> 
>>  #define arch_set_tagging_report_once(state)    mte_set_report_once(state)
>>  #define arch_init_tags(max_tag)                        mte_init_tags(max_tag)
>>  #define arch_get_random_tag()                  mte_get_random_tag()
>> diff --git a/arch/arm64/include/asm/mte-kasan.h b/arch/arm64/include/asm/mte-kasan.h
>> index 7ab500e2ad17..4acf8bf41cad 100644
>> --- a/arch/arm64/include/asm/mte-kasan.h
>> +++ b/arch/arm64/include/asm/mte-kasan.h
>> @@ -77,7 +77,8 @@ static inline void mte_set_mem_tag_range(void *addr, size_t size, u8 tag)
>>         } while (curr != end);
>>  }
>>
>> -void mte_enable_kernel(void);
>> +void mte_enable_kernel_sync(void);
>> +void mte_enable_kernel_async(void);
>>  void mte_init_tags(u64 max_tag);
>>
>>  void mte_set_report_once(bool state);
>> @@ -104,7 +105,11 @@ static inline void mte_set_mem_tag_range(void *addr, size_t size, u8 tag)
>>  {
>>  }
>>
>> -static inline void mte_enable_kernel(void)
>> +static inline void mte_enable_kernel_sync(void)
>> +{
>> +}
>> +
>> +static inline void mte_enable_kernel_async(void)
>>  {
>>  }
>>
>> diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
>> index a66c2806fc4d..706b7ab75f31 100644
>> --- a/arch/arm64/kernel/mte.c
>> +++ b/arch/arm64/kernel/mte.c
>> @@ -107,13 +107,26 @@ void mte_init_tags(u64 max_tag)
>>         write_sysreg_s(SYS_GCR_EL1_RRND | gcr_kernel_excl, SYS_GCR_EL1);
>>  }
>>
>> -void mte_enable_kernel(void)
>> +static inline void __mte_enable_kernel(const char *mode, unsigned long tcf)
>>  {
>>         /* Enable MTE Sync Mode for EL1. */
>> -       sysreg_clear_set(sctlr_el1, SCTLR_ELx_TCF_MASK, SCTLR_ELx_TCF_SYNC);
>> +       sysreg_clear_set(sctlr_el1, SCTLR_ELx_TCF_MASK, tcf);
>>         isb();
>> +
>> +       pr_info_once("MTE: enabled in %s mode at EL1\n", mode);
>> +}
>> +
>> +void mte_enable_kernel_sync(void)
>> +{
>> +       __mte_enable_kernel("synchronous", SCTLR_ELx_TCF_SYNC);
>> +}
>> +EXPORT_SYMBOL_GPL(mte_enable_kernel_sync);
>> +
>> +void mte_enable_kernel_async(void)
>> +{
>> +       __mte_enable_kernel("asynchronous", SCTLR_ELx_TCF_ASYNC);
>>  }
>> -EXPORT_SYMBOL_GPL(mte_enable_kernel);
>> +EXPORT_SYMBOL_GPL(mte_enable_kernel_async);
>>
>>  void mte_set_report_once(bool state)
>>  {
>> --
>> 2.30.0
>>

-- 
Regards,
Vincenzo
