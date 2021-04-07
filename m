Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61825356A1D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 12:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347078AbhDGKoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 06:44:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:51702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235796AbhDGKop (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 06:44:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 47AB76108B;
        Wed,  7 Apr 2021 10:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617792275;
        bh=/OYd8ejLQFNhGdZWMDHFlb/wavoCjwGmIAxQChr4y0I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lAszGQDh0IJBjt0Zb7UzHLOMuePGL2eE4/Fa3nR+8cALdr/D3xE+fbRUg65zaCChS
         Tw9C9Ho1Ii2Ir5HqgHluupVFxpSi0GhucOKYs3I/v0TcC04EBAYufuFcQ4tSpnbHiJ
         sNfTaqT+4iuid7/+sFakR9fZ+WpxUsytMrx5qRQLefU/Iigd39UlGeCX7RyZUpSI4M
         WPib7+YcHlLoX0XmybUhmv6kl5MpvOthmQ1r2pOV4hevL+NrVlF2/3XjNyGMFmo8Hx
         t2DMY/uaYlS8TnOAEXez9s1NJ9r+iGXiwmz3fjqnHEKojuFLqM0r4BWEK3uCVX08a/
         Gn/jyTL3rHHuw==
Date:   Wed, 7 Apr 2021 11:44:29 +0100
From:   Will Deacon <will@kernel.org>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>, devicetree@vger.kernel.org,
        Hector Martin <marcan@marcan.st>, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        linux-arm-kernel@lists.infradead.org,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH v2 1/3] iommu: io-pgtable: add DART pagetable format
Message-ID: <20210407104425.GB15173@willie-the-truck>
References: <20210328074009.95932-1-sven@svenpeter.dev>
 <20210328074009.95932-2-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210328074009.95932-2-sven@svenpeter.dev>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 28, 2021 at 09:40:07AM +0200, Sven Peter wrote:
> Apple's DART iommu uses a pagetable format that shares some
> similarities with the ones already implemented by io-pgtable.c.
> Add a new format variant to support the required differences
> so that we don't have to duplicate the pagetable handling code.
> 
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
>  drivers/iommu/io-pgtable-arm.c | 59 ++++++++++++++++++++++++++++++++++
>  drivers/iommu/io-pgtable.c     |  1 +
>  include/linux/io-pgtable.h     |  6 ++++
>  3 files changed, 66 insertions(+)
> 
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index 87def58e79b5..2f63443fd115 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -127,6 +127,9 @@
>  #define ARM_MALI_LPAE_MEMATTR_IMP_DEF	0x88ULL
>  #define ARM_MALI_LPAE_MEMATTR_WRITE_ALLOC 0x8DULL
>  
> +#define APPLE_DART_PTE_PROT_NO_WRITE (1<<7)
> +#define APPLE_DART_PTE_PROT_NO_READ (1<<8)
> +
>  /* IOPTE accessors */
>  #define iopte_deref(pte,d) __va(iopte_to_paddr(pte, d))
>  
> @@ -381,6 +384,15 @@ static arm_lpae_iopte arm_lpae_prot_to_pte(struct arm_lpae_io_pgtable *data,
>  {
>  	arm_lpae_iopte pte;
>  
> +	if (data->iop.fmt == ARM_APPLE_DART) {
> +		pte = 0;
> +		if (!(prot & IOMMU_WRITE))
> +			pte |= APPLE_DART_PTE_PROT_NO_WRITE;
> +		if (!(prot & IOMMU_READ))
> +			pte |= APPLE_DART_PTE_PROT_NO_READ;
> +		return pte;
> +	}
> +
>  	if (data->iop.fmt == ARM_64_LPAE_S1 ||
>  	    data->iop.fmt == ARM_32_LPAE_S1) {
>  		pte = ARM_LPAE_PTE_nG;
> @@ -1043,6 +1055,48 @@ arm_mali_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
>  	return NULL;
>  }
>  
> +static struct io_pgtable *
> +apple_dart_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
> +{
> +	struct arm_lpae_io_pgtable *data;
> +
> +	if (cfg->ias > 36)
> +		return NULL;
> +	if (cfg->oas > 36)
> +		return NULL;
> +
> +	if (!cfg->coherent_walk)
> +		return NULL;

This all feels like IOMMU-specific limitations leaking into the page-table
code here; it doesn't feel so unlikely that future implementations of this
IP might have greater addressing capabilities, for example, and so I don't
see why the page-table code needs to police this.

> +	cfg->pgsize_bitmap &= SZ_16K;
> +	if (!cfg->pgsize_bitmap)
> +		return NULL;

This is worrying (and again, I don't think this belongs here). How is this
thing supposed to work if the CPU is using 4k pages?

Will
