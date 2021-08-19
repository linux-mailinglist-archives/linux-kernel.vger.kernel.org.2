Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26C5B3F170B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 12:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238009AbhHSKFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 06:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237788AbhHSKFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 06:05:52 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0BCC061575
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 03:05:15 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id l24so4103930qtj.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 03:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X3zlPWDyphvVlbQ5qW3mRYO0Onpjp0vHlmpsTSdQ76U=;
        b=Qt/ngTdhvfqfEUTB6oXvy1Tg6d89U6mWp/wKxapl/JcsNUitJUvR9DiI/l+/T/95ZW
         EKkvzDOz4tBamAa3OCDgmTjd5MJAbewUELKSWH1Lyd8S7LDb3T/0AvrxUcFxsjnPLy5K
         /4T96yV6fiQUHdNuKhQ/VwbgjjTLth6uXACDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X3zlPWDyphvVlbQ5qW3mRYO0Onpjp0vHlmpsTSdQ76U=;
        b=Py2crQZrgMk/EZUP3xbHVD5UKw9qsVdhEdlZec0WL+udNFxcsI+OaV1yg5eLsTYguF
         twgyC6GxKUUKjFe2dlCZOktV/uEOvoH8eDbu6hP8TuXZ/uy1sDC2dLETmIqMe2u2iRh+
         Rgmuk+OWNwexFfY2sa0ZzLOI3uzyMjaUJhyxZRoxGSBUbum++5CF65jU+1o1qz8pe/iU
         R4m0O3+yBpIkN6OhMg6jEh0ZqbpZalNMvdRF+EseEb8WZbunIstnLsyGP+ad33RVBCgh
         MinUOONm++dPJ/YYlZG3muWt0G1LO2rzEF4/eGwjcLWgAVnjqDXevnOUhnfgBCB7eVke
         Y+UA==
X-Gm-Message-State: AOAM532XMRgJJh4PfOAz3NMFMBnwKp6ACQqixGxmDg2g2TVSt6hArbPV
        l9sjNTOIzlNc17DtgluteDFXFQZ+5kbUgwyZKgdMVQ==
X-Google-Smtp-Source: ABdhPJzCdJjP1MwbH7hH0bJZ9B1Z5mWBm8tscwzL3/O2b/V30LA1px2FIzqx7BzQ1O2BI0NboeA0Mz6aGA4pJydjQ34=
X-Received: by 2002:ac8:7183:: with SMTP id w3mr8137304qto.116.1629367515209;
 Thu, 19 Aug 2021 03:05:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210817013852.3222824-1-stevensd@google.com> <20210817013852.3222824-8-stevensd@google.com>
 <f64b1349-d271-7b57-0eea-276dda065a87@arm.com>
