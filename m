Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 318923DD663
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 15:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233761AbhHBNEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 09:04:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:59256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233645AbhHBNEx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 09:04:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 009E960FC1;
        Mon,  2 Aug 2021 13:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627909484;
        bh=ZgQ7QJgecBwwh1ArbvcKHFHcRL7o3t2ryIirvGXNdvM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G4TMOdi7yTY1vtU//csNd7tLpkHXDpBr2WeQf5Sz1YbBTbSwc0T+ghVCoNWzvDZN6
         no7Nsgwhy69t1Qu3BSB3o47J0eFDa10psaLhc2coaEy6ZMantZ6wxvA31lRNc5SQDK
         0TW9oarNKxI+eciwapRPEgTF86NLI8z2Xy2ZAAyHFfUvOI890HlHt1wGwZ8dnfi9gv
         B6mz1p65fqDi4LbdkyXQzwL965aWMNANepCe6ASOtHFFMZ5e5DBDLqrfGG9sxj3djb
         4JoNmbQTNzXDJOfX3EYDKmgQKuDHKVNXSTBMRi1oylaoo0Gm1zt+3x81KpbWep/m0R
         gnb6BTB8Qzgqg==
Date:   Mon, 2 Aug 2021 14:04:39 +0100
From:   Will Deacon <will@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        suravee.suthikulpanit@amd.com, baolu.lu@linux.intel.com,
        john.garry@huawei.com, dianders@chromium.org
Subject: Re: [PATCH v2 23/24] iommu/arm-smmu: Allow non-strict in
 pgtable_quirks interface
Message-ID: <20210802130438.GA28547@willie-the-truck>
References: <cover.1627468308.git.robin.murphy@arm.com>
 <0fcd1f5225a6b435cbc697551a6247cd435c04db.1627468310.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fcd1f5225a6b435cbc697551a6247cd435c04db.1627468310.git.robin.murphy@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 04:58:44PM +0100, Robin Murphy wrote:
> To make io-pgtable aware of a flush queue being dynamically enabled,
> allow IO_PGTABLE_QUIRK_NON_STRICT to be set even after a domain has been
> attached to, and hook up the final piece of the puzzle in iommu-dma.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 15 +++++++++++++++
>  drivers/iommu/arm/arm-smmu/arm-smmu.c       | 11 +++++++++++
>  drivers/iommu/dma-iommu.c                   |  3 +++
>  3 files changed, 29 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 19400826eba7..40fa9cb382c3 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2711,6 +2711,20 @@ static int arm_smmu_enable_nesting(struct iommu_domain *domain)
>  	return ret;
>  }
>  
> +static int arm_smmu_set_pgtable_quirks(struct iommu_domain *domain,
> +		unsigned long quirks)
> +{
> +	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
> +
> +	if (quirks == IO_PGTABLE_QUIRK_NON_STRICT && smmu_domain->pgtbl_ops) {
> +		struct io_pgtable *iop = io_pgtable_ops_to_pgtable(smmu_domain->pgtbl_ops);
> +
> +		iop->cfg.quirks |= IO_PGTABLE_QUIRK_NON_STRICT;
> +		return 0;
> +	}
> +	return -EINVAL;
> +}

I don't see anything serialising this against a concurrent iommu_unmap(), so
the ordering and atomicity looks quite suspicious to me here. I don't think
it's just the page-table quirks either, but also setting cookie->fq_domain.

Will
