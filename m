Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5349B3E9ACB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 00:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232454AbhHKWP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 18:15:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:60472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232226AbhHKWP6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 18:15:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9856A60462;
        Wed, 11 Aug 2021 22:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628720134;
        bh=PA2v/bxyiDdtoBYeKQY7SGsBHybDekFx7rqqJ52I8qg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Sy9IJOOy6ccdw3ccS614BwU/RljW9LaFHzEbg6qqXw+lYBzS6ft0QmQie4XeyhXWH
         ECTE8Y24mYVpTMeG7bb4BT8ixIZ9G4E3tp8Pk7IAnlx/+3xAOjJd7SVSU2KKUCT124
         PMgcWX1f7ZJbK2Gop86RmFwKNKOpjcVOjlkDhgy3LTW/dohrRcjMTsbGdaD9rNbPSa
         hFf/jrx2LGrKWvu2HZSLb7QNU/h+mPWET2VDJbEJ7x4Rj3uBxMYEa9obs5nxee5HlP
         35klOM+Rz7tTh/02Hd/6hhsN3kP7XzYcfwNLBRkHiwQvLs1RZGtoMWKxFKAIj7zaCi
         uU4cgkkmFtczA==
Subject: Re: [PATCH 15/18] ARC: mm: support 3 levels of page tables
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Anshuman Khandual <anshuman.khandual@arm.com>
References: <20210811004258.138075-1-vgupta@kernel.org>
 <20210811004258.138075-16-vgupta@kernel.org> <YRPBhJyYM/L5XWb/@kernel.org>
