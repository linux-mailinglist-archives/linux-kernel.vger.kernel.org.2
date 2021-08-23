Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF6593F4FF2
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 19:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbhHWRyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 13:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbhHWRyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 13:54:32 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3384C061575;
        Mon, 23 Aug 2021 10:53:49 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id c19-20020a9d6153000000b0051829acbfc7so38489274otk.9;
        Mon, 23 Aug 2021 10:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZQomryc6rUW/QpCZz/zN784OOX3FK9mSd+n7gkdCcUg=;
        b=GYZKfIhnP/AUtsvBuwr4kKzf4C0u22P7lBumXF8aw3bfjh5Z8ibPee+tK0DTd/i+tH
         Xzfn5AlKUEl9UKolkHjDra8eUNQDqsVRmV7pU0JCEBYkRMuHt680TczIex1v+gNYWaAW
         8FqMh/nNhzVl3y5pb9I4rV0VuRwRUUi7whivD9A4IjFQmuSWyUMByO0fJU8cBnbIkVL1
         Fmesa9dGHwq8j7lIpcehH/9s7AqtoIhpRCJvuGjM1Nduw5KIm/jg4cqjFGQGKPaTliE6
         BmBVlT5zW7csd0eoAP7y3PY0pIO1Lf616U3OyGHekNFENFLvxQj2u/yjVBc8Es3p/Hm5
         5rHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZQomryc6rUW/QpCZz/zN784OOX3FK9mSd+n7gkdCcUg=;
        b=f/mdWmfP4k8lX/eIicmrfL3OgTiCJz53XyGcnSesfaZUMtqMFF9T8k2VNDp2gSb/+U
         t6ghtZUm+TuilmQqIXigqEEAdzbgU/lYbHrxxs0I9aGd/eYcmxyFqyx7DuXaY6hzl3iL
         mvgMm0VdqMK4iB37mmu9dVwGwiNtfBuOBcDXqbuYO1yITegT0+kIADzUfSlqKLNM0EBE
         /dzF3zgX7+clj6tkT4/yGbKPANNEMlWFvPG77w2y422B1cQJDXtwyIwoloWjFxj/mVki
         h1hxscIXUrOi4eBlhI7qwHj30XF0nVuTdXfi2jPfZrNKQNRJnZcyaAznALWePYvkBuIT
         s1mA==
X-Gm-Message-State: AOAM531udwyiOvyxDMtg9Hrco+xA0zZUCfiNgwH6Fqjjv3Ey0foh4pkJ
        pNaU8G94v0lSVZaUr7ZGLeN2jogLdjKGnrvXKy4=
X-Google-Smtp-Source: ABdhPJwujOOZljA91OYN5H6dukXF63lJ2O87nAd49AlEjNXKsEKPf59CWweVy6tO5kbpZma/LC108skbsGrZelu1rDI=
X-Received: by 2002:a9d:4c15:: with SMTP id l21mr15572911otf.311.1629741229119;
 Mon, 23 Aug 2021 10:53:49 -0700 (PDT)
MIME-Version: 1.0
References: <1187ca1dbaa74ca4a87db9496061243e9a810faa.1629667363.git.christophe.jaillet@wanadoo.fr>
 <cd7b5eb2-24c1-d54d-d6dd-c529d3eb140f@amd.com>
