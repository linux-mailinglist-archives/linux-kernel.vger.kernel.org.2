Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC697456330
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 20:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232714AbhKRTLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 14:11:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232137AbhKRTLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 14:11:54 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0E2C061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 11:08:54 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id i9so2121862ilu.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 11:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WyfaLYwNLsMa80kZpW75sztUwF1erOJGMf+B6Q/Q61s=;
        b=Fp3J6lqXwcgJiCVPHZiZQNkNguy1rnEWS3eP1A5aeDOWlPuWVlN5TwgPYn5MAjOMGd
         WmrbwUWSsl5eVerFprAJdvUSwrLXSwZyhspqzN4O8aJu6dsIWggrEH39+X0k0Fy3dR5O
         Egq4kU43zg3qpmhNLX87cnaAXgUYMgpOtluYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WyfaLYwNLsMa80kZpW75sztUwF1erOJGMf+B6Q/Q61s=;
        b=OQeORO4AeN0JCq/goDEsL9Knfton8z77X+twXgcJOOffX8Ja0gwDiKzpVEeFCKCGhO
         lw78Y1HQ7tLQGLktFlIkk7KFlucjSzvHdh+QLFA1L3kVAPLiIr998F+afpOL3Tx3RoVM
         tSWkqw4Guze5ZFpYVNCB/5/8+gR1VNolPptrq4N7MLITu52p+8mPHkQBSzaUcl1y77gE
         Fzf0dkMoQOc4FQD/kzsCWh57TDHG510q8m1QvsZawZf59dJKEii6mb8m8t0KS0GCljEM
         zWmEtHAaxPJMfG0p4QLYwsLWx+8qrRYM+O7R5Z5sXweOZZj7zRD+u8L4ZFggPNXmEzmM
         KMSw==
X-Gm-Message-State: AOAM532bdQ1XefSVV08U2OLUIDkokZNfAlyyjMNdl1PpQsPb91RkzDEy
        wI10wvXeJ765au5GQ2SpopkkXh3c42YRPrPjsbcy0w==
X-Google-Smtp-Source: ABdhPJwXKOCETZCZElLQLrOX3B4B3PRF1rceUhBEF0V3VY2S+YUkPaoBQBElDUj2NSNs5aAKiI87p1opkqA/jqv8dyk=
X-Received: by 2002:a05:6e02:1445:: with SMTP id p5mr903918ilo.105.1637262533551;
 Thu, 18 Nov 2021 11:08:53 -0800 (PST)
MIME-Version: 1.0
References: <20211112112433.942075-1-hsinyi@chromium.org> <20211118165203.GA1721588@roeck-us.net>
In-Reply-To: <20211118165203.GA1721588@roeck-us.net>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Fri, 19 Nov 2021 03:08:27 +0800
Message-ID: <CAJMQK-iZ5dc0ghYZ_0F3N2QQ3cfsvOdUMg6q0WsaDTMUQvXtdg@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: anx7625: Fix edid_read break case in sp_tx_edid_read()
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Robert Foss <robert.foss@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Xin Ji <xji@analogixsemi.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2021 at 12:52 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Fri, Nov 12, 2021 at 07:24:33PM +0800, Hsin-Yi Wang wrote:
> > edid_read() was assumed to return 0 on success. After
> > 7f16d0f3b8e2("drm/bridge: anx7625: Propagate errors from sp_tx_rst_aux()"),
> > the function can return >= 0 for successful case. Fix the g_edid_break
> > condition in sp_tx_edid_read().
> >
> > Fixes: 7f16d0f3b8e2("drm/bridge: anx7625: Propagate errors from sp_tx_rst_aux()")
> > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > Reviewed-by: Robert Foss <robert.foss@linaro.org>
> > ---
> >  drivers/gpu/drm/bridge/analogix/anx7625.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
> > index 1a871f6b6822ee..392203b576042b 100644
> > --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> > +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> > @@ -826,7 +826,7 @@ static int sp_tx_edid_read(struct anx7625_data *ctx,
> >                               g_edid_break = edid_read(ctx, offset,
> >                                                        pblock_buf);
> >
> > -                             if (g_edid_break)
> > +                             if (g_edid_break < 0)
> >                                       break;
>
> g_edid_break is declared u8 and thus never < 0. The break; statement
> doesn't indicate an error but that a break was encountered, and the
> value of g_edid_break == 1 is used elsewhere in the function to indicate
> that condition.  It also doesn't break out of the outer loop, but only
> out of the switch statement.
>
> With this patch in place, g_edid_break will have a more or less random
> value after an error, and the behavior of this function will be undefined.
>

Before 7f16d0f3b8e2("drm/bridge: anx7625: Propagate errors from
sp_tx_rst_aux()"), edid_read() only returns 0 (i2c read bytes > 0) or
-EIO, so g_edid_break also couldn't be 1. After checking the code
more, I guess what it wants to do is:

- For the 1st and 2nd block (case 0 and 1) in sp_tx_edid_read(), copy
the buffer on success.
- For other blocks (case 2 and 3), process the buffer when the last
g_edid_break updated in previous blocks is not 1. These blocks
probably don't need to be updated if previous blocks have failed. The
whole edid will be checked if valid.

I will update the patch.

> Guenter
