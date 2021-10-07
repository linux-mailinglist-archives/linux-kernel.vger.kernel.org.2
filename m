Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA5C4259B8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 19:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242884AbhJGRsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 13:48:21 -0400
Received: from mga05.intel.com ([192.55.52.43]:5527 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241071AbhJGRsU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 13:48:20 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10130"; a="312514366"
X-IronPort-AV: E=Sophos;i="5.85,355,1624345200"; 
   d="scan'208";a="312514366"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2021 10:46:26 -0700
X-IronPort-AV: E=Sophos;i="5.85,355,1624345200"; 
   d="scan'208";a="478659965"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2021 10:46:25 -0700
Date:   Thu, 7 Oct 2021 10:50:10 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Barry Song <21cnbao@gmail.com>, iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Tony Luck <tony.luck@intel.com>, mike.campin@intel.com,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, jacob.jun.pan@linux.intel.com
Subject: Re: [RFC 0/7] Support in-kernel DMA with PASID and SVA
Message-ID: <20211007105010.33d706cf@jacob-builder>
In-Reply-To: <20211007115918.GH2744544@nvidia.com>
References: <1632256181-36071-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <CAGsJ_4z=2y2nVStXP-aAPnQrJJbMmv78mjaMwNc9P9Ec+gCtGw@mail.gmail.com>
        <20211001123623.GM964074@nvidia.com>
        <CAGsJ_4wfkrJp-eFKiXsLdiZCb3eS_zqZtJvXQTBafoTWY2yWKQ@mail.gmail.com>
        <20211004094003.527222e5@jacob-builder>
        <20211004182142.GM964074@nvidia.com>
        <CAGsJ_4w+ed78cnJusM_enEZpdGghzvjgt0aYDPpfwk4z7PQqxQ@mail.gmail.com>
        <20211007113221.GF2744544@nvidia.com>
        <CAGsJ_4x2UEmNXCVhJAVRyB8568VMrTkOLeVCNp8CyP6xZJwCig@mail.gmail.com>
        <20211007115918.GH2744544@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On Thu, 7 Oct 2021 08:59:18 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Fri, Oct 08, 2021 at 12:54:52AM +1300, Barry Song wrote:
> > On Fri, Oct 8, 2021 at 12:32 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >  
> > >
> > > On Thu, Oct 07, 2021 at 06:43:33PM +1300, Barry Song wrote:
> > >  
> > > > So do we have a case where devices can directly access the kernel's
> > > > data structure such as a list/graph/tree with pointers to a kernel
> > > > virtual address? then devices don't need to translate the address
> > > > of pointers in a structure. I assume this is one of the most useful
> > > > features userspace SVA can provide.  
> > >
> > > AFIACT that is the only good case for KVA, but it is also completely
> > > against the endianess, word size and DMA portability design of the
> > > kernel.
> > >
> > > Going there requires some new set of portable APIs for gobally
> > > coherent KVA dma.  
> > 
> > yep. I agree. it would be very weird if accelerators/gpu are sharing
> > kernel' data struct, but for each "DMA" operation - reading or writing
> > the data struct, we have to call dma_map_single/sg or
> > dma_sync_single_for_cpu/device etc. It seems once devices and cpus
> > are sharing virtual address(SVA), code doesn't need to do explicit
> > map/sync each time.  
> 
That is what we have today with sva_bind_device.
> No, it still need to do something to manage visibility from the
> current CPU to the DMA - it might not be flushing a cache, but it is
> probably a arch specific CPU barrier instruction.
> 
Are you talking about iommu_dma_sync_single_for_cpu(), this is not SVA
specific, right?

On platforms that are DMA snooped, this barrier is not needed. But I think
your point is that once we convert to DMA API, the sync/barrier is covered
by DMA APIs if !dev_is_dma_coherent(dev). Then all archs are good.

We could also add a check for dev_is_dma_coherent(dev) before using SVA.

> Jason


Thanks,

Jacob
