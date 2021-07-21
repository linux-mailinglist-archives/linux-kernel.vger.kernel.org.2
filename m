Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6913D068D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 03:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbhGUBNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 21:13:00 -0400
Received: from mga07.intel.com ([134.134.136.100]:28331 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230015AbhGUBMm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 21:12:42 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10051"; a="275176378"
X-IronPort-AV: E=Sophos;i="5.84,256,1620716400"; 
   d="scan'208";a="275176378"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2021 18:53:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,256,1620716400"; 
   d="scan'208";a="462240705"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118]) ([10.239.159.118])
  by orsmga008.jf.intel.com with ESMTP; 20 Jul 2021 18:52:58 -0700
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] iommu/vt-d: Disallow SVA if devices don't support
 64-bit address
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
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <4d3a2546-da21-605d-26a9-1f6f52123056@linux.intel.com>
Date:   Wed, 21 Jul 2021 09:50:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <22302277-0470-db41-7a19-41b5f73bd2c5@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

Thanks a lot for reviewing my patch!

On 7/20/21 5:27 PM, Robin Murphy wrote:
> On 2021-07-20 02:38, Lu Baolu wrote:
>> When the device and CPU share an address space (such as SVA), the device
>> must support the same addressing capability as the CPU. The CPU does not
>> consider the addressing ability of any device when managing the page 
>> table
>> of a process, so the device must have enough addressing ability to bind
>> the page table of the process.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/intel/iommu.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index f45c80ce2381..f3cca1dd384d 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -5372,6 +5372,9 @@ static int intel_iommu_enable_sva(struct device 
>> *dev)
>>       if (!(iommu->flags & VTD_FLAG_SVM_CAPABLE))
>>           return -ENODEV;
>> +    if (!dev->dma_mask || *dev->dma_mask != DMA_BIT_MASK(64))
> 
> Careful - VFIO doesn't set DMA masks (since it doesn't use the DMA API),

SVA doesn't work through the VFIO framework.

> so this appears to be relying on another driver having bound previously,

Yes. You are right.

> otherwise the mask would still be the default 32-bit one from 
> pci_setup_device(). I'm not sure that's an entirely robust assumption.

Currently SVA implementation always requires a native kernel driver. The
assumption is that the drivers should check and set 64-bit addressing
capability before calling iommu_sva_xxx() APIs.

>
> Robin.
> 
>> +        return -ENODEV;
>> +
>>       if (intel_iommu_enable_pasid(iommu, dev))
>>           return -ENODEV;
>>

Best regards,
baolu
