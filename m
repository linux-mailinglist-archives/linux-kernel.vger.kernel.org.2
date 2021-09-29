Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9301141CF86
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 00:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346602AbhI2WzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 18:55:24 -0400
Received: from mga14.intel.com ([192.55.52.115]:55656 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344976AbhI2WzX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 18:55:23 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10122"; a="224714675"
X-IronPort-AV: E=Sophos;i="5.85,334,1624345200"; 
   d="scan'208";a="224714675"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2021 15:53:40 -0700
X-IronPort-AV: E=Sophos;i="5.85,334,1624345200"; 
   d="scan'208";a="588270949"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2021 15:53:40 -0700
Date:   Wed, 29 Sep 2021 15:57:20 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        mike.campin@intel.com, Thomas Gleixner <tglx@linutronix.de>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [RFC 0/7] Support in-kernel DMA with PASID and SVA
Message-ID: <20210929155720.794b6e65@jacob-builder>
In-Reply-To: <20210929193953.GX964074@nvidia.com>
References: <1632256181-36071-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <20210929123437.721991dc@jacob-builder>
        <20210929193953.GX964074@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On Wed, 29 Sep 2021 16:39:53 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Wed, Sep 29, 2021 at 12:37:19PM -0700, Jacob Pan wrote:
>  
> > For #2, it seems we can store the kernel PASID in struct device. This
> > will preserve the DMA API interface while making it PASID capable.
> > Essentially, each PASID capable device would have two special global
> > PASIDs: 
> > 	- PASID 0 for DMA request w/o PASID, aka RID2PASID
> > 	- PASID 1 (randomly selected) for in-kernel DMA request w/
> > PASID  
> 
> This seems reasonable, I had the same thought. Basically just have the
> driver issue some trivial call:
>   pci_enable_pasid_dma(pdev, &pasid)
That would work, but I guess it needs to be an iommu_ call instead of pci_?

Or, it can be done by the platform IOMMU code where system PASID is
automatically enabled for PASID capable devices during boot and stored in
struct device. Device drivers can retrieve the PASID from struct device.

I think your suggestion is more precise, in case the driver does not want
to do DMA w/ PASID, we can do less IOTLB flush (PASID 0 only).

> And then DMA tagged with the PASID will be handled equivilant to
> untagged DMA. Basically PASID and no PASID point to the exact same IO
> page table and the DMA API manipulates that single page table.
> 
> Having multiple RID's pointing at the same IO page table is something
> we expect iommufd to require so the whole thing should ideally fall
> out naturally.
That would be the equivalent of attaching multiple devices to the same
IOMMU domain. right?

> Jason


Thanks,

Jacob
