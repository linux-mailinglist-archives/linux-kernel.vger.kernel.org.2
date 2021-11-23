Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A76745A13D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 12:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235353AbhKWLWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 06:22:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234990AbhKWLW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 06:22:26 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346EEC061756
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 03:19:18 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id e11so10319662ljo.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 03:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w+ogjWxG1DbsOOSKAdBRBvdcSf1vlOMjAXY68aT/3+U=;
        b=g2Y3CYQC1NcCLavzUvr4ErWMQvZ4fzsgBv6CCbmTOoZcOun8WjSds54sZrtzeYEA0U
         N5KF7mJ3kl8nFIULnhlxeAUeFZAuCfq+uX5Urd7Y31Xp8cHxNzCxkkp6HS46EZb3D6jZ
         c7TwybE0YdC9woGghm+c/KCOlK35CIfDZrYTO7zFljpZaTHjklc27An1TOol1n/1idvS
         kCKfDejnDdUw+aN2JJNNmUQf32+SP4pOXJVkzxhNH+rbEkLFMLkjE8yfz5ElxThNneaF
         SJXtBIs1DuxaYn0676eJKdryXGQlku5s0UQEwOdM0oGilYhXoK+2140z6YDVV15iHy6a
         9PQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w+ogjWxG1DbsOOSKAdBRBvdcSf1vlOMjAXY68aT/3+U=;
        b=jgbZ24FfFzeZ8jhUojfX5z3jhwHOW018ovh6jhpldw79I/J8WNsZ/geE8kyTxkzuZ1
         jtvJr8dZGpgQq8eHwyewP+KRsMbYUWHEJvWgmKSKYKWpPU1PSWfiDS3zET2pw7sNBpmR
         EZ217r+eOSpIuIq/qUSdq1c8p/fy6BBYT4fZnF7Jkn21djF7uS6Px63+u817yjuvdQ+n
         +jj2Y/dOaj5G8B5ldjVoab434gtlRZZm5cW/+ec1fQ/P6PsowlhS82rkvPdTlyDyHrCr
         IC5S15gT7z6LkW9sWHMK2wb2qiORU3ju0YXXtsYqpeuCAVX2yghqpTdy535z3wNHsuTc
         AQFQ==
X-Gm-Message-State: AOAM530XsieAb+rfio6+0G4yTVMz4/CX9g62wR561QNIk2wA5Y4y+2Yo
        VD20JgxbBGqX2taSAlkhFp5AGwWpHisAWXzE0rRm9Q==
X-Google-Smtp-Source: ABdhPJxH+dIDF8nBsp8fxznpkoFe9y9Zmc/xUzjvp4Mfv2L5TNuCMH6djlHGcQ7ManpwMDd1PzQBcWJG8pF2EVa/HSY=
X-Received: by 2002:a05:651c:1507:: with SMTP id e7mr4381662ljf.300.1637666356182;
 Tue, 23 Nov 2021 03:19:16 -0800 (PST)
MIME-Version: 1.0
References: <20211122222203.4103644-1-arnd@kernel.org> <20211122222203.4103644-5-arnd@kernel.org>
In-Reply-To: <20211122222203.4103644-5-arnd@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 23 Nov 2021 12:18:40 +0100
Message-ID: <CAPDyKFrCOoFWuM_6Renu+M5SHotyuzXeyH99WZb69G1PFQ1z5A@mail.gmail.com>
Subject: Re: [PATCH v2 04/11] mmc: bcm2835: stop setting chan_config->slave_id
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Andy Gross <agross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Jon Hunter <jonathanh@nvidia.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Scott Branden <sbranden@broadcom.com>,
        Takashi Iwai <tiwai@suse.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        alsa-devel@alsa-project.org, bcm-kernel-feedback-list@broadcom.com,
        dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Nov 2021 at 23:23, Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The field is not interpreted by the DMA engine driver, as all the data
> is passed from devicetree instead. Remove the assignment so the field
> can eventually be deleted.
>
> Reviewed-by: Nicolas Saenz Julienne <nsaenz@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I think I acked the previous version, but nevermind:

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/mmc/host/bcm2835.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
> index 8c2361e66277..463b707d9e99 100644
> --- a/drivers/mmc/host/bcm2835.c
> +++ b/drivers/mmc/host/bcm2835.c
> @@ -1293,14 +1293,12 @@ static int bcm2835_add_host(struct bcm2835_host *host)
>
>                 host->dma_cfg_tx.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
>                 host->dma_cfg_tx.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> -               host->dma_cfg_tx.slave_id = 13;         /* DREQ channel */
>                 host->dma_cfg_tx.direction = DMA_MEM_TO_DEV;
>                 host->dma_cfg_tx.src_addr = 0;
>                 host->dma_cfg_tx.dst_addr = host->phys_addr + SDDATA;
>
>                 host->dma_cfg_rx.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
>                 host->dma_cfg_rx.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> -               host->dma_cfg_rx.slave_id = 13;         /* DREQ channel */
>                 host->dma_cfg_rx.direction = DMA_DEV_TO_MEM;
>                 host->dma_cfg_rx.src_addr = host->phys_addr + SDDATA;
>                 host->dma_cfg_rx.dst_addr = 0;
> --
> 2.29.2
>
