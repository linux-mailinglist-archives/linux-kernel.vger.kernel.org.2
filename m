Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8723D1E56
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 08:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbhGVF4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 01:56:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34166 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230117AbhGVF4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 01:56:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626935837;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T5yJXoswrtbBl372z9LAdEWN+q1EKTxAfgwD664hR5E=;
        b=SKDkPUPjKk2rrWt8P2f40VkiKt5yiuEcXAE/cUqu0ui/nwDqdO9ipplkx/HkKCFxCzGPaL
        f0nY8jxPI5y5N5HaUut0VxVhbnsH2ksXZGoUrCRnlQ8KCaDYoy6EMl+8tHnCA9XYTUIhjS
        /FzvAh0kqLGhUdKJ6cnrP2M8q+RHACY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-454-LpOZS3vyP86UpbiWH7jigA-1; Thu, 22 Jul 2021 02:37:15 -0400
X-MC-Unique: LpOZS3vyP86UpbiWH7jigA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 96B1A802575;
        Thu, 22 Jul 2021 06:37:14 +0000 (UTC)
Received: from [10.64.54.195] (vpn2-54-195.bne.redhat.com [10.64.54.195])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A989E5D6D1;
        Thu, 22 Jul 2021 06:37:10 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v3 07/12] mm/debug_vm_pgtable: Use struct
 pgtable_debug_args in PTE modifying tests
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        will@kernel.org, akpm@linux-foundation.org, chuhu@redhat.com,
        shan.gavin@gmail.com
References: <20210719130613.334901-1-gshan@redhat.com>
 <20210719130613.334901-8-gshan@redhat.com>
 <bfa07f56-f58c-f2c3-64e1-1cdb09dbf366@arm.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <99c73652-7294-17ff-0c4f-986b588ab022@redhat.com>
Date:   Thu, 22 Jul 2021 16:37:26 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <bfa07f56-f58c-f2c3-64e1-1cdb09dbf366@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshuman,

On 7/22/21 3:56 PM, Anshuman Khandual wrote:
> On 7/19/21 6:36 PM, Gavin Shan wrote:
>> This uses struct pgtable_debug_args in PTE modifying tests. The allocated
>> page is used as set_pte_at() is used there. The tests are skipped if
>> the allocated page doesn't exist. Besides, the unused variable @ptep
>> and @pte_aligned in debug_vm_pgtable() are dropped.
> 
> Please dont drop @ptep and @pte_aligned just yet.
> 

We need to do so. Otherwise, there are build warning raised to
complain something like 'unused variable'.

