Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8F338AD49
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242077AbhETMBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:01:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38395 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241957AbhETMAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:00:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621511972;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JBAQo3FtbFzeEZGaxuRtcZF/NyukBTNcZelW04MqfX4=;
        b=eYu6HQrqfOOQAXqmvWunTtb2QCvJflrSuvGd22eNLyjM3c98w2Jeln3FwWkcWiwSAkvbC4
        rbw4USnKnWafLYoQl9xdJcWZeKfyUWcANSkekq+2tky0mas9DFRMHUWJ5hU5G7fCQLPrVX
        VgiE74NlfkLamq4njP5//PGdZmaO2Rs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7--20u9cPEP2iX7vN7BOomAg-1; Thu, 20 May 2021 07:59:30 -0400
X-MC-Unique: -20u9cPEP2iX7vN7BOomAg-1
Received: by mail-wr1-f72.google.com with SMTP id a5-20020a5d6ca50000b029011035a261adso8515226wra.17
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 04:59:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=JBAQo3FtbFzeEZGaxuRtcZF/NyukBTNcZelW04MqfX4=;
        b=kPn8oxEtNzkODtxzREC/R2nQUB3URRg5/i0wVEayVdpncmBx0YG4ZTnGGCf3UQmdCa
         8q1cKtN1cbqS8JJGGXXff6wVRJWpWZI5DO1on+NFbK5NTE8Fav0pnzK7Dkq51v4+Woge
         Eig+prfnxRiymgdRPdz//7H+3sfE4e+TTmtPouRVF+Jjo9D2uTC75Hvly6RYxFw7tyvh
         GNj0/u30gVP7e1KghHat0SaSplW/dSLxAfDOdcf+sQEQxnReFqXUkOpGGjLGrK8VIU/b
         fBKs4P1hvvc/s6zg+6r8N7xkjT6rLtcbowu/y8nTuGCu5waOQry4W367NsU88I78mUuu
         zbdA==
X-Gm-Message-State: AOAM533F+5+sR4cH8GAKQzPnMaiMJpfJ4W1MJpRmn6VplMha7DIGqKOA
        SsxNNE97fmakSeO84OEItybHwOitSYqbDJHUGcT9r0nnr+epsIl3CQNWjetjA9K+RzuRhYN+ivF
        thu9SU0NJPDjZHPYIO9hRwqDX
X-Received: by 2002:a1c:7fd0:: with SMTP id a199mr3256500wmd.161.1621511969537;
        Thu, 20 May 2021 04:59:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwkFujVPAteUWEO5DO4dowktrsEOc85LrVAZwnahENNHCoVm2vyCin1TRLLH8zU4SOOP8G4EQ==
X-Received: by 2002:a1c:7fd0:: with SMTP id a199mr3256481wmd.161.1621511969239;
        Thu, 20 May 2021 04:59:29 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6315.dip0.t-ipconnect.de. [91.12.99.21])
        by smtp.gmail.com with ESMTPSA id v15sm8757755wmj.39.2021.05.20.04.59.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 May 2021 04:59:28 -0700 (PDT)
Subject: Re: [PATCH] arm64: mm: hugetlb: add support for free vmemmap pages of
 HugeTLB
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Muchun Song <songmuchun@bytedance.com>, will@kernel.org,
        akpm@linux-foundation.org, bodeddub@amazon.com, osalvador@suse.de,
        mike.kravetz@oracle.com, rientjes@google.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com,
        fam.zheng@bytedance.com, zhengqi.arch@bytedance.com
References: <20210518091826.36937-1-songmuchun@bytedance.com>
 <1b9d008a-7544-cc85-5c2f-532b984eb5b5@arm.com>
 <88114091-fbb2-340d-b69b-a572fa340265@redhat.com>
 <df8a0fd5-2389-6ef0-b8e2-1c56663e7868@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <45c1a368-3d31-e92d-f120-4dca0eb2111d@redhat.com>
