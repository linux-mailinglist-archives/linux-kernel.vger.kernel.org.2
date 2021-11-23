Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D72345A953
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 17:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234807AbhKWQ5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 11:57:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31602 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229814AbhKWQ5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 11:57:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637686476;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aciHBgOPYUjXvQ93eMaFUYSRPYuVBl2T8inUXnPM1DI=;
        b=BqWXir209ftETRhV5Vk2ivyeFI9FEazvbI5x7aJBpimAfoyi6cQ6bkbxvyxtQNLAU0Mj/C
        HV5uzguWp+A4gUckpNmBZyCOriTinXc02Jg66dXJxuIOuWUhCAAvfOT0ce+IjDD5Ruy3tJ
        dz4FIhrOzmwPQRUoqfMJqqNocc3mMMM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-564-IYQRMb2gMwi-j2EpGAlf4Q-1; Tue, 23 Nov 2021 11:54:34 -0500
X-MC-Unique: IYQRMb2gMwi-j2EpGAlf4Q-1
Received: by mail-wm1-f71.google.com with SMTP id i131-20020a1c3b89000000b00337f92384e0so1493037wma.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 08:54:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=aciHBgOPYUjXvQ93eMaFUYSRPYuVBl2T8inUXnPM1DI=;
        b=iR74Q1LXTygRPJ4PPmlG4mvx3PF2Qn8vx2OCtr2XWrGdE9uI18FRUGmJOwyS5x+ueM
         JM/7zwgDCAEZMBtnVSPXgLHs2fqX3JSDHPdzEf7L9Qtxqj6ZDgQip0nJ7U/Xrmp9EBQh
         Te7gWHKhF8aZk5hMMG+FTgaNOsMoh2mtMhetftTZjVOJzVM/TTDa7rNLx5xOKZARnk4o
         kWqf8t075xp1Kbg6fAC5mpVdC1lPTAQFbgcwXFUDCwaiZmalqO3mQCQMpll/ZzUw2rBm
         b7JJ40Z/XKhHeHAvsVQ2/YPkSzpGFsERiMmazu2lo6L7VH8LeShtOyEd8+KUWwWkC55k
         CDDA==
X-Gm-Message-State: AOAM532rE5ZHFKUmSNB55MLswgJhu+8voXI7+/X6VNqItTqDe31KO9oP
        jXdsty50Z3PCHgzdozJhIM8cPGUvTzNVwC+nfTH79zS2Z+i0oqyO6lWJbe5QDmywSgNcVZgPRFh
        4+Yw5Y7zzp47glOwenwKbqo9c
X-Received: by 2002:a1c:2d5:: with SMTP id 204mr4949214wmc.47.1637686473396;
        Tue, 23 Nov 2021 08:54:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzwCJ9kqIZ1afGl9dtKnbyb539MClO63tVvd/xZetuV1ttuaLkE63sS63XqpG4w9XhQeDN2Gg==
X-Received: by 2002:a1c:2d5:: with SMTP id 204mr4949133wmc.47.1637686472942;
        Tue, 23 Nov 2021 08:54:32 -0800 (PST)
Received: from [192.168.3.132] (p5b0c6765.dip0.t-ipconnect.de. [91.12.103.101])
        by smtp.gmail.com with ESMTPSA id m20sm2100400wmq.11.2021.11.23.08.54.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Nov 2021 08:54:32 -0800 (PST)
Message-ID: <4c5311c7-bae4-4e48-7006-787f2ee19fb3@redhat.com>
Date:   Tue, 23 Nov 2021 17:54:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To:     Zi Yan <ziy@nvidia.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org
References: <20211115193725.737539-1-zi.yan@sent.com>
 <d19fb078-cb9b-f60f-e310-fdeea1b947d2@redhat.com>
 <C99EE864-DF71-469D-A047-4446400B2AE8@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC PATCH 0/3] Use pageblock_order for cma and
 alloc_contig_range alignment.
In-Reply-To: <C99EE864-DF71-469D-A047-4446400B2AE8@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.11.21 04:04, Zi Yan wrote:
> On 16 Nov 2021, at 3:58, David Hildenbrand wrote:
> 
>> On 15.11.21 20:37, Zi Yan wrote:
>>> From: Zi Yan <ziy@nvidia.com>
>>>
>>> Hi David,
>>
>> Hi,
>>
>> thanks for looking into this.
>>

Hi,

sorry for the delay, I wasn't "actually working" last week, so now I'm
back from holiday :)

