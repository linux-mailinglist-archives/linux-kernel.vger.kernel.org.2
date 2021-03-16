Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2C2833DB33
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 18:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239046AbhCPRpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 13:45:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39491 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239018AbhCPRp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 13:45:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615916726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kj43tFwVRr2NmhS0pno3wwc/9fOdv1FSTvbdHxmpOdI=;
        b=O4V3k6lMOpnvT+uh6gaSSXzu35O/zqEFVzymrXCWR3M8TNHaNZWc0JoLn/RAaMGfL15uZH
        2blSfro7Jq+cAXAyF25o4hUW2EbZK0SoHy0LxKPUJhMPwBwk6ZlZGzE+n3YP/eFmqmI5U8
        g+kwQ63xuYzX3rnHB46X6oAvWFXV+Mc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-383-LEH97x4aMoq-B_tMNgGNfg-1; Tue, 16 Mar 2021 13:45:22 -0400
X-MC-Unique: LEH97x4aMoq-B_tMNgGNfg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 238CA817469;
        Tue, 16 Mar 2021 17:45:20 +0000 (UTC)
Received: from [10.36.114.203] (ovpn-114-203.ams2.redhat.com [10.36.114.203])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0812219D61;
        Tue, 16 Mar 2021 17:45:17 +0000 (UTC)
Subject: Re: [PATCH v4 1/5] mm,memory_hotplug: Allocate memmap from the added
 memory range
From:   David Hildenbrand <david@redhat.com>
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
 <a2bf7b25-1e7a-bb6b-2fcd-08a4f4636ed5@redhat.com>
