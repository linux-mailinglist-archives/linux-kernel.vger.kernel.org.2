Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A817A3EF812
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 04:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236651AbhHRC3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 22:29:01 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:8870 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236471AbhHRC3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 22:29:00 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GqBYK5wKfz8sYn;
        Wed, 18 Aug 2021 10:24:21 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 18 Aug 2021 10:28:10 +0800
Received: from [10.174.178.242] (10.174.178.242) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 18 Aug 2021 10:28:10 +0800
Subject: Re: [PATCH] iommu/arm-smmu-v3: Simplify useless instructions in
 arm_smmu_cmdq_build_cmd()
To:     Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
        "Joerg Roedel" <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     John Garry <john.garry@huawei.com>
References: <20210817113450.2026-1-thunder.leizhen@huawei.com>
 <6fea9ce0-7b8d-bd46-6b85-f3f9ba3ddd48@arm.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <54b94259-628a-1763-0f1e-e2e7c2b2a297@huawei.com>
Date:   Wed, 18 Aug 2021 10:28:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <6fea9ce0-7b8d-bd46-6b85-f3f9ba3ddd48@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.242]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/8/17 21:23, Robin Murphy wrote:
> On 2021-08-17 12:34, Zhen Lei wrote:
>> Although the parameter 'cmd' is always passed by a local array variable,
>> and only this function modifies it, the compiler does not know this. The
>> compiler almost always reads the value of cmd[i] from memory rather than
>> directly using the value cached in the register. This generates many
>> useless instruction operations and affects the performance to some extent.
> 
> Which compiler? GCC 4.9 does not make the same codegen decisions that GCC 10 does; Clang is different again. There are also various config options which affect a compiler's inlining/optimisation choices either directly or indirectly.

gcc version 7.3.1 20180425 [linaro-7.3-2018.05 revision d29120a424ecfbc167ef90065c0eeb7f91977701] (Linaro GCC 7.3-2018.05)

In addition, yesterday morning I also purposely compiled a compiler with the latest
GCC source code. The result is the same.

gcc version 11.2.0 (GCC)

> 
> If it's something that newer compilers can get right anyway, then micro-optimising just for older ones might warrant a bit more justification.
> 
>> To guide the compiler for proper optimization, 'cmd' is defined as a local
>> array variable, marked as register, and copied to the output parameter at
>> a time when the function is returned.
>>
>> The optimization effect can be viewed by running the "size arm-smmu-v3.o"
>> command.
>>
>> Before:
>>     text    data     bss     dec     hex
>>    27602    1348      56   29006    714e
>>
>> After:
>>     text    data     bss     dec     hex
>>    27402    1348      56   28806    7086
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 18 +++++++++++++++---
>>   1 file changed, 15 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> index d76bbbde558b776..50a9db5bac466c7 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> @@ -233,11 +233,19 @@ static int queue_remove_raw(struct arm_smmu_queue *q, u64 *ent)
>>       return 0;
>>   }
>>   +#define arm_smmu_cmdq_copy_cmd(dst, src)    \
>> +    do {                    \
>> +        dst[0] = src[0];        \
>> +        dst[1] = src[1];        \
>> +    } while (0)
>> +
>>   /* High-level queue accessors */
>> -static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
>> +static int arm_smmu_cmdq_build_cmd(u64 *out_cmd, struct arm_smmu_cmdq_ent *ent)
>>   {
>> -    memset(cmd, 0, 1 << CMDQ_ENT_SZ_SHIFT);
>> -    cmd[0] |= FIELD_PREP(CMDQ_0_OP, ent->opcode);
>> +    register u64 cmd[CMDQ_ENT_DWORDS];
>> +
>> +    cmd[0] = FIELD_PREP(CMDQ_0_OP, ent->opcode);
>> +    cmd[1] = 0;
>>         switch (ent->opcode) {
>>       case CMDQ_OP_TLBI_EL2_ALL:
>> @@ -309,6 +317,7 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
>>           case PRI_RESP_SUCC:
>>               break;
>>           default:
>> +            arm_smmu_cmdq_copy_cmd(out_cmd, cmd);
> 
> Why bother writing back a partial command when we're telling the caller it's invalid anyway?

Some callers do not check the return value of arm_smmu_cmdq_build_cmd().
In particular, the arm_smmu_cmdq_batch_add has no judgment. Yes, I should
add judgment there.

> 
>>               return -EINVAL;
>>           }
>>           cmd[1] |= FIELD_PREP(CMDQ_PRI_1_RESP, ent->pri.resp);
>> @@ -329,9 +338,12 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
>>           cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_MSIATTR, ARM_SMMU_MEMATTR_OIWB);
>>           break;
>>       default:
>> +        arm_smmu_cmdq_copy_cmd(out_cmd, cmd);
> 
> Ditto.
> 
>>           return -ENOENT;
>>       }
>>   +    arm_smmu_cmdq_copy_cmd(out_cmd, cmd);
> 
> ...and then it would be simpler to open-code the assignment here.

Right, I'll modify it in v2. I also don't like the addition of arm_smmu_cmdq_copy_cmd().

> 
> I guess if you're really concerned with avoiding temporary commands being written back to the stack and reloaded, it might be worth experimenting with wrapping them in a struct which can be passed around by value - AAPCS64 allows passing a 16-byte composite type purely in registers.

'out_cmd' is an output parameter. Use 16-byte composite type need to modify
many functions, this may not be good..

> 
> Robin.
> 
>> +
>>       return 0;
>>   }
>>  
> .
> 