In-Reply-To: <cd7b5eb2-24c1-d54d-d6dd-c529d3eb140f@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 23 Aug 2021 13:53:38 -0400
Message-ID: <CADnq5_NU=DKqiHURbB70No94wi-qz7YbwA11_18DbCXPfxWzLQ@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: switch from 'pci_' to 'dma_' API
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Mon, Aug 23, 2021 at 2:17 AM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 22.08.21 um 23:23 schrieb Christophe JAILLET:
> > The wrappers in include/linux/pci-dma-compat.h should go away.
> >
> > The patch has been generated with the coccinelle script below.
> >
> > It has been compile tested.
> >
> > @@
> > @@
> > -    PCI_DMA_BIDIRECTIONAL
> > +    DMA_BIDIRECTIONAL
> >
> > @@
> > @@
> > -    PCI_DMA_TODEVICE
> > +    DMA_TO_DEVICE
> >
> > @@
> > @@
> > -    PCI_DMA_FROMDEVICE
> > +    DMA_FROM_DEVICE
> >
> > @@
> > @@
> > -    PCI_DMA_NONE
> > +    DMA_NONE
> >
> > @@
> > expression e1, e2, e3;
> > @@
> > -    pci_alloc_consistent(e1, e2, e3)
> > +    dma_alloc_coherent(&e1->dev, e2, e3, GFP_)
> >
> > @@
> > expression e1, e2, e3;
> > @@
> > -    pci_zalloc_consistent(e1, e2, e3)
> > +    dma_alloc_coherent(&e1->dev, e2, e3, GFP_)
> >
> > @@
> > expression e1, e2, e3, e4;
> > @@
> > -    pci_free_consistent(e1, e2, e3, e4)
> > +    dma_free_coherent(&e1->dev, e2, e3, e4)
> >
> > @@
> > expression e1, e2, e3, e4;
> > @@
> > -    pci_map_single(e1, e2, e3, e4)
> > +    dma_map_single(&e1->dev, e2, e3, e4)
> >
> > @@
> > expression e1, e2, e3, e4;
> > @@
> > -    pci_unmap_single(e1, e2, e3, e4)
> > +    dma_unmap_single(&e1->dev, e2, e3, e4)
> >
> > @@
> > expression e1, e2, e3, e4, e5;
> > @@
> > -    pci_map_page(e1, e2, e3, e4, e5)
> > +    dma_map_page(&e1->dev, e2, e3, e4, e5)
> >
> > @@
> > expression e1, e2, e3, e4;
> > @@
> > -    pci_unmap_page(e1, e2, e3, e4)
> > +    dma_unmap_page(&e1->dev, e2, e3, e4)
> >
> > @@
> > expression e1, e2, e3, e4;
> > @@
> > -    pci_map_sg(e1, e2, e3, e4)
> > +    dma_map_sg(&e1->dev, e2, e3, e4)
> >
> > @@
> > expression e1, e2, e3, e4;
> > @@
> > -    pci_unmap_sg(e1, e2, e3, e4)
> > +    dma_unmap_sg(&e1->dev, e2, e3, e4)
> >
> > @@
> > expression e1, e2, e3, e4;
> > @@
> > -    pci_dma_sync_single_for_cpu(e1, e2, e3, e4)
> > +    dma_sync_single_for_cpu(&e1->dev, e2, e3, e4)
> >
> > @@
> > expression e1, e2, e3, e4;
> > @@
> > -    pci_dma_sync_single_for_device(e1, e2, e3, e4)
> > +    dma_sync_single_for_device(&e1->dev, e2, e3, e4)
> >
> > @@
> > expression e1, e2, e3, e4;
> > @@
> > -    pci_dma_sync_sg_for_cpu(e1, e2, e3, e4)
> > +    dma_sync_sg_for_cpu(&e1->dev, e2, e3, e4)
> >
> > @@
> > expression e1, e2, e3, e4;
> > @@
> > -    pci_dma_sync_sg_for_device(e1, e2, e3, e4)
> > +    dma_sync_sg_for_device(&e1->dev, e2, e3, e4)
> >
> > @@
> > expression e1, e2;
> > @@
> > -    pci_dma_mapping_error(e1, e2)
> > +    dma_mapping_error(&e1->dev, e2)
> >
> > @@
> > expression e1, e2;
> > @@
> > -    pci_set_dma_mask(e1, e2)
> > +    dma_set_mask(&e1->dev, e2)
> >
> > @@
> > expression e1, e2;
> > @@
> > -    pci_set_consistent_dma_mask(e1, e2)
> > +    dma_set_coherent_mask(&e1->dev, e2)
> >
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> Should we pick them up or do you want to push them upstream?
>
> Regards,
> Christian.
>
> > ---
> > If needed, see post from Christoph Hellwig on the kernel-janitors ML:
> >     https://marc.info/?l=3Dkernel-janitors&m=3D158745678307186&w=3D4
> > ---
> >   drivers/gpu/drm/radeon/radeon_device.c | 6 +++---
> >   1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/radeon/radeon_device.c b/drivers/gpu/drm/r=
adeon/radeon_device.c
> > index ac8c3251b616..4f0fbf667431 100644
> > --- a/drivers/gpu/drm/radeon/radeon_device.c
> > +++ b/drivers/gpu/drm/radeon/radeon_device.c
> > @@ -785,7 +785,7 @@ int radeon_dummy_page_init(struct radeon_device *rd=
ev)
> >       if (rdev->dummy_page.page =3D=3D NULL)
> >               return -ENOMEM;
> >       rdev->dummy_page.addr =3D dma_map_page(&rdev->pdev->dev, rdev->du=
mmy_page.page,
> > -                                     0, PAGE_SIZE, PCI_DMA_BIDIRECTION=
AL);
> > +                                     0, PAGE_SIZE, DMA_BIDIRECTIONAL);
> >       if (dma_mapping_error(&rdev->pdev->dev, rdev->dummy_page.addr)) {
> >               dev_err(&rdev->pdev->dev, "Failed to DMA MAP the dummy pa=
ge\n");
> >               __free_page(rdev->dummy_page.page);
> > @@ -808,8 +808,8 @@ void radeon_dummy_page_fini(struct radeon_device *r=
dev)
> >   {
> >       if (rdev->dummy_page.page =3D=3D NULL)
> >               return;
> > -     pci_unmap_page(rdev->pdev, rdev->dummy_page.addr,
> > -                     PAGE_SIZE, PCI_DMA_BIDIRECTIONAL);
> > +     dma_unmap_page(&rdev->pdev->dev, rdev->dummy_page.addr, PAGE_SIZE=
,
> > +                    DMA_BIDIRECTIONAL);
> >       __free_page(rdev->dummy_page.page);
> >       rdev->dummy_page.page =3D NULL;
> >   }
>
