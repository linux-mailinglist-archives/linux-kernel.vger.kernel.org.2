Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38A9D37AB8D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 18:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbhEKQNh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 11 May 2021 12:13:37 -0400
Received: from mga04.intel.com ([192.55.52.120]:54646 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229921AbhEKQNg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 12:13:36 -0400
IronPort-SDR: MH3VkuDoxBP2cuEePQFZZIvEwMOEUno6UvyAMapHNu+Fg2C2dd0Sq677lq1PfwmJ/B5YVNldfd
 i7w5bughUHKA==
X-IronPort-AV: E=McAfee;i="6200,9189,9981"; a="197501467"
X-IronPort-AV: E=Sophos;i="5.82,291,1613462400"; 
   d="scan'208";a="197501467"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2021 09:12:27 -0700
IronPort-SDR: WkArB/mkxVj2txW3V/uTWHVEI7jMObfp61iG6B7af54As7VEc7oHkCnrfCOd8zLBMRJRaC5+Ac
 E8Qe34nHih6w==
X-IronPort-AV: E=Sophos;i="5.82,291,1613462400"; 
   d="scan'208";a="541705233"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2021 09:12:27 -0700
Date:   Tue, 11 May 2021 09:14:52 -0700
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
        jacob.jun.pan@linux.intel.com,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH v4 1/2] iommu/sva: Tighten SVA bind API with explicit
 flags
Message-ID: <20210511091452.721e9a03@jacob-builder>
In-Reply-To: <20210511114848.GK1002214@nvidia.com>
References: <1620653108-44901-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1620653108-44901-2-git-send-email-jacob.jun.pan@linux.intel.com>
        <20210510233749.GG1002214@nvidia.com>
        <20210510203145.086835cc@jacob-builder>
        <20210511114848.GK1002214@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On Tue, 11 May 2021 08:48:48 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Mon, May 10, 2021 at 08:31:45PM -0700, Jacob Pan wrote:
> > Hi Jason,
> > 
> > On Mon, 10 May 2021 20:37:49 -0300, Jason Gunthorpe <jgg@nvidia.com>
> > wrote: 
> > > On Mon, May 10, 2021 at 06:25:07AM -0700, Jacob Pan wrote:
> > >   
> > > > +/*
> > > > + * The IOMMU_SVA_BIND_SUPERVISOR flag requests a PASID which can be
> > > > used only
> > > > + * for access to kernel addresses. No IOTLB flushes are
> > > > automatically done
> > > > + * for kernel mappings; it is valid only for access to the kernel's
> > > > static
> > > > + * 1:1 mapping of physical memory — not to vmalloc or even module
> > > > mappings.
> > > > + * A future API addition may permit the use of such ranges, by
> > > > means of an
> > > > + * explicit IOTLB flush call (akin to the DMA API's unmap method).
> > > > + *
> > > > + * It is unlikely that we will ever hook into
> > > > flush_tlb_kernel_range() to
> > > > + * do such IOTLB flushes automatically.
> > > > + */
> > > > +#define IOMMU_SVA_BIND_SUPERVISOR       BIT(0)    
> > > 
> > > Huh? That isn't really SVA, can you call it something saner please?
> > >   
> > This is shared kernel virtual address, I am following the SVA lib naming
> > since this is where the flag will be used. Why this is not SVA? Kernel
> > virtual address is still virtual address. Is it due to direct map?  
> 
> As the above explains it doesn't actually synchronize the kernel's
> address space it just shoves the direct map into the IOMMU.
> 
There is no duplicated kernel direct map in IOMMU.

> I suppose a different IOMMU implementation might point the PASID directly
> at the kernel's page table and avoid those limitations - but since
> that isn't portable it seems irrelevant.
> 
This is what we are doing here. We allocate a supervisor PASID and put
the kernel page table (init_mm pgd) in this PASID entry.

> Since the only thing it really maps is the direct map I would just
> call it direct_map, or all physical or something.
> 
Good idea. It makes things clear to the callers. They must only use direct
map memory for DMA.

> How does this interact with the DMA APIs?
DMA API would use RID2PASID (PASID 0), so it is separated by PASIDs.

> How do you get CPU cache
> flushing/etc into PASID operations that don't trigger IOMMU updates?
> 
Sorry, I am not following. This is used for direct map only.

> Honestly, I'm not convinced we should have "kernel SVA" at all.. Why
> does IDXD use normal DMA on the RID for kernel controlled accesses?
> 
Using SVA simplifies the work submission, there is no need to do map/unmap.
Just bind PASID with init_mm, then submit work directly either with ENQCMDS
(supervisor version of ENQCMD) to a shared workqueue or put the supervisor
PASID in the descriptor for dedicated workqueue.

> > > Is it really a PASID that always has all of physical memory mapped
> > > into it? Sounds dangerous. What is it for?  
> > 
> > Yes. It is to bind DMA request w/ PASID with init_mm/init_top_pgt. Per
> > PCIe spec PASID TLP prefix has "Privileged Mode Requested" bit. VT-d
> > supports this with "Privileged-mode-Requested (PR) flag (to distinguish
> > user versus supervisor access)". Each PASID entry has a SRE (Supervisor
> > Request Enable) bit.  
> 
> The PR flag is only needed if the underlying IOMMU is directly
> processing the CPU page tables. For cases where the IOMMU is using its
> own page table format and has its own copies the PR flag shouldn't be
> used.
> 
We are doing the former case. There is no IOMMU page tables for the direct
map.

> Jason


Thanks,

Jacob
