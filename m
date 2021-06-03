Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD2A399F6A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 13:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbhFCLCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 07:02:39 -0400
Received: from foss.arm.com ([217.140.110.172]:38178 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229790AbhFCLCi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 07:02:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 345F81063;
        Thu,  3 Jun 2021 04:00:54 -0700 (PDT)
Received: from [10.57.73.64] (unknown [10.57.73.64])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C8CA53F774;
        Thu,  3 Jun 2021 04:00:52 -0700 (PDT)
Subject: Re: [PATCH v3] iommu/dma: Fix IOVA reserve dma ranges
To:     Sven Peter <sven@svenpeter.dev>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Joerg Roedel <joro@8bytes.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, poza@codeaurora.org
Cc:     iommu <iommu@lists.linux-foundation.org>,
        bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org
References: <20200914072319.6091-1-srinath.mannam@broadcom.com>
 <c72a45e4-c156-4a62-bfd7-9cf8a31ff499@www.fastmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <c9b5900b-8212-35c1-c358-46158d34b253@arm.com>
Date:   Thu, 3 Jun 2021 12:00:46 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <c72a45e4-c156-4a62-bfd7-9cf8a31ff499@www.fastmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-02 21:18, Sven Peter wrote:
> Hi,
> 
> I just ran into the exact same issue while working on the M1 DART IOMMU driver
> and it was fixed by this commit. Thanks!
> 
> Would be great if this could be picked up.

Oops, apparently I was happy enough with this 9 months ago to forget 
about it, so if it helps,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Tested-by: Sven Peter <sven@svenpeter.dev>
> 
> 
> Best,
> 
> 
> Sven
> 
> 
> On Mon, Sep 14, 2020, at 09:23, Srinath Mannam via iommu wrote:
>> Fix IOVA reserve failure in the case when address of first memory region
>> listed in dma-ranges is equal to 0x0.
>>
>> Fixes: aadad097cd46f ("iommu/dma: Reserve IOVA for PCIe inaccessible
>> DMA address")
>> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
>> ---
>> Changes from v2:
>>     Modify error message with useful information based on Bjorn's
>> comments.
>>
>> Changes from v1:
>>     Removed unnecessary changes based on Robin's review comments.
>>
>>   drivers/iommu/dma-iommu.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>> index 5141d49a046b..5b9791f35c5e 100644
>> --- a/drivers/iommu/dma-iommu.c
>> +++ b/drivers/iommu/dma-iommu.c
>> @@ -217,9 +217,11 @@ static int iova_reserve_pci_windows(struct pci_dev *dev,
>>   			lo = iova_pfn(iovad, start);
>>   			hi = iova_pfn(iovad, end);
>>   			reserve_iova(iovad, lo, hi);
>> -		} else {
>> +		} else if (end < start) {
>>   			/* dma_ranges list should be sorted */
>> -			dev_err(&dev->dev, "Failed to reserve IOVA\n");
>> +			dev_err(&dev->dev,
>> +				"Failed to reserve IOVA [%#010llx-%#010llx]\n",
>> +				start, end);
>>   			return -EINVAL;
>>   		}
>>   
>> -- 
>> 2.17.1
>>
>> _______________________________________________
>> iommu mailing list
>> iommu@lists.linux-foundation.org
>> https://lists.linuxfoundation.org/mailman/listinfo/iommu
>>
>>
