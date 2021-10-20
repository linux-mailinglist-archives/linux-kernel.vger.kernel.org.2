Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39B0B4345E4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 09:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbhJTHcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 03:32:14 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:29916 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbhJTHcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 03:32:13 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HZ2Fb3VL3zbnKC;
        Wed, 20 Oct 2021 15:25:23 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Wed, 20 Oct 2021 15:29:56 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Wed, 20 Oct 2021 15:29:56 +0800
Subject: Re: [PATCH v2 2/2] iommu/arm-smmu-v3: Simplify useless instructions
 in arm_smmu_cmdq_build_cmd()
To:     Will Deacon <will@kernel.org>
CC:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>,
        "John Garry" <john.garry@huawei.com>
References: <20210818080452.2079-1-thunder.leizhen@huawei.com>
 <20210818080452.2079-3-thunder.leizhen@huawei.com>
 <20211004120714.GD27373@willie-the-truck>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <68742c41-8610-9b3f-49b7-7ae04dc87ec2@huawei.com>
Date:   Wed, 20 Oct 2021 15:29:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20211004120714.GD27373@willie-the-truck>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/10/4 20:07, Will Deacon wrote:
> On Wed, Aug 18, 2021 at 04:04:52PM +0800, Zhen Lei wrote:
>> Although the parameter 'cmd' is always passed by a local array variable,
>> and only this function modifies it, the compiler does not know this. The
>> compiler almost always reads the value of cmd[i] from memory rather than
>> directly using the value cached in the register. This generates many
>> useless instruction operations and affects the performance to some extent.
>>
>> To guide the compiler for proper optimization, 'cmd' is defined as a local
>> array variable, marked as register, and copied to the output parameter at
>> a time when the function is returned.
>>
>> The optimization effect can be viewed by running the "size arm-smmu-v3.o"
>> command.
>>
>> Before:
>>    text    data     bss     dec     hex
>>   26954    1348      56   28358    6ec6
>>
>> After:
>>    text    data     bss     dec     hex
>>   26762    1348      56   28166    6e06
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 11 ++++++++---
>>  1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> index 01e95b56ffa07d1..7cec0c967f71d86 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> @@ -234,10 +234,12 @@ static int queue_remove_raw(struct arm_smmu_queue *q, u64 *ent)
>>  }
>>  
>>  /* High-level queue accessors */
>> -static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
>> +static int arm_smmu_cmdq_build_cmd(u64 *out_cmd, struct arm_smmu_cmdq_ent *ent)
>>  {
>> -	memset(cmd, 0, 1 << CMDQ_ENT_SZ_SHIFT);
>> -	cmd[0] |= FIELD_PREP(CMDQ_0_OP, ent->opcode);
>> +	register u64 cmd[CMDQ_ENT_DWORDS];
> 
> 'register' is pretty badly specified outside of a handful of limited uses in
> conjunction with inline asm, so I really don't think we should be using it
> here.

OK, I think I was overly aggressive in the beginning, and I just tried to
remove the register modifier and get the same optimization.

> 
>> +	cmd[0] = FIELD_PREP(CMDQ_0_OP, ent->opcode);
> 
> This generates a compiler warning about taking the address of a 'register'
> variable.
> 
> Will
> .
> 
