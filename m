Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60436379DC7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 05:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhEKDac convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 10 May 2021 23:30:32 -0400
Received: from mga09.intel.com ([134.134.136.24]:27291 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229920AbhEKDa1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 23:30:27 -0400
IronPort-SDR: NlyUZ2m1UehV7iVXdKTNH0tj/pZBS0B1KVQtNdM31ULfQ8Fr2cMho3NC3HiOxQ4ki6IbM0qDPP
 kI7n6CTBOBIg==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="199413708"
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="199413708"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 20:29:21 -0700
IronPort-SDR: Uhpb1DvDD4VWPvQUKBbuZtT0+KRdRivARUbZUC56WRz1l0s45RJxsvGjfZ0Rq+c/5mOehZQAfH
 TrML/fzG6MxA==
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="436443967"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 20:29:21 -0700
Date:   Mon, 10 May 2021 20:31:45 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Christoph Hellwig <hch@infradead.org>,
        Yi Liu <yi.l.liu@intel.com>, Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, wangzhou1@hisilicon.com,
        zhangfei.gao@linaro.org, vkoul@kernel.org,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v4 1/2] iommu/sva: Tighten SVA bind API with explicit
 flags
Message-ID: <20210510203145.086835cc@jacob-builder>
In-Reply-To: <20210510233749.GG1002214@nvidia.com>
References: <1620653108-44901-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1620653108-44901-2-git-send-email-jacob.jun.pan@linux.intel.com>
        <20210510233749.GG1002214@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On Mon, 10 May 2021 20:37:49 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Mon, May 10, 2021 at 06:25:07AM -0700, Jacob Pan wrote:
> 
> > +/*
> > + * The IOMMU_SVA_BIND_SUPERVISOR flag requests a PASID which can be
> > used only
> > + * for access to kernel addresses. No IOTLB flushes are automatically
> > done
> > + * for kernel mappings; it is valid only for access to the kernel's
> > static
> > + * 1:1 mapping of physical memory — not to vmalloc or even module
> > mappings.
> > + * A future API addition may permit the use of such ranges, by means
> > of an
> > + * explicit IOTLB flush call (akin to the DMA API's unmap method).
> > + *
> > + * It is unlikely that we will ever hook into flush_tlb_kernel_range()
> > to
> > + * do such IOTLB flushes automatically.
> > + */
> > +#define IOMMU_SVA_BIND_SUPERVISOR       BIT(0)  
> 
> Huh? That isn't really SVA, can you call it something saner please?
> 
This is shared kernel virtual address, I am following the SVA lib naming
since this is where the flag will be used. Why this is not SVA? Kernel
virtual address is still virtual address. Is it due to direct map?

> Is it really a PASID that always has all of physical memory mapped
> into it? Sounds dangerous. What is it for?
> 

Yes. It is to bind DMA request w/ PASID with init_mm/init_top_pgt. Per PCIe
spec PASID TLP prefix has "Privileged Mode Requested" bit. VT-d supports
this with "Privileged-mode-Requested (PR) flag (to distinguish user versus
supervisor access)". Each PASID entry has a SRE (Supervisor Request Enable)
bit.

Perhaps we should limit that to trusted device, e.g. RCIEP device?

> Jason


Thanks,

Jacob
