Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 830413EEBF2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 13:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236948AbhHQLy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 07:54:29 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3655 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236693AbhHQLy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 07:54:28 -0400
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GpqD04WDBz6BGJN;
        Tue, 17 Aug 2021 19:53:04 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Tue, 17 Aug 2021 13:53:53 +0200
Received: from [10.202.227.179] (10.202.227.179) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Tue, 17 Aug 2021 12:53:53 +0100
Subject: Re: [PATCH] iommu/arm-smmu-v3: Stop pre-zeroing batch commands in
 arm_smmu_atc_inv_master()
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
References: <20210817113411.1962-1-thunder.leizhen@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <23f1cc66-2172-9534-53ef-3d9b2db26bda@huawei.com>
Date:   Tue, 17 Aug 2021 12:53:52 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20210817113411.1962-1-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.179]
X-ClientProxiedBy: lhreml702-chm.china.huawei.com (10.201.108.51) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/08/2021 12:34, Zhen Lei wrote:
> Pre-zeroing the batched commands structure is inefficient, as individual
> commands are zeroed later in arm_smmu_cmdq_build_cmd(). Therefore, only
> the member 'num' needs to be initialized to 0.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

Reviewed-by: John Garry <john.garry@huawei.com>

> ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 50a9db5bac466c7..e6882ae81fd08f6 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1776,10 +1776,11 @@ static int arm_smmu_atc_inv_master(struct arm_smmu_master *master)
>   {
>   	int i;
>   	struct arm_smmu_cmdq_ent cmd;
> -	struct arm_smmu_cmdq_batch cmds = {};
> +	struct arm_smmu_cmdq_batch cmds;
>   
>   	arm_smmu_atc_inv_to_cmd(0, 0, 0, &cmd);
>   
> +	cmds.num = 0;

We prob should have added a comment why we do this (and at the other 
sites). I think Robin said something similar in another patch.

>   	for (i = 0; i < master->num_streams; i++) {
>   		cmd.atc.sid = master->streams[i].id;
>   		arm_smmu_cmdq_batch_add(master->smmu, &cmds, &cmd);
> 

