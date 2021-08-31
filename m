Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8BA93FC9A7
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 16:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234726AbhHaOXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 10:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbhHaOXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 10:23:51 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9B2C061575
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 07:22:56 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id j4-20020a17090a734400b0018f6dd1ec97so2543387pjs.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 07:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=agCwJbjopXjgdjmt4UnQYJb9rZ+TRxYP+Vp/4vfg7+k=;
        b=xUfPT7uqyNTLbSkt8EJkfnL621vuvL4YaeyQMQcEyMiFDL4/I5sTnl5XcQ5k3PpyE9
         Rjs+X9He+NEyKrm3YHptM2QT7wsAMniI7Dk5IXuxP0CgeoQzedp6hG4mkDvWv6vYUdjD
         uoO9n4eDgTjDFTzMOizrpN9LrpGx6wRzgNrSmrwXzhRsgt43uULPFtYQRHdmG9OgSnST
         6NZ2aINyRolFvpynKmPIPcfSQ8OCvenMfgfOdK8upQh+Te0gCDws+NKP/ZLTJ6NpfhPY
         j113oi2x/NWHM4B6HltsQfeuRoVdi22TthwV51cFm5KQ0w8WMCejRSd8q8OxFu3lhJ2o
         4VQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=agCwJbjopXjgdjmt4UnQYJb9rZ+TRxYP+Vp/4vfg7+k=;
        b=k5kMxy48FmGJzf6RQtL1/c7e3VU6r2I/n7y/3Em/HKUCWhDTKY8DYawlSmz6Zl5e1A
         2R0xPrAP2FCc7feo0xgWx9HeMNfdMzew19OMqojBrO7z5KAtISQvrUPIO43E0KUfSj9f
         JrVz82KQL+ZthdP7EYUOEG0uL3aGtr3um+6ScHslbd1WK9u8NMbu/j5PypNKmNtxrU7+
         rh99dr4uFs9I/IVn+zoN3m+lnuCPezM+N9factoKwIUlcQEk591E31sKLaPQseY5KjvP
         p9nhaYTAFo005V4H+yJdiI1/+74ylMt84hYYTzXR5jb12ov860edrJt0idmHBvVNswbg
         ai3w==
X-Gm-Message-State: AOAM533wHdTRE3dbAPE6xU8NI1T8M8SxGDYjWOQzZcPFCIea48rQEvpU
        7R9A6FsBVrfWC55ylQ3sSjUocP17d5MrAmCnGIx4enI1z24=
X-Google-Smtp-Source: ABdhPJxRfsG7ydqj58dpKD9O7I8cMNgCJ98STKID3Y4Eep+EHuVwC6xKW+BLX4aQHDJ5ezz2uuvo491L64pugzlwrjE=
X-Received: by 2002:a17:90b:4c8b:: with SMTP id my11mr5588645pjb.220.1630419775900;
 Tue, 31 Aug 2021 07:22:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210827163956.27517-1-paul@crapouillou.net> <27e68baf-5797-9c66-37b2-382cb8792467@baylibre.com>
In-Reply-To: <27e68baf-5797-9c66-37b2-382cb8792467@baylibre.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Tue, 31 Aug 2021 16:22:44 +0200
Message-ID: <CAG3jFytAdkt5DDzsm9T+buAL0vqS-X4M66aNyOaB8=5N3CbKWg@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/bridge: it66121: Initialize {device,vendor}_ids
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Paul Cercueil <paul@crapouillou.net>, Phong LE <ple@baylibre.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, list@opendingux.net,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Aug 2021 at 11:40, Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> On 27/08/2021 18:39, Paul Cercueil wrote:
> > These two arrays are populated with data read from the I2C device
> > through regmap_read(), and the data is then compared with hardcoded
> > vendor/product ID values of supported chips.
> >
> > However, the return value of regmap_read() was never checked. This is
> > fine, as long as the two arrays are zero-initialized, so that we don't
> > compare the vendor/product IDs against whatever garbage is left on the
> > stack.
> >
> > Address this issue by zero-initializing these two arrays.
> >
>
> Fixes: 988156dc2fc9 ("drm: bridge: add it66121 driver")
>
> > Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> > ---
> >  drivers/gpu/drm/bridge/ite-it66121.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
> > index 2f2a09adb4bc..b130d01147c6 100644
> > --- a/drivers/gpu/drm/bridge/ite-it66121.c
> > +++ b/drivers/gpu/drm/bridge/ite-it66121.c
> > @@ -889,7 +889,7 @@ static irqreturn_t it66121_irq_threaded_handler(int irq, void *dev_id)
> >  static int it66121_probe(struct i2c_client *client,
> >                        const struct i2c_device_id *id)
> >  {
> > -     u32 vendor_ids[2], device_ids[2], revision_id;
> > +     u32 revision_id, vendor_ids[2] = { 0 }, device_ids[2] = { 0 };
> >       struct device_node *ep;
> >       int ret;
> >       struct it66121_ctx *ctx;
> >
>
> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>

Applied series to drm-misc-next.