>>>
>>> You suggested to make alloc_contig_range() deal with pageblock_order instead of
>>> MAX_ORDER - 1 and get rid of MAX_ORDER - 1 dependency in virtio_mem[1]. This
>>> patchset is my attempt to achieve that. Please take a look and let me know if
>>> I am doing it correctly or not.
>>>
>>> From what my understanding, cma required alignment of
>>> max(MAX_ORDER - 1, pageblock_order), because when MIGRATE_CMA was introduced,
>>> __free_one_page() does not prevent merging two different pageblocks, when
>>> MAX_ORDER - 1 > pageblock_order. But current __free_one_page() implementation
>>> does prevent that. It should be OK to just align cma to pageblock_order.
>>> alloc_contig_range() relies on MIGRATE_CMA to get free pages, so it can use
>>> pageblock_order as alignment too.
>>
>> I wonder if that's sufficient. Especially the outer_start logic in
>> alloc_contig_range() might be problematic. There are some ugly corner
>> cases with free pages/allocations spanning multiple pageblocks and we
>> only isolated a single pageblock.
> 
> Thank you a lot for writing the list of these corner cases. They are
> very helpful!
> 
>>
>>
>> Regarding CMA, we have to keep the following cases working:
>>
>> a) Different pageblock types (MIGRATE_CMA and !MIGRATE_CMA) in MAX_ORDER
>>    - 1 page:
>>    [       MAX_ ORDER - 1     ]
>>    [ pageblock 0 | pageblock 1]
>>
>> Assume either pageblock 0 is MIGRATE_CMA or pageblock 1 is MIGRATE_CMA,
>> but not both. We have to make sure alloc_contig_range() keeps working
>> correctly. This should be the case even with your change, as we won't
>> merging pages accross differing migratetypes.
> 
> Yes.
> 
>>
>> b) Migrating/freeing a MAX_ ORDER - 1 page while partially isolated:
>>    [       MAX_ ORDER - 1     ]
>>    [ pageblock 0 | pageblock 1]
>>
>> Assume both are MIGRATE_CMA. Assume we want to either allocate from
>> pageblock 0 or pageblock 1. Especially, assume we want to allocate from
>> pageblock 1. While we would isolate pageblock 1, we wouldn't isolate
>> pageblock 0.
>>
>> What happens if we either have a free page spanning the MAX_ORDER - 1
>> range already OR if we have to migrate a MAX_ORDER - 1 page, resulting
>> in a free MAX_ORDER - 1 page of which only the second pageblock is
>> isolated? We would end up essentially freeing a page that has mixed
>> pageblocks, essentially placing it in !MIGRATE_ISOLATE free lists ... I
>> might be wrong but I have the feeling that this would be problematic.
>>
> 
> This could happen when start_isolate_page_range() stumbles upon a compound
> page with order >= pageblock_order or a free page with order >=
> pageblock_order, but should not. start_isolate_page_range() should check
> the actual page size, either compound page size or free page size, and set
> the migratetype across pageblocks if the page is bigger than pageblock size.
> More precisely set_migratetype_isolate() should do that.

Right -- but then we have to extend the isolation range from within
set_migratetype_isolate() :/ E.g., how should we know what we have to
unisolate later ..

> 
> 
>> c) Concurrent allocations:
>>     [       MAX_ ORDER - 1     ]
>>     [ pageblock 0 | pageblock 1]
>>
>> Assume b) but we have two concurrent CMA allocations to pageblock 0 and
>> pageblock 1, which would now be possible as start_isolate_page_range()
>> isolate would succeed on both.
> 
> Two isolations will be serialized by the zone lock taken by
> set_migratetype_isolate(), so the concurrent allocation would not be a problem.
> If it is a MAX_ORDER-1 free page, the first comer should split it and only
> isolate one of the pageblock then second one can isolate the other pageblock.

Right, the issue is essentially b) above.

> If it is a MAX_ORDER-1 compound page, the first comer should isolate both
> pageblocks, then the second one would fail. WDYT?

Possibly we could even have two independent CMA areas "colliding" within
a MAX_ ORDER - 1 page. I guess the surprise would be getting an
"-EAGAIN" from isolation, but the caller should properly handle that.

Maybe it's really easier to do something along the lines I proposed
below and always isolate the complete MAX_ORDER-1 range in
alloc_contig_range(). We just have to "fix" isolation as I drafted.

