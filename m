Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75C2E38AD22
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 13:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242218AbhETL4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 07:56:53 -0400
Received: from foss.arm.com ([217.140.110.172]:48786 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244146AbhETLy4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 07:54:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7CFE5101E;
        Thu, 20 May 2021 04:53:32 -0700 (PDT)
Received: from [10.163.80.140] (unknown [10.163.80.140])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2B3943F73D;
        Thu, 20 May 2021 04:53:27 -0700 (PDT)
Subject: Re: [PATCH] arm64: mm: hugetlb: add support for free vmemmap pages of
 HugeTLB
To:     David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>, will@kernel.org,
        akpm@linux-foundation.org, bodeddub@amazon.com, osalvador@suse.de,
        mike.kravetz@oracle.com, rientjes@google.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com,
        fam.zheng@bytedance.com, zhengqi.arch@bytedance.com
References: <20210518091826.36937-1-songmuchun@bytedance.com>
 <1b9d008a-7544-cc85-5c2f-532b984eb5b5@arm.com>
 <88114091-fbb2-340d-b69b-a572fa340265@redhat.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <df8a0fd5-2389-6ef0-b8e2-1c56663e7868@arm.com>
Date:   Thu, 20 May 2021 17:24:12 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <88114091-fbb2-340d-b69b-a572fa340265@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/19/21 5:33 PM, David Hildenbrand wrote:
> On 19.05.21 13:45, Anshuman Khandual wrote:
>>
>>
>> On 5/18/21 2:48 PM, Muchun Song wrote:
>>> The preparation of supporting freeing vmemmap associated with each
>>> HugeTLB page is ready, so we can support this feature for arm64.
>>>
>>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>>> ---
>>>   arch/arm64/mm/mmu.c | 5 +++++
>>>   fs/Kconfig          | 2 +-
>>>   2 files changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>>> index 5d37e461c41f..967b01ce468d 100644
>>> --- a/arch/arm64/mm/mmu.c
>>> +++ b/arch/arm64/mm/mmu.c
>>> @@ -23,6 +23,7 @@
>>>   #include <linux/mm.h>
>>>   #include <linux/vmalloc.h>
>>>   #include <linux/set_memory.h>
>>> +#include <linux/hugetlb.h>
>>>     #include <asm/barrier.h>
>>>   #include <asm/cputype.h>
>>> @@ -1134,6 +1135,10 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
>>>       pmd_t *pmdp;
>>>         WARN_ON((start < VMEMMAP_START) || (end > VMEMMAP_END));
>>> +
>>> +    if (is_hugetlb_free_vmemmap_enabled() && !altmap)
>>> +        return vmemmap_populate_basepages(start, end, node, altmap);
>>
>> Not considering the fact that this will force the kernel to have only
>> base page size mapping for vmemmap (unless altmap is also requested)
>> which might reduce the performance, it also enables vmemmap mapping to
>> be teared down or build up at runtime which could potentially collide
>> with other kernel page table walkers like ptdump or memory hotremove
>> operation ! How those possible collisions are protected right now ?
> 
> Hi Anshuman,
> 
> Memory hotremove is not an issue IIRC. At the time memory is removed, all huge pages either have been migrated away or dissolved; the vmemmap is stable.

But what happens when a hot remove section's vmemmap area (which is being
teared down) is nearby another vmemmap area which is either created or
being destroyed for HugeTLB alloc/free purpose. As you mentioned HugeTLB
pages inside the hot remove section might be safe. But what about other
HugeTLB areas whose vmemmap area shares page table entries with vmemmap
entries for a section being hot removed ? Massive HugeTLB alloc/use/free
test cycle using memory just adjacent to a memory hotplug area, which is
always added and removed periodically, should be able to expose this problem.

IIUC unlike vmalloc(), vmemap mapping areas in the kernel page table were
always constant unless there are hotplug add or remove operations which
are protected with a hotplug lock. Now with this change, we could have
simultaneous walking and add or remove of the vmemap areas without any
synchronization. Is not this problematic ?

On arm64 memory hot remove operation empties free portions of the vmemmap
table after clearing them. Hence all concurrent walkers (hugetlb_vmemmap,
hot remove, ptdump etc) need to be synchronized against hot remove.

From arch/arm64/mm/mmu.c

void vmemmap_free(unsigned long start, unsigned long end,
                struct vmem_altmap *altmap)
{
#ifdef CONFIG_MEMORY_HOTPLUG
        WARN_ON((start < VMEMMAP_START) || (end > VMEMMAP_END));

        unmap_hotplug_range(start, end, true, altmap);
        free_empty_tables(start, end, VMEMMAP_START, VMEMMAP_END);
#endif
}

> 
> vmemmap access (accessing the memmap via a virtual address) itself is not an issue. Manually walking (vmemmap) page tables might behave 

Right.

differently, not sure if ptdump would require any synchronization.

Dumping an wrong value is probably okay but crashing because a page table
entry is being freed after ptdump acquired the pointer is bad. On arm64,
ptdump() is protected against hotremove via [get|put]_online_mems().

> 
>>
>> Does not this vmemmap operation increase latency for HugeTLB usage ?
>> Should not this runtime enablement also take into account some other
>> qualifying information apart from potential memory save from struct
>> page areas. Just wondering.
> 
> That's one of the reasons why it explicitly has to be enabled by an admin.
> 

config HUGETLB_PAGE_FREE_VMEMMAP
        def_bool HUGETLB_PAGE
        depends on X86_64 || ARM64
        depends on SPARSEMEM_VMEMMAP

Should not this depend on EXPERT as well ? Regardless, there is a sync
problem on arm64 if this feature is enabled as vmemmap portions can be
freed up during hot remove operation. But wondering how latency would
be impacted if vmemap_remap_[alloc|free]() add [get|put]_online_mems().
