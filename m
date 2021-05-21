Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3AF738C011
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 08:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234105AbhEUGyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 02:54:32 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:3460 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232339AbhEUGy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 02:54:28 -0400
Received: from dggems703-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FmcgD5sj3zCswv;
        Fri, 21 May 2021 14:50:16 +0800 (CST)
Received: from dggema765-chm.china.huawei.com (10.1.198.207) by
 dggems703-chm.china.huawei.com (10.3.19.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 21 May 2021 14:53:04 +0800
Received: from [10.174.185.210] (10.174.185.210) by
 dggema765-chm.china.huawei.com (10.1.198.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 21 May 2021 14:53:04 +0800
Subject: Re: [RFC PATCH v1 0/2] iommu/arm-smmu-v3: Add some parameter check in
 __arm_smmu_tlb_inv_range()
To:     Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
        "Eric Auger" <eric.auger@redhat.com>,
        "moderated list:ARM SMMU DRIVERS" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
CC:     <wanghaibin.wang@huawei.com>
References: <20210519094307.3275-1-jiangkunkun@huawei.com>
 <c577a7cc-8db3-5802-53cb-985f0c7216b3@arm.com>
From:   Kunkun Jiang <jiangkunkun@huawei.com>
Message-ID: <0f4e8394-72e1-e837-d98f-4998b9a71097@huawei.com>
Date:   Fri, 21 May 2021 14:53:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <c577a7cc-8db3-5802-53cb-985f0c7216b3@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.185.210]
X-ClientProxiedBy: dggeme708-chm.china.huawei.com (10.1.199.104) To
 dggema765-chm.china.huawei.com (10.1.198.207)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On 2021/5/19 18:01, Robin Murphy wrote:
> On 2021-05-19 10:43, Kunkun Jiang wrote:
>> Hi all,
>>
>> This set of patches solves some errors when I tested the SMMU nested 
>> mode.
>>
>> Test scenario description:
>> guest kernel: 4KB translation granule
>> host kernel: 16KB translation granule
>>
>> errors:
>> 1. encountered an endless loop in __arm_smmu_tlb_inv_range because
>> num_pages is 0
>> 2. encountered CERROR_ILL because the fields of TLB invalidation
>> command are as follow: TG = 2, NUM = 0, SCALE = 0, TTL = 0. The
>> combination is exactly the kind of reserved combination pointed
>> out in the SMMUv3 spec(page 143-144, version D.a)
>>
>> In my opinion, it is more appropriate to add parameter check in
>> __arm_smmu_tlb_inv_range(), although these problems only appeared
>> when I tested the SMMU nested mode. What do you think?
>
> FWIW I think it would be better to fix the caller to not issue broken 
> commands in the first place. The kernel shouldn't do so for itself 
> (and definitely needs fixing if it ever does), so it sounds like the 
> nesting implementation needs to do a bit more validation of what it's 
> passing through.
Thanks for your reply.
I will report these errors to Eric and discuss how to fix them.

Thanks,
Kunkun Jiang
>
> Robin.
>
>> This series include patches as below:
>> Patch 1:
>> - align the invalid range with leaf page size upwards when smmu
>> supports RIL
>>
>> Patch 2:
>> - add a check to standardize granule size when smmu supports RIL
>>
>> Kunkun Jiang (2):
>>    iommu/arm-smmu-v3: Align invalid range with leaf page size upwards
>>      when support RIL
>>    iommu/arm-smmu-v3: Standardize granule size when support RIL
>>
>>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
> .


