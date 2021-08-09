Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7020E3E45ED
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 14:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233528AbhHIMxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 08:53:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:36818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233093AbhHIMxE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 08:53:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D482360E78;
        Mon,  9 Aug 2021 12:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628513564;
        bh=2GdN8DXcLKY6quaCw1rtuvP0Kw0zfqRfIg+LPre32c4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=itunlC02CLGsvDphIlDR/5dpsZL296ArW0IxZolvss0dFEd7dhOrjDGQ5oL8kUi+8
         ZSLKB6GrOeIEQnEL0YG+kij+D39yylkWqWcsQYmN31c5XX9gOpac6sJ5nQ2WJ9JndP
         m7fh+4pnBwzVj+Lh/HWS0Tbf65NwwGNYY89zjNmxi/g37dk646P9n/qDMST1+ZkGnp
         lwFctwo1zC2t8zfLRGCtw+1JqnX68dcCjppXGZt5+LvBO6y5oYoZGkCxMYch3B6Vo4
         JngGmJo9wH8dZ+UsstcyL2rGsf8wL2qCBNJbZRPT1wjrdOm2T0Yia767C61TT3mFlv
         5ubgaHRseS4Kw==
Date:   Mon, 9 Aug 2021 13:52:39 +0100
From:   Will Deacon <will@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, linux-kernel@vger.kernel.org,
        dianders@chromium.org, iommu@lists.linux-foundation.org,
        rajatja@google.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 24/25] iommu/dma: Factor out flush queue init
Message-ID: <20210809125238.GB1097@willie-the-truck>
References: <cover.1628094600.git.robin.murphy@arm.com>
 <3b5284ee394f267ba966839173f874fc9a996bb2.1628094601.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b5284ee394f267ba966839173f874fc9a996bb2.1628094601.git.robin.murphy@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 04, 2021 at 06:15:52PM +0100, Robin Murphy wrote:
> Factor out flush queue setup from the initial domain init so that we
> can potentially trigger it from sysfs later on in a domain's lifetime.
> 
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: John Garry <john.garry@huawei.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/dma-iommu.c | 30 ++++++++++++++++++++----------
>  include/linux/dma-iommu.h |  9 ++++++---
>  2 files changed, 26 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 2e19505dddf9..f51b8dc99ac6 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -310,6 +310,25 @@ static bool dev_is_untrusted(struct device *dev)
>  	return dev_is_pci(dev) && to_pci_dev(dev)->untrusted;
>  }
>  
> +int iommu_dma_init_fq(struct iommu_domain *domain)
> +{
> +	struct iommu_dma_cookie *cookie = domain->iova_cookie;
> +
> +	if (domain->type != IOMMU_DOMAIN_DMA_FQ)
> +		return -EINVAL;
> +	if (cookie->fq_domain)
> +		return 0;
> +
> +	if (init_iova_flush_queue(&cookie->iovad, iommu_dma_flush_iotlb_all,
> +				  iommu_dma_entry_dtor)) {
> +		pr_warn("iova flush queue initialization failed\n");
> +		domain->type = IOMMU_DOMAIN_DMA;
> +		return -ENODEV;

I do find this a bit odd: we assert that the caller has set domain->type
to IOMMU_DOMAIN_DMA_FQ but then on failure we reset it to IOMMU_DOMAIN_DMA
here. I think it would be less error-prone if the setting of domain->type
was handled in the same function.

Will
