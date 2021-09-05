Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78EDC400F42
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Sep 2021 13:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237793AbhIELM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Sep 2021 07:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbhIELM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Sep 2021 07:12:56 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED67C061575;
        Sun,  5 Sep 2021 04:11:53 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id s10so7542943lfr.11;
        Sun, 05 Sep 2021 04:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+U3UCSNl0YCQFxJbxthaYAnyClY/Df6RLpX0xQi9nss=;
        b=KAHeikv6jYS9vB9RItJDvLfB1r61Gr0xUZ09IZd68sKzTWinBnsYuhdoplPzNDyUN6
         944LYLVhKCAuqALA8OxBCjsyK1j1Vb9AjxxjP+1benvTokzRCwQ1D0+K+S73IUqjUscY
         75BeA459SmujHarF6uqbVIewzlCGhrNxWteIAYmOy+SF/KuAeVH1XVpaRcSHjfgHB1Ry
         FSkQfT1lkR4q3BIhOHKZclnzTP0vlCaSE3Jx0ZeKccGHXkSUfV67lsTYDdeF9wsNNpMs
         q+feujqKvK1+qklPVJxLyfXgC4WTfP9isV/BJHIJlPOUyy8G8R1nGPmYq3Ilh5DDy9Pk
         2TbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+U3UCSNl0YCQFxJbxthaYAnyClY/Df6RLpX0xQi9nss=;
        b=lf0un+4l7iWcU4viG2P4IXpoufuW88Db3FY4kwtSQukMNI2YNcmXn3Qkm4gMCHYmYf
         L0Xe8wvafvnDyEhK3IPDFeJUq4o80dQtT49qqSiM1rCavjzNvc2sRnHWup6yzNgaIVtj
         19R64T0KVhbPMSo9yxqLiMpy5hppemdEsuXR/3gaBS38zSvsVyw5qlSc8a87gCWJfgCM
         k//MzjcO5wztsbELEoLr9WrpRI4MPyPVXhDdOYqJU3X0RagLFdJMVJAgrZ3YOaBfkibl
         DXk3uGnbKEp0XoXCZpc/OzjyoWu8TQ8kemhw/8mJsKsXM73Ck7Sv8jWCyQuRf9MElrwo
         FuWg==
X-Gm-Message-State: AOAM532DWN5DJiI2u5vNGzKWZ8FvilaoGD+frC/yk7XCK0isRlaVdpGA
        Uk7MYg4Vuc8j6xvUlCWPiKo=
X-Google-Smtp-Source: ABdhPJz/o/N9suu58Kfxg3LSyezuIuzh4johk13WESXNiNb8FhTlFyjqwJcNQmzSC+XwWAfz0pDG0g==
X-Received: by 2002:a05:6512:3d0d:: with SMTP id d13mr5793425lfv.513.1630840311782;
        Sun, 05 Sep 2021 04:11:51 -0700 (PDT)
Received: from mobilestation ([95.79.127.110])
        by smtp.gmail.com with ESMTPSA id l11sm460515lfg.39.2021.09.05.04.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Sep 2021 04:11:51 -0700 (PDT)
Date:   Sun, 5 Sep 2021 14:11:49 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     sanju.mehta@amd.com, Shyam-sundar.S-k@amd.com, jdmason@kudzu.us,
        dave.jiang@intel.com, allenbh@gmail.com,
        linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] NTB: switch from 'pci_' to 'dma_' API
Message-ID: <20210905111149.atqgurplzy472thz@mobilestation>
References: <6a1db73ba4e46958cb40d3766eff771ef5d7a11b.1629640974.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a1db73ba4e46958cb40d3766eff771ef5d7a11b.1629640974.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe

On Sun, Aug 22, 2021 at 04:04:12PM +0200, Christophe JAILLET wrote:
> The wrappers in include/linux/pci-dma-compat.h should go away.
> 
> The patch has been generated with the coccinelle script below.
> 
> It has been compile tested.

Thanks for the clean up. Explicit Ack for the IDT-part is below.

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
> 
> This patch is mostly mechanical and compile tested. I hope it is ok to
> update the "drivers/ntb/hw/" directory all at once.
> ---
>  drivers/ntb/hw/amd/ntb_hw_amd.c    | 12 ++----------

