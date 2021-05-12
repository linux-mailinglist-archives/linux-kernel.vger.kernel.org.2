Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 193DB37EB69
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 00:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380220AbhELTap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 15:30:45 -0400
Received: from mga11.intel.com ([192.55.52.93]:22674 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245743AbhELQ5S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 12:57:18 -0400
IronPort-SDR: PcXimC+t3lq2yVupjQbjzL1Wsb0smygLkeb/Ra2XIZ99JIjY0o9gTaeRGVClwwIjRkEvoxpgDm
 T4RyHYqfuyBA==
X-IronPort-AV: E=McAfee;i="6200,9189,9982"; a="196660939"
X-IronPort-AV: E=Sophos;i="5.82,293,1613462400"; 
   d="scan'208";a="196660939"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2021 09:56:05 -0700
IronPort-SDR: IeV1lHQFk5f6Ts24SI0GTrT1YtPg2oIgUi1emWWX4gumZsh+/1vA95q/TOZoUabcqibaNEGqcL
 lwfTTRMDnhnw==
X-IronPort-AV: E=Sophos;i="5.82,293,1613462400"; 
   d="scan'208";a="392818030"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.36])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2021 09:56:04 -0700
Date:   Wed, 12 May 2021 09:56:02 -0700
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        kevin.tian@intel.com, jacob.jun.pan@intel.com, yi.l.liu@intel.com,
        sanjay.k.kumar@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH 1/1] iommu/vt-d: Tweak the description of a DMA fault
Message-ID: <20210512165602.GA102348@otc-nc-03>
References: <20210512065012.3441160-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210512065012.3441160-1-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2021 at 02:50:12PM +0800, Lu Baolu wrote:
> The Intel IOMMU driver reports the DMA fault reason in a decimal number
> while the VT-d specification uses a hexadecimal one. It's inconvenient
> that users need to covert them everytime before consulting the spec.
> Let's use hexadecimal number for a DMA fault reason.
> 
> The fault message uses 0xffffffff as PASID for DMA requests w/o PASID.
> This is confusing. Tweak this by adding "w/o PASID" explicitly.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Maybe simpler to call it NO_PASID, and just PASID 0xxxxx instead?

with the minor suggestions below

Reviewed-by: Ashok Raj <ashok.raj@intel.com>

> ---
>  drivers/iommu/intel/dmar.c | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> index 1757ac1e1623..11e37d2c2af2 100644
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -1911,15 +1911,21 @@ static int dmar_fault_do_one(struct intel_iommu *iommu, int type,
>  	reason = dmar_get_fault_reason(fault_reason, &fault_type);
>  
>  	if (fault_type == INTR_REMAP)
> -		pr_err("[INTR-REMAP] Request device [%02x:%02x.%d] fault index %llx [fault reason %02d] %s\n",
> -			source_id >> 8, PCI_SLOT(source_id & 0xFF),
> -			PCI_FUNC(source_id & 0xFF), addr >> 48,
> -			fault_reason, reason);
> -	else
> -		pr_err("[%s] Request device [%02x:%02x.%d] PASID %x fault addr %llx [fault reason %02d] %s\n",
> +		pr_err("[INTR-REMAP] Request device [%02x:%02x.%d] fault index %llx [fault reason %02xh] %s\n",
> +		       source_id >> 8, PCI_SLOT(source_id & 0xFF),
> +		       PCI_FUNC(source_id & 0xFF), addr >> 48,
> +		       fault_reason, reason);
> +	else if (pasid == INVALID_IOASID)
> +		pr_err("[%s w/o PASID] Request device [%02x:%02x.%d] fault addr %llx [fault reason %02xh] %s\n",
>  		       type ? "DMA Read" : "DMA Write",
>  		       source_id >> 8, PCI_SLOT(source_id & 0xFF),
> -		       PCI_FUNC(source_id & 0xFF), pasid, addr,
> +		       PCI_FUNC(source_id & 0xFF), addr,
> +		       fault_reason, reason);
> +	else
> +		pr_err("[%s w/ PASID %x] Request device [%02x:%02x.%d] fault addr %llx [fault reason %02xh] %s\n",

Can you always lead hex values with 0x?

> +		       type ? "DMA Read" : "DMA Write", pasid,
> +		       source_id >> 8, PCI_SLOT(source_id & 0xFF),
> +		       PCI_FUNC(source_id & 0xFF), addr,
>  		       fault_reason, reason);
>  	return 0;
>  }
> @@ -1987,7 +1993,7 @@ irqreturn_t dmar_fault(int irq, void *dev_id)
>  		if (!ratelimited)
>  			/* Using pasid -1 if pasid is not present */
>  			dmar_fault_do_one(iommu, type, fault_reason,
> -					  pasid_present ? pasid : -1,
> +					  pasid_present ? pasid : INVALID_IOASID,
>  					  source_id, guest_addr);
>  
>  		fault_index++;
> -- 
> 2.25.1
> 

-- 
Cheers,
Ashok

[Forgiveness is the attribute of the STRONG - Gandhi]
