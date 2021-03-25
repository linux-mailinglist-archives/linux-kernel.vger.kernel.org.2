Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 600B4348D65
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 10:52:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbhCYJwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 05:52:11 -0400
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:19302 "EHLO
        ste-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbhCYJvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 05:51:42 -0400
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id E9F543F741;
        Thu, 25 Mar 2021 10:51:40 +0100 (CET)
Authentication-Results: ste-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=qiMGMepD;
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
        with ESMTP id vAReIesnAhFI; Thu, 25 Mar 2021 10:51:39 +0100 (CET)
Received: by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 1D2003F492;
        Thu, 25 Mar 2021 10:51:37 +0100 (CET)
Received: from [10.249.254.165] (unknown [192.198.151.44])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 1AE563600A8;
        Thu, 25 Mar 2021 10:51:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1616665897; bh=WCKbFkGWBwAkKKUJflucqzb+FagoWI5lSIX7EGlYCNs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=qiMGMepDGGsEet51B2YyUgoqeCNa1KrerqEw9jc8pUsFpK2msThYncgxxULvngT4B
         l8IyZ78gIJFnYjw+sZ+DhE6hC59Uq7VP/FiaepV5ux3rhnfWCf0PuXZxIJUnYQ9auu
         wBeh/K83tVhKAahv46rULBpPFI+PazfdWM3wg+gs=
Subject: Re: [RFC PATCH 1/2] mm,drm/ttm: Block fast GUP to TTM huge pages
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
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
 <607ecbeb-e8a5-66e9-6fe2-9a8d22f12bc2@shipmail.org>
 <fb74efd9-55be-9a8d-95b0-6103e263aab8@amd.com>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28Intel=29?= 
        <thomas_os@shipmail.org>
