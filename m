Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 347AA321EA6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 18:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbhBVR7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 12:59:00 -0500
Received: from mga06.intel.com ([134.134.136.31]:4489 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230306AbhBVR64 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 12:58:56 -0500
IronPort-SDR: 4/L6QinlOgFzOs5B7TDkG9PO9Dj1CpR+MMjxqR9aJUdbDTl/z2Gsp+R/BDIRt2UjMlbOOB6O5M
 cAzjmVOfUkbw==
X-IronPort-AV: E=McAfee;i="6000,8403,9903"; a="245957615"
X-IronPort-AV: E=Sophos;i="5.81,197,1610438400"; 
   d="scan'208";a="245957615"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2021 09:57:10 -0800
IronPort-SDR: EiAgx9BcJeHoJJxNILbt0ATqQN8YupwBd7ME4C8JWsvg4II1d/cdeXGcWindSzUkn76jF3j4d1
 XM0mMi/NrUZQ==
X-IronPort-AV: E=Sophos;i="5.81,197,1610438400"; 
   d="scan'208";a="364097390"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2021 09:57:10 -0800
Date:   Mon, 22 Feb 2021 09:59:48 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        Yi Liu <yi.l.liu@intel.com>, Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Wu Hao <hao.wu@intel.com>,
        Yi Sun <yi.y.sun@intel.com>, Dave Jiang <dave.jiang@intel.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Sanjay Kumar <sanjay.k.kumar@intel.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH 1/4] iommu/vt-d: Enable write protect for supervisor SVM
Message-ID: <20210222095948.295178f5@jacob-builder>
In-Reply-To: <fba522cc-7f34-a090-4669-e7720452033b@linux.intel.com>
References: <1613683878-89946-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1613683878-89946-2-git-send-email-jacob.jun.pan@linux.intel.com>
        <fba522cc-7f34-a090-4669-e7720452033b@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lu,

On Sat, 20 Feb 2021 09:56:26 +0800, Lu Baolu <baolu.lu@linux.intel.com>
wrote:

> Hi Jacob and Sanjay,
> 
> On 2/19/21 5:31 AM, Jacob Pan wrote:
> > Write protect bit, when set, inhibits supervisor writes to the read-only
> > pages. In supervisor shared virtual addressing (SVA), where page tables
> > are shared between CPU and DMA, IOMMU PASID entry WPE bit should match
> > CR0.WP bit in the CPU.
> > This patch sets WPE bit for supervisor PASIDs if CR0.WP is set.  
> 
>  From reading the commit message, the intention of this patch is to match
> PASID entry WPE bith with CPU CR0.WP if 1) SRE is set (supervisor
> pasid); 2) page table is shared between CPU and IOMMU. Do I understand
> it right?
> 
yes. that is my intention.

> But what the real code doing is failing pasid entry setup for first
> level translation if CPU CR0.WP is not set. It's not consistent with
> what described above.
> 
> What I am thinking is that, as long as SRE is set, we should always set
> WPE in intel_pasid_setup_first_level(). For supervisor SVA case, we
> should check CPU CR0.WP in intel_svm_bind_mm() and abort binding if
> CR0.WP is not set.
> 
> Thought?
> 
This code only affects supervisor SVA, since PASID_FLAG_SUPERVISOR_MODE
flag is not set for FL IOVA.

> Best regards,
> baolu
> 
> > 
> > Signed-off-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >   drivers/iommu/intel/pasid.c | 26 ++++++++++++++++++++++++++
> >   1 file changed, 26 insertions(+)
> > 
> > diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
> > index 0cceaabc3ce6..0b7e0e726ade 100644
> > --- a/drivers/iommu/intel/pasid.c
> > +++ b/drivers/iommu/intel/pasid.c
> > @@ -410,6 +410,15 @@ static inline void pasid_set_sre(struct
> > pasid_entry *pe) pasid_set_bits(&pe->val[2], 1 << 0, 1);
> >   }
> >   
> > +/*
> > + * Setup the WPE(Write Protect Enable) field (Bit 132) of a
> > + * scalable mode PASID entry.
> > + */
> > +static inline void pasid_set_wpe(struct pasid_entry *pe)
> > +{
> > +	pasid_set_bits(&pe->val[2], 1 << 4, 1 << 4);
> > +}
> > +
> >   /*
> >    * Setup the P(Present) field (Bit 0) of a scalable mode PASID
> >    * entry.
> > @@ -553,6 +562,20 @@ static void pasid_flush_caches(struct intel_iommu
> > *iommu, }
> >   }
> >   
> > +static inline int pasid_enable_wpe(struct pasid_entry *pte)
> > +{
> > +	unsigned long cr0 = read_cr0();
> > +
> > +	/* CR0.WP is normally set but just to be sure */
> > +	if (unlikely(!(cr0 & X86_CR0_WP))) {
> > +		pr_err_ratelimited("No CPU write protect!\n");
> > +		return -EINVAL;
> > +	}
> > +	pasid_set_wpe(pte);
> > +
> > +	return 0;
> > +};
> > +
> >   /*
> >    * Set up the scalable mode pasid table entry for first only
> >    * translation type.
> > @@ -584,6 +607,9 @@ int intel_pasid_setup_first_level(struct
> > intel_iommu *iommu, return -EINVAL;
> >   		}
> >   		pasid_set_sre(pte);
> > +		if (pasid_enable_wpe(pte))
> > +			return -EINVAL;
> > +
> >   	}
> >   
> >   	if (flags & PASID_FLAG_FL5LP) {
> >   


Thanks,

Jacob
