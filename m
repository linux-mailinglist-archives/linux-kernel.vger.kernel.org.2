Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68D293D3116
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 03:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232978AbhGWATg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 20:19:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34442 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232730AbhGWATe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 20:19:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627002008;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fgDr0yJetS9zOP53EO5TTRWKZaWog8b4cwZiRW0fLI8=;
        b=fkpqUHkKYAEFBb/uKOVAwDrfTFfkeSmAbF12W28EWmOTCQ9SBBiR70KVnWTS/NZdpicUpN
        a99wIsFlTe2Kwo24zZVYS/9ENICyS/o9uw6Aqk047yerAhZH0lDPULG47TsGEy8M9keXDC
        6qSR0lz6f6lV2uhCGwvz93QnRbWsYtw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-555-b-RF2xeUOuaBWsgWodFhMQ-1; Thu, 22 Jul 2021 21:00:04 -0400
X-MC-Unique: b-RF2xeUOuaBWsgWodFhMQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 535E6800C78;
        Fri, 23 Jul 2021 01:00:03 +0000 (UTC)
Received: from [10.64.54.195] (vpn2-54-195.bne.redhat.com [10.64.54.195])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6EC1C10013D6;
        Fri, 23 Jul 2021 00:59:58 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v3 08/12] mm/debug_vm_pgtable: Use struct
 pgtable_debug_args in PMD modifying tests
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        will@kernel.org, akpm@linux-foundation.org, chuhu@redhat.com,
        shan.gavin@gmail.com
References: <20210719130613.334901-1-gshan@redhat.com>
 <20210719130613.334901-9-gshan@redhat.com>
 <52a61d4a-f93d-af9e-4a34-d8ea7c476838@arm.com>
 <e2707943-8645-a6d5-be15-7cf56791fedb@redhat.com>
 <876f9722-c307-560d-5efd-3613c312c7bd@arm.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <8d8daf85-0015-4221-aad5-5baa03e3f699@redhat.com>
Date:   Fri, 23 Jul 2021 11:00:15 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <876f9722-c307-560d-5efd-3613c312c7bd@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshuman,