Message-ID: <15da5784-96ca-25e5-1485-3ce387ee6695@shipmail.org>
Date:   Thu, 25 Mar 2021 10:51:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <fb74efd9-55be-9a8d-95b0-6103e263aab8@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/25/21 9:27 AM, Christian König wrote:
> Am 25.03.21 um 08:48 schrieb Thomas Hellström (Intel):
>>
>> On 3/25/21 12:14 AM, Jason Gunthorpe wrote:
>>> On Wed, Mar 24, 2021 at 09:07:53PM +0100, Thomas Hellström (Intel) 
>>> wrote:
>>>> On 3/24/21 7:31 PM, Christian König wrote:
>>>>>
>>>>> Am 24.03.21 um 17:38 schrieb Jason Gunthorpe:
>>>>>> On Wed, Mar 24, 2021 at 04:50:14PM +0100, Thomas Hellström (Intel)
>>>>>> wrote:
>>>>>>> On 3/24/21 2:48 PM, Jason Gunthorpe wrote:
>>>>>>>> On Wed, Mar 24, 2021 at 02:35:38PM +0100, Thomas Hellström
>>>>>>>> (Intel) wrote:
>>>>>>>>
>>>>>>>>>> In an ideal world the creation/destruction of page
>>>>>>>>>> table levels would
>>>>>>>>>> by dynamic at this point, like THP.
>>>>>>>>> Hmm, but I'm not sure what problem we're trying to solve
>>>>>>>>> by changing the
>>>>>>>>> interface in this way?
>>>>>>>> We are trying to make a sensible driver API to deal with huge 
>>>>>>>> pages.
>>>>>>>>> Currently if the core vm requests a huge pud, we give it
>>>>>>>>> one, and if we
>>>>>>>>> can't or don't want to (because of dirty-tracking, for
>>>>>>>>> example, which is
>>>>>>>>> always done on 4K page-level) we just return
>>>>>>>>> VM_FAULT_FALLBACK, and the
>>>>>>>>> fault is retried at a lower level.
>>>>>>>> Well, my thought would be to move the pte related stuff into
>>>>>>>> vmf_insert_range instead of recursing back via VM_FAULT_FALLBACK.
>>>>>>>>
>>>>>>>> I don't know if the locking works out, but it feels cleaner 
>>>>>>>> that the
>>>>>>>> driver tells the vmf how big a page it can stuff in, not the vm
>>>>>>>> telling the driver to stuff in a certain size page which it 
>>>>>>>> might not
>>>>>>>> want to do.
>>>>>>>>
>>>>>>>> Some devices want to work on a in-between page size like 64k so 
>>>>>>>> they
>>>>>>>> can't form 2M pages but they can stuff 64k of 4K pages in a 
>>>>>>>> batch on
>>>>>>>> every fault.
>>>>>>> Hmm, yes, but we would in that case be limited anyway to insert 
>>>>>>> ranges
>>>>>>> smaller than and equal to the fault size to avoid extensive and
>>>>>>> possibly
>>>>>>> unnecessary checks for contigous memory.
>>>>>> Why? The insert function is walking the page tables, it just updates
>>>>>> things as they are. It learns the arragement for free while doing 
>>>>>> the
>>>>>> walk.
>>>>>>
>>>>>> The device has to always provide consistent data, if it overlaps 
>>>>>> into
>>>>>> pages that are already populated that is fine so long as it isn't
>>>>>> changing their addresses.
>>>>>>
>>>>>>> And then if we can't support the full fault size, we'd need to
>>>>>>> either presume a size and alignment of the next level or search for
>>>>>>> contigous memory in both directions around the fault address,
>>>>>>> perhaps unnecessarily as well.
>>>>>> You don't really need to care about levels, the device should be
>>>>>> faulting in the largest memory regions it can within its efficiency.
>>>>>>
>>>>>> If it works on 4M pages then it should be faulting 4M pages. The 
>>>>>> page
>>>>>> size of the underlying CPU doesn't really matter much other than 
>>>>>> some
>>>>>> tuning to impact how the device's allocator works.
>>>> Yes, but then we'd be adding a lot of complexity into this function 
>>>> that is
>>>> already provided by the current interface for DAX, for little or no 
>>>> gain, at
>>>> least in the drm/ttm setting. Please think of the following 
>>>> situation: You
>>>> get a fault, you do an extensive time-consuming scan of your VRAM 
>>>> buffer
>>>> object into which the fault goes and determine you can fault 1GB. 
>>>> Now you
>>>> hand it to vmf_insert_range() and because the user-space address is
>>>> misaligned, or already partly populated because of a previous 
>>>> eviction, you
>>>> can only fault single pages, and you end up faulting a full GB of 
>>>> single
>>>> pages perhaps for a one-time small update.
>>> Why would "you can only fault single pages" ever be true? If you have
>>> 1GB of pages then the vmf_insert_range should allocate enough page
>>> table entries to consume it, regardless of alignment.
>>
>> Ah yes, What I meant was you can only insert PTE size entries, either 
>> because of misalignment or because the page-table is alredy 
>> pre-populated with pmd size page directories, which you can't remove 
>> with only the read side of the mmap lock held.
>
> Please explain that further. Why do we need the mmap lock to insert 
> PMDs but not when insert PTEs?

We don't. But once you've inserted a PMD directory you can't remove it 
unless you have the mmap lock (and probably also the i_mmap_lock in 
write mode). That for example means that if you have a VRAM region 
mapped with huge PMDs, and then it gets evicted, and you happen to read 
a byte from it when it's evicted and therefore populate the full region 
with PTEs pointing to system pages, you can't go back to huge PMDs again 
without a munmap() in between.

>
>>> And why shouldn't DAX switch to this kind of interface anyhow? It is
>>> basically exactly the same problem. The underlying filesystem block
>>> size is *not* necessarily aligned to the CPU page table sizes and DAX
>>> would benefit from better handling of this mismatch.
>>
>> First, I think we must sort out what "better handling" means. This is 
>> my takeout of the discussion so far:
>>
>> Claimed Pros: of vmf_insert_range()
>> * We get an interface that doesn't require knowledge of CPU page 
>> table entry level sizes.
>> * We get the best efficiency when we look at what the GPU driver 
>> provides. (I disagree on this one).
>>
>> Claimed Cons:
>> * A new implementation that may get complicated particularly if it 
>> involves modifying all of the DAX code
>> * The driver would have to know about those sizes anyway to get 
>> alignment right (Applies to DRM, because we mmap buffer objects, not 
>> physical address ranges. But not to DAX AFAICT),
>
> I don't think so. We could just align all buffers to their next power 
> of two in size. Since we have plenty of offset space that shouldn't 
> matter much.
It's not offset space like in drm fake offsets, but virtual address 
space. But I guess we have plenty of that as well.
>
> Apart from that I still don't fully get why we need this in the first 
> place.

