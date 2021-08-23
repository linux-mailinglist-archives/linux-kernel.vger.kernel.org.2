Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABDFC3F509A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 20:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbhHWSqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 14:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbhHWSqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 14:46:01 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C54C061575;
        Mon, 23 Aug 2021 11:45:19 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id x9-20020a056830278900b0051b8be1192fso18244305otu.7;
        Mon, 23 Aug 2021 11:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Su7i+pg4CPOi3J6AfRlZUAB8GpQBJfAZDJfBcoAOY+M=;
        b=jsUrk1I+wnzAAh78tQ5ihhocBHkO57rZtmLB4NGq5XmKybU9l8ioe9/c3zQq5np/uZ
         Q4DELa29H/ApiacvJwa01oSDtLYJyT8IMsY2PRZbSayIkk9/N/LkXvWWldP/TTtaenlG
         hFQidzAlG0Wnirycltmh9EghyyCnh2ylwtYFxWC+QN6keHMRqSx1F+R1I5kyV74PnLYz
         m02nMA5V/px0SSmd60r9ywydxDRBH3qpfyN0TEsU8xVbpjS1r2nHftA2O/xpq54rOTW4
         rRP68S9TSpFtSKVZJG9z+FNPeITiF4du+/i98l27ld/jlfHj0EEw3T8Q9qleA6CVL/S3
         VsDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Su7i+pg4CPOi3J6AfRlZUAB8GpQBJfAZDJfBcoAOY+M=;
        b=X5h9u0zj4vCp2rgSidQWNAlUJwOYEoyc7lzNdmaz6Z3N6/8ONdwiBL1SCcIYePl0cI
         uqNxUoBBKA6+mdb5XSdvMFTqpLLrRU6l4o0FiIMHFAa8pZi2arH4T6RhArIxZxuFRqql
         no6FQq1frTMia4APbP1HkcMxr3Y0HWIV/etC6WhEsr6D6tAZXTD+bBzDNv/hkX1o+Y1p
         bXuL+PNxcHQgg/pBAAQP0IGCGfVgOzSHWev+95gKWYf1dysbL0HPE5wvrX1Ti0DqksK7
         ztBT/keG+J0IAUZvwSSdJYuJPyOLvkEImv733uGUb6/0w8eruiwqM6WsYl6aNM0EjfdN
         Fy2A==
X-Gm-Message-State: AOAM533UeR61ML4UWYOIimt+170TZMTJLKqKbBI3PZoGGTF0t5jh3QC0
        OEfATKTVhozcYMVO/qSDUwkvrcq1Ptly6+3w/9o=
X-Google-Smtp-Source: ABdhPJyIfwWabERUH9VE9kASFzrWv4Ku92yHtP9ybXRUU1SltP+Y0MOsN7DlKDJpXhNOiiSBsPN05O0dn3FqYjJbp3g=
X-Received: by 2002:a9d:4c15:: with SMTP id l21mr15752808otf.311.1629744318478;
 Mon, 23 Aug 2021 11:45:18 -0700 (PDT)
