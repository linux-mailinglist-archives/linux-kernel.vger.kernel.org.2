Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 468B5321EBB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 19:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbhBVSB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 13:01:26 -0500
Received: from mga06.intel.com ([134.134.136.31]:4652 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231936AbhBVSAQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 13:00:16 -0500
IronPort-SDR: P1ztj35Hud7HIUErJQ9wcUp1xZO/wkjTj840sZ7vNuFDDrSOZ+QP7LzqU8S4ogcfUwHH8HB5xK
 KLMuGGYryd7g==
X-IronPort-AV: E=McAfee;i="6000,8403,9903"; a="245958041"
X-IronPort-AV: E=Sophos;i="5.81,197,1610438400"; 
   d="scan'208";a="245958041"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2021 09:58:30 -0800
IronPort-SDR: IA7AY8wsZOxpoKUHheB4xcj/giQmReA+JZG0euxu7ms2z7uPEeoGak2bviLbsthLmeu3gP6qzR
 znzSJYah6wwQ==
X-IronPort-AV: E=Sophos;i="5.81,197,1610438400"; 
   d="scan'208";a="432171493"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2021 09:58:29 -0800
Date:   Mon, 22 Feb 2021 10:01:06 -0800
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
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH 2/4] iommu/vt-d: Enable write protect propagation from
 guest
Message-ID: <20210222100106.0ae8380e@jacob-builder>
In-Reply-To: <MWHPR11MB1886D3FA49A212684239530D8C839@MWHPR11MB1886.namprd11.prod.outlook.com>
References: <1613683878-89946-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1613683878-89946-3-git-send-email-jacob.jun.pan@linux.intel.com>
        <MWHPR11MB1886F4395B64EC23277D88328C849@MWHPR11MB1886.namprd11.prod.outlook.com>
        <20210219090841.4ae6f01c@jacob-builder>
        <MWHPR11MB1886D3FA49A212684239530D8C839@MWHPR11MB1886.namprd11.prod.outlook.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin,

On Sat, 20 Feb 2021 02:38:02 +0000, "Tian, Kevin" <kevin.tian@intel.com>
wrote:

> > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Sent: Saturday, February 20, 2021 1:09 AM
> > 
> > Hi Kevin,
> > 
> > On Fri, 19 Feb 2021 06:19:04 +0000, "Tian, Kevin" <kevin.tian@intel.com>
> > wrote:
> >   
> > > > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > > Sent: Friday, February 19, 2021 5:31 AM
> > > >
> > > > Write protect bit, when set, inhibits supervisor writes to the
> > > > read-only pages. In guest supervisor shared virtual addressing
> > > > (SVA), write-protect should be honored upon guest bind supervisor
> > > > PASID request.
> > > >
> > > > This patch extends the VT-d portion of the IOMMU UAPI to include WP
> > > > bit. WPE bit of the  supervisor PASID entry will be set to match
> > > > CPU CR0.WP bit.
> > > >
> > > > Signed-off-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
> > > > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > > ---
> > > >  drivers/iommu/intel/pasid.c | 5 +++++
> > > >  include/uapi/linux/iommu.h  | 3 ++-
> > > >  2 files changed, 7 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/iommu/intel/pasid.c
> > > > b/drivers/iommu/intel/pasid.c index 0b7e0e726ade..c7a2ec930af4
> > > > 100644 --- a/drivers/iommu/intel/pasid.c
> > > > +++ b/drivers/iommu/intel/pasid.c
> > > > @@ -763,6 +763,11 @@ intel_pasid_setup_bind_data(struct  
> > intel_iommu  
> > > > *iommu, struct pasid_entry *pte,
> > > >  			return -EINVAL;
> > > >  		}
> > > >  		pasid_set_sre(pte);
> > > > +		/* Enable write protect WP if guest requested */
> > > > +		if (pasid_data->flags & IOMMU_SVA_VTD_GPASID_WPE) {
> > > > +			if (pasid_enable_wpe(pte))
> > > > +				return -EINVAL;  
> > >
> > > We should call pasid_set_wpe directly, as this binding is about guest
> > > page table and suppose the guest has done whatever check required
> > > (e.g. gcr0.wp) before setting this bit. pasid_enable_wpe has an
> > > additional check on host cr0.wp thus is logically incorrect here.
> > >  
> > If the host CPU does not support WP, can guest VCPU still support WP? If
> > so, I agree.
> >   
> 
> If you change 'support' to 'enable', then the answer is yes.

I agree, thanks for explaining. Will change it to pasid_set_wpe.

Thanks,

Jacob
