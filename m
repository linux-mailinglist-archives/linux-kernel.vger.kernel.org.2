Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 680C944D6AF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 13:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233311AbhKKMfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 07:35:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233274AbhKKMfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 07:35:38 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637AEC061766
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 04:32:49 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id z6so5489202pfe.7
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 04:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=N9eWrGMaTS7mIY9Ow3VHOpPVUK2E0L1tukxlTfZow/I=;
        b=0DCmcveGGlFkJ6nj1QVG7Pj/jIAVjn7kPov9weG3UvqT8F0hvEstw+o0v12mpnlitN
         n8scT97+kJmkNEdr/1/PG6GcF1illpYNK8gGUe3KIJSlXid/dAfIjlzjizeqRLrU76fx
         JJDPQJumxFsIAXPN8jjlFER29TRiwr2YUrrXCEX7egZUdjm5l/iI3vPZCTpRkmTfGaIa
         7AhYSvPMi4BQ4NOV1LiU0rjZ9Qq1CavRL0l18hI6fIOp27/KcuCv1mTJLMnw0iuaGPPQ
         XnH1ROgwnLtx8bcbkasc/TeLPH9jUEqevAuIuK9z6mar7eYpn10wFLVlHXMH4eeoNhSb
         cGrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=N9eWrGMaTS7mIY9Ow3VHOpPVUK2E0L1tukxlTfZow/I=;
        b=V8/Cg4/oCyWS56B7ROGfvc1tk086+TgYsYiBYSAYljm0/oTgmtkzlhGrEJbREYOUIU
         KOeYaxxinaSPH9dvKlIOaSKtp4zUeEOhYtpGasj1KpBNGZlDAhBTZef+k80zMxs9y00t
         LcS6uqc469gAuQIWbHTswYci/SvNKGpVYAHHL+Sor990a1W0Lgbjso7aNTx8fu/P+WwI
         pJG2bD+I0Dx2FY1lIgq+ZwpFeDTRuljNelE78KgWNPngWdUHpqH67/8zoj0kMx3CsIYP
         av27ST4W5+AcEDZrAVejvcDGIMfrtjKyaMt5CCIHF76X3zJrWySa2f/d/2xPpRBVRU6l
         ngQw==
X-Gm-Message-State: AOAM5312c1FzEg/MTua5dcUFq9+ESQ3B0HEgg8+9CRmodlNGGQbIXb7P
        Bw/ZCCDpKndsVt/VfrJd/P0Y/dNyra+bNQ==
X-Google-Smtp-Source: ABdhPJyiZWEFxYBGLynrCfVHBE7mGR89TDDZMx2f07TTTneXkPh/suRRqCYTj58MFolNEg3awLnFTA==
X-Received: by 2002:a05:6a00:1a8d:b0:49f:de63:d9c0 with SMTP id e13-20020a056a001a8d00b0049fde63d9c0mr6089092pfv.79.1636633968816;
        Thu, 11 Nov 2021 04:32:48 -0800 (PST)
Received: from [10.254.173.217] ([139.177.225.248])
        by smtp.gmail.com with ESMTPSA id j17sm3327330pfj.55.2021.11.11.04.32.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Nov 2021 04:32:48 -0800 (PST)
Message-ID: <791ddf94-5ad1-b431-85a1-db9a07579057@bytedance.com>
Date:   Thu, 11 Nov 2021 20:32:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [PATCH v3 00/15] Free user PTE page table pages
To:     David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     akpm@linux-foundation.org, tglx@linutronix.de,
        kirill.shutemov@linux.intel.com, mika.penttila@nextfour.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, songmuchun@bytedance.com,
        zhouchengming@bytedance.com
