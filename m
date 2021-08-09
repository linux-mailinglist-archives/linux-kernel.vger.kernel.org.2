Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A35EC3E40C3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 09:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233253AbhHIHUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 03:20:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22280 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232094AbhHIHUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 03:20:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628493634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bJDimoDYG/HnL2+KloR5q89QeG8EXr3Ft9bM0dBgjf8=;
        b=XxZ/nyqISYDlzqOk/etlFeymCorrecWyeGpwOX49Mq3RhymHZIB28g/tIr/8zpr+NrRlWu
        FWPQNg12E8VrC6HFS9SRp6QfM7WMXPt8jgwg+o4OH22KD6yWuKVbaOAkzIxdGJJbwupUjJ
        NuAXPPD12HxZZk9TW6Urnjk8dm/eiLA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-555-4DvKOB4iN4GuCxnIQ8f4wQ-1; Mon, 09 Aug 2021 03:20:32 -0400
X-MC-Unique: 4DvKOB4iN4GuCxnIQ8f4wQ-1
Received: by mail-wr1-f71.google.com with SMTP id d7-20020adffd870000b02901544ea2018fso5078048wrr.10
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 00:20:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=bJDimoDYG/HnL2+KloR5q89QeG8EXr3Ft9bM0dBgjf8=;
        b=JqrBK8Wq+GfBeMj/Pw8UBdjQvnFvp7cj+dFwTCkQIku5MPBaKrsdsI40eJU4mM1mDy
         q2cqs7vinDL75qelurJXoC2eEzRCYPl3Dc9HVooHEhYjHXPZdoJsH9SKzMjEqAUhADfu
         UcQYxHEhcx4DeWACP1SeHHpEBSEDlHPUqhqiHMqkh1oTZRb9mLAeR3IFQPL7F9zCHUju
         XOyim/yaRPKdRpTdy9ln93lGuwkNvh+PHhh+diQsXqsF5GqzShG0Xt6a8OmjOFEoi4Bu
         rGJeJ8PMKLcrt4FlFreCeTX4ChGwaMryRxdiXh87m3AMGLf7B5tds6oZM81TcZXkpeQr
         VucA==
X-Gm-Message-State: AOAM531D/QbopfV22xHJADN9PueiAi8OUNnK9VQUTFktmjMYva6Br1jA
        HZk8kxzp5+scGyAadBxWzdI5R+KqdbBsroxwobQKMskhmR84xbmlLF1kwjmuL9r4fIUAlWvDV60
        0zWkF7ol0uQot5XFRX885RSIA
X-Received: by 2002:a05:600c:210d:: with SMTP id u13mr5832342wml.57.1628493631012;
        Mon, 09 Aug 2021 00:20:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz7QKw8UFOMCDDGYlhf6JXwCFNKFjdiwm9HowlbZFC+BqP2SQtUVjqzcO6n2K1e07oNt8Q1cg==
X-Received: by 2002:a05:600c:210d:: with SMTP id u13mr5832325wml.57.1628493630765;
        Mon, 09 Aug 2021 00:20:30 -0700 (PDT)
Received: from ?IPv6:2003:d8:2f0a:7f00:fad7:3bc9:69d:31f? (p200300d82f0a7f00fad73bc9069d031f.dip0.t-ipconnect.de. [2003:d8:2f0a:7f00:fad7:3bc9:69d:31f])
        by smtp.gmail.com with ESMTPSA id y3sm7160099wma.32.2021.08.09.00.20.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Aug 2021 00:20:30 -0700 (PDT)
To:     Zi Yan <ziy@nvidia.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>
References: <20210805190253.2795604-1-zi.yan@sent.com>
 <40982106-0eee-4e62-7ce0-c4787b0afac4@suse.cz>
 <72b317e5-c78a-f0bc-fe69-f82261ec252e@redhat.com>
 <3417eb98-36c8-5459-c83e-52f90e42a146@suse.cz>
 <59c59a77-cf93-40a8-2ad5-b72d87b8815a@redhat.com>
 <83221D29-5ABE-40F1-8FF3-3B901E494C33@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC PATCH 00/15] Make MAX_ORDER adjustable as a kernel boot time
 parameter.
