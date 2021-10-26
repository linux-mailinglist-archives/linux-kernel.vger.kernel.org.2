Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21EBE43BA72
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 21:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbhJZTQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 15:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbhJZTQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 15:16:57 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E8EC061570
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 12:14:33 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 67so187624yba.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 12:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e1Od3r3qPkF5gqs5aFmgK4aW8UvHyGg0exs5u3kOpa0=;
        b=ANzzsKfUm9vSae7g+ybUBDvg9jE+GcvmfzWlk3f7mugii25iwlmsDsODDryutvtCle
         DYcAu8yQ1+qtB3rdAr0j2/QtXBaxgDqTXvW30azJttqgblP4hgrCe3DUQgtAojRuQkOI
         NspzrKmW2XpvnQaumNP/BjfaD7B8eqoaL6F20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e1Od3r3qPkF5gqs5aFmgK4aW8UvHyGg0exs5u3kOpa0=;
        b=A7jHLTJ86o4A67WwUnjTn9CmEV38ZiWCL0GGji/v5o0ARnQeiH6aLYqWuTXFWH4+XK
         6Py+wQz0AxyPby4VUJ6Vi/4SLMzzzi1RrsKtVtvm6Qv4GmkPs75ufq4PsyFwYVQnwoWC
         v2Ixn5IcF3tTWVIufD6EzYqPLCfHPmNoKq8fO3wH0TDcE7ffADF5kSew7pqvMIUCeup/
         +omHDCklsWCtWqHe0/GtvWdssxg61TcgxIBUv8cn0nAoiI8+NNF8hFfpb/PFUmUh4kC5
         phQ+Ux491cRgvyJ3lJAiIls9BDcwszDReMjY1+MZB8DeswtRwpCD2pCSI0unIa5al1lW
         JyUA==
X-Gm-Message-State: AOAM530nXJrkBwo4vkllmT9RLXmN80kD2TNSm5j97ln3WMJX4FWMvk74
        Pyzfrg3/a0D0E0CaISy08OjWVKQbBOVKdYdhPaBmrw==
X-Google-Smtp-Source: ABdhPJxC8ykyO0LlKiUPOTjbY7wYtV5Eg4VAmMAB9V5oV/P2EMLduP9B6fK+tqolSIZhDs36vR9F3kQvl0EBYn/xQV0=
X-Received: by 2002:a25:ea48:: with SMTP id o8mr25556562ybe.14.1635275671133;
 Tue, 26 Oct 2021 12:14:31 -0700 (PDT)
MIME-Version: 1.0
References: <20211021140552.v2.1.I9d81c3b44f350707b5373d00524af77c4aae862b@changeid>
 <CAE-0n50zgG963E-xPA3H7NJd9=iAQaV5YYdrN9zHPsTj93TE-A@mail.gmail.com>
In-Reply-To: <CAE-0n50zgG963E-xPA3H7NJd9=iAQaV5YYdrN9zHPsTj93TE-A@mail.gmail.com>
From:   Philip Chen <philipchen@chromium.org>
Date:   Tue, 26 Oct 2021 12:14:20 -0700
Message-ID: <CA+cxXhnXVJYs3Q31N8iG+Dt5b+BLTenWan1i=ooPs2kwZq8Peg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drm/bridge: parade-ps8640: Enable runtime power management
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, dianders@chromium.org,
        Andrzej Hajda <a.hajda@samsung.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Mon, Oct 25, 2021 at 1:05 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Philip Chen (2021-10-21 14:05:59)
