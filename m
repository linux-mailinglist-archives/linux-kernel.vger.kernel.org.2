Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1841361400
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 23:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235710AbhDOVQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 17:16:31 -0400
Received: from mga02.intel.com ([134.134.136.20]:6498 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234959AbhDOVQa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 17:16:30 -0400
IronPort-SDR: cOmfhycYgrXXfAL7B4EchOUSG+0UqDMSDnLXPGMBGWF3TFhx/wsqpAY8GZHnz7I2siT99b7dpx
 GvTIZBCe71TA==
X-IronPort-AV: E=McAfee;i="6200,9189,9955"; a="182068864"
X-IronPort-AV: E=Sophos;i="5.82,225,1613462400"; 
   d="scan'208";a="182068864"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 14:16:06 -0700
IronPort-SDR: q5op6QHfmrt3NbPHSPNKpJwGJNDmsFZ2z4LhgON7RFerF+9cnD82iJXQadzBHw5/coMOJnqkkU
 0cBuTmD4hyYg==
X-IronPort-AV: E=Sophos;i="5.82,225,1613462400"; 
   d="scan'208";a="461754208"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 14:16:06 -0700
Date:   Thu, 15 Apr 2021 14:18:45 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, vkoul@kernel.org,
        Jason Gunthorpe <jgg@nvidia.com>, zhangfei.gao@linaro.org,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v2 2/2] iommu/sva: Remove mm parameter from SVA bind API
Message-ID: <20210415141845.06e5a1cf@jacob-builder>
In-Reply-To: <20210415064459.GB1938497@infradead.org>
References: <1618414077-28808-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1618414077-28808-3-git-send-email-jacob.jun.pan@linux.intel.com>
        <20210415064459.GB1938497@infradead.org>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On Thu, 15 Apr 2021 07:44:59 +0100, Christoph Hellwig <hch@infradead.org>
wrote:

> >   *
> >   * Returns 0 on success and < 0 on error.
> > @@ -28,6 +28,9 @@ int iommu_sva_alloc_pasid(struct mm_struct *mm,
> > ioasid_t min, ioasid_t max) int ret = 0;
> >  	ioasid_t pasid;
> >  
> > +	if (mm != current->mm)
> > +		return -EINVAL;
> > +  
> 
> Why not remove the parameter entirely?
It was removed in my v1 but thought it would be cleaner if we treat
iommu_sva_alloc_pasid() as a leaf function of iommu_sva_bind_device(). Then
we don't have to do get_task_mm() every time. But to your point below, it
is better to get low-level driver handle it.
> 
> > @@ -2989,8 +2990,11 @@ iommu_sva_bind_device(struct device *dev, struct
> > mm_struct *mm, unsigned int fla return ERR_PTR(-ENODEV);
> >  
> >  	/* Supervisor SVA does not need the current mm */
> > -	if ((flags & IOMMU_SVA_BIND_SUPERVISOR) && mm)
> > -		return ERR_PTR(-EINVAL);
> > +	if (!(flags & IOMMU_SVA_BIND_SUPERVISOR)) {
> > +		mm = get_task_mm(current);
> > +		if (!mm)
> > +			return ERR_PTR(-EINVAL);
> > +	}  
> 
> I don't see why we need the reference.  I think we should just stop
> passing the mm to ->sva_bind and let the low-level driver deal with
> any reference to current->mm where needed.
The mm users reference is just for precaution, in case low level driver use
kthread etc.
I agree it is cleaner to just remove mm here, let the low-level driver deal
with it.
Let me give it a spin.

Thanks,

Jacob
