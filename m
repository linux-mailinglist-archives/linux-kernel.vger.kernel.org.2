Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE9403DA88D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 18:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232332AbhG2QL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 12:11:27 -0400
Received: from gloria.sntech.de ([185.11.138.130]:58922 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234234AbhG2QJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 12:09:52 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1m98aN-0004AD-4y; Thu, 29 Jul 2021 18:08:39 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        joro@8bytes.org, will@kernel.org, robh+dt@kernel.org,
        xxm@rock-chips.com, robin.murphy@arm.com,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v7 3/4] iommu: rockchip: Add internal ops to handle variants
Date:   Thu, 29 Jul 2021 18:08:38 +0200
Message-ID: <3544194.oiGErgHkdL@diego>
In-Reply-To: <c6175f3d-a324-9fb5-bd39-cfe0447ee5e7@collabora.com>
References: <20210525121551.606240-1-benjamin.gaignard@collabora.com> <20210525121551.606240-4-benjamin.gaignard@collabora.com> <c6175f3d-a324-9fb5-bd39-cfe0447ee5e7@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dafna,

Am Donnerstag, 29. Juli 2021, 17:59:26 CEST schrieb Dafna Hirschfeld:
> On 25.05.21 14:15, Benjamin Gaignard wrote:
> > @@ -879,7 +895,7 @@ static int rk_iommu_enable(struct rk_iommu *iommu)
> >   
> >   	for (i = 0; i < iommu->num_mmu; i++) {
> >   		rk_iommu_write(iommu->bases[i], RK_MMU_DTE_ADDR,
> > -			       rk_domain->dt_dma);
> > +			       rk_ops->dma_addr_dte(rk_domain->dt_dma));
> 
> Hi,
> This is not related to that patch, I was wondring why are all mmu devices initialized
> with the same dt_dma?
> I see for example that the isp0_mmu in rk3399.dtsi has two resources. Can't each resource
> be initialized with different dt_dma and this way there are two dt tables instead of the two mmus pointing
> to the same dt table.

maybe
git log -1 cd6438c5f8446691afa4829fe1a9d7b656204f11

"iommu/rockchip: Reconstruct to support multi slaves
    
There are some IPs, such as video encoder/decoder, contains 2 slave iommus,
one for reading and the other for writing. They share the same irq and
clock with master.
    
This patch reconstructs to support this case by making them share the same
Page Directory, Page Tables and even the register operations.
That means every instruction to the reading MMU registers would be
duplicated to the writing MMU and vice versa."


Heiko


> 
> Thanks,
> Dafna
> 
> >   		rk_iommu_base_command(iommu->bases[i], RK_MMU_CMD_ZAP_CACHE);
> >   		rk_iommu_write(iommu->bases[i], RK_MMU_INT_MASK, RK_MMU_IRQ_MASK);
> >   	}
> > @@ -1037,7 +1053,7 @@ static void rk_iommu_domain_free(struct iommu_domain *domain)
> >   	for (i = 0; i < NUM_DT_ENTRIES; i++) {
> >   		u32 dte = rk_domain->dt[i];
> >   		if (rk_dte_is_pt_valid(dte)) {
> > -			phys_addr_t pt_phys = rk_dte_pt_address(dte);
> > +			phys_addr_t pt_phys = rk_ops->pt_address(dte);
> >   			u32 *page_table = phys_to_virt(pt_phys);
> >   			dma_unmap_single(dma_dev, pt_phys,
> >   					 SPAGE_SIZE, DMA_TO_DEVICE);
> > @@ -1127,6 +1143,7 @@ static int rk_iommu_probe(struct platform_device *pdev)
> >   	struct device *dev = &pdev->dev;
> >   	struct rk_iommu *iommu;
> >   	struct resource *res;
> > +	const struct rk_iommu_ops *ops;
> >   	int num_res = pdev->num_resources;
> >   	int err, i;
> >   
> > @@ -1138,6 +1155,17 @@ static int rk_iommu_probe(struct platform_device *pdev)
> >   	iommu->dev = dev;
> >   	iommu->num_mmu = 0;
> >   
> > +	ops = of_device_get_match_data(dev);
> > +	if (!rk_ops)
> > +		rk_ops = ops;
> > +
> > +	/*
> > +	 * That should not happen unless different versions of the
> > +	 * hardware block are embedded the same SoC
> > +	 */
> > +	if (WARN_ON(rk_ops != ops))
> > +		return -EINVAL;
> > +
> >   	iommu->bases = devm_kcalloc(dev, num_res, sizeof(*iommu->bases),
> >   				    GFP_KERNEL);
> >   	if (!iommu->bases)
> > @@ -1226,6 +1254,8 @@ static int rk_iommu_probe(struct platform_device *pdev)
> >   		}
> >   	}
> >   
> > +	dma_set_mask_and_coherent(dev, rk_ops->dma_bit_mask);
> > +
> >   	return 0;
> >   err_remove_sysfs:
> >   	iommu_device_sysfs_remove(&iommu->iommu);
> > @@ -1277,8 +1307,20 @@ static const struct dev_pm_ops rk_iommu_pm_ops = {
> >   				pm_runtime_force_resume)
> >   };
> >   
> > +static struct rk_iommu_ops iommu_data_ops_v1 = {
> > +	.pt_address = &rk_dte_pt_address,
> > +	.mk_dtentries = &rk_mk_dte,
> > +	.mk_ptentries = &rk_mk_pte,
> > +	.dte_addr_phys = &rk_dte_addr_phys,
> > +	.dma_addr_dte = &rk_dma_addr_dte,
> > +	.dma_bit_mask = DMA_BIT_MASK(32),
> > +};
> > +
> > +
> >   static const struct of_device_id rk_iommu_dt_ids[] = {
> > -	{ .compatible = "rockchip,iommu" },
> > +	{	.compatible = "rockchip,iommu",
> > +		.data = &iommu_data_ops_v1,
> > +	},
> >   	{ /* sentinel */ }
> >   };
> >   
> > 
> 




