Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E46673E8EB8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 12:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237199AbhHKKcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 06:32:13 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3624 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236935AbhHKKcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 06:32:11 -0400
Received: from fraeml735-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Gl5hK69ZTz6BDkl;
        Wed, 11 Aug 2021 18:31:13 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml735-chm.china.huawei.com (10.206.15.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 11 Aug 2021 12:31:46 +0200
Received: from [10.47.80.4] (10.47.80.4) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 11 Aug
 2021 11:31:45 +0100
Subject: Re: [PATCH RFC 2/8] iommu/arm-smmu-v3: Add and use static helper
 function arm_smmu_cmdq_issue_cmd_with_sync()
To:     Will Deacon <will@kernel.org>,
        "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
CC:     Robin Murphy <robin.murphy@arm.com>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210626110130.2416-1-thunder.leizhen@huawei.com>
 <20210626110130.2416-3-thunder.leizhen@huawei.com>
 <20210810182454.GB3296@willie-the-truck>
 <b9fa05b5-d3ee-5c79-c8b8-b908e533646a@huawei.com>
 <20210811100905.GB4426@willie-the-truck>
From:   John Garry <john.garry@huawei.com>
Message-ID: <d551f31d-4edc-db28-fb08-41a130a5d97f@huawei.com>
Date:   Wed, 11 Aug 2021 11:31:08 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20210811100905.GB4426@willie-the-truck>
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

>>>> Obviously, inserting as many commands at a time as possible can reduce the
>>>> number of times the mutex contention participates, thereby improving the
>>>> overall performance. At least it reduces the number of calls to function
>>>> arm_smmu_cmdq_issue_cmdlist().
>>>>
>>>> Therefore, function arm_smmu_cmdq_issue_cmd_with_sync() is added to insert
>>>> the 'cmd+sync' commands at a time.
>>>>
>>>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>>>> ---
>>>>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 33 +++++++++++++--------
>>>>   1 file changed, 21 insertions(+), 12 deletions(-)
>>>>
>>>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>>> index 2433d3c29b49ff2..a5361153ca1d6a4 100644
>>>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>>> @@ -858,11 +858,25 @@ static int arm_smmu_cmdq_issue_cmd(struct arm_smmu_device *smmu,
>>>>   	return arm_smmu_cmdq_issue_cmdlist(smmu, cmd, 1, false);
>>>>   }
>>>>   
>>>> -static int arm_smmu_cmdq_issue_sync(struct arm_smmu_device *smmu)
>>>> +static int __maybe_unused arm_smmu_cmdq_issue_sync(struct arm_smmu_device *smmu)
>>>>   {
>>>>   	return arm_smmu_cmdq_issue_cmdlist(smmu, NULL, 0, true);
>>>>   }
>>>>   
>>>> +static int arm_smmu_cmdq_issue_cmd_with_sync(struct arm_smmu_device *smmu,
>>>> +					     struct arm_smmu_cmdq_ent *ent)
>>>> +{
>>>> +	u64 cmd[CMDQ_ENT_DWORDS];
>>>> +
>>>> +	if (arm_smmu_cmdq_build_cmd(cmd, ent)) {
>>>> +		dev_warn(smmu->dev, "ignoring unknown CMDQ opcode 0x%x\n",
>>>> +			 ent->opcode);
>>>> +		return -EINVAL;

Are any of the errors returned from the "issue command" functions 
actually consumed? I couldn't see it on mainline code from a brief browse.

>>>> +	}
>>>> +
>>>> +	return arm_smmu_cmdq_issue_cmdlist(smmu, cmd, 1, true);

Thanks,
John
