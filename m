Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF9E1348A67
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 08:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbhCYHsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 03:48:50 -0400
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:65488 "EHLO
        ste-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbhCYHsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 03:48:45 -0400
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 4CB603FAC2;
        Thu, 25 Mar 2021 08:48:43 +0100 (CET)
Authentication-Results: ste-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=rjjw6b5f;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
        DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
        URIBL_BLOCKED=0.001] autolearn=ham autolearn_force=no
Authentication-Results: ste-ftg-msa2.bahnhof.se (amavisd-new);
        dkim=pass (1024-bit key) header.d=shipmail.org
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id pDGIQe96YS27; Thu, 25 Mar 2021 08:48:42 +0100 (CET)
Received: by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 6B3183F8A2;
        Thu, 25 Mar 2021 08:48:40 +0100 (CET)
Received: from [10.249.254.165] (unknown [192.198.151.44])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 515933600A8;
        Thu, 25 Mar 2021 08:48:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1616658520; bh=M6Y7VQAxKQqKu/9EYXFH7+a9T3OZ0ie/KAWLd3bLZts=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=rjjw6b5fgH1LdcpVtK0ueVUajLTSvJd7xFsQYN7SPJFPF9OT/xBFD4+h4NJ3K+wWn
         g8Oi44qjXy9oB1y+OJDu+ZOueVkT7h81/iB08c0KDigaUbqUEiV3XQpP5GzPGysnM+
         o8/A/vJaZHQojYyB6lxob8XeRJAIPCLYpTIR7aH0=
Subject: Re: [RFC PATCH 1/2] mm,drm/ttm: Block fast GUP to TTM huge pages
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <YFsM23t2niJwhpM/@phenom.ffwll.local>
 <20210324122430.GW2356281@nvidia.com>
 <e12e2c49-afaf-dbac-b18c-272c93c83e06@shipmail.org>
 <20210324124127.GY2356281@nvidia.com>
 <6c9acb90-8e91-d8af-7abd-e762d9a901aa@shipmail.org>
 <20210324134833.GE2356281@nvidia.com>
 <0b984f96-00fb-5410-bb16-02e12b2cc024@shipmail.org>
 <20210324163812.GJ2356281@nvidia.com>
 <08f19e80-d6cb-8858-0c5d-67d2e2723f72@amd.com>
 <730eb2ff-ba98-2393-6d42-61735e3c6b83@shipmail.org>
 <20210324231419.GR2356281@nvidia.com>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28Intel=29?= 
        <thomas_os@shipmail.org>
Message-ID: <607ecbeb-e8a5-66e9-6fe2-9a8d22f12bc2@shipmail.org>
Date:   Thu, 25 Mar 2021 08:48:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210324231419.GR2356281@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/25/21 12:14 AM, Jason Gunthorpe wrote:
> On Wed, Mar 24, 2021 at 09:07:53PM +0100, Thomas Hellström (Intel) wrote:
>> On 3/24/21 7:31 PM, Christian König wrote:
>>>
>>> Am 24.03.21 um 17:38 schrieb Jason Gunthorpe:
>>>> On Wed, Mar 24, 2021 at 04:50:14PM +0100, Thomas Hellström (Intel)
>>>> wrote:
>>>>> On 3/24/21 2:48 PM, Jason Gunthorpe wrote:
>>>>>> On Wed, Mar 24, 2021 at 02:35:38PM +0100, Thomas Hellström
>>>>>> (Intel) wrote:
>>>>>>
>>>>>>>> In an ideal world the creation/destruction of page
>>>>>>>> table levels would
>>>>>>>> by dynamic at this point, like THP.
>>>>>>> Hmm, but I'm not sure what problem we're trying to solve
>>>>>>> by changing the
>>>>>>> interface in this way?
>>>>>> We are trying to make a sensible driver API to deal with huge pages.
>>>>>>> Currently if the core vm requests a huge pud, we give it
>>>>>>> one, and if we
>>>>>>> can't or don't want to (because of dirty-tracking, for
>>>>>>> example, which is
>>>>>>> always done on 4K page-level) we just return
>>>>>>> VM_FAULT_FALLBACK, and the
>>>>>>> fault is retried at a lower level.
>>>>>> Well, my thought would be to move the pte related stuff into
>>>>>> vmf_insert_range instead of recursing back via VM_FAULT_FALLBACK.
>>>>>>
>>>>>> I don't know if the locking works out, but it feels cleaner that the
>>>>>> driver tells the vmf how big a page it can stuff in, not the vm
>>>>>> telling the driver to stuff in a certain size page which it might not
>>>>>> want to do.
>>>>>>
>>>>>> Some devices want to work on a in-between page size like 64k so they
>>>>>> can't form 2M pages but they can stuff 64k of 4K pages in a batch on
>>>>>> every fault.
>>>>> Hmm, yes, but we would in that case be limited anyway to insert ranges
>>>>> smaller than and equal to the fault size to avoid extensive and
>>>>> possibly
>>>>> unnecessary checks for contigous memory.
>>>> Why? The insert function is walking the page tables, it just updates
>>>> things as they are. It learns the arragement for free while doing the
>>>> walk.
>>>>
>>>> The device has to always provide consistent data, if it overlaps into
>>>> pages that are already populated that is fine so long as it isn't
>>>> changing their addresses.
>>>>
>>>>> And then if we can't support the full fault size, we'd need to
>>>>> either presume a size and alignment of the next level or search for
>>>>> contigous memory in both directions around the fault address,
>>>>> perhaps unnecessarily as well.
>>>> You don't really need to care about levels, the device should be
>>>> faulting in the largest memory regions it can within its efficiency.
>>>>
>>>> If it works on 4M pages then it should be faulting 4M pages. The page
>>>> size of the underlying CPU doesn't really matter much other than some
>>>> tuning to impact how the device's allocator works.
>> Yes, but then we'd be adding a lot of complexity into this function that is
>> already provided by the current interface for DAX, for little or no gain, at
>> least in the drm/ttm setting. Please think of the following situation: You
>> get a fault, you do an extensive time-consuming scan of your VRAM buffer
>> object into which the fault goes and determine you can fault 1GB. Now you
>> hand it to vmf_insert_range() and because the user-space address is
>> misaligned, or already partly populated because of a previous eviction, you
>> can only fault single pages, and you end up faulting a full GB of single
>> pages perhaps for a one-time small update.
> Why would "you can only fault single pages" ever be true? If you have
> 1GB of pages then the vmf_insert_range should allocate enough page
> table entries to consume it, regardless of alignment.

