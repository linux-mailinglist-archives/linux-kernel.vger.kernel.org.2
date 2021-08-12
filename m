Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13EB33EA4D3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 14:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237517AbhHLMo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 08:44:27 -0400
Received: from foss.arm.com ([217.140.110.172]:42772 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237119AbhHLMo0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 08:44:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D6211042;
        Thu, 12 Aug 2021 05:44:01 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 379203F718;
        Thu, 12 Aug 2021 05:44:00 -0700 (PDT)
Subject: Re: [RFC PATCH 2/3] iommu/dma-iommu: Support iovad->granule >
 PAGE_SIZE
To:     Sven Peter <sven@svenpeter.dev>, iommu@lists.linux-foundation.org
Cc:     Arnd Bergmann <arnd@kernel.org>, Hector Martin <marcan@marcan.st>,
        linux-kernel@vger.kernel.org, Alexander Graf <graf@amazon.com>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Will Deacon <will@kernel.org>
References: <20210806155523.50429-1-sven@svenpeter.dev>
 <20210806155523.50429-3-sven@svenpeter.dev>
 <d289a555-9e3b-b948-1883-2ee4c915da4c@arm.com>
 <dadbd8b0-171a-4008-8a2e-f68abfed9285@www.fastmail.com>
 <5002ed91-416c-d7ee-b1ab-a50c590749c2@arm.com>
 <cf78f795-1e75-45c9-a759-018f17cfaed9@www.fastmail.com>
 <a721f8e3-4c1d-afb2-3ae2-eb1360e1eaca@arm.com>
 <7b6cf00c-86ea-43c4-861f-f1cc32d5852d@www.fastmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <26874474-82d5-9807-f666-ff2291fb3b14@arm.com>
Date:   Thu, 12 Aug 2021 13:43:53 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <7b6cf00c-86ea-43c4-861f-f1cc32d5852d@www.fastmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-11 21:18, Sven Peter wrote:
> 
> 
> On Tue, Aug 10, 2021, at 11:51, Robin Murphy wrote:
>> On 2021-08-09 21:45, Sven Peter wrote:
>>>
>>>
>>> On Mon, Aug 9, 2021, at 19:41, Robin Murphy wrote:
>>>> On 2021-08-07 12:47, Sven Peter via iommu wrote:
>>>>>
>>>>>
>>>>> On Fri, Aug 6, 2021, at 20:04, Robin Murphy wrote:
>>>>>> On 2021-08-06 16:55, Sven Peter via iommu wrote:
>>>>>>> @@ -1006,6 +1019,31 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
>>>>>>>      	if (dev_is_untrusted(dev))
>>>>>>>      		return iommu_dma_map_sg_swiotlb(dev, sg, nents, dir, attrs);
>>>>>>>      
>>>>>>> +	/*
>>>>>>> +	 * If the IOMMU pagesize is larger than the CPU pagesize we will
>>>>>>> +	 * very likely run into sgs with a physical address that is not aligned
>>>>>>> +	 * to an IOMMU page boundary. Fall back to just mapping every entry
>>>>>>> +	 * independently with __iommu_dma_map then.
>>>>>>
>>>>>> Scatterlist segments often don't have nicely aligned ends, which is why
>>>>>> we already align things to IOVA granules in main loop here. I think in
>>>>>> principle we'd just need to move the non-IOVA-aligned part of the
>>>>>> address from sg->page to sg->offset in the temporary transformation for
>>>>>> the rest of the assumptions to hold. I don't blame you for being timid
>>>>>> about touching that, though - it took me 3 tries to get right when I
>>>>>> first wrote it...
>>>>>>
>>>>>
>>>>>
>>>>> I've spent some time with that code now and I think we cannot use it
>>>>> but have to fall back to iommu_dma_map_sg_swiotlb (even though that swiotlb
>>>>> part is a lie then):
>>>>>
>>>>> When we have sg_phys(s) = 0x802e65000 with s->offset = 0 the paddr
>>>>> is aligned to PAGE_SIZE but has an offset of 0x1000 from something
>>>>> the IOMMU can map.
>>>>> Now this would result in s->offset = -0x1000 which is already weird
>>>>> enough.
>>>>> Offset is unsigned (and 32bit) so this will actually look like
>>>>> s->offset = 0xfffff000 then, which isn't much better.
>>>>> And then sg_phys(s) = 0x902e64000 (instead of 0x802e64000) and
>>>>> we'll map some random memory in iommu_map_sg_atomic and a little bit later
>>>>> everything explodes.
>>>>>
>>>>> Now I could probably adjust the phys addr backwards and make sure offset is
>>>>> always positive (and possibly larger than PAGE_SIZE) and later restore it
>>>>> in __finalise_sg then but I feel like that's pushing this a little bit too far.
>>>>
>>>> Yes, that's what I meant. At a quick guess, something like the
>>>> completely untested diff below.
>>>
>>> That unfortunately results in unaligned mappings
>>
>> You mean it even compiles!? :D
> 
> I was more impressed that it already almost worked correctly :)
> 
>>
>>> [    9.630334] iommu: unaligned: iova 0xbff40000 pa 0x0000000801a3b000 size 0x4000 min_pagesz 0x4000
>>>
>>> I'll take a closer look later this week and see if I can fix it.
>>
>> On reflection, "s->offset ^ s_iova_off" is definitely wrong, that more
>> likely wants to be "s->offset & ~s_iova_off".
>>
>> Robin.
>>
> 
> 
> If I change
> 
> 		sg_set_page(s, phys_to_page(sg_phys(s)), s_length,
> 			    s_iova_off & ~PAGE_MASK);
> 
> in __finalise_sg (and the same thing in __invalidate_sg) to
> 
> 		sg_set_page(s, phys_to_page(sg_phys(s) + s_iova_off), s_length,
> 			    s_iova_off & ~PAGE_MASK);
> 
> then it also restores the original fields correctly.

Ah, good point, once again this proves to be right on the limit of how 
many moving parts I can hold in my head without working it through on 
paper (or in a debugger). FWIW my thought there was that sg_phys(s) 
would be enough to "re-normalise" things from a state where s->page_link 
was rounded down and s->offset held the PAGE_SIZE multiple (which is 
what the XOR did do), but of course that wasn't right to begin with. In 
fact, s->offset must always be negligible when restoring so you could 
arguably open-code page_to_phys(sg_page(s)), but that might be a bit too 
much of a mouthful for a theoretical micro-optimisation (note that 
trying to avoid the phys_addr_t round-trip by offsetting the page 
pointer itself might appear to work for SPARSEMEM_VMEMMAP, but I'm 
pretty sure it's not valid in general).

> What is the proper way to credit you for coming up with this?
> Do you create the commit and I apply it to my local tree and
> include it in my submission once I have fixed the other
> issues? Or do I create the commit and put a Suggested-by
> in the message?

Suggested-by is fine by me, but if you feel there's enough of my diff 
left that you haven't had to put right then you're also welcome to have 
these instead:

Co-developed-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Cheers,
Robin.

> 
> 
> Either way, here's the patch that I have right now:
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 7ce74476699d..ba31dc59566d 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -907,8 +907,8 @@ static int __finalise_sg(struct device *dev, struct scatterlist *sg, int nents,
>   		unsigned int s_length = sg_dma_len(s);
>   		unsigned int s_iova_len = s->length;
> 
> -		s->offset += s_iova_off;
> -		s->length = s_length;
> +		sg_set_page(s, phys_to_page(sg_phys(s) + s_iova_off), s_length,
> +			    s_iova_off & ~PAGE_MASK);
>   		sg_dma_address(s) = DMA_MAPPING_ERROR;
>   		sg_dma_len(s) = 0;
> 
> @@ -952,10 +952,11 @@ static void __invalidate_sg(struct scatterlist *sg, int nents)
>   	int i;
> 
>   	for_each_sg(sg, s, nents, i) {
> -		if (sg_dma_address(s) != DMA_MAPPING_ERROR)
> -			s->offset += sg_dma_address(s);
>   		if (sg_dma_len(s))
> -			s->length = sg_dma_len(s);
> +			sg_set_page(s,
> +				    phys_to_page(sg_phys(s) + sg_dma_address(s)),
> +				    sg_dma_len(s),
> +				    sg_dma_address(s) & ~PAGE_MASK);
>   		sg_dma_address(s) = DMA_MAPPING_ERROR;
>   		sg_dma_len(s) = 0;
>   	}
> @@ -1031,15 +1032,16 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
>   	 * stashing the unaligned parts in the as-yet-unused DMA fields.
>   	 */
>   	for_each_sg(sg, s, nents, i) {
> -		size_t s_iova_off = iova_offset(iovad, s->offset);
> +		phys_addr_t s_phys = sg_phys(s);
> +		size_t s_iova_off = iova_offset(iovad, s_phys);
>   		size_t s_length = s->length;
>   		size_t pad_len = (mask - iova_len + 1) & mask;
> 
>   		sg_dma_address(s) = s_iova_off;
>   		sg_dma_len(s) = s_length;
> -		s->offset -= s_iova_off;
>   		s_length = iova_align(iovad, s_length + s_iova_off);
> -		s->length = s_length;
> +		sg_set_page(s, phys_to_page(s_phys - s_iova_off),
> +			    s_length, s->offset & ~s_iova_off);
> 
>   		/*
>   		 * Due to the alignment of our single IOVA allocation, we can
> 
> 
> 
> 
> 
> Sven
> 
