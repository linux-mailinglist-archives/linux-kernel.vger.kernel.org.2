Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22FE440F188
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 07:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235325AbhIQFMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 01:12:32 -0400
Received: from foss.arm.com ([217.140.110.172]:48070 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229704AbhIQFM3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 01:12:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7ADF531B;
        Thu, 16 Sep 2021 22:11:01 -0700 (PDT)
Received: from [10.163.71.122] (unknown [10.163.71.122])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 89BEA3F5A1;
        Thu, 16 Sep 2021 22:10:59 -0700 (PDT)
Subject: Re: [PATCH] arm64/mm: Add pud_sect_supported()
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        suzuki.poulose@arm.com, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org
References: <1631677459-28383-1-git-send-email-anshuman.khandual@arm.com>
 <YUNt3btNlYVGDTkX@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <f268e345-1e07-54af-619f-7853c706fe0d@arm.com>
Date:   Fri, 17 Sep 2021 10:42:04 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YUNt3btNlYVGDTkX@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/16/21 9:46 PM, Catalin Marinas wrote:
> On Wed, Sep 15, 2021 at 09:14:19AM +0530, Anshuman Khandual wrote:
>> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
>> index 23505fc35324..641854f0e8ee 100644
>> --- a/arch/arm64/mm/hugetlbpage.c
>> +++ b/arch/arm64/mm/hugetlbpage.c
>> @@ -40,11 +40,10 @@ void __init arm64_hugetlb_cma_reserve(void)
>>  {
>>  	int order;
>>  
>> -#ifdef CONFIG_ARM64_4K_PAGES
>> -	order = PUD_SHIFT - PAGE_SHIFT;
>> -#else
>> -	order = CONT_PMD_SHIFT + PMD_SHIFT - PAGE_SHIFT;
>> -#endif
>> +	if (pud_sect_supported())
>> +		order = PUD_SHIFT - PAGE_SHIFT;
>> +	else
>> +		order = CONT_PMD_SHIFT + PMD_SHIFT - PAGE_SHIFT;
>>  	/*
>>  	 * HugeTLB CMA reservation is required for gigantic
>>  	 * huge pages which could not be allocated via the
>> @@ -62,8 +61,9 @@ bool arch_hugetlb_migration_supported(struct hstate *h)
>>  	size_t pagesize = huge_page_size(h);
>>  
>>  	switch (pagesize) {
>> -#ifdef CONFIG_ARM64_4K_PAGES
>> +#ifndef __PAGETABLE_PUD_FOLDED
>>  	case PUD_SIZE:
>> +		return pud_sect_supported();
>>  #endif
>>  	case PMD_SIZE:
>>  	case CONT_PMD_SIZE:
> 
> Is this the same thing? With 4K pages and 3-levels (39-bit VA), the PUD

No. These huge page sizes are different at each level for the above config.
Seems like the SOFT_OFFLINE based HugeTLB migration test, which I normally
run for all HugeTLB related changes some how missed this particular config
(4K|39V|48PA) where it mattered.

> is folded but we do have a valid PUD_SIZE == PGDIR_SIZE and different
> from PMD_SIZE. Do we disallow section mappings at the top level in this
> case? If not, we should have check for __PAGETABLE_PMD_FOLDED instead.

Right, should dont disallow such PUD_SIZE which is different from PMD_SIZE.
Will replace the check with __PAGETABLE_PMD_FOLDED.

> 
>> @@ -126,8 +126,11 @@ static inline int num_contig_ptes(unsigned long size, size_t *pgsize)
>>  	*pgsize = size;
>>  
>>  	switch (size) {
>> -#ifdef CONFIG_ARM64_4K_PAGES
>> +#ifndef __PAGETABLE_PUD_FOLDED
>>  	case PUD_SIZE:
>> +		if (pud_sect_supported())
>> +			contig_ptes = 1;
>> +		break;
>>  #endif
>>  	case PMD_SIZE:
>>  		contig_ptes = 1;
> 
> Same here.

Sure, will change.

> 
>> @@ -489,9 +492,9 @@ void huge_ptep_clear_flush(struct vm_area_struct *vma,
>>  
>>  static int __init hugetlbpage_init(void)
>>  {
>> -#ifdef CONFIG_ARM64_4K_PAGES
>> -	hugetlb_add_hstate(PUD_SHIFT - PAGE_SHIFT);
>> -#endif
>> +	if (pud_sect_supported())
>> +		hugetlb_add_hstate(PUD_SHIFT - PAGE_SHIFT);
>> +
>>  	hugetlb_add_hstate(CONT_PMD_SHIFT - PAGE_SHIFT);
>>  	hugetlb_add_hstate(PMD_SHIFT - PAGE_SHIFT);
>>  	hugetlb_add_hstate(CONT_PTE_SHIFT - PAGE_SHIFT);
>> @@ -503,8 +506,9 @@ arch_initcall(hugetlbpage_init);
>>  bool __init arch_hugetlb_valid_size(unsigned long size)
>>  {
>>  	switch (size) {
>> -#ifdef CONFIG_ARM64_4K_PAGES
>> +#ifndef __PAGETABLE_PUD_FOLDED
>>  	case PUD_SIZE:
>> +		return pud_sect_supported();
>>  #endif
>>  	case CONT_PMD_SIZE:
>>  	case PMD_SIZE:
> 
> And here.

Sure, will change.
