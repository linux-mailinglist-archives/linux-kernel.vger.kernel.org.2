Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFDCC310015
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 23:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbhBDWZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 17:25:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbhBDWZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 17:25:55 -0500
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E23C0613D6
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 14:25:15 -0800 (PST)
Received: by mail-vs1-xe31.google.com with SMTP id u127so2581989vsc.10
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 14:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=31jUhQb4QgBdzmAxm7WR6grUlNAOknQ+++TxEZo30Ts=;
        b=AEZu9A+PtNGkoSHnMDnQwaWORrLt+lZB4uI7bD12xs19pXOqzYGftocfVpVi11/2nP
         vGMjloHYJP6gHbtTCqiJdG43ZiNRd4E9FAPpeKv8FzMPLwiDADgf6jzi9rOvvrBvPfa3
         iNF6k3j71vTvOITaT7d/322ce5rE0H+3Oh0Go=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=31jUhQb4QgBdzmAxm7WR6grUlNAOknQ+++TxEZo30Ts=;
        b=JaYJ48Ynkq7erxGqpJXkzCPaVLUJmK6pzDVg8aqNpv0dP2FarD/Kxojb3NfMawjdzW
         +r7Hqp3PhV6ooaLkuZV/eB5jHzQzYynQdjSnKTsGmCIDfMRWt7pRNTnfe4Aadk68zVZw
         QB2H2rh8T5CKxVwCap7HTkZrILnU/2Z5ptkNMYULr049gryKl4Yh8xYWv5fkGHoXMmXw
         FQd1/Kp/jkKg/yst85zrgmp67Q+0QEYaRyaIitRCGA0c9j4xvpBPUpXFZjxkZsUeJKkm
         t+GEznXaQjmsY0tIm2cnsP5JfxuJk12JOcJRwe4JZuVmKv4GqAtBN3w86JE9ykuvMyKo
         utPg==
X-Gm-Message-State: AOAM532KG2qCkrT/snf2WX0BFkVnidNW405wRkHxsjpT7V/7p9BN1JbR
        zksSaF4COlBqv+rfBg+Vk/CnusSl5FvaKgr4C2QZLQ==
X-Google-Smtp-Source: ABdhPJyMpXvwQyrCOQjc4jvN2lm7zHDjPIYpmEmeanwteLDdiY63Jm6FlPAvp99+wgnb/9zVDISwMQgWlH5CvnpGXkc=
X-Received: by 2002:a67:6b46:: with SMTP id g67mr1153931vsc.60.1612477514078;
 Thu, 04 Feb 2021 14:25:14 -0800 (PST)
MIME-Version: 1.0
References: <20210128111549.GA8174@zhaomy-pc> <CAG3jFysU4epjS3A85ZojrJn3TAC78O_jx5p_4SWsCdRBrQ5GXQ@mail.gmail.com>
 <CGME20210204123452eucas1p1eb8fd9dc5b62b036ebd9e9208e796cb9@eucas1p1.samsung.com>
 <CANMq1KAuUTqgM2mDR5WN6Ad+cATFXLPE+5rstyhfNE9Lc716+g@mail.gmail.com> <b680fef2-7c8a-183b-443a-6b2b9fe595d7@samsung.com>
In-Reply-To: <b680fef2-7c8a-183b-443a-6b2b9fe595d7@samsung.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Fri, 5 Feb 2021 06:25:02 +0800
Message-ID: <CANMq1KAVMhFAdy_s4R-h1yzNWXRgWgZ4s9kQL11LDze3+Qv5_w@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: anx7625: enable DSI EOTP
To:     Andrzej Hajda <a.hajda@samsung.com>
Cc:     Robert Foss <robert.foss@linaro.org>, devel@driverdev.osuosl.org,
        Nicolas Boichat <drinkcat@google.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sheng Pan <span@analogixsemi.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        David Airlie <airlied@linux.ie>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Torsten Duwe <duwe@lst.de>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Sam Ravnborg <sam@ravnborg.org>, Xin Ji <xji@analogixsemi.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 4, 2021 at 8:59 PM Andrzej Hajda <a.hajda@samsung.com> wrote:
>
>
> W dniu 04.02.2021 o 13:34, Nicolas Boichat pisze:
> > On Thu, Feb 4, 2021 at 8:07 PM Robert Foss <robert.foss@linaro.org> wrote:
> >> Hi Xin,
> >>
> >> Thanks for the patch.
> >>
> >> On Thu, 28 Jan 2021 at 12:17, Xin Ji <xji@analogixsemi.com> wrote:
> >>> Enable DSI EOTP feature for fixing some panel screen constance
> >>> shift issue.
> >>> Removing MIPI flag MIPI_DSI_MODE_EOT_PACKET to enable DSI EOTP.
> >> I don't think I quite understand how removing the
> >> MIPI_DSI_MODE_EOT_PACKET flag will cause DSI EOTP to be enabled. Could
> >> you extrapolate on this in the commit message?
> > That confused me as well, but it turns out that's how the flag is defined:
> > ```
> > /* disable EoT packets in HS mode */
> > #define MIPI_DSI_MODE_EOT_PACKET BIT(9)
> > ```
> > (https://protect2.fireeye.com/v1/url?k=5bd95ebd-044267fb-5bd8d5f2-0cc47a3003e8-ce9db8ea264d6901&q=1&e=900556dc-d199-4c18-9432-5c3465a98eae&u=https%3A%2F%2Felixir.bootlin.com%2Flinux%2Flatest%2Fsource%2Finclude%2Fdrm%2Fdrm_mipi_dsi.h%23L129)
> >
> > I'm almost tempted to put together a mass patch to rename all of these flags...
>
>
> Yes that would be good, many of these flags were just copy pasted from
> some hw datasheet, without good analysis how to adapt them to the framework.

I'll look into it (but that shouldn't block this patch).

>
>
> Regards
>
> Andrzej
>
>
> >
> >>> Signed-off-by: Xin Ji <xji@analogixsemi.com>
> >>> ---
> >>>   drivers/gpu/drm/bridge/analogix/anx7625.c | 1 -
> >>>   1 file changed, 1 deletion(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
> >>> index 65cc059..e31eeb1b 100644
> >>> --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> >>> +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> >>> @@ -1334,7 +1334,6 @@ static int anx7625_attach_dsi(struct anx7625_data *ctx)
> >>>          dsi->format = MIPI_DSI_FMT_RGB888;
> >>>          dsi->mode_flags = MIPI_DSI_MODE_VIDEO   |
> >>>                  MIPI_DSI_MODE_VIDEO_SYNC_PULSE  |
> >>> -               MIPI_DSI_MODE_EOT_PACKET        |
> >>>                  MIPI_DSI_MODE_VIDEO_HSE;
> >>>
> >>>          if (mipi_dsi_attach(dsi) < 0) {
> >>> --
> >>> 2.7.4
> >>>
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://protect2.fireeye.com/v1/url?k=457f3f39-1ae4067f-457eb476-0cc47a3003e8-b702072da729d8c9&q=1&e=900556dc-d199-4c18-9432-5c3465a98eae&u=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Fdri-devel
> >
