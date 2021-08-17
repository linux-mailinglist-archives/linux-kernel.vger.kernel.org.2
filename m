Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA803EF236
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 20:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233178AbhHQSrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 14:47:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43331 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233159AbhHQSrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 14:47:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629226010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/UVqS9He4itCTfHUpyw05N/OnhkuV6wfA8Bz/uBk6FQ=;
        b=LYaqWQL2tqos0X+JEqOmN3O/xebjoP4Kv4Q7SbPkFHIN8d0N8K0JndQi+NMZyc6iYNnFgp
        1UNiJJsTVBTXRqAbv6VpwM54IXk7+MlFQrw65KYR3k2e3v1iGG61jnp9DcLI5EypWZExve
        3Xy0Q5oT4wfeRUDSywlDjyZY74TmcmM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-501-CgKsuuMRMhSuDbwOxiuWPA-1; Tue, 17 Aug 2021 14:46:49 -0400
X-MC-Unique: CgKsuuMRMhSuDbwOxiuWPA-1
Received: by mail-wr1-f70.google.com with SMTP id y12-20020adfee0c0000b0290154e82fef34so6944934wrn.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 11:46:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=/UVqS9He4itCTfHUpyw05N/OnhkuV6wfA8Bz/uBk6FQ=;
        b=LFAKwAN89xf38KXx8iih9Ug7ev2pq9L2f1iBQp9KDnp0eOGnVxUhYsvkdv2fWG2IuK
         WCuDLiDj/baM+ssUa7OY8lZgEPB4S3SK2B8W6pxiNi59djqU2X+aPPc4JrZ9yvMZQ30A
         KO8J5iTguHMUO28z5T9fhMRiT0C0zCc1rWntHJtIgviz4REkcV0t2wJbV+XgS6tBFwDz
         GC60vnMnwEuZ37n/3ApYtryNM/5A7u6eMsWtzjyW8SIJf8MNfS7csJxvHZB3Q+Jlp4o4
         T1jiHAzlKeM4MM+Yjt6l4PixWkMaafVUHm8htCSfSRD0mT5TcGekJNUIwMd6oCKXGB3F
         OcYg==
X-Gm-Message-State: AOAM53088V64A/1pN1iJE46/ObNzePjcgsLGUGSlxumAqR8OxW2X9Zy/
        3F8aeuCt9A8Y0NAmt1EP8dWiywty9GrmeaT9VjyPsJnn3ESBRx0JqkKjl/Md5Aaje/p4n0gyYXt
        oTp1MwPO1pU9+RoHxdbw71GCK
X-Received: by 2002:a1c:1b49:: with SMTP id b70mr4829467wmb.17.1629226007793;
        Tue, 17 Aug 2021 11:46:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwm3rNL9I4of8er/rHFIJ8C+gP/qgnzqSrsgHJlR5+16MRnj1wh0eisiIpRId4UiO+ygsUfWg==
X-Received: by 2002:a1c:1b49:: with SMTP id b70mr4829450wmb.17.1629226007487;
        Tue, 17 Aug 2021 11:46:47 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c65c6.dip0.t-ipconnect.de. [91.12.101.198])
        by smtp.gmail.com with ESMTPSA id b12sm4015900wrx.72.2021.08.17.11.46.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Aug 2021 11:46:46 -0700 (PDT)
From:   David Hildenbrand <david@redhat.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Alistair Popple <apopple@nvidia.com>,
        Tiberiu Georgescu <tiberiu.georgescu@nutanix.com>,
        ivan.teterevkov@nutanix.com,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
References: <20210807032521.7591-1-peterx@redhat.com>
 <16a765e7-c2a3-982a-e585-c04067766e3f@redhat.com> <YRvtPrPmAorX+KY5@t490s>
Organization: Red Hat
Subject: Re: [PATCH RFC 0/4] mm: Enable PM_SWAP for shmem with PTE_MARKER
Message-ID: <c4adbba1-2299-f87c-1893-e83af9beadbc@redhat.com>
Date:   Tue, 17 Aug 2021 20:46:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YRvtPrPmAorX+KY5@t490s>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>
>> For uffd-wp in its current form, it would certainly be the way to go I
>> think. AFAIKT, the idea of special swap entries isn't new, just that it's
>> limited to anonymous memory for now, which makes things like fork and new
>> mappings a lot cheaper.
> 
> Thanks for reviewing this series separately; yes I definitely wanted to get
> comments on both sides: one on the pte marker idea, the other is whether it's
> applicable to this swap+shmem use case.

Exactly.

> 
> Here I really want to make the pte marker be flexible - it can be strict when
> necessary (it will be 100% strict with uffd-wp), then it can also be a hint
> just like what we have with available ptes on soft-dirty, idle, accessed bits.
> Here the swap bit I wanted to make it that kind, so we add zero overhead to
> fork() and we still solve problems.
> 
> Same thing to "newly mapped shmem".  Do we have a use case for that?  If that's
> a hint bit, can we ignore it?

I am really not a fan of taking an already broken feature (broken 
presence information for shmem in pagemap) and instead of fixing it 
properly, turning it less broken, crossing fingers that nobody will 
notice the remaining (undocumented) cases.

[...]