MIME-Version: 1.0
References: <46ccdd7bffdba1273a1ebb3d6cd2fbe186e0795a.1629667572.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <46ccdd7bffdba1273a1ebb3d6cd2fbe186e0795a.1629667572.git.christophe.jaillet@wanadoo.fr>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 23 Aug 2021 14:45:07 -0400
Message-ID: <CADnq5_PYZpwoneV=JvEiTp53U2vT0+Vk=ggKt=srYPSU5PE0SQ@mail.gmail.com>
Subject: Re: [PATCH] drm/r128: switch from 'pci_' to 'dma_' API
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Dave Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 22, 2021 at 5:34 PM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> The wrappers in include/linux/pci-dma-compat.h should go away.
>
> The patch has been generated with the coccinelle script below.
>
> It has been compile tested.
>
> @@
> @@
> -    PCI_DMA_BIDIRECTIONAL
> +    DMA_BIDIRECTIONAL
>
> @@
> @@
> -    PCI_DMA_TODEVICE
> +    DMA_TO_DEVICE
>
> @@
> @@
> -    PCI_DMA_FROMDEVICE
> +    DMA_FROM_DEVICE
>
> @@
> @@
> -    PCI_DMA_NONE
> +    DMA_NONE
>
> @@
> expression e1, e2, e3;
> @@
> -    pci_alloc_consistent(e1, e2, e3)
> +    dma_alloc_coherent(&e1->dev, e2, e3, GFP_)
>
> @@
> expression e1, e2, e3;
> @@
> -    pci_zalloc_consistent(e1, e2, e3)
> +    dma_alloc_coherent(&e1->dev, e2, e3, GFP_)
>
> @@
> expression e1, e2, e3, e4;
> @@
> -    pci_free_consistent(e1, e2, e3, e4)
> +    dma_free_coherent(&e1->dev, e2, e3, e4)
>
> @@
> expression e1, e2, e3, e4;
> @@
> -    pci_map_single(e1, e2, e3, e4)
> +    dma_map_single(&e1->dev, e2, e3, e4)
>
> @@
> expression e1, e2, e3, e4;
> @@
> -    pci_unmap_single(e1, e2, e3, e4)
> +    dma_unmap_single(&e1->dev, e2, e3, e4)
>
> @@
> expression e1, e2, e3, e4, e5;
> @@
> -    pci_map_page(e1, e2, e3, e4, e5)
> +    dma_map_page(&e1->dev, e2, e3, e4, e5)
>
> @@
> expression e1, e2, e3, e4;
> @@
> -    pci_unmap_page(e1, e2, e3, e4)
> +    dma_unmap_page(&e1->dev, e2, e3, e4)
>
> @@
> expression e1, e2, e3, e4;
> @@
> -    pci_map_sg(e1, e2, e3, e4)
> +    dma_map_sg(&e1->dev, e2, e3, e4)
>
> @@
> expression e1, e2, e3, e4;
> @@
> -    pci_unmap_sg(e1, e2, e3, e4)
> +    dma_unmap_sg(&e1->dev, e2, e3, e4)
>
> @@
> expression e1, e2, e3, e4;
> @@
> -    pci_dma_sync_single_for_cpu(e1, e2, e3, e4)
> +    dma_sync_single_for_cpu(&e1->dev, e2, e3, e4)
>
> @@
> expression e1, e2, e3, e4;
> @@
> -    pci_dma_sync_single_for_device(e1, e2, e3, e4)
> +    dma_sync_single_for_device(&e1->dev, e2, e3, e4)
>
> @@
> expression e1, e2, e3, e4;
> @@
> -    pci_dma_sync_sg_for_cpu(e1, e2, e3, e4)
> +    dma_sync_sg_for_cpu(&e1->dev, e2, e3, e4)
>
> @@
> expression e1, e2, e3, e4;
> @@
> -    pci_dma_sync_sg_for_device(e1, e2, e3, e4)
> +    dma_sync_sg_for_device(&e1->dev, e2, e3, e4)
>
> @@
> expression e1, e2;
> @@
> -    pci_dma_mapping_error(e1, e2)
> +    dma_mapping_error(&e1->dev, e2)
>
> @@
> expression e1, e2;
> @@
> -    pci_set_dma_mask(e1, e2)
> +    dma_set_mask(&e1->dev, e2)
>
> @@
> expression e1, e2;
> @@
> -    pci_set_consistent_dma_mask(e1, e2)
> +    dma_set_coherent_mask(&e1->dev, e2)
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

And applied to drm-misc-next.

Alex


> ---
> If needed, see post from Christoph Hellwig on the kernel-janitors ML:
>    https://marc.info/?l=kernel-janitors&m=158745678307186&w=4
> ---
>  drivers/gpu/drm/r128/ati_pcigart.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/r128/ati_pcigart.c b/drivers/gpu/drm/r128/ati_pcigart.c
> index 0ecccf25a3c7..26001c2de9e9 100644
> --- a/drivers/gpu/drm/r128/ati_pcigart.c
> +++ b/drivers/gpu/drm/r128/ati_pcigart.c
> @@ -99,7 +99,8 @@ int drm_ati_pcigart_cleanup(struct drm_device *dev, struct drm_ati_pcigart_info
>                 for (i = 0; i < pages; i++) {
>                         if (!entry->busaddr[i])
>                                 break;
> -                       pci_unmap_page(pdev, entry->busaddr[i], PAGE_SIZE, PCI_DMA_BIDIRECTIONAL);
> +                       dma_unmap_page(&pdev->dev, entry->busaddr[i],
> +                                      PAGE_SIZE, DMA_BIDIRECTIONAL);
>                 }
>
>                 if (gart_info->gart_table_location == DRM_ATI_GART_MAIN)
> @@ -134,7 +135,7 @@ int drm_ati_pcigart_init(struct drm_device *dev, struct drm_ati_pcigart_info *ga
>         if (gart_info->gart_table_location == DRM_ATI_GART_MAIN) {
>                 DRM_DEBUG("PCI: no table in VRAM: using normal RAM\n");
>
> -               if (pci_set_dma_mask(pdev, gart_info->table_mask)) {
> +               if (dma_set_mask(&pdev->dev, gart_info->table_mask)) {
>                         DRM_ERROR("fail to set dma mask to 0x%Lx\n",
>                                   (unsigned long long)gart_info->table_mask);
>                         ret = -EFAULT;
> @@ -173,9 +174,9 @@ int drm_ati_pcigart_init(struct drm_device *dev, struct drm_ati_pcigart_info *ga
>         gart_idx = 0;
>         for (i = 0; i < pages; i++) {
>                 /* we need to support large memory configurations */
> -               entry->busaddr[i] = pci_map_page(pdev, entry->pagelist[i],
> -                                                0, PAGE_SIZE, PCI_DMA_BIDIRECTIONAL);
> -               if (pci_dma_mapping_error(pdev, entry->busaddr[i])) {
> +               entry->busaddr[i] = dma_map_page(&pdev->dev, entry->pagelist[i],
> +                                                0, PAGE_SIZE, DMA_BIDIRECTIONAL);
> +               if (dma_mapping_error(&pdev->dev, entry->busaddr[i])) {
>                         DRM_ERROR("unable to map PCIGART pages!\n");
>                         drm_ati_pcigart_cleanup(dev, gart_info);
>                         address = NULL;
> --
> 2.30.2
>
