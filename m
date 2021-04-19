Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC208363B4E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 08:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237249AbhDSGNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 02:13:00 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:17011 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbhDSGM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 02:12:59 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FNxGt2rGlzPqhD;
        Mon, 19 Apr 2021 14:09:26 +0800 (CST)
Received: from [10.174.177.208] (10.174.177.208) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Mon, 19 Apr 2021 14:12:23 +0800
Subject: Re: [PATCH -next v2 1/2] mm/debug_vm_pgtable: Move
 {pmd/pud}_huge_tests out of CONFIG_TRANSPARENT_HUGEPAGE
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210406044900.2178705-1-liushixin2@huawei.com>
 <4f290e6e-0e44-8f9a-52e8-1e113695abbb@arm.com>
 <a0962789-9238-9900-c7cb-41c41eb1d916@arm.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
From:   Liu Shixin <liushixin2@huawei.com>
Message-ID: <bb366c97-fa17-48dc-c594-b79d6256b23c@huawei.com>
Date:   Mon, 19 Apr 2021 14:12:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <a0962789-9238-9900-c7cb-41c41eb1d916@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.208]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your advice. I will fix these patches and resend them as soon as possilble.


On 2021/4/19 11:30, Anshuman Khandual wrote:
>
> On 4/9/21 9:35 AM, Anshuman Khandual wrote:
>> On 4/6/21 10:18 AM, Shixin Liu wrote:
>>> v1->v2:
>>> Modified the commit message.
>> Please avoid change log in the commit message, it should be after '---'
>> below the SOB statement.
>>
>>> The functions {pmd/pud}_set_huge and {pmd/pud}_clear_huge ars not dependent on THP.
>> typo 							   ^^^^^ s/ars/are
>>
>> Also there is a checkpatch.pl warning.
>>
>> WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
>> #10: 
>> The functions {pmd/pud}_set_huge and {pmd/pud}_clear_huge ars not dependent on THP.
>>
>> total: 0 errors, 1 warnings, 121 lines checked
>>
>> As I had mentioned in the earlier version, the commit message should be some
>> thing like ..
>>
>> ----
>> The functions {pmd/pud}_set_huge and {pmd/pud}_clear_huge are not dependent
>> on THP. Hence move {pmd/pud}_huge_tests out of CONFIG_TRANSPARENT_HUGEPAGE.
>> ----
>>
>>> Signed-off-by: Shixin Liu <liushixin2@huawei.com>
>>> ---
>>>  mm/debug_vm_pgtable.c | 91 +++++++++++++++++++------------------------
>>>  1 file changed, 39 insertions(+), 52 deletions(-)
>>>
>>> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
>>> index 05efe98a9ac2..d3cf178621d9 100644
>>> --- a/mm/debug_vm_pgtable.c
>>> +++ b/mm/debug_vm_pgtable.c
>>> @@ -242,29 +242,6 @@ static void __init pmd_leaf_tests(unsigned long pfn, pgprot_t prot)
>>>  	WARN_ON(!pmd_leaf(pmd));
>>>  }
>>>  
>>> -#ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
>>> -static void __init pmd_huge_tests(pmd_t *pmdp, unsigned long pfn, pgprot_t prot)
>>> -{
>>> -	pmd_t pmd;
>>> -
>>> -	if (!arch_vmap_pmd_supported(prot))
>>> -		return;
>>> -
>>> -	pr_debug("Validating PMD huge\n");
>>> -	/*
>>> -	 * X86 defined pmd_set_huge() verifies that the given
>>> -	 * PMD is not a populated non-leaf entry.
>>> -	 */
>>> -	WRITE_ONCE(*pmdp, __pmd(0));
>>> -	WARN_ON(!pmd_set_huge(pmdp, __pfn_to_phys(pfn), prot));
>>> -	WARN_ON(!pmd_clear_huge(pmdp));
>>> -	pmd = READ_ONCE(*pmdp);
>>> -	WARN_ON(!pmd_none(pmd));
>>> -}
>>> -#else /* CONFIG_HAVE_ARCH_HUGE_VMAP */
>>> -static void __init pmd_huge_tests(pmd_t *pmdp, unsigned long pfn, pgprot_t prot) { }
>>> -#endif /* CONFIG_HAVE_ARCH_HUGE_VMAP */
>>> -
>>>  static void __init pmd_savedwrite_tests(unsigned long pfn, pgprot_t prot)
>>>  {
>>>  	pmd_t pmd = pfn_pmd(pfn, prot);
>>> @@ -379,30 +356,6 @@ static void __init pud_leaf_tests(unsigned long pfn, pgprot_t prot)
>>>  	pud = pud_mkhuge(pud);
>>>  	WARN_ON(!pud_leaf(pud));
>>>  }
>>> -
>>> -#ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
>>> -static void __init pud_huge_tests(pud_t *pudp, unsigned long pfn, pgprot_t prot)
>>> -{
>>> -	pud_t pud;
>>> -
>>> -	if (!arch_vmap_pud_supported(prot))
>>> -		return;
>>> -
>>> -	pr_debug("Validating PUD huge\n");
>>> -	/*
>>> -	 * X86 defined pud_set_huge() verifies that the given
>>> -	 * PUD is not a populated non-leaf entry.
>>> -	 */
>>> -	WRITE_ONCE(*pudp, __pud(0));
>>> -	WARN_ON(!pud_set_huge(pudp, __pfn_to_phys(pfn), prot));
>>> -	WARN_ON(!pud_clear_huge(pudp));
>>> -	pud = READ_ONCE(*pudp);
>>> -	WARN_ON(!pud_none(pud));
>>> -}
>>> -#else /* !CONFIG_HAVE_ARCH_HUGE_VMAP */
>>> -static void __init pud_huge_tests(pud_t *pudp, unsigned long pfn, pgprot_t prot) { }
>>> -#endif /* !CONFIG_HAVE_ARCH_HUGE_VMAP */
>>> -
>>>  #else  /* !CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
>>>  static void __init pud_basic_tests(struct mm_struct *mm, unsigned long pfn, int idx) { }
>>>  static void __init pud_advanced_tests(struct mm_struct *mm,
>>> @@ -412,9 +365,6 @@ static void __init pud_advanced_tests(struct mm_struct *mm,
>>>  {
>>>  }
>>>  static void __init pud_leaf_tests(unsigned long pfn, pgprot_t prot) { }
>>> -static void __init pud_huge_tests(pud_t *pudp, unsigned long pfn, pgprot_t prot)
>>> -{
>>> -}
>>>  #endif /* CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
>>>  #else  /* !CONFIG_TRANSPARENT_HUGEPAGE */
>>>  static void __init pmd_basic_tests(unsigned long pfn, int idx) { }
>>> @@ -433,14 +383,51 @@ static void __init pud_advanced_tests(struct mm_struct *mm,
>>>  }
>>>  static void __init pmd_leaf_tests(unsigned long pfn, pgprot_t prot) { }
>>>  static void __init pud_leaf_tests(unsigned long pfn, pgprot_t prot) { }
>>> +static void __init pmd_savedwrite_tests(unsigned long pfn, pgprot_t prot) { }
>>> +#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>>> +
>>> +#ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
>>>  static void __init pmd_huge_tests(pmd_t *pmdp, unsigned long pfn, pgprot_t prot)
>>>  {
>>> +	pmd_t pmd;
>>> +
>>> +	if (!arch_vmap_pmd_supported(prot))
>>> +		return;
>>> +
>>> +	pr_debug("Validating PMD huge\n");
>>> +	/*
>>> +	 * X86 defined pmd_set_huge() verifies that the given
>>> +	 * PMD is not a populated non-leaf entry.
>>> +	 */
>>> +	WRITE_ONCE(*pmdp, __pmd(0));
>>> +	WARN_ON(!pmd_set_huge(pmdp, __pfn_to_phys(pfn), prot));
>>> +	WARN_ON(!pmd_clear_huge(pmdp));
>>> +	pmd = READ_ONCE(*pmdp);
>>> +	WARN_ON(!pmd_none(pmd));
>>>  }
>>> +
>>>  static void __init pud_huge_tests(pud_t *pudp, unsigned long pfn, pgprot_t prot)
>>>  {
>>> +	pud_t pud;
>>> +
>>> +	if (!arch_vmap_pud_supported(prot))
>>> +		return;
>>> +
>>> +	pr_debug("Validating PUD huge\n");
>>> +	/*
>>> +	 * X86 defined pud_set_huge() verifies that the given
>>> +	 * PUD is not a populated non-leaf entry.
>>> +	 */
>>> +	WRITE_ONCE(*pudp, __pud(0));
>>> +	WARN_ON(!pud_set_huge(pudp, __pfn_to_phys(pfn), prot));
>>> +	WARN_ON(!pud_clear_huge(pudp));
>>> +	pud = READ_ONCE(*pudp);
>>> +	WARN_ON(!pud_none(pud));
>>>  }
>>> -static void __init pmd_savedwrite_tests(unsigned long pfn, pgprot_t prot) { }
>>> -#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>>> +#else /* !CONFIG_HAVE_ARCH_HUGE_VMAP */
>>> +static void __init pmd_huge_tests(pmd_t *pmdp, unsigned long pfn, pgprot_t prot) { }
>>> +static void __init pud_huge_tests(pud_t *pudp, unsigned long pfn, pgprot_t prot) { }
>>> +#endif /* CONFIG_HAVE_ARCH_HUGE_VMAP */
>>>  
>>>  static void __init p4d_basic_tests(unsigned long pfn, pgprot_t prot)
>>>  {
>>>
>> With changes to the commit message as suggested earlier.
>>
>> Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>
> Hello Shixin,
>
> Wondering if you are planning to respin the series ?
>
> - Anshuman
> .
>