References: <20211110105428.32458-1-zhengqi.arch@bytedance.com>
 <20211110125601.GQ1740502@nvidia.com>
 <8d0bc258-58ba-52c5-2e0d-a588489f2572@redhat.com>
 <20211110143859.GS1740502@nvidia.com>
 <6ac9cc0d-7dea-0e19-51b3-625ec6561ac7@redhat.com>
 <20211110163925.GX1740502@nvidia.com>
 <7c97d86f-57f4-f764-3e92-1660690a0f24@redhat.com>
 <60515562-5f93-11cd-6c6a-c7cc92ff3bf8@bytedance.com>
 <a052e0ba-a22c-5df1-80b8-d847efacd66e@redhat.com>
 <9ee06b52-4844-7996-fa34-34fc7d4fdc10@bytedance.com>
 <27d73395-70b4-fe4a-4c8d-415b43ff9c1f@redhat.com>
 <2e19ad1b-15f3-7508-c5d5-6c31765f26d3@bytedance.com>
 <1489f02f-d024-b9ec-2ab6-e6efc8a022f1@redhat.com>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <1489f02f-d024-b9ec-2ab6-e6efc8a022f1@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/11/21 8:20 PM, David Hildenbrand wrote:
> On 11.11.21 13:00, Qi Zheng wrote:
>>
>>
>> On 11/11/21 7:19 PM, David Hildenbrand wrote:
>>> On 11.11.21 12:08, Qi Zheng wrote:
>>>>
>>>>
>>>> On 11/11/21 5:22 PM, David Hildenbrand wrote:
>>>>> On 11.11.21 04:58, Qi Zheng wrote:
>>>>>>
>>>>>>
>>>>>> On 11/11/21 1:37 AM, David Hildenbrand wrote:
>>>>>>>>> It would still be a fairly coarse-grained locking, I am not sure if that
>>>>>>>>> is a step into the right direction. If you want to modify *some* page
>>>>>>>>> table in your process you have exclude each and every page table walker.
>>>>>>>>> Or did I mis-interpret what you were saying?
>>>>>>>>
>>>>>>>> That is one possible design, it favours fast walking and penalizes
>>>>>>>> mutation. We could also stick a lock in the PMD (instead of a
>>>>>>>> refcount) and still logically be using a lock instead of a refcount
>>>>>>>> scheme. Remember modify here is "want to change a table pointer into a
>>>>>>>> leaf pointer" so it isn't an every day activity..
>>>>>>>
>>>>>>> It will be if we somewhat frequent when reclaim an empty PTE page table
>>>>>>> as soon as it turns empty. This not only happens when zapping, but also
>>>>>>> during writeback/swapping. So while writing back / swapping you might be
>>>>>>> left with empty page tables to reclaim.
>>>>>>>
>>>>>>> Of course, this is the current approach. Another approach that doesn't
>>>>>>> require additional refcounts is scanning page tables for empty ones and
>>>>>>> reclaiming them. This scanning can either be triggered manually from
>>>>>>> user space or automatically from the kernel.
>>>>>>
>>>>>> Whether it is introducing a special rwsem or scanning an empty page
>>>>>> table, there are two problems as follows:
>>>>>>
>>>>>> 	#1. When to trigger the scanning or releasing?
>>>>>
>>>>> For example when reclaiming memory, when scanning page tables in
>>>>> khugepaged, or triggered by user space (note that this is the approach I
>>>>> originally looked into). But it certainly requires more locking thought
>>>>> to avoid stopping essentially any page table walker.
>>>>>
>>>>>> 	#2. Every time to release a 4K page table page, 512 page table
>>>>>> 	    entries need to be scanned.
>>>>>
>>>>> It would happen only when actually trigger reclaim of page tables
>>>>> (again, someone has to trigger it), so it's barely an issue.
>>>>>
>>>>> For example, khugepaged already scans the page tables either way.
>>>>>
>>>>>>
>>>>>> For #1, if the scanning is triggered manually from user space, the
>>>>>> kernel is relatively passive, and the user does not fully know the best
>>>>>> timing to scan. If the scanning is triggered automatically from the
>>>>>> kernel, that is great. But the timing is not easy to confirm, is it
>>>>>> scanned and reclaimed every time zap or try_to_unmap?
>>>>>>
>>>>>> For #2, refcount has advantages.
>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>> There is some advantage with this thinking because it harmonizes well
>>>>>>>> with the other stuff that wants to convert tables into leafs, but has
>>>>>>>> to deal with complicated locking.
>>>>>>>>
>>>>>>>> On the other hand, refcounts are a degenerate kind of rwsem and only
>>>>>>>> help with freeing pages. It also puts more atomics in normal fast
>>>>>>>> paths since we are refcounting each PTE, not read locking the PMD.
>>>>>>>>
>>>>>>>> Perhaps the ideal thing would be to stick a rwsem in the PMD. read
>>>>>>>> means a table cannot be come a leaf. I don't know if there is space
>>>>>>>> for another atomic in the PMD level, and we'd have to use a hitching
>>>>>>>> post/hashed waitq scheme too since there surely isn't room for a waitq
>>>>>>>> too..
>>>>>>>>
>>>>>>>> I wouldn't be so quick to say one is better than the other, but at
>>>>>>>> least let's have thought about a locking solution before merging
>>>>>>>> refcounts :)
>>>>>>>
>>>>>>> Yes, absolutely. I can see the beauty in the current approach, because
>>>>>>> it just reclaims "automatically" once possible -- page table empty and
>>>>>>> nobody is walking it. The downside is that it doesn't always make sense
>>>>>>> to reclaim an empty page table immediately once it turns empty.
>>>>>>>
>>>>>>> Also, it adds complexity for something that is only a problem in some
>>>>>>> corner cases -- sparse memory mappings, especially relevant for some
>>>>>>> memory allocators after freeing a lot of memory or running VMs with
>>>>>>> memory ballooning after inflating the balloon. Some of these use cases
>>>>>>> might be good with just triggering page table reclaim manually from user
>>>>>>> space.
>>>>>>>
>>>>>>
>>>>>> Yes, this is indeed a problem. Perhaps some flags can be introduced so
>>>>>> that the release of page table pages can be delayed in some cases.
>>>>>> Similar to the lazyfree mechanism in MADV_FREE?
>>>>>
>>>>> The issue AFAIU is that once your refcount hits 0 (no more references,
>>>>> no more entries), the longer you wait with reclaim, the longer others
>>>>> have to wait for populating a fresh page table because the "page table
>>>>> to be reclaimed" is still stuck around. You'd have to keep the refcount
>>>>> increased for a while, and only drop it after a while. But when? And
>>>>> how? IMHO it's not trivial, but maybe there is an easy way to achieve it.
>>>>>
>>>>
>>>> For running VMs with memory ballooning after inflating the balloon, is
>>>> this a hot behavior? Even if it is, it is already facing the release and
>>>> reallocation of physical pages. The overhead after introducing
>>>> pte_refcount is that we need to release and re-allocate page table page.
>>>> But 2MB physical pages only corresponds to 4KiB of PTE page table page.
>>>> So maybe the overhead is not big.
>>>
>>> The cases that come to my mind are
>>>
>>> a) Swapping on shared memory with concurrent access
>>> b) Reclaim on file-backed memory with concurrent access
>>> c) Free page reporting as implemented by virtio-balloon
>>>
>>> In all of these cases, you can have someone immediately re-access the
>>> page table and re-populate it.
>>
>> In the performance test shown on the cover, we repeatedly performed
>> touch and madvise(MADV_DONTNEED) actions, which simulated the case
>> you said above.
>>
>> We did find a small amount of performance regression, but I think it is
>> acceptable, and no new perf hotspots have been added.
> 
> That test always accesses 2MiB and does it from a single thread. Things
> might (IMHO will) look different when only accessing individual pages
> and doing the access from one/multiple separate threads (that's what

No, it includes multi-threading:

	while (1) {
		char *c;
		char *start = mmap_area[cpu];
		char *end = mmap_area[cpu] + FAULT_LENGTH;
		pthread_barrier_wait(&barrier);
		//printf("fault into %p-%p\n",start, end);

		for (c = start; c < end; c += PAGE_SIZE)
			*c = 0;

		pthread_barrier_wait(&barrier);
		for (i = 0; cpu==0 && i < num; i++)
			madvise(mmap_area[i], FAULT_LENGTH, MADV_DONTNEED);
		pthread_barrier_wait(&barrier);
	}

Thread on cpu0 will use madvise(MADV_DONTNEED) to release the physical
memory of threads on other cpu.

> a),b) and c) essentially do, they don't do it in the pattern you
> measured. what you measured matches rather a typical memory allocator).
> 
> 
