Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70B5A3EDE49
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 21:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbhHPTyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 15:54:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:45378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231545AbhHPTyT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 15:54:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8F2C860F55;
        Mon, 16 Aug 2021 19:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629143627;
        bh=r/p8syA5J+lSSVbewqqUp6dVC6KJ6TIpFGwK1o5LI48=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=AZxIiheBnZDugN1zxIu3qLt1vTjNx7hnQj6R+FXnTzkLHPw66PqdHDHoTCV3HIuCo
         C/oQpj71tqTU47TQ6kUITmC6trdnzCfSGShLHrDRKoqTasNLw8zj3w/sedPxZ5BRka
         wlYO7S2CYh9N5hgw7t5WODMcgM2tzX3QpTbwiZ7LPXDw+68YzeI4Pnf9G4OprdaQMW
         UUtuHL0QPtrw3vt4Ytlx4cVZBDsLDGFt9aGezBk+sT48GvXFTbpsF3LMoTNbvMbp8z
         /Pal4tynsZbCVeYFR76NIgx9d8GvkoQ8ZGTsWCakLeGuFaKLNpSvV2oJMgkKnuVkVY
         UvZCIzGEb32vw==
Subject: Re: [PATCH v2 16/19] ARC: mm: support 3 levels of page tables
To:     Mike Rapoport <rppt@kernel.org>, Vineet Gupta <vgupta@kernel.org>
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Anshuman Khandual <anshuman.khandual@arm.com>
References: <20210812233753.104217-1-vgupta@kernel.org>
 <20210812233753.104217-17-vgupta@kernel.org> <YRjeHE19KXqYWgRp@kernel.org>
From:   Vineet Gupta <vgupta@kernel.org>
Message-ID: <3878c8da-cba0-d4f5-90a7-f4024054872d@kernel.org>
Date:   Mon, 16 Aug 2021 12:53:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YRjeHE19KXqYWgRp@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/15/21 2:27 AM, Mike Rapoport wrote:
> On Thu, Aug 12, 2021 at 04:37:50PM -0700, Vineet Gupta wrote:
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
>> 3c. pmd_alloc_one()/pmd_free() also provided by generic code
>>      (pmd_populate/pmd_free already exist)
>>
>> 4. Define pud_none(), pud_bad() macros based on generic pud_val() which
>>     internally pertains to pgd now.
>> 4b. define pud_populate() to just setup pgd
>>
>> Signed-off-by: Vineet Gupta <vgupta@kernel.org>
>> ---
> ...
>
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
> Adding /* CONFIG_PGTABLE_LEVELS == 2 */ would make the whole thing a bit
> more readable, I think.

You meant

+#else /* CONFIG_PGTABLE_LEVELS != 2

>
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
> and here as well.

I added following to indicate conditional coding for levels related code

+#endif /* CONFIG_PGTABLE_LEVELS */


>    
>> +#define PGDIR_SIZE		BIT(PGDIR_SHIFT)
>> +#define PGDIR_MASK		(~(PGDIR_SIZE - 1))
>>   #define PTRS_PER_PGD		BIT(32 - PGDIR_SHIFT)
>>   
>> -#define PTRS_PER_PTE		BIT(PGDIR_SHIFT - PAGE_SHIFT)
>> +#if CONFIG_PGTABLE_LEVELS > 2
>> +#define PMD_SIZE		BIT(PMD_SHIFT)
>> +#define PMD_MASK		(~(PMD_SIZE - 1))
>> +#define PTRS_PER_PMD		BIT(PGDIR_SHIFT - PMD_SHIFT)
>> +#endif
>> +
>> +#define PTRS_PER_PTE		BIT(PMD_SHIFT - PAGE_SHIFT)
>>   

