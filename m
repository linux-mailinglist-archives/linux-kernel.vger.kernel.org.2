Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 512103800F0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 01:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbhEMXjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 19:39:15 -0400
Received: from mga05.intel.com ([192.55.52.43]:7286 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230230AbhEMXjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 19:39:13 -0400
IronPort-SDR: 2YkOzYHz9Cqk9R8JUmje4f42+hbByX3/KJtOwl2+71O8GkCNYlnoy61RDA6at3lYMWQXctfDOj
 8VYMmDvCXy9A==
X-IronPort-AV: E=McAfee;i="6200,9189,9983"; a="285592759"
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="285592759"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 16:38:02 -0700
IronPort-SDR: LSmIhSZ/iJ19HTFkyX5tBW+4f5BeEKik1AweyzWqWzo8Zjwf1GY38yktThsKCjhW+YTcFICCZA
 6tvEi3QdOioA==
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="392484089"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 16:38:02 -0700
Date:   Thu, 13 May 2021 16:40:28 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
        "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v4 1/2] iommu/sva: Tighten SVA bind API with explicit
 flags
Message-ID: <20210513164028.6e2d6e59@jacob-builder>
In-Reply-To: <20210513223122.GV1002214@nvidia.com>
References: <20210513081050.5cf6a6ed@jacob-builder>
        <dd52760ab65a40328b4c1a26ddd0e1d0@intel.com>
        <20210513173303.GL1002214@nvidia.com>
        <20210513185349.GA801495@agluck-desk2.amr.corp.intel.com>
        <20210513190040.GR1002214@nvidia.com>
        <e9dd39aa8a144c23beffa5ca58936385@intel.com>
        <20210513192014.GU1002214@nvidia.com>
        <20210513124621.01421173@jacob-builder>
        <20210513195749.GA801830@agluck-desk2.amr.corp.intel.com>
        <20210513132251.0ff89b90@jacob-builder>
        <20210513223122.GV1002214@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On Thu, 13 May 2021 19:31:22 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Thu, May 13, 2021 at 01:22:51PM -0700, Jacob Pan wrote:
> > Hi Tony,
> > 
> > On Thu, 13 May 2021 12:57:49 -0700, "Luck, Tony" <tony.luck@intel.com>
> > wrote:
> >   
> > > On Thu, May 13, 2021 at 12:46:21PM -0700, Jacob Pan wrote:  
> > > > It seems there are two options:
> > > > 1. Add a new IOMMU API to set up a system PASID with a *separate*
> > > > IOMMU page table/domain, mark the device is PASID only with a flag.
> > > > Use DMA APIs to explicit map/unmap. Based on this PASID-only flag,
> > > > Vendor IOMMU driver will decide whether to use system PASID domain
> > > > during map/unmap. Not clear if we also need to make IOVA==kernel VA.
> > > > 
> > > > 2. Add a new IOMMU API to setup a system PASID which points to
> > > > init_mm.pgd. This API only allows trusted device to bind with the
> > > > system PASID at its own risk. There is no need for DMA API. This is
> > > > the same as the current code except with an explicit API.
> > > > 
> > > > Which option?    
> > > 
> > > Option #1 looks cleaner to me. Option #2 gives access to bits
> > > of memory that the users of system PASID shouldn't ever need
> > > to touch ... just map regions of memory that the kernel has
> > > a "struct page" for.
> > > 
> > > What does "use DMA APIs to explicitly map/unmap" mean? Is that
> > > for the whole region?
> > >   
> > If we map the entire kernel direct map during system PASID setup, then
> > we don't need to use DMA API to map/unmap certain range.
> > 
> > I was thinking this system PASID page table could be on-demand. The
> > mapping is built by explicit use of DMA map/unmap APIs.  
> 
> Option 1 should be the PASID works exactly like a normal RID and uses
> all the normal DMA APIs and IOMMU mechanisms, whatever the platform
> implements. This might mean an iommu update on every operation or not.
>  
> > > I'm expecting that once this system PASID has been initialized,
> > > then any accelerator device with a kernel use case would use the
> > > same PASID. I.e. DSA for page clearing, IAX for ZSwap compression
> > > & decompression, etc.
> > >   
> > OK, sounds like we have to map the entire kernel VA with struct page as
> > you said. So we still by-pass DMA APIs, can we all agree on that?  
> 
> Option 2 should be the faster option, but not available in all cases.
> 
> Option 1 isn't optional. DMA and IOMMU code has to be portable and
> this is the portable API.
> 
> If you want to do option 1 and option 2 then give it a go, but in most
> common cases with the IOMMU in a direct map you shouldn't get a
> notable performance win.
> 
Looks like we are converging. Let me summarize the takeaways:
1. Remove IOMMU_SVA_BIND_SUPERVISOR flag from this patch, in fact there
will be no flags at all for iommu_sva_bind_device()
2. Remove all supervisor SVA related vt-d, idxd code.
3. Create API iommu_setup_system_pasid_direct_map(option_flag)
	if (option_flag == 1)
		iommu_domain_alloc(IOMMU_DOMAIN_DMA);
	if (option_flag == 2)
		iommu_domain_alloc(IOMMU_DOMAIN_DIRECT); //new domain type?
		setup IOMMU page tables mirroring the direct map
4. Create API iommu_enable_dev_direct_map(struct dev, &pasid, &option)
	- Drivers call this API to get the system PASID and which option is
	available on the system PASID
	- mark device as PASID only, perhaps a new flag in struct
	device->dev_iommu->pasid_only = 1
5. DMA API IOMMU vendor ops will take action based on the pasid_only flag to
decide if the mapping is for system PASID page tables.

Does it make sense?


> Jason


Thanks,

Jacob
