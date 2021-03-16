Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D98133D341
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 12:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbhCPLkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 07:40:23 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:13942 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237403AbhCPLj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 07:39:57 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4F0BB63pQkzkb03;
        Tue, 16 Mar 2021 19:38:22 +0800 (CST)
Received: from [10.174.184.42] (10.174.184.42) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Tue, 16 Mar 2021 19:39:48 +0800
Subject: Re: [PATCH v2 04/11] iommu/arm-smmu-v3: Split block descriptor when
 start dirty log
To:     Yi Sun <yi.y.sun@linux.intel.com>
References: <20210310090614.26668-1-zhukeqian1@huawei.com>
 <20210310090614.26668-5-zhukeqian1@huawei.com>
 <20210316091751.GN28580@yi.y.sun>
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
Message-ID: <84cef87c-af82-8564-fc23-654042448d05@huawei.com>
Date:   Tue, 16 Mar 2021 19:39:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20210316091751.GN28580@yi.y.sun>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.184.42]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yi,

On 2021/3/16 17:17, Yi Sun wrote:
> On 21-03-10 17:06:07, Keqian Zhu wrote:
>> From: jiangkunkun <jiangkunkun@huawei.com>
>>
>> Block descriptor is not a proper granule for dirty log tracking.
>> Take an extreme example, if DMA writes one byte, under 1G mapping,
>> the dirty amount reported to userspace is 1G, but under 4K mapping,
>> the dirty amount is just 4K.
>>
>> This adds a new interface named start_dirty_log in iommu layer and
>> arm smmuv3 implements it, which splits block descriptor to an span
>> of page descriptors. Other types of IOMMU will perform architecture
>> specific actions to start dirty log.
>>
>> To allow code reuse, the split_block operation is realized as an
>> iommu_ops too. We flush all iotlbs after the whole procedure is
>> completed to ease the pressure of iommu, as we will hanle a huge
>> range of mapping in general.
>>
>> Spliting block does not simultaneously work with other pgtable ops,
>> as the only designed user is vfio, which always hold a lock, so race
>> condition is not considered in the pgtable ops.
>>
>> Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
>> Signed-off-by: Kunkun Jiang <jiangkunkun@huawei.com>
>> ---
>>
>> changelog:
>>
>> v2:
>>  - Change the return type of split_block(). size_t -> int.
>>  - Change commit message to properly describe race condition. (Robin)
>>  - Change commit message to properly describe the need of split block.
>>  - Add a new interface named start_dirty_log(). (Sun Yi)
>>  - Change commit message to explain the realtionship of split_block() and start_dirty_log().
>>
>> ---
>>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  52 +++++++++
>>  drivers/iommu/io-pgtable-arm.c              | 122 ++++++++++++++++++++
>>  drivers/iommu/iommu.c                       |  48 ++++++++
>>  include/linux/io-pgtable.h                  |   2 +
>>  include/linux/iommu.h                       |  24 ++++
>>  5 files changed, 248 insertions(+)
>>
> Could you please split iommu common interface to a separate patch?
> This may make review and comments easier.
Yup, good suggestion.

> 
> IMHO, I think the start/stop interfaces could be merged into one, e.g:
>     int iommu_domain_set_hwdbm(struct iommu_domain *domain, bool enable,
>                                unsigned long iova, size_t size,
>                                int prot);
Looks good, this reduces some code. but I have a concern that this causes loss of flexibility,
as we must pass same arguments when start|stop dirty log. What's your opinion about this?

> 
> Same comments to patch 5.
OK. Thanks.

> 
> BRs,
> Yi Sun
> 
>> -- 
>> 2.19.1
> .
Thanks,
Keqian