Message-ID: <fefb01a0-057b-8174-a7ca-ad914b864953@redhat.com>
Date:   Mon, 9 Aug 2021 09:20:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <83221D29-5ABE-40F1-8FF3-3B901E494C33@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.08.21 20:24, Zi Yan wrote:
> On 6 Aug 2021, at 13:08, David Hildenbrand wrote:
> 
>> On 06.08.21 18:54, Vlastimil Babka wrote:
>>> On 8/6/21 6:16 PM, David Hildenbrand wrote:
>>>> On 06.08.21 17:36, Vlastimil Babka wrote:
>>>>> On 8/5/21 9:02 PM, Zi Yan wrote:
>>>>>> From: Zi Yan <ziy@nvidia.com>
>>>>>
>>>>>> Patch 3 restores the pfn_valid_within() check when buddy allocator can merge
>>>>>> pages across memory sections. The check was removed when ARM64 gets rid of holes
>>>>>> in zones, but holes can appear in zones again after this patchset.
>>>>>
>>>>> To me that's most unwelcome resurrection. I kinda missed it was going away and
>>>>> now I can't even rejoice? I assume the systems that will be bumping max_order
>>>>> have a lot of memory. Are they going to have many holes? What if we just
>>>>> sacrificed the memory that would have a hole and don't add it to buddy at all?
>>>>
>>>> I think the old implementation was just horrible and the description we have
>>>> here still suffers from that old crap: "but holes can appear in zones again".
>>>> No, it's not related to holes in zones at all. We can have MAX_ORDER -1 pages
>>>> that are partially a hole.
>>>>
>>>> And to be precise, "hole" here means "there is no memmap" and not "there is a
>>>> hole but it has a valid memmap".
>>>
>>> Yes.
>>>
>>>> But IIRC, we now have under SPARSEMEM always a complete memmap for a complete
>>>> memory sections (when talking about system RAM, ZONE_DEVICE is different but we
>>>> don't really care for now I think).
>>>>
>>>> So instead of introducing what we had before, I think we should look into
>>>> something that doesn't confuse each person that stumbles over it out there. What
>>>> does pfn_valid_within() even mean in the new context? pfn_valid() is most
>>>> probably no longer what we really want, as we're dealing with multiple sections
>>>> that might be online or offline; in the old world, this was different, as a
>>>> MAX_ORDER -1 page was completely contained in a memory section that was either
>>>> online or offline.
>>>>
>>>> I'd imagine something that expresses something different in the context of
>>>> sparsemem:
>>>>
>>>> "Some page orders, such as MAX_ORDER -1, might span multiple memory sections.
>>>> Each memory section has a completely valid memmap if online. Memory sections
>>>> might either be completely online or completely offline. pfn_to_online_page()
>>>> might succeed on one part of a MAX_ORDER - 1 page, but not on another part. But
>>>> it will certainly be consistent within one memory section."
>>>>
>>>> Further, as we know that MAX_ORDER -1 and memory sections are a power of two, we
>>>> can actually do a binary search to identify boundaries, instead of having to
>>>> check each and every page in the range.
>>>>
>>>> Is what I describe the actual reason why we introduce pfn_valid_within() ? (and
>>>> might better introduce something new, with a better fitting name?)
>>>
>>> What I don't like is mainly the re-addition of pfn_valid_within() (or whatever
>>> we'd call it) into __free_one_page() for performance reasons, and also to
>>> various pfn scanners (compaction) for performance and "I must not forget to
>>> check this, or do I?" confusion reasons. It would be really great if we could
>>> keep a guarantee that memmap exists for MAX_ORDER blocks. I see two ways to
>>> achieve that:
>>>
>>> 1. we create memmap for MAX_ORDER blocks, pages in sections not online are
>>> marked as reserved or some other state that allows us to do checks such as "is
>>> there a buddy? no" without accessing a missing memmap
>>> 2. smaller blocks than MAX_ORDER are not released to buddy allocator
>>>
>>> I think 1 would be more work, but less wasteful in the end?
>>
>> It will end up seriously messing with memory hot(un)plug. It's not sufficient if there is a memmap (pfn_valid()), it has to be online (pfn_to_online_page()) to actually have a meaning.
>>
>> So you'd have to  allocate a memmap for all such memory sections, initialize it to all PG_Reserved ("memory hole") and mark these memory sections online. Further, you need memory block devices that are initialized and online.
>>
>> So far so good, although wasteful. What happens if someone hotplugs a memory block that doesn't span a complete MAX_ORDER -1 page? Broken.
>>
>>
>> The only "workaround" would be requiring that MAX_ORDER - 1 cannot be bigger than memory blocks (memory_block_size_bytes()). The memory block size determines our hot(un)plug granularity and can (on some archs already) be determined at runtime. As both (MAX_ORDER and memory_block_size_bytes) would be determined at runtime, for example, by an admin explicitly requesting it, this might be feasible.
>>
>>
>> Memory hot(un)plug / onlining / offlining would most probably work naturally (although the hot(un)plug granularity is then limited to e.g., 1GiB memory blocks). But if that's what an admin requests on the command line, so be it.
>>
>> What might need some thought, though, is having overlapping sections/such memory blocks with devmem. Sub-section hotadd has to continue working unless we want to break some PMEM devices seriously.
> 
> Thanks a lot for your valuable inputs!
> 
> Yes, this might work. But it seems to also defeat the purpose of sparse memory, which allow only memmapping present PFNs, right?

Not really. I will only be suboptimal for corner cases.

Except corner cases for devemem, we already always populate the memmap 
for complete memory sections. Now, we would populate the memmap for all 
memory sections spanning a MAX_ORDER - 1 page, if bigger than a section.

Will it matter in practice? I doubt it.

I consider 1 GiB allocations only relevant for really big machines. 
There, we don't really expect to have a lot of random memory holes. On a 
1 TiB machine, with 1 GiB memory blocks and 1 GiB max_order - 1, you 
don't expect to have a completely fragmented memory layout such that 
allocating additional memmap for some memory sections really makes a 
difference.

> Also it requires a lot more intrusive changes, which might not be accepted easily.

I guess it should require quite minimal changes in contrast to what you 
propose. What we should have to do is

a) Check that the configured MAX_ORDER - 1 is effectively not bigger 
than the memory block size