>  drivers/ntb/hw/idt/ntb_hw_idt.c    | 15 ++-------------

Acked-by: Serge Semin <fancer.lancer@gmail.com>

-Sergey

>  drivers/ntb/hw/intel/ntb_hw_gen1.c | 12 ++----------
>  3 files changed, 6 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
> index 71428d8cbcfc..87847c380051 100644
> --- a/drivers/ntb/hw/amd/ntb_hw_amd.c
> +++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
> @@ -1176,22 +1176,14 @@ static int amd_ntb_init_pci(struct amd_ntb_dev *ndev,
>  
>  	pci_set_master(pdev);
>  
> -	rc = pci_set_dma_mask(pdev, DMA_BIT_MASK(64));
> +	rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
>  	if (rc) {
> -		rc = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
> +		rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
>  		if (rc)
>  			goto err_dma_mask;
>  		dev_warn(&pdev->dev, "Cannot DMA highmem\n");
>  	}
>  
> -	rc = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64));
> -	if (rc) {
> -		rc = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(32));
> -		if (rc)
> -			goto err_dma_mask;
> -		dev_warn(&pdev->dev, "Cannot DMA consistent highmem\n");
> -	}
> -
>  	ndev->self_mmio = pci_iomap(pdev, 0, 0);
>  	if (!ndev->self_mmio) {
>  		rc = -EIO;
> diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
> index e7a4c2aa8baa..733557231ed0 100644
> --- a/drivers/ntb/hw/idt/ntb_hw_idt.c
> +++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
> @@ -2640,26 +2640,15 @@ static int idt_init_pci(struct idt_ntb_dev *ndev)
>  	int ret;
>  
>  	/* Initialize the bit mask of PCI/NTB DMA */
> -	ret = pci_set_dma_mask(pdev, DMA_BIT_MASK(64));
> +	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
>  	if (ret != 0) {
> -		ret = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
> +		ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
>  		if (ret != 0) {
>  			dev_err(&pdev->dev, "Failed to set DMA bit mask\n");
>  			return ret;
>  		}
>  		dev_warn(&pdev->dev, "Cannot set DMA highmem bit mask\n");
>  	}
> -	ret = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64));
> -	if (ret != 0) {
> -		ret = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(32));
> -		if (ret != 0) {
> -			dev_err(&pdev->dev,
> -				"Failed to set consistent DMA bit mask\n");
> -			return ret;
> -		}
> -		dev_warn(&pdev->dev,
> -			"Cannot set consistent DMA highmem bit mask\n");
> -	}
>  
>  	/*
>  	 * Enable the device advanced error reporting. It's not critical to
> diff --git a/drivers/ntb/hw/intel/ntb_hw_gen1.c b/drivers/ntb/hw/intel/ntb_hw_gen1.c
> index 093dd20057b9..e5f14e20a9ff 100644
> --- a/drivers/ntb/hw/intel/ntb_hw_gen1.c
> +++ b/drivers/ntb/hw/intel/ntb_hw_gen1.c
> @@ -1771,22 +1771,14 @@ static int intel_ntb_init_pci(struct intel_ntb_dev *ndev, struct pci_dev *pdev)
>  
>  	pci_set_master(pdev);
>  
> -	rc = pci_set_dma_mask(pdev, DMA_BIT_MASK(64));
> +	rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
>  	if (rc) {
> -		rc = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
> +		rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
>  		if (rc)
>  			goto err_dma_mask;
>  		dev_warn(&pdev->dev, "Cannot DMA highmem\n");
>  	}
>  
> -	rc = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64));
> -	if (rc) {
> -		rc = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(32));
> -		if (rc)
> -			goto err_dma_mask;
> -		dev_warn(&pdev->dev, "Cannot DMA consistent highmem\n");
> -	}
> -
>  	ndev->self_mmio = pci_iomap(pdev, 0, 0);
>  	if (!ndev->self_mmio) {
>  		rc = -EIO;
> -- 
> 2.30.2
> 
