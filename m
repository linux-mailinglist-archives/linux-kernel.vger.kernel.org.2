Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B75F3E9ACD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 00:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbhHKWR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 18:17:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:36214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232212AbhHKWR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 18:17:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4F74860F46;
        Wed, 11 Aug 2021 22:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628720222;
        bh=UaYfoPDE2WuCGV0z84ZII/H6BosPDprnkParVyRKNRo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ICE6+tLuUCglGwJP+j1DNUB5gMzg4siP5Y+84MQaKMxptMxe1YoBY/8HkJqmjKfYz
         tn6PoTnY+KA0Bn6IGAQd/7YTBYYS//aWG8qu4n+0EMKu5qvtSBIiP8zHHCXvADGBID
         41SHsAkKziUkvAmGxrgemcOF3WPZ3/F8fmqxuDJxoJ+sM0JTIa7QF/gNL4YDrw6aNO
         2wljBj9dlmk9Yn1kqX+FrtKUZazwH+8WK0Db3IhhhJzm+A0WOzQKFoM27kbjqge4zw
         cY5c4gkCZCIVzbX9/JaTlD637FjHd1gpykcGp01oqcE3qcx2Ju0cvr3pMWipuAYrxM
         MSwHGg+uiwkOw==
Subject: Re: [PATCH 16/18] ARC: mm: support 4 levels of page tables
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Anshuman Khandual <anshuman.khandual@arm.com>
References: <20210811004258.138075-1-vgupta@kernel.org>
 <20210811004258.138075-17-vgupta@kernel.org> <YRPCaxDC5f8N9jHW@kernel.org>
From:   Vineet Gupta <vgupta@kernel.org>
Message-ID: <cfe75b58-0783-5997-c05f-3c7db88508f8@kernel.org>
Date:   Wed, 11 Aug 2021 15:17:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YRPCaxDC5f8N9jHW@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/21 5:28 AM, Mike Rapoport wrote:
> On Tue, Aug 10, 2021 at 05:42:56PM -0700, Vineet Gupta wrote:
>> Signed-off-by: Vineet Gupta<vgupta@kernel.org>
>> ---
>>   arch/arc/include/asm/page.h           | 11 +++++++
>>   arch/arc/include/asm/pgalloc.h        | 22 +++++++++++++
>>   arch/arc/include/asm/pgtable-levels.h | 45 ++++++++++++++++++++++++---
>>   arch/arc/mm/fault.c                   |  2 ++
>>   arch/arc/mm/tlbex.S                   |  9 ++++++
>>   5 files changed, 84 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arc/include/asm/page.h b/arch/arc/include/asm/page.h
>> index df3cc154ae4a..883856f12afe 100644
>> --- a/arch/arc/include/asm/page.h
>> +++ b/arch/arc/include/asm/page.h
>> @@ -41,6 +41,17 @@ typedef struct {
>>   #define pgd_val(x)	((x).pgd)
>>   #define __pgd(x)	((pgd_t) { (x) })
>>   
>> +#if CONFIG_PGTABLE_LEVELS > 3
>> +
>> +typedef struct {
>> +	unsigned long pud;
>> +} pud_t;
>> +
>> +#define pud_val(x)      	((x).pud)
>> +#define __pud(x)        	((pud_t) { (x) })
>> +
>> +#endif
>> +
>>   #if CONFIG_PGTABLE_LEVELS > 2
>>   
>>   typedef struct {
>> diff --git a/arch/arc/include/asm/pgalloc.h b/arch/arc/include/asm/pgalloc.h
>> index 01c2d84418ed..e99c724d9235 100644
>> --- a/arch/arc/include/asm/pgalloc.h
>> +++ b/arch/arc/include/asm/pgalloc.h
>> @@ -86,6 +86,28 @@ static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
>>   }
>>   
>>   
>> +#if CONFIG_PGTABLE_LEVELS > 3
>> +
>> +static inline void p4d_populate(struct mm_struct *mm, p4d_t *p4dp, pud_t *pudp)
>> +{
>> +	set_p4d(p4dp, __p4d((unsigned long)pudp));
>> +}
>> +
>> +static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long addr)
>> +{
>> +	return (pud_t *)__get_free_page(
>> +		GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_ZERO);
>> +}
>> +
>> +static inline void pud_free(struct mm_struct *mm, pud_t *pudp)
>> +{
>> +	free_page((unsigned long)pudp);
>> +}
>> +
>> +#define __pud_free_tlb(tlb, pmd, addr)  pud_free((tlb)->mm, pmd)
>> +
>> +#endif
>> +
>>   #if CONFIG_PGTABLE_LEVELS > 2
>>   
>>   static inline void pud_populate(struct mm_struct *mm, pud_t *pudp, pmd_t *pmdp)
>> diff --git a/arch/arc/include/asm/pgtable-levels.h b/arch/arc/include/asm/pgtable-levels.h
>> index 1c2f022d4ad0..2da3c4e52a91 100644
>> --- a/arch/arc/include/asm/pgtable-levels.h
>> +++ b/arch/arc/include/asm/pgtable-levels.h
>> @@ -44,8 +44,13 @@
>>   /*
>>    * A default 3 level paging testing setup in software walked MMU
>>    *   MMUv4 (8K page): <4> : <7> : <8> : <13>
>> + * A default 4 level paging testing setup in software walked MMU
>> + *   MMUv4 (8K page): <4> : <3> : <4> : <8> : <13>
>>    */
>>   #define PGDIR_SHIFT		28
>> +#if CONFIG_PGTABLE_LEVELS > 3
>> +#define PUD_SHIFT		25
>> +#endif
>>   #if CONFIG_PGTABLE_LEVELS > 2
>>   #define PMD_SHIFT		21
>>   #endif
>> @@ -56,17 +61,25 @@
>>   #define PGDIR_MASK		(~(PGDIR_SIZE - 1))
>>   #define PTRS_PER_PGD		BIT(32 - PGDIR_SHIFT)
>>   
>> +#if CONFIG_PGTABLE_LEVELS > 3
>> +#define PUD_SIZE		BIT(PUD_SHIFT)
>> +#define PUD_MASK		(~(PUD_SIZE - 1))
>> +#define PTRS_PER_PUD		BIT(PGDIR_SHIFT - PUD_SHIFT)
> Maybe move these into the previous #if CONFIG_PGTABLE_LEVELS > 3?

Same reasoning as the prev one. Sure there's a bit more ifdef'ery but I 
think it looks more organized to me. But if you really feel strongly I 
can move the code around.

-Vineet
