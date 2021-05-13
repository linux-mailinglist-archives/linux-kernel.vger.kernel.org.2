Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 809F737FA46
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 17:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233598AbhEMPJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 11:09:39 -0400
Received: from mga18.intel.com ([134.134.136.126]:64242 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232156AbhEMPJf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 11:09:35 -0400
IronPort-SDR: 2MkuJgSUn0Vaf3qug1rS09q0Ou+mVTTeMCEK8tRbAV/TRx08MYDHnLF5uyDSFhKlOVgwwVRSbV
 7RWWhbLNBhpA==
X-IronPort-AV: E=McAfee;i="6200,9189,9982"; a="187382670"
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="187382670"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 08:08:24 -0700
IronPort-SDR: h8cnr1lRgYszrkpIKJZgTT5deHWSNW4DKLnW4hv/nIRhPifQYiZdb19NeQKFI2GUvfxErDsCe7
 cGsYelF/g5Lg==
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="409665304"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 08:08:24 -0700
Date:   Thu, 13 May 2021 08:10:50 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Yi Liu <yi.l.liu@intel.com>, Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, wangzhou1@hisilicon.com,
        zhangfei.gao@linaro.org, vkoul@kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        "Luck, Tony" <tony.luck@intel.com>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v4 1/2] iommu/sva: Tighten SVA bind API with explicit
 flags
Message-ID: <20210513081050.5cf6a6ed@jacob-builder>
In-Reply-To: <20210513133834.GC1002214@nvidia.com>
References: <1620653108-44901-2-git-send-email-jacob.jun.pan@linux.intel.com>
        <20210510233749.GG1002214@nvidia.com>
        <20210510203145.086835cc@jacob-builder>
        <20210511114848.GK1002214@nvidia.com>
        <20210511091452.721e9a03@jacob-builder>
        <20210511163521.GN1002214@nvidia.com>
        <20210511110550.477a434f@jacob-builder>
        <20210511194726.GP1002214@nvidia.com>
        <YJt3tGlzFK3b4E82@infradead.org>
        <20210513060012.0fcc7653@jacob-builder>
        <20210513133834.GC1002214@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On Thu, 13 May 2021 10:38:34 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Thu, May 13, 2021 at 06:00:12AM -0700, Jacob Pan wrote:
> > > > If you want to do SVA PASID then it also must come with DMA APIs to
> > > > manage the CPU cache coherence that are all NOP's on x86.    
> > > 
> > > Yes.  And we have plenty of precende where an IOMMU is in "bypass"
> > > mode to allow access to all memory and then uses the simple
> > > dma-direct case.  
> > I agree it is better not to expose the entire direct map. But the
> > missing piece of using DMA APIs is the PASID. The caller needs the
> > PASID value to do work submission once buffer is mapped.  
> 
> You still haven't explained why the kernel driver should have a PASID at
> all.
> 
For shared workqueue, it can only generate DMA request with PASID. The
submission is done by ENQCMDS (S for supervisor) instruction.

If we were not to share page tables with init_mm, we need a system PASID
that doing the same direct mapping in IOMMU page tables.

> Jason


Thanks,

Jacob
