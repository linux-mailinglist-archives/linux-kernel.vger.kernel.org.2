Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC25A36F708
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 10:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbhD3IVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 04:21:19 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:17072 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbhD3IVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 04:21:18 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FWlc729JXz19M5r;
        Fri, 30 Apr 2021 16:17:59 +0800 (CST)
Received: from [10.174.176.174] (10.174.176.174) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Fri, 30 Apr 2021 16:20:24 +0800
Subject: Re: [PATCH v2 3/5] mm/huge_memory.c: add missing read-only THP
 checking in transparent_hugepage_enabled()
To:     David Hildenbrand <david@redhat.com>, <akpm@linux-foundation.org>
CC:     <ziy@nvidia.com>, <william.kucharski@oracle.com>,
        <willy@infradead.org>, <yang.shi@linux.alibaba.com>,
        <aneesh.kumar@linux.ibm.com>, <rcampbell@nvidia.com>,
        <songliubraving@fb.com>, <kirill.shutemov@linux.intel.com>,
        <riel@surriel.com>, <hannes@cmpxchg.org>, <minchan@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20210429132648.305447-1-linmiaohe@huawei.com>
 <20210429132648.305447-4-linmiaohe@huawei.com>
 <68c8c4a8-c4f8-83db-7326-dabeea74239c@redhat.com>
 <9b511ad9-0ba1-e896-4eb5-0e91ca4b97ab@huawei.com>
 <9c340151-6dbb-504c-e205-3edda6a5aff8@redhat.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <b793da18-215a-06db-1b08-55b5c0f737d9@huawei.com>
Date:   Fri, 30 Apr 2021 16:20:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <9c340151-6dbb-504c-e205-3edda6a5aff8@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.174]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/4/30 15:49, David Hildenbrand wrote:
> On 30.04.21 03:57, Miaohe Lin wrote:
>> On 2021/4/29 22:57, David Hildenbrand wrote:
>>> On 29.04.21 15:26, Miaohe Lin wrote:
>>>> Since commit 99cb0dbd47a1 ("mm,thp: add read-only THP support for
>>>> (non-shmem) FS"), read-only THP file mapping is supported. But it
>>>> forgot to add checking for it in transparent_hugepage_enabled().
>>>> To fix it, we add checking for read-only THP file mapping and also
>>>> introduce helper transhuge_vma_enabled() to check whether thp is
>>>> enabled for specified vma to reduce duplicated code.
>>>>
>>>> Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
>>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>>>> ---
>>>>    include/linux/huge_mm.h | 21 +++++++++++++++++----
>>>>    mm/huge_memory.c        |  6 ++++++
>>>>    mm/khugepaged.c         |  4 +---
>>>>    mm/shmem.c              |  3 +--
>>>>    4 files changed, 25 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>>>> index 0a526f211fec..f460b74619fc 100644
>>>> --- a/include/linux/huge_mm.h
>>>> +++ b/include/linux/huge_mm.h
>>>> @@ -115,6 +115,16 @@ extern struct kobj_attribute shmem_enabled_attr;
>>>>      extern unsigned long transparent_hugepage_flags;
>>>>    +static inline bool transhuge_vma_enabled(struct vm_area_struct *vma,
>>>> +                      unsigned long vm_flags)
>>>
>>> You're passing the vma already, why do you pass vma->vm_flags separately? It's sufficient to pass in the vma only.
>>>
>>
>> Many thanks for comment! IMO, vm_flags may not always equal to vma->vm_flags. When hugepage_vma_check()
>> is called from collapse_pte_mapped_thp, vma_flags = vma->vm_flags | VM_HUGEPAGE. So I think we should
>> pass vm_flags here.
> 
> Oh, sorry, I missed the hugepage_vma_check() user. That's unfortunate.

Yes, that's unfortunate.

> 
>>>>    static inline void prep_transhuge_page(struct page *page) {}
>>>>      static inline bool is_transparent_hugepage(struct page *page)
>>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>>> index 76ca1eb2a223..e24a96de2e37 100644
>>>> --- a/mm/huge_memory.c
>>>> +++ b/mm/huge_memory.c
>>>> @@ -68,12 +68,18 @@ bool transparent_hugepage_enabled(struct vm_area_struct *vma)
>>>>        /* The addr is used to check if the vma size fits */
>>>>        unsigned long addr = (vma->vm_end & HPAGE_PMD_MASK) - HPAGE_PMD_SIZE;
>>>>    +    if (!transhuge_vma_enabled(vma, vma->vm_flags))
>>>> +        return false;
>>>>        if (!transhuge_vma_suitable(vma, addr))
>>>>            return false;
>>>>        if (vma_is_anonymous(vma))
>>>>            return __transparent_hugepage_enabled(vma);
>>>>        if (vma_is_shmem(vma))
>>>>            return shmem_huge_enabled(vma);
>>>> +    if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) && vma->vm_file &&
>>>> +        !inode_is_open_for_write(vma->vm_file->f_inode) &&
>>>> +        (vma->vm_flags & VM_EXEC))
>>>> +        return true;
>>>
>>> Nit: I'm really wondering why we have 3 different functions that sound like they are doing the same thing
>>>
>>> transparent_hugepage_enabled(vma)
>>> transhuge_vma_enabled()
>>> transhuge_vma_suitable()
>>>
>>> Which check belongs where? Does it really have to be that complicated?
>>>
>>
>> IMO, transhuge_vma_suitable() checks whether pgoff , vm_start and vm_end is possible for thp.
>> transhuge_vma_enabled() checks whether thp is explicitly disabled through madvise.
>> And transparent_hugepage_enabled() use these helpers to get the conclusion whether thp is
>> enabled for specified vma.
>>
>> Any suggestions?
> 
> transparent_hugepage_enabled() vs. transhuge_vma_enabled() is really sub-optimal naming. I guess "transparent_hugepage_active()" would have been clearer (enabled + suitable + applicable). Cannot really give a good suggestion here on how to name transhuge_vma_enabled() differently.
> 

I think transparent_hugepage_active() sounds better too.

> 
> We now have
> 
> transparent_hugepage_enabled()
> -> transhuge_vma_enabled()
> -> __transparent_hugepage_enabled() -> transhuge_vma_enabled()
> -> shmem_huge_enabled() -> transhuge_vma_enabled()
> 
> That looks sub-optimal as well. Maybe we should have a
> 
> static inline bool file_thp_enabled(struct vma *vma)
> {
>     return transhuge_vma_enabled() &&
>            IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
>            !inode_is_open_for_write(vma->vm_file->f_inode) &&
>            (vma->vm_flags & VM_EXEC))
> }
> 
> and in transparent_hugepage_enabled() only do a
> 
> if (vma->vm_file)
>     return file_thp_enabled(vma);
> 

Really good suggestion! I would try to do this one in next version. Many thanks for your time and suggestion! :)

> 
> Or move the transhuge_vma_enabled() check completely to transparent_hugepage_enabled() if possible.
> 
