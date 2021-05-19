Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84B673892DD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 17:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbhESPpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 11:45:04 -0400
Received: from mga07.intel.com ([134.134.136.100]:11908 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354959AbhESPo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 11:44:59 -0400
IronPort-SDR: wSs0/kPjMkpT0b/zT50ZkadCgwBc4ZUsvxMNqbAz+rYiOz6ZFr1c/BOlkiEpq62qxDJuipnzfy
 M3yMhJl9YFaA==
X-IronPort-AV: E=McAfee;i="6200,9189,9989"; a="264923355"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="264923355"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 08:43:39 -0700
IronPort-SDR: Rq6mGhGWq0ocMcxjGSwqTjh0L6uzNef5+zlx/xUruW8mle889BFq5V15MgpXgpVzGdaiT+Qbx5
 b8/+T5xnypYQ==
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="395307475"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 08:43:39 -0700
Date:   Wed, 19 May 2021 08:46:08 -0700
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
Message-ID: <20210519084608.3d498169@jacob-builder>
In-Reply-To: <20210517143758.GP1002214@nvidia.com>
References: <20210513173303.GL1002214@nvidia.com>
        <20210513185349.GA801495@agluck-desk2.amr.corp.intel.com>
        <20210513190040.GR1002214@nvidia.com>
        <e9dd39aa8a144c23beffa5ca58936385@intel.com>
        <20210513192014.GU1002214@nvidia.com>
        <20210513124621.01421173@jacob-builder>
        <20210513195749.GA801830@agluck-desk2.amr.corp.intel.com>
        <20210513132251.0ff89b90@jacob-builder>
        <20210513223122.GV1002214@nvidia.com>
        <20210513164028.6e2d6e59@jacob-builder>
        <20210517143758.GP1002214@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On Mon, 17 May 2021 11:37:58 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Thu, May 13, 2021 at 04:40:28PM -0700, Jacob Pan wrote:
> 
> > Looks like we are converging. Let me summarize the takeaways:
> > 1. Remove IOMMU_SVA_BIND_SUPERVISOR flag from this patch, in fact there
> > will be no flags at all for iommu_sva_bind_device()
> > 2. Remove all supervisor SVA related vt-d, idxd code.
> > 3. Create API iommu_setup_system_pasid_direct_map(option_flag)
> > 	if (option_flag == 1)
> > 		iommu_domain_alloc(IOMMU_DOMAIN_DMA);
> > 	if (option_flag == 2)
> > 		iommu_domain_alloc(IOMMU_DOMAIN_DIRECT); //new domain
> > type? setup IOMMU page tables mirroring the direct map
> > 4. Create API iommu_enable_dev_direct_map(struct dev, &pasid, &option)
> > 	- Drivers call this API to get the system PASID and which
> > option is available on the system PASID
> > 	- mark device as PASID only, perhaps a new flag in struct
> > 	device->dev_iommu->pasid_only = 1
> > 5. DMA API IOMMU vendor ops will take action based on the pasid_only
> > flag to decide if the mapping is for system PASID page tables.
> > 
> > Does it make sense?  
> 
> I think you will run into trouble with that approach when you get to
> patches..
> 
> For 'option 1' what you want is an API that is 'give me a PASID that
> is equivalent to the RID'.
> 
> Then all the DMA API operations map IO page tables to both RID and
> PASID access. For the direct mode the PASID and RID will both point at
> the shared all physical memory IO page table.
> 
> Otherwise the DMA API won't care if the device is using RID or PASID,
> if it needs to map a range it does it to the shared IO page table and
> flushes both the RID and PASID based caches.
> 
> Then the driver will use the normal DMA API with its normal struct
> pci_device and simply tell the HW to do DMA TLP's with the returned
> PASID.
> 
> For 'option 2' it should be a completely different API family.
> 
Make sense, thanks for the suggestions.

> Jason


Thanks,

Jacob
