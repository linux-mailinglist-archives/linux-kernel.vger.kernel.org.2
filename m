Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE3D45C720
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 15:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356094AbhKXOV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 09:21:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357476AbhKXOUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 09:20:18 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6A5C0E4880
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 04:39:56 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id v19so1739546plo.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 04:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lMFICmq1b+/JqHXnwVNpy/lNHjIXGz9n5dRmdIrsjj4=;
        b=BWH1E2DUIhqLlVJHGrhMUVKBs2n/zeDD5VZuPP0uGwx0Zq+LEMVtgXS7oF3eSxyv9+
         VHsRneraaYkRPuxjFq2y6gvkaWBpTsnQk5vY/1pkDTgccpvxdeduG6bIZ5qqqzUVN5A8
         /2pgwJt0+NjD9cveA4naQJ0xa32z2VngFdC8hfHSOSNVu4m8ugmTdge3Zq9pdpeqFz/+
         ckX8Qzmb40/v9+ueRLKN4zCIhhMJxz48O/UpVnCp5BWz1GWoKmgIXIfFyZBCKmgpzBZC
         JxGwt8B3ucwMwcGGkjlpBcWGsHqMQyc/W0lEKnDfAbGxlF97xXeS9coOTdO31vwfIzDY
         /4Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lMFICmq1b+/JqHXnwVNpy/lNHjIXGz9n5dRmdIrsjj4=;
        b=6ro7eRjCWhLWwM+v47xv1/970lURwRuTqydoU0KJEpvkD2W/7oAFUurGDRhY5xwALS
         y5ltygiIgKVdkTb19M9WFiwaxOu+MzBwvYSq3a6ifkLn4D3HXsFG11FvMpVTGeo7wqOh
         0s1t5dThUwXRJrzvl0o4p7hOHFU7NV1IYj6gVhgRtLxif4+1H2R2NfBGADd/WCXB1lrH
         Jb/W3B0Si8Lhv7ufW9b96ycVzEDFblptMa9GtaAbce694/0FHYmg9uS8K6m9tiPwPVOm
         3Qoi9FKKEmFDztXNGRGff8/DiGuEKMJoKclvsw2rJBHf4myOtt1GJZvzaNXq/OtgG2N+
         Jq/g==
X-Gm-Message-State: AOAM532hRIbZYXFGHBT7pfU+rWou2kwa/pQaxL/d/O15Z770O6BDSumg
        XciJuOaxmUZ7pPecSJN/ZV9GfPrXlAYcyzxYXrQZug==
X-Google-Smtp-Source: ABdhPJyDLVIppheFrvbGjpHZVBjEkgj1stb+v8Y6ldPVozNLNACR1bfimZTh8WnjRo77xRtzdL9Z0DU7pTOxDlcd5Sk=
X-Received: by 2002:a17:902:d505:b0:141:f5f7:848e with SMTP id
 b5-20020a170902d50500b00141f5f7848emr18120813plg.72.1637757595783; Wed, 24
 Nov 2021 04:39:55 -0800 (PST)
MIME-Version: 1.0
References: <20211118193002.407168-1-hsinyi@chromium.org> <20211119015453.GB3823948@anxtwsw-Precision-3640-Tower>
In-Reply-To: <20211119015453.GB3823948@anxtwsw-Precision-3640-Tower>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Wed, 24 Nov 2021 13:39:44 +0100
Message-ID: <CAG3jFytd0PXYNB_2NUcyr2pD1xJ-YJkDSqiSivbiPStV0s_qtw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/bridge: anx7625: Fix edid_read break case in sp_tx_edid_read()
To:     Xin Ji <xji@analogixsemi.com>
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux@roeck-us.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Nov 2021 at 02:55, Xin Ji <xji@analogixsemi.com> wrote:
>
> On Fri, Nov 19, 2021 at 03:30:02AM +0800, Hsin-Yi Wang wrote:
> > edid_read() was assumed to return 0 on success. After
> > 7f16d0f3b8e2("drm/bridge: anx7625: Propagate errors from sp_tx_rst_aux()"),
> > the function will return > 0 for successful case, representing the i2c
> > read bytes. Otherwise -EIO on failure cases. Update the g_edid_break
> > break condition accordingly.
> Hi Hsin-Yi, thanks for the patch!
> Reviewed-by: Xin Ji <xji@analogixsemi.com>
> >
> > Fixes: 7f16d0f3b8e2("drm/bridge: anx7625: Propagate errors from sp_tx_rst_aux()")
> > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > Reviewed-by: Robert Foss <robert.foss@linaro.org>
> > ---
> > v2: Fix type error.
> > ---
> >  drivers/gpu/drm/bridge/analogix/anx7625.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
> > index 1a871f6b6822ee..3a18f1dabcfd51 100644
> > --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> > +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> > @@ -795,7 +795,7 @@ static int sp_tx_edid_read(struct anx7625_data *ctx,
> >       int count, blocks_num;
> >       u8 pblock_buf[MAX_DPCD_BUFFER_SIZE];
> >       u8 i, j;
> > -     u8 g_edid_break = 0;
> > +     int g_edid_break = 0;
> >       int ret;
> >       struct device *dev = &ctx->client->dev;
> >
> > @@ -826,7 +826,7 @@ static int sp_tx_edid_read(struct anx7625_data *ctx,
> >                               g_edid_break = edid_read(ctx, offset,
> >                                                        pblock_buf);
> >
> > -                             if (g_edid_break)
> > +                             if (g_edid_break < 0)
> >                                       break;
> >
> >                               memcpy(&pedid_blocks_buf[offset],
> > --

Fixed commit id syntax of commit message in order to make checkpatch
--strict happy.

Applied to drm-misc-next.
