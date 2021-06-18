Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA653AC131
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 05:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbhFRDI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 23:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbhFRDI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 23:08:27 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5BB4C061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 20:06:18 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id g4so4949064pjk.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 20:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MF+HvSh2Ph2aJcSQ8YS6FS+dV1UC86cI16zR69oJ2u8=;
        b=jYJn0PjuLeGUOI9PsxEFTmfohuH85BJzoU5Rq7Fst9tN15oc/M1M6mieCH2th80v0h
         +56mhuRuaWRmjRG3dECTL4xdtK9p2nica6EyBFtZYTNyrxY5oo6ArQhm4nR8Q/reji2G
         MhbNSTEpCBm9snqP44Xr93566LvXK1Jlv52/Nii/MhWe7XSGe0efrZCezH/nA3AP0Qmf
         dcIUHFaQbGdlcy9KzG9UybuyDDxpd21jHoMGH4Jrdafx8i+r28H9yDrcbLFn75ov5xhm
         JvmoNp2SMIoGuSaU2ntbtrSdpOBxnEm0XhGbnXGtFZVQJMiaFg1PAF+JGmLTOK2+6oAj
         pvUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MF+HvSh2Ph2aJcSQ8YS6FS+dV1UC86cI16zR69oJ2u8=;
        b=RMZNqYh07lfX2s4K70epw4USFTrxrk465Y8nHmh4shDjTTJcMYUYEUC54ubJaLPKKA
         VkOue9L5jcP4Y4xcEzJXL8mVoOBJmshLSwFQY2q7NDOOgFggvPzvXRfeENIBQCjIkcYr
         2etvqipuB42GV1VxHlNIdHb4pQh0gVrJxm9oCe4+6pg6/+YCcWXmKN+X9rF9TmnAqifo
         rKw+4d43tP5OdD1FM8XU5W/Iqa65l65UzU6rwHPoX6HHZUkTI5js3YQzx9GuX7wk+Gvd
         c07GHHzRvDdrGbX6hNU5x+5v1Yd48Zguutke7C84NhnNFVTuB9VVl2yvv3O7aVY8e01q
         UCAg==
X-Gm-Message-State: AOAM532Css7tKIEA9qCfORUxPe+8nu6rAWDYV8flkxXXrK/tfgJm9tM7
        DYSsjp1FsyOb+nImG1WmRP/xQiJxonJxP8zpa4M=
X-Google-Smtp-Source: ABdhPJzd3QjZo222960R4VEwMcg19qhdCaLwAOfwGm2SrRnSgF82Mc4zLEOH80+DEn9D9NbzapHzspaopRQih7B/NHE=
X-Received: by 2002:a17:90a:e98f:: with SMTP id v15mr19574185pjy.235.1623985578289;
 Thu, 17 Jun 2021 20:06:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210617111925.162120-1-net147@gmail.com> <YMtYoaSIIRhb85fh@pendragon.ideasonboard.com>
In-Reply-To: <YMtYoaSIIRhb85fh@pendragon.ideasonboard.com>
From:   Jonathan Liu <net147@gmail.com>
Date:   Fri, 18 Jun 2021 13:06:07 +1000
Message-ID: <CANwerB0J9xKj3kjYPjzfeDvKV8JXPcDtoZaLMzkudCBz8=ZnVw@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: ti-sn65dsi83: Fix null pointer dereference in
 remove callback
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Marek Vasut <marex@denx.de>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Linus Walleij <linus.walleij@linaro.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marek,

On Fri, 18 Jun 2021 at 00:14, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Jonathan,
>
> Thank you for the patch.
>
> On Thu, Jun 17, 2021 at 09:19:25PM +1000, Jonathan Liu wrote:
> > If attach has not been called, unloading the driver can result in a null
> > pointer dereference in mipi_dsi_detach as ctx->dsi has not been assigned
> > yet.
>
> Shouldn't this be done in a brige .detach() operation instead ?
>

Could you please take a look?
I don't have a working setup to test moving the code to detach.

> > Fixes: ceb515ba29ba6b ("drm/bridge: ti-sn65dsi83: Add TI SN65DSI83 and SN65DSI84 driver")
> > Signed-off-by: Jonathan Liu <net147@gmail.com>
> > ---
> >  drivers/gpu/drm/bridge/ti-sn65dsi83.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> > index 750f2172ef08..8e9f45c5c7c1 100644
> > --- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> > +++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> > @@ -671,8 +671,11 @@ static int sn65dsi83_remove(struct i2c_client *client)
> >  {
> >       struct sn65dsi83 *ctx = i2c_get_clientdata(client);
> >
> > -     mipi_dsi_detach(ctx->dsi);
> > -     mipi_dsi_device_unregister(ctx->dsi);
> > +     if (ctx->dsi) {
> > +             mipi_dsi_detach(ctx->dsi);
> > +             mipi_dsi_device_unregister(ctx->dsi);
> > +     }
> > +
> >       drm_bridge_remove(&ctx->bridge);
> >       of_node_put(ctx->host_node);
> >

Thanks.

Regards,
Jonathan
