Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD4D241DD30
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 17:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245234AbhI3PTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 11:19:25 -0400
Received: from mga09.intel.com ([134.134.136.24]:11227 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245339AbhI3PTY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 11:19:24 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10123"; a="225250609"
X-IronPort-AV: E=Sophos;i="5.85,336,1624345200"; 
   d="scan'208";a="225250609"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2021 08:17:41 -0700
X-IronPort-AV: E=Sophos;i="5.85,336,1624345200"; 
   d="scan'208";a="487364233"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2021 08:17:41 -0700
Date:   Thu, 30 Sep 2021 08:21:21 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     "Campin, Mike" <mike.campin@intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [RFC 0/7] Support in-kernel DMA with PASID and SVA
Message-ID: <20210930082121.444299be@jacob-builder>
In-Reply-To: <CO1PR11MB5153C703BC0E0112CE7F65B2F3AA9@CO1PR11MB5153.namprd11.prod.outlook.com>
References: <1632256181-36071-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <20210929123437.721991dc@jacob-builder>
        <20210929193953.GX964074@nvidia.com>
        <20210929155720.794b6e65@jacob-builder>
        <20210929234301.GC964074@nvidia.com>
        <CO1PR11MB5153C703BC0E0112CE7F65B2F3AA9@CO1PR11MB5153.namprd11.prod.outlook.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On Thu, 30 Sep 2021 14:22:34 +0000, "Campin, Mike" <mike.campin@intel.com>
wrote:

> I need support for mixed user PASID, kernel PASID and non-PASID use cases
> in the driver.
> 
This specific RFC is for kernel PASID only. User PASID native use is
supported under SVA lib kernel API and /dev/uacce UAPI or driver specific
char dev. Guest PASID is being developed under the new /dev/iommu framework.
Non-PASID kernel use should be under DMA API unchanged from the driver's
POV. In fact, this proposal will map non-PASID and PASID DMA identically.

Thanks,

Jacob

> -----Original Message-----
> From: Jason Gunthorpe <jgg@nvidia.com> 
> Sent: Wednesday, September 29, 2021 4:43 PM
> To: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: iommu@lists.linux-foundation.org; LKML
> <linux-kernel@vger.kernel.org>; Joerg Roedel <joro@8bytes.org>; Christoph
> Hellwig <hch@infradead.org>; Tian, Kevin <kevin.tian@intel.com>; Luck,
> Tony <tony.luck@intel.com>; Jiang, Dave <dave.jiang@intel.com>; Raj,
> Ashok <ashok.raj@intel.com>; Kumar, Sanjay K <sanjay.k.kumar@intel.com>;
> Campin, Mike <mike.campin@intel.com>; Thomas Gleixner
> <tglx@linutronix.de> Subject: Re: [RFC 0/7] Support in-kernel DMA with
> PASID and SVA
> 
> On Wed, Sep 29, 2021 at 03:57:20PM -0700, Jacob Pan wrote:
> > Hi Jason,
> > 
> > On Wed, 29 Sep 2021 16:39:53 -0300, Jason Gunthorpe <jgg@nvidia.com>
> > wrote: 
> > > On Wed, Sep 29, 2021 at 12:37:19PM -0700, Jacob Pan wrote:
> > >    
> > > > For #2, it seems we can store the kernel PASID in struct device. 
> > > > This will preserve the DMA API interface while making it PASID
> > > > capable. Essentially, each PASID capable device would have two
> > > > special global
> > > > PASIDs: 
> > > > 	- PASID 0 for DMA request w/o PASID, aka RID2PASID
> > > > 	- PASID 1 (randomly selected) for in-kernel DMA request w/
> > > > PASID  
> > > 
> > > This seems reasonable, I had the same thought. Basically just have 
> > > the driver issue some trivial call:
> > >   pci_enable_pasid_dma(pdev, &pasid)  
> > That would work, but I guess it needs to be an iommu_ call instead of
> > pci_?  
> 
> Which ever makes sense..  The API should take in a struct pci_device and
> return a PCI PASID - at least as a wrapper around a more generic immu api.
> 
> > I think your suggestion is more precise, in case the driver does not 
> > want to do DMA w/ PASID, we can do less IOTLB flush (PASID 0 only).  
> 
> Since it is odd, and it may create overhead, I would do it only when
> asked to do it
> 
> > > Having multiple RID's pointing at the same IO page table is 
> > > something we expect iommufd to require so the whole thing should 
> > > ideally fall out naturally.  
> 
> > That would be the equivalent of attaching multiple devices to the same 
> > IOMMU domain. right?  
> 
> Effectively..
> 
> Jason


Thanks,

Jacob
