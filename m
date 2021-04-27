Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEBC836CBCB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 21:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238779AbhD0TlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 15:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238676AbhD0TlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 15:41:00 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A32C061761
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 12:40:16 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id q136so40249418qka.7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 12:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Qjlzws9tOjfG2kgF5PSaus20BHkak4AbpiykyhDCpWc=;
        b=FgJgWNr62C5ZYe5v1vnbBayAlBas9KMfjlI+laH23uWCOINrv2HqPW9/a2+lK1+qpn
         Zdr+bMJ3dVh1M82cRSTI4JbQADrXanZ5JfGjdWIrOPB62lKoHfvu6nr6Gx+k2tmRlxI9
         VnIPeqy1NjUABHuJSDWeU4As9HayrnVGiZr56daurC5uY37+XvT8TZlGM0+FK9uB/Zvv
         YTKfdf8OvZo8ENhSomjWbrDXc8AvVOdpQ72iroWjNxj+tV6CHjB8W81hADxRNQW+tUQ7
         dB77SYRDbWj7e5FkrYJA2fixQk601M0tulsmdtPUJHEnm9ZHX5SNJW5GF5Co+YjnesqM
         4DUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Qjlzws9tOjfG2kgF5PSaus20BHkak4AbpiykyhDCpWc=;
        b=IbiivVSOyxv3GgW2CA2GuhvWgP/guRIe83N5zsB7xbpV4KA298HbbUZNfgsAOg7P/s
         eHyckm0YvFIdY1CDcp14eBo2by9JnglJrznDSnKhGivVHhltuIci/CdlXAjJ4dyBZBtZ
         8kK7E5NjYBev75oKDzF0EbG/I454rgBEA2QD+ZqLu8z4zeTKz2k9/88KEJ+HruLwU/TS
         wZPVKIGXb+uig58U4GcFEBRZAtHg0LCjzXU/T52dTmI8CR+NowJdrrEkO/9t59mZi2+0
         FciVsqdtT6ROfzva70sVP9ra6w3P4lpQcBXQVogrNznIiKCLbVHp3LUqCEm3ZWGWktX+
         KitA==
X-Gm-Message-State: AOAM5300q+ou8L/DFS4yN3nf5nnCGXc9x28M5ozSLW9AjReppqQCxu+r
        hOPlCvedpUlfY0Pt8KT4Ep4dMw==
X-Google-Smtp-Source: ABdhPJzTB/kVzpwj6kXVp9NJ/SmSPf5xftMaBkmkgU98M9PRxB8v4F4XSKjG3yTN0WaJic3//dLNPQ==
X-Received: by 2002:a37:ccb:: with SMTP id 194mr7861132qkm.45.1619552415304;
        Tue, 27 Apr 2021 12:40:15 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id d3sm605486qtm.56.2021.04.27.12.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 12:40:14 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lbTZ7-00Dh3g-Sk; Tue, 27 Apr 2021 16:40:13 -0300
Date:   Tue, 27 Apr 2021 16:40:13 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jakowski Andrzej <andrzej.jakowski@intel.com>,
        Minturn Dave B <dave.b.minturn@intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Xiong Jianxin <jianxin.xiong@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 09/16] dma-direct: Support PCI P2PDMA pages in dma-direct
 map_sg
Message-ID: <20210427194013.GS2047089@ziepe.ca>
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-10-logang@deltatee.com>
 <20210427193351.GR2047089@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210427193351.GR2047089@ziepe.ca>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 04:33:51PM -0300, Jason Gunthorpe wrote:
> On Thu, Apr 08, 2021 at 11:01:16AM -0600, Logan Gunthorpe wrote:
> > Add PCI P2PDMA support for dma_direct_map_sg() so that it can map
> > PCI P2PDMA pages directly without a hack in the callers. This allows
> > for heterogeneous SGLs that contain both P2PDMA and regular pages.
> > 
> > SGL segments that contain PCI bus addresses are marked with
> > sg_mark_pci_p2pdma() and are ignored when unmapped.
> > 
> > Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> >  kernel/dma/direct.c | 25 ++++++++++++++++++++++---
> >  1 file changed, 22 insertions(+), 3 deletions(-)
> > 
> > diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> > index 002268262c9a..108dfb4ecbd5 100644
> > +++ b/kernel/dma/direct.c
> > @@ -13,6 +13,7 @@
> >  #include <linux/vmalloc.h>
> >  #include <linux/set_memory.h>
> >  #include <linux/slab.h>
> > +#include <linux/pci-p2pdma.h>
> >  #include "direct.h"
> >  
> >  /*
> > @@ -387,19 +388,37 @@ void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sgl,
> >  	struct scatterlist *sg;
> >  	int i;
> >  
> > -	for_each_sg(sgl, sg, nents, i)
> > +	for_each_sg(sgl, sg, nents, i) {
> > +		if (sg_is_pci_p2pdma(sg)) {
> > +			sg_unmark_pci_p2pdma(sg);
> 
> This doesn't seem nice, the DMA layer should only alter the DMA
> portion of the SG, not the other portions. Is it necessary?

Oh, I got it completely wrong what this is for.

This should be named sg_dma_mark_pci_p2p() and similar for other
functions to make it clear it is part of the DMA side of the SG
interface (eg it is like sg_dma_address, sg_dma_len, etc)

Jason
