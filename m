Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 730E031FD93
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 18:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbhBSRJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 12:09:05 -0500
Received: from mga18.intel.com ([134.134.136.126]:21220 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229734AbhBSRJB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 12:09:01 -0500
IronPort-SDR: Jv8u6AS34n6crgmMTG15Cu4zKgbxut+ojFjqPtOcTt5ZKY5NEshC/g0Hf0rIje3t4LMX4MKyKH
 8DhE6U0kKLUg==
X-IronPort-AV: E=McAfee;i="6000,8403,9900"; a="171567461"
X-IronPort-AV: E=Sophos;i="5.81,189,1610438400"; 
   d="scan'208";a="171567461"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2021 09:06:05 -0800
IronPort-SDR: Di5Ms4CVASvFl+T3Rme5u33oluH6arCvcUasfIeAJYKXj11y0k0t/PB7jgFart2Cn8guOS9cq2
 JXo41pR4RIpQ==
X-IronPort-AV: E=Sophos;i="5.81,189,1610438400"; 
   d="scan'208";a="401112007"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2021 09:06:05 -0800
Date:   Fri, 19 Feb 2021 09:08:41 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>, "Wu, Hao" <hao.wu@intel.com>,
        "Sun, Yi Y" <yi.y.sun@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Eric Auger <eric.auger@redhat.com>,
        "Jean-Philippe Brucker" <jean-philippe@linaro.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH 2/4] iommu/vt-d: Enable write protect propagation from
 guest
Message-ID: <20210219090841.4ae6f01c@jacob-builder>
In-Reply-To: <MWHPR11MB1886F4395B64EC23277D88328C849@MWHPR11MB1886.namprd11.prod.outlook.com>
References: <1613683878-89946-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1613683878-89946-3-git-send-email-jacob.jun.pan@linux.intel.com>
        <MWHPR11MB1886F4395B64EC23277D88328C849@MWHPR11MB1886.namprd11.prod.outlook.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin,

On Fri, 19 Feb 2021 06:19:04 +0000, "Tian, Kevin" <kevin.tian@intel.com>
wrote:

> > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Sent: Friday, February 19, 2021 5:31 AM
> > 
> > Write protect bit, when set, inhibits supervisor writes to the read-only
> > pages. In guest supervisor shared virtual addressing (SVA),
> > write-protect should be honored upon guest bind supervisor PASID
> > request.
> > 
> > This patch extends the VT-d portion of the IOMMU UAPI to include WP bit.
> > WPE bit of the  supervisor PASID entry will be set to match CPU CR0.WP
> > bit.
> > 
> > Signed-off-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >  drivers/iommu/intel/pasid.c | 5 +++++
> >  include/uapi/linux/iommu.h  | 3 ++-
> >  2 files changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
> > index 0b7e0e726ade..c7a2ec930af4 100644
> > --- a/drivers/iommu/intel/pasid.c
> > +++ b/drivers/iommu/intel/pasid.c
> > @@ -763,6 +763,11 @@ intel_pasid_setup_bind_data(struct intel_iommu
> > *iommu, struct pasid_entry *pte,
> >  			return -EINVAL;
> >  		}
> >  		pasid_set_sre(pte);
> > +		/* Enable write protect WP if guest requested */
> > +		if (pasid_data->flags & IOMMU_SVA_VTD_GPASID_WPE) {
> > +			if (pasid_enable_wpe(pte))
> > +				return -EINVAL;  
> 
> We should call pasid_set_wpe directly, as this binding is about guest
> page table and suppose the guest has done whatever check required
> (e.g. gcr0.wp) before setting this bit. pasid_enable_wpe has an
> additional check on host cr0.wp thus is logically incorrect here.
> 
If the host CPU does not support WP, can guest VCPU still support WP? If
so, I agree.

> Thanks
> Kevin
> 
> > +		}
> >  	}
> > 
> >  	if (pasid_data->flags & IOMMU_SVA_VTD_GPASID_EAFE) {
> > diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
> > index 68cb558fe8db..33f3dc7a91de 100644
> > --- a/include/uapi/linux/iommu.h
> > +++ b/include/uapi/linux/iommu.h
> > @@ -288,7 +288,8 @@ struct iommu_gpasid_bind_data_vtd {
> >  #define IOMMU_SVA_VTD_GPASID_PWT	(1 << 3) /* page-level write
> > through */
> >  #define IOMMU_SVA_VTD_GPASID_EMTE	(1 << 4) /* extended mem
> > type enable */
> >  #define IOMMU_SVA_VTD_GPASID_CD		(1 << 5) /* PASID-level
> > cache disable */
> > -#define IOMMU_SVA_VTD_GPASID_LAST	(1 << 6)
> > +#define IOMMU_SVA_VTD_GPASID_WPE	(1 << 6) /* Write protect
> > enable */
> > +#define IOMMU_SVA_VTD_GPASID_LAST	(1 << 7)
> >  	__u64 flags;
> >  	__u32 pat;
> >  	__u32 emt;
> > --
> > 2.25.1  
> 


Thanks,

Jacob
