Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88BD2348297
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 21:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238154AbhCXUIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 16:08:40 -0400
Received: from ste-pvt-msa1.bahnhof.se ([213.80.101.70]:23965 "EHLO
        ste-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238133AbhCXUIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 16:08:07 -0400
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 880A241C23;
        Wed, 24 Mar 2021 21:08:00 +0100 (CET)
Authentication-Results: ste-pvt-msa1.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=P+s2NS8J;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
        DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
        URIBL_BLOCKED=0.001] autolearn=ham autolearn_force=no
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id mMze0gdUSJgY; Wed, 24 Mar 2021 21:07:59 +0100 (CET)
Received: by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 5FEB83F660;
        Wed, 24 Mar 2021 21:07:56 +0100 (CET)
Received: from [10.249.254.166] (unknown [192.198.151.44])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 689EC36062E;
        Wed, 24 Mar 2021 21:07:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1616616476; bh=3qCxYoZfXVcIr6IpgNofra0wmJqpRFAzpDo4oMeG2n4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=P+s2NS8JR6bgZjWtEWtrP50nVsF5NTzm85ecSAvPaeaV2HAmU4h5YlAYuj/1/OfJN
         yMZPRJgOAIMozwhOd8Mc3SWg9rvlQuobgmFUAtCRsC0FE7IV+Yux+l6tIBgP8OoGKG
         I8WBTZW8AxL5/8afqsZTd1D4Ip814CDQSFBKgSrE=
Subject: Re: [RFC PATCH 1/2] mm,drm/ttm: Block fast GUP to TTM huge pages
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <314fc020-d243-dbf0-acb3-ecfcc9c2443c@shipmail.org>
 <20210323163715.GJ2356281@nvidia.com>
 <5824b731-ca6a-92fd-e314-d986b6a7b101@shipmail.org>
 <YFsM23t2niJwhpM/@phenom.ffwll.local> <20210324122430.GW2356281@nvidia.com>
 <e12e2c49-afaf-dbac-b18c-272c93c83e06@shipmail.org>
 <20210324124127.GY2356281@nvidia.com>
 <6c9acb90-8e91-d8af-7abd-e762d9a901aa@shipmail.org>
 <20210324134833.GE2356281@nvidia.com>
 <0b984f96-00fb-5410-bb16-02e12b2cc024@shipmail.org>
 <20210324163812.GJ2356281@nvidia.com>
 <08f19e80-d6cb-8858-0c5d-67d2e2723f72@amd.com>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28Intel=29?= 
        <thomas_os@shipmail.org>
Message-ID: <730eb2ff-ba98-2393-6d42-61735e3c6b83@shipmail.org>
Date:   Wed, 24 Mar 2021 21:07:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <08f19e80-d6cb-8858-0c5d-67d2e2723f72@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/24/21 7:31 PM, Christian König wrote:
>
>
> Am 24.03.21 um 17:38 schrieb Jason Gunthorpe:
>> On Wed, Mar 24, 2021 at 04:50:14PM +0100, Thomas Hellström (Intel) 
>> wrote:
>>> On 3/24/21 2:48 PM, Jason Gunthorpe wrote:
>>>> On Wed, Mar 24, 2021 at 02:35:38PM +0100, Thomas Hellström (Intel) 
>>>> wrote:
>>>>
>>>>>> In an ideal world the creation/destruction of page table levels 
>>>>>> would
>>>>>> by dynamic at this point, like THP.
>>>>> Hmm, but I'm not sure what problem we're trying to solve by 
>>>>> changing the
>>>>> interface in this way?
>>>> We are trying to make a sensible driver API to deal with huge pages.
>>>>> Currently if the core vm requests a huge pud, we give it one, and 
>>>>> if we
>>>>> can't or don't want to (because of dirty-tracking, for example, 
>>>>> which is
>>>>> always done on 4K page-level) we just return VM_FAULT_FALLBACK, 
>>>>> and the
>>>>> fault is retried at a lower level.
>>>> Well, my thought would be to move the pte related stuff into
>>>> vmf_insert_range instead of recursing back via VM_FAULT_FALLBACK.
>>>>
>>>> I don't know if the locking works out, but it feels cleaner that the
>>>> driver tells the vmf how big a page it can stuff in, not the vm
>>>> telling the driver to stuff in a certain size page which it might not
>>>> want to do.
>>>>
>>>> Some devices want to work on a in-between page size like 64k so they
>>>> can't form 2M pages but they can stuff 64k of 4K pages in a batch on
>>>> every fault.
>>> Hmm, yes, but we would in that case be limited anyway to insert ranges
>>> smaller than and equal to the fault size to avoid extensive and 
>>> possibly
>>> unnecessary checks for contigous memory.
>> Why? The insert function is walking the page tables, it just updates
>> things as they are. It learns the arragement for free while doing the
>> walk.
>>
>> The device has to always provide consistent data, if it overlaps into
>> pages that are already populated that is fine so long as it isn't
>> changing their addresses.
>>
>>> And then if we can't support the full fault size, we'd need to
>>> either presume a size and alignment of the next level or search for
>>> contigous memory in both directions around the fault address,
>>> perhaps unnecessarily as well.
>> You don't really need to care about levels, the device should be
>> faulting in the largest memory regions it can within its efficiency.
>>
>> If it works on 4M pages then it should be faulting 4M pages. The page
>> size of the underlying CPU doesn't really matter much other than some
>> tuning to impact how the device's allocator works.

Yes, but then we'd be adding a lot of complexity into this function that 
is already provided by the current interface for DAX, for little or no 
gain, at least in the drm/ttm setting. Please think of the following 
situation: You get a fault, you do an extensive time-consuming scan of 
your VRAM buffer object into which the fault goes and determine you can 
fault 1GB. Now you hand it to vmf_insert_range() and because the 
user-space address is misaligned, or already partly populated because of 
a previous eviction, you can only fault single pages, and you end up 
faulting a full GB of single pages perhaps for a one-time small update.

On top of this, unless we want to do the walk trying increasingly 
smaller sizes of vmf_insert_xxx(), we'd have to use 
apply_to_page_range() and teach it about transhuge page table entries, 
because pagewalk.c can't be used (It can't populate page tables). That 
also means apply_to_page_range() needs to be complicated with page table 
locks since transhuge pages aren't stable and can be zapped and 
refaulted under us while we do the walk.

On top of this, the user-space address allocator needs to know how large 
gpu pages are aligned in buffer objects to have a reasonable chance of 
aligning with CPU huge page boundaries which is a requirement to be able 
to insert a huge CPU page table entry, so the driver would basically 
need the drm helper that can do this alignment anyway.

All this makes me think we should settle for the current interface for 
now, and if someone feels like refining it, I'm fine with that.  After 
all, this isn't a strange drm/ttm invention, it's a pre-existing 
interface that we reuse.

>
> I agree with Jason here.
>
> We get the best efficiency when we look at the what the GPU driver 
> provides and make sure that we handle one GPU page at once instead of 
> looking to much into what the CPU is doing with it's page tables.
>
> At least one AMD GPUs the GPU page size can be anything between 4KiB 
> and 2GiB and if we will in a 2GiB chunk at once this can in theory be 
> handled by just two giant page table entries on the CPU side.

Yes, but I fail to see why, with the current code, we can't do this 
(save the refcounting bug)?

/Thomas

