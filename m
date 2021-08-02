Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 952723DDAA6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 16:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236671AbhHBORk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 10:17:40 -0400
Received: from foss.arm.com ([217.140.110.172]:36324 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235745AbhHBOQL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 10:16:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 947C411D4;
        Mon,  2 Aug 2021 07:15:58 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1911B3F66F;
        Mon,  2 Aug 2021 07:15:56 -0700 (PDT)
Subject: Re: [PATCH v2 23/24] iommu/arm-smmu: Allow non-strict in
 pgtable_quirks interface
To:     Will Deacon <will@kernel.org>
Cc:     joro@8bytes.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        suravee.suthikulpanit@amd.com, baolu.lu@linux.intel.com,
        john.garry@huawei.com, dianders@chromium.org
References: <cover.1627468308.git.robin.murphy@arm.com>
 <0fcd1f5225a6b435cbc697551a6247cd435c04db.1627468310.git.robin.murphy@arm.com>
 <20210802130438.GA28547@willie-the-truck>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <3dd7cdae-7111-6ff2-6350-a0e19fe4ab66@arm.com>
Date:   Mon, 2 Aug 2021 15:15:50 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210802130438.GA28547@willie-the-truck>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-02 14:04, Will Deacon wrote:
> On Wed, Jul 28, 2021 at 04:58:44PM +0100, Robin Murphy wrote:
>> To make io-pgtable aware of a flush queue being dynamically enabled,
>> allow IO_PGTABLE_QUIRK_NON_STRICT to be set even after a domain has been
>> attached to, and hook up the final piece of the puzzle in iommu-dma.
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 15 +++++++++++++++
>>   drivers/iommu/arm/arm-smmu/arm-smmu.c       | 11 +++++++++++
>>   drivers/iommu/dma-iommu.c                   |  3 +++
>>   3 files changed, 29 insertions(+)
>>
>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> index 19400826eba7..40fa9cb382c3 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> @@ -2711,6 +2711,20 @@ static int arm_smmu_enable_nesting(struct iommu_domain *domain)
>>   	return ret;
>>   }
>>   
>> +static int arm_smmu_set_pgtable_quirks(struct iommu_domain *domain,
>> +		unsigned long quirks)
>> +{
>> +	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
>> +
>> +	if (quirks == IO_PGTABLE_QUIRK_NON_STRICT && smmu_domain->pgtbl_ops) {
>> +		struct io_pgtable *iop = io_pgtable_ops_to_pgtable(smmu_domain->pgtbl_ops);
>> +
>> +		iop->cfg.quirks |= IO_PGTABLE_QUIRK_NON_STRICT;
>> +		return 0;
>> +	}
>> +	return -EINVAL;
>> +}
> 
> I don't see anything serialising this against a concurrent iommu_unmap(), so
> the ordering and atomicity looks quite suspicious to me here. I don't think
> it's just the page-table quirks either, but also setting cookie->fq_domain.

Heh, I confess to very much taking the cheeky "let's say nothing and see 
what Will thinks about concurrency" approach here :)

The beauty of only allowing relaxation in the strict->non-strict 
direction is that it shouldn't need serialising as such - it doesn't 
matter if the update to cookie->fq_domain is observed between 
iommu_unmap() and iommu_dma_free_iova(), since there's no correctness 
impact to queueing IOVAs which may already have been invalidated and may 
or may not have been synced. AFAICS the only condition which matters is 
that the setting of the io-pgtable quirk must observe fq_domain being 
set. It feels like there must be enough dependencies on the read side, 
but we might need an smp_wmb() between the two in iommu_dma_init_fq()?

I've also flip-flopped a bit on whether fq_domain needs to be accessed 
with READ_ONCE/WRITE_ONCE - by the time of posting I'd convinced myself 
that it was probably OK, but looking again now I suppose this wacky 
reordering is theoretically possible:


	iommu_dma_unmap() {
		bool free_fq = cookie->fq_domain; // == false

		iommu_unmap();

		if (!cookie->fq_domain) // observes new non-NULL value
			iommu_tlb_sync(); // skipped

		iommu_dma_free_iova { // inlined
			if (free_fq) // false
				queue_iova();
			else
				free_iova_fast(); // Uh-oh!
		}
	}

so although I still can't see atomicity being a problem I guess we do 
need it for the sake of reordering at least.

Cheers,
Robin.
