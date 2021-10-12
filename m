Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82281429FCA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 10:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234867AbhJLIaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 04:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234587AbhJLIaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 04:30:18 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E8BC06161C
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 01:28:16 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id t9so83117888lfd.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 01:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TqrU2cFlasxqkRqpiYWWW8WqiL3iPrIO9687ezTTKRI=;
        b=hJfcN/qDfclUWPP4E7Tyb36Msq1t/iAmwmHBv7DcB4/3+nOkvGPjBnpx24dfLCX14W
         4wCqaAfftoH3aRqdcW+Br6QcSjj2Jhk6KVdzqgchJRGl2zaFbumb0vfvs0xEO8HBwvY0
         zuJrnAo+kkgO1JGHW+b8PmR59LJjgzVfAa3/hZNyxorAbcYoCBOQ4KxgZoJF2X+MZ2YW
         wEjKZ+Z6e6pl/zBljPxZli2EkOQwQlFhU+KAejWJ3qTkTAT51aZ5fkbEk86sSdA3hXS9
         +icaZt4VmL+UL5PpzajC6AvDptZnzdO2u1KXeuVjPP+KUISew4C+7A0rLTBnpHPJD/36
         7Fow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TqrU2cFlasxqkRqpiYWWW8WqiL3iPrIO9687ezTTKRI=;
        b=8MfIylI2Ggzi/FqqJfTv4Da6R5mvGHuZKK8pIfYrbSnjdU3K2uP9B4+7eK35r5DA0y
         2Mi+fQMf4gqn7di3ndJ0WrFe/jZudFkoZQp++suPZ21zceVqs7t2wmLSFP0mCAwQZP3c
         BZkkA/RRbXF0pR4y0jr/PWHEHuz2UgD/rg6DnWO0/VnzrfvTk56jJe2X8oixPHtwKmlJ
         KV3Ryd+t8myTTIPYszFBadORcaG8gdRCnmLjmCoIOIFZV+WD6g0d2dfrahk7RDph2LyS
         rp+KO5vG6i6kN9OZtxcuIBlwrAXlnxc3ZZk2bPycnj0D/durRT910pu0Hp+cuwJkkUab
         aM+g==
X-Gm-Message-State: AOAM530IcGYduJ1/ocGILVH1B6CiVy2Aqz7qmubhezQ+K/xKkg8xtq33
        wC723yCnXRi+cSogflwv4lMN3mX54h+1FNRkbg6tmA==
X-Google-Smtp-Source: ABdhPJxgFFm23/W0H3AeChVmx6tYmbVLkmEarDtdQaV1AerU2A94yipRaSPVs1z1DCtqoWswDxAdZ7vS3zkCIYAp4ms=
X-Received: by 2002:a19:6a16:: with SMTP id u22mr31250288lfu.254.1634027294895;
 Tue, 12 Oct 2021 01:28:14 -0700 (PDT)
MIME-Version: 1.0
References: <20211009041918.28419-1-xiongx18@fudan.edu.cn>
In-Reply-To: <20211009041918.28419-1-xiongx18@fudan.edu.cn>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 12 Oct 2021 10:27:38 +0200
Message-ID: <CAPDyKFpnQWeKdxc1oMWj+i9hBq0oqjZ9vvgXWdct+oNnR4dndg@mail.gmail.com>
Subject: Re: [PATCH v4] drivers/mmc: fix reference count leaks in moxart_probe
To:     Xin Xiong <xiongx18@fudan.edu.cn>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        yuanxzhang@fudan.edu.cn, Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Oct 2021 at 06:20, Xin Xiong <xiongx18@fudan.edu.cn> wrote:
>
> The issue happens in several error handling paths on two refcounted
> object related to the object "host" (dma_chan_rx, dma_chan_tx). In
> these paths, the function forgets to decrement one or both objects'
> reference count increased earlier by dma_request_chan(), causing
> reference count leaks.
>
> Fix it by balancing the refcounts of both objects in some error
> handling paths. In correspondence with the changes in moxart_probe(),
> IS_ERR() is replaced with IS_ERR_OR_NULL() in moxart_remove() as well.
>
> Signed-off-by: Xin Xiong <xiongx18@fudan.edu.cn>
> Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/moxart-mmc.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/moxart-mmc.c b/drivers/mmc/host/moxart-mmc.c
> index 6c9d38132..7b9fcef49 100644
> --- a/drivers/mmc/host/moxart-mmc.c
> +++ b/drivers/mmc/host/moxart-mmc.c
> @@ -621,6 +621,14 @@ static int moxart_probe(struct platform_device *pdev)
>                         ret = -EPROBE_DEFER;
>                         goto out;
>                 }
> +               if (!IS_ERR(host->dma_chan_tx)) {
> +                       dma_release_channel(host->dma_chan_tx);
> +                       host->dma_chan_tx = NULL;
> +               }
> +               if (!IS_ERR(host->dma_chan_rx)) {
> +                       dma_release_channel(host->dma_chan_rx);
> +                       host->dma_chan_rx = NULL;
> +               }
>                 dev_dbg(dev, "PIO mode transfer enabled\n");
>                 host->have_dma = false;
>         } else {
> @@ -675,6 +683,10 @@ static int moxart_probe(struct platform_device *pdev)
>         return 0;
>
>  out:
> +       if (!IS_ERR_OR_NULL(host->dma_chan_tx))
> +               dma_release_channel(host->dma_chan_tx);
> +       if (!IS_ERR_OR_NULL(host->dma_chan_rx))
> +               dma_release_channel(host->dma_chan_rx);
>         if (mmc)
>                 mmc_free_host(mmc);
>         return ret;
> @@ -687,9 +699,9 @@ static int moxart_remove(struct platform_device *pdev)
>
>         dev_set_drvdata(&pdev->dev, NULL);
>
> -       if (!IS_ERR(host->dma_chan_tx))
> +       if (!IS_ERR_OR_NULL(host->dma_chan_tx))
>                 dma_release_channel(host->dma_chan_tx);
> -       if (!IS_ERR(host->dma_chan_rx))
> +       if (!IS_ERR_OR_NULL(host->dma_chan_rx))
>                 dma_release_channel(host->dma_chan_rx);
>         mmc_remove_host(mmc);
>         mmc_free_host(mmc);
> --
> 2.25.1
>
