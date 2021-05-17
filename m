Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8191F38232E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 05:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233294AbhEQDwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 23:52:31 -0400
Received: from foss.arm.com ([217.140.110.172]:40820 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229661AbhEQDwa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 23:52:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C75F3106F;
        Sun, 16 May 2021 20:51:14 -0700 (PDT)
Received: from [192.168.0.130] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 36A2D3F73B;
        Sun, 16 May 2021 20:51:12 -0700 (PDT)
Subject: Re: [RFC] mm/thp: Update mm's MM_ANONPAGES stat in
 set_huge_zero_page()
To:     Zi Yan <ziy@nvidia.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <1620890438-9127-1-git-send-email-anshuman.khandual@arm.com>
 <1B37E0D8-2F69-45A3-9384-DC5BCE9F67A8@nvidia.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <d63a9067-258b-16ec-c5cd-d90d14793090@arm.com>
Date:   Mon, 17 May 2021 09:21:59 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1B37E0D8-2F69-45A3-9384-DC5BCE9F67A8@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/13/21 7:42 PM, Zi Yan wrote:
> On 13 May 2021, at 3:20, Anshuman Khandual wrote:
> 
>> Although the zero huge page is being shared across various processes, each
>> mapping needs to update its mm's MM_ANONPAGES stat by HPAGE_PMD_NR in order
>> to be consistent. This just updates the stats in set_huge_zero_page() after
>> the mapping gets created.
> 
> In addition, MM_ANONPAGES stats should be decreased at zap_huge_pmd() and

Right, would something like this work ?

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 63ed6b2..776984d 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1678,6 +1678,7 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
                        tlb_remove_page_size(tlb, pmd_page(orig_pmd), HPAGE_PMD_SIZE);
        } else if (is_huge_zero_pmd(orig_pmd)) {
                zap_deposited_table(tlb->mm, pmd);
+               add_mm_counter(tlb->mm, MM_ANONPAGES, -HPAGE_PMD_NR);
                spin_unlock(ptl);
                tlb_remove_page_size(tlb, pmd_page(orig_pmd), HPAGE_PMD_SIZE);
        } else {

> __split_huge_pmd_locked() when the zero huge page mapping is removed from
> a process, right?

__split_huge_pmd_locked() calls __split_huge_zero_page_pmd() which will
replace a zero huge page with multiple (HPAGE_PMD_NR) zero small pages.
Why should MM_ANONPAGES stats change for the MM when the mapping is still
out there but in normal pages now.

> 
>>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Zi Yan <ziy@nvidia.com>
>> Cc: linux-mm@kvack.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>> Should it update MM_SHMEM_PAGES instead ? Applies on latest mainline.
> 
> zero huge page is added via do_huge_pmd_anonymous_page(), I think MM_ANONPAGES
> is appropriate.

Okay, sure.

> 
>>
>>  mm/huge_memory.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 63ed6b25deaa..262703304807 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -706,6 +706,7 @@ static void set_huge_zero_page(pgtable_t pgtable, struct mm_struct *mm,
>>  	if (pgtable)
>>  		pgtable_trans_huge_deposit(mm, pmd, pgtable);
>>  	set_pmd_at(mm, haddr, pmd, entry);
>> +	add_mm_counter(mm, MM_ANONPAGES, HPAGE_PMD_NR);
>>  	mm_inc_nr_ptes(mm);
>>  }
>>
>> -- 
>> 2.20.1
> 
> 
> —
> Best Regards,
> Yan Zi
> 
