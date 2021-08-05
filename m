Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB8E3E1C17
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 21:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241469AbhHETF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 15:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232116AbhHETFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 15:05:55 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD09C061765
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 12:05:40 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id e2-20020a17090a4a02b029016f3020d867so11880128pjh.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 12:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2ZFFq7OM5nVkToszzdtX9QSlNl/eY89U4a4AO5gbJ0c=;
        b=dgxIBWU0u0EHXfPQrJsNfrQ8leeNYIxMblGPZfdM3Ua7Qj+jQjx5zoz/UaSUmzqj6q
         tIX67J0aXI+Av+ptQljjWXFQeGYLxwdbj2qhFwEWL90k+N25uxQ1rDEDrKiPb4wqRVe3
         rT23r+cBkDJ9g8JijWw84nFgPxCSpV4PQn+iMphpfz4y04ObSCyLuI60Z07KnNlfZ+oj
         NY/2x7Jo2MqimtJzymKazggA5aIuIkvFjUWcsmy7w2hBG3tGQFpqsSt6Hkknt5XLIM/T
         +rW8B1o1WfkgB4tUvMQfipkFb2KUbdd/DxggqQFa/z8Ii/CpEAG2KWbvZi0Sw8VZXi/R
         Bq0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2ZFFq7OM5nVkToszzdtX9QSlNl/eY89U4a4AO5gbJ0c=;
        b=V4a+KaePAc0jtahUtNHF0Iur+4b1xebk3Xd8eU+kV+WrTcyGtlMQZndD7OpVMUqkxf
         ujCcgBKV07KoEY+o5/mhRjd73KQ9dWEP+hmcQKfXkHhFAZ1XNN0fGyoZnxHkbsu88+sn
         8lvQm8htMqVBM0hG7aWzCt033g/y/7vr1Czmhv/KZdJ/bK4XwBdgY+WsQfyhqaUxxjyY
         dRKw/JeQYZQbVll4ErYUno2Ehsq+rsYtZVpf3wFgpjaG9klHpTfc9KR6SCyflWlpIlk2
         B5vQoF4UbrZ5PCH2uVZAbJOq/IF750iBYkCIeSUOWVnEMaA6C/Rt/PEpG8GNMQXdX0JH
         6pGw==
X-Gm-Message-State: AOAM532AX5lBIoKg1mzanmxS8QjetBMpg4CevzIhYS0AdDyslJhMF1hz
        dA7V6WVuZmnxa7sxwt4MJjsJWZyYrrCrxJ3d9VHm8g==
X-Google-Smtp-Source: ABdhPJxKXPQWKZYVNFugMmvukgwEvPM1+RUaAfvu87Y0aIiNAm/MX3SlelYUjvZdxUxr63cktsycKHW5sNSqYYm9sU0=
X-Received: by 2002:aa7:90c8:0:b029:32c:935f:de5f with SMTP id
 k8-20020aa790c80000b029032c935fde5fmr6578542pfk.79.1628190340250; Thu, 05 Aug
 2021 12:05:40 -0700 (PDT)
MIME-Version: 1.0
References: <a565cb1662d2f8300905a369c575e19176fd8e4c.1628148418.git.xji@analogixsemi.com>
In-Reply-To: <a565cb1662d2f8300905a369c575e19176fd8e4c.1628148418.git.xji@analogixsemi.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Thu, 5 Aug 2021 21:05:29 +0200
Message-ID: <CAG3jFyuGJZ4ig6nFxXJJ0d-7ob2+=po2cxSuN29wedV5xVE+gA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] drm/bridge: anx7625: Tune K value for IVO panel
To:     Xin Ji <xji@analogixsemi.com>
Cc:     Nicolas Boichat <drinkcat@google.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>, Torsten Duwe <duwe@lst.de>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bernie Liang <bliang@analogixsemi.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devel@driverdev.osuosl.org, Qilin Wen <qwen@analogixsemi.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Xin,

Thanks for submitting this.

On Thu, 5 Aug 2021 at 09:31, Xin Ji <xji@analogixsemi.com> wrote:
>
> IVO panel require less input video clock variation than video clock
> variation in DP CTS spec.
>
> This patch decreases the K value of ANX7625 which will shrink eDP Tx
> video clock variation to meet IVO panel's requirement.
>
> Signed-off-by: Xin Ji <xji@analogixsemi.com>
> ---
>  drivers/gpu/drm/bridge/analogix/anx7625.c | 17 ++++++++++++++---
>  drivers/gpu/drm/bridge/analogix/anx7625.h |  4 +++-
>  2 files changed, 17 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
> index a3d82377066b..ceed1c7f3f28 100644
> --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> @@ -384,6 +384,18 @@ static int anx7625_odfc_config(struct anx7625_data *ctx,
>         return ret;
>  }
>
> +static int anx7625_set_k_value(struct anx7625_data *ctx)

Pardon my ignorance, but I don't know what a K-value is. Could you add
a comment detailing
what the K-value does?

> +{
> +       struct edid *edid = (struct edid *)ctx->slimport_edid_p.edid_raw_data;
> +
> +       if (edid->mfg_id[0] == IVO_MID0 && edid->mfg_id[1] == IVO_MID1)
> +               return anx7625_reg_write(ctx, ctx->i2c.rx_p1_client,
> +                                        MIPI_DIGITAL_ADJ_1, 0x3B);
> +
> +       return anx7625_reg_write(ctx, ctx->i2c.rx_p1_client,
> +                                MIPI_DIGITAL_ADJ_1, 0x3D);
> +}
> +
>  static int anx7625_dsi_video_timing_config(struct anx7625_data *ctx)
>  {
>         struct device *dev = &ctx->client->dev;
> @@ -470,9 +482,8 @@ static int anx7625_dsi_video_timing_config(struct anx7625_data *ctx)
>                         MIPI_PLL_N_NUM_15_8, (n >> 8) & 0xff);
>         ret |= anx7625_reg_write(ctx, ctx->i2c.rx_p1_client, MIPI_PLL_N_NUM_7_0,
>                         (n & 0xff));
> -       /* Diff */
> -       ret |= anx7625_reg_write(ctx, ctx->i2c.rx_p1_client,
> -                       MIPI_DIGITAL_ADJ_1, 0x3D);
> +       /* Diff and K value */

With a proper comment above, this comment is no longer needed.

> +       anx7625_set_k_value(ctx);
>
>         ret |= anx7625_odfc_config(ctx, post_divider - 1);
>
> diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.h b/drivers/gpu/drm/bridge/analogix/anx7625.h
> index 034c3840028f..6dcf64c703f9 100644
> --- a/drivers/gpu/drm/bridge/analogix/anx7625.h
> +++ b/drivers/gpu/drm/bridge/analogix/anx7625.h
> @@ -210,7 +210,9 @@
>  #define  MIPI_VIDEO_STABLE_CNT           0x0A
>
>  #define  MIPI_LANE_CTRL_10               0x0F
> -#define  MIPI_DIGITAL_ADJ_1   0x1B
> +#define  MIPI_DIGITAL_ADJ_1     0x1B
> +#define  IVO_MID0               0x26
> +#define  IVO_MID1               0xCF
>
>  #define  MIPI_PLL_M_NUM_23_16   0x1E
>  #define  MIPI_PLL_M_NUM_15_8    0x1F
> --
> 2.25.1
>

LGTM with the above fix.

Reviewed-by: Robert Foss <robert.foss@linaro.org>
