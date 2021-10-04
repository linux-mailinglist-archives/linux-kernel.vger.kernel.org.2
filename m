Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B607420A9F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 14:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233171AbhJDMJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 08:09:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:45524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232875AbhJDMJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 08:09:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F24A960F9B;
        Mon,  4 Oct 2021 12:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633349239;
        bh=rCJYdr32dOl1E74PBWpYOr8BwKcZx05HK0ZRUpipNQ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oKQjBWAnxcd/31GhQ0+bLFhoylKcEBeS3fcT6cHbp4QqE8BZDvJ0vXfy85uElZqHk
         mZqNoC9UaK2GU52qbBumDMWACYDr3P7VBcdV4jpnc7/ant6AZwpEWh1HE/RAmdgKHS
         uYPA8/TvcSFKCImvCsQ61FZC1Qu2U8J3xRM/ZSmIfO+y5q/UBTEM/yD7mJ1lTSQYJb
         FnRcNGQmg48BYP7b+1DMZdrn9Owx+r8iZ8+yaxBNpzbiBjOWrcYgTn6DYsaSX+xt5u
         1f5nA91t8/HLEnztt0UX7X+WzXKlQu6zi5mF8//0PAPlnw3vfWK82zU1cX4EkFxgQk
         Kj1AklzDHqRRA==
Date:   Mon, 4 Oct 2021 13:07:15 +0100
From:   Will Deacon <will@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel@vger.kernel.org, John Garry <john.garry@huawei.com>
Subject: Re: [PATCH v2 2/2] iommu/arm-smmu-v3: Simplify useless instructions
 in arm_smmu_cmdq_build_cmd()
Message-ID: <20211004120714.GD27373@willie-the-truck>
References: <20210818080452.2079-1-thunder.leizhen@huawei.com>
 <20210818080452.2079-3-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210818080452.2079-3-thunder.leizhen@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2021 at 04:04:52PM +0800, Zhen Lei wrote:
> Although the parameter 'cmd' is always passed by a local array variable,
> and only this function modifies it, the compiler does not know this. The
> compiler almost always reads the value of cmd[i] from memory rather than
> directly using the value cached in the register. This generates many
> useless instruction operations and affects the performance to some extent.
> 
> To guide the compiler for proper optimization, 'cmd' is defined as a local
> array variable, marked as register, and copied to the output parameter at
> a time when the function is returned.
> 
> The optimization effect can be viewed by running the "size arm-smmu-v3.o"
> command.
> 
> Before:
>    text    data     bss     dec     hex
>   26954    1348      56   28358    6ec6
> 
> After:
>    text    data     bss     dec     hex
>   26762    1348      56   28166    6e06
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 01e95b56ffa07d1..7cec0c967f71d86 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -234,10 +234,12 @@ static int queue_remove_raw(struct arm_smmu_queue *q, u64 *ent)
>  }
>  
>  /* High-level queue accessors */
> -static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
> +static int arm_smmu_cmdq_build_cmd(u64 *out_cmd, struct arm_smmu_cmdq_ent *ent)
>  {
> -	memset(cmd, 0, 1 << CMDQ_ENT_SZ_SHIFT);
> -	cmd[0] |= FIELD_PREP(CMDQ_0_OP, ent->opcode);
> +	register u64 cmd[CMDQ_ENT_DWORDS];

'register' is pretty badly specified outside of a handful of limited uses in
conjunction with inline asm, so I really don't think we should be using it
here.

> +	cmd[0] = FIELD_PREP(CMDQ_0_OP, ent->opcode);

This generates a compiler warning about taking the address of a 'register'
variable.

Will