>> As already expressed, we should try storing as little information in page
>> tables as possible if we're dealing with shared memory. The features we
>> design around this all seem to over-complicate the actual users,
>> over-complicate fork, over-complicate handling on new mappings.
> 
> I'll skip the last two "over-complicated" items, because as we've discussed I
> don't think we need to take care of them so far.  We can revisit when they
> become some kind of requirement.
> 
> To me having PM_SWAP 99% right on shmem is still a progress comparing to
> completely missing it, even if it's not 100% right.  It's used for performance
> reasons on PAGEOUT and doing finer-grained memory control from userspace, it's
> not a strict requirement.
> 
> So I still cannot strictly follow why storing information in pte is so bad for
> file-backed, which I can see you really don't like it.  Could you share some
> detailed example?

I am not a fan of your approach of "hints", because while it might work 
for some use cases, it might not work for others (see below for CRIU); I 
would rather like to avoid such "inconsistent caches" where it's not 
really required. But again, this is just my opinion and there might be 
plenty other people that will most probably disagree.

Storing hints in page tables isn't actually that bad, because we can 
drop hints whenever we like (well, there are side effects, and once we 
drop hints too often people might complain again) -- for example, when 
reclaiming "empty" but actually "filled with hints" page tables. When we 
rely on consistent values, fork() and mmap() are a problem. Well, and 
page tables will have to stick around. At least for uffd-wp, mmap() is 
not an issue, and we don't expect too many uffd-wp users such that page 
table consumption would matter -- my guess.

So I repeat, for uffd-wp in its current form, it sounds like the right 
thing to do.

>> But I guess I'm biased at this point because the main users of these
>> features actually want to query/set such properties for all sharers, not
>> individual processes; so the opinion of others would be appreciated.
>>
>>>
>>> Known Issues/Concerns
>>> =====================
>>>
>>> About THP
>>> ---------
>>>
>>> Currently we don't need to worry about THP because paged out shmem pages will
>>> be split when shrinking, IOW we only need to consider PTE, and the markers will
>>> only be applied to a shmem pte not pmd or bigger.
>>>
>>> About PM_SWAP Accuracy
>>> ----------------------
>>>
>>> This is not an "accurate" solution to provide PM_SWAP bit.  Two exmaples:
>>>
>>>     - When process A & B both map shmem page P somewhere, it can happen that only
>>>       one of these ptes got marked with the pte marker.  Imagine below sequence:
>>>
>>>       0. Process A & B both map shmem page P somewhere
>>>       1. Process A zap pte of page P for some reason (e.g. thp split)
>>>       2. System decides to recycle page P
>>>       3. System replace process B's pte (pointed to P) by PTE marker
>>>       4. System _didn't_ replace process A's pte because it was none pte, and
>>>          it'll continue to be none pte
>>>       5. Only process B's relevant pte has the PTE marker after P swapped out
>>>
>>>     - When fork, we don't copy shmem vma ptes, including the pte markers.  So
>>>       even if page P was swapped out, only the parent process has the pte marker
>>>       installed, in child it'll be none pte if fork() happened after pageout.
>>>
>>> Conclusion: just like it used to be, the PM_SWAP is best-effort.  But it should
>>> work in 99.99% cases and it should already start to solve problems.
>>
>> At least I don't like these semantics at all. PM_SWAP is a cached value
>> which might be under-represented and consequently wrong.
> 
> Please have a look at current pagemap impl in pte_to_pagemap_entry().  It's not
> accurate from the 1st day, imho.  E.g., when a page is being migrated from numa
> node 1 to node 2, we'll mark it PM_SWAP but I think it's not the case.  We can
> make it more accurate, but I think it's fine, because it's a hint.

That inconsistency doesn't really matter as you can determine if 
something is present and worth dumping if it's either swapped or 
present. As long as it's one of both but not simply nothing.

I will shamelessly reference 
tools/testing/selftests/vm/madv_populate.c:pagemap_is_populated() that 
checks exactly for that (the test case uses only private anonymous memory).

> 
>> Take CRIU as an example, it has to be correct even if a process would remap a
>> memory region, fork() and unmap in the parent as far as I understand, ...
> 
> Are you talking about dirty bit or swap bit?  I'm a bit confused on why swap
> bit needs to be accurate.  Maybe you mean the dirty bit?

https://criu.org/Shared_memory

"Dumping present pages"

"... CRIU does not dump all of the data. Instead, it determines which 
pages contain it, and only dumps those pages. This is done similarly to 
how regular memory dumping and restoring works, i.e. by looking for 
PRESENT or SWAPPED bits in owners' pagemap entries."

-> Neither PRESENT nor SWAPPED results in memory not getting dumped, 
which makes perfect sense.

1) Process A sets up shared memory and writes data to it.
2) System swaps out memory, hints are setup.
3) Process A forks Process B, hints are not copied.
4) Process A unmaps shared memory, hints are dropped.
5) CRIU migrates process A and B and migrates only PRESENT or SWAPPED in 
pagemap.
6) Process B uses memory in shared memory region. Pages were not migrated.

Just one example; feel free to correct me.


There is notion of the mincore() systemcall:

"There is one particular feature of shared memory dumps worth 
mentioning. Sometimes, a shared memory page can exist in the kernel, but 
it is not mapped to any process. CRIU detects such pages by calling 
mincore() on the shmem segment, which reports back the page in-memory 
status. The mincore bitmap is when ANDed with the per-process ones. "

Not sure if they actually mean ORed, because otherwise they'd be losing 
pages that have been swapped out. "mincore() returns a vector that 
indicates whether pages of the calling process's virtual memory are 
resident in core (RAM)"

-- 
Thanks,

David / dhildenb


