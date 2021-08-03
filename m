Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE4F3DEB07
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 12:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235510AbhHCKgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 06:36:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:37408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235254AbhHCKgQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 06:36:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D137160F58;
        Tue,  3 Aug 2021 10:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627986965;
        bh=OKjeuOM6V0zI7ozBJZBwK2+rpt/Y8fFWQlLVfX7CcCc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TzormALcrksfXm3/ozDNOrUjiK9T4bOuW7LOMOpv+HBrpO2IHzm1VLBOFb1krOuMU
         Lvxew2ej+IRxCVIe1c4fc9U2Hw+rVwqABkfiU7Azk2PYH3PP4gv9Ap32vkTKQPH9/Q
         agWi4w3XGZeHm+uQbqMYUWKc5X5ZIWZoAP4maZJbeBAYoquaz2KWncAkgaLFxXmCXX
         9gjAH/b/A54MXuDRlXCiro1uFDr69tNmA3ybxzObRCnECbEPNbif5qE7fljuDi5qbJ
         LtQt+4dcn1+QUHWxtAvDiFpbZUDF2J7Rh2C6u0NIbuAQitBoqBrqZ08V4HfB+QdpmI
         FDPspXLllLHkQ==
Date:   Tue, 3 Aug 2021 11:36:00 +0100
From:   Will Deacon <will@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        suravee.suthikulpanit@amd.com, baolu.lu@linux.intel.com,
        john.garry@huawei.com, dianders@chromium.org
Subject: Re: [PATCH v2 23/24] iommu/arm-smmu: Allow non-strict in
 pgtable_quirks interface
Message-ID: <20210803103559.GA30690@willie-the-truck>
References: <cover.1627468308.git.robin.murphy@arm.com>
 <0fcd1f5225a6b435cbc697551a6247cd435c04db.1627468310.git.robin.murphy@arm.com>
 <20210802130438.GA28547@willie-the-truck>
 <3dd7cdae-7111-6ff2-6350-a0e19fe4ab66@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3dd7cdae-7111-6ff2-6350-a0e19fe4ab66@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02, 2021 at 03:15:50PM +0100, Robin Murphy wrote:
> On 2021-08-02 14:04, Will Deacon wrote:
> > On Wed, Jul 28, 2021 at 04:58:44PM +0100, Robin Murphy wrote:
> > > To make io-pgtable aware of a flush queue being dynamically enabled,
> > > allow IO_PGTABLE_QUIRK_NON_STRICT to be set even after a domain has been
> > > attached to, and hook up the final piece of the puzzle in iommu-dma.
> > > 
> > > Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> > > ---
> > >   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 15 +++++++++++++++
> > >   drivers/iommu/arm/arm-smmu/arm-smmu.c       | 11 +++++++++++
> > >   drivers/iommu/dma-iommu.c                   |  3 +++
> > >   3 files changed, 29 insertions(+)
> > > 
> > > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > index 19400826eba7..40fa9cb382c3 100644
> > > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > @@ -2711,6 +2711,20 @@ static int arm_smmu_enable_nesting(struct iommu_domain *domain)
> > >   	return ret;
> > >   }
> > > +static int arm_smmu_set_pgtable_quirks(struct iommu_domain *domain,
> > > +		unsigned long quirks)
> > > +{
> > > +	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
> > > +
> > > +	if (quirks == IO_PGTABLE_QUIRK_NON_STRICT && smmu_domain->pgtbl_ops) {
> > > +		struct io_pgtable *iop = io_pgtable_ops_to_pgtable(smmu_domain->pgtbl_ops);
> > > +
> > > +		iop->cfg.quirks |= IO_PGTABLE_QUIRK_NON_STRICT;
> > > +		return 0;
> > > +	}
> > > +	return -EINVAL;
> > > +}
> > 
> > I don't see anything serialising this against a concurrent iommu_unmap(), so
> > the ordering and atomicity looks quite suspicious to me here. I don't think
> > it's just the page-table quirks either, but also setting cookie->fq_domain.
> 
> Heh, I confess to very much taking the cheeky "let's say nothing and see
> what Will thinks about concurrency" approach here :)

Damnit, I fell for that didn't I?

Overall, I'm really nervous about the concurrency here and think we'd be
better off requiring the unbind as we have for the other domain changes.

> The beauty of only allowing relaxation in the strict->non-strict direction
> is that it shouldn't need serialising as such - it doesn't matter if the
> update to cookie->fq_domain is observed between iommu_unmap() and
> iommu_dma_free_iova(), since there's no correctness impact to queueing IOVAs
> which may already have been invalidated and may or may not have been synced.
> AFAICS the only condition which matters is that the setting of the
> io-pgtable quirk must observe fq_domain being set. It feels like there must
> be enough dependencies on the read side, but we might need an smp_wmb()
> between the two in iommu_dma_init_fq()?
> 
> I've also flip-flopped a bit on whether fq_domain needs to be accessed with
> READ_ONCE/WRITE_ONCE - by the time of posting I'd convinced myself that it
> was probably OK, but looking again now I suppose this wacky reordering is
> theoretically possible:
> 
> 
> 	iommu_dma_unmap() {
> 		bool free_fq = cookie->fq_domain; // == false
> 
> 		iommu_unmap();
> 
> 		if (!cookie->fq_domain) // observes new non-NULL value
> 			iommu_tlb_sync(); // skipped
> 
> 		iommu_dma_free_iova { // inlined
> 			if (free_fq) // false
> 				queue_iova();
> 			else
> 				free_iova_fast(); // Uh-oh!
> 		}
> 	}
> 
> so although I still can't see atomicity being a problem I guess we do need
> it for the sake of reordering at least.

With your changes, I think quite a few things can go wrong.

  * cookie->fq_domain may be observed but iovad->fq could be NULL
  * We can miss the smp_wmb() in the pgtable code but end up deferring the
    IOVA reclaim
  * iommu_change_dev_def_domain() only holds the group mutex afaict, so can
    possibly run concurrently with itself on the same domain?
  * iommu_dma_init_fq() can flip the domain type back from
    IOMMU_DOMAIN_DMA_FQ to IOMMU_DOMAIN_DMA on the error path
  * set_pgtable_quirks() isn't atomic, which probably is ok for now, but the
    moment we use it anywhere else it's dangerous

and I suspect there are more :/

Will
