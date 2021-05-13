Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C76F37FDA2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 20:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbhEMSzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 14:55:05 -0400
Received: from mga18.intel.com ([134.134.136.126]:21422 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230366AbhEMSzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 14:55:03 -0400
IronPort-SDR: bdavYTQgf/Zo8bNZMMVUMwO7biC10MI8sBpElUx0snHgnn5TIOOKRkrV/Xs9rpAlGWM9WzdQa2
 DNoXCjIwpRgA==
X-IronPort-AV: E=McAfee;i="6200,9189,9983"; a="187438245"
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="187438245"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 11:53:51 -0700
IronPort-SDR: 9Up57c0CDb2ZmIMevyH92mTBnr53E6sGPaiKBteRDKCDfWtXeUgBwaGMn3vmPUXfWWGWYM4yMA
 Ije96e4uOsyg==
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="626346317"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.146])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 11:53:50 -0700
Date:   Thu, 13 May 2021 11:53:49 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
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
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH v4 1/2] iommu/sva: Tighten SVA bind API with explicit
 flags
Message-ID: <20210513185349.GA801495@agluck-desk2.amr.corp.intel.com>
References: <20210511091452.721e9a03@jacob-builder>
 <20210511163521.GN1002214@nvidia.com>
 <20210511110550.477a434f@jacob-builder>
 <20210511194726.GP1002214@nvidia.com>
 <YJt3tGlzFK3b4E82@infradead.org>
 <20210513060012.0fcc7653@jacob-builder>
 <20210513133834.GC1002214@nvidia.com>
 <20210513081050.5cf6a6ed@jacob-builder>
 <dd52760ab65a40328b4c1a26ddd0e1d0@intel.com>
 <20210513173303.GL1002214@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210513173303.GL1002214@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2021 at 02:33:03PM -0300, Jason Gunthorpe wrote:
> The page table under the kernel PASID should behave the same way that
> the kernel would operate the page table assigned to a kernel RID.
> 
> If the kernel has security off then the PASID should map to all
> physical memory, just like the RID does.
> 
> If security is on then every DMA map needs to be loaded into the
> PASID's io page table no different than a RID page table.
> 
> "kernel SVA" is, IMHO, not a desirable thing, it completely destroys
> the kernel's DMA security model.
> 
> > If people want to use an accelerator on memory allocated by vmalloc()
> > things will get more complicated. But maybe we can delay solving that
> > problem until someone comes up with a real use case that needs to
> > do this?
> 
> If you have a HW limitation that the device can only issue TLPs
> with a PASID, even for kernel users, then I think the proper thing is
> to tell the IOMMU layer than a certain 'struct device' enters
> PASID-only mode and the IOMMU layer should construct an appropriate
> PASID and flow the dma operations through it.
> 
> Pretending the DMA layer doesn't exist and that PASID gets a free pass
> is not OK in the kernel.

I can see why a tight security model is needed to stop
random devices having access to mamory that they should
not be able to access.  Now that PCIe devices can be plugged
into Thunderbolt ports on computers, nobody wants to repeat
the disaster that Firewire ports created for systems over
a decade ago.

But I'd like to challege the one-size-fits-all policy. There's
a big difference between a random device plugged into a port
(which may even lie about its VendorID/DeviceID) and a device
that is part of the CPU socket.

I'd like people to think of DSA as an extension to the instruction
set. It implements asynchronous instructions like "MEMFILL" and
"MEMCOPY". These can be limited in scope when executed in user
processes or guests. But when executed by the host OS ring0 code
they can have all the same access that ring0 code has when it
dereferences a pointer.

-Tony
