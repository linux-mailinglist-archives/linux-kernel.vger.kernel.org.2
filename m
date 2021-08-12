Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51A5C3E9C07
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 03:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233385AbhHLBqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 21:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbhHLBqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 21:46:02 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF5CC061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 18:45:38 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id e14so4769961qkg.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 18:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sVlaR7t/R94hd0zmYZq3g+CzewEHmfZEE8FNG6b25iA=;
        b=nTPBIgSR1+DYRuTz126NpJG3MGlML74YM1Le2P962yisyrtzCnff17kwv/c5kyI7i5
         k83aktakoC1RDga4lJ6tpulebc9ZSC51LDDl2Zq3S3sHSaqssdBI/jblrsHMO7MDGXNF
         /nSk5dmIM+FwBtSIrNcRk0EI7SZSD1NCSYxz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sVlaR7t/R94hd0zmYZq3g+CzewEHmfZEE8FNG6b25iA=;
        b=Pu3I0VOv0+ufHebkpcQoBlmAbQ5SpCEvyphgzAWESizuweWoW0TGbeWWVKFoA/aTvJ
         ib8O5M7QOHlN8g32qVfj+5ZxvNNSttrrj677i7Zm3aO0dGPpo3Glm/Uu6kFOSvXjDt+d
         18gmQw+nCfEPAjDMh7V2I/1MMoxImWm1gcbkRmWeJIyrc3qZAM4/Oq8cJFPu6eRmnMMl
         CNUnKGnS663BwWmQ4TRYEgTsjYF2AyPjUFdXth6WU0tcnbPrPGcoqLsAB/jOaiML85uF
         E7fv6rDxs7PZfG7oLgM8vSzR+qgTo/+aaRlz0NDLVFrxDizfbt+ygyI7qYIy+C7jc7B4
         EYpw==
X-Gm-Message-State: AOAM532WcOA37c3sTpHfccv/md7ANzuImAjvX7IXXv5EO9mTs1R2YFt5
        zF67Ma+GPPJFj2ulOMwzuukBInptP7jjzve0bNdjPg==
X-Google-Smtp-Source: ABdhPJwC6Y9w83pWVs6KCrJupE+hkSFvjIO2mfTRLAyBQ2KctEfzgqHFI5pSOZvgZ0DFQfcOgMhPzyLR0BQnU31+3lE=
X-Received: by 2002:a37:8505:: with SMTP id h5mr2116592qkd.241.1628732737520;
 Wed, 11 Aug 2021 18:45:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210811024247.1144246-1-stevensd@google.com> <20210811024247.1144246-6-stevensd@google.com>
 <b5fff839-3242-7080-13f7-61c0e40af304@arm.com>
In-Reply-To: <b5fff839-3242-7080-13f7-61c0e40af304@arm.com>
From:   David Stevens <stevensd@chromium.org>
Date:   Thu, 12 Aug 2021 10:45:26 +0900
Message-ID: <CAD=HUj7u71cdPfJ5t2tC8A26YOgwDe8H7i-h78f_MeRmuNUySQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] dma-iommu: account for min_align_mask
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Tom Murphy <murphyt7@tcd.ie>, iommu@lists.linux-foundation.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2021 at 4:12 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2021-08-11 03:42, David Stevens wrote:
> > From: David Stevens <stevensd@chromium.org>
> >
> > For devices which set min_align_mask, swiotlb preserves the offset of
> > the original physical address within that mask. Since __iommu_dma_map
> > accounts for non-aligned addresses, passing a non-aligned swiotlb
> > address with the swiotlb aligned size results in the offset being
> > accounted for twice in the size passed to iommu_map_atomic. The extra
> > page exposed to DMA is also not cleaned up by __iommu_dma_unmap, since
> > tht at function unmaps with the correct size. This causes mapping failures
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
> >   drivers/iommu/dma-iommu.c | 23 ++++++++++++-----------
> >   1 file changed, 12 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> > index 89b689bf801f..ffa7e8ef5db4 100644
> > --- a/drivers/iommu/dma-iommu.c
> > +++ b/drivers/iommu/dma-iommu.c
> > @@ -549,9 +549,8 @@ static dma_addr_t __iommu_dma_map_swiotlb(struct device *dev, phys_addr_t phys,
> >       struct iommu_domain *domain = iommu_get_dma_domain(dev);
> >       struct iommu_dma_cookie *cookie = domain->iova_cookie;
> >       struct iova_domain *iovad = &cookie->iovad;
> > -     size_t aligned_size = org_size;
> > -     void *padding_start;
> > -     size_t padding_size;
> > +     void *tlb_start;
> > +     size_t aligned_size, iova_off, mapping_end_off;
> >       dma_addr_t iova;
> >
> >       /*
> > @@ -566,24 +565,26 @@ static dma_addr_t __iommu_dma_map_swiotlb(struct device *dev, phys_addr_t phys,
> >               if (phys == DMA_MAPPING_ERROR)
> >                       return DMA_MAPPING_ERROR;
> >
> > -             /* Cleanup the padding area. */
> > -             padding_start = phys_to_virt(phys);
> > -             padding_size = aligned_size;
> > +             iova_off = iova_offset(iovad, phys);
> > +             tlb_start = phys_to_virt(phys - iova_off);
> >
> > +             /* Cleanup the padding area. */
> >               if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
> >                   (dir == DMA_TO_DEVICE ||
> >                    dir == DMA_BIDIRECTIONAL)) {
> > -                     padding_start += org_size;
> > -                     padding_size -= org_size;
> > +                     mapping_end_off = iova_off + org_size;
> > +                     memset(tlb_start, 0, iova_off);
> > +                     memset(tlb_start + mapping_end_off, 0,
> > +                            aligned_size - mapping_end_off);
> > +             } else {
> > +                     memset(tlb_start, 0, aligned_size);
> >               }
> > -
> > -             memset(padding_start, 0, padding_size);
> >       }
> >
> >       if (!coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
> >               arch_sync_dma_for_device(phys, org_size, dir);
> >
> > -     iova = __iommu_dma_map(dev, phys, aligned_size, prot, dma_mask);
> > +     iova = __iommu_dma_map(dev, phys, org_size, prot, dma_mask);
>
> This doesn't feel right - what if the IOVA granule was equal to or
> smaller than min_align_mask, wouldn't you potentially end up mapping the
> padding rather than the data?

The phys value returned by swiotlb_tbl_map_single is the address of
the start of the data in the swiotlb buffer, so the range that needs
to be mapped is [phys, phys + org_size). __iommu_dma_map will handle
this the same as it handles a misaligned mapping in the non-swiotlb
case. It might map memory before/after the desired range, but it will
map the entire range and iova will be the mapped address of phys. Is
there something I'm missing there?

That said, considering that memory before phys might be mapped, I
think there is actually still a bug. The buffer allocated by swiotlb
needs to be aligned to the granule size to ensure that preceding
swiotlb slots aren't mapped. The swiotlb does align allocations larger
than a page to PAGE_SIZE, but if IO_TLB_SIZE < IOVA granule <
PAGE_SIZE, then there can be problems. That can't happen if PAGE_SIZE
is 4k, but it can for larger page sizes. I'll add a fix for that to
the next version of this series.

-David

> Robin.
>
> >       if (iova == DMA_MAPPING_ERROR && is_swiotlb_buffer(phys))
> >               swiotlb_tbl_unmap_single(dev, phys, org_size, dir, attrs);
> >       return iova;
> >
