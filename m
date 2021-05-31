Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6AD3955CE
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 09:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbhEaHOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 03:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbhEaHOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 03:14:43 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40246C061574
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 00:13:04 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id h24so7318739qtm.12
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 00:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yPnIo42plkwFrQDyxV2qx/s2cknNkAGZDVtx3wbOgvs=;
        b=Tp9Af5PZOT1pgH/udgKZCP5uYa6IETW7cLxSNlICLKoZBpazH6eoBaMbErfh4PiY69
         ZoKenJXw/hfXSNe3QTHHJUOulDCKS4mckM2v7xUz0AOKJN1X9z60aWCOU0dQq64zOmPb
         0OpX/Ls4vxYX6evECby6KGRXXXDYsg+Xr9cRcYcNtFWyxrBv2DUM7dToHqzcGahi2O1d
         mBWjAiXxxToWo7fkbaCA9oZRU/qc0/TATOekuO6BMXH+cKvTks/F+m3jJvi06JOFV2A3
         y1r3BKbP6+Ws0j3BfJkL/fwFd2tT8q48cSXfLZOh9/s4RQkhqPwK01T/4grlfIVPRV8C
         0T+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yPnIo42plkwFrQDyxV2qx/s2cknNkAGZDVtx3wbOgvs=;
        b=SuHYeV2hXShkG0gK0+m6Pkhbu55yT6C+YYGcJT70nzJ8N+Q/fNGCn9S8gDPNKzJ63l
         3dOaxRufdNl6sAyaRp83NbhKbjDC4LP+4UpvXX4tTrehyjxALTvCjFhnNNfAL+BaC1wk
         N0BBmNb05vjqd3HX/AwLVLKwC57RVmxpLiU6wARuiImkHmVR4G/XOkHTW9dEHtIf/884
         TaFAKmXxWOshsXl9Aq2mD3vejMwLXDXJaN6ztCKfdTdq7mZlAPYYK/E8Bbu54AJK0sYD
         WmyjzbNkcevqjRKRK7rg+1yEdzIFFIQYU8Raap3cdbPuIhgCSijFauXqUnW569C7gdJX
         2WWg==
X-Gm-Message-State: AOAM530P9le95qmlIvWJ5cogPUhn1mhnBLk6+E6s1YqpeJD+vny37ujP
        KDTnaUuBwCmZSsIKXPTr6C1k3OA+fxLftw2kpnQ=
X-Google-Smtp-Source: ABdhPJwqutod0yLild77qYJkxAUuP6UWl9+wI+5CsvXM3euJPYCcMm5SprLhD6u2aBWc3gjpwazA7aQ94EnX1pITFQc=
X-Received: by 2002:ac8:5197:: with SMTP id c23mr13620903qtn.292.1622445183449;
 Mon, 31 May 2021 00:13:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210527163409.22049-1-nicolas.cavallari@green-communications.fr>
In-Reply-To: <20210527163409.22049-1-nicolas.cavallari@green-communications.fr>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Mon, 31 May 2021 15:12:52 +0800
Message-ID: <CAA+D8APeigNMB4gTNTTVE4-vj0J9y5DEh+3P7p9iTZq1KdGuPg@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl-asoc-card: Set .owner attribute when
 registering card.
To:     Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
Cc:     Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2021 at 12:35 AM Nicolas Cavallari
<nicolas.cavallari@green-communications.fr> wrote:
>
> Otherwise, when compiled as module, a WARN_ON is triggered:
>
> WARNING: CPU: 0 PID: 5 at sound/core/init.c:208 snd_card_new+0x310/0x39c [snd]
> [...]
> CPU: 0 PID: 5 Comm: kworker/0:0 Not tainted 5.10.39 #1
> Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> Workqueue: events deferred_probe_work_func
> [<c0111988>] (unwind_backtrace) from [<c010c8ac>] (show_stack+0x10/0x14)
> [<c010c8ac>] (show_stack) from [<c092784c>] (dump_stack+0xdc/0x104)
> [<c092784c>] (dump_stack) from [<c0129710>] (__warn+0xd8/0x114)
> [<c0129710>] (__warn) from [<c0922a48>] (warn_slowpath_fmt+0x5c/0xc4)
> [<c0922a48>] (warn_slowpath_fmt) from [<bf0496f8>] (snd_card_new+0x310/0x39c [snd])
> [<bf0496f8>] (snd_card_new [snd]) from [<bf1d7df8>] (snd_soc_bind_card+0x334/0x9c4 [snd_soc_core])
> [<bf1d7df8>] (snd_soc_bind_card [snd_soc_core]) from [<bf1e9cd8>] (devm_snd_soc_register_card+0x30/0x6c [snd_soc_core])
> [<bf1e9cd8>] (devm_snd_soc_register_card [snd_soc_core]) from [<bf22d964>] (fsl_asoc_card_probe+0x550/0xcc8 [snd_soc_fsl_asoc_card])
> [<bf22d964>] (fsl_asoc_card_probe [snd_soc_fsl_asoc_card]) from [<c060c930>] (platform_drv_probe+0x48/0x98)
> [...]
>
> Signed-off-by: Nicolas Cavallari <nicolas.cavallari@green-communications.fr>

Acked-by: Shengjiu Wang <shengjiu.wang@gmail.com>

> ---
>  sound/soc/fsl/fsl-asoc-card.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
> index c62bfd1c3ac7..4f55b316cf0f 100644
> --- a/sound/soc/fsl/fsl-asoc-card.c
> +++ b/sound/soc/fsl/fsl-asoc-card.c
> @@ -744,6 +744,7 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
>         /* Initialize sound card */
>         priv->pdev = pdev;
>         priv->card.dev = &pdev->dev;
> +       priv->card.owner = THIS_MODULE;
>         ret = snd_soc_of_parse_card_name(&priv->card, "model");
>         if (ret) {
>                 snprintf(priv->name, sizeof(priv->name), "%s-audio",
> --
> 2.32.0.rc0
>
