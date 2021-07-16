Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F09DF3CB32D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 09:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235822AbhGPHXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 03:23:00 -0400
Received: from foss.arm.com ([217.140.110.172]:35342 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235691AbhGPHW6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 03:22:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B8B2431B;
        Fri, 16 Jul 2021 00:20:03 -0700 (PDT)
Received: from [10.163.67.71] (unknown [10.163.67.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CD2523F7D8;
        Fri, 16 Jul 2021 00:20:00 -0700 (PDT)
Subject: Re: [RFC 06/10] arm64/mm: Add FEAT_LPA2 specific encoding
To:     Steven Price <steven.price@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, suzuki.poulose@arm.com,
        mark.rutland@arm.com, will@kernel.org, catalin.marinas@arm.com,
        maz@kernel.org, james.morse@arm.com
References: <1626229291-6569-1-git-send-email-anshuman.khandual@arm.com>
 <1626229291-6569-7-git-send-email-anshuman.khandual@arm.com>
 <9f0d9925-3694-3fae-0d09-00adbecd1878@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <b471b41b-de6d-3b56-2595-30586b0a47b3@arm.com>
Date:   Fri, 16 Jul 2021 12:50:49 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <9f0d9925-3694-3fae-0d09-00adbecd1878@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/14/21 9:08 PM, Steven Price wrote:
> On 14/07/2021 03:21, Anshuman Khandual wrote:
>> FEAT_LPA2 requires different PTE representation formats for both 4K and 16K
>> page size config. This adds FEAT_LPA2 specific new PTE encodings as per ARM
>> ARM (0487G.A) which updates [pte|phys]_to_[phys|pte](). The updated helpers
>> would be used when FEAT_LPA2 gets enabled via CONFIG_ARM64_PA_BITS_52 on 4K
>> and 16K page size. Although TTBR encoding and phys_to_ttbr() helper remains
>> the same as FEAT_LPA for FEAT_LPA2 as well. It updates 'phys_to_pte' helper
>> to accept a temporary variable and changes impacted call sites.
>>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>  arch/arm64/include/asm/assembler.h     | 23 +++++++++++++++++++----
>>  arch/arm64/include/asm/pgtable-hwdef.h |  4 ++++
>>  arch/arm64/include/asm/pgtable.h       |  4 ++++
>>  arch/arm64/kernel/head.S               | 25 +++++++++++++------------
>>  4 files changed, 40 insertions(+), 16 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
>> index fedc202..0492543 100644
>> --- a/arch/arm64/include/asm/assembler.h
>> +++ b/arch/arm64/include/asm/assembler.h
>> @@ -606,7 +606,7 @@ alternative_endif
>>  #endif
>>  	.endm
>>  
>> -	.macro	phys_to_pte, pte, phys
>> +	.macro	phys_to_pte, pte, phys, tmp
>>  #ifdef CONFIG_ARM64_PA_BITS_52_LPA
>>  	/*
>>  	 * We assume \phys is 64K aligned and this is guaranteed by only
>> @@ -614,6 +614,17 @@ alternative_endif
>>  	 */
>>  	orr	\pte, \phys, \phys, lsr #36
>>  	and	\pte, \pte, #PTE_ADDR_MASK
>> +#elif defined(CONFIG_ARM64_PA_BITS_52_LPA2)
>> +	orr	\pte, \phys, \phys, lsr #42
>> +
>> +	/*
>> +	 * The 'tmp' is being used here to just prepare
>> +	 * and hold PTE_ADDR_MASK which cannot be passed
>> +	 * to the subsequent 'and' instruction.
>> +	 */
>> +	mov	\tmp, #PTE_ADDR_LOW
>> +	orr	\tmp, \tmp, #PTE_ADDR_HIGH
>> +	and	\pte, \pte, \tmp
> Rather than adding an extra temporary register (and the fallout of
> various other macros needing an extra register), this can be done with
> two AND instructions:

I would really like to get rid of the 'tmp' variable here as
well but did not figure out any method of accomplishing it.

> 
> 	/* PTE_ADDR_MASK cannot be encoded as an immediate, so
>          * mask off all but two bits, followed by masking the
>          * extra two bits
>          */
> 	and	\pte, \pte, #PTE_ADDR_MASK | (3 << 10)
> 	and	\pte, \pte, #~(3 << 10)

Did this change as suggested

--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -626,9 +626,8 @@ alternative_endif
         * and hold PTE_ADDR_MASK which cannot be passed
         * to the subsequent 'and' instruction.
         */
-       mov     \tmp, #PTE_ADDR_LOW
-       orr     \tmp, \tmp, #PTE_ADDR_HIGH
-       and     \pte, \pte, \tmp
+       and     \pte, \pte, #PTE_ADDR_MASK | (0x3 << 10)
+       and     \pte, \pte, #~(0x3 << 10)
 
 .Lskip_lpa2\@:
        mov     \pte, \phys


but still fails to build (tested on 16K)

arch/arm64/kernel/head.S: Assembler messages:
arch/arm64/kernel/head.S:377: Error: immediate out of range at operand 3 -- `and x6,x6,#((((1<<(50-14))-1)<<14)|(0x3<<8))|(0x3<<10)'
arch/arm64/kernel/head.S:390: Error: immediate out of range at operand 3 -- `and x12,x12,#((((1<<(50-14))-1)<<14)|(0x3<<8))|(0x3<<10)'
arch/arm64/kernel/head.S:390: Error: immediate out of range at operand 3 -- `and x12,x12,#((((1<<(50-14))-1)<<14)|(0x3<<8))|(0x3<<10)'
arch/arm64/kernel/head.S:404: Error: immediate out of range at operand 3 -- `and x12,x12,#((((1<<(50-14))-1)<<14)|(0x3<<8))|(0x3<<10)'
arch/arm64/kernel/head.S:404: Error: immediate out of range at operand 3 -- `and x12,x12,#((((1<<(50-14))-1)<<14)|(0x3<<8))|(0x3<<10)'
