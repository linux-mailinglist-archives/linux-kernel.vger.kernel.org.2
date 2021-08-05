Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E10FA3E0CDA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 05:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238548AbhHEDlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 23:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbhHEDlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 23:41:06 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFCEFC061765
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 20:40:52 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id a12so2990695qtb.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 20:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yBtiUC/DqJCFyQ7ZmzGjMneaNful/xPGIES5YDgZBg0=;
        b=kihQiWwbBwUWEV5CjWsqhY6HExovObfvVrQkYJIjNnQPi1ZuACiFo6ZnS2VMCy1FTs
         /M++ELHrNNxsI0eky/SnDkGuprUiBEAUhu4fS+oGq9TBaJiPHV8FU1BSrCUSJYYbDgJe
         augwd8ykKjzAUTFUIIsV0T6bgk6mh7tiYSYdI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yBtiUC/DqJCFyQ7ZmzGjMneaNful/xPGIES5YDgZBg0=;
        b=SvGXfDgxDdHyMxN5cY9NncLu0NMpAkC1SpwetfOAZIK5iiAt508POGKbJ6/Wt26jwf
         lUT557/o/H1659NHF388iVnL1prkuZPwhm3BRcAeovYu8dSDFOpGi77IzaLRRVQQV8bg
         dYblLbEMxL0ltTeBYLDT5OIETZYR1+YkpJG3eA7teT5uAr/2UcQRtylh/zfto2nYCw65
         SQ/z4dVvyq1ihWd8ZxyeL+VY993R29PLQ8zSmls9Wbs1njU5V93UpHXTmVSOwWqXOaHf
         TOkwnOwup2X2LpGHlghwZBVX7aMx11Lm7o77EQ66AkRTragxIgSA8DAa8i/fdLdoMCtX
         XMZw==
X-Gm-Message-State: AOAM530N1JuJ5gNMaB+W5o24HdKKNWOvKFxk7booehCLwLV0FYznfbNk
        h5yT8xXlpua35hb+ZiznWesFPyYPJUV2uY0jXDGTJA==
X-Google-Smtp-Source: ABdhPJxe+N69yLZ01P7SKYrFtU+HLW34drGDN+erTrJ2h39C/3stVphQDQjtsWq75Gl0wDxTucOTk5Pd3fRtIaKwUU8=
X-Received: by 2002:a05:622a:209:: with SMTP id b9mr2775066qtx.136.1628134851882;
 Wed, 04 Aug 2021 20:40:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210709033502.3545820-1-stevensd@google.com> <20210709033502.3545820-2-stevensd@google.com>
 <20210802133037.GB28547@willie-the-truck>
In-Reply-To: <20210802133037.GB28547@willie-the-truck>
From:   David Stevens <stevensd@chromium.org>
Date:   Thu, 5 Aug 2021 12:40:40 +0900
Message-ID: <CAD=HUj6BoCZ31Dd-jeWKKbmt-jSWXiS2ZLwrFg40FFdPm0y7cA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] dma-iommu: fix sync_sg with swiotlb
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

On Mon, Aug 2, 2021 at 10:30 PM Will Deacon <will@kernel.org> wrote:
>
> On Fri, Jul 09, 2021 at 12:34:59PM +0900, David Stevens wrote:
> > From: David Stevens <stevensd@chromium.org>
> >
> > The is_swiotlb_buffer function takes the physical address of the swiotlb
> > buffer, not the physical address of the original buffer. The sglist
> > contains the physical addresses of the original buffer, so for the
> > sync_sg functions to work properly when a bounce buffer might have been
> > used, we need to use iommu_iova_to_phys to look up the physical address.
> > This is what sync_single does, so call that function on each sglist
> > segment.
> >
> > The previous code mostly worked because swiotlb does the transfer on map
> > and unmap. However, any callers which use DMA_ATTR_SKIP_CPU_SYNC with
> > sglists or which call sync_sg would not have had anything copied to the
> > bounce buffer.
> >
> > Fixes: 82612d66d51d ("iommu: Allow the dma-iommu api to use bounce buffers")
> > Signed-off-by: David Stevens <stevensd@chromium.org>
> > ---
> >  drivers/iommu/dma-iommu.c | 26 +++++++++++++-------------
> >  1 file changed, 13 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> > index 7bcdd1205535..eac65302439e 100644
> > --- a/drivers/iommu/dma-iommu.c
> > +++ b/drivers/iommu/dma-iommu.c
> > @@ -811,14 +811,14 @@ static void iommu_dma_sync_sg_for_cpu(struct device *dev,
> >       if (dev_is_dma_coherent(dev) && !dev_is_untrusted(dev))
> >               return;
> >
> > -     for_each_sg(sgl, sg, nelems, i) {
> > -             if (!dev_is_dma_coherent(dev))
> > -                     arch_sync_dma_for_cpu(sg_phys(sg), sg->length, dir);
> > -
> > -             if (is_swiotlb_buffer(sg_phys(sg)))
> > +     if (dev_is_untrusted(dev))
> > +             for_each_sg(sgl, sg, nelems, i)
> > +                     iommu_dma_sync_single_for_cpu(dev, sg_dma_address(sg),
> > +                                                   sg->length, dir);
> > +     else
> > +             for_each_sg(sgl, sg, nelems, i)
> >                       swiotlb_sync_single_for_cpu(dev, sg_phys(sg),
> >                                                   sg->length, dir);
>
> Doesn't this skip arch_sync_dma_for_cpu() for non-coherent trusted devices?

Whoops, this was supposed to be a call to arch_sync_dma_for_cpu, not
to swiotlb_sync_single_for_cpu. Similar to the sync_sg_for_device
case.

> Why not skip the extra dev_is_untrusted(dev) call here and just call
> iommu_dma_sync_single_for_cpu() for each entry regardless?

iommu_dma_sync_single_for_cpu calls iommu_iova_to_phys to translate
the dma_addr_t to a phys_addr_t. Since the physical address is readily
available, I think it's better to avoid that extra work.

> Will
