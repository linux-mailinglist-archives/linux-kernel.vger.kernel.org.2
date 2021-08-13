Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1D053EB9B1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 18:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241482AbhHMQCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 12:02:12 -0400
Received: from foss.arm.com ([217.140.110.172]:55338 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241152AbhHMQCL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 12:02:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A84FB1FB;
        Fri, 13 Aug 2021 09:01:44 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B50B33F718;
        Fri, 13 Aug 2021 09:01:43 -0700 (PDT)
Subject: Re: [PATCH 1/4] iommu/arm-smmu-v3: Use command queue batching helpers
 to improve performance
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <20210811114852.2429-1-thunder.leizhen@huawei.com>
 <20210811114852.2429-2-thunder.leizhen@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <81258eb7-eb73-8a32-0983-3487daba1167@arm.com>
Date:   Fri, 13 Aug 2021 17:01:38 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210811114852.2429-2-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-11 12:48, Zhen Lei wrote:
> The obvious key to the performance optimization of commit 587e6c10a7ce
> ("iommu/arm-smmu-v3: Reduce contention during command-queue insertion") is
> to allow multiple cores to insert commands in parallel after a brief mutex
> contention.
> 
> Obviously, inserting as many commands at a time as possible can reduce the
> number of times the mutex contention participates, thereby improving the
> overall performance. At least it reduces the number of calls to function
> arm_smmu_cmdq_issue_cmdlist().
> 
> Therefore, use command queue batching helpers to insert multiple commands
> at a time.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 235f9bdaeaf223b..c81cd929047f573 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1747,15 +1747,16 @@ static int arm_smmu_atc_inv_master(struct arm_smmu_master *master)
>   {
>   	int i;
>   	struct arm_smmu_cmdq_ent cmd;
> +	struct arm_smmu_cmdq_batch cmds = {};

BTW, it looks like this has crossed over with John's patch removing these.

Robin.

>   
>   	arm_smmu_atc_inv_to_cmd(0, 0, 0, &cmd);
>   
>   	for (i = 0; i < master->num_streams; i++) {
>   		cmd.atc.sid = master->streams[i].id;
> -		arm_smmu_cmdq_issue_cmd(master->smmu, &cmd);
> +		arm_smmu_cmdq_batch_add(master->smmu, &cmds, &cmd);
>   	}
>   
> -	return arm_smmu_cmdq_issue_sync(master->smmu);
> +	return arm_smmu_cmdq_batch_submit(master->smmu, &cmds);
>   }
>   
>   int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain, int ssid,
> 