>>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>>   mm/debug_vm_pgtable.c | 75 ++++++++++++++++++++++---------------------
>>   1 file changed, 39 insertions(+), 36 deletions(-)
>>
>> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
>> index d32e55a95c55..eb6dda88e0d9 100644
>> --- a/mm/debug_vm_pgtable.c
>> +++ b/mm/debug_vm_pgtable.c
>> @@ -116,10 +116,7 @@ static void __init pte_basic_tests(struct pgtable_debug_args *args, int idx)
>>   	WARN_ON(!pte_dirty(pte_wrprotect(pte_mkdirty(pte))));
>>   }
>>   
>> -static void __init pte_advanced_tests(struct mm_struct *mm,
>> -				      struct vm_area_struct *vma, pte_t *ptep,
>> -				      unsigned long pfn, unsigned long vaddr,
>> -				      pgprot_t prot)
>> +static void __init pte_advanced_tests(struct pgtable_debug_args *args)
>>   {
>>   	pte_t pte;
>>   
>> @@ -130,33 +127,38 @@ static void __init pte_advanced_tests(struct mm_struct *mm,
>>   	 */
>>   
>>   	pr_debug("Validating PTE advanced\n");
>> -	pte = pfn_pte(pfn, prot);
>> -	set_pte_at(mm, vaddr, ptep, pte);
>> -	ptep_set_wrprotect(mm, vaddr, ptep);
>> -	pte = ptep_get(ptep);
>> +	if (args->pte_pfn == ULONG_MAX) {
>> +		pr_debug("%s: Skipped\n", __func__);
>> +		return;
>> +	}
> 
> Just return. Please dont call out "Skipped". Also this check should be
> performed before printing pr_debug("Validating PTE advanced\n"). The
> print indicates that the test has started.
> 

Sure.

>> +
>> +	pte = pfn_pte(args->pte_pfn, args->page_prot);
>> +	set_pte_at(args->mm, args->vaddr, args->ptep, pte);
>> +	ptep_set_wrprotect(args->mm, args->vaddr, args->ptep);
>> +	pte = ptep_get(args->ptep);
>>   	WARN_ON(pte_write(pte));
>> -	ptep_get_and_clear(mm, vaddr, ptep);
>> -	pte = ptep_get(ptep);
>> +	ptep_get_and_clear(args->mm, args->vaddr, args->ptep);
>> +	pte = ptep_get(args->ptep);
>>   	WARN_ON(!pte_none(pte));
>>   
>> -	pte = pfn_pte(pfn, prot);
>> +	pte = pfn_pte(args->pte_pfn, args->page_prot);
>>   	pte = pte_wrprotect(pte);
>>   	pte = pte_mkclean(pte);
>> -	set_pte_at(mm, vaddr, ptep, pte);
>> +	set_pte_at(args->mm, args->vaddr, args->ptep, pte);
>>   	pte = pte_mkwrite(pte);
>>   	pte = pte_mkdirty(pte);
>> -	ptep_set_access_flags(vma, vaddr, ptep, pte, 1);
>> -	pte = ptep_get(ptep);
>> +	ptep_set_access_flags(args->vma, args->vaddr, args->ptep, pte, 1);
>> +	pte = ptep_get(args->ptep);
>>   	WARN_ON(!(pte_write(pte) && pte_dirty(pte)));
>> -	ptep_get_and_clear_full(mm, vaddr, ptep, 1);
>> -	pte = ptep_get(ptep);
>> +	ptep_get_and_clear_full(args->mm, args->vaddr, args->ptep, 1);
>> +	pte = ptep_get(args->ptep);
>>   	WARN_ON(!pte_none(pte));
>>   
>> -	pte = pfn_pte(pfn, prot);
>> +	pte = pfn_pte(args->pte_pfn, args->page_prot);
>>   	pte = pte_mkyoung(pte);
>> -	set_pte_at(mm, vaddr, ptep, pte);
>> -	ptep_test_and_clear_young(vma, vaddr, ptep);
>> -	pte = ptep_get(ptep);
>> +	set_pte_at(args->mm, args->vaddr, args->ptep, pte);
>> +	ptep_test_and_clear_young(args->vma, args->vaddr, args->ptep);
>> +	pte = ptep_get(args->ptep);
>>   	WARN_ON(pte_young(pte));
>>   }
>>   
>> @@ -617,20 +619,24 @@ static void __init pgd_populate_tests(struct mm_struct *mm, pgd_t *pgdp,
>>   }
>>   #endif /* PAGETABLE_P4D_FOLDED */
>>   
>> -static void __init pte_clear_tests(struct mm_struct *mm, pte_t *ptep,
>> -				   unsigned long pfn, unsigned long vaddr,
>> -				   pgprot_t prot)
>> +static void __init pte_clear_tests(struct pgtable_debug_args *args)
>>   {
>> -	pte_t pte = pfn_pte(pfn, prot);
>> +	pte_t pte;
>>   
>>   	pr_debug("Validating PTE clear\n");
>> +	if (args->pte_pfn == ULONG_MAX) {
>> +		pr_debug("%s: Skipped\n", __func__);
>> +		return;
>> +	}
> 
> Just return. Please dont call out "Skipped". Also this check should be
> performed before printing pr_debug("Validating PTE clear\n"). The print
> indicates that the test has started.
> 

Sure.

>> +
>> +	pte = pfn_pte(args->pte_pfn, args->page_prot);
> 
> Please keep this unchanged and move to its original position.
> 

Ok.

>>   #ifndef CONFIG_RISCV
>>   	pte = __pte(pte_val(pte) | RANDOM_ORVALUE);
>>   #endif
>> -	set_pte_at(mm, vaddr, ptep, pte);
>> +	set_pte_at(args->mm, args->vaddr, args->ptep, pte);
>>   	barrier();
>> -	pte_clear(mm, vaddr, ptep);
>> -	pte = ptep_get(ptep);
>> +	pte_clear(args->mm, args->vaddr, args->ptep);
>> +	pte = ptep_get(args->ptep);
>>   	WARN_ON(!pte_none(pte));
>>   }
>>   
>> @@ -1150,11 +1156,10 @@ static int __init debug_vm_pgtable(void)
>>   	p4d_t *p4dp, *saved_p4dp;
>>   	pud_t *pudp, *saved_pudp;
>>   	pmd_t *pmdp, *saved_pmdp, pmd;
>> -	pte_t *ptep;
>>   	pgtable_t saved_ptep;
>>   	pgprot_t prot;
>>   	phys_addr_t paddr;
>> -	unsigned long vaddr, pte_aligned, pmd_aligned;
>> +	unsigned long vaddr, pmd_aligned;
>>   	unsigned long pud_aligned;
>>   	spinlock_t *ptl = NULL;
>>   	int idx, ret;
>> @@ -1189,10 +1194,8 @@ static int __init debug_vm_pgtable(void)
>>   	 */
>>   	paddr = __pa_symbol(&start_kernel);
>>   
>> -	pte_aligned = (paddr & PAGE_MASK) >> PAGE_SHIFT;
> 
> Please dont drop pte_aligned just yet.
> 

We need to drop the variable. Otherwise, there is build warning to
complain: 'unused variable'.

>>   	pmd_aligned = (paddr & PMD_MASK) >> PAGE_SHIFT;
>>   	pud_aligned = (paddr & PUD_MASK) >> PAGE_SHIFT;
>> -	WARN_ON(!pfn_valid(pte_aligned));
> 
> This should go into init_args() at the right place as the following,
> after evaluating it from 'start_kernel' symbol - just to be sure.
> 
> WARN_ON(!pfn_valid(args->fixed_pte_pfn))
> 

Yes.

>>   
>>   	pgdp = pgd_offset(mm, vaddr);
>>   	p4dp = p4d_alloc(mm, pgdp, vaddr);
>> @@ -1272,11 +1275,11 @@ static int __init debug_vm_pgtable(void)
>>   	 * Page table modifying tests. They need to hold
>>   	 * proper page table lock.
>>   	 */
>> -
>> -	ptep = pte_offset_map_lock(mm, pmdp, vaddr, &ptl);
>> -	pte_clear_tests(mm, ptep, pte_aligned, vaddr, prot);
>> -	pte_advanced_tests(mm, vma, ptep, pte_aligned, vaddr, prot);
>> -	pte_unmap_unlock(ptep, ptl);
>> +	ptl = pte_lockptr(args.mm, args.pmdp);
>> +	spin_lock(ptl);
>> +	pte_clear_tests(&args);
>> +	pte_advanced_tests(&args);
>> +	spin_unlock(ptl);
> 
> Why pte_offset_map_lock()/pte_unmap_unlock() has been dropped and
> spin_lock()/spin_unlock() sequence has been added ? Please dont
> change the tests in these patches.
> 

The semantics of pte_offset_map_lock() is to grab and take the lock
and return the PTE entry, which is mapped if needed. We already had
the PTE entry tracked by args->ptep in init_args(). So some of the
operations covered by pte_offset_map_lock() isn't needed any more.

>>   
>>   	ptl = pmd_lock(mm, pmdp);
>>   	pmd_clear_tests(mm, pmdp);
>>
> 

Thanks,
Gavin

