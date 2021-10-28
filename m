Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A41B43DE5D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 12:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbhJ1KDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 06:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbhJ1KDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 06:03:35 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED93FC061767
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 03:01:08 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id k13so9655397ljj.12
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 03:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fSUUXSAFp+U/pzk0ZFFpNl+pmZUQiHZI7Km2UPBgzxo=;
        b=pyIEuQfNSMvWaNLN4sXO6MGPdFJpMAFX/V8Vn8qMhLNzrgXfippjXKeKDerh0YjsyA
         5zJn7MNZHNZ1qb/mkLWiMtNDvLViR3JI/44RxloJPwcBxfyqdZ+YZn3XtnjbxEnWdeCF
         oH4tqXjy1QIcOtTY6iBFWJaSihr9CGTa7luZZEOj6Fp6qgzZR8vMz4o3Zt/HfvVvazNY
         g8Wy5QOhBD0LdnPBnL2ZlFko2KwmA+VfMcCgLZeImT46c2F5ifBBlsf4f/hXLAKLaINP
         RhDXWzKBA/GH1ZdLCh/odbLVryNdOWeYi6/0z0cGAHJL2ZBOOrdQrNH8qqGkstHdDf4m
         NQoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fSUUXSAFp+U/pzk0ZFFpNl+pmZUQiHZI7Km2UPBgzxo=;
        b=rCWSovu5d/yf/SFGFk0WHYuoouTEOZ/Kh8TSz/Fw7SEEIJ8UPXdVWZa0jijizlh5+Q
         COgZxvsYseipP0ndMnQOly1dwEkxAOuM4zxOmRcc/wcbNoLcTRbEMM5q/8c5TQjra+ZS
         dSZzCvmYovGCzh0vcpu6IGQhqY27xZFxogx2+w3IKGKGZvV8HMBJ3ePJhrg+x8JiUKvm
         sa/qmiGEAcjTD8qv0RTcaESB/DRHLelKGpuhoCkJOSVALWmLalomZVsc0ufFG9jYNCfy
         Oszbpbiih/4/AIvW5CujW5akrJOjhmW8pvSzitfgNvkOKO86g38a1d7Ks3muKOWke2Rt
         zfMQ==
X-Gm-Message-State: AOAM533nfjSf+fbnoO0rDuX2HBbfAhI5TEjjoGPHArP+9JFV5QSMLzqp
        1byq63dW1WuOKnTAvZRaFWa4jbNnfFJ9PUX/BGjDxg==
X-Google-Smtp-Source: ABdhPJxluntOhxdxK38z3qCSthne3EvWdVhekoNo1AufTq1f5b0lSX4qPbjRU8qzy2AYU+QFtnq4Te9kDWr177reDPc=
X-Received: by 2002:a05:651c:907:: with SMTP id e7mr3774078ljq.300.1635415267227;
 Thu, 28 Oct 2021 03:01:07 -0700 (PDT)
MIME-Version: 1.0
References: <20211028022049.22129-1-wenbin.mei@mediatek.com>
In-Reply-To: <20211028022049.22129-1-wenbin.mei@mediatek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 28 Oct 2021 12:00:30 +0200
Message-ID: <CAPDyKFpcPDKmL-MCsXssX2ABVQ3LnMQVM+pG1=z68_b4d6bPBA@mail.gmail.com>
Subject: Re: [PATCH] mmc: mediatek: move cqhci init behind ungate clock
To:     Wenbin Mei <wenbin.mei@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Chun-Hung Wu <chun-hung.wu@mediatek.com>,
        Yong Mao <yong.mao@mediatek.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Oct 2021 at 04:20, Wenbin Mei <wenbin.mei@mediatek.com> wrote:
>
> We must enable clock before cqhci init, because crypto needs
> read information from CQHCI registers, otherwise, it will hang
> in MediaTek mmc host controller.
>
> Signed-off-by: Wenbin Mei <wenbin.mei@mediatek.com>
> Fixes: 88bd652b3c74 ("mmc: mediatek: command queue support")
> Cc: stable@vger.kernel.org

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mtk-sd.c | 38 +++++++++++++++++++-------------------
>  1 file changed, 19 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index b124cfee05a1..943940b44e83 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -2656,6 +2656,25 @@ static int msdc_drv_probe(struct platform_device *pdev)
>                 host->dma_mask = DMA_BIT_MASK(32);
>         mmc_dev(mmc)->dma_mask = &host->dma_mask;
>
> +       host->timeout_clks = 3 * 1048576;
> +       host->dma.gpd = dma_alloc_coherent(&pdev->dev,
> +                               2 * sizeof(struct mt_gpdma_desc),
> +                               &host->dma.gpd_addr, GFP_KERNEL);
> +       host->dma.bd = dma_alloc_coherent(&pdev->dev,
> +                               MAX_BD_NUM * sizeof(struct mt_bdma_desc),
> +                               &host->dma.bd_addr, GFP_KERNEL);
> +       if (!host->dma.gpd || !host->dma.bd) {
> +               ret = -ENOMEM;
> +               goto release_mem;
> +       }
> +       msdc_init_gpd_bd(host, &host->dma);
> +       INIT_DELAYED_WORK(&host->req_timeout, msdc_request_timeout);
> +       spin_lock_init(&host->lock);
> +
> +       platform_set_drvdata(pdev, mmc);
> +       msdc_ungate_clock(host);
> +       msdc_init_hw(host);
> +
>         if (mmc->caps2 & MMC_CAP2_CQE) {
>                 host->cq_host = devm_kzalloc(mmc->parent,
>                                              sizeof(*host->cq_host),
> @@ -2676,25 +2695,6 @@ static int msdc_drv_probe(struct platform_device *pdev)
>                 mmc->max_seg_size = 64 * 1024;
>         }
>
> -       host->timeout_clks = 3 * 1048576;
> -       host->dma.gpd = dma_alloc_coherent(&pdev->dev,
> -                               2 * sizeof(struct mt_gpdma_desc),
> -                               &host->dma.gpd_addr, GFP_KERNEL);
> -       host->dma.bd = dma_alloc_coherent(&pdev->dev,
> -                               MAX_BD_NUM * sizeof(struct mt_bdma_desc),
> -                               &host->dma.bd_addr, GFP_KERNEL);
> -       if (!host->dma.gpd || !host->dma.bd) {
> -               ret = -ENOMEM;
> -               goto release_mem;
> -       }
> -       msdc_init_gpd_bd(host, &host->dma);
> -       INIT_DELAYED_WORK(&host->req_timeout, msdc_request_timeout);
> -       spin_lock_init(&host->lock);
> -
> -       platform_set_drvdata(pdev, mmc);
> -       msdc_ungate_clock(host);
> -       msdc_init_hw(host);
> -
>         ret = devm_request_irq(&pdev->dev, host->irq, msdc_irq,
>                                IRQF_TRIGGER_NONE, pdev->name, host);
>         if (ret)
> --
> 2.25.1
>