On 7/22/21 5:11 PM, Anshuman Khandual wrote:
> On 7/22/21 12:11 PM, Gavin Shan wrote:
>> On 7/22/21 3:45 PM, Anshuman Khandual wrote:
>>> On 7/19/21 6:36 PM, Gavin Shan wrote:
>>>> This uses struct pgtable_debug_args in PMD modifying tests. The allocated
>>>> huge page is used when set_pmd_at() is used. The corresponding tests
>>>> are skipped if the huge page doesn't exist. Besides, the unused variable
>>>> @pmd_aligned in debug_vm_pgtable() is dropped.
>>>
>>> Please dont drop @pmd_aligned just yet.
>>>
>>
>> We need do so. Otherwise, there is build warning to complain
>> something like 'unused variable' after this patch is applied.
>>
>>>>
>>>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>>>> ---
>>>>    mm/debug_vm_pgtable.c | 102 ++++++++++++++++++++----------------------
>>>>    1 file changed, 48 insertions(+), 54 deletions(-)
>>>>
>>>> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
>>>> index eb6dda88e0d9..cec3cbf99a6b 100644
>>>> --- a/mm/debug_vm_pgtable.c
>>>> +++ b/mm/debug_vm_pgtable.c
>>>> @@ -213,54 +213,54 @@ static void __init pmd_basic_tests(struct pgtable_debug_args *args, int idx)
>>>>        WARN_ON(!pmd_bad(pmd_mkhuge(pmd)));
>>>>    }
>>>>    -static void __init pmd_advanced_tests(struct mm_struct *mm,
>>>> -                      struct vm_area_struct *vma, pmd_t *pmdp,
>>>> -                      unsigned long pfn, unsigned long vaddr,
>>>> -                      pgprot_t prot, pgtable_t pgtable)
>>>> +static void __init pmd_advanced_tests(struct pgtable_debug_args *args)
>>>>    {
>>>>        pmd_t pmd;
>>>> +    unsigned long vaddr = (args->vaddr & HPAGE_PMD_MASK);
>>>>          if (!has_transparent_hugepage())
>>>>            return;
>>>>          pr_debug("Validating PMD advanced\n");
>>>> -    /* Align the address wrt HPAGE_PMD_SIZE */
>>>> -    vaddr &= HPAGE_PMD_MASK;
>>>
>>> Please just leave these unchanged. If has_transparent_hugepage() evaluates
>>> negative, it skips the masking operation. As mentioned earlier please avoid
>>> changing the test in any manner during these transition patches.
>>>
>>
>> Ok.
>>
>>>> +    if (args->pmd_pfn == ULONG_MAX) {
>>>> +        pr_debug("%s: Skipped\n", __func__);
>>>> +        return;
>>>> +    }
>>>
>>> Just return. Please dont call out "Skipped".
>>>
>>
>> Ok.
>>
>>>>    -    pgtable_trans_huge_deposit(mm, pmdp, pgtable);
>>>> +    pgtable_trans_huge_deposit(args->mm, args->pmdp, args->start_ptep);
>>>>    -    pmd = pfn_pmd(pfn, prot);
>>>> -    set_pmd_at(mm, vaddr, pmdp, pmd);
>>>> -    pmdp_set_wrprotect(mm, vaddr, pmdp);
>>>> -    pmd = READ_ONCE(*pmdp);
>>>> +    pmd = pfn_pmd(args->pmd_pfn, args->page_prot);
>>>> +    set_pmd_at(args->mm, vaddr, args->pmdp, pmd);
>>>> +    pmdp_set_wrprotect(args->mm, vaddr, args->pmdp);
>>>> +    pmd = READ_ONCE(*(args->pmdp));
>>>>        WARN_ON(pmd_write(pmd));
>>>> -    pmdp_huge_get_and_clear(mm, vaddr, pmdp);
>>>> -    pmd = READ_ONCE(*pmdp);
>>>> +    pmdp_huge_get_and_clear(args->mm, vaddr, args->pmdp);
>>>> +    pmd = READ_ONCE(*(args->pmdp));
>>>>        WARN_ON(!pmd_none(pmd));
>>>>    -    pmd = pfn_pmd(pfn, prot);
>>>> +    pmd = pfn_pmd(args->pmd_pfn, args->page_prot);
>>>>        pmd = pmd_wrprotect(pmd);
>>>>        pmd = pmd_mkclean(pmd);
>>>> -    set_pmd_at(mm, vaddr, pmdp, pmd);
>>>> +    set_pmd_at(args->mm, vaddr, args->pmdp, pmd);
>>>>        pmd = pmd_mkwrite(pmd);
>>>>        pmd = pmd_mkdirty(pmd);
>>>> -    pmdp_set_access_flags(vma, vaddr, pmdp, pmd, 1);
>>>> -    pmd = READ_ONCE(*pmdp);
>>>> +    pmdp_set_access_flags(args->vma, vaddr, args->pmdp, pmd, 1);
>>>> +    pmd = READ_ONCE(*(args->pmdp));
>>>>        WARN_ON(!(pmd_write(pmd) && pmd_dirty(pmd)));
>>>> -    pmdp_huge_get_and_clear_full(vma, vaddr, pmdp, 1);
>>>> -    pmd = READ_ONCE(*pmdp);
>>>> +    pmdp_huge_get_and_clear_full(args->vma, vaddr, args->pmdp, 1);
>>>> +    pmd = READ_ONCE(*(args->pmdp));
>>>>        WARN_ON(!pmd_none(pmd));
>>>>    -    pmd = pmd_mkhuge(pfn_pmd(pfn, prot));
>>>> +    pmd = pmd_mkhuge(pfn_pmd(args->pmd_pfn, args->page_prot));
>>>>        pmd = pmd_mkyoung(pmd);
>>>> -    set_pmd_at(mm, vaddr, pmdp, pmd);
>>>> -    pmdp_test_and_clear_young(vma, vaddr, pmdp);
>>>> -    pmd = READ_ONCE(*pmdp);
>>>> +    set_pmd_at(args->mm, vaddr, args->pmdp, pmd);
>>>> +    pmdp_test_and_clear_young(args->vma, vaddr, args->pmdp);
>>>> +    pmd = READ_ONCE(*(args->pmdp));
>>>>        WARN_ON(pmd_young(pmd));
>>>>          /*  Clear the pte entries  */
>>>> -    pmdp_huge_get_and_clear(mm, vaddr, pmdp);
>>>> -    pgtable = pgtable_trans_huge_withdraw(mm, pmdp);
>>>> +    pmdp_huge_get_and_clear(args->mm, vaddr, args->pmdp);
>>>> +    pgtable_trans_huge_withdraw(args->mm, args->pmdp);
>>>>    }
>>>>      static void __init pmd_leaf_tests(struct pgtable_debug_args *args)
>>>> @@ -417,12 +417,7 @@ static void __init pud_leaf_tests(struct pgtable_debug_args *args) { }
>>>>    #else  /* !CONFIG_TRANSPARENT_HUGEPAGE */
>>>>    static void __init pmd_basic_tests(struct pgtable_debug_args *args, int idx) { }
>>>>    static void __init pud_basic_tests(struct pgtable_debug_args *args, int idx) { }
>>>> -static void __init pmd_advanced_tests(struct mm_struct *mm,
>>>> -                      struct vm_area_struct *vma, pmd_t *pmdp,
>>>> -                      unsigned long pfn, unsigned long vaddr,
>>>> -                      pgprot_t prot, pgtable_t pgtable)
>>>> -{
>>>> -}
>>>> +static void __init pmd_advanced_tests(struct pgtable_debug_args *args) { }
>>>>    static void __init pud_advanced_tests(struct mm_struct *mm,
>>>>                          struct vm_area_struct *vma, pud_t *pudp,
>>>>                          unsigned long pfn, unsigned long vaddr,
>>>> @@ -435,11 +430,11 @@ static void __init pmd_savedwrite_tests(struct pgtable_debug_args *args) { }
>>>>    #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>>>>      #ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
>>>> -static void __init pmd_huge_tests(pmd_t *pmdp, unsigned long pfn, pgprot_t prot)
>>>> +static void __init pmd_huge_tests(struct pgtable_debug_args *args)
>>>>    {
>>>>        pmd_t pmd;
>>>>    -    if (!arch_vmap_pmd_supported(prot))
>>>> +    if (!arch_vmap_pmd_supported(args->page_prot))
>>>>            return;
>>>>          pr_debug("Validating PMD huge\n");
>>>> @@ -447,10 +442,11 @@ static void __init pmd_huge_tests(pmd_t *pmdp, unsigned long pfn, pgprot_t prot)
>>>>         * X86 defined pmd_set_huge() verifies that the given
>>>>         * PMD is not a populated non-leaf entry.
>>>>         */
>>>> -    WRITE_ONCE(*pmdp, __pmd(0));
>>>> -    WARN_ON(!pmd_set_huge(pmdp, __pfn_to_phys(pfn), prot));
>>>> -    WARN_ON(!pmd_clear_huge(pmdp));
>>>> -    pmd = READ_ONCE(*pmdp);
>>>> +    WRITE_ONCE(*(args->pmdp), __pmd(0));
>>>
>>> Possible extra braces.
>>>
>>
>> Will drop it in v4, thanks!
>>
>>>> +    WARN_ON(!pmd_set_huge(args->pmdp, __pfn_to_phys(args->fixed_pmd_pfn),
>>>> +                  args->page_prot));
>>>
>>> Dont break the line.
>>>
>>
>> Ok.
>>
>>>> +    WARN_ON(!pmd_clear_huge(args->pmdp));
>>>> +    pmd = READ_ONCE(*(args->pmdp));
>>>>        WARN_ON(!pmd_none(pmd));
>>>>    }
>>>>    @@ -473,7 +469,7 @@ static void __init pud_huge_tests(pud_t *pudp, unsigned long pfn, pgprot_t prot)
>>>>        WARN_ON(!pud_none(pud));
>>>>    }
>>>>    #else /* !CONFIG_HAVE_ARCH_HUGE_VMAP */
>>>> -static void __init pmd_huge_tests(pmd_t *pmdp, unsigned long pfn, pgprot_t prot) { }
>>>> +static void __init pmd_huge_tests(struct pgtable_debug_args *args) { }
>>>>    static void __init pud_huge_tests(pud_t *pudp, unsigned long pfn, pgprot_t prot) { }
>>>>    #endif /* CONFIG_HAVE_ARCH_HUGE_VMAP */
>>>>    @@ -640,20 +636,19 @@ static void __init pte_clear_tests(struct pgtable_debug_args *args)
>>>>        WARN_ON(!pte_none(pte));
>>>>    }
>>>>    -static void __init pmd_clear_tests(struct mm_struct *mm, pmd_t *pmdp)
>>>> +static void __init pmd_clear_tests(struct pgtable_debug_args *args)
>>>>    {
>>>> -    pmd_t pmd = READ_ONCE(*pmdp);
>>>> +    pmd_t pmd = READ_ONCE(*(args->pmdp));
>>>>          pr_debug("Validating PMD clear\n");
>>>>        pmd = __pmd(pmd_val(pmd) | RANDOM_ORVALUE);
>>>> -    WRITE_ONCE(*pmdp, pmd);
>>>> -    pmd_clear(pmdp);
>>>> -    pmd = READ_ONCE(*pmdp);
>>>> +    WRITE_ONCE(*(args->pmdp), pmd);
>>>> +    pmd_clear(args->pmdp);
>>>> +    pmd = READ_ONCE(*(args->pmdp));
>>>>        WARN_ON(!pmd_none(pmd));
>>>>    }
>>>>    -static void __init pmd_populate_tests(struct mm_struct *mm, pmd_t *pmdp,
>>>> -                      pgtable_t pgtable)
>>>> +static void __init pmd_populate_tests(struct pgtable_debug_args *args)
>>>>    {
>>>>        pmd_t pmd;
>>>>    @@ -662,8 +657,8 @@ static void __init pmd_populate_tests(struct mm_struct *mm, pmd_t *pmdp,
>>>>         * This entry points to next level page table page.
>>>>         * Hence this must not qualify as pmd_bad().
>>>>         */
>>>> -    pmd_populate(mm, pmdp, pgtable);
>>>> -    pmd = READ_ONCE(*pmdp);
>>>> +    pmd_populate(args->mm, args->pmdp, args->start_ptep);
>>>> +    pmd = READ_ONCE(*(args->pmdp));
>>>>        WARN_ON(pmd_bad(pmd));
>>>>    }
>>>>    @@ -1159,7 +1154,7 @@ static int __init debug_vm_pgtable(void)
>>>>        pgtable_t saved_ptep;
>>>>        pgprot_t prot;
>>>>        phys_addr_t paddr;
>>>> -    unsigned long vaddr, pmd_aligned;
>>>> +    unsigned long vaddr;
>>>>        unsigned long pud_aligned;
>>>>        spinlock_t *ptl = NULL;
>>>>        int idx, ret;
>>>> @@ -1194,7 +1189,6 @@ static int __init debug_vm_pgtable(void)
>>>>         */
>>>>        paddr = __pa_symbol(&start_kernel);
>>>>    -    pmd_aligned = (paddr & PMD_MASK) >> PAGE_SHIFT;
>>>
>>> Please dont drop these just yet and wait until [PATCH 11/12].
>>>
>>
>> Otherwise, it causes build warning: 'unused variable'.
> 
> Why ? Just the evaluation of 'pmd_aligned' from 'paddr' should
> be enough to avoid such warning. 'pmd_aligned' need not be used
> afterwards.
> 

It's not enough to avoid the warning. I apply the patches till
this one (PATCH[v3 08/12]) and have additional code to keep
@pmd_aligned, then I run into build warning as below:

diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index cec3cbf99a6b..961c9bb6fc7c 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -1154,7 +1154,7 @@ static int __init debug_vm_pgtable(void)
         pgtable_t saved_ptep;
         pgprot_t prot;
         phys_addr_t paddr;
-       unsigned long vaddr;
+       unsigned long vaddr, pmd_aligned;
         unsigned long pud_aligned;
         spinlock_t *ptl = NULL;
         int idx, ret;
@@ -1189,6 +1189,7 @@ static int __init debug_vm_pgtable(void)
          */
         paddr = __pa_symbol(&start_kernel);
  
+       pmd_aligned = (paddr & PMD_MASK) >> PAGE_SHIFT;
         pud_aligned = (paddr & PUD_MASK) >> PAGE_SHIFT;
  
         pgdp = pgd_offset(mm, vaddr);

[gwshan@gshan l]$ make W=1 mm/debug_vm_pgtable.o
      :
mm/debug_vm_pgtable.c: In function ‘debug_vm_pgtable’:
mm/debug_vm_pgtable.c:1157:23: warning: variable ‘pmd_aligned’ set but not used [-Wunused-but-set-variable]
  1157 |  unsigned long vaddr, pmd_aligned;
       |                       ^~~~~~~~~~~


By the way, 0-day is trying to build kernel with "W=1". It means the
build warnings will be reported by 0-day if the unused variables aren't
dropped from individual patches. It makes the review a bit harder. However,
we still need to keep each individual patch complete to make 'git bisect'
friendly.

Thanks,
Gavin

