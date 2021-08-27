Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 181E93FA0A9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 22:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbhH0Uhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 16:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbhH0Uhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 16:37:47 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97CF4C0613D9;
        Fri, 27 Aug 2021 13:36:57 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id p15so13571242ljn.3;
        Fri, 27 Aug 2021 13:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uvuYXAVCQEZqw1nKK2OO3GZfBdchkFmag0EOn0maiaU=;
        b=vB4jlwlUCB5pzinOcnNinVlhvUqZ4vmDRTEJte3hLxEZcAkdehuu7kWPCRAWlWBvkr
         yA094g6mGJC4/CS1jC0jyPJavfA7xh0eHUyYrTs06d93rbZahMA2vH3GBCSjXks8v6O2
         SCgTiS1lDNUu9/zNNujgs85SU+bcFlQyGCOuIlp3JQGPQ1i4aeCdxGvReaWzhRqTOJp3
         V9FTmzsh6Q+fBkLhpzM6+5/QpWeKbYEQmw21yPTWsjrsBldEq4QnNeoJ1fTEG/rXCoCy
         cHtUK0nXi9YtjUZ8wW20bYgV51maUHU8n4t7kxpsr8ahxPG7lJYgTPm/4FvTbR30KvuZ
         yuTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uvuYXAVCQEZqw1nKK2OO3GZfBdchkFmag0EOn0maiaU=;
        b=LpI5BtGt/KENqcN68FMg/RY+lWPZ1KEQ7hZmjYtPD5TaYtYKmyOEqz6W/BRDsuMfue
         mnAwttOlkHyoEPT9Prp+/fFdCCUwb/x6nHC5gBefADKJU9rF9Z8N+TSRP5f6h+E04F9s
         UaHeRPiIwYuKuvcdqur5Yt7/3uKu91SiuDetz4DsHSdl6yhHeQR6hqAmMvy2jDSQdyO0
         wkB7xCY/zJlNm9Q9o/tsSSGaz/alejmSAvfJMgxm2CDi6XcCta6zewBZJd0F0W0PXB/E
         O6e/pdBJX+um9LP1S55hoxlcjNi9nS1dbYVrk3xaSk21uxnKgmcYFZZbnL9qXUkJ31Gv
         A6VA==
X-Gm-Message-State: AOAM530IG8sjqNKoc/ECtmkbdDUg+BrBD1vbjenxex1yhhmVxWd5GYRY
        RkSK5ISBCIHwBGSrmnm5opVH9668TvW0LQ==
X-Google-Smtp-Source: ABdhPJwCNBqGeDfMPczEECqeGszRyfUN9hujSQU+BqKcvL+V50rigtwbjmj9tchkcFW/uTHmeFPnhw==
X-Received: by 2002:a05:651c:2006:: with SMTP id s6mr9020803ljo.171.1630096614686;
        Fri, 27 Aug 2021 13:36:54 -0700 (PDT)
Received: from kari-VirtualBox (87-95-21-3.bb.dnainternet.fi. [87.95.21.3])
        by smtp.gmail.com with ESMTPSA id bt29sm687080lfb.4.2021.08.27.13.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 13:36:54 -0700 (PDT)
Date:   Fri, 27 Aug 2021 23:36:51 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     tomas.winkler@intel.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] mei: switch from 'pci_' to 'dma_' API
Message-ID: <20210827203651.nzr2yrneg5rjo76k@kari-VirtualBox>
References: <d4d442f06c602230e8145a531647bbfee69a1e31.1629662528.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4d442f06c602230e8145a531647bbfee69a1e31.1629662528.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 22, 2021 at 10:02:59PM +0200, Christophe JAILLET wrote:
> The wrappers in include/linux/pci-dma-compat.h should go away.
> 
> The patch has been generated with the coccinelle script below.
> 
> It has been compile tested.

This should not be in commit message. It is unrelevant after this patch
is merged. It should be between
---
<here>
---

It is still good info to give.

Argillander

> 
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
> ---
> If needed, see post from Christoph Hellwig on the kernel-janitors ML:
>    https://marc.info/?l=kernel-janitors&m=158745678307186&w=4
> ---
>  drivers/misc/mei/pci-txe.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/mei/pci-txe.c b/drivers/misc/mei/pci-txe.c
> index aec0483b8e72..fa20d9a27813 100644
> --- a/drivers/misc/mei/pci-txe.c
> +++ b/drivers/misc/mei/pci-txe.c
> @@ -69,9 +69,9 @@ static int mei_txe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  		goto end;
>  	}
>  
> -	err = pci_set_dma_mask(pdev, DMA_BIT_MASK(36));
> +	err = dma_set_mask(&pdev->dev, DMA_BIT_MASK(36));
>  	if (err) {
> -		err = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
> +		err = dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
>  		if (err) {
>  			dev_err(&pdev->dev, "No suitable DMA available.\n");
>  			goto end;
> -- 
> 2.30.2
> 
