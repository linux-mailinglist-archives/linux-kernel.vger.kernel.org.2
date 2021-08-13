Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDC4F3EBA54
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 18:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235739AbhHMQqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 12:46:38 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3650 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbhHMQqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 12:46:36 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GmTv86sfxz6FBPV;
        Sat, 14 Aug 2021 00:45:24 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 13 Aug 2021 18:46:08 +0200
Received: from [10.47.94.64] (10.47.94.64) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 13 Aug
 2021 17:46:07 +0100
Subject: Re: [PATCH 1/4] iommu/arm-smmu-v3: Use command queue batching helpers
 to improve performance
To:     Robin Murphy <robin.murphy@arm.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
References: <20210811114852.2429-1-thunder.leizhen@huawei.com>
 <20210811114852.2429-2-thunder.leizhen@huawei.com>
 <81258eb7-eb73-8a32-0983-3487daba1167@arm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <4e741216-d6e7-c40c-f257-242cd2fea302@huawei.com>
Date:   Fri, 13 Aug 2021 17:45:23 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <81258eb7-eb73-8a32-0983-3487daba1167@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.94.64]
X-ClientProxiedBy: lhreml730-chm.china.huawei.com (10.201.108.81) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/08/2021 17:01, Robin Murphy wrote:
>>
>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c 
>> b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> index 235f9bdaeaf223b..c81cd929047f573 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> @@ -1747,15 +1747,16 @@ static int arm_smmu_atc_inv_master(struct 
>> arm_smmu_master *master)
>>   {
>>       int i;
>>       struct arm_smmu_cmdq_ent cmd;
>> +    struct arm_smmu_cmdq_batch cmds = {};
> 
> BTW, it looks like this has crossed over with John's patch removing these.

It is only called from arm_smmu_disable_ats(), so not hot-path by the 
look for it. Or who even has ats HW ...?

But it should be at least cleaned-up for consistency. Leizhen?

Thanks,
John
