Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 999BA36E321
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 04:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234549AbhD2CB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 22:01:28 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:17068 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbhD2CB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 22:01:27 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FVzDM1Xx1z16N0m;
        Thu, 29 Apr 2021 09:58:11 +0800 (CST)
Received: from [10.174.176.174] (10.174.176.174) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Thu, 29 Apr 2021 10:00:34 +0800
Subject: Re: [PATCH 3/5] mm/huge_memory.c: add missing read-only THP checking
 in transparent_hugepage_enabled()
To:     Yang Shi <shy828301@gmail.com>
CC:     Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
        <william.kucharski@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Yang Shi" <yang.shi@linux.alibaba.com>,
        <aneesh.kumar@linux.ibm.com>,
        "Ralph Campbell" <rcampbell@nvidia.com>,
        Song Liu <songliubraving@fb.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Rik van Riel <riel@surriel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Minchan Kim <minchan@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
References: <20210427133214.2270207-1-linmiaohe@huawei.com>
 <20210427133214.2270207-4-linmiaohe@huawei.com>
 <CAHbLzkrBAtTM8aE_pM4ASQ6cGyfPcs7_7HPJLCd9T24VyqU5wQ@mail.gmail.com>
 <1fa95721-2ae0-af5f-b2e4-cdb430ebc263@huawei.com>
 <CAHbLzkr6j2TFUTUv3kEXR-jKQ+Qc11su2r9U-KiDjG4KrnGRkQ@mail.gmail.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <18d8302c-3ff0-c508-2e8f-61d55bafe4fd@huawei.com>
Date:   Thu, 29 Apr 2021 10:00:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAHbLzkr6j2TFUTUv3kEXR-jKQ+Qc11su2r9U-KiDjG4KrnGRkQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.174]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/4/29 0:21, Yang Shi wrote:
> On Tue, Apr 27, 2021 at 7:06 PM Miaohe Lin <linmiaohe@huawei.com> wrote:
>>
>> On 2021/4/28 5:03, Yang Shi wrote:
>>> On Tue, Apr 27, 2021 at 6:32 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
>>>>
>>>> Since commit 99cb0dbd47a1 ("mm,thp: add read-only THP support for
>>>> (non-shmem) FS"), read-only THP file mapping is supported. But it
>>>> forgot to add checking for it in transparent_hugepage_enabled().
>>>>
>>>> Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
>>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>>>> ---
>>>>  mm/huge_memory.c | 3 +++
>>>>  1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>>> index 76ca1eb2a223..aa22a0ae9894 100644
>>>> --- a/mm/huge_memory.c
>>>> +++ b/mm/huge_memory.c
>>>> @@ -74,6 +74,9 @@ bool transparent_hugepage_enabled(struct vm_area_struct *vma)
>>>>                 return __transparent_hugepage_enabled(vma);
>>>>         if (vma_is_shmem(vma))
>>>>                 return shmem_huge_enabled(vma);
>>>> +       if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) && vma->vm_file &&
>>>> +           (vma->vm_flags & VM_DENYWRITE))
>>>> +               return true;
>>>
>>
>> Many thanks for your quick respond and Reviewed-by tag!
>>
>>> I don't think this change is correct. This function is used to
>>> indicate if allocating THP is eligible for the VMAs or not showed by
>>> smap. And currently readonly FS THP is collapsed by khugepaged only.
>>>
>>> So, you need check if the vma is suitable for khugepaged. Take a look
>>> at what hugepage_vma_check() does.
>>>
>>> And, the new patch
>>> (https://lore.kernel.org/linux-mm/20210406000930.3455850-1-cfijalkovich@google.com/)
>>> relax the constraints for readonly FS THP, it might be already in -mm
>>> tree, so you need adopt the new condition as well.
>>>
>>
>> Many thanks for your comment. I referred to what hugepage_vma_check() does about
>> Read-only file mappings when I came up this patch. But it seems I am miss something.
> 
> Yes, you need do the below check for readonly FS THP too:
> 
> if ((vm_flags & VM_NOHUGEPAGE) ||
>     test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
> return false;
> 
> This check is done separately for anonymous and shmem. It seems not
> perfect to do it three times in a row. So I'd suggest extracting the
> check into a common helper then call it at the top of
> transparent_hugepage_enabled() .
> 
> The helper also could replace the same check in
> __transparent_hugepage_enabled() and shmem_huge_enabled().
> 

I see. Many thanks for detailed explanation and good suggestion! Will do it in v2. :)

>> Take the new patch into account, the check for READ_ONLY_THP now should be:
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 76ca1eb2a223..a46a558233b4 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -74,6 +74,10 @@ bool transparent_hugepage_enabled(struct vm_area_struct *vma)
>>                 return __transparent_hugepage_enabled(vma);
>>         if (vma_is_shmem(vma))
>>                 return shmem_huge_enabled(vma);
>> +       if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) && vma->vm_file &&
>> +           !inode_is_open_for_write(vma->vm_file->f_inode) &&
>> +           (vma->vm_flags & VM_EXEC))
>> +               return true;
>>
>>         return false;
>>  }
>>
>> Am I miss something about checking for READ_ONLY_THP case? Or READ_ONLY_THP case is ok
>> but other case is missed? Could you please explain this more detailed for me?
>>
>> Many thanks!
>>
>>>>
>>>>         return false;
>>>>  }
>>>
>>>> --
>>>> 2.23.0
>>>>
>>>>
>>>
>>> .
>>>
>>
> .
> 

