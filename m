Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE7DA3E8ECB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 12:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237204AbhHKKeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 06:34:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:60388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237116AbhHKKeN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 06:34:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ECD0360C3E;
        Wed, 11 Aug 2021 10:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628678030;
        bh=MG7heJZm5M3tEsl415rXYzpWZZsIqmxepajSEhkW4Zo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RkuqxgEd02iFCSEOmFrL6Lj/suWCuMrUu0fBECIz8mEjKlnHsjlvIwLmWXayBI4Re
         oZvfIrh7+xC86tFxJHW8SKB/YbYeNXNtVKwsFMJrmiRcbkxpnsDM9Gyr0NF9Tx05eL
         d6n8iqUo9ZMGfyCSqYV81EERnG3geug5cBJRdmmWa96V70yrmdv7REaVMTHpEBiNq+
         RBLk8UI5qQHo+uIbngO+jZHUIyWDZQu4gOpt7SiSXL1HF/exMLTmgfxtkMySOuVpry
         Z/dEEi8lNKQJv6UHHHeefspGTTd3zZSjfhYcuGgUB0TfugRT1VzoeIlIaHegB1TdJm
         BsEKf0t/yQ4gA==
Date:   Wed, 11 Aug 2021 11:33:45 +0100
From:   Will Deacon <will@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC 2/8] iommu/arm-smmu-v3: Add and use static helper
 function arm_smmu_cmdq_issue_cmd_with_sync()
Message-ID: <20210811103344.GA4736@willie-the-truck>
References: <20210626110130.2416-1-thunder.leizhen@huawei.com>
 <20210626110130.2416-3-thunder.leizhen@huawei.com>
 <20210810182454.GB3296@willie-the-truck>
 <b9fa05b5-d3ee-5c79-c8b8-b908e533646a@huawei.com>
 <20210811100905.GB4426@willie-the-truck>
 <d551f31d-4edc-db28-fb08-41a130a5d97f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d551f31d-4edc-db28-fb08-41a130a5d97f@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2021 at 11:31:08AM +0100, John Garry wrote:
> > > > > Obviously, inserting as many commands at a time as possible can reduce the
> > > > > number of times the mutex contention participates, thereby improving the
> > > > > overall performance. At least it reduces the number of calls to function
> > > > > arm_smmu_cmdq_issue_cmdlist().
> > > > > 
> > > > > Therefore, function arm_smmu_cmdq_issue_cmd_with_sync() is added to insert
> > > > > the 'cmd+sync' commands at a time.
> > > > > 
> > > > > Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> > > > > ---
> > > > >   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 33 +++++++++++++--------
> > > > >   1 file changed, 21 insertions(+), 12 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > > > index 2433d3c29b49ff2..a5361153ca1d6a4 100644
> > > > > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > > > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > > > @@ -858,11 +858,25 @@ static int arm_smmu_cmdq_issue_cmd(struct arm_smmu_device *smmu,
> > > > >   	return arm_smmu_cmdq_issue_cmdlist(smmu, cmd, 1, false);
> > > > >   }
> > > > > -static int arm_smmu_cmdq_issue_sync(struct arm_smmu_device *smmu)
> > > > > +static int __maybe_unused arm_smmu_cmdq_issue_sync(struct arm_smmu_device *smmu)
> > > > >   {
> > > > >   	return arm_smmu_cmdq_issue_cmdlist(smmu, NULL, 0, true);
> > > > >   }
> > > > > +static int arm_smmu_cmdq_issue_cmd_with_sync(struct arm_smmu_device *smmu,
> > > > > +					     struct arm_smmu_cmdq_ent *ent)
> > > > > +{
> > > > > +	u64 cmd[CMDQ_ENT_DWORDS];
> > > > > +
> > > > > +	if (arm_smmu_cmdq_build_cmd(cmd, ent)) {
> > > > > +		dev_warn(smmu->dev, "ignoring unknown CMDQ opcode 0x%x\n",
> > > > > +			 ent->opcode);
> > > > > +		return -EINVAL;
> 
> Are any of the errors returned from the "issue command" functions actually
> consumed? I couldn't see it on mainline code from a brief browse.

I don't think so. Can we actually propagate them?

Will
