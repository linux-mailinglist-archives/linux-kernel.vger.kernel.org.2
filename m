Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36DD23E87F1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 04:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbhHKCRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 22:17:06 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:17004 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbhHKCRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 22:17:05 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GktdT5F3Nzb0kW;
        Wed, 11 Aug 2021 10:13:01 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 11 Aug 2021 10:16:40 +0800
Received: from [10.174.179.0] (10.174.179.0) by dggpemm500006.china.huawei.com
 (7.185.36.236) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 11 Aug
 2021 10:16:40 +0800
Subject: Re: [PATCH RFC 2/8] iommu/arm-smmu-v3: Add and use static helper
 function arm_smmu_cmdq_issue_cmd_with_sync()
To:     Will Deacon <will@kernel.org>
CC:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210626110130.2416-1-thunder.leizhen@huawei.com>
 <20210626110130.2416-3-thunder.leizhen@huawei.com>
 <20210810182454.GB3296@willie-the-truck>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <b9fa05b5-d3ee-5c79-c8b8-b908e533646a@huawei.com>
Date:   Wed, 11 Aug 2021 10:16:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20210810182454.GB3296@willie-the-truck>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.0]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/8/11 2:24, Will Deacon wrote:
> On Sat, Jun 26, 2021 at 07:01:24PM +0800, Zhen Lei wrote:
>> The obvious key to the performance optimization of commit 587e6c10a7ce
>> ("iommu/arm-smmu-v3: Reduce contention during command-queue insertion") is
>> to allow multiple cores to insert commands in parallel after a brief mutex
>> contention.
>>
>> Obviously, inserting as many commands at a time as possible can reduce the
>> number of times the mutex contention participates, thereby improving the
>> overall performance. At least it reduces the number of calls to function
>> arm_smmu_cmdq_issue_cmdlist().
>>
>> Therefore, function arm_smmu_cmdq_issue_cmd_with_sync() is added to insert
>> the 'cmd+sync' commands at a time.
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 33 +++++++++++++--------
>>  1 file changed, 21 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> index 2433d3c29b49ff2..a5361153ca1d6a4 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> @@ -858,11 +858,25 @@ static int arm_smmu_cmdq_issue_cmd(struct arm_smmu_device *smmu,
>>  	return arm_smmu_cmdq_issue_cmdlist(smmu, cmd, 1, false);
>>  }
>>  
>> -static int arm_smmu_cmdq_issue_sync(struct arm_smmu_device *smmu)
>> +static int __maybe_unused arm_smmu_cmdq_issue_sync(struct arm_smmu_device *smmu)
>>  {
>>  	return arm_smmu_cmdq_issue_cmdlist(smmu, NULL, 0, true);
>>  }
>>  
>> +static int arm_smmu_cmdq_issue_cmd_with_sync(struct arm_smmu_device *smmu,
>> +					     struct arm_smmu_cmdq_ent *ent)
>> +{
>> +	u64 cmd[CMDQ_ENT_DWORDS];
>> +
>> +	if (arm_smmu_cmdq_build_cmd(cmd, ent)) {
>> +		dev_warn(smmu->dev, "ignoring unknown CMDQ opcode 0x%x\n",
>> +			 ent->opcode);
>> +		return -EINVAL;
>> +	}
>> +
>> +	return arm_smmu_cmdq_issue_cmdlist(smmu, cmd, 1, true);
>> +}
> 
> This function is almost identical to arm_smmu_cmdq_issue_cmd(). How about
> moving the guts out into a helper:
> 
> 	static int __arm_smmu_cmdq_issue_cmd(struct arm_smmu_device *smmu,
> 					     struct arm_smmu_cmdq_ent *ent,
> 					     bool sync);
> 
> and then having arm_smmu_cmdq_issue_cmd_with_sync() and
> arm_smmu_cmdq_issue_cmd() wrap that?

OK, I will do it.

How about remove arm_smmu_cmdq_issue_sync()? It's unused now.

> 
> Will
> .
> 
