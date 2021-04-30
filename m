Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12CDE36F3C5
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 03:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbhD3BkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 21:40:21 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:17486 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhD3BkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 21:40:20 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FWZhh5KJfzPvMk;
        Fri, 30 Apr 2021 09:36:20 +0800 (CST)
Received: from [10.174.176.174] (10.174.176.174) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Fri, 30 Apr 2021 09:39:29 +0800
Subject: Re: [PATCH v2 1/5] mm/huge_memory.c: remove dedicated macro
 HPAGE_CACHE_INDEX_MASK
To:     David Hildenbrand <david@redhat.com>, <akpm@linux-foundation.org>
CC:     <ziy@nvidia.com>, <william.kucharski@oracle.com>,
        <willy@infradead.org>, <yang.shi@linux.alibaba.com>,
        <aneesh.kumar@linux.ibm.com>, <rcampbell@nvidia.com>,
        <songliubraving@fb.com>, <kirill.shutemov@linux.intel.com>,
        <riel@surriel.com>, <hannes@cmpxchg.org>, <minchan@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20210429132648.305447-1-linmiaohe@huawei.com>
 <20210429132648.305447-2-linmiaohe@huawei.com>
 <c7dab2a5-cf77-a1dd-201a-f4a5f190c4d7@redhat.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <cb8c3df7-92e1-bce6-9268-12fc10797e23@huawei.com>
Date:   Fri, 30 Apr 2021 09:39:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <c7dab2a5-cf77-a1dd-201a-f4a5f190c4d7@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.174]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/4/29 22:48, David Hildenbrand wrote:
> On 29.04.21 15:26, Miaohe Lin wrote:
>> Rewrite the pgoff checking logic to remove macro HPAGE_CACHE_INDEX_MASK
>> which is only used here to simplify the code.
>>
>> Reviewed-by: Yang Shi <shy828301@gmail.com>
>> Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>   include/linux/huge_mm.h | 6 ++----
>>   1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>> index 9626fda5efce..0a526f211fec 100644
>> --- a/include/linux/huge_mm.h
>> +++ b/include/linux/huge_mm.h
>> @@ -152,15 +152,13 @@ static inline bool __transparent_hugepage_enabled(struct vm_area_struct *vma)
>>     bool transparent_hugepage_enabled(struct vm_area_struct *vma);
>>   -#define HPAGE_CACHE_INDEX_MASK (HPAGE_PMD_NR - 1)
>> -
>>   static inline bool transhuge_vma_suitable(struct vm_area_struct *vma,
>>           unsigned long haddr)
>>   {
>>       /* Don't have to check pgoff for anonymous vma */
>>       if (!vma_is_anonymous(vma)) {
>> -        if (((vma->vm_start >> PAGE_SHIFT) & HPAGE_CACHE_INDEX_MASK) !=
>> -            (vma->vm_pgoff & HPAGE_CACHE_INDEX_MASK))
>> +        if (!IS_ALIGNED((vma->vm_start >> PAGE_SHIFT) - vma->vm_pgoff,
>> +                HPAGE_PMD_NR))
>>               return false;
> 
> I'd have used
> 
> if (!IS_ALIGNED(PHYS_PFN(vma->vm_start) - vma->vm_pgoff,
> 

It's because I want keep the code style consistent with hugepage_vma_check().
There is similiar code in hugepage_vma_check():

	return IS_ALIGNED((vma->vm_start >> PAGE_SHIFT) - vma->vm_pgoff,
			HPAGE_PMD_NR);

> Reviewed-by: David Hildenbrand <david@redhat.com>

Many thanks for review!

> 

