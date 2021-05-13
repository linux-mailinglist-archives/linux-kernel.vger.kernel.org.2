Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 450D837F848
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 14:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbhEMM7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 08:59:01 -0400
Received: from mga06.intel.com ([134.134.136.31]:46560 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232155AbhEMM66 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 08:58:58 -0400
IronPort-SDR: bSGhElpfifOLE5gankVJ0p/phvPDXVPaR385gprRHsU3B30POEBAEEM697rjDjBSQ0SbgY7bQm
 /v01h8J3prcg==
X-IronPort-AV: E=McAfee;i="6200,9189,9982"; a="261182169"
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="261182169"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 05:57:46 -0700
IronPort-SDR: +Ka8K3jSvMdk9JcfAqQ9xlSFFWZUb8o2IAO9JmMQkfdxsdh1yWj+ZikhEso8Y9ZUOqF/o6pWfw
 a9IAufpbsw6Q==
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="392272892"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 05:57:46 -0700
Date:   Thu, 13 May 2021 06:00:12 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Yi Liu <yi.l.liu@intel.com>, Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, wangzhou1@hisilicon.com,
        zhangfei.gao@linaro.org, vkoul@kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        jacob.jun.pan@linux.intel.com, "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [PATCH v4 1/2] iommu/sva: Tighten SVA bind API with explicit
 flags
Message-ID: <20210513060012.0fcc7653@jacob-builder>
In-Reply-To: <YJt3tGlzFK3b4E82@infradead.org>
References: <1620653108-44901-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1620653108-44901-2-git-send-email-jacob.jun.pan@linux.intel.com>
        <20210510233749.GG1002214@nvidia.com>
        <20210510203145.086835cc@jacob-builder>
        <20210511114848.GK1002214@nvidia.com>
        <20210511091452.721e9a03@jacob-builder>
        <20210511163521.GN1002214@nvidia.com>
        <20210511110550.477a434f@jacob-builder>
        <20210511194726.GP1002214@nvidia.com>
        <YJt3tGlzFK3b4E82@infradead.org>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On Wed, 12 May 2021 07:37:40 +0100, Christoph Hellwig <hch@infradead.org>
wrote:

> On Tue, May 11, 2021 at 04:47:26PM -0300, Jason Gunthorpe wrote:
> > > Let me try to break down your concerns:
> > > 1. portability - driver uses DMA APIs can function w/ and w/o IOMMU.
> > > is that your concern? But PASID is intrinsically tied with IOMMU and
> > > if the drivers are using a generic sva-lib API, why they are not
> > > portable? SVA by its definition is to avoid map/unmap every time.  
> > 
> > Kernel explicitly does not support this programming model. All DMA is
> > explicit and the DMA API hides platform details like IOMMU and CPU
> > cache coherences. Just because x86 doesn't care about this doesn't
> > make any of it optional.  
> 
> Exactly.
Perhaps we can view these SVA capable devices as FPU or a device that can
be fused onto the CPU by PASID binding. We don't require DMA map/unmap for
FPU to use kernel virtual address, right?

> 
> > If you want to do SVA PASID then it also must come with DMA APIs to
> > manage the CPU cache coherence that are all NOP's on x86.  
> 
> Yes.  And we have plenty of precende where an IOMMU is in "bypass" mode
> to allow access to all memory and then uses the simple dma-direct case.
I agree it is better not to expose the entire direct map. But the missing
piece of using DMA APIs is the PASID. The caller needs the PASID value to
do work submission once buffer is mapped.

Perhaps we can add a parameter to the DMA API to specify the address space?
As Jason suggested the definition of IOASID, which represents a page table.
Just my quick thought, can you help us with a viable solution?

I know we are supposed to hide IOMMU by using DMA APIs which makes drivers
portable w/ and w/o IOMMU. This IOASID can be optional.

Thanks,

Jacob