In-Reply-To: <f64b1349-d271-7b57-0eea-276dda065a87@arm.com>
From:   David Stevens <stevensd@chromium.org>
Date:   Thu, 19 Aug 2021 19:05:04 +0900
Message-ID: <CAD=HUj6pRdiprRNc_wH_vLBMaNKZvQG9mhFa29vOD4WfcAo4=g@mail.gmail.com>
Subject: Re: [PATCH v6 7/7] dma-iommu: account for min_align_mask
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Tom Murphy <murphyt7@tcd.ie>, iommu@lists.linux-foundation.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  On Thu, Aug 19, 2021 at 6:03 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2021-08-17 02:38, David Stevens wrote:
> > From: David Stevens <stevensd@chromium.org>
> >
> > For devices which set min_align_mask, swiotlb preserves the offset of
> > the original physical address within that mask. Since __iommu_dma_map
> > accounts for non-aligned addresses, passing a non-aligned swiotlb
> > address with the swiotlb aligned size results in the offset being
> > accounted for twice in the size passed to iommu_map_atomic. The extra
> > page exposed to DMA is also not cleaned up by __iommu_dma_unmap, since
> > that function unmaps with the correct size. This causes mapping failures
> > if the iova gets reused, due to collisions in the iommu page tables.
> >
> > To fix this, pass the original size to __iommu_dma_map, since that
> > function already handles alignment.
> >
> > Additionally, when swiotlb returns non-aligned addresses, there is
> > padding at the start of the bounce buffer that needs to be cleared.
> >
> > Fixes: 1f221a0d0dbf ("swiotlb: respect min_align_mask")
> > Signed-off-by: David Stevens <stevensd@chromium.org>
> > ---
> >   drivers/iommu/dma-iommu.c | 24 +++++++++++++-----------
> >   1 file changed, 13 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> > index 6738420fc081..f2fb360c2907 100644
> > --- a/drivers/iommu/dma-iommu.c
> > +++ b/drivers/iommu/dma-iommu.c
> > @@ -788,7 +788,6 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
> >       struct iommu_domain *domain = iommu_get_dma_domain(dev);
> >       struct iommu_dma_cookie *cookie = domain->iova_cookie;
> >       struct iova_domain *iovad = &cookie->iovad;
> > -     size_t aligned_size = size;
> >       dma_addr_t iova, dma_mask = dma_get_mask(dev);
> >
> >       /*
> > @@ -796,8 +795,8 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
> >        * page aligned, we don't need to use a bounce page.
> >        */
> >       if (dev_use_swiotlb(dev) && iova_offset(iovad, phys | size)) {
> > -             void *padding_start;
> > -             size_t padding_size;
> > +             void *tlb_start;
> > +             size_t aligned_size, iova_off, mapping_end_off;
> >
> >               aligned_size = iova_align(iovad, size);
> >               phys = swiotlb_tbl_map_single(dev, phys, size, aligned_size,
> > @@ -806,23 +805,26 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
> >               if (phys == DMA_MAPPING_ERROR)
> >                       return DMA_MAPPING_ERROR;
> >
> > -             /* Cleanup the padding area. */
> > -             padding_start = phys_to_virt(phys);
> > -             padding_size = aligned_size;
> > +             iova_off = iova_offset(iovad, phys);
> > +             tlb_start = phys_to_virt(phys - iova_off);
> >
> >               if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
> >                   (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL)) {
> > -                     padding_start += size;
> > -                     padding_size -= size;
> > +                     /* Cleanup the padding area. */
> > +                     mapping_end_off = iova_off + size;
> > +                     memset(tlb_start, 0, iova_off);
> > +                     memset(tlb_start + mapping_end_off, 0,
> > +                            aligned_size - mapping_end_off);
> > +             } else {
> > +                     /* Nothing was sync'ed, so clear the whole buffer. */
> > +                     memset(tlb_start, 0, aligned_size);
> >               }
> > -
> > -             memset(padding_start, 0, padding_size);
> >       }
> >
> >       if (!coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
> >               arch_sync_dma_for_device(phys, size, dir);
> >
> > -     iova = __iommu_dma_map(dev, phys, aligned_size, prot, dma_mask);
> > +     iova = __iommu_dma_map(dev, phys, size, prot, dma_mask);
>
> I still don't see how this preserves min_align_mask if it is larger than
> the IOVA granule

That's a slightly different issue, and not addressed in this series. I
guess the commit message should be 'dma-iommu: account for
min_align_mask w/swiotlb'. At least from my understanding of
min_align_mask, getting min_align_mask larger than the IOVA granule to
work would require changes to IOVA allocation, not anything to do
directly with swiotlb bounce buffers. Also, probably changes to
scatterlist coalescing. That being said, it looks like the only driver
that sets min_align_mask is the nvme driver, which sets it to 4096.

> (either way this change here does nothing since the
> first thing __iommu_dma_map() does is iova_align() the size right back
> anyway).
>

__iommu_dma_map() doesn't just align the size, it aligns
size+iova_off. Let's say you're doing a read of size 512 bytes at
offset 2048 within a page. In this case, aligned_size will be 4096.
Without min_align_mask, phys will be page aligned, so that's fine. But
with min_align_mask=4096, phys will also be at offset 2048. This
causes __iommu_dma_map to align 4096 + 2048, which becomes 8192. That
results in an extra page being mapped, which then doesn't get cleaned
up by __iommu_dma_unmap. That causes collisions in the IOMMU driver
the next time the iova is reused.

Passing size to __iommu_dma_map is sufficient. iommu_dma_map_page
needs to map [phys, phys+size), regardless of whether or not bounce
buffers are being used. __iommu_dma_map already takes care of cleaning
up the alignment, there's no need to do any extra alignment specific
to the bounce buffer case.

-David

> Robin.
>
> >       if (iova == DMA_MAPPING_ERROR && is_swiotlb_buffer(phys))
> >               swiotlb_tbl_unmap_single(dev, phys, size, dir, attrs);
> >       return iova;
> >
