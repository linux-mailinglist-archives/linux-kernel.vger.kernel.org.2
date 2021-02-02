Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7BDB30BFC8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 14:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232738AbhBBNll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 08:41:41 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:12067 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232690AbhBBNiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 08:38:04 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DVQGh3THKzMSx2;
        Tue,  2 Feb 2021 21:13:00 +0800 (CST)
Received: from [10.174.184.42] (10.174.184.42) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Tue, 2 Feb 2021 21:14:30 +0800
Subject: Re: [PATCH] iommu: Update the document of IOMMU_DOMAIN_UNMANAGED
To:     Robin Murphy <robin.murphy@arm.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>
References: <20210202085330.31716-1-zhukeqian1@huawei.com>
 <8eac9259-66e5-9b83-39a9-46a86097d450@arm.com>
CC:     Marc Zyngier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        <jiangkunkun@huawei.com>, Will Deacon <will@kernel.org>,
        <wanghaibin.wang@huawei.com>
From:   Keqian Zhu <zhukeqian1@huawei.com>
Message-ID: <c8aebb44-a5ff-9532-facf-b33e0402e660@huawei.com>
Date:   Tue, 2 Feb 2021 21:14:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <8eac9259-66e5-9b83-39a9-46a86097d450@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.184.42]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/2/2 20:58, Robin Murphy wrote:
> On 2021-02-02 08:53, Keqian Zhu wrote:
>> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
>> ---
>>   include/linux/iommu.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index 77e561ed57fd..e8f2efae212b 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>> @@ -68,7 +68,7 @@ struct iommu_domain_geometry {
>>    *                  devices
>>    *    IOMMU_DOMAIN_IDENTITY    - DMA addresses are system physical addresses
>>    *    IOMMU_DOMAIN_UNMANAGED    - DMA mappings managed by IOMMU-API user, used
>> - *                  for VMs
>> + *                  for VMs or userspace driver frameworks
> 
> Given that "VMs" effectively has to mean VFIO, doesn't it effectively already imply other uses of VFIO anyway? Unmanaged domains are also used in other subsystems/drivers inside the kernel and we're not naming those, so I don't see that it's particularly helpful to specifically call out one more VFIO use-case.
> 
> Perhaps the current wording could be generalised a little more, but we certainly don't want to start trying to maintain an exhaustive list of users here...
Yep, a more generalised description is better. After I have a look at all the use cases...

Thanks,
Keqian

> 
> Robin.
> 
>>    *    IOMMU_DOMAIN_DMA    - Internally used for DMA-API implementations.
>>    *                  This flag allows IOMMU drivers to implement
>>    *                  certain optimizations for these domains
>>
> .
> 
