Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD6BA33D9C1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 17:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238912AbhCPQqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 12:46:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51065 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238867AbhCPQqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 12:46:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615913172;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rGr5W1PgDszu6kWN4ONO/QzqL29aAraAzC4JvvT+R/g=;
        b=EYgXnwRGNSwWodSNkC6bpUgxLxi4lvbr2MLv8AefEJwvXsW/ObrgwRuzCijQ12GloN0Yqk
        lTG8HQE/QpMYqP7WmTMf+qK/BO3mazdeJRb7E8C/6bX0F/9jinDpXJQ31kAS1i8gMDaLh/
        6yGMheRiAvZiGE0HQxhLJn7olOw68mo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-racK3aJQMOKrvE8oD-_iMw-1; Tue, 16 Mar 2021 12:46:10 -0400
X-MC-Unique: racK3aJQMOKrvE8oD-_iMw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B4EF2108BD0A;
        Tue, 16 Mar 2021 16:46:08 +0000 (UTC)
Received: from [10.36.114.203] (ovpn-114-203.ams2.redhat.com [10.36.114.203])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6F92F2C167;
        Tue, 16 Mar 2021 16:46:06 +0000 (UTC)
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210309175546.5877-1-osalvador@suse.de>
 <20210309175546.5877-2-osalvador@suse.de>
 <f600451e-48aa-184f-ae71-94e0abe9d6b1@redhat.com>
 <20210315102224.GA24699@linux>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: [PATCH v4 1/5] mm,memory_hotplug: Allocate memmap from the added
 memory range
Message-ID: <a2bf7b25-1e7a-bb6b-2fcd-08a4f4636ed5@redhat.com>
Date:   Tue, 16 Mar 2021 17:46:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210315102224.GA24699@linux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.03.21 11:22, Oscar Salvador wrote:
> On Thu, Mar 11, 2021 at 08:06:53PM +0100, David Hildenbrand wrote:
>> This looks essentially good to me, except some parts in
>> mhp_supports_memmap_on_memory()
>>
>>> +bool mhp_supports_memmap_on_memory(unsigned long size)
>>> +{
>>> +	unsigned long pageblock_size = PFN_PHYS(pageblock_nr_pages);
>>> +	unsigned long remaining_mem = size - PMD_SIZE;
> 
> Hi David, thanks for the review!
> 
>> This looks weird. I think what you want to test is that
>>
>>
>> a) "nr_vmemmap_pages * sizeof(struct page)" spans complete PMDs (IOW, we
>> won't map too much via the altmap when populating a PMD in the vmemmap)
>>
>> b) "remaining = size - nr_vmemmap_pages * sizeof(struct page)" spans
>> complete pageblock.
> 
> We do not know the nr_vmemmap_pages at this point in time, although it is
> easy to pre-compute.
> 
> For every section we populate, we use PMD_SIZE. So, PMD_SIZE/PAGE_SIZE lays
> the nr_vmemmap_pages that are used for populating a single section.

I find that cross reference to vmemmap code a little hard to digest.
I would have assume that we don't have to care about PMDs in this
code here at all. The vmemmap population code should handle that.

I think I already mentioned that somewhere, I think it should be like this:

a) vmemmap code should *never* populate more memory than requested for
a single memory section when we are populating from the altmap.
If that cannot be guaranteed for PMDs, then we have to fallback
to populating base pages. Populating PMDs from an altmap with
sizeof(struct page) == 64 is highly dangerous.

Assume we have sizeof(struct page) == 56. A 128 MiB section
spans 32768 pages -  we need 32768 * sizeof(struct page)
space for the vmemmap.

With 64k pages we *can* use exactly one PMD. With 56k pages
we need 448 individual (full!) pages for the vmemmap.

IOW, we don't care how vmemmap code will do the mapping.
vmemmap code has to get it right. IMHO, asserting it in
this code is wrong.


b) In this code, we really should only care about what
memory onlining/offlining code can or can't do.
We really only care that

1) size == memory_block_size_bytes()
2) remaining_size
3) IS_ALIGNED(remaining_size, pageblock_size);


I think a) is a logical consequence of b) for x86-64,
whereby the pageblock size corresponds to PMD, so we
might not have to care about a) right now.

See below for my take.


