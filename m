Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F30D400281
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 17:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349672AbhICPqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 11:46:52 -0400
Received: from foss.arm.com ([217.140.110.172]:45366 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235536AbhICPqv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 11:46:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC207D6E;
        Fri,  3 Sep 2021 08:45:50 -0700 (PDT)
Received: from [10.57.15.112] (unknown [10.57.15.112])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3401C3F766;
        Fri,  3 Sep 2021 08:45:49 -0700 (PDT)
Subject: Re: [PATCH v2 3/8] iommu/dma: Disable get_sgtable for granule >
 PAGE_SIZE
To:     Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc:     Sven Peter <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Alexander Graf <graf@amazon.com>,
        Hector Martin <marcan@marcan.st>, linux-kernel@vger.kernel.org
References: <20210828153642.19396-1-sven@svenpeter.dev>
 <20210828153642.19396-4-sven@svenpeter.dev> <YS6fasuqPURbmC6X@sunset>
 <c8bc7f77-3b46-4675-a642-76871fcec963@www.fastmail.com>
 <YS/sMckPUJRMYwYq@sunset>
 <ac34e920-d1b4-4044-a8fe-5172d5ebfa9c@www.fastmail.com>
 <74621c69-ef68-c12a-3770-319cb7a0db73@arm.com>
 <989af5a3-8c84-4796-adb6-af9426d68b76@www.fastmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <462494ab-121e-e4dd-3811-d744f0fffa66@arm.com>
Date:   Fri, 3 Sep 2021 16:45:41 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <989af5a3-8c84-4796-adb6-af9426d68b76@www.fastmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-09-03 16:16, Sven Peter wrote:
> 
> 
> On Thu, Sep 2, 2021, at 21:42, Robin Murphy wrote:
>> On 2021-09-02 19:19, Sven Peter wrote:
>>>
>>>
>>> On Wed, Sep 1, 2021, at 23:10, Alyssa Rosenzweig wrote:
>>>>> My biggest issue is that I do not understand how this function is supposed
>>>>> to be used correctly. It would work fine as-is if it only ever gets passed buffers
>>>>> allocated by the coherent API but there's not way to check or guarantee that.
>>>>> There may also be callers making assumptions that no longer hold when
>>>>> iovad->granule > PAGE_SIZE.
>>>>>
>>>>> Regarding your case: I'm not convinced the function is meant to be used there.
>>>>> If I understand it correctly, your code first allocates memory with dma_alloc_coherent
>>>>> (which possibly creates a sgt internally and then maps it with iommu_map_sg),
>>>>> then coerces that back into a sgt with dma_get_sgtable, and then maps that sgt to
>>>>> another iommu domain with dma_map_sg while assuming that the result will be contiguous
>>>>> in IOVA space. It'll work out because dma_alloc_coherent is the very thing
>>>>> meant to allocate pages that can be mapped into kernel and device VA space
>>>>> as a single contiguous block and because both of your IOMMUs are different
>>>>> instances of the same HW block. Anything allocated by dma_alloc_coherent for the
>>>>> first IOMMU will have the right shape that will allow it to be mapped as
>>>>> a single contiguous block for the second IOMMU.
>>>>>
>>>>> What could be done in your case is to instead use the IOMMU API,
>>>>> allocate the pages yourself (while ensuring the sgt your create is made up
>>>>> of blocks with size and physaddr aligned to max(domain_a->granule, domain_b->granule))
>>>>> and then just use iommu_map_sg for both domains which actually comes with the
>>>>> guarantee that the result will be a single contiguous block in IOVA space and
>>>>> doesn't required the sgt roundtrip.
>>>>
>>>> In principle I agree. I am getting the sense this function can't be used
>>>> correctly in general, and yet is the function that's meant to be used.
>>>> If my interpretation of prior LKML discussion holds, the problems are
>>>> far deeper than my code or indeed page size problems...
>>>
>>> Right, which makes reasoning about this function and its behavior if the
>>> IOMMU pages size is unexpected very hard for me. I'm not opposed to just
>>> keeping this function as-is when there's a mismatch between PAGE_SIZE and
>>> the IOMMU page size (and it will probably work that way) but I'd like to
>>> be sure that won't introduce unexpected behavior.
>>>
>>>>
>>>> If the right way to handle this is with the IOMMU and IOVA APIs, I really wish
>>>> that dance were wrapped up in a safe helper function instead of open
>>>> coding it in every driver that does cross device sharing.
>>>>
>>>> We might even call that helper... hmm... dma_map_sg.... *ducks*
>>>>
>>>
>>> There might be another way to do this correctly. I'm likely just a little
>>> bit biased because I've spent the past weeks wrapping my head around the
>>> IOMMU and DMA APIs and when all you have is a hammer everything looks like
>>> a nail.
>>>
>>> But dma_map_sg operates at the DMA API level and at that point the dma-ops
>>> for two different devices could be vastly different.
>>> In the worst case one of them could be behind an IOMMU that can easily map
>>> non-contiguous pages while the other one is directly connected to the bus and
>>> can't even access >4G pages without swiotlb support.
>>> It's really only possible to guarantee that it will map N buffers to <= N
>>> DMA-addressable buffers (possibly by using an IOMMU or swiotlb internally) at
>>> that point.
>>>
>>> On the IOMMU API level you have much more information available about the actual
>>> hardware and can prepare the buffers in a way that makes both devices happy.
>>> That's why iommu_map_sgtable combined with iovad->granule aligned sgt entries
>>> can actually guarantee to map the entire list to a single contiguous IOVA block.
>>
>> Essentially there are two reasonable options, and doing pretend dma-buf
>> export/import between two devices effectively owned by the same driver
>> is neither of them. Handily, DRM happens to be exactly where all the
>> precedent is, too; unsurprisingly this is not a new concern.
>>
>> One is to go full IOMMU API, like rockchip or tegra, attaching the
>> relevant devices to your own unmanaged domain(s) and mapping pages
>> exactly where you choose. You still make dma_map/dma_unmap calls for the
>> sake of cache maintenance and other housekeeping on the underlying
>> memory, but you ignore the provided DMA addresses in favour of your own
>> IOVAs when it comes to programming the devices.
>>
>> The lazier option if you can rely on all relevant devices having equal
>> DMA and IOMMU capabilities is to follow exynos, and herd the devices
>> into a common default domain. Instead of allocating you own domain, you
>> grab the current domain for one device (which will be its default
>> domain) and manually attach the other devices to that. Then you forget
>> all about IOMMUs but make sure to do all your regular DMA API calls
>> using that first device, and the DMA addresses which come back should be
>> magically valid for the other devices too. It was a bit of a cheeky hack
>> TBH, but I'd still much prefer more of that over any usage of
>> get_sgtable outside of actual dma-buf...
>>
>> Note that where multiple IOMMU instances are involved, the latter
>> approach does depend on the IOMMU driver being able to support sharing a
>> single domain across them; I think that might sort-of-work for DART
>> already, but may need a little more attention.
> 
> It'll work for two streams inside the same DART but needs some
> attention for streams from two separate DARTs.
> 
> Then there's also this amazing "feature" that the display controller DART
> pagetable pointer register is read-only so that we have to reuse the memory
> Apple configured for first level table. That needs some changes anyway
> but might make adding multiple devices from different groups more complex.

OK, I was thinking the dual-DART accommodation is already at least some 
of the way there, but I guess it's still tied to a single device's cfg. 
One upside to generalising further might be that the dual-DART case 
stops being particularly special :)

Not being able to physically share pagetables shouldn't be too big a 
deal, just a bit more work to sync iommu_map/iommu_unmap calls across 
all the relevant instances for the given domain.

Robin.
