Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 784AA3E5781
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 11:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235877AbhHJJwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 05:52:22 -0400
Received: from foss.arm.com ([217.140.110.172]:52514 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229474AbhHJJwV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 05:52:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D7BEF1063;
        Tue, 10 Aug 2021 02:51:59 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 920723F70D;
        Tue, 10 Aug 2021 02:51:58 -0700 (PDT)
Subject: Re: [RFC PATCH 2/3] iommu/dma-iommu: Support iovad->granule >
 PAGE_SIZE
To:     Sven Peter <sven@svenpeter.dev>,
        Sven Peter <iommu@lists.linux-foundation.org>
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
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <a721f8e3-4c1d-afb2-3ae2-eb1360e1eaca@arm.com>
Date:   Tue, 10 Aug 2021 10:51:52 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <cf78f795-1e75-45c9-a759-018f17cfaed9@www.fastmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-09 21:45, Sven Peter wrote:
> 
> 
> On Mon, Aug 9, 2021, at 19:41, Robin Murphy wrote:
>> On 2021-08-07 12:47, Sven Peter via iommu wrote:
>>>
>>>
>>> On Fri, Aug 6, 2021, at 20:04, Robin Murphy wrote:
>>>> On 2021-08-06 16:55, Sven Peter via iommu wrote:
>>>>> @@ -1006,6 +1019,31 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
>>>>>     	if (dev_is_untrusted(dev))
>>>>>     		return iommu_dma_map_sg_swiotlb(dev, sg, nents, dir, attrs);
>>>>>     
>>>>> +	/*
>>>>> +	 * If the IOMMU pagesize is larger than the CPU pagesize we will
>>>>> +	 * very likely run into sgs with a physical address that is not aligned
>>>>> +	 * to an IOMMU page boundary. Fall back to just mapping every entry
>>>>> +	 * independently with __iommu_dma_map then.
>>>>
>>>> Scatterlist segments often don't have nicely aligned ends, which is why
>>>> we already align things to IOVA granules in main loop here. I think in
>>>> principle we'd just need to move the non-IOVA-aligned part of the
>>>> address from sg->page to sg->offset in the temporary transformation for
>>>> the rest of the assumptions to hold. I don't blame you for being timid
>>>> about touching that, though - it took me 3 tries to get right when I
>>>> first wrote it...
>>>>
>>>
>>>
>>> I've spent some time with that code now and I think we cannot use it
>>> but have to fall back to iommu_dma_map_sg_swiotlb (even though that swiotlb
>>> part is a lie then):
>>>
>>> When we have sg_phys(s) = 0x802e65000 with s->offset = 0 the paddr
>>> is aligned to PAGE_SIZE but has an offset of 0x1000 from something
>>> the IOMMU can map.
>>> Now this would result in s->offset = -0x1000 which is already weird
>>> enough.
>>> Offset is unsigned (and 32bit) so this will actually look like
>>> s->offset = 0xfffff000 then, which isn't much better.
>>> And then sg_phys(s) = 0x902e64000 (instead of 0x802e64000) and
>>> we'll map some random memory in iommu_map_sg_atomic and a little bit later
>>> everything explodes.
>>>
>>> Now I could probably adjust the phys addr backwards and make sure offset is
>>> always positive (and possibly larger than PAGE_SIZE) and later restore it
>>> in __finalise_sg then but I feel like that's pushing this a little bit too far.
>>
>> Yes, that's what I meant. At a quick guess, something like the
>> completely untested diff below.
> 
> That unfortunately results in unaligned mappings

You mean it even compiles!? :D

> [    9.630334] iommu: unaligned: iova 0xbff40000 pa 0x0000000801a3b000 size 0x4000 min_pagesz 0x4000
> 
> I'll take a closer look later this week and see if I can fix it.

On reflection, "s->offset ^ s_iova_off" is definitely wrong, that more 
likely wants to be "s->offset & ~s_iova_off".

Robin.

>> It really comes down to what we want to
>> achieve here - if it's just to make this thing work at all, then I'd
>> favour bolting on the absolute minimum changes, possibly even cheating
>> by tainting the kernel and saying all bets are off instead of trying to
>> handle the more involved corners really properly. However if you want to
>> work towards this being a properly-supported thing, then I think it's
>> worth generalising the existing assumptions of page alignment from the
>> beginning.
> 
> I'd like to try and see if we can make this a properly-supported thing.
> 
> That will likely take a few iterations but realistically the rest of the drivers
> required to make this platform actually useful (and especially the display controller
> and GPU drivers) won't be ready for a few more months anyway. And even on 4KB PAGE_SIZE
> kernels half the USB ports and NVMe will work fine, which should be enough to install
> a distro and some third-party package that just ships the distro kernel with 16KB
> pages.
> 
> 
> 
> 
> Sven
> 
