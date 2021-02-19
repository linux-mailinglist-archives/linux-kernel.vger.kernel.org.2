Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AEC931FCFE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 17:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbhBSQSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 11:18:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbhBSQRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 11:17:49 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 435BEC061786
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 08:17:02 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id h10so10873516edl.6
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 08:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bwqh7eek7Wc+3t3YTsL7G0gagoVwzjjdPhWUeI8RZbw=;
        b=tLHcAE1h3wJEOF7Tn/PXq5/G5/ZviBHkahcb6WVBi6IuqnG+M48af//6lBqp38dM7U
         R3iMdRzk2DCDK9NRDoRa/TNeyl2LNPMKCUH+pJ9eYUpUHU1l7H9RBrnh5RTzpKJr7Ys0
         YLMiHEffWL8BCLfcbAkUVyTlqREKm8HDdx/DBcLoo8Rzy8xOqIbPH1g2PQbQECBOEz3T
         8eP5/mLDedi/805m/JhjWdsObXwNK114p9Z3I42ltnG3tUj+nAPMqEyXz++vC7dHGnTf
         FAWrI8RlCK6qY9lx+jFXvXDV566rKtTP4V7TDrqULfpQOM7jgsc6agylb4RaPsmkJEtq
         Uw1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bwqh7eek7Wc+3t3YTsL7G0gagoVwzjjdPhWUeI8RZbw=;
        b=MGL1WKOMUMt4xSLLBWhYDlpl3EULbIk5lF9fmEkigkWrLJSUfw+KB3DZKbNLflum8B
         W+UMIXrs/j573hBnbzvx70EK0xWooP2Bc+TxKigSRD/zJqh0fxwi7gCPFrQir4pB94sf
         o5FT1IMxhfUxr3Vz7u/x5O+nl8oE7IjM+CU/0+N9SqL1f+VXU4FIMXGD9B211SmpsUhY
         m26A3gbDQ4ozbVooVCmBqwP5vyDSVBMQHAPDPpFw0f/FHqckmsD2LgyZ2njME2JYyiEu
         Q2KyS6ybUVd4kISwee/vGPBQimwM+hp3IRR/fibG8Q7nFyS3d7icRyIxuXBjJff0h6GV
         Y6mQ==
X-Gm-Message-State: AOAM531YuIriWjYhBepWpWz6ejJSWs50gskLwzzpdupEyOzO28pNS2ty
        qgNx5SkAhm6dyRsMWd5LflsgPej7Ve3kaKcr7BgS1w==
X-Google-Smtp-Source: ABdhPJwIWQ+j+RjmbGJA+kXahou9TCnyEzCx6el1aPMaVHS9Q9CO/yV3evNcaZ5G/993fNKXKux4thxwumcQ7ZpUl2o=
X-Received: by 2002:a50:cbc7:: with SMTP id l7mr9930057edi.134.1613751421015;
 Fri, 19 Feb 2021 08:17:01 -0800 (PST)
MIME-Version: 1.0
References: <20210206135020.1991820-1-heiko@sntech.de>
In-Reply-To: <20210206135020.1991820-1-heiko@sntech.de>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Fri, 19 Feb 2021 13:16:49 -0300
Message-ID: <CAAEAJfB44mBxbdHgXFV1m6774O+6jYR6jG2qYz_15+Vc1dNejA@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: kd35t133: allow using non-continuous dsi clock
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Chris Morgan <macromorgan@hotmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Feb 2021 at 10:50, Heiko Stuebner <heiko@sntech.de> wrote:
>
> The panel is able to work when dsi clock is non-continuous, thus
> the system power consumption can be reduced using such feature.
>
> Add MIPI_DSI_CLOCK_NON_CONTINUOUS to panel's mode_flags.
>
> Also the flag actually becomes necessary after
> commit c6d94e37bdbb ("drm/bridge/synopsys: dsi: add support for non-continuous HS clock")
> and without it the panel only emits stripes instead of output.
>

Looks like c6d94e37bdbb landed in v5.10, so we should add:

Fixes: c6d94e37bdbb ("drm/bridge/synopsys: dsi: add support for
non-continuous HS clock")
Cc: stable@vger.kernel.org # 5.10+

With this fix, my Odroid Go2 has display.

Tested-by: Ezequiel Garcia <ezequiel@collabora.com>

Thanks,
Ezequiel

> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  drivers/gpu/drm/panel/panel-elida-kd35t133.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/panel/panel-elida-kd35t133.c b/drivers/gpu/drm/panel/panel-elida-kd35t133.c
> index bc36aa3c1123..fe5ac3ef9018 100644
> --- a/drivers/gpu/drm/panel/panel-elida-kd35t133.c
> +++ b/drivers/gpu/drm/panel/panel-elida-kd35t133.c
> @@ -265,7 +265,8 @@ static int kd35t133_probe(struct mipi_dsi_device *dsi)
>         dsi->lanes = 1;
>         dsi->format = MIPI_DSI_FMT_RGB888;
>         dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
> -                         MIPI_DSI_MODE_LPM | MIPI_DSI_MODE_EOT_PACKET;
> +                         MIPI_DSI_MODE_LPM | MIPI_DSI_MODE_EOT_PACKET |
> +                         MIPI_DSI_CLOCK_NON_CONTINUOUS;
>
>         drm_panel_init(&ctx->panel, &dsi->dev, &kd35t133_funcs,
>                        DRM_MODE_CONNECTOR_DSI);
> --
> 2.29.2
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
