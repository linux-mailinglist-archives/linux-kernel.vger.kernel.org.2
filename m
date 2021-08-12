Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91DD03EA1E3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 11:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236006AbhHLJWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 05:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236005AbhHLJWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 05:22:01 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3CFC061765
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 02:21:28 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id x12so2722966qvo.12
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 02:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SmZ+/nyBNyi7W1OAT4slsmhGWuIvjhgj8UeehGa0k/Y=;
        b=hVjYySTSr0mjWPr6vJnVDO+D69tCC702LiCJ7rDBEZ8U0jtHIsGHwHbhAUChGNDAQT
         OSReT1EQFc2WwI8Cf0k/ghW7OzOe19N/C1NkQCb0SsByX0aMrEBtVsUdHa+2KoC/+SF+
         dnayMuuUuEmRW/in/Hyw2px4iqdls/d/ae7u8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SmZ+/nyBNyi7W1OAT4slsmhGWuIvjhgj8UeehGa0k/Y=;
        b=XRRu+2sr+OYEPNpsxrOBaDHWR6XOaI0YKiigm8r3UXfQup6rtulkWeVD4S4XOIZCCX
         loa0FV4n97HADkVemnZkXI1j1erUpP9daSigomt/TqMNbvoacHyNg6siDzJMvgDN1Fly
         u5vWl6wBTX+9tZ9dyYjMCPwHfCyjdo3wZgGKSEOg/j+n0YhvP8Lus8QRi1ayAsjzrgzQ
         EFMRYuoCALgO1OX4kzAccgMoFyqDGJZ/jRTMfGe9uWQaquMZ4hw6YY0It8SRl22z/zRO
         Ah1EGqtnGUS4P2C3YzX2ouew0k9xOaDIN2vGBiVNNDNW/Xhv0//a812/fYwdv1lLxinT
         07RQ==
X-Gm-Message-State: AOAM532GwgTY3XNyBDwXuHxPaZRzue2vcG8RHIoFoWLfpDSxL8ePcGI+
        lpqi8fqUNisSZbyZquQx7KVbhgGYl3TiQHLNkP9qPg0zh4YMOA==
X-Google-Smtp-Source: ABdhPJzAD5fCBvwB9Laq4jiGcu6LVmTZWScIZ8Ggkj0igXEtHBmNYvtKbvo5AxQJ0QOBWO39LUPJr7M+FhPPk1ER2EM=
X-Received: by 2002:a05:6214:2247:: with SMTP id c7mr2902170qvc.52.1628760087852;
 Thu, 12 Aug 2021 02:21:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210811024247.1144246-1-stevensd@google.com> <20210811024247.1144246-3-stevensd@google.com>
 <5b4fd891-a86a-42cd-5b69-bc08d351dd3a@arm.com>
In-Reply-To: <5b4fd891-a86a-42cd-5b69-bc08d351dd3a@arm.com>
From:   David Stevens <stevensd@chromium.org>
Date:   Thu, 12 Aug 2021 18:21:16 +0900
Message-ID: <CAD=HUj7RLtRkKwRHOAeuJXiiLp9WujOysYAoU0s2Nx5qR1_B7g@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] dma-iommu: fix arch_sync_dma for map
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Tom Murphy <murphyt7@tcd.ie>, iommu@lists.linux-foundation.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2021 at 3:47 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2021-08-11 03:42, David Stevens wrote:
> > From: David Stevens <stevensd@chromium.org>
> >
> > When calling arch_sync_dma, we need to pass it the memory that's
> > actually being used for dma. When using swiotlb bounce buffers, this is
> > the bounce buffer. Move arch_sync_dma into the __iommu_dma_map_swiotlb
> > helper, so it can use the bounce buffer address if necessary. This also
> > means it is no longer necessary to call iommu_dma_sync_sg_for_device in
> > iommu_dma_map_sg for untrusted devices.
> >
> > Fixes: 82612d66d51d ("iommu: Allow the dma-iommu api to use bounce buffers")
> > Signed-off-by: David Stevens <stevensd@chromium.org>
> > ---
> >   drivers/iommu/dma-iommu.c | 16 +++++++---------
> >   1 file changed, 7 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> > index 54e103b989d9..4f0cc4a0a61f 100644
> > --- a/drivers/iommu/dma-iommu.c
> > +++ b/drivers/iommu/dma-iommu.c
> > @@ -576,6 +576,9 @@ static dma_addr_t __iommu_dma_map_swiotlb(struct device *dev, phys_addr_t phys,
> >               memset(padding_start, 0, padding_size);
> >       }
> >
> > +     if (!coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
>
> Make that an "else if" - otherwise you're just reintroducing the same
> thing that the third hunk is trying to clean up.

swiotlb_tbl_map_single only copies into the swiotlb buffer, it doesn't
do any architectural syncing. So this block is necessary in the
swiotlb case as well, for iommu_dma_map_page to work properly.

The third chunk is a separate optimization, so I'll split it out into
its own patch.

-David
