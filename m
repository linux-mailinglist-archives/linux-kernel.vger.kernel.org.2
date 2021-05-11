Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5E1A37ADAD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 20:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbhEKSEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 14:04:40 -0400
Received: from mga05.intel.com ([192.55.52.43]:45780 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231986AbhEKSEe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 14:04:34 -0400
IronPort-SDR: sfmUPHTs5/oLzavXjLv9Ek2zEdHBnuywOZoV5VW/6dkiMdWDMJLvrvuqLdLKSuYbw+6nXZirH0
 MXbvFvrMiI5Q==
X-IronPort-AV: E=McAfee;i="6200,9189,9981"; a="285003719"
X-IronPort-AV: E=Sophos;i="5.82,291,1613462400"; 
   d="scan'208";a="285003719"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2021 11:03:25 -0700
IronPort-SDR: igI2hkMwhTJNky0TneHIeis9ZrKM8EdQlPu6AwIr9M00XUdSZvHFazf4kP/W4pKIyGlBPfy9kc
 v0A5mF9aN18w==
X-IronPort-AV: E=Sophos;i="5.82,291,1613462400"; 
   d="scan'208";a="436779964"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2021 11:03:25 -0700
Date:   Tue, 11 May 2021 11:05:50 -0700
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
        David Woodhouse <dwmw2@infradead.org>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v4 1/2] iommu/sva: Tighten SVA bind API with explicit
 flags
Message-ID: <20210511110550.477a434f@jacob-builder>
In-Reply-To: <20210511163521.GN1002214@nvidia.com>
References: <1620653108-44901-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1620653108-44901-2-git-send-email-jacob.jun.pan@linux.intel.com>
        <20210510233749.GG1002214@nvidia.com>
        <20210510203145.086835cc@jacob-builder>
        <20210511114848.GK1002214@nvidia.com>
        <20210511091452.721e9a03@jacob-builder>
        <20210511163521.GN1002214@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On Tue, 11 May 2021 13:35:21 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Tue, May 11, 2021 at 09:14:52AM -0700, Jacob Pan wrote:
> 
> > > Honestly, I'm not convinced we should have "kernel SVA" at all.. Why
> > > does IDXD use normal DMA on the RID for kernel controlled accesses?  
> > 
> > Using SVA simplifies the work submission, there is no need to do
> > map/unmap. Just bind PASID with init_mm, then submit work directly
> > either with ENQCMDS (supervisor version of ENQCMD) to a shared
> > workqueue or put the supervisor PASID in the descriptor for dedicated
> > workqueue.  
> 
> That is not OK, protable drivers in Linux have to sue dma map/unmap
> calls to manage cache coherence. PASID does not opt out of any of
> that.
> 
Let me try to break down your concerns:
1. portability - driver uses DMA APIs can function w/ and w/o IOMMU. is
that your concern? But PASID is intrinsically tied with IOMMU and if
the drivers are using a generic sva-lib API, why they are not portable?
SVA by its definition is to avoid map/unmap every time.

2. cache coherence - as you suggested if we name the flag "direct_map",
there is no mapping change, then there is no need for mmu_notifier like tlb
flush calls, right? it is caller's responsibility to make sure vmalloc are
not used.

> I dislike this whole idea a lot. A single driver should not opt itself
> out of IOMMU based security "just because"
> 
Perhaps I missed your point here. This is NOT a single driver, privileged
access is a PCIe spec defined feature. We are using IOMMU sva-lib APIs, not
sure why it is by-passing.

Perhaps we should add check for struct pci_dev->untrusted && rciep to
address security?

> Jason


Thanks,

Jacob
