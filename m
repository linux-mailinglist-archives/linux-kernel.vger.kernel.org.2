Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A72B63F6129
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 16:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238090AbhHXO6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 10:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238087AbhHXO6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 10:58:14 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF7EC0613A3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 07:57:30 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id b4so2056850lfo.13
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 07:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tFuAhHRvSBhDz+fiasoL7jf1i1KSqv23Xjdy8dyIAuM=;
        b=mhEK3xD5kfM/MMWdqfiXtqpFYXTaguDWW0o7KXfSaguSDL6W+DN8rYV5nlh2e0uSuv
         gU8R0CFXWwEdyDWgVS+mP34Z25JeZYBkWgcIkWkg2q9r59ojChEVC8BI15W8ax3sYEKh
         o6OkjoIF/FvUhQjXQHa9JEnNHSUPK7i4+OO9Mxmu7JJ1yOpzMKH9+8n3Pr3FoXNLgGQN
         MvJ8CqBPORqEJ2XFQYPVorB06suFtuZXEl4yBpRKYH34jCbhsydcFlSNSi46xEBkO0cK
         OSBErhFDEcjtQCKYtym4RX4h8ly33sjVON9/LCFaT5Z8FPPWWS41b7QzX5I13h8tUL63
         o2Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tFuAhHRvSBhDz+fiasoL7jf1i1KSqv23Xjdy8dyIAuM=;
        b=bPS/VIi/lenBjhTBL8BkTdqt/BIniZ+LCR+GPrT0/c71DfXJTKboezqRZ21HvVtFwh
         sE6MsUPbXC0NqOubj08rDCkNjdypqijHiNsxVN6cBsm+Z/dKhjAOBcpERRyS+kBQBJLS
         8eOQN7+gscNP8KoQae3P72qUNBxqotzuiaJKZiTRSnABUYDyHROnrkWcrEDsuXGCNLN6
         5gvs5OVQVYaInHTkdAgfxRrVPY0lqx+M2EPu6OyclNVvrnwAhc0qcM9OOliSFluU9bt8
         gDEYEBqd1AYS/rT2DT5wrNXCWZK7KjB0nnQKZskr8Ewiz85Nz0M7Sk0t3Fb2q/Oz3Pis
         SLrQ==
X-Gm-Message-State: AOAM530YRZq0gyCuxDmJ7SXPO8nrr6F1FQUei34c7u+nLqOrH7qJElFz
        QXqH6tJOAnPh6Rsg3iI8PMBemXX7dRbQPPTtMMyXTw==
X-Google-Smtp-Source: ABdhPJzBtOEeU09sJuUqAdfTBw1y5ZBxo0r+z7rrGFgSd3VtlxoiEk+AzaqMmuQlh5WB1UfpJMTen1+JY+z+bHMaK+c=
X-Received: by 2002:ac2:5b9e:: with SMTP id o30mr3762491lfn.400.1629817048379;
 Tue, 24 Aug 2021 07:57:28 -0700 (PDT)
MIME-Version: 1.0
References: <b617f284e2ab8b6b48fff150eba1638641646edd.1629640046.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <b617f284e2ab8b6b48fff150eba1638641646edd.1629640046.git.christophe.jaillet@wanadoo.fr>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 24 Aug 2021 16:56:52 +0200
Message-ID: <CAPDyKFpnWQJ7fGF_QBq-_KE7Hc-Wc0U3cc89EHyHBPx+4t1j1A@mail.gmail.com>
Subject: Re: [PATCH] mmc: switch from 'pci_' to 'dma_' API
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Alex Dubov <oakad@yahoo.com>, Bruce Chang <brucechang@via.com.tw>,
        Harald Welte <HaraldWelte@viatech.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Aug 2021 at 15:48, Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> The wrappers in include/linux/pci-dma-compat.h should go away.
>
> The patch has been generated with the coccinelle script below.
>
> It has been compile tested.
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

Applied for next, thanks!

Kind regards
Uffe


