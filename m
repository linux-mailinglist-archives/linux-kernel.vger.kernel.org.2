Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 459443DEBB2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 13:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235552AbhHCL01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 07:26:27 -0400
Received: from foss.arm.com ([217.140.110.172]:47576 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235497AbhHCL01 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 07:26:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC3191396;
        Tue,  3 Aug 2021 04:26:15 -0700 (PDT)
Received: from [10.163.67.68] (unknown [10.163.67.68])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 921433F40C;
        Tue,  3 Aug 2021 04:26:13 -0700 (PDT)
Subject: Re: [PATCH] arm64/mm: Fix idmap on [16K|36VA|48PA]
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
References: <1627879359-30303-1-git-send-email-anshuman.khandual@arm.com>
 <20210803103440.GA5786@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <7bad50a2-76f1-7946-3a15-35e46fb289c0@arm.com>
Date:   Tue, 3 Aug 2021 16:57:04 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210803103440.GA5786@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/3/21 4:04 PM, Catalin Marinas wrote:
> On Mon, Aug 02, 2021 at 10:12:39AM +0530, Anshuman Khandual wrote:
>> When creating the idmap, the kernel may add one extra level to idmap memory
>> outside the VA range. But for [16K|36VA|48PA], we need two levels to reach
>> 48 bits. If the bootloader places the kernel in memory above (1 << 46), the
> 
> Did you mean (1 << 36)?

No it is actually (1 << 47). If __idmap_text_end is beyond (1 << 47), a single
additional page table level in idmap would not be sufficient to map it. Rather
two more levels would be required. A single additional page table level covers
(PAGE_SHIFT - 3 = 14 - 3 = 11) bits on 16K pages.

First  additional page table level covers	VA(36) --> (47)
Second additional page table level covers	VA(48) --> (48)

> 
>> kernel will fail to enable the MMU. Although we are not aware of a platform
>> where this happens, it is worth to accommodate such scenarios and prevent a
>> possible kernel crash.
>>
>> Lets fix the problem on the above configuration by creating two additional
>> idmap page table levels when 'idmap_text_end' is outside the VA range. This
>> reduces 'idmap_t0sz' to cover the entire PA range which would prevent table
>> misconfiguration (fault) when a given 'idmap_t0sz' value requires a single
>> additional page table level where as two have been built.
> [...]
>> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
>> index c5c994a..da33bbc 100644
>> --- a/arch/arm64/kernel/head.S
>> +++ b/arch/arm64/kernel/head.S
>> @@ -329,7 +329,9 @@ SYM_FUNC_START_LOCAL(__create_page_tables)
>>  
>>  #if (VA_BITS < 48)
>>  #define EXTRA_SHIFT	(PGDIR_SHIFT + PAGE_SHIFT - 3)
>> +#define EXTRA_SHIFT_1	(EXTRA_SHIFT + PAGE_SHIFT - 3)
>>  #define EXTRA_PTRS	(1 << (PHYS_MASK_SHIFT - EXTRA_SHIFT))
>> +#define EXTRA_PTRS_1	(1 << (PHYS_MASK_SHIFT - EXTRA_SHIFT_1))
>>  
>>  	/*
>>  	 * If VA_BITS < 48, we have to configure an additional table level.
>> @@ -342,8 +344,30 @@ SYM_FUNC_START_LOCAL(__create_page_tables)
>>  #error "Mismatch between VA_BITS and page size/number of translation levels"
>>  #endif
>>  
>> +/*
>> + * In this particular CONFIG_ARM64_16K_PAGES config, there might be a
>> + * scenario where 'idmap_text_end' ends up high enough in the PA range
>> + * requiring two additional idmap page table levels. Reduce idmap_t0sz
>> + * to cover the entire PA range. This prevents table misconfiguration
>> + * when a given idmap_t0sz value just requires single additional level
>> + * where as two levels have been built.
>> + */
>> +#if defined(CONFIG_ARM64_VA_BITS_36) && defined(CONFIG_ARM64_PA_BITS_48)
>> +	mov	x4, EXTRA_PTRS_1
>> +	create_table_entry x0, x3, EXTRA_SHIFT_1, x4, x5, x6
>> +
>> +	mov	x4, PTRS_PER_PTE
>> +	create_table_entry x0, x3, EXTRA_SHIFT, x4, x5, x6
>> +
>> +	mov	x5, #64 - PHYS_MASK_SHIFT
>> +	adr_l	x6, idmap_t0sz
>> +	str	x5, [x6]
>> +	dmb	sy
>> +	dc	ivac, x6
>> +#else
>>  	mov	x4, EXTRA_PTRS
>>  	create_table_entry x0, x3, EXTRA_SHIFT, x4, x5, x6
>> +#endif
>>  #else
>>  	/*
>>  	 * If VA_BITS == 48, we don't have to configure an additional
> 
> There's a prior idmap_t0sz setting based on __idmap_text_end. Isn't that
> sufficient? We don't care about covering the whole PA space, just the
> __idmap_text_end.

Right but its bit tricky here.

__idmap_text_end could be any where between VA_BITS (36) and PA_BITS (48)
which would require (one or two) additional page table levels. But in this
solution it creates two additional page table levels for idmap which would
completely map upto PA_BITS, regardless of __idmap_text_end's position. So
in case __idmap_text_end is between VA_BITS (36) and VA_BITS(47), a single
additional page table level is required where as we have created two ! So
to avoid such a situation, adjust idmap_t0sz accordingly. Otherwise there
will be a MMU mis-configuration.

This patch is indented for stable back port and hence tries to be as simple
and minimal as possible. So it creates two additional page table levels
mapping upto PA_BITS without just considering __idmap_text_end's position.
Reducing __idmap_t0sz upto PA_BITS should not be a problem irrespective of
ID_AA64MMFR0_EL1.PARANGE value. As __idmap_text_end would never be on a PA
which is not supported. Hence out of range PA would never be on the bus for
translation.
