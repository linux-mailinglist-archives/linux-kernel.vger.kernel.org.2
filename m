Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D07B438AD4A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242151AbhETMB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:01:59 -0400
Received: from foss.arm.com ([217.140.110.172]:49020 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237411AbhETMBP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:01:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 25615101E;
        Thu, 20 May 2021 04:59:54 -0700 (PDT)
Received: from [10.163.80.140] (unknown [10.163.80.140])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D8D143F73D;
        Thu, 20 May 2021 04:59:49 -0700 (PDT)
Subject: Re: [External] Re: [PATCH] arm64: mm: hugetlb: add support for free
 vmemmap pages of HugeTLB
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        "Bodeddula, Balasubramaniam" <bodeddub@amazon.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Rientjes <rientjes@google.com>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        fam.zheng@bytedance.com, zhengqi.arch@bytedance.com
References: <20210518091826.36937-1-songmuchun@bytedance.com>
 <1b9d008a-7544-cc85-5c2f-532b984eb5b5@arm.com>
 <CAMZfGtVnfYjsDRSL5zURZrPvrvsGp3H22jWUy1mBEnEhKTm+eg@mail.gmail.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <b9452999-27a7-9b71-8496-de636a860be3@arm.com>
Date:   Thu, 20 May 2021 17:30:34 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAMZfGtVnfYjsDRSL5zURZrPvrvsGp3H22jWUy1mBEnEhKTm+eg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/19/21 6:19 PM, Muchun Song wrote:
> On Wed, May 19, 2021 at 7:44 PM Anshuman Khandual
> <anshuman.khandual@arm.com> wrote:
>> On 5/18/21 2:48 PM, Muchun Song wrote:
>>> The preparation of supporting freeing vmemmap associated with each
>>> HugeTLB page is ready, so we can support this feature for arm64.
>>>
>>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>>> ---
>>>  arch/arm64/mm/mmu.c | 5 +++++
>>>  fs/Kconfig          | 2 +-
>>>  2 files changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>>> index 5d37e461c41f..967b01ce468d 100644
>>> --- a/arch/arm64/mm/mmu.c
>>> +++ b/arch/arm64/mm/mmu.c
>>> @@ -23,6 +23,7 @@
>>>  #include <linux/mm.h>
>>>  #include <linux/vmalloc.h>
>>>  #include <linux/set_memory.h>
>>> +#include <linux/hugetlb.h>
>>>
>>>  #include <asm/barrier.h>
>>>  #include <asm/cputype.h>
>>> @@ -1134,6 +1135,10 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
>>>       pmd_t *pmdp;
>>>
>>>       WARN_ON((start < VMEMMAP_START) || (end > VMEMMAP_END));
>>> +
>>> +     if (is_hugetlb_free_vmemmap_enabled() && !altmap)
>>> +             return vmemmap_populate_basepages(start, end, node, altmap);
>>
>> Not considering the fact that this will force the kernel to have only
>> base page size mapping for vmemmap (unless altmap is also requested)
>> which might reduce the performance, it also enables vmemmap mapping to
>> be teared down or build up at runtime which could potentially collide
>> with other kernel page table walkers like ptdump or memory hotremove
>> operation ! How those possible collisions are protected right now ?
> 
> For the ptdump, there seems no problem.  The change of pte seems
> not to affect the ptdump unless I miss something.

The worst case scenario for ptdump would be an wrong information being
dumped. But as mentioned earlier, this must be protected against memory
hot remove operation which could free up entries for vmemmap areas in
the kernel page table.
