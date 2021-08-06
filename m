Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB0D3E2EC0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 19:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240423AbhHFRIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 13:08:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22405 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239852AbhHFRIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 13:08:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628269694;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/GvUXzVqBNpTYmWX6silIAbrzIkt7NivstiUqC9NAzM=;
        b=cxh+9k0lbP2owqF2ZaApd/sXClAPVFfuomNWGN7dCHvAgrr/M1XwyRfi7BpZ2QetDUYK+M
        jYkD2+qE7RMyG5gCRnTTTfWk2A1GztRIpGX0qP/B16kvLGvh7JzucbS0R4ta38PH+vjeMa
        Fk2YcV7c1/Y0R6rrEz/ZAGklaRO877Y=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-enTQNZEIPoKx4T-Ijo5jzQ-1; Fri, 06 Aug 2021 13:08:13 -0400
X-MC-Unique: enTQNZEIPoKx4T-Ijo5jzQ-1
Received: by mail-wm1-f71.google.com with SMTP id o67-20020a1ca5460000b0290223be6fd23dso2209200wme.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 10:08:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=/GvUXzVqBNpTYmWX6silIAbrzIkt7NivstiUqC9NAzM=;
        b=WKWKN2CvJ2urFSlAmY21vMRZwvmkYE/KJSiNoV107YJFYMgJM/q2/ra8NKMoxAEMrO
         T9PphSwkXyHkQSiADvXlxuiE2BnyhJVUwVWOGcsq75o90a8ClWuZmyD8Du0HgTelDrTj
         dlcQwMU60k+9by4svvO32tOAKf5H60YBa5iQX4m/+W67ArefDZUJ3a0HxWNXlpqChI6Q
         GmKJgLsKiKSJ9N64Zj+ZqXwLEXy15mHO1nlzjHX6HoZzJQkFZ6cM2pSAYHN4bc0bmbZY
         hRqwQBEF1IhhrQgUDt+4rssQqn6eti1sglq9EIetnjIFT9lwQaQw91IwKLAq59RcCCcJ
         jaAA==
X-Gm-Message-State: AOAM5311EsEYKdbE52G6H3xLuCTscF2coWm9P1pGdyzC8RduJe2kcIUi
        aYfTm+9C9HAkn9DTop8lLD91WuzfMvdMOvS+rWBadiZat63H8HagyLceXpy76p/ymeyREw950aL
        AVMEu6+hJ36J/c48dEyrG9VDQ
X-Received: by 2002:a05:600c:293:: with SMTP id 19mr4211153wmk.179.1628269692159;
        Fri, 06 Aug 2021 10:08:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxpG/+b2pMeozwLiwEUf9OenFHEwQndI1oxEpX71cpScaVHXoK5GX5T55V+c7A3djXlCxO+Wg==
X-Received: by 2002:a05:600c:293:: with SMTP id 19mr4211130wmk.179.1628269691924;
        Fri, 06 Aug 2021 10:08:11 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6104.dip0.t-ipconnect.de. [91.12.97.4])
        by smtp.gmail.com with ESMTPSA id e3sm10296154wrw.51.2021.08.06.10.08.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Aug 2021 10:08:11 -0700 (PDT)
To:     Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>,
        linux-mm@kvack.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>
References: <20210805190253.2795604-1-zi.yan@sent.com>
 <40982106-0eee-4e62-7ce0-c4787b0afac4@suse.cz>
 <72b317e5-c78a-f0bc-fe69-f82261ec252e@redhat.com>
 <3417eb98-36c8-5459-c83e-52f90e42a146@suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC PATCH 00/15] Make MAX_ORDER adjustable as a kernel boot time
 parameter.
