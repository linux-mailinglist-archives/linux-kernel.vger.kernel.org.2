Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B929340921
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 16:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbhCRPpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 11:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbhCRPo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 11:44:56 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A32C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 08:44:56 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 80F502DA; Thu, 18 Mar 2021 16:44:54 +0100 (CET)
Date:   Thu, 18 Mar 2021 16:44:49 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Jon.Grimm@amd.com, Wei.Huang2@amd.com
Subject: Re: [RFC PATCH 7/7] iommu/amd: Add support for using AMD IOMMU v2
 page table for DMA-API
Message-ID: <YFN1cdOrH7v81CJt@8bytes.org>
References: <20210312090411.6030-1-suravee.suthikulpanit@amd.com>
 <20210312090411.6030-8-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312090411.6030-8-suravee.suthikulpanit@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 03:04:11AM -0600, Suravee Suthikulpanit wrote:
> Introduce init function for setting up DMA domain for DMA-API with
> the IOMMU v2 page table.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/iommu/amd/iommu.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index e29ece6e1e68..bd26de8764bd 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -1937,6 +1937,24 @@ static int protection_domain_init_v1(struct protection_domain *domain, int mode)
>  	return 0;
>  }
>  
> +static int protection_domain_init_v2(struct protection_domain *domain)
> +{
> +	spin_lock_init(&domain->lock);
> +	domain->id = domain_id_alloc();
> +	if (!domain->id)
> +		return -ENOMEM;
> +	INIT_LIST_HEAD(&domain->dev_list);
> +
> +	domain->giov = true;
> +
> +	if (amd_iommu_pgtable == AMD_IOMMU_V2 &&
> +	    domain_enable_v2(domain, 1, false)) {
> +		return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
> +

You also need to advertise a different aperture size and a different
pgsize-bitmap. The host page-table can only map a 48 bit address space,
not a 64 bit one like with v1 page-tables.

Regards,

	Joerg
