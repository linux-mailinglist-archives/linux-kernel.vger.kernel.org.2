Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C506361282
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 20:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234628AbhDOSvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 14:51:42 -0400
Received: from mga18.intel.com ([134.134.136.126]:33714 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234407AbhDOSvk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 14:51:40 -0400
IronPort-SDR: GDWBM4ICIyYL4g+ZiJ6Xdx2SO77lOhqUOGKVc8oupANUy/4oyKL8rcDsyx1b2bFhJeWLo6fKRF
 u474Zb5Jbbhw==
X-IronPort-AV: E=McAfee;i="6200,9189,9955"; a="182415585"
X-IronPort-AV: E=Sophos;i="5.82,225,1613462400"; 
   d="scan'208";a="182415585"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 11:51:09 -0700
IronPort-SDR: 7mVjtdxduOhFD/qaBlx9o4lynInMuvOEE55/fJFzvq8O3LoZz3ue7rXJ2xgmFz8gjZXlaOAAMM
 HquB5oNUgcIQ==
X-IronPort-AV: E=Sophos;i="5.82,225,1613462400"; 
   d="scan'208";a="384108451"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 11:51:09 -0700
Date:   Thu, 15 Apr 2021 11:53:48 -0700
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
Subject: Re: [PATCH v2 1/2] iommu/sva: Tighten SVA bind API with explicit
 flags
Message-ID: <20210415115348.107554aa@jacob-builder>
In-Reply-To: <20210415064033.GA1938497@infradead.org>
References: <1618414077-28808-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1618414077-28808-2-git-send-email-jacob.jun.pan@linux.intel.com>
        <20210415064033.GA1938497@infradead.org>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

Thanks for the review.

On Thu, 15 Apr 2021 07:40:33 +0100, Christoph Hellwig <hch@infradead.org>
wrote:

> On Wed, Apr 14, 2021 at 08:27:56AM -0700, Jacob Pan wrote:
> >  static int idxd_enable_system_pasid(struct idxd_device *idxd)
> >  {
> > -	int flags;
> > +	unsigned int flags;
> >  	unsigned int pasid;
> >  	struct iommu_sva *sva;
> >  
> > -	flags = SVM_FLAG_SUPERVISOR_MODE;
> > +	flags = IOMMU_SVA_BIND_SUPERVISOR;
> >  
> > -	sva = iommu_sva_bind_device(&idxd->pdev->dev, NULL, &flags);
> > +	sva = iommu_sva_bind_device(&idxd->pdev->dev, NULL, flags);  
> 
> Please also remove the now pointless flags variable.
> 
Good catch.

> > +iommu_sva_bind_device(struct device *dev, struct mm_struct *mm,
> > unsigned int flags)  
> 
> Pleae avoid the pointless overly long line.
> 
> > -#define SVM_FLAG_GUEST_PASID		(1<<3)
> > +#define SVM_FLAG_GUEST_PASID		(1<<2)  
> 
> This flag is entirely unused, please just remove it in a prep patch
> rather than renumbering it.
> 
You are right. The flag was set and intended to be used by the guest IO
page request patches by Baolu.

As you might be aware, we are restructuring the guest SVA uAPI according to
Jason's proposal, can we wait until we have a clear solution? We may
refactor lots of code.

> >  static inline struct iommu_sva *
> > -iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, void
> > *drvdata) +iommu_sva_bind_device(struct device *dev, struct mm_struct
> > *mm, unsigned int flags)  
> 
> Same overy long line here.
This is temporary as the mm parameter will be removed in the next patch.

Thanks,

Jacob