Message-ID: <59c59a77-cf93-40a8-2ad5-b72d87b8815a@redhat.com>
Date:   Fri, 6 Aug 2021 19:08:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <3417eb98-36c8-5459-c83e-52f90e42a146@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.08.21 18:54, Vlastimil Babka wrote:
> On 8/6/21 6:16 PM, David Hildenbrand wrote:
>> On 06.08.21 17:36, Vlastimil Babka wrote:
>>> On 8/5/21 9:02 PM, Zi Yan wrote:
>>>> From: Zi Yan <ziy@nvidia.com>
>>>
>>>> Patch 3 restores the pfn_valid_within() check when buddy allocator can merge
>>>> pages across memory sections. The check was removed when ARM64 gets rid of holes
>>>> in zones, but holes can appear in zones again after this patchset.
>>>
>>> To me that's most unwelcome resurrection. I kinda missed it was going away and
>>> now I can't even rejoice? I assume the systems that will be bumping max_order
>>> have a lot of memory. Are they going to have many holes? What if we just
>>> sacrificed the memory that would have a hole and don't add it to buddy at all?
>>
>> I think the old implementation was just horrible and the description we have
>> here still suffers from that old crap: "but holes can appear in zones again".
>> No, it's not related to holes in zones at all. We can have MAX_ORDER -1 pages
>> that are partially a hole.
>>
>> And to be precise, "hole" here means "there is no memmap" and not "there is a
>> hole but it has a valid memmap".
> 
> Yes.
> 
>> But IIRC, we now have under SPARSEMEM always a complete memmap for a complete
>> memory sections (when talking about system RAM, ZONE_DEVICE is different but we
>> don't really care for now I think).
>>
>> So instead of introducing what we had before, I think we should look into
>> something that doesn't confuse each person that stumbles over it out there. What
>> does pfn_valid_within() even mean in the new context? pfn_valid() is most
>> probably no longer what we really want, as we're dealing with multiple sections
>> that might be online or offline; in the old world, this was different, as a
>> MAX_ORDER -1 page was completely contained in a memory section that was either
>> online or offline.
>>
>> I'd imagine something that expresses something different in the context of
>> sparsemem:
>>
>> "Some page orders, such as MAX_ORDER -1, might span multiple memory sections.
>> Each memory section has a completely valid memmap if online. Memory sections
>> might either be completely online or completely offline. pfn_to_online_page()
>> might succeed on one part of a MAX_ORDER - 1 page, but not on another part. But
>> it will certainly be consistent within one memory section."
>>
>> Further, as we know that MAX_ORDER -1 and memory sections are a power of two, we
>> can actually do a binary search to identify boundaries, instead of having to
>> check each and every page in the range.
>>
>> Is what I describe the actual reason why we introduce pfn_valid_within() ? (and
>> might better introduce something new, with a better fitting name?)
> 
> What I don't like is mainly the re-addition of pfn_valid_within() (or whatever
> we'd call it) into __free_one_page() for performance reasons, and also to
> various pfn scanners (compaction) for performance and "I must not forget to
> check this, or do I?" confusion reasons. It would be really great if we could
> keep a guarantee that memmap exists for MAX_ORDER blocks. I see two ways to
> achieve that:
> 
> 1. we create memmap for MAX_ORDER blocks, pages in sections not online are
> marked as reserved or some other state that allows us to do checks such as "is
> there a buddy? no" without accessing a missing memmap
> 2. smaller blocks than MAX_ORDER are not released to buddy allocator
> 
> I think 1 would be more work, but less wasteful in the end?

It will end up seriously messing with memory hot(un)plug. It's not 
sufficient if there is a memmap (pfn_valid()), it has to be online 
(pfn_to_online_page()) to actually have a meaning.

So you'd have to  allocate a memmap for all such memory sections, 
initialize it to all PG_Reserved ("memory hole") and mark these memory 
sections online. Further, you need memory block devices that are 
initialized and online.

So far so good, although wasteful. What happens if someone hotplugs a 
memory block that doesn't span a complete MAX_ORDER -1 page? Broken.


The only "workaround" would be requiring that MAX_ORDER - 1 cannot be 
bigger than memory blocks (memory_block_size_bytes()). The memory block 
size determines our hot(un)plug granularity and can (on some archs 
already) be determined at runtime. As both (MAX_ORDER and 
memory_block_size_bytes) would be determined at runtime, for example, by 
an admin explicitly requesting it, this might be feasible.


Memory hot(un)plug / onlining / offlining would most probably work 
naturally (although the hot(un)plug granularity is then limited to e.g., 
1GiB memory blocks). But if that's what an admin requests on the command 
line, so be it.

What might need some thought, though, is having overlapping 
sections/such memory blocks with devmem. Sub-section hotadd has to 
continue working unless we want to break some PMEM devices seriously.

-- 
Thanks,

David / dhildenb

