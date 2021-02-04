Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A67230F340
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 13:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236043AbhBDMf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 07:35:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235777AbhBDMf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 07:35:26 -0500
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC0FC061573
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 04:34:45 -0800 (PST)
Received: by mail-vs1-xe32.google.com with SMTP id n18so1626382vsa.12
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 04:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cJd9FKa1a551Lyef6CfNIDn2oz8BtNjwZF6tWhdERIY=;
        b=Xzw+OgQoMx4trTdOG7xobK372anzs7OyIMUdScK7DPaq+0hgLQQ1NFI4Qx2Tuok4J6
         hAkqvhjsZh+LCLA0a0er2430U3EVnT7T5bdWQvCtekJ53Lhoac45JBKPCr8zLXCyqnY7
         xlXP068fErj3w2dS0S9kwb6OCNpntevlsAVnk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cJd9FKa1a551Lyef6CfNIDn2oz8BtNjwZF6tWhdERIY=;
        b=d6bEgBsGoJgyTocDks5sBCi8QIZaGkphtahtp3Rn5MA+r0Gzaw9yknc0GgbR7o/xgw
         9YPq5qqQKcXHagHHuSY+URqhOa7MLREB+cs6QwYs6pYYiPGA8zzN6YCbCrmRwbCpnbXe
         lViJ7UQV8CPceknPvtKca98OIpN24cXRfytZ7JOKJdSJ6cSyuGDdQzZG6K9fU1s4ratc
         0naELDbGQnN9OpP+QvQIqi1jbBIRDiMCk7+xh3E53eNvRtPYYEiopkZJQ9ANgRkocOey
         l/ej1ScICRMbBXLOFhne+kcVvbFA9tfiY6ghX8Z3feB9KGzz0agknLGY85ECcSz4sE9d
         E48w==
X-Gm-Message-State: AOAM531pXcjjhWIk0EvmTCcQY+lN9hnRJEg0r+EOn8v00v7Yqxf2Dchf
        mXEDBqnzq0dM8xxPf/wlthvwwNISY8KpWdeNb4usow==
X-Google-Smtp-Source: ABdhPJzGdlYykvQ6K2WLJtushykS2XRoEspc46YEBzHBjnOeFCMTRStUy8XPadrULy6Vqn8znu7NjaabkXzJbd3THdE=
X-Received: by 2002:a67:8945:: with SMTP id l66mr4678569vsd.48.1612442084863;
 Thu, 04 Feb 2021 04:34:44 -0800 (PST)
MIME-Version: 1.0
References: <20210128111549.GA8174@zhaomy-pc> <CAG3jFysU4epjS3A85ZojrJn3TAC78O_jx5p_4SWsCdRBrQ5GXQ@mail.gmail.com>
In-Reply-To: <CAG3jFysU4epjS3A85ZojrJn3TAC78O_jx5p_4SWsCdRBrQ5GXQ@mail.gmail.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Thu, 4 Feb 2021 20:34:33 +0800
Message-ID: <CANMq1KAuUTqgM2mDR5WN6Ad+cATFXLPE+5rstyhfNE9Lc716+g@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: anx7625: enable DSI EOTP
To:     Robert Foss <robert.foss@linaro.org>
Cc:     Xin Ji <xji@analogixsemi.com>,
        Nicolas Boichat <drinkcat@google.com>,
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
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devel@driverdev.osuosl.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 4, 2021 at 8:07 PM Robert Foss <robert.foss@linaro.org> wrote:
>
> Hi Xin,
>
> Thanks for the patch.
>
> On Thu, 28 Jan 2021 at 12:17, Xin Ji <xji@analogixsemi.com> wrote:
> >
> > Enable DSI EOTP feature for fixing some panel screen constance
> > shift issue.
> > Removing MIPI flag MIPI_DSI_MODE_EOT_PACKET to enable DSI EOTP.
>
> I don't think I quite understand how removing the
> MIPI_DSI_MODE_EOT_PACKET flag will cause DSI EOTP to be enabled. Could
> you extrapolate on this in the commit message?

That confused me as well, but it turns out that's how the flag is defined:
```
/* disable EoT packets in HS mode */
#define MIPI_DSI_MODE_EOT_PACKET BIT(9)
```
(https://elixir.bootlin.com/linux/latest/source/include/drm/drm_mipi_dsi.h#L129)

I'm almost tempted to put together a mass patch to rename all of these flags...

>
> >
> > Signed-off-by: Xin Ji <xji@analogixsemi.com>
> > ---
> >  drivers/gpu/drm/bridge/analogix/anx7625.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
> > index 65cc059..e31eeb1b 100644
> > --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> > +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> > @@ -1334,7 +1334,6 @@ static int anx7625_attach_dsi(struct anx7625_data *ctx)
> >         dsi->format = MIPI_DSI_FMT_RGB888;
> >         dsi->mode_flags = MIPI_DSI_MODE_VIDEO   |
> >                 MIPI_DSI_MODE_VIDEO_SYNC_PULSE  |
> > -               MIPI_DSI_MODE_EOT_PACKET        |
> >                 MIPI_DSI_MODE_VIDEO_HSE;
> >
> >         if (mipi_dsi_attach(dsi) < 0) {
> > --
> > 2.7.4
> >
