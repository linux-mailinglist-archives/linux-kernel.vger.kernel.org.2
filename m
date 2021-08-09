Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8CF3E47E3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 16:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233959AbhHIOsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 10:48:00 -0400
Received: from foss.arm.com ([217.140.110.172]:34124 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229474AbhHIOr7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 10:47:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EFD416D;
        Mon,  9 Aug 2021 07:47:38 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D6E0A3F718;
        Mon,  9 Aug 2021 07:47:37 -0700 (PDT)
Subject: Re: [PATCH v3 24/25] iommu/dma: Factor out flush queue init
To:     Will Deacon <will@kernel.org>
Cc:     joro@8bytes.org, linux-kernel@vger.kernel.org,
        dianders@chromium.org, iommu@lists.linux-foundation.org,
        rajatja@google.com, linux-arm-kernel@lists.infradead.org
References: <cover.1628094600.git.robin.murphy@arm.com>
 <3b5284ee394f267ba966839173f874fc9a996bb2.1628094601.git.robin.murphy@arm.com>
 <20210809125238.GB1097@willie-the-truck>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <4c6ecfb1-cf64-fa35-9fa7-f6fa39e2c066@arm.com>
Date:   Mon, 9 Aug 2021 15:47:32 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210809125238.GB1097@willie-the-truck>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-09 13:52, Will Deacon wrote:
> On Wed, Aug 04, 2021 at 06:15:52PM +0100, Robin Murphy wrote:
>> Factor out flush queue setup from the initial domain init so that we
>> can potentially trigger it from sysfs later on in a domain's lifetime.
>>
>> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
>> Reviewed-by: John Garry <john.garry@huawei.com>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>   drivers/iommu/dma-iommu.c | 30 ++++++++++++++++++++----------
>>   include/linux/dma-iommu.h |  9 ++++++---
>>   2 files changed, 26 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>> index 2e19505dddf9..f51b8dc99ac6 100644
>> --- a/drivers/iommu/dma-iommu.c
>> +++ b/drivers/iommu/dma-iommu.c
>> @@ -310,6 +310,25 @@ static bool dev_is_untrusted(struct device *dev)
>>   	return dev_is_pci(dev) && to_pci_dev(dev)->untrusted;
>>   }
>>   
>> +int iommu_dma_init_fq(struct iommu_domain *domain)
>> +{
>> +	struct iommu_dma_cookie *cookie = domain->iova_cookie;
>> +
>> +	if (domain->type != IOMMU_DOMAIN_DMA_FQ)
>> +		return -EINVAL;
>> +	if (cookie->fq_domain)
>> +		return 0;
>> +
>> +	if (init_iova_flush_queue(&cookie->iovad, iommu_dma_flush_iotlb_all,
>> +				  iommu_dma_entry_dtor)) {
>> +		pr_warn("iova flush queue initialization failed\n");
>> +		domain->type = IOMMU_DOMAIN_DMA;
>> +		return -ENODEV;
> 
> I do find this a bit odd: we assert that the caller has set domain->type
> to IOMMU_DOMAIN_DMA_FQ but then on failure we reset it to IOMMU_DOMAIN_DMA
> here. I think it would be less error-prone if the setting of domain->type
> was handled in the same function.

On reflection I think I agree. For some reason I settled on the idea of 
doing this to make the callers simpler, but it turns out that unpicking 
it to flow logically is in fact a +4/-5 diff essentially just moving all 
the same statements to different places, and that's before I update 
comments since that theoretical race between the sysfs and DMA ops paths 
only exists because of sysfs having to dance around the type check here...

I'll send v4 later today or possibly tomorrow, but not in such a hurry 
that I skimp on the build-testing this time!

Cheers,
Robin.
