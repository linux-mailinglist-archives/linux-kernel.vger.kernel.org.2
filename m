Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73B2F41A318
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 00:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237955AbhI0Wep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 18:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237976AbhI0Wen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 18:34:43 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B2FFC061740
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 15:33:05 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id z24so84967810lfu.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 15:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=I15WPZIIpocs3G+JmlLPOy9NymMqM29RVT5hOe2pQ/I=;
        b=vSDbSgUP2Di4FwmkQvN5iGnb4Hk8Cgsc/2exc8E7ZVUr8RLiXT36Nl0Eqx8GKT9CBA
         P9tcUzUWQTqnYKbbDun5StBCWZTKUDW4OwG6WZwEJg28ucGk77PR/E5ftDqrjmBf+Q2a
         DMExwu3LEynnZUE8N9O3eTZ1rzHxMx56LpMzUTnUNvcnk76ACZHjl9aXyLYUY+9jjqRi
         PMY1QpVshdG5XEYo4Kh6UOnBeT6ml+Ra1Yv6DQv6u49nui3wcEDhe6Xq4BBJrxW4zNM0
         Lmpxz95XtW3Z1KVeGh9aQJbZWscyKt50/9btqvgqL9MEEO/CQaIWCvezCHf///gzxAbM
         OyIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=I15WPZIIpocs3G+JmlLPOy9NymMqM29RVT5hOe2pQ/I=;
        b=5RfZTzeyo90/OogjbtPQtgSEgggOsVnflkEdv0PSBwhqJgvVaBAHs5azTEft/zNFnv
         IBcIUxVHpzUj9IUXthrTuZCumoJ6C7aSpAnmz/Y1SRjS4q7ADcaDK1FZGcOHOU8Vp4Z5
         suNSPA/x3a7RLCITshpUVjbKC2t2kyfh/wb3WieVxT83060x062RPT9+5+G3cyYIz03I
         RXM6hm/IJVSHxqlkm7Qcfoa3Ve7Nn/+OyNUuxsZh3T4C88WOZrZX6W6an2Xkg67mdic8
         Oqy9CqTwa5bos+MN4JMiCIC3fWmMvpxU6/XVoITkc+I5YSVieyFUDz5FnDfp4G397KZ5
         NXsQ==
X-Gm-Message-State: AOAM532QgjCEdCxjBdGTj3+1NSKFImjWdeLUqEEwHAnYsJV6Ev/THWct
        W74RGpQiV5zYOBeYtxlIQRvo9WgktbnJgRQV0/UU9A==
X-Google-Smtp-Source: ABdhPJyxBGWiBc4Azjidi9rycgneWjrmFFuGJT4rTG0L/rzqF2tXs/eZ6AtBTZQFKQpWUQ8wE3izb/7yQauawTmc4qs=
X-Received: by 2002:a2e:898c:: with SMTP id c12mr2434278lji.16.1632781983522;
 Mon, 27 Sep 2021 15:33:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210927015759.30855-1-xiongx18@fudan.edu.cn>
In-Reply-To: <20210927015759.30855-1-xiongx18@fudan.edu.cn>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 28 Sep 2021 00:32:27 +0200
Message-ID: <CAPDyKFoeA01fy6pAcSu2qaqs9U2VcgTLSvhzvNObhhprPdDT9g@mail.gmail.com>
Subject: Re: [PATCH v2] drivers/mmc: fix reference count leaks in moxart_probe
To:     Xin Xiong <xiongx18@fudan.edu.cn>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        yuanxzhang@fudan.edu.cn, Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Sept 2021 at 04:00, Xin Xiong <xiongx18@fudan.edu.cn> wrote:
>
> The issue happens in several error handling paths on two refcounted
> object related to the object "host" (dma_chan_rx, dma_chan_tx). In
> these paths, the function forgets to decrement one or both objects'
> reference count increased earlier by dma_request_chan(), causing
> reference count leaks.
>
> Fix it by balancing the refcounts of both objects in some error
> handling paths.
>
> Signed-off-by: Xin Xiong <xiongx18@fudan.edu.cn>
> Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>

The code looks good to me! However, checkpatch is complaining about
the format. Please run it and fixup the reported warnings/errors.

Kind regards
=C3=9Cffe


> ---
>  drivers/mmc/host/moxart-mmc.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/mmc/host/moxart-mmc.c b/drivers/mmc/host/moxart-mmc.=
c
> index 6c9d38132..e27ab3446 100644
> --- a/drivers/mmc/host/moxart-mmc.c
> +++ b/drivers/mmc/host/moxart-mmc.c
> @@ -621,6 +621,14 @@ static int moxart_probe(struct platform_device *pdev=
)
>                         ret =3D -EPROBE_DEFER;
>                         goto out;
>                 }
> +        if (!IS_ERR(host->dma_chan_tx)) {
> +            dma_release_channel(host->dma_chan_tx);
> +            host->dma_chan_tx =3D NULL;
> +        }
> +        if (!IS_ERR(host->dma_chan_rx)) {
> +            dma_release_channel(host->dma_chan_rx);
> +            host->dma_chan_rx =3D NULL;
> +        }
>                 dev_dbg(dev, "PIO mode transfer enabled\n");
>                 host->have_dma =3D false;
>         } else {
> @@ -675,6 +683,10 @@ static int moxart_probe(struct platform_device *pdev=
)
>         return 0;
>
>  out:
> +    if (!IS_ERR_OR_NULL(host->dma_chan_tx))
> +        dma_release_channel(host->dma_chan_tx);
> +    if (!IS_ERR_OR_NULL(host->dma_chan_rx))
> +        dma_release_channel(host->dma_chan_rx);
>         if (mmc)
>                 mmc_free_host(mmc);
>         return ret;
> --
> 2.25.1
>
