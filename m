Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 716E23639BC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 05:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237277AbhDSD37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 23:29:59 -0400
Received: from foss.arm.com ([217.140.110.172]:34110 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232317AbhDSD3v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 23:29:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 65A3431B;
        Sun, 18 Apr 2021 20:29:22 -0700 (PDT)
Received: from [10.163.74.113] (unknown [10.163.74.113])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CB78D3F800;
        Sun, 18 Apr 2021 20:29:20 -0700 (PDT)
Subject: Re: [PATCH -next v2 1/2] mm/debug_vm_pgtable: Move
 {pmd/pud}_huge_tests out of CONFIG_TRANSPARENT_HUGEPAGE
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     Shixin Liu <liushixin2@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210406044900.2178705-1-liushixin2@huawei.com>
 <4f290e6e-0e44-8f9a-52e8-1e113695abbb@arm.com>
Message-ID: <a0962789-9238-9900-c7cb-41c41eb1d916@arm.com>
Date:   Mon, 19 Apr 2021 09:00:12 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <4f290e6e-0e44-8f9a-52e8-1e113695abbb@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/9/21 9:35 AM, Anshuman Khandual wrote:
> 
> On 4/6/21 10:18 AM, Shixin Liu wrote:
>> v1->v2:
>> Modified the commit message.
> 
> Please avoid change log in the commit message, it should be after '---'
> below the SOB statement.
> 
>>
>> The functions {pmd/pud}_set_huge and {pmd/pud}_clear_huge ars not dependent on THP.
> 
> typo 							   ^^^^^ s/ars/are
> 
> Also there is a checkpatch.pl warning.
> 
> WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
> #10: 
> The functions {pmd/pud}_set_huge and {pmd/pud}_clear_huge ars not dependent on THP.
> 
> total: 0 errors, 1 warnings, 121 lines checked
> 
> As I had mentioned in the earlier version, the commit message should be some
> thing like ..
> 
> ----
> The functions {pmd/pud}_set_huge and {pmd/pud}_clear_huge are not dependent
> on THP. Hence move {pmd/pud}_huge_tests out of CONFIG_TRANSPARENT_HUGEPAGE.
> ----
> 
>>
>> Signed-off-by: Shixin Liu <liushixin2@huawei.com>
>> ---
>>  mm/debug_vm_pgtable.c | 91 +++++++++++++++++++------------------------
>>  1 file changed, 39 insertions(+), 52 deletions(-)
>>
>> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
>> index 05efe98a9ac2..d3cf178621d9 100644
>> --- a/mm/debug_vm_pgtable.c
>> +++ b/mm/debug_vm_pgtable.c
>> @@ -242,29 +242,6 @@ static void __init pmd_leaf_tests(unsigned long pfn, pgprot_t prot)
>>  	WARN_ON(!pmd_leaf(pmd));
>>  }
>>  
>> -#ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
>> -static void __init pmd_huge_tests(pmd_t *pmdp, unsigned long pfn, pgprot_t prot)
>> -{
>> -	pmd_t pmd;
>> -
>> -	if (!arch_vmap_pmd_supported(prot))
>> -		return;
>> -
>> -	pr_debug("Validating PMD huge\n");
>> -	/*
>> -	 * X86 defined pmd_set_huge() verifies that the given
>> -	 * PMD is not a populated non-leaf entry.
>> -	 */
>> -	WRITE_ONCE(*pmdp, __pmd(0));
>> -	WARN_ON(!pmd_set_huge(pmdp, __pfn_to_phys(pfn), prot));
>> -	WARN_ON(!pmd_clear_huge(pmdp));
>> -	pmd = READ_ONCE(*pmdp);
>> -	WARN_ON(!pmd_none(pmd));
>> -}
>> -#else /* CONFIG_HAVE_ARCH_HUGE_VMAP */
>> -static void __init pmd_huge_tests(pmd_t *pmdp, unsigned long pfn, pgprot_t prot) { }
>> -#endif /* CONFIG_HAVE_ARCH_HUGE_VMAP */
>> -
>>  static void __init pmd_savedwrite_tests(unsigned long pfn, pgprot_t prot)
>>  {
>>  	pmd_t pmd = pfn_pmd(pfn, prot);
>> @@ -379,30 +356,6 @@ static void __init pud_leaf_tests(unsigned long pfn, pgprot_t prot)
>>  	pud = pud_mkhuge(pud);
>>  	WARN_ON(!pud_leaf(pud));
>>  }
>> -
>> -#ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
>> -static void __init pud_huge_tests(pud_t *pudp, unsigned long pfn, pgprot_t prot)
>> -{
>> -	pud_t pud;
>> -
>> -	if (!arch_vmap_pud_supported(prot))
>> -		return;
>> -
>> -	pr_debug("Validating PUD huge\n");
>> -	/*
>> -	 * X86 defined pud_set_huge() verifies that the given
>> -	 * PUD is not a populated non-leaf entry.
>> -	 */
>> -	WRITE_ONCE(*pudp, __pud(0));
>> -	WARN_ON(!pud_set_huge(pudp, __pfn_to_phys(pfn), prot));
>> -	WARN_ON(!pud_clear_huge(pudp));
>> -	pud = READ_ONCE(*pudp);
>> -	WARN_ON(!pud_none(pud));
>> -}
>> -#else /* !CONFIG_HAVE_ARCH_HUGE_VMAP */
>> -static void __init pud_huge_tests(pud_t *pudp, unsigned long pfn, pgprot_t prot) { }
>> -#endif /* !CONFIG_HAVE_ARCH_HUGE_VMAP */
>> -
>>  #else  /* !CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
>>  static void __init pud_basic_tests(struct mm_struct *mm, unsigned long pfn, int idx) { }
>>  static void __init pud_advanced_tests(struct mm_struct *mm,
>> @@ -412,9 +365,6 @@ static void __init pud_advanced_tests(struct mm_struct *mm,
>>  {
>>  }
>>  static void __init pud_leaf_tests(unsigned long pfn, pgprot_t prot) { }
>> -static void __init pud_huge_tests(pud_t *pudp, unsigned long pfn, pgprot_t prot)
>> -{
>> -}
>>  #endif /* CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
>>  #else  /* !CONFIG_TRANSPARENT_HUGEPAGE */
>>  static void __init pmd_basic_tests(unsigned long pfn, int idx) { }
>> @@ -433,14 +383,51 @@ static void __init pud_advanced_tests(struct mm_struct *mm,
>>  }
>>  static void __init pmd_leaf_tests(unsigned long pfn, pgprot_t prot) { }
>>  static void __init pud_leaf_tests(unsigned long pfn, pgprot_t prot) { }
>> +static void __init pmd_savedwrite_tests(unsigned long pfn, pgprot_t prot) { }
>> +#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>> +
>> +#ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
>>  static void __init pmd_huge_tests(pmd_t *pmdp, unsigned long pfn, pgprot_t prot)
>>  {
>> +	pmd_t pmd;
>> +
>> +	if (!arch_vmap_pmd_supported(prot))
>> +		return;
>> +
>> +	pr_debug("Validating PMD huge\n");
>> +	/*
>> +	 * X86 defined pmd_set_huge() verifies that the given
>> +	 * PMD is not a populated non-leaf entry.
>> +	 */
>> +	WRITE_ONCE(*pmdp, __pmd(0));
>> +	WARN_ON(!pmd_set_huge(pmdp, __pfn_to_phys(pfn), prot));
>> +	WARN_ON(!pmd_clear_huge(pmdp));
>> +	pmd = READ_ONCE(*pmdp);
>> +	WARN_ON(!pmd_none(pmd));
>>  }
>> +
>>  static void __init pud_huge_tests(pud_t *pudp, unsigned long pfn, pgprot_t prot)
>>  {
>> +	pud_t pud;
>> +
>> +	if (!arch_vmap_pud_supported(prot))
>> +		return;
>> +
>> +	pr_debug("Validating PUD huge\n");
>> +	/*
>> +	 * X86 defined pud_set_huge() verifies that the given
>> +	 * PUD is not a populated non-leaf entry.
>> +	 */
>> +	WRITE_ONCE(*pudp, __pud(0));
>> +	WARN_ON(!pud_set_huge(pudp, __pfn_to_phys(pfn), prot));
>> +	WARN_ON(!pud_clear_huge(pudp));
>> +	pud = READ_ONCE(*pudp);
>> +	WARN_ON(!pud_none(pud));
>>  }
>> -static void __init pmd_savedwrite_tests(unsigned long pfn, pgprot_t prot) { }
>> -#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>> +#else /* !CONFIG_HAVE_ARCH_HUGE_VMAP */
>> +static void __init pmd_huge_tests(pmd_t *pmdp, unsigned long pfn, pgprot_t prot) { }
>> +static void __init pud_huge_tests(pud_t *pudp, unsigned long pfn, pgprot_t prot) { }
>> +#endif /* CONFIG_HAVE_ARCH_HUGE_VMAP */
>>  
>>  static void __init p4d_basic_tests(unsigned long pfn, pgprot_t prot)
>>  {
>>
> 
> With changes to the commit message as suggested earlier.
> 
> Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
> 

Hello Shixin,

Wondering if you are planning to respin the series ?

- Anshuman