> 
> 
> In sum, it seems to me that the issue is page isolation code only sees
> pageblock without check the actual page. When there are multiple pageblocks
> belonging to one page, the problem appears. This should be fixed.
> 
>>
>>
>> Regarding virtio-mem, we care about the following cases:
>>
>> a) Allocating parts from completely movable MAX_ ORDER - 1 page:
>>    [       MAX_ ORDER - 1     ]
>>    [ pageblock 0 | pageblock 1]
>>
>> Assume pageblock 0 and pageblock 1 are either free or contain only
>> movable pages. Assume we allocated pageblock 0. We have to make sure we
>> can allocate pageblock 1. The other way around, assume we allocated
>> pageblock 1, we have to make sure we can allocate pageblock 0.
>>
>> Free pages spanning both pageblocks might be problematic.
> 
> Can you elaborate a bit? If either of pageblock 0 and 1 is used by
> virtio-mem, why do we care the other? If pageblock 0 and 1 belong to
> the same page (either free or compound), they should have the same
> migratetype. If we want to just allocate one of them, we can split
> the free page or migrate the compound page then split the remaining
> free page.

The thing is: it has to work on ZONE_NORMAL and ZONE_MOVABLE as well.
It's essentially the same issue as a) and b) in the CMA case, so it
should be covered by these.

> 
>>
>> b) Allocate parts of partially movable MAX_ ORDER - 1 page:
>>    [       MAX_ ORDER - 1     ]
>>    [ pageblock 0 | pageblock 1]
>>
>> Assume pageblock 0 contains unmovable data but pageblock 1 not: we have
>> to make sure we can allocate pageblock 1. Similarly, assume pageblock 1
>> contains unmovable data but pageblock 0 no: we have to make sure we can
>> allocate pageblock 1. has_unmovable_pages() might allow for that.
>>
>> But, we want to fail early in case we want to allocate a single
>> pageblock but it contains unmovable data. This could be either directly
>> or indirectly.
>>
>> If we have an unmovable (compound) MAX_ ORDER - 1 and we'd try isolating
>> pageblock 1, has_unmovable_pages() would always return "false" because
>> we'd simply be skiping over any tail pages, and not detect the
>> un-movability.
> 
> OK. It seems to me that has_unmovable_pages() needs to be fixed to handle
> such a situation.

Right.

> 
>>
>> c) Migrating/freeing a MAX_ ORDER - 1 page while partially isolated:
>>
>> Same concern as for CMA b)
>>
>>
>> So the biggest concern I have is dealing with migrating/freeing >
>> pageblock_order pages while only having isolated a single pageblock.
> 
> I agree. I think isolation code needs to be aware of >pageblock_order
> pages and act accordingly. If it is a free page, split the page to
> avoid isolating a subset of the page. If it is a compound page, either
> fail the isolation or isolate the entire compound page instead.
> 
>>
>>>
>>> In terms of virtio_mem, if I understand correctly, it relies on
>>> alloc_contig_range() to obtain contiguous free pages and offlines them to reduce
>>> guest memory size. As the result of alloc_contig_range() alignment change,
>>> virtio_mem should be able to just align PFNs to pageblock_order.
>>
>> For virtio-mem it will most probably be desirable to first try
>> allocating the MAX_ORDER -1 range if possible and then fallback to
>> pageblock_order. But that's an additional change on top in virtio-mem code.
>>
> 
> Just to understand the motivation, is this because MAX_ORDER-1 range
> would be faster than pageblock_order? What if MAX_ORDER-1 goes beyond
> a memory section size (like my WIP patchset to increase MAX_ORDER
> beyond the memory section size)? virtio-mem could first try PAGES_PER_SECTION,
> then fall back to pageblock_order, right?

My comment is only in the context of this patch series, not in context
of eventually raising MAX_ORDER to exceed eventually a single memory
section or even a memory block.

Yes, it would be faster. What we do right now (if the complete memory
block is used by Linux and thus not allocated by virtio-mem yet):

a) Try allocating the the complete memory block.
b) If it fails, fallback to essentially MAX_ORDER - 1 chunks

In the context of this patch it would be reasonable to

a) Try allocating the the complete memory block.
b) If it fails, fallback to essentially MAX_ORDER - 1 chunks
c) If it fails, fallback to essentially pageblock order chunks

Things will be different if we change MAX_ORDER - 1.

