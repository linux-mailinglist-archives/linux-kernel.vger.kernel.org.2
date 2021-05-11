Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5CB379FB7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 08:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbhEKGhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 02:37:08 -0400
Received: from verein.lst.de ([213.95.11.211]:35236 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229807AbhEKGhH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 02:37:07 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8C47567373; Tue, 11 May 2021 08:35:58 +0200 (CEST)
Date:   Tue, 11 May 2021 08:35:58 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Stefano Stabellini <sstabellini@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Julien Grall <julien@xen.org>,
        f.fainelli@gmail.com,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        linux-kernel@vger.kernel.org,
        osstest service owner <osstest-admin@xenproject.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        iommu@lists.linux-foundation.org
Subject: Re: Regression when booting 5.15 as dom0 on arm64 (WAS: Re:
 [linux-linus test] 161829: regressions - FAIL)
Message-ID: <20210511063558.GA7605@lst.de>
References: <osstest-161829-mainreport@xen.org> <4ea1e89f-a7a0-7664-470c-b3cf773a1031@xen.org> <20210510084057.GA933@lst.de> <alpine.DEB.2.21.2105101818260.5018@sstabellini-ThinkPad-T480s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2105101818260.5018@sstabellini-ThinkPad-T480s>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 06:46:34PM -0700, Stefano Stabellini wrote:
> On Mon, 10 May 2021, Christoph Hellwig wrote:
> > On Sat, May 08, 2021 at 12:32:37AM +0100, Julien Grall wrote:
> > > The pointer dereferenced seems to suggest that the swiotlb hasn't been 
> > > allocated. From what I can tell, this may be because swiotlb_force is set 
> > > to SWIOTLB_NO_FORCE, we will still enable the swiotlb when running on top 
> > > of Xen.
> > >
> > > I am not entirely sure what would be the correct fix. Any opinions?
> > 
> > Can you try something like the patch below (not even compile tested, but
> > the intent should be obvious?
> > 
> > 
> > diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> > index 16a2b2b1c54d..7671bc153fb1 100644
> > --- a/arch/arm64/mm/init.c
> > +++ b/arch/arm64/mm/init.c
> > @@ -44,6 +44,8 @@
> >  #include <asm/tlb.h>
> >  #include <asm/alternative.h>
> >  
> > +#include <xen/arm/swiotlb-xen.h>
> > +
> >  /*
> >   * We need to be able to catch inadvertent references to memstart_addr
> >   * that occur (potentially in generic code) before arm64_memblock_init()
> > @@ -482,7 +484,7 @@ void __init mem_init(void)
> >  	if (swiotlb_force == SWIOTLB_FORCE ||
> >  	    max_pfn > PFN_DOWN(arm64_dma_phys_limit))
> >  		swiotlb_init(1);
> > -	else
> > +	else if (!IS_ENABLED(CONFIG_XEN) || !xen_swiotlb_detect())
> >  		swiotlb_force = SWIOTLB_NO_FORCE;
> >  
> >  	set_max_mapnr(max_pfn - PHYS_PFN_OFFSET);
> 
> The "IS_ENABLED(CONFIG_XEN)" is not needed as the check is already part
> of xen_swiotlb_detect().

As far as I can tell the x86 version of xen_swiotlb_detect has a
!CONFIG_XEN stub.  The arm/arm64 version in uncoditionally declared, but
the implementation only compiled when Xen support is enabled.

> 
> 
> But let me ask another question first. Do you think it makes sense to have:
> 
> 	if (swiotlb_force == SWIOTLB_NO_FORCE)
> 		return 0;
> 
> at the beginning of swiotlb_late_init_with_tbl? I am asking because
> swiotlb_late_init_with_tbl is meant for special late initializations,
> right? It shouldn't really matter the presence or absence of
> SWIOTLB_NO_FORCE in regards to swiotlb_late_init_with_tbl. Also the
> commit message for "swiotlb: Make SWIOTLB_NO_FORCE perform no
> allocation" says that "If a platform was somehow setting
> swiotlb_no_force and a later call to swiotlb_init() was to be made we
> would still be proceeding with allocating the default SWIOTLB size
> (64MB)." Our case here is very similar, right? So the allocation should
> proceed?

Well, right now SWIOTLB_NO_FORCE is checked in dma_direct_map_page.
We need to clean all this up a bit, especially with the work to support
multiple swiotlb buffers, but I think for now this is the best we can
do.

> Which brings me to a separate unrelated issue, still affecting the path
> xen_swiotlb_init -> swiotlb_late_init_with_tbl. If swiotlb_init(1) is
> called by mem_init then swiotlb_late_init_with_tbl will fail due to the
> check:
> 
>     /* protect against double initialization */
>     if (WARN_ON_ONCE(io_tlb_default_mem))
>         return -ENOMEM;
> 
> xen_swiotlb_init is meant to ask Xen to make a bunch of pages physically
> contiguous. Then, it initializes the swiotlb buffer based on those
> pages. So it is a problem that swiotlb_late_init_with_tbl refuses to
> continue. However, in practice it is not a problem today because on ARM
> we don't actually make any special requests to Xen to make the pages
> physically contiguous (yet). See the empty implementation of
> arch/arm/xen/mm.c:xen_create_contiguous_region. I don't know about x86.
> 
> So maybe we should instead do something like the appended?

So I'd like to change the core swiotlb initialization to just use
a callback into the arch/xen code to make the pages contigous and
kill all that code duplication.  Together with the multiple swiotlb
buffer work I'd rather avoid churn that goes into a different direction
if possible.
