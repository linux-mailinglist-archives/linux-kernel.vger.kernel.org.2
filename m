Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBF63E2791
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 11:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244637AbhHFJmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 05:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242680AbhHFJmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 05:42:53 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5312C061798
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 02:42:37 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id i10so6358254pla.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 02:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4HPNOHJF+FggNfCJseeN2/kUR7mznmygd2VV7qNoCFg=;
        b=SXu8xId+7S96lozM+9jNDTE8KKNGlgx6uPoKWwz+WwXMvz1d0rTofjoV4SQCFfBnSZ
         LTuYpkQ0CveluxulWfcAhp7m4fWmgzDpBIdavDKgZxUWtxzkDRb3q8BfjRwEcApD9YHh
         yJGyg9XNka6qwhtKSbTE7OZ0NRcPB3y6hgI4TbrUCKYm6diWoiNap6rtWPQQ/SmhTcUm
         BSlATxLy43GGhqInxcGTKxazNRM1Zg//uB/Jj7C4m/JnBpihK0FRyTFLTkq6UjMmbYXo
         m3jUv43U/G6Dkbjs3xy3kvWsunCj/DdxViD6qYM+wt+FTFCXB+AR2t9X2xTnai+47F9a
         0Nrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4HPNOHJF+FggNfCJseeN2/kUR7mznmygd2VV7qNoCFg=;
        b=aMbxli9mvvNc+0QmU3AlP3uO1yX+MpUVmoosmAulQbs5A4B/RNsXL9pP4g/67e+Epm
         728ZVvpfior782vSa6JKm8odHxZGmIpnWVUyK9+4bunBUZ3lupK0t4Sdahp8DYQqExU/
         OpRCSKv/RfiKQSQc+ytCB+cCyzzkev6KTd9MujmXf2CfeAxcrFgzkdb1KFYqrhdjwzmw
         c3f4Hd95j1THyD3127MYzzn2zgHtfI/Y5k4eAFV2uzFeuqUfM8CcGrJev6/wIj3TArxR
         FCuCKQdsMegeEs9lyEuir3eoOjwbdwTZnxyF2CVI3tgExtG9brhaYc0I5A3bdnxKQb4E
         tEvA==
X-Gm-Message-State: AOAM533dNXuuuNpe3kXmBalnqnDGW4zZ7BgbjyPxzfS9GUnWSn/mDpuV
        gLs5HTI+5Na7ytlURuuN9XYrnE/A998XcFtmnkZwCA==
X-Google-Smtp-Source: ABdhPJx+BDp+a/3ncBTlo6vu6+TXRvbaFZ9ImUS/1LbApSXQDKjL8eqWP8K5L9x04aHKdfGndP9XdWO+I9CX1KGMutQ=
X-Received: by 2002:aa7:90c8:0:b029:32c:935f:de5f with SMTP id
 k8-20020aa790c80000b029032c935fde5fmr9660331pfk.79.1628242957366; Fri, 06 Aug
 2021 02:42:37 -0700 (PDT)
MIME-Version: 1.0
References: <a02c0a414bd3d0f67bf7d77c10415196743f1c0d.1628242192.git.xji@analogixsemi.com>
In-Reply-To: <a02c0a414bd3d0f67bf7d77c10415196743f1c0d.1628242192.git.xji@analogixsemi.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Fri, 6 Aug 2021 11:42:26 +0200
Message-ID: <CAG3jFyvTsG1ZjqS+3yqspW+DCPX4zrs02tdmqC9n9mQxmvsJEQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] drm/bridge: anx7625: Tune K value for IVO panel
To:     Xin Ji <xji@analogixsemi.com>
Cc:     Nicolas Boichat <drinkcat@google.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>, Torsten Duwe <duwe@lst.de>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bernie Liang <bliang@analogixsemi.com>,
        Qilin Wen <qwen@analogixsemi.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devel@driverdev.osuosl.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Xin,

Thanks for implementing the suggestion so quickly.

Can you send this version of the patch out as v2? Versioning is
important and both tools and processes break if different versions
aren't submitted in different emails.

On Fri, 6 Aug 2021 at 11:35, Xin Ji <xji@analogixsemi.com> wrote:
>
> IVO panel require less input video clock variation than video clock
> variation in DP CTS spec.
>
> This patch decreases the K value of ANX7625 which will shrink eDP Tx
> video clock variation to meet IVO panel's requirement.
>
> Acked-by: Sam Ravnborg <sam@ravnborg.org>
> Signed-off-by: Xin Ji <xji@analogixsemi.com>
> ---
>  drivers/gpu/drm/bridge/analogix/anx7625.c | 24 ++++++++++++++++++++---
>  drivers/gpu/drm/bridge/analogix/anx7625.h |  4 +++-
>  2 files changed, 24 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
> index a3d82377066b..9b9e3984dd38 100644
> --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> @@ -384,6 +384,25 @@ static int anx7625_odfc_config(struct anx7625_data *ctx,
>         return ret;
>  }
>
> +/*
> + * The MIPI source video data exist large variation (e.g. 59Hz ~ 61Hz),
> + * anx7625 defined K ratio for matching MIPI input video clock and
> + * DP output video clock. Increase K value can match bigger video data
> + * variation. IVO panel has small variation than DP CTS spec, need
> + * decrease the K value.
> + */
> +static int anx7625_set_k_value(struct anx7625_data *ctx)
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
> @@ -470,9 +489,8 @@ static int anx7625_dsi_video_timing_config(struct anx7625_data *ctx)
>                         MIPI_PLL_N_NUM_15_8, (n >> 8) & 0xff);
>         ret |= anx7625_reg_write(ctx, ctx->i2c.rx_p1_client, MIPI_PLL_N_NUM_7_0,
>                         (n & 0xff));
> -       /* Diff */
> -       ret |= anx7625_reg_write(ctx, ctx->i2c.rx_p1_client,
> -                       MIPI_DIGITAL_ADJ_1, 0x3D);
> +
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