From:   Vineet Gupta <vgupta@kernel.org>
Message-ID: <0d3aa903-9e4d-fdef-82f8-23b53602c6ea@kernel.org>
Date:   Wed, 11 Aug 2021 15:15:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YRPBhJyYM/L5XWb/@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/21 5:24 AM, Mike Rapoport wrote:
> On Tue, Aug 10, 2021 at 05:42:55PM -0700, Vineet Gupta wrote:
>> ARCv2 MMU is software walked and Linux implements 2 levels of paging: pgd/pte.
>> Forthcoming hw will have multiple levels, so this change preps mm code
>> for same. It is also fun to try multi levels even on soft-walked code to
>> ensure generic mm code is robust to handle.
>>
>> overview
>> ________
>>
>> 2 levels {pgd, pte} : pmd is folded but pmd_* macros are valid and operate on pgd
>> 3 levels {pgd, pmd, pte}:
>>    - pud is folded and pud_* macros point to pgd
>>    - pmd_* macros operate on actual pmd
>>
>> code changes
>> ____________
>>
>> 1. #include <asm-generic/pgtable-nopud.h>
>>
>> 2. Define CONFIG_PGTABLE_LEVELS 3
>>
>> 3a. Define PMD_SHIFT, PMD_SIZE, PMD_MASK, pmd_t
>> 3b. Define pmd_val() which actually deals with pmd
>>      (pmd_offset(), pmd_index() are provided by generic code)
>> 3c. Define pmd_alloc_one() and pmd_free() to allocate pmd
>>      (pmd_populate/pmd_free already exist)
>>
>> 4. Define pud_none(), pud_bad() macros based on generic pud_val() which
>>     internally pertains to pgd now.
>> 4b. define pud_populate() to just setup pgd
>>
>> Signed-off-by: Vineet Gupta <vgupta@kernel.org>
>> ---
>>   arch/arc/Kconfig                      |  4 ++
>>   arch/arc/include/asm/page.h           | 11 +++++
>>   arch/arc/include/asm/pgalloc.h        | 22 ++++++++++
>>   arch/arc/include/asm/pgtable-levels.h | 63 ++++++++++++++++++++++++---
>>   arch/arc/include/asm/processor.h      |  2 +-
>>   arch/arc/mm/fault.c                   |  4 ++
>>   arch/arc/mm/tlb.c                     |  4 +-
>>   arch/arc/mm/tlbex.S                   |  9 ++++
>>   8 files changed, 111 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
>> index 59d5b2a179f6..43cb8aaf57a2 100644
>> --- a/arch/arc/Kconfig
>> +++ b/arch/arc/Kconfig
>> @@ -314,6 +314,10 @@ config ARC_HUGEPAGE_16M
>>   
>>   endchoice
>>   
>> +config PGTABLE_LEVELS
>> +	int "Number of Page table levels"
>> +	default 2
>> +
>>   config ARC_COMPACT_IRQ_LEVELS
>>   	depends on ISA_ARCOMPACT
>>   	bool "Setup Timer IRQ as high Priority"
>> diff --git a/arch/arc/include/asm/page.h b/arch/arc/include/asm/page.h
>> index 313e6f543d2d..df3cc154ae4a 100644
>> --- a/arch/arc/include/asm/page.h
>> +++ b/arch/arc/include/asm/page.h
>> @@ -41,6 +41,17 @@ typedef struct {
>>   #define pgd_val(x)	((x).pgd)
>>   #define __pgd(x)	((pgd_t) { (x) })
>>   
>> +#if CONFIG_PGTABLE_LEVELS > 2
>> +
>> +typedef struct {
>> +	unsigned long pmd;
>> +} pmd_t;
>> +
>> +#define pmd_val(x)	((x).pmd)
>> +#define __pmd(x)	((pmd_t) { (x) })
>> +
>> +#endif
>> +
>>   typedef struct {
>>   #ifdef CONFIG_ARC_HAS_PAE40
>>   	unsigned long long pte;
>> diff --git a/arch/arc/include/asm/pgalloc.h b/arch/arc/include/asm/pgalloc.h
>> index 0cf73431eb89..01c2d84418ed 100644
>> --- a/arch/arc/include/asm/pgalloc.h
>> +++ b/arch/arc/include/asm/pgalloc.h
>> @@ -86,6 +86,28 @@ static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
>>   }
>>   
>>   
>> +#if CONFIG_PGTABLE_LEVELS > 2
>> +
>> +static inline void pud_populate(struct mm_struct *mm, pud_t *pudp, pmd_t *pmdp)
>> +{
>> +	set_pud(pudp, __pud((unsigned long)pmdp));
>> +}
>> +
>> +static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long addr)
>> +{
>> +	return (pmd_t *)__get_free_page(
>> +		GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_ZERO);
>> +}
>> +
>> +static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
>> +{
>> +	free_page((unsigned long)pmd);
>> +}
>> +
>> +#define __pmd_free_tlb(tlb, pmd, addr)  pmd_free((tlb)->mm, pmd)
>> +
>> +#endif
>> +
>>   /*
>>    * With software-only page-tables, addr-split for traversal is tweakable and
>>    * that directly governs how big tables would be at each level.
>> diff --git a/arch/arc/include/asm/pgtable-levels.h b/arch/arc/include/asm/pgtable-levels.h
>> index 8ece75335bb5..1c2f022d4ad0 100644
>> --- a/arch/arc/include/asm/pgtable-levels.h
>> +++ b/arch/arc/include/asm/pgtable-levels.h
>> @@ -10,6 +10,8 @@
>>   #ifndef _ASM_ARC_PGTABLE_LEVELS_H
>>   #define _ASM_ARC_PGTABLE_LEVELS_H
>>   
>> +#if CONFIG_PGTABLE_LEVELS == 2
>> +
>>   /*
>>    * 2 level paging setup for software walked MMUv3 (ARC700) and MMUv4 (HS)
>>    *
>> @@ -37,16 +39,38 @@
>>   #define PGDIR_SHIFT		21
>>   #endif
>>   
>> -#define PGDIR_SIZE		BIT(PGDIR_SHIFT)	/* vaddr span, not PDG sz */
>> -#define PGDIR_MASK		(~(PGDIR_SIZE - 1))
>> +#else
>> +
>> +/*
>> + * A default 3 level paging testing setup in software walked MMU
>> + *   MMUv4 (8K page): <4> : <7> : <8> : <13>
>> + */
>> +#define PGDIR_SHIFT		28
>> +#if CONFIG_PGTABLE_LEVELS > 2
>> +#define PMD_SHIFT		21
>> +#endif
>> +
>> +#endif
>>   
>> +#define PGDIR_SIZE		BIT(PGDIR_SHIFT)
>> +#define PGDIR_MASK		(~(PGDIR_SIZE - 1))
>>   #define PTRS_PER_PGD		BIT(32 - PGDIR_SHIFT)
>>   
>> -#define PTRS_PER_PTE		BIT(PGDIR_SHIFT - PAGE_SHIFT)
>> +#if CONFIG_PGTABLE_LEVELS > 2
>> +#define PMD_SIZE		BIT(PMD_SHIFT)
>> +#define PMD_MASK		(~(PMD_SIZE - 1))
>> +#define PTRS_PER_PMD		BIT(PGDIR_SHIFT - PMD_SHIFT)
> Maybe move these into the previous #if CONFIG_PGTABLE_LEVELS > 2?

I've kept them separate to distinguish the "configuration" parts which 
can be changed (for ARCv2 where this is not hardware enforced) from the 
pieces which remain the same. So PMD_SHIFT can be changed for a quick 
hack say but the PMD_{SIZE,MASK} etc are invariants.

-Vineet