Organization: Red Hat GmbH
Message-ID: <a03fcbb3-5b77-8671-6376-13c360f5ae25@redhat.com>
Date:   Tue, 16 Mar 2021 18:45:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <a2bf7b25-1e7a-bb6b-2fcd-08a4f4636ed5@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.03.21 17:46, David Hildenbrand wrote:
> On 15.03.21 11:22, Oscar Salvador wrote:
>> On Thu, Mar 11, 2021 at 08:06:53PM +0100, David Hildenbrand wrote:
>>> This looks essentially good to me, except some parts in
>>> mhp_supports_memmap_on_memory()
>>>
>>>> +bool mhp_supports_memmap_on_memory(unsigned long size)
>>>> +{
>>>> +	unsigned long pageblock_size = PFN_PHYS(pageblock_nr_pages);
>>>> +	unsigned long remaining_mem = size - PMD_SIZE;
>>
>> Hi David, thanks for the review!
>>
>>> This looks weird. I think what you want to test is that
>>>
>>>
>>> a) "nr_vmemmap_pages * sizeof(struct page)" spans complete PMDs (IOW, we
>>> won't map too much via the altmap when populating a PMD in the vmemmap)
>>>
>>> b) "remaining = size - nr_vmemmap_pages * sizeof(struct page)" spans
>>> complete pageblock.
>>
>> We do not know the nr_vmemmap_pages at this point in time, although it is
>> easy to pre-compute.
>>
>> For every section we populate, we use PMD_SIZE. So, PMD_SIZE/PAGE_SIZE lays
>> the nr_vmemmap_pages that are used for populating a single section.
> 
> I find that cross reference to vmemmap code a little hard to digest.
> I would have assume that we don't have to care about PMDs in this
> code here at all. The vmemmap population code should handle that.
> 
> I think I already mentioned that somewhere, I think it should be like this:
> 
> a) vmemmap code should *never* populate more memory than requested for
> a single memory section when we are populating from the altmap.
> If that cannot be guaranteed for PMDs, then we have to fallback
> to populating base pages. Populating PMDs from an altmap with
> sizeof(struct page) == 64 is highly dangerous.
> 
> Assume we have sizeof(struct page) == 56. A 128 MiB section
> spans 32768 pages -  we need 32768 * sizeof(struct page)
> space for the vmemmap.
> 
> With 64k pages we *can* use exactly one PMD. With 56k pages
> we need 448 individual (full!) pages for the vmemmap.
> 
> IOW, we don't care how vmemmap code will do the mapping.
> vmemmap code has to get it right. IMHO, asserting it in
> this code is wrong.
> 
> 
> b) In this code, we really should only care about what
> memory onlining/offlining code can or can't do.
> We really only care that
> 
> 1) size == memory_block_size_bytes()
> 2) remaining_size
> 3) IS_ALIGNED(remaining_size, pageblock_size);
> 
> 
> I think a) is a logical consequence of b) for x86-64,
> whereby the pageblock size corresponds to PMD, so we
> might not have to care about a) right now.
> 
> See below for my take.
> 
> 
>>
>> But let me explain the reasoning I use in the current code:
>>
>> I will enumarate the assumptions that must hold true in order to support the
>> feature together with their check:
>>
>> - We span a single memory block
>>
>>     size == memory_block_size_bytes()
>>
>> - The vmemmap pages span a complete PMD and no more than a PMD.
>>
>>     !(PMD_SIZE % sizeof(struct page))
>>
>> - The vmemmap pages and the pages exposed to the buddy have to cover full
>>     pageblocks
>>
>>     remaining_mem = size - PMD_SIZE;
>>     IS_ALIGNED(remaining_mem, pageblock_size)
>>
>>     Although this check only covers the range without the vmemmap pages, one could
>>     argue that since we use only a PMD_SIZE at a time, we know that PMD_SIZE is
>>     pageblock aligned, so the vmemmap range is PMD_SIZE as well.
>>
>> Now, I see how this might be confusing and rather incomplete.
>> So I guess a better and more clear way to write it would be:
>>
>>    bool mhp_supports_memmap_on_memory(unsigned long size)
>>    {
>>            unsigned long nr_vmemmap_pages = PMD_SIZE / PAGE_SIZE;
>>            unsigned long vmemmap_size = nr_vmemmap_pages * sizeof(struct page);
>>            unsigned long remaining_size = size - vmemmap_size;
>>
>>            return memmap_on_memory &&
>>                   IS_ENABLED(CONFIG_MHP_MEMMAP_ON_MEMORY) &&
>>                   size == memory_block_size_bytes() &&
>>                   !(PMD_SIZE % vmemmap_size) &&
>>                   IS_ALIGNED(vmemmap_size, pageblock_size) &&
>>                   remaining_size &&
>>                   IS_ALIGNED(remaining_size, pageblock_size);
>>     }
>>                   
>> Note that above check is only for a single section, but if assumptions hold true
>> for a single section, it will for many as well.
> 
> Okay, please document the statement about single sections, that's
> important to understand what's happening.
> 
> My take would be
> 
> bool mhp_supports_memmap_on_memory(unsigned long size)
> {
> 	/*
> 	 * Note: We calculate for a single memory section. The calculation
> 	 * implicitly covers memory blocks that span multiple sections.
> 	 */
> 	unsigned long nr_vmemmap_pages = SECTION_SIZE / PAGE_SIZE;
> 	unsigned long vmemmap_size = nr_vmemmap_pages * sizeof(struct page);
> 	unsigned long remaining_size = size - vmemmap_size;
> 
> 	/*
> 	 * Note: vmemmap code has to make sure to not populate more memory
> 	 * via the altmap than absolutely necessary for a single section.
> 	 * This always holds when we allocate pageblock-sized chunks from
> 	 * the altmap, as we require pageblock alignment here.
> 	 *
> 	 * TODO, other doc
> 	 */
> 	return memmap_on_memory &&
>                  IS_ENABLED(CONFIG_MHP_MEMMAP_ON_MEMORY) &&
> 	       size == memory_block_size_bytes() &&
> 	       remaining_size &&
> 	       IS_ALIGNED(remaining_size, pageblock_size);

Oh, I forgot, we can also drop the check for "remaining_size" in that 
code. If we ever have PAGE_SIZE == sizeof(struct page) we'll be in 
bigger trouble :D


-- 
Thanks,

David / dhildenb

