Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FAA23E82F5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 20:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234525AbhHJSZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 14:25:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:53690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241593AbhHJSZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 14:25:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 159936056C;
        Tue, 10 Aug 2021 18:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628619899;
        bh=XbSvD674RGlSPfIxav1H631OYTL4qbTMztVKJu94RmE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DP2yJU21UM40aoq+olIUxsGijAPx/54KDW0L2HA9jcuB1s+ob8A/qEGqH/gcz4Rt/
         k3iS9l6IciBEPaKctYkl2yetJYVe+XwpYQ1BEkg+dZ5tbX6r8tUUfbk057P2kSZtAR
         hZFuezBTIUpwZzyO6ItV0yJlvISdEuGVKBhNb3f373gCXm4U58DjStb+oJgC6hS6qI
         OTHGqyaPt5CtqkCgDXGYFqBpva3OaIKo3fwTPU1xbHaP16id6w77LpiO5fWvZchRN/
         zoojfv8EZAOYTrNjppNhBoAbrnYL2DYTz7E6rEUMDJrXuCDaG5ffmuU4+WD89C3mMa
         j5cdq7t96Dxew==
Date:   Tue, 10 Aug 2021 19:24:54 +0100
From:   Will Deacon <will@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC 2/8] iommu/arm-smmu-v3: Add and use static helper
 function arm_smmu_cmdq_issue_cmd_with_sync()
Message-ID: <20210810182454.GB3296@willie-the-truck>
References: <20210626110130.2416-1-thunder.leizhen@huawei.com>
 <20210626110130.2416-3-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210626110130.2416-3-thunder.leizhen@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 26, 2021 at 07:01:24PM +0800, Zhen Lei wrote:
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
> Therefore, function arm_smmu_cmdq_issue_cmd_with_sync() is added to insert
> the 'cmd+sync' commands at a time.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 33 +++++++++++++--------
>  1 file changed, 21 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 2433d3c29b49ff2..a5361153ca1d6a4 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -858,11 +858,25 @@ static int arm_smmu_cmdq_issue_cmd(struct arm_smmu_device *smmu,
>  	return arm_smmu_cmdq_issue_cmdlist(smmu, cmd, 1, false);
>  }
>  
> -static int arm_smmu_cmdq_issue_sync(struct arm_smmu_device *smmu)
> +static int __maybe_unused arm_smmu_cmdq_issue_sync(struct arm_smmu_device *smmu)
>  {
>  	return arm_smmu_cmdq_issue_cmdlist(smmu, NULL, 0, true);
>  }
>  
> +static int arm_smmu_cmdq_issue_cmd_with_sync(struct arm_smmu_device *smmu,
> +					     struct arm_smmu_cmdq_ent *ent)
> +{
> +	u64 cmd[CMDQ_ENT_DWORDS];
> +
> +	if (arm_smmu_cmdq_build_cmd(cmd, ent)) {
> +		dev_warn(smmu->dev, "ignoring unknown CMDQ opcode 0x%x\n",
> +			 ent->opcode);
> +		return -EINVAL;
> +	}
> +
> +	return arm_smmu_cmdq_issue_cmdlist(smmu, cmd, 1, true);
> +}

This function is almost identical to arm_smmu_cmdq_issue_cmd(). How about
moving the guts out into a helper:

	static int __arm_smmu_cmdq_issue_cmd(struct arm_smmu_device *smmu,
					     struct arm_smmu_cmdq_ent *ent,
					     bool sync);

and then having arm_smmu_cmdq_issue_cmd_with_sync() and
arm_smmu_cmdq_issue_cmd() wrap that?

Will