>>
>>
>> My take to teach alloc_contig_range() to properly handle would be the
>> following:
>>
>> a) Convert MIGRATE_ISOLATE into a separate pageblock flag
>>
>> We would want to convert MIGRATE_ISOLATE into a separate pageblock
>> flags, such that when we isolate a page block we preserve the original
>> migratetype. While start_isolate_page_range() would set that bit,
>> undo_isolate_page_range() would simply clear that bit. The buddy would
>> use a single MIGRATE_ISOLATE queue as is: the original migratetype is
>> only used for restoring the correct migratetype. This would allow for
>> restoring e.g., MIGRATE_UNMOVABLE after isolating an unmovable pageblock
>> (below) and not simply setting all such pageblocks to MIGRATE_MOVABLE
>> when un-isolating.
>>
>> Ideally, we'd get rid of the "migratetype" parameter for
>> alloc_contig_range(). However, even with the above change we have to
>> make sure that memory offlining and ordinary alloc_contig_range() users
>> will fail on MIGRATE_CMA pageblocks (has_unmovable_page() checks that as
>> of today). We could achieve that differently, though (e.g., bool
>> cma_alloc parameter instead).
> 
> This might need to be done in a separate patch, since pageblock bits require
> to be word aligned and it is 4 now. To convert MIGRATE_ISOLATE to a separate
> bit, either NR_PAGEBLOCK_BITS needs to be increased to 8 or a separate
> isolation bitmap array needs to be allocated. Or the migratetype information
> can be stored temporarily during isolation process. I can look into it later.

Right, we'd need 8 instead of 4 bits. But we could preserve the previous
migratettype (MOVABLE, UNMOVABLE, CMA) ... when isolating and wouldn't
have to magically punch in whatever someone told us.

> 
> 
>>
>>
>> b) Allow isolating pageblocks with unmovable pages
>>
>> We'd pass the actual range of interest to start_isolate_page_range() and
>> rework the code to check has_unmovable_pages() only on the range of
>> interest, but considering overlapping larger allocations. E.g., if we
>> stumble over a compound page, lookup the head an test if that page is
>> movable/unmovable.
> 
> This is an optimization to reduce isolation failure rate, right? This only
> applies to the pageblocks at the beginning and the end of a range of interest.

Right. And with a) we can simply isolate+unisolate without always
changing the migratetype e.g., to MIGRATE_MOVABLE in case of virtio-mem.

> 
>>
>> c) Change alloc_contig_range() to not "extend" the range of interest to
>> include pageblock of different type. Assume we're isolating a
>> MIGRATE_CMA pageblock, only isolate a neighboring MIGRATE_CMA pageblock,
>> not other pageblocks.
> 
> But alloc_contig_range() would return these extended pageblocks at the end.
> And if pageblock migratetype can be preserved during isolation (item (a) above),
> this would not be a problem, right?

We have to make sure that ordinary alloc_contig_range() and memory
offlining don't allocate MIGRATE_CMA ranges. So when actually isolating
we have to refuse isolating MIGRATE_CMA pageblocks. Handling that in the
caller when adjusting the range keeps the logic in the actual isolation
code is one option (cma=false - bail out when wanting to isolate
MIGRATE_CMA).

But there might be alternatives. Most probably we'd just have to check
for the "range of interest". If cma=false we just have to make sure to
not isolate MIGRATE_CMA inside the "range of interest". Yes that should
work as well.

> 
>>
>>
>> So we'd keep isolating complete MAX_ORDER - 1 pages unless c) prevents
>> it. We'd allow isolating even pageblocks that contain unmovable pages on
>> ZONE_NORMAL, and check via has_unmovable_pages() only if the range of
>> interest contains unmovable pages, not the whole MAX_ORDER -1 range or
>> even the whole pageblock. We'd not silently overwrite the pageblock type
>> when restoring but instead restore the old migratetype.
>>
> I assume MAX_ORDER - 1 is an optimization for faster isolation speed.
> If MAX_ORDER goes beyond a memory section size, I guess PAGES_PER_SECTION
> is what you want, right? FYI, I am preparing a follow-up patch to replace
> any MAX_ORDER use that is intended to indicate maximum physically contiguous
> size with a new variable, MAX_PHYS_CONTIG_ORDER, which is PFN_SECTION_SHIFT
> when SPARSEMEM and MAX_ORDER when FLATMEM. I would replace MAX_ORDER here
> with the new variable.

Yes, with MAX_ORDER changes it will be a different story. We could
detect at runtime what actually makes sense.

-- 
Thanks,

David / dhildenb

