Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 444823ECFA5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 09:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234410AbhHPHsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 03:48:40 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:17024 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234043AbhHPHsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 03:48:35 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Gp5lR6SgRzb2Sx;
        Mon, 16 Aug 2021 15:44:19 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 16 Aug 2021 15:47:59 +0800
Received: from [10.174.178.242] (10.174.178.242) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 16 Aug 2021 15:47:58 +0800
Subject: Re: [PATCH 1/4] iommu/arm-smmu-v3: Use command queue batching helpers
 to improve performance
To:     John Garry <john.garry@huawei.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
References: <20210811114852.2429-1-thunder.leizhen@huawei.com>
 <20210811114852.2429-2-thunder.leizhen@huawei.com>
 <81258eb7-eb73-8a32-0983-3487daba1167@arm.com>
 <4e741216-d6e7-c40c-f257-242cd2fea302@huawei.com>
 <5482d2e5-24db-6139-a8a8-74be1282e2ec@huawei.com>
 <52204403-f69a-d2b9-9365-7553e87d1298@huawei.com>
 <a3cdd5df-c028-5484-ce99-928a689d341a@huawei.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <e8b71423-e827-f141-1203-00aca2e70834@huawei.com>
Date:   Mon, 16 Aug 2021 15:47:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <a3cdd5df-c028-5484-ce99-928a689d341a@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.242]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/8/16 15:24, John Garry wrote:
>> In addition, I find that function arm_smmu_cmdq_build_cmd() can also be optimized
>> slightly, three useless instructions can be reduced.
> 
> I think that you could optimise further by pre-building commonly used commands.
> 
> For example, CMD_SYNC without MSI polling is always the same. And then only different in 1 field for MSI polling.
> 
> But you need to check if the performance gain is worth the change.

Good advice. I can give it a try.

> 
>>
>> Case 1):
>> void arm_smmu_cmdq_build_cmd_tst1(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
>> {
>>          memset(cmd, 0, 1 << CMDQ_ENT_SZ_SHIFT);
>>          cmd[0] |= FIELD_PREP(CMDQ_0_OP, ent->opcode);
>> }
>> 0000000000004608 <arm_smmu_cmdq_build_cmd_tst1>:
>>      4608:       a9007c1f        stp     xzr, xzr, [x0]
>>      460c:       39400022        ldrb    w2, [x1]
>>      4610:       f9400001        ldr     x1, [x0]
>>      4614:       aa020021        orr     x1, x1, x2
>>      4618:       f9000001        str     x1, [x0]
>>      461c:       d65f03c0        ret
>>
>> Case 2):
>> void arm_smmu_cmdq_build_cmd_tst2(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
>> {
>>          int i;
>>
>>          cmd[0] = FIELD_PREP(CMDQ_0_OP, ent->opcode);
>>          for (i = 1; i < CMDQ_ENT_DWORDS; i++)
>>                  cmd[i] = 0;
>> }
>> 0000000000004620 <arm_smmu_cmdq_build_cmd_tst2>:
>>      4620:       39400021        ldrb    w1, [x1]
>>      4624:       a9007c01        stp     x1, xzr, [x0]
>>      4628:       d65f03c0        ret
>>      462c:       d503201f        nop
>>
>> Case 3):
>> void arm_smmu_cmdq_build_cmd_tst3(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
>> {
>>          memset(cmd, 0, 1 << CMDQ_ENT_SZ_SHIFT);
>>          cmd[0] = FIELD_PREP(CMDQ_0_OP, ent->opcode);
>> }
>> 0000000000004630 <arm_smmu_cmdq_build_cmd_tst3>:
>>      4630:       a9007c1f        stp     xzr, xzr, [x0]
>>      4634:       39400021        ldrb    w1, [x1]
>>      4638:       f9000001        str     x1, [x0]
>>      463c:       d65f03c0        ret
>>
> 
> .
> 