> 
> But let me explain the reasoning I use in the current code:
> 
> I will enumarate the assumptions that must hold true in order to support the
> feature together with their check:
> 
> - We span a single memory block
> 
>    size == memory_block_size_bytes()
> 
> - The vmemmap pages span a complete PMD and no more than a PMD.
> 
>    !(PMD_SIZE % sizeof(struct page))
> 
> - The vmemmap pages and the pages exposed to the buddy have to cover full
>    pageblocks
> 
>    remaining_mem = size - PMD_SIZE;
>    IS_ALIGNED(remaining_mem, pageblock_size)
> 
>    Although this check only covers the range without the vmemmap pages, one could
>    argue that since we use only a PMD_SIZE at a time, we know that PMD_SIZE is
>    pageblock aligned, so the vmemmap range is PMD_SIZE as well.
> 
> Now, I see how this might be confusing and rather incomplete.
> So I guess a better and more clear way to write it would be:
> 
>   bool mhp_supports_memmap_on_memory(unsigned long size)
>   {
>           unsigned long nr_vmemmap_pages = PMD_SIZE / PAGE_SIZE;
>           unsigned long vmemmap_size = nr_vmemmap_pages * sizeof(struct page);
>           unsigned long remaining_size = size - vmemmap_size;
> 
>           return memmap_on_memory &&
>                  IS_ENABLED(CONFIG_MHP_MEMMAP_ON_MEMORY) &&
>                  size == memory_block_size_bytes() &&
>                  !(PMD_SIZE % vmemmap_size) &&
>                  IS_ALIGNED(vmemmap_size, pageblock_size) &&
>                  remaining_size &&
>                  IS_ALIGNED(remaining_size, pageblock_size);
>    }
>                  
> Note that above check is only for a single section, but if assumptions hold true
> for a single section, it will for many as well.

Okay, please document the statement about single sections, that's
important to understand what's happening.

My take would be

bool mhp_supports_memmap_on_memory(unsigned long size)
{
	/*
	 * Note: We calculate for a single memory section. The calculation
	 * implicitly covers memory blocks that span multiple sections.
	 */
	unsigned long nr_vmemmap_pages = SECTION_SIZE / PAGE_SIZE;
	unsigned long vmemmap_size = nr_vmemmap_pages * sizeof(struct page);
	unsigned long remaining_size = size - vmemmap_size;

	/*
	 * Note: vmemmap code has to make sure to not populate more memory
	 * via the altmap than absolutely necessary for a single section.
	 * This always holds when we allocate pageblock-sized chunks from
	 * the altmap, as we require pageblock alignment here.
	 *
	 * TODO, other doc
	 */
	return memmap_on_memory &&
                IS_ENABLED(CONFIG_MHP_MEMMAP_ON_MEMORY) &&
	       size == memory_block_size_bytes() &&
	       remaining_size &&
	       IS_ALIGNED(remaining_size, pageblock_size);
}


For arm64 with 64k base pages it might not hold and we might
have to fix vmemmap code to not over-populate PMDs (512 MB). I
did not have a loom at the code, though.

> 	
>> I suggest a restructuring, compressing the information like:
>>
>> "
>> Besides having arch support and the feature enabled at runtime, we need a
>> few more assumptions to hold true:
>>
>> a) We span a single memory block: memory onlining/offlining happens in
>> memory block granularity. We don't want the vmemmap of online memory blocks
>> to reside on offline memory blocks. In the future, we might want to support
>> variable-sized memory blocks to make the feature more versatile.
>>
>> b) The vmemmap pages span complete PMDs: We don't want vmemmap code to
>> populate memory from the altmap for unrelated parts (i.e., other memory
>> blocks).
>>
>> c) The vmemmap pages (and thereby the pages that will be exposed to the
>> buddy) have to cover full pageblocks: memory onlining/offlining code
>> requires applicable ranges to be page-aligned, for example, to set the
>> migratetypes properly.
>> "
> 
> I am fine with the above, I already added it, thanks.
> 
>> Do we have to special case / protect against the vmemmap optimization for
>> hugetlb pages? Or is that already blocked somehow and I missed it?
> 
> Yes, hugetlb-vmemmap feature disables vmemmap on PMD population [1]
> 
> [1] https://patchwork.kernel.org/project/linux-mm/patch/20210308102807.59745-7-songmuchun@bytedance.com/

Sorry, I might be missing something important.
How does that make both features run mutually exclusive?

hugetlb-vmemmap only instructs to populate base pages on
!altmap. I assume if hugetlb-vmemmap code stumbles over
a PMD it will skip optimization.

But what if your machine does not have
boot_cpu_has(X86_FEATURE_PSE) -- IOW, you always populate base pages?

Either hugetlb-vmemmap code would have to identify that
these pages come from an altmap (how? PageReserved() is also
used for boot memory), or both features have to somehow
run mutually exclusive.

-- 
Thanks,

David / dhildenb

