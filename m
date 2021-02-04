Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B903030F2D8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 13:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235817AbhBDMGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 07:06:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235613AbhBDMGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 07:06:08 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65642C061573
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 04:05:28 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id j11so1634814plt.11
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 04:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3gCwnJ3I9TFynlXEE8EgeDSc39OV8tdTTKcZtSs6Ob4=;
        b=pMVNR9XQ5X8T87rmsm48JCoslRIqG0EnlWBjAb6WHAvZOeIxyj2TRJh9wRqraexw/g
         ziQJ35MJ8oLcyIL8gD73cX9x0S3QP3ZHCsXx1d9apIGe3IP2QhCrsODgomRmEuF/BM/s
         TNiQTIGJWqXuqvTeF8rUedp93b/6llTNJfLExHC8WCB/2nLPdtBDEzD/KoXxLR2diMwW
         cTtzZ8waYaNGVVS0S52ML3lY5B8vxdKUH8BHnp8l6/zclOWgJOio+28qUntlf8pp+Z+L
         xn1NRzQ4BguP4n7giKheAxDsLeSPx5BnXRz9nbMgO81daLgjLIeuHQOF9gfltTISKdTl
         8xxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3gCwnJ3I9TFynlXEE8EgeDSc39OV8tdTTKcZtSs6Ob4=;
        b=rcQs9VETNSW/mo1U4zdM8BkI8i7cIC7RW+Bkm/H8FlxkGvqkyus79P6l38/uKIli6I
         06QN4iYU0L94tFT6g9NUv+Uv4wweaB/sVk3HyyZm1GxdInWVZYl7Td6IohBI5EH/2Pm7
         uagNhAJ3f39Oc+u4TRuDCaPj2+oU3kw/oOsV2W7Ltt0+D15Md4Lsgff+NcwP83xJ/eRz
         /we9STFn4YjA8wpXZHoKKcRGwG5XsT6Fq2wgnAvDi4iUiu95+i1TnS46/zZ1Yyoi4r2N
         DquDpXYvzt30x/O1nO71Hom2y7wsmAjLDOapilmZhJuk0sxnsPtWn0woqZsU2WN0tbBX
         AvJA==
X-Gm-Message-State: AOAM530uVfVk7FnSC2bQVl/NHmApqqxHz1bm2ndCTM6oBJ+gYwbhN23H
        IG/vkb2pl4ZUJLTJ3Qe8GPpUBBcywiI2cavzJBtjgg==
X-Google-Smtp-Source: ABdhPJwzDbuoQicSrDC63yyRE+e3cv4bXJqhpUMqxqgXg7BPyh+dk863cUQABNYOGRT+4bP925wm4mKt33lqmX4ll5A=
X-Received: by 2002:a17:90a:4ecb:: with SMTP id v11mr8360759pjl.75.1612440327917;
 Thu, 04 Feb 2021 04:05:27 -0800 (PST)
MIME-Version: 1.0
References: <20210128111549.GA8174@zhaomy-pc>
In-Reply-To: <20210128111549.GA8174@zhaomy-pc>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Thu, 4 Feb 2021 13:05:16 +0100
Message-ID: <CAG3jFysU4epjS3A85ZojrJn3TAC78O_jx5p_4SWsCdRBrQ5GXQ@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: anx7625: enable DSI EOTP
To:     Xin Ji <xji@analogixsemi.com>
Cc:     Nicolas Boichat <drinkcat@google.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>, Torsten Duwe <duwe@lst.de>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sheng Pan <span@analogixsemi.com>,
        dri-devel@lists.freedesktop.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devel@driverdev.osuosl.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xin,

Thanks for the patch.

On Thu, 28 Jan 2021 at 12:17, Xin Ji <xji@analogixsemi.com> wrote:
>
> Enable DSI EOTP feature for fixing some panel screen constance
> shift issue.
> Removing MIPI flag MIPI_DSI_MODE_EOT_PACKET to enable DSI EOTP.

I don't think I quite understand how removing the
MIPI_DSI_MODE_EOT_PACKET flag will cause DSI EOTP to be enabled. Could
you extrapolate on this in the commit message?

>
> Signed-off-by: Xin Ji <xji@analogixsemi.com>
> ---
>  drivers/gpu/drm/bridge/analogix/anx7625.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
> index 65cc059..e31eeb1b 100644
> --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> @@ -1334,7 +1334,6 @@ static int anx7625_attach_dsi(struct anx7625_data *ctx)
>         dsi->format = MIPI_DSI_FMT_RGB888;
>         dsi->mode_flags = MIPI_DSI_MODE_VIDEO   |
>                 MIPI_DSI_MODE_VIDEO_SYNC_PULSE  |
> -               MIPI_DSI_MODE_EOT_PACKET        |
>                 MIPI_DSI_MODE_VIDEO_HSE;
>
>         if (mipi_dsi_attach(dsi) < 0) {
> --
> 2.7.4
>
