Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2772D37FE61
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 21:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbhEMTpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 15:45:08 -0400
Received: from mga12.intel.com ([192.55.52.136]:44989 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230135AbhEMTpH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 15:45:07 -0400
IronPort-SDR: Oe18/mxZYnLMAH7C71pVI/070wpIgrqY9eaj3ErttG9xExAHFqVzdM/l0zO+T9B1IX9DmKn6+f
 K7oZ2vvklACQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9983"; a="179631164"
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="179631164"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 12:43:55 -0700
IronPort-SDR: MYq4ex9mgKnk5EcKOTq7+8RvTud/ZpqoO3zsu1Sfq638UTdAq4NuOUXwDaYGC6ya6AliLHrbEH
 yffHAgTNFcqQ==
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="431408546"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 12:43:55 -0700
Date:   Thu, 13 May 2021 12:46:21 -0700
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
Message-ID: <20210513124621.01421173@jacob-builder>
In-Reply-To: <20210513192014.GU1002214@nvidia.com>
References: <20210511194726.GP1002214@nvidia.com>
        <YJt3tGlzFK3b4E82@infradead.org>
        <20210513060012.0fcc7653@jacob-builder>
        <20210513133834.GC1002214@nvidia.com>
        <20210513081050.5cf6a6ed@jacob-builder>
        <dd52760ab65a40328b4c1a26ddd0e1d0@intel.com>
        <20210513173303.GL1002214@nvidia.com>
        <20210513185349.GA801495@agluck-desk2.amr.corp.intel.com>
        <20210513190040.GR1002214@nvidia.com>
        <e9dd39aa8a144c23beffa5ca58936385@intel.com>
        <20210513192014.GU1002214@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On Thu, 13 May 2021 16:20:14 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Thu, May 13, 2021 at 07:14:54PM +0000, Luck, Tony wrote:
> > > If you want this then be explicit about what it is you are making when
> > > building the API. Don't try to hide it under some generic idea of
> > > "kernel PCI DMA SVA"  
> > 
> > So, a special API call (that Dave can call from IDXD) to set up this
> > kernel PASID. With suitable documentation to explain the scope.
> > Maybe with a separate CONFIG option so it can be completely
> > stubbed out (IDXD does *NOT* "select" this option ... users have
> > to explicitly pick it).
> >   
> > > I could easily see an admin option to "turn this off" entirely as
> > > being too dangerous, especially if the users have no interest in
> > > IDXD.  
> > 
> > And a kernel command line option to block IDXD from using that
> > special API ... for users on generic kernels who want to block
> > this use model (but still use IDXD in non-kernel cases). Users
> > who don't want IDXD at all can block loading of the driver.  
> 
> A generic IOMMU API should not be IDXD specific, if you want to allow
> some special "integrated to the SOC accelerator PASID" mode then it
> should be a global IOMMU API and any security toggles for it should be
> global and unrelated to IDXD.
> 
> Concurrently it seems necessary to have a solution for secure kernel
> PASID use under the DMA API and reserve this special mode for getting
> higher performance.
> 
> I think you need to come with a proposal, and it is a bit alarming a
> noteworthy security hole was added under the guise of "kernel SVA" :(
> 
It seems there are two options:
1. Add a new IOMMU API to set up a system PASID with a *separate* IOMMU page
table/domain, mark the device is PASID only with a flag. Use DMA APIs
to explicit map/unmap. Based on this PASID-only flag, Vendor IOMMU driver
will decide whether to use system PASID domain during map/unmap. Not clear
if we also need to make IOVA==kernel VA.

2. Add a new IOMMU API to setup a system PASID which points to init_mm.pgd.
This API only allows trusted device to bind with the system PASID at its
own risk. There is no need for DMA API. This is the same as the current
code except with an explicit API.

Which option?

> Jason


Thanks,

Jacob
