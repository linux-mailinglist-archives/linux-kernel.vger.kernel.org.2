Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33A093E8E25
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 12:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236883AbhHKKJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 06:09:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:53396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236690AbhHKKJd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 06:09:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 20E5A601FD;
        Wed, 11 Aug 2021 10:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628676550;
        bh=WFdcMDOdwT6iqhf90eKghlHbPA/yHhanICAd1+UlmRM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vAuQbY91bb67oIRwclNTdMUX+7hGHLmfOVBobsNUxT24P57KeqHCdpi20UnTatwot
         OZTwRCmKEHFSunGGfYDgTE4fvaSJFZSFMq9eR4Vj+Mq7MkOs0tQGNsscLUOj5Vs3LI
         fi6VUbSxohmzU3VdJiV4LVrxqFwDx+djRZUBmkqB5Nw8ogI/nwRutVaqUWWic9Q+DV
         XcXffrF9Gzgc7UVsNls69LOLZ/rgVhMuQEvqM7u6l6pJI6unO60/779Am1YIu7Ah+7
         oxEOBtNDLKDCD61Gii2bw60MtIHfAyuFvv9rv9XqZRGmgsDTvTYd77MPiKiw1TLOow
         H1fZODrUX+eyg==
Date:   Wed, 11 Aug 2021 11:09:06 +0100
From:   Will Deacon <will@kernel.org>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC 2/8] iommu/arm-smmu-v3: Add and use static helper
 function arm_smmu_cmdq_issue_cmd_with_sync()
Message-ID: <20210811100905.GB4426@willie-the-truck>
References: <20210626110130.2416-1-thunder.leizhen@huawei.com>
 <20210626110130.2416-3-thunder.leizhen@huawei.com>
 <20210810182454.GB3296@willie-the-truck>
 <b9fa05b5-d3ee-5c79-c8b8-b908e533646a@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9fa05b5-d3ee-5c79-c8b8-b908e533646a@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2021 at 10:16:39AM +0800, Leizhen (ThunderTown) wrote:
> 
> 
> On 2021/8/11 2:24, Will Deacon wrote:
> > On Sat, Jun 26, 2021 at 07:01:24PM +0800, Zhen Lei wrote:
> >> The obvious key to the performance optimization of commit 587e6c10a7ce
> >> ("iommu/arm-smmu-v3: Reduce contention during command-queue insertion") is
> >> to allow multiple cores to insert commands in parallel after a brief mutex
> >> contention.
> >>
> >> Obviously, inserting as many commands at a time as possible can reduce the
> >> number of times the mutex contention participates, thereby improving the
> >> overall performance. At least it reduces the number of calls to function
> >> arm_smmu_cmdq_issue_cmdlist().
> >>
> >> Therefore, function arm_smmu_cmdq_issue_cmd_with_sync() is added to insert
> >> the 'cmd+sync' commands at a time.
> >>
> >> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> >> ---
> >>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 33 +++++++++++++--------
> >>  1 file changed, 21 insertions(+), 12 deletions(-)
> >>
> >> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> >> index 2433d3c29b49ff2..a5361153ca1d6a4 100644
> >> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> >> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> >> @@ -858,11 +858,25 @@ static int arm_smmu_cmdq_issue_cmd(struct arm_smmu_device *smmu,
> >>  	return arm_smmu_cmdq_issue_cmdlist(smmu, cmd, 1, false);
> >>  }
> >>  
> >> -static int arm_smmu_cmdq_issue_sync(struct arm_smmu_device *smmu)
> >> +static int __maybe_unused arm_smmu_cmdq_issue_sync(struct arm_smmu_device *smmu)
> >>  {
> >>  	return arm_smmu_cmdq_issue_cmdlist(smmu, NULL, 0, true);
> >>  }
> >>  
> >> +static int arm_smmu_cmdq_issue_cmd_with_sync(struct arm_smmu_device *smmu,
> >> +					     struct arm_smmu_cmdq_ent *ent)
> >> +{
> >> +	u64 cmd[CMDQ_ENT_DWORDS];
> >> +
> >> +	if (arm_smmu_cmdq_build_cmd(cmd, ent)) {
> >> +		dev_warn(smmu->dev, "ignoring unknown CMDQ opcode 0x%x\n",
> >> +			 ent->opcode);
> >> +		return -EINVAL;
> >> +	}
> >> +
> >> +	return arm_smmu_cmdq_issue_cmdlist(smmu, cmd, 1, true);
> >> +}
> > 
> > This function is almost identical to arm_smmu_cmdq_issue_cmd(). How about
> > moving the guts out into a helper:
> > 
> > 	static int __arm_smmu_cmdq_issue_cmd(struct arm_smmu_device *smmu,
> > 					     struct arm_smmu_cmdq_ent *ent,
> > 					     bool sync);
> > 
> > and then having arm_smmu_cmdq_issue_cmd_with_sync() and
> > arm_smmu_cmdq_issue_cmd() wrap that?
> 
> OK, I will do it.
> 
> How about remove arm_smmu_cmdq_issue_sync()? It's unused now.

Sure.

Will