> > Fit ps8640 driver into runtime power management framework:
> >
> > First, break _poweron() to 3 parts: (1) turn on power and wait for
> > ps8640's internal MCU to finish init (2) check panel HPD (which is
> > proxied by GPIO9) (3) the other configs. As runtime_resume() can be
> > called before panel is powered, we only add (1) to _resume() and leave
> > (2)(3) to _pre_enable(). We also add (2) to _aux_transfer() as we want
> > to ensure panel HPD is asserted before we start AUX CH transactions.
> >
> > The original driver has a mysterious delay of 50 ms between (2) and
> > (3). Since Parade's support can't explain what the delay is for, and we
> > don't see removing the delay break any boards at hand, remove the dalay
>
> s/dalay/delay/
Thanks.
I've fixed it in v3.
>
> > to fit into this driver change.
> >
> > Besides, rename "powered" to "pre_enabled" and don't check for it in
>
> "Besides" doesn't make sense here. Probably "In addition" or "Also"?
Thanks.
I've fixed it in v3.
>
> > the pm_runtime calls. The pm_runtime calls are already refcounted so
> > there's no reason to check there. The other user of "powered",
> > _get_edid(), only cares if pre_enable() has already been called.
> >
> > Lastly, change some existing DRM_...() logging to dev_...() along the
> > way, since DRM_...() seem to be deprecated in [1].
> >
> > [1] https://patchwork.freedesktop.org/patch/454760/
> >
> > Signed-off-by: Philip Chen <philipchen@chromium.org>
> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> > ---
> > diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bridge/parade-ps8640.c
> > index 3aaa90913bf8..220ca3b03d24 100644
> > --- a/drivers/gpu/drm/bridge/parade-ps8640.c
> > +++ b/drivers/gpu/drm/bridge/parade-ps8640.c
> > @@ -148,6 +149,25 @@ static inline struct ps8640 *aux_to_ps8640(struct drm_dp_aux *aux)
> >         return container_of(aux, struct ps8640, aux);
> >  }
> >
> > +static void ps8640_ensure_hpd(struct ps8640 *ps_bridge)
> > +{
> > +       struct regmap *map = ps_bridge->regmap[PAGE2_TOP_CNTL];
> > +       struct device *dev = &ps_bridge->page[PAGE2_TOP_CNTL]->dev;
> > +       int status;
> > +       int ret;
> > +
> > +       /*
> > +        * Apparently something about the firmware in the chip signals that
> > +        * HPD goes high by reporting GPIO9 as high (even though HPD isn't
> > +        * actually connected to GPIO9).
> > +        */
> > +       ret = regmap_read_poll_timeout(map, PAGE2_GPIO_H, status,
> > +                               status & PS_GPIO9, 20 * 1000, 200 * 1000);
> > +
> > +       if (ret < 0)
> > +               dev_warn(dev, "HPD didn't go high: %d", ret);
>
> Missing newline on the print message.
Thanks.
I've fixed it in v3.
>
> > +}
> > +
> >  static ssize_t ps8640_aux_transfer(struct drm_dp_aux *aux,
> >                                    struct drm_dp_aux_msg *msg)
> >  {
> > @@ -171,6 +191,9 @@ static ssize_t ps8640_aux_transfer(struct drm_dp_aux *aux,
> >         if (msg->address & ~SWAUX_ADDR_MASK)
> >                 return -EINVAL;
> >
> > +       pm_runtime_get_sync(dev);
> > +       ps8640_ensure_hpd(ps_bridge);
>
> Shouldn't we bail out of here with an error if we can't ensure hpd?
Sounds about right.
I fixed this in v3.
PTAL.
>
> > +
> >         switch (request) {
> >         case DP_AUX_NATIVE_WRITE:
> >         case DP_AUX_NATIVE_READ:
> > @@ -180,14 +203,15 @@ static ssize_t ps8640_aux_transfer(struct drm_dp_aux *aux,
> >         case DP_AUX_I2C_READ:
> >                 break;
> >         default:
> > -               return -EINVAL;
> > +               ret = -EINVAL;
> > +               goto exit;
> >         }
> >
> >         ret = regmap_write(map, PAGE0_AUXCH_CFG3, AUXCH_CFG3_RESET);
> >         if (ret) {
> >                 DRM_DEV_ERROR(dev, "failed to write PAGE0_AUXCH_CFG3: %d\n",
> >                               ret);
> > -               return ret;
> > +               goto exit;
> >         }
> >
> >         /* Assume it's good */
> > @@ -213,7 +237,7 @@ static ssize_t ps8640_aux_transfer(struct drm_dp_aux *aux,
> >                                 DRM_DEV_ERROR(dev,
> >                                               "failed to write WDATA: %d\n",
> >                                               ret);
> > -                               return ret;
> > +                               goto exit;
> >                         }
> >                 }
> >         }
> > @@ -228,7 +252,7 @@ static ssize_t ps8640_aux_transfer(struct drm_dp_aux *aux,
> >         if (ret) {
> >                 DRM_DEV_ERROR(dev, "failed to read PAGE0_SWAUX_STATUS: %d\n",
> >                               ret);
> > -               return ret;
> > +               goto exit;
> >         }
> >
> >         switch (data & SWAUX_STATUS_MASK) {
> > @@ -250,9 +274,11 @@ static ssize_t ps8640_aux_transfer(struct drm_dp_aux *aux,
> >                 len = data & SWAUX_M_MASK;
> >                 break;
> >         case SWAUX_STATUS_INVALID:
> > -               return -EOPNOTSUPP;
> > +               ret = -EOPNOTSUPP;
> > +               goto exit;
> >         case SWAUX_STATUS_TIMEOUT:
> > -               return -ETIMEDOUT;
> > +               ret = -ETIMEDOUT;
> > +               goto exit;
> >         }
> >
> >         if (len && (request == DP_AUX_NATIVE_READ ||
>
> It may be simpler to understand the diff if the transfer function still
> exited the same way and a small wrapper function was put around this to
> do the runtime PM operations.
Thanks for the suggestion.
I've posted v3 following this route.
PTAL.

>
>
>         pm_runtime_get_sync();
>         if (ps8640_hpd_asserted())
>                 ret = ps8640_aux_transfer_msg();
>         pm_runtime_mark_last_busy();
>         pm_runtime_put_autosuspend();
>
>         return ret;
>
>
> > @@ -587,6 +611,13 @@ static int ps8640_probe(struct i2c_client *client)
> >         ps_bridge->aux.transfer = ps8640_aux_transfer;
> >         drm_dp_aux_init(&ps_bridge->aux);
> >
> > +       pm_runtime_enable(dev);
> > +       pm_runtime_set_autosuspend_delay(dev, 500);
>
> Presumably 500 is chosen because the message transfer speed is faster
> than that? Can we get a comment in the code for that?
Added a comment in v3.
PTAL.

>
> > +       pm_runtime_use_autosuspend(dev);
> > +       ret = devm_add_action_or_reset(dev, ps8640_runtime_disable, dev);
> > +       if (ret)
> > +               return ret;
> > +
> >         drm_bridge_add(&ps_bridge->bridge);
> >
> >         return 0;
