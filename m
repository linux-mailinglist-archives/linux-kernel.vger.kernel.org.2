Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFF841D880
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 13:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350361AbhI3LQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 07:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350300AbhI3LQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 07:16:19 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93528C06176A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 04:14:36 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id b20so23901593lfv.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 04:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QJy8rE6zmEhX4hcf3qv1ndfW23x/yb8hlbRxX9xSBaQ=;
        b=R5J4RI2sYKFf8FYhkRoaK32Tdo16lFEKm1T/3FfArpim46zwaKeh0TMMKc6bFs4xqO
         QFW+JsKdiqNvwwMrD1jsIa2ifbm0j71PHYVFKqNpiHopXAFJJ88Jf7F9oNidx87Ok6Nv
         jgOwfILRJ5iZe92YLcvW8fgpVvaBnMvIA1u412AJRgA+Fq197mZVwUDi6+rE03JwSkje
         ZCrHjISvrrOzibauqAb0fEq2tZHkT2gczuWFexa03Ote/Seustcs5gkE1TM2RN5ew4HA
         8XzN+vXi5qDgvD8kH5Fp3/V6Tzj2CEL8SG0YQ3DctOslJBC5fTGjVzO9YZr8Smj8cNcn
         P/OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QJy8rE6zmEhX4hcf3qv1ndfW23x/yb8hlbRxX9xSBaQ=;
        b=58sqYQ56igfjUagCRgDbXRe1SNxGax8mozkzWP6Mym0lhk+ryJkWtJ9rnBtHDvxVfD
         TfjPoxgUVB4EN+rhWeTh3Qva6L6LmO9teForeZTk7iLupTKg6w5TFfL3LaqN3wzEH5KY
         cr7D2Fo/lUGWNgzSw88xnXbJ/38oO/gldeXi5rzLn2yJICr6YKatpXA/kl5eqxE8URpR
         Go3G4Tf7y28o6xw57fSPQeYgzWrH25vcWrR2jNfDyUWJB+FX6s5DoWiikDZjr9p22udI
         OjaVE49QTJyZsrrgnp/mN3tSk5X2gZRv9IlLEIHgcQUivXZ4teblWF0dnthcUZbEMwKo
         qnTg==
X-Gm-Message-State: AOAM533mWOjBiOXKp/0uSUGnrHKDTYeKmJRTW0CgB07c1AJ/koE3IBy8
        3v0j6n2dmu2DfAaPOvyreW7+sJkupPPLJ7/fCbVC4Q==
X-Google-Smtp-Source: ABdhPJzpvQSrEfqijhwBTwrlWrZFBoL/UDHz6+BMY8/8tCkJScD5DKbm2x5ESqdPVMznwydRAzuroutQMCebonsSgMg=
X-Received: by 2002:ac2:4157:: with SMTP id c23mr5064360lfi.184.1633000474975;
 Thu, 30 Sep 2021 04:14:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210928021337.2359-1-xiongx18@fudan.edu.cn>
In-Reply-To: <20210928021337.2359-1-xiongx18@fudan.edu.cn>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 30 Sep 2021 13:13:59 +0200
Message-ID: <CAPDyKFobTze665JuBYYfVyXg3F9CkBVbw7A-PqBcj2WOk194Pw@mail.gmail.com>
Subject: Re: [PATCH v3] drivers/mmc: fix reference count leaks in moxart_probe
To:     Xin Xiong <xiongx18@fudan.edu.cn>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        yuanxzhang@fudan.edu.cn, Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Sept 2021 at 04:15, Xin Xiong <xiongx18@fudan.edu.cn> wrote:
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
> ---
>  drivers/mmc/host/moxart-mmc.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/mmc/host/moxart-mmc.c b/drivers/mmc/host/moxart-mmc.c
> index 6c9d38132..f421be7ce 100644
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

This looks much better! However, it seems like we also need to deal
with the NULL case in moxart_remove(), similar to as above.

Kind regards
Uffe
