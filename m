Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE35F3D88F0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 09:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234399AbhG1HiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 03:38:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30407 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232691AbhG1HiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 03:38:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627457878;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=65Z8ZWIRBkX0VRMC+qLtByPlgxjiVH76+vN5XvSW6MQ=;
        b=NHZ1DnHeLX24npvJUJlLKOWBtaE4+M2gJAuFtuANaUOESDu0CPkkg5qZlzCvRsNmCFq6hj
        vuOYSHxciVHGHUqa78TYdOWon8qj7cphzO2UzJpVX7SHdVkGKS/vmg9+Q3U3d8IBjXeteF
        kgK0eq4AM19KjMMh/JSALJmxi1eOI9k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-2UQmif5RMlKfIAAn1RswgA-1; Wed, 28 Jul 2021 03:37:55 -0400
X-MC-Unique: 2UQmif5RMlKfIAAn1RswgA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 26C9C107ACF5;
        Wed, 28 Jul 2021 07:37:53 +0000 (UTC)
Received: from [10.64.54.184] (vpn2-54-184.bne.redhat.com [10.64.54.184])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B34EB60862;
        Wed, 28 Jul 2021 07:37:48 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v4 01/12] mm/debug_vm_pgtable: Introduce struct
 pgtable_debug_args
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, gerald.schaefer@linux.ibm.com,
        aneesh.kumar@linux.ibm.com, christophe.leroy@csgroup.eu,
        cai@lca.pw, catalin.marinas@arm.com, will@kernel.org,
        akpm@linux-foundation.org, chuhu@redhat.com, shan.gavin@gmail.com
References: <20210727061401.592616-1-gshan@redhat.com>
 <20210727061401.592616-2-gshan@redhat.com>
 <9977fea4-ff36-390a-3a5a-58f088dab111@arm.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <e80d90d6-0ce0-72a6-7631-6815020cd419@redhat.com>
Date:   Wed, 28 Jul 2021 17:38:01 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <9977fea4-ff36-390a-3a5a-58f088dab111@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshuman,

On 7/28/21 5:32 PM, Anshuman Khandual wrote:
> On 7/27/21 11:43 AM, Gavin Shan wrote:
>> In debug_vm_pgtable(), there are many local variables introduced to
>> track the needed information and they are passed to the functions for
>> various test cases. It'd better to introduce a struct as place holder
>> for these information. With it, what the tests functions need is the
>> struct. In this way, the code is simplified and easier to be maintained.
>>
>> Besides, set_xxx_at() could access the data on the corresponding pages
>> in the page table modifying tests. So the accessed pages in the tests
>> should have been allocated from buddy. Otherwise, we're accessing pages
>> that aren't owned by us. This causes issues like page flag corruption
>> or kernel crash on accessing unmapped page when CONFIG_DEBUG_PAGEALLOC
>> is enabled.
>>
>> This introduces "struct pgtable_debug_args". The struct is initialized
>> and destroyed, but the information in the struct isn't used yet. It will
>> be used in subsequent patches.
>>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>>   mm/debug_vm_pgtable.c | 280 +++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 279 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
>> index 1c922691aa61..8c7361643166 100644
>> --- a/mm/debug_vm_pgtable.c
>> +++ b/mm/debug_vm_pgtable.c
>> @@ -58,6 +58,37 @@
>>   #define RANDOM_ORVALUE (GENMASK(BITS_PER_LONG - 1, 0) & ~ARCH_SKIP_MASK)
>>   #define RANDOM_NZVALUE	GENMASK(7, 0)
>>   
>> +struct pgtable_debug_args {
>> +	struct mm_struct	*mm;
>> +	struct vm_area_struct	*vma;
>> +
>> +	pgd_t			*pgdp;
>> +	p4d_t			*p4dp;
>> +	pud_t			*pudp;
>> +	pmd_t			*pmdp;
>> +	pte_t			*ptep;
>> +
>> +	p4d_t			*start_p4dp;
>> +	pud_t			*start_pudp;
>> +	pmd_t			*start_pmdp;
>> +	pgtable_t		start_ptep;
>> +
>> +	unsigned long		vaddr;
>> +	pgprot_t		page_prot;
>> +	pgprot_t		page_prot_none;
>> +
>> +	bool			is_contiguous_page;
>> +	unsigned long		pud_pfn;
>> +	unsigned long		pmd_pfn;
>> +	unsigned long		pte_pfn;
>> +
>> +	unsigned long		fixed_pgd_pfn;
>> +	unsigned long		fixed_p4d_pfn;
>> +	unsigned long		fixed_pud_pfn;
>> +	unsigned long		fixed_pmd_pfn;
>> +	unsigned long		fixed_pte_pfn;
>> +};
>> +
>>   static void __init pte_basic_tests(unsigned long pfn, int idx)
>>   {
>>   	pgprot_t prot = protection_map[idx];
>> @@ -955,8 +986,249 @@ static unsigned long __init get_random_vaddr(void)
>>   	return random_vaddr;
>>   }
>>   
>> +static void __init destroy_args(struct pgtable_debug_args *args)
>> +{
>> +	struct page *page = NULL;
>> +
>> +	/* Free (huge) page */
>> +	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
>> +	    IS_ENABLED(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD) &&
>> +	    has_transparent_hugepage() &&
>> +	    args->pud_pfn != ULONG_MAX) {
>> +		if (args->is_contiguous_page) {
>> +			free_contig_range(args->pud_pfn,
>> +					  (1 << (HPAGE_PUD_SHIFT - PAGE_SHIFT)));
>> +		} else {
>> +			page = pfn_to_page(args->pud_pfn);
>> +			__free_pages(page, HPAGE_PUD_SHIFT - PAGE_SHIFT);
>> +		}
>> +
>> +		args->pud_pfn = ULONG_MAX;
>> +		args->pmd_pfn = ULONG_MAX;
>> +		args->pte_pfn = ULONG_MAX;
>> +	}
>> +
>> +	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
>> +	    has_transparent_hugepage() &&
>> +	    args->pmd_pfn != ULONG_MAX) {
>> +		if (args->is_contiguous_page) {
>> +			free_contig_range(args->pmd_pfn, (1 << HPAGE_PMD_ORDER));
>> +		} else {
>> +			page = pfn_to_page(args->pmd_pfn);
>> +			__free_pages(page, HPAGE_PMD_ORDER);
>> +		}
>> +
>> +		args->pmd_pfn = ULONG_MAX;
>> +		args->pte_pfn = ULONG_MAX;
>> +	}
>> +
>> +	if (args->pte_pfn != ULONG_MAX) {
>> +		page = pfn_to_page(args->pte_pfn);
>> +		__free_pages(page, 0);
>> +	}
>> +
>> +	/* Free page table entries */
>> +	if (args->start_ptep) {
>> +		pte_free(args->mm, args->start_ptep);
>> +		mm_dec_nr_ptes(args->mm);
>> +	}
>> +
>> +	if (args->start_pmdp) {
>> +		pmd_free(args->mm, args->start_pmdp);
>> +		mm_dec_nr_pmds(args->mm);
>> +	}
>> +
>> +	if (args->start_pudp) {
>> +		pud_free(args->mm, args->start_pudp);
>> +		mm_dec_nr_puds(args->mm);
>> +	}
>> +
>> +	if (args->start_p4dp)
>> +		p4d_free(args->mm, args->p4dp);
> 
> 				     ^^^^ s/args->p4dp/args->start_p4dp ?
> 

Yes, It should be "args->start_p4dp" here. I will correct it in v5
after you finish review on v4.

Thanks,
Gavin

