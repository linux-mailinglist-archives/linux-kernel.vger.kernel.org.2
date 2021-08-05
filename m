Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 030533E0DBE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 07:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbhHEF0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 01:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbhHEF0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 01:26:37 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED82C061765
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 22:26:22 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id g6so2361581qvj.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 22:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SAWYlvs5XtqLwUaEqS2qwqUPDupygtRRMcwg/DOIhsg=;
        b=nPobvWYZhXvZVrEvTwMU2dN2uActZpK/cmTowjhr6t4tZ/uQJTV2sYljb33SV3+52s
         RaEEuEtlXJg0GNli7EjvCKg1OdX457q6ggegb6fm0jHB0hquE0l21h7u4prEoW3YJUIZ
         +vSH8yX8Y0CNRYy1NI4biFTXdCLBLa5M10cBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SAWYlvs5XtqLwUaEqS2qwqUPDupygtRRMcwg/DOIhsg=;
        b=F6/ozJ+/qMu39WJfYBbmQaaEXRgwCODMGw/VzrwSk2dDrCy8DAx/vwnJ/WI+mCKdT6
         9lGF5Z0vryqRLQUhhyj3MoPSvsKOO3v0nE3GL6IXAXzCoyci886WyrGnHScsKK11ggpH
         WbADyDWcTobSSR6dKJjHqGLUtnDP9fDIYeZ2ne7PQM1eJ2qL9F8OFqPoaFgfspbTdAHi
         0ikS1L6pESf1t0jSsyf3zxO5CcbjlAxUJ+GGzUPGBY/x2KPpnAdDKk0Un3XBPsDUcAqi
         K2jcV0Tl+e2BnMWHzrr0v2CdRSlefp2yoW4H6lPmR4s0CKU9tTRD1dlqHyxpm3akcQAA
         J8aQ==
X-Gm-Message-State: AOAM530OvCH2laa+T5cRWhhpE3xlP3TXu4HLSLjUqmcl793to7ntjlNy
        S7BzzYI4oDEzvtkiowogJ+ExL9Tcpx32V1rGrP4rIw==
X-Google-Smtp-Source: ABdhPJwliKWoxLiTKjhaiCktAIkaJ/XWbOQ6RdbyHxj8/NjoJYsYviXy+qLt7OPWwt6dfpKxWyMiB9EhxZZyd+mymtc=
X-Received: by 2002:a05:6214:e4e:: with SMTP id o14mr3391377qvc.55.1628141181770;
 Wed, 04 Aug 2021 22:26:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210709033502.3545820-1-stevensd@google.com> <20210709033502.3545820-4-stevensd@google.com>
 <20210802135446.GE28547@willie-the-truck>
In-Reply-To: <20210802135446.GE28547@willie-the-truck>
From:   David Stevens <stevensd@chromium.org>
Date:   Thu, 5 Aug 2021 14:26:10 +0900
Message-ID: <CAD=HUj4+62dYZTWfbPjh8eLRY6FQak8nBS8OD85t0xk_+JvDpA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] dma-iommu: pass SKIP_CPU_SYNC to swiotlb unmap
To:     Will Deacon <will@kernel.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Tom Murphy <murphyt7@tcd.ie>, iommu@lists.linux-foundation.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 2, 2021 at 10:54 PM Will Deacon <will@kernel.org> wrote:
>
> On Fri, Jul 09, 2021 at 12:35:01PM +0900, David Stevens wrote:
> > From: David Stevens <stevensd@chromium.org>
> >
> > If SKIP_CPU_SYNC isn't already set, then iommu_dma_unmap_(page|sg) has
> > already called iommu_dma_sync_(single|sg)_for_cpu, so there is no need
> > to copy from the bounce buffer again.
> >
> > Signed-off-by: David Stevens <stevensd@chromium.org>
> > ---
> >  drivers/iommu/dma-iommu.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> > index e79e274d2dc5..0a9a9a343e64 100644
> > --- a/drivers/iommu/dma-iommu.c
> > +++ b/drivers/iommu/dma-iommu.c
> > @@ -505,7 +505,8 @@ static void __iommu_dma_unmap_swiotlb(struct device *dev, dma_addr_t dma_addr,
> >       __iommu_dma_unmap(dev, dma_addr, size);
> >
> >       if (unlikely(is_swiotlb_buffer(phys)))
> > -             swiotlb_tbl_unmap_single(dev, phys, size, dir, attrs);
> > +             swiotlb_tbl_unmap_single(dev, phys, size, dir,
> > +                                      attrs | DMA_ATTR_SKIP_CPU_SYNC);
> >  }
>
> I think it would be cleaner to drop DMA_ATTR_SKIP_CPU_SYNC in the callers
> once they've called iommu_dma_sync_*_for_cpu().

Dropping that flag in iommu_dma_unmap_* would result in always copying
from the swiotlb here, which is the opposite direction of what this
patch is trying to do.

This change is aiming to address the case where DMA_ATTR_SKIP_CPU_SYNC
isn't passed to dma_unmap_*. In that case, there are calls to
swiotlb_sync_single_for_cpu from iommu_dma_sync_*_for_cpu, and calls
to swiotlb_tlb_unmap_single here. That means we copy from the swiotlb
twice. Adding the DMA_ATTR_SKIP_CPU_SYNC flag here skips the second
copy.

-David

> Will
