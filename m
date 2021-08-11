Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA653E8F4F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 13:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237221AbhHKLQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 07:16:19 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3625 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237191AbhHKLQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 07:16:17 -0400
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Gl6gD2vDFz6BCtW;
        Wed, 11 Aug 2021 19:15:20 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 11 Aug 2021 13:15:52 +0200
Received: from [10.47.80.4] (10.47.80.4) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 11 Aug
 2021 12:15:51 +0100
Subject: Re: [PATCH RFC 2/8] iommu/arm-smmu-v3: Add and use static helper
 function arm_smmu_cmdq_issue_cmd_with_sync()
To:     Will Deacon <will@kernel.org>
CC:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210626110130.2416-1-thunder.leizhen@huawei.com>
 <20210626110130.2416-3-thunder.leizhen@huawei.com>
 <20210810182454.GB3296@willie-the-truck>
 <b9fa05b5-d3ee-5c79-c8b8-b908e533646a@huawei.com>
 <20210811100905.GB4426@willie-the-truck>
 <d551f31d-4edc-db28-fb08-41a130a5d97f@huawei.com>
 <20210811103344.GA4736@willie-the-truck>
From:   John Garry <john.garry@huawei.com>
Message-ID: <1dcf5fe0-6ae0-2df6-9d2a-bda6a4f885ac@huawei.com>
Date:   Wed, 11 Aug 2021 12:15:14 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20210811103344.GA4736@willie-the-truck>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.80.4]
X-ClientProxiedBy: lhreml712-chm.china.huawei.com (10.201.108.63) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>>>
>>>>>> Therefore, function arm_smmu_cmdq_issue_cmd_with_sync() is added to insert
>>>>>> the 'cmd+sync' commands at a time.
>>>>>>
>>>>>> Signed-off-by: Zhen Lei<thunder.leizhen@huawei.com>
>>>>>> ---
>>>>>>    drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 33 +++++++++++++--------
>>>>>>    1 file changed, 21 insertions(+), 12 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>>>>> index 2433d3c29b49ff2..a5361153ca1d6a4 100644
>>>>>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>>>>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>>>>> @@ -858,11 +858,25 @@ static int arm_smmu_cmdq_issue_cmd(struct arm_smmu_device *smmu,
>>>>>>    	return arm_smmu_cmdq_issue_cmdlist(smmu, cmd, 1, false);
>>>>>>    }
>>>>>> -static int arm_smmu_cmdq_issue_sync(struct arm_smmu_device *smmu)
>>>>>> +static int __maybe_unused arm_smmu_cmdq_issue_sync(struct arm_smmu_device *smmu)
>>>>>>    {
>>>>>>    	return arm_smmu_cmdq_issue_cmdlist(smmu, NULL, 0, true);
>>>>>>    }
>>>>>> +static int arm_smmu_cmdq_issue_cmd_with_sync(struct arm_smmu_device *smmu,
>>>>>> +					     struct arm_smmu_cmdq_ent *ent)
>>>>>> +{
>>>>>> +	u64 cmd[CMDQ_ENT_DWORDS];
>>>>>> +
>>>>>> +	if (arm_smmu_cmdq_build_cmd(cmd, ent)) {
>>>>>> +		dev_warn(smmu->dev, "ignoring unknown CMDQ opcode 0x%x\n",
>>>>>> +			 ent->opcode);
>>>>>> +		return -EINVAL;
>> Are any of the errors returned from the "issue command" functions actually
>> consumed? I couldn't see it on mainline code from a brief browse.
> I don't think so.

I don't think so either.

> Can we actually propagate them?

There does appear to be some places, here's one I found:

arm_smmu_page_response() -> arm_smmu_cmdq_issue_cmd(), and 
arm_smmu_page_response is set to arm_smmu_ops.page_response, which 
returns an int

Thanks,
John