Date:   Thu, 20 May 2021 13:59:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <df8a0fd5-2389-6ef0-b8e2-1c56663e7868@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.05.21 13:54, Anshuman Khandual wrote:
> 
> On 5/19/21 5:33 PM, David Hildenbrand wrote:
>> On 19.05.21 13:45, Anshuman Khandual wrote:
>>>
>>>
>>> On 5/18/21 2:48 PM, Muchun Song wrote:
>>>> The preparation of supporting freeing vmemmap associated with each
>>>> HugeTLB page is ready, so we can support this feature for arm64.
>>>>
>>>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>>>> ---
>>>>    arch/arm64/mm/mmu.c | 5 +++++
>>>>    fs/Kconfig          | 2 +-
>>>>    2 files changed, 6 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>>>> index 5d37e461c41f..967b01ce468d 100644
>>>> --- a/arch/arm64/mm/mmu.c
>>>> +++ b/arch/arm64/mm/mmu.c
>>>> @@ -23,6 +23,7 @@
>>>>    #include <linux/mm.h>
>>>>    #include <linux/vmalloc.h>
>>>>    #include <linux/set_memory.h>
>>>> +#include <linux/hugetlb.h>
>>>>      #include <asm/barrier.h>
>>>>    #include <asm/cputype.h>
>>>> @@ -1134,6 +1135,10 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
>>>>        pmd_t *pmdp;
>>>>          WARN_ON((start < VMEMMAP_START) || (end > VMEMMAP_END));
>>>> +
>>>> +    if (is_hugetlb_free_vmemmap_enabled() && !altmap)
>>>> +        return vmemmap_populate_basepages(start, end, node, altmap);
>>>
>>> Not considering the fact that this will force the kernel to have only
>>> base page size mapping for vmemmap (unless altmap is also requested)
>>> which might reduce the performance, it also enables vmemmap mapping to
>>> be teared down or build up at runtime which could potentially collide
>>> with other kernel page table walkers like ptdump or memory hotremove
>>> operation ! How those possible collisions are protected right now ?
>>
>> Hi Anshuman,
>>
>> Memory hotremove is not an issue IIRC. At the time memory is removed, all huge pages either have been migrated away or dissolved; the vmemmap is stable.
> 
> But what happens when a hot remove section's vmemmap area (which is being
> teared down) is nearby another vmemmap area which is either created or
> being destroyed for HugeTLB alloc/free purpose. As you mentioned HugeTLB
> pages inside the hot remove section might be safe. But what about other
> HugeTLB areas whose vmemmap area shares page table entries with vmemmap
> entries for a section being hot removed ? Massive HugeTLB alloc/use/free
> test cycle using memory just adjacent to a memory hotplug area, which is
> always added and removed periodically, should be able to expose this problem.
> 
> IIUC unlike vmalloc(), vmemap mapping areas in the kernel page table were
> always constant unless there are hotplug add or remove operations which
> are protected with a hotplug lock. Now with this change, we could have
> simultaneous walking and add or remove of the vmemap areas without any
> synchronization. Is not this problematic ?
> 
> On arm64 memory hot remove operation empties free portions of the vmemmap
> table after clearing them. Hence all concurrent walkers (hugetlb_vmemmap,
> hot remove, ptdump etc) need to be synchronized against hot remove.
> 
>  From arch/arm64/mm/mmu.c
> 
> void vmemmap_free(unsigned long start, unsigned long end,
>                  struct vmem_altmap *altmap)
> {
> #ifdef CONFIG_MEMORY_HOTPLUG
>          WARN_ON((start < VMEMMAP_START) || (end > VMEMMAP_END));
> 
>          unmap_hotplug_range(start, end, true, altmap);
>          free_empty_tables(start, end, VMEMMAP_START, VMEMMAP_END);
> #endif
> }

You are right, however, AFAIR

1) We always populate base pages, meaning we only modify PTEs and not 
actually add/remove page tables when creating/destroying a hugetlb page. 
Page table walkers should be fine and not suddenly run into a 
use-after-free.

2) For pfn_to_page() users to never fault, we have to do an atomic 
exchange of PTES, meaning, someone traversing a page table looking for 
pte_none() entries (like free_empty_tables() in your example) should 
never get a false positive.

Makes sense, or am I missing something?

> 
>>
>> vmemmap access (accessing the memmap via a virtual address) itself is not an issue. Manually walking (vmemmap) page tables might behave
> 
> Right.
> 
> differently, not sure if ptdump would require any synchronization.
> 
> Dumping an wrong value is probably okay but crashing because a page table
> entry is being freed after ptdump acquired the pointer is bad. On arm64,
> ptdump() is protected against hotremove via [get|put]_online_mems().

Okay, and as the feature in question only exchanges PTEs, we should be 
fine.



-- 
Thanks,

David / dhildenb