> ---
> If needed, see post from Christoph Hellwig on the kernel-janitors ML:
>    https://marc.info/?l=kernel-janitors&m=158745678307186&w=4
> ---
>  drivers/mmc/host/tifm_sd.c   | 16 ++++++++--------
>  drivers/mmc/host/via-sdmmc.c |  4 ++--
>  2 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/mmc/host/tifm_sd.c b/drivers/mmc/host/tifm_sd.c
> index 9fdf7ea06e3f..63917070b1a7 100644
> --- a/drivers/mmc/host/tifm_sd.c
> +++ b/drivers/mmc/host/tifm_sd.c
> @@ -669,8 +669,8 @@ static void tifm_sd_request(struct mmc_host *mmc, struct mmc_request *mrq)
>
>                         if(1 != tifm_map_sg(sock, &host->bounce_buf, 1,
>                                             r_data->flags & MMC_DATA_WRITE
> -                                           ? PCI_DMA_TODEVICE
> -                                           : PCI_DMA_FROMDEVICE)) {
> +                                           ? DMA_TO_DEVICE
> +                                           : DMA_FROM_DEVICE)) {
>                                 pr_err("%s : scatterlist map failed\n",
>                                        dev_name(&sock->dev));
>                                 mrq->cmd->error = -ENOMEM;
> @@ -680,15 +680,15 @@ static void tifm_sd_request(struct mmc_host *mmc, struct mmc_request *mrq)
>                                                    r_data->sg_len,
>                                                    r_data->flags
>                                                    & MMC_DATA_WRITE
> -                                                  ? PCI_DMA_TODEVICE
> -                                                  : PCI_DMA_FROMDEVICE);
> +                                                  ? DMA_TO_DEVICE
> +                                                  : DMA_FROM_DEVICE);
>                         if (host->sg_len < 1) {
>                                 pr_err("%s : scatterlist map failed\n",
>                                        dev_name(&sock->dev));
>                                 tifm_unmap_sg(sock, &host->bounce_buf, 1,
>                                               r_data->flags & MMC_DATA_WRITE
> -                                             ? PCI_DMA_TODEVICE
> -                                             : PCI_DMA_FROMDEVICE);
> +                                             ? DMA_TO_DEVICE
> +                                             : DMA_FROM_DEVICE);
>                                 mrq->cmd->error = -ENOMEM;
>                                 goto err_out;
>                         }
> @@ -762,10 +762,10 @@ static void tifm_sd_end_cmd(struct tasklet_struct *t)
>                 } else {
>                         tifm_unmap_sg(sock, &host->bounce_buf, 1,
>                                       (r_data->flags & MMC_DATA_WRITE)
> -                                     ? PCI_DMA_TODEVICE : PCI_DMA_FROMDEVICE);
> +                                     ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
>                         tifm_unmap_sg(sock, r_data->sg, r_data->sg_len,
>                                       (r_data->flags & MMC_DATA_WRITE)
> -                                     ? PCI_DMA_TODEVICE : PCI_DMA_FROMDEVICE);
> +                                     ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
>                 }
>
>                 r_data->bytes_xfered = r_data->blocks
> diff --git a/drivers/mmc/host/via-sdmmc.c b/drivers/mmc/host/via-sdmmc.c
> index c32df5530b94..88662a90ed96 100644
> --- a/drivers/mmc/host/via-sdmmc.c
> +++ b/drivers/mmc/host/via-sdmmc.c
> @@ -491,7 +491,7 @@ static void via_sdc_preparedata(struct via_crdr_mmc_host *host,
>
>         count = dma_map_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
>                 ((data->flags & MMC_DATA_READ) ?
> -               PCI_DMA_FROMDEVICE : PCI_DMA_TODEVICE));
> +               DMA_FROM_DEVICE : DMA_TO_DEVICE));
>         BUG_ON(count != 1);
>
>         via_set_ddma(host, sg_dma_address(data->sg), sg_dma_len(data->sg),
> @@ -638,7 +638,7 @@ static void via_sdc_finish_data(struct via_crdr_mmc_host *host)
>
>         dma_unmap_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
>                 ((data->flags & MMC_DATA_READ) ?
> -               PCI_DMA_FROMDEVICE : PCI_DMA_TODEVICE));
> +               DMA_FROM_DEVICE : DMA_TO_DEVICE));
>
>         if (data->stop)
>                 via_sdc_send_command(host, data->stop);
> --
> 2.30.2
>
