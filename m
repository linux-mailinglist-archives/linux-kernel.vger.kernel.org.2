Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F48933F0CB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 14:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbhCQM7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 08:59:50 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:14363 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbhCQM7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 08:59:47 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4F0qvN2WStz90W0;
        Wed, 17 Mar 2021 20:57:52 +0800 (CST)
Received: from [10.174.184.42] (10.174.184.42) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Wed, 17 Mar 2021 20:59:38 +0800
Subject: Re: [PATCH v2 06/11] iommu/arm-smmu-v3: Scan leaf TTD to sync
 hardware dirty log
To:     Yi Sun <yi.y.sun@linux.intel.com>
References: <20210310090614.26668-1-zhukeqian1@huawei.com>
 <20210310090614.26668-7-zhukeqian1@huawei.com>
 <20210317104429.GT28580@yi.y.sun>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "Will Deacon" <will@kernel.org>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        "Cornelia Huck" <cohuck@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        <wanghaibin.wang@huawei.com>, <jiangkunkun@huawei.com>,
        <yuzenghui@huawei.com>, <lushenming@huawei.com>
From:   Keqian Zhu <zhukeqian1@huawei.com>
Message-ID: <82fd0514-dc2e-c908-56d1-73143762540b@huawei.com>
Date:   Wed, 17 Mar 2021 20:59:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20210317104429.GT28580@yi.y.sun>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.184.42]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/3/17 18:44, Yi Sun wrote:
> On 21-03-10 17:06:09, Keqian Zhu wrote:
>> From: jiangkunkun <jiangkunkun@huawei.com>
>>
>> During dirty log tracking, user will try to retrieve dirty log from
>> iommu if it supports hardware dirty log.
>>
>> This adds a new interface named sync_dirty_log in iommu layer and
>> arm smmuv3 implements it, which scans leaf TTD and treats it's dirty
>> if it's writable (As we just enable HTTU for stage1, so check whether
>> AP[2] is not set).
>>
>> Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
>> Signed-off-by: Kunkun Jiang <jiangkunkun@huawei.com>
>> ---
>>
>> changelog:
>>
>> v2:
>>  - Add new sanity check in arm_smmu_sync_dirty_log(). (smmu_domain->stage != ARM_SMMU_DOMAIN_S1)
>>  - Document the purpose of flush_iotlb in arm_smmu_sync_dirty_log(). (Robin)
>>  
>> ---
>>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 30 +++++++
>>  drivers/iommu/io-pgtable-arm.c              | 90 +++++++++++++++++++++
>>  drivers/iommu/iommu.c                       | 38 +++++++++
>>  include/linux/io-pgtable.h                  |  4 +
>>  include/linux/iommu.h                       | 18 +++++
>>  5 files changed, 180 insertions(+)
>>
> Please split iommu common interface out. Thanks!
Yes, I will do it in v3.

> 
> [...]
> 
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index 2a10294b62a3..44dfb78f9050 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -2850,6 +2850,44 @@ int iommu_stop_dirty_log(struct iommu_domain *domain, unsigned long iova,
>>  }
>>  EXPORT_SYMBOL_GPL(iommu_stop_dirty_log);
>>  
>> +int iommu_sync_dirty_log(struct iommu_domain *domain, unsigned long iova,
>> +			 size_t size, unsigned long *bitmap,
>> +			 unsigned long base_iova, unsigned long bitmap_pgshift)
> 
> One open question: shall we add PASID as one parameter to make iommu
> know which address space to visit?
> 
> For live migration, the pasid should not be necessary. But considering
Sure, for live migration we just need to care about level/stage 2 mapping under nested mode.

> future extension, it may be required.
It sounds a good idea. I will consider this, thanks!

> 
> BRs,
> Yi Sun
> .
> 
Thanks,
Keqian