b) Initialize all sections spanning a MAX_ORDER - 1 during boot, we 
won't even have to mess with memory blocks et al.

All that's required is parsing/processing early parameters in the right 
order.

That sound very little intrusive compared to what you propose. Actually, 
I think what you propose would be an optimization of that approach.


> I will look into the cost of the added pfn checks and try to optimize it. One thing I can think of is that these non-present PFNs should only appear at the beginning and at the end of a zone, since HOLES_IN_ZONE is gone, maybe I just need to store and check PFN range of a zone instead of checking memory section validity and modify the zone PFN range during memory hot(un)plug. For offline pages in the middle of a zone, struct page still exists and PageBuddy() returns false, since PG_offline is set, right?

I think we can have quite some crazy "sparse" layouts where you can have 
random holes within a zone, not only at the beginning/end.

Offline pages can be identified using pfn_to_online_page(). You must not 
touch their memmap, not even to check for PageBuddy(). PG_offline is a 
special case where pfn_to_online_page() returns true and the memmap is 
valid, however, the pages are logically offline and  might get logically 
onlined later -- primarily used in virtualized environments, for 
example, with memory ballooning.

You can treat PG_offline pages like their are online, they just are 
accounted differently (!managed) and shouldn't be touched; but 
otherwise, they are just like any other allocated page.

-- 
Thanks,

David / dhildenb

