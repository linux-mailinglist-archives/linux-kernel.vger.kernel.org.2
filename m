Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10E823CCD2E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 06:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbhGSEtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 00:49:35 -0400
Received: from foss.arm.com ([217.140.110.172]:48884 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229512AbhGSEte (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 00:49:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B309B31B;
        Sun, 18 Jul 2021 21:46:34 -0700 (PDT)
Received: from [10.163.64.230] (unknown [10.163.64.230])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 026E33F694;
        Sun, 18 Jul 2021 21:46:30 -0700 (PDT)
Subject: Re: [RFC 07/10] arm64/mm: Detect and enable FEAT_LPA2
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, mark.rutland@arm.com, will@kernel.org,
        catalin.marinas@arm.com, maz@kernel.org, james.morse@arm.com,
        steven.price@arm.com
References: <1626229291-6569-1-git-send-email-anshuman.khandual@arm.com>
 <1626229291-6569-8-git-send-email-anshuman.khandual@arm.com>
 <18c42dd0-b6db-d118-dad0-cac0bf6ab2ce@arm.com>
 <8adefac5-c677-1fca-20dd-bba8543f8d59@arm.com>
 <429105f9-e967-492e-1d1f-5bb913ef6854@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <a2ba2c98-bcf6-85cc-bdb7-633b5e5aa756@arm.com>
Date:   Mon, 19 Jul 2021 10:17:20 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <429105f9-e967-492e-1d1f-5bb913ef6854@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/16/21 1:38 PM, Suzuki K Poulose wrote:
> On 16/07/2021 08:06, Anshuman Khandual wrote:
>>
>> On 7/14/21 1:51 PM, Suzuki K Poulose wrote:
>>> On 14/07/2021 03:21, Anshuman Khandual wrote:
>>>> Detect FEAT_LPA2 implementation early enough during boot when requested via
>>>> CONFIG_ARM64_PA_BITS_52_LPA2 and remember in a variable arm64_lpa2_enabled.
>>>> This variable could then be used to turn on TCR_EL1.TCR_DS effecting the 52
>>>> bits PA range or fall back to default 48 bits PA range if FEAT_LPA2 feature
>>>> was requested but found not to be implemented.
>>>>
>>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>>> ---
>>>>    arch/arm64/include/asm/memory.h |  1 +
>>>>    arch/arm64/kernel/head.S        | 15 +++++++++++++++
>>>>    arch/arm64/mm/mmu.c             |  3 +++
>>>>    arch/arm64/mm/proc.S            |  9 +++++++++
>>>>    4 files changed, 28 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
>>>> index 824a365..d0ca002 100644
>>>> --- a/arch/arm64/include/asm/memory.h
>>>> +++ b/arch/arm64/include/asm/memory.h
>>>> @@ -178,6 +178,7 @@
>>>>    #include <asm/bug.h>
>>>>      extern u64            vabits_actual;
>>>> +extern u64            arm64_lpa2_enabled;
>>>>      extern s64            memstart_addr;
>>>>    /* PHYS_OFFSET - the physical address of the start of memory. */
>>>> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
>>>> index 6444147..9cf79ea 100644
>>>> --- a/arch/arm64/kernel/head.S
>>>> +++ b/arch/arm64/kernel/head.S
>>>> @@ -94,6 +94,21 @@ SYM_CODE_START(primary_entry)
>>>>        adrp    x23, __PHYS_OFFSET
>>>>        and    x23, x23, MIN_KIMG_ALIGN - 1    // KASLR offset, defaults to 0
>>>>        bl    set_cpu_boot_mode_flag
>>>> +
>>>> +#ifdef CONFIG_ARM64_PA_BITS_52_LPA2
>>>> +    mrs     x10, ID_AA64MMFR0_EL1
>>>> +    ubfx    x10, x10, #ID_AA64MMFR0_TGRAN_SHIFT, 4
>>>> +    cmp     x10, #ID_AA64MMFR0_TGRAN_LPA2
>>>> +    b.ne    1f
>>>
>>> For the sake of forward compatibility, this should be "b.lt"
>> Right, I guess we could assume that the feature will be present from the
>> current ID_AA64MMFR0_TGRAN_LPA2 values onward in the future. But should
>> not this also be capped at ID_AA64MMFR0_TGRAN_SUPPORTED_MAX as the upper
>> limit is different for 4K and 16K page sizes.
> 
> Absolutely.

ID_AA64MMFR0_TGRAN_SUPPORTED_MAX check there is not required as __enable_mmu()
already performs the required boundary check for a given page size support.
