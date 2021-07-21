Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6BF3D1106
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 16:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238874AbhGUNhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 09:37:40 -0400
Received: from mga09.intel.com ([134.134.136.24]:64109 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232419AbhGUNhi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 09:37:38 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10052"; a="211442244"
X-IronPort-AV: E=Sophos;i="5.84,258,1620716400"; 
   d="scan'208";a="211442244"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2021 07:18:14 -0700
X-IronPort-AV: E=Sophos;i="5.84,258,1620716400"; 
   d="scan'208";a="501302795"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.213.149]) ([10.254.213.149])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2021 07:18:11 -0700
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
To:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Sanjay Kumar <sanjay.k.kumar@intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Liu Yi L <yi.l.liu@intel.com>
References: <20210720013856.4143880-1-baolu.lu@linux.intel.com>
 <20210720013856.4143880-5-baolu.lu@linux.intel.com>
 <22302277-0470-db41-7a19-41b5f73bd2c5@arm.com>
 <4d3a2546-da21-605d-26a9-1f6f52123056@linux.intel.com>
 <5662caea-a974-e511-9509-010606fda251@arm.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 4/5] iommu/vt-d: Disallow SVA if devices don't support
 64-bit address
Message-ID: <f1fd4464-d186-e18f-3e33-eac56d488bba@linux.intel.com>
Date:   Wed, 21 Jul 2021 22:17:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <5662caea-a974-e511-9509-010606fda251@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/7/21 19:12, Robin Murphy wrote:
> On 2021-07-21 02:50, Lu Baolu wrote:
>> Hi Robin,
>>
>> Thanks a lot for reviewing my patch!
>>
>> On 7/20/21 5:27 PM, Robin Murphy wrote:
>>> On 2021-07-20 02:38, Lu Baolu wrote:
>>>> When the device and CPU share an address space (such as SVA), the 
>>>> device
>>>> must support the same addressing capability as the CPU. The CPU does 
>>>> not
>>>> consider the addressing ability of any device when managing the page 
>>>> table
>>>> of a process, so the device must have enough addressing ability to bind
>>>> the page table of the process.
>>>>
>>>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>>>> ---
>>>>   drivers/iommu/intel/iommu.c | 3 +++
>>>>   1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>>>> index f45c80ce2381..f3cca1dd384d 100644
>>>> --- a/drivers/iommu/intel/iommu.c
>>>> +++ b/drivers/iommu/intel/iommu.c
>>>> @@ -5372,6 +5372,9 @@ static int intel_iommu_enable_sva(struct 
>>>> device *dev)
>>>>       if (!(iommu->flags & VTD_FLAG_SVM_CAPABLE))
>>>>           return -ENODEV;
>>>> +    if (!dev->dma_mask || *dev->dma_mask != DMA_BIT_MASK(64))
>>>
>>> Careful - VFIO doesn't set DMA masks (since it doesn't use the DMA API),
>>
>> SVA doesn't work through the VFIO framework.
> 
> Did anyone say it does? My point is that, as far as I understand, the 
> SVA UAPI is very much intended to work *with* VFIO, and even if the 
> finer details are still mired in the /dev/ioasid discussion today we 
> should definitely expect to see VFIO-like use-cases at some point. I 
> certainly don't see why any of the guest SVA stuff exists already if not 
> for VFIO-assigned devices?

Agreed. From /dev/ioasid design point of view, it's possible to have
VFIO-like use case of SVA. Perhaps the device addressing capability
could be included in GET_DEV_INFO of /dev/ioasid UAPI.

> 
>>> so this appears to be relying on another driver having bound previously,
>>
>> Yes. You are right.
>>
>>> otherwise the mask would still be the default 32-bit one from 
>>> pci_setup_device(). I'm not sure that's an entirely robust assumption.
>>
>> Currently SVA implementation always requires a native kernel driver. The
>> assumption is that the drivers should check and set 64-bit addressing
>> capability before calling iommu_sva_xxx() APIs.
> 
> ...and given that that is not a documented requirement, and certainly 
> not a technical one (even a self-contained kernel driver could choose to 
> only use SVA contexts and not touch the DMA API), it's an inherently 
> fragile assumption which I'm confident *will* be broken eventually :)
> 

Fair enough. I will drop this patch.

Thanks a lot for the comments.

Best regards,
baolu

> Robin.
> 
>>>> +        return -ENODEV;
>>>> +
>>>>       if (intel_iommu_enable_pasid(iommu, dev))
>>>>           return -ENODEV;
>>>>
>>
>> Best regards,
>> baolu
