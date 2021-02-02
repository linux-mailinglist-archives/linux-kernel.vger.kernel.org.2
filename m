Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7EB30C7AC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 18:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237408AbhBBR1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 12:27:48 -0500
Received: from 8bytes.org ([81.169.241.247]:54076 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234129AbhBBOOh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 09:14:37 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 83B4E3E6; Tue,  2 Feb 2021 15:13:51 +0100 (CET)
Date:   Tue, 2 Feb 2021 15:13:50 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        Baolin Wang <baolin.wang7@gmail.com>,
        linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        Sheng Xu <sheng.xu@unisoc.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: Re: [PATCH 2/2] iommu: add Unisoc iommu basic driver
Message-ID: <20210202141349.GB32671@8bytes.org>
References: <20210202073258.559443-3-zhang.lyra@gmail.com>
 <20210202104257.736836-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202104257.736836-1-zhang.lyra@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 02, 2021 at 06:42:57PM +0800, Chunyan Zhang wrote:
> +static phys_addr_t sprd_iommu_iova_to_phys(struct iommu_domain *domain,
> +					   dma_addr_t iova)
> +{
> +	struct sprd_iommu_domain *dom = to_sprd_domain(domain);
> +	unsigned long flags;
> +	phys_addr_t pa;
> +	unsigned long start = domain->geometry.aperture_start;
> +	unsigned long end = domain->geometry.aperture_end;
> +
> +	if (iova < start || iova > end)
> +		pr_err("iova (0x%llx) exceed the vpn range[0x%lx-0x%lx]!\n",
> +		       iova, start, end);

It is not a good idea to continue here with an out-of-range iova. The
code below might access random memory for its checks. Better do a
WARN_ON here and return an invalid physical address.

> +
> +	spin_lock_irqsave(&dom->pgtlock, flags);
> +	pa = *(dom->pgt_va + ((iova - start) >> SPRD_IOMMU_PAGE_SHIFT));
> +	pa = (pa << SPRD_IOMMU_PAGE_SHIFT) + ((iova - start) & (SPRD_IOMMU_PAGE_SIZE - 1));
> +	spin_unlock_irqrestore(&dom->pgtlock, flags);
> +
> +	return pa;
> +}
> +
