Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E795637EB71
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 00:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380378AbhELTbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 15:31:20 -0400
Received: from mga14.intel.com ([192.55.52.115]:33132 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242223AbhELRFT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 13:05:19 -0400
IronPort-SDR: jg/idgA9MigghB8bQqgU5x4cfq0XDjaILrbMDEa1ycJsWZq9gFbWBXBa1cCwKdBlh+OJY7ENyz
 5bmr3CM02HkA==
X-IronPort-AV: E=McAfee;i="6200,9189,9982"; a="199435632"
X-IronPort-AV: E=Sophos;i="5.82,293,1613462400"; 
   d="scan'208";a="199435632"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2021 10:03:52 -0700
IronPort-SDR: EZnuhS0IuWujoEwn2ARLWM9dR+Ej2WeYFGDec7GJnuonITU50yOOwT9KnPIB3ISjn7rz4ZBs+8
 Bw32tv6jxK3g==
X-IronPort-AV: E=Sophos;i="5.82,293,1613462400"; 
   d="scan'208";a="610015657"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.36])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2021 10:03:51 -0700
Date:   Wed, 12 May 2021 10:03:49 -0700
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        kevin.tian@intel.com, jacob.jun.pan@intel.com, yi.l.liu@intel.com,
        sanjay.k.kumar@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [RESEND PATACH 1/1] iommu/vt-d: Use user privilege for RID2PASID
 translation
Message-ID: <20210512170349.GB102348@otc-nc-03>
References: <20210512064426.3440915-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210512064426.3440915-1-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2021 at 02:44:26PM +0800, Lu Baolu wrote:
> When first-level page tables are used for IOVA translation, we use user
> privilege by setting U/S bit in the page table entry. This is to make it
> consistent with the second level translation, where the U/S enforcement
> is not available. Clear the SRE (Supervisor Request Enable) field in the
> pasid table entry of RID2PASID so that requests requesting the supervisor
> privilege are blocked and treated as DMA remapping faults.
> 
> Suggested-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Fixes: b802d070a52a1 ("iommu/vt-d: Use iova over first level")
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.c | 7 +++++--
>  drivers/iommu/intel/pasid.c | 3 ++-
>  2 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 708f430af1c4..f1742da42478 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -2525,9 +2525,9 @@ static int domain_setup_first_level(struct intel_iommu *iommu,
>  				    struct device *dev,
>  				    u32 pasid)
>  {
> -	int flags = PASID_FLAG_SUPERVISOR_MODE;
>  	struct dma_pte *pgd = domain->pgd;
>  	int agaw, level;
> +	int flags = 0;
>  
>  	/*
>  	 * Skip top levels of page tables for iommu which has
> @@ -2543,7 +2543,10 @@ static int domain_setup_first_level(struct intel_iommu *iommu,
>  	if (level != 4 && level != 5)
>  		return -EINVAL;
>  
> -	flags |= (level == 5) ? PASID_FLAG_FL5LP : 0;
> +	if (pasid != PASID_RID2PASID)
> +		flags |= PASID_FLAG_SUPERVISOR_MODE;
> +	if (level == 5)
> +		flags |= PASID_FLAG_FL5LP;

Given that we are still not bought into the supervisor PASID, should we make this an 
explicit request before turning on SUPERVISOR mode always? Since
pasid_set_sre() has no return, we have no way to fail it.



>  
>  	if (domain->domain.type == IOMMU_DOMAIN_UNMANAGED)
>  		flags |= PASID_FLAG_PAGE_SNOOP;
> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
> index 72646bafc52f..72dc84821dad 100644
> --- a/drivers/iommu/intel/pasid.c
> +++ b/drivers/iommu/intel/pasid.c
> @@ -699,7 +699,8 @@ int intel_pasid_setup_second_level(struct intel_iommu *iommu,
>  	 * Since it is a second level only translation setup, we should
>  	 * set SRE bit as well (addresses are expected to be GPAs).
>  	 */
> -	pasid_set_sre(pte);
> +	if (pasid != PASID_RID2PASID)
> +		pasid_set_sre(pte);
>  	pasid_set_present(pte);
>  	pasid_flush_caches(iommu, pte, pasid, did);
>  
> -- 
> 2.25.1
> 

-- 
Cheers,
Ashok

[Forgiveness is the attribute of the STRONG - Gandhi]
