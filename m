Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4371C392DB3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 14:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235143AbhE0MMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 08:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235031AbhE0MMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 08:12:34 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD87C061574
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 05:11:00 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 6so3544215pgk.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 05:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oRhOKDNCOPh50Z/aFWDPzmEZC3yRRNIu9ormTXELjPU=;
        b=FAtHvEHXffBJBOCgQsvJa5akS5Nglw9bWWCOVrq4tcCcg56lvMMxOowZje89pRhld5
         /c8grAu+6J5TfmjOPe7da67YYS7LaYbFWgkYRIPqX9O+tqYiFqfZbfMzcM6UxJUOt+zO
         FmIUWqnkMURbc5YamnxktnGwtz/QS0O07i8B3J7PyXQTbNMD9/t23e3UEt/wJ3m7RxWe
         IEoMJmbe/P+BxFd1Ce6vvW3vAQ6OqG2sb9YGAjKykheU6Q+0Q7jSuxQDLzOWCPj+QPeT
         EZpfZF/T5brTa2jKcbHX5vc96olSdqvgBBaHH6X97bStJ84eojoH9IPstHB9lxYkPjqU
         zP6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oRhOKDNCOPh50Z/aFWDPzmEZC3yRRNIu9ormTXELjPU=;
        b=hHHGWHWcBINhvGi9nrYaR35KtzraC5vVu5TX1Yqv7QxRkHCwEHMhfY/6lRAFj/rU+R
         soBTEG0W1FKNormFIUFORPZ8oJ1KWfep+w5pby5k7f0wkYTeEmJhUyBQo09Umu7L6aaI
         eqYHKFv2AFTVBbVfWK63jh00iT5wQXHl4eJSGPDJ3+DQJ5mLZVPkh6aDETEactpP4UKL
         Bn7kfsWX7Gep45mPKQNUyHLZMLASvW0msJTiNz0uZyJcx4pf3XmZkB+8EEiPZ17lo90n
         XlLlwW7xGV2P8yU36JpXOfs7ca+ntAifPTT83MGO1C/1zEIFaRhedy477f9D4MtNd5bX
         Rm2g==
X-Gm-Message-State: AOAM531bIF/mzclhwH69Eo0YgQQLFIjuvHjFjsYzEDMRQsIX66lRczDV
        Dwy0/UShPgARO0lKB5627zJz0pHqtWfHMgkMLZz2eg==
X-Google-Smtp-Source: ABdhPJwyrVAU5VpztJZBZHZ+lAWPAAKCkinkA93Nd0vesd87KBbFlG9BIMaHP3lTMMMgQZJDGsQJmZeEH33Mvf9+32w=
X-Received: by 2002:a63:4e01:: with SMTP id c1mr3455280pgb.265.1622117459824;
 Thu, 27 May 2021 05:10:59 -0700 (PDT)
MIME-Version: 1.0
References: <d107d1840b83607baee8571cc5d88973fc32b519.1622015323.git.geert+renesas@glider.be>
 <d728f168-8e36-44e4-0d9a-a52572ed1c1b@collabora.com>
In-Reply-To: <d728f168-8e36-44e4-0d9a-a52572ed1c1b@collabora.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Thu, 27 May 2021 14:10:48 +0200
Message-ID: <CAG3jFyttwK728aXzAVHai2aSWmP2iy6eVwXn8ojOJdPGQ=GSMA@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: DRM_CROS_EC_ANX7688 should depend on I2C_CROS_EC_TUNNEL
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pushed to drm-misc-next.

On Thu, 27 May 2021 at 13:07, Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Hi Geert,
>
> Thank you for your patch.
>
> On 26/5/21 9:50, Geert Uytterhoeven wrote:
> > The ChromeOS EC ANX7688 bridge is connected to a ChromeOS Embedded
> > Controller, and is accessed using I2C tunneling through the Embedded
> > Controller.  Hence add a dependency on I2C_CROS_EC_TUNNEL, to prevent
> > asking the user about this driver when configuring a kernel without
> > support for the ChromeOS EC tunnel I2C bus.
> >
> > Fixes: 44602b10d7f2a5f7 ("drm/bridge: Add ChromeOS EC ANX7688 bridge driver support")
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>
> > ---
> >  drivers/gpu/drm/bridge/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> > index 7e7f28eb954661e2..c96e4b38d1d34ee6 100644
> > --- a/drivers/gpu/drm/bridge/Kconfig
> > +++ b/drivers/gpu/drm/bridge/Kconfig
> > @@ -53,6 +53,7 @@ config DRM_CHRONTEL_CH7033
> >  config DRM_CROS_EC_ANX7688
> >       tristate "ChromeOS EC ANX7688 bridge"
> >       depends on OF
> > +     depends on I2C_CROS_EC_TUNNEL || COMPILE_TEST
> >       select DRM_KMS_HELPER
> >       select REGMAP_I2C
> >       help
> >