Ah yes, What I meant was you can only insert PTE size entries, either 
because of misalignment or because the page-table is alredy 
pre-populated with pmd size page directories, which you can't remove 
with only the read side of the mmap lock held.

>
> And why shouldn't DAX switch to this kind of interface anyhow? It is
> basically exactly the same problem. The underlying filesystem block
> size is *not* necessarily aligned to the CPU page table sizes and DAX
> would benefit from better handling of this mismatch.

First, I think we must sort out what "better handling" means. This is my 
takeout of the discussion so far:

Claimed Pros: of vmf_insert_range()
* We get an interface that doesn't require knowledge of CPU page table 
entry level sizes.
* We get the best efficiency when we look at what the GPU driver 
provides. (I disagree on this one).

Claimed Cons:
* A new implementation that may get complicated particularly if it 
involves modifying all of the DAX code
* The driver would have to know about those sizes anyway to get 
alignment right (Applies to DRM, because we mmap buffer objects, not 
physical address ranges. But not to DAX AFAICT),
* We loose efficiency, because we are prepared to spend an extra effort 
for alignment- and continuity checks when we know we can insert a huge 
page table entry, but not if we know we can't
* We loose efficiency because we might unnecessarily prefault a number 
of PTE size page-table entries (really a special case of the above one).

Now in the context of quickly fixing a critical bug, the choice IMHO 
becomes easy.

>
>> On top of this, unless we want to do the walk trying increasingly smaller
>> sizes of vmf_insert_xxx(), we'd have to use apply_to_page_range() and teach
>> it about transhuge page table entries, because pagewalk.c can't be used (It
>> can't populate page tables). That also means apply_to_page_range() needs to
>> be complicated with page table locks since transhuge pages aren't stable and
>> can be zapped and refaulted under us while we do the walk.
> I didn't say it would be simple :) But we also need to stop hacking
> around the sides of all this huge page stuff and come up with sensible
> APIs that drivers can actually implement correctly. Exposing drivers
> to specific kinds of page levels really feels like the wrong level of
> abstraction.

I generally agree. But for the last sentence I think the potential gain 
must be carefully weighed against the efficiency arguments.

>
> Once we start doing this we should do it everywhere, the io_remap_pfn
> stuff should be able to create huge special IO pages as well, for
> instance.

I agree here as well. Here we can be more agressive as the contigous 
range is already known and we IIRC hold the mmap lock in write mode.

>   
>> On top of this, the user-space address allocator needs to know how large gpu
>> pages are aligned in buffer objects to have a reasonable chance of aligning
>> with CPU huge page boundaries which is a requirement to be able to insert a
>> huge CPU page table entry, so the driver would basically need the drm helper
>> that can do this alignment anyway.
> Don't you have this problem anyhow?

Yes, but it sort of defeats the simplicity argument of the proposed 
interface change.

/Thomas