Because virtual huge page address boundaries need to be aligned with 
physical huge page address boundaries, and mmap can happen before bos 
are populated so you have no way of knowing how physical huge page 
address boundaries are laid out in the buffer object unless you define a 
rule for how that should be done. Meaning whatever scheme you use for 
the virtual address space you need apply for linear VRAM as well, and 
that's a more scarce resource.

The scheme used today is that buffers that are > PMD size aligns bo VRAM 
on PMD size boundaries if possible (and similar for virtual addresses). 
Buffers that are > PUD size aligns to PUD size boundaries.

>
>> * We loose efficiency, because we are prepared to spend an extra 
>> effort for alignment- and continuity checks when we know we can 
>> insert a huge page table entry, but not if we know we can't
>
> I don't think so either. See with don't need any extra effort for the 
> alignment nor the handling, it actually becomes much cheaper as far as 
> I can see.

We have those checks there today. Think buddy allocator, bos with system 
pages. They are only executed when we know we can insert a huge page 
today. With the new interface we'd do them always.

>
> In other words when you have a fault you don't care about the faulting 
> address that much, you only use it to determine the memory segment to 
> map.
>
> Then this whole memory segment is mapped into the address space of the 
> user application.
>
> If can of course happen that we need to fiddle with addresses and 
> sizes because userspace only mmap a fraction of the underlying buffer, 
> but in reality we never do this.
>
>> * We loose efficiency because we might unnecessarily prefault a 
>> number of PTE size page-table entries (really a special case of the 
>> above one).
>
> I really don't see that either. When a buffer is accessed by the CPU 
> it is in > 90% of all cases completely accessed. Not faulting in full 
> ranges is just optimizing for a really unlikely case here.

It might be that you're right, but are all drivers wanting to use this 
like drm in this respect? Using the interface to fault in a 1G range in 
the hope it could map it to a huge pud may unexpectedly consume and 
populate some 16+ MB of page tables.

To me, keeping the current interface for flexibility and add an optional 
huge-page-table-entry-aware prefaulting helper, perhaps not restricted 
to contigous ranges, for drivers that think its a good idea to prefault 
given the right conditions and unconditionally for stuff like 
remap_pfn_range() sounds reasonable.

/Thomas

>
>>
>> Now in the context of quickly fixing a critical bug, the choice IMHO 
>> becomes easy.
>
> Well for quick fixing this I would rather disable huge pages for now.
>
> Regards,
> Christian.
>
>>
>>>
>>>> On top of this, unless we want to do the walk trying increasingly 
>>>> smaller
>>>> sizes of vmf_insert_xxx(), we'd have to use apply_to_page_range() 
>>>> and teach
>>>> it about transhuge page table entries, because pagewalk.c can't be 
>>>> used (It
>>>> can't populate page tables). That also means apply_to_page_range() 
>>>> needs to
>>>> be complicated with page table locks since transhuge pages aren't 
>>>> stable and
>>>> can be zapped and refaulted under us while we do the walk.
>>> I didn't say it would be simple :) But we also need to stop hacking
>>> around the sides of all this huge page stuff and come up with sensible
>>> APIs that drivers can actually implement correctly. Exposing drivers
>>> to specific kinds of page levels really feels like the wrong level of
>>> abstraction.
>>
>> I generally agree. But for the last sentence I think the potential 
>> gain must be carefully weighed against the efficiency arguments.
>>
>>>
>>> Once we start doing this we should do it everywhere, the io_remap_pfn
>>> stuff should be able to create huge special IO pages as well, for
>>> instance.
>>
>> I agree here as well. Here we can be more agressive as the contigous 
>> range is already known and we IIRC hold the mmap lock in write mode.
>>
>>>> On top of this, the user-space address allocator needs to know how 
>>>> large gpu
>>>> pages are aligned in buffer objects to have a reasonable chance of 
>>>> aligning
>>>> with CPU huge page boundaries which is a requirement to be able to 
>>>> insert a
>>>> huge CPU page table entry, so the driver would basically need the 
>>>> drm helper
>>>> that can do this alignment anyway.
>>> Don't you have this problem anyhow?
>>
>> Yes, but it sort of defeats the simplicity argument of the proposed 
>> interface change.
>>
>> /Thomas
>>
>>
