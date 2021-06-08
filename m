Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 988B839F285
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 11:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbhFHJgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 05:36:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:38996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229507AbhFHJgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 05:36:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DD0A761208;
        Tue,  8 Jun 2021 09:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623144898;
        bh=OBg9ZyaK512GGHt182oF1kF5QsrSXhwvc7zhceE23oM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iDb+QR31ZeM+YOq1a0JSVmmISfgSlciNzX/PmhKHv1750KXls7wRjZCHvq/zT9stC
         CThLm/qbdLjJXoWle+V4R5fcGAdx4eoEIrVUm/It3A47aJVhN3Ctk7L1ZPuk6hpVxl
         abUtxuBD4DLrmkD/iXYD8kwVAX3uEy6SN9TQ25l4yeFGP5HwV4MTaIBsBsD00qni23
         t5k0+WW0QoavnXoqbxbazgVPF1B+gJFpQEr1Dcu3yAFFsTAanJ1gUETwGMz5xQAskA
         INiuFeE/aHoi5nG6BRZeuQP0CwrcXpdLuO/HOp9udFSE95oT1tggqpOoU3nsbadaQ6
         VDBodI6R5uqXg==
Date:   Tue, 8 Jun 2021 10:34:53 +0100
From:   Will Deacon <will@kernel.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, ashok.raj@intel.com,
        kevin.tian@intel.com, jacob.jun.pan@intel.com, yi.l.liu@intel.com,
        sanjay.k.kumar@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Select PCI_ATS explicitly
Message-ID: <20210608093453.GB8935@willie-the-truck>
References: <20210512065313.3441309-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210512065313.3441309-1-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2021 at 02:53:13PM +0800, Lu Baolu wrote:
> The Intel VT-d implementation supports device TLB management. Select
> PCI_ATS explicitly so that the pci_ats helpers are always available.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
> index 28a3d1596c76..7e5b240b801d 100644
> --- a/drivers/iommu/intel/Kconfig
> +++ b/drivers/iommu/intel/Kconfig
> @@ -14,6 +14,7 @@ config INTEL_IOMMU
>  	select SWIOTLB
>  	select IOASID
>  	select IOMMU_DMA
> +	select PCI_ATS
>  	help
>  	  DMA remapping (DMAR) devices support enables independent address
>  	  translations for Direct Memory Access (DMA) from devices.

Acked-by: Will Deacon <will@kernel.org>

Will
