Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 316C243A468
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 22:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236637AbhJYUY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 16:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233831AbhJYUYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 16:24:52 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4884EC0F4A7C
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 13:05:26 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id g125so17167497oif.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 13:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=Kddf3rhfd2mwlt1ps9zH7TAMJvvrILGOEKiITtIiEjs=;
        b=kJeIWrgEG/oZGBiTmLDdFEpuphATvas4SUpqd0y0do4c9tRg/5a9GNwNHAj3D1QhWp
         DT5KAWmhJv+zwyR7t+mGhqeLuZgHmFQJqKh/2n1/FpBo0BwohEZmlX/D1k2ianZ0C31G
         FzR0UDFCyNPHV20tBPlYfsTaWx9JdT3mC5nCk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=Kddf3rhfd2mwlt1ps9zH7TAMJvvrILGOEKiITtIiEjs=;
        b=U8hA283GMlX5hBzmVl/juiKNMzx0UWMzMESeZgWMCOnkgzxM0BX8LxTzpk0XyqA7jB
         U6/w/O/0KyomlGZ4SFuxFgFprQxx2zC8IYnPfFQ83RoTtmWIgt3oMrp81vUAR3/DVHhq
         7pV+/YkMy/LkD26rj87bDWgY8xXh3lawtEHrVrVw72MO5GWPiLKwuxt6yMa8iHiWW7sN
         wctCQTjMtCYGhs6zYTUAvN7/on9r9x52BEUNczUT2APyIUwq0AHQbh2CEQeRhVl6fERA
         tKHheuCQ5UVECnpVxQrFM435uU5Q4hpzmqRwjCMJ0aeIYdWpxhU5PCBx4VvfSRC4Z6hv
         G5nA==
X-Gm-Message-State: AOAM531IQUK5svemx4gqWenpFqPjj6kmvwHbnvp1UlQN9FWIyzvxuNkR
        ZOxHTqv44/CyWu9Gs64gCSKoTWfQn1yJ+XnG5ogYZwa0FqA=
X-Google-Smtp-Source: ABdhPJz+slegngwS5VAKi2tbkWLbDE01t2nraU7usD8sV16bb8iycvt49rJ/mKwFF7SiP139E1i+oj7ujDGAHzsyzXY=
X-Received: by 2002:a05:6808:1d9:: with SMTP id x25mr12862977oic.64.1635192325533;
 Mon, 25 Oct 2021 13:05:25 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 25 Oct 2021 13:05:25 -0700
MIME-Version: 1.0
In-Reply-To: <20211021140552.v2.1.I9d81c3b44f350707b5373d00524af77c4aae862b@changeid>
References: <20211021140552.v2.1.I9d81c3b44f350707b5373d00524af77c4aae862b@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Mon, 25 Oct 2021 13:05:25 -0700
Message-ID: <CAE-0n50zgG963E-xPA3H7NJd9=iAQaV5YYdrN9zHPsTj93TE-A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drm/bridge: parade-ps8640: Enable runtime power management
To:     LKML <linux-kernel@vger.kernel.org>,
        Philip Chen <philipchen@chromium.org>
Cc:     dianders@chromium.org, Andrzej Hajda <a.hajda@samsung.com>,
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

Quoting Philip Chen (2021-10-21 14:05:59)
> Fit ps8640 driver into runtime power management framework:
>
> First, break _poweron() to 3 parts: (1) turn on power and wait for
> ps8640's internal MCU to finish init (2) check panel HPD (which is
> proxied by GPIO9) (3) the other configs. As runtime_resume() can be
> called before panel is powered, we only add (1) to _resume() and leave
> (2)(3) to _pre_enable(). We also add (2) to _aux_transfer() as we want
> to ensure panel HPD is asserted before we start AUX CH transactions.
>
> The original driver has a mysterious delay of 50 ms between (2) and
> (3). Since Parade's support can't explain what the delay is for, and we
> don't see removing the delay break any boards at hand, remove the dalay

s/dalay/delay/

> to fit into this driver change.
>
> Besides, rename "powered" to "pre_enabled" and don't check for it in

"Besides" doesn't make sense here. Probably "In addition" or "Also"?

> the pm_runtime calls. The pm_runtime calls are already refcounted so
> there's no reason to check there. The other user of "powered",
> _get_edid(), only cares if pre_enable() has already been called.
>
> Lastly, change some existing DRM_...() logging to dev_...() along the
> way, since DRM_...() seem to be deprecated in [1].
>
> [1] https://patchwork.freedesktop.org/patch/454760/
>
> Signed-off-by: Philip Chen <philipchen@chromium.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---
> diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bridge/parade-ps8640.c
> index 3aaa90913bf8..220ca3b03d24 100644
> --- a/drivers/gpu/drm/bridge/parade-ps8640.c
> +++ b/drivers/gpu/drm/bridge/parade-ps8640.c
> @@ -148,6 +149,25 @@ static inline struct ps8640 *aux_to_ps8640(struct drm_dp_aux *aux)
>         return container_of(aux, struct ps8640, aux);
>  }
>
> +static void ps8640_ensure_hpd(struct ps8640 *ps_bridge)
> +{
> +       struct regmap *map = ps_bridge->regmap[PAGE2_TOP_CNTL];
> +       struct device *dev = &ps_bridge->page[PAGE2_TOP_CNTL]->dev;
> +       int status;
> +       int ret;
> +
> +       /*
> +        * Apparently something about the firmware in the chip signals that
> +        * HPD goes high by reporting GPIO9 as high (even though HPD isn't
> +        * actually connected to GPIO9).
> +        */
> +       ret = regmap_read_poll_timeout(map, PAGE2_GPIO_H, status,
> +                               status & PS_GPIO9, 20 * 1000, 200 * 1000);
> +
> +       if (ret < 0)
> +               dev_warn(dev, "HPD didn't go high: %d", ret);

Missing newline on the print message.

> +}
> +
>  static ssize_t ps8640_aux_transfer(struct drm_dp_aux *aux,
>                                    struct drm_dp_aux_msg *msg)
>  {
> @@ -171,6 +191,9 @@ static ssize_t ps8640_aux_transfer(struct drm_dp_aux *aux,
>         if (msg->address & ~SWAUX_ADDR_MASK)
>                 return -EINVAL;
>
> +       pm_runtime_get_sync(dev);
> +       ps8640_ensure_hpd(ps_bridge);

Shouldn't we bail out of here with an error if we can't ensure hpd?

> +
>         switch (request) {
>         case DP_AUX_NATIVE_WRITE:
>         case DP_AUX_NATIVE_READ:
> @@ -180,14 +203,15 @@ static ssize_t ps8640_aux_transfer(struct drm_dp_aux *aux,
>         case DP_AUX_I2C_READ:
>                 break;
>         default:
> -               return -EINVAL;
> +               ret = -EINVAL;
> +               goto exit;
>         }
>
>         ret = regmap_write(map, PAGE0_AUXCH_CFG3, AUXCH_CFG3_RESET);
>         if (ret) {
>                 DRM_DEV_ERROR(dev, "failed to write PAGE0_AUXCH_CFG3: %d\n",
>                               ret);
> -               return ret;
> +               goto exit;
>         }
>
>         /* Assume it's good */
> @@ -213,7 +237,7 @@ static ssize_t ps8640_aux_transfer(struct drm_dp_aux *aux,
>                                 DRM_DEV_ERROR(dev,
>                                               "failed to write WDATA: %d\n",
>                                               ret);
> -                               return ret;
> +                               goto exit;
>                         }
>                 }
>         }
> @@ -228,7 +252,7 @@ static ssize_t ps8640_aux_transfer(struct drm_dp_aux *aux,
>         if (ret) {
>                 DRM_DEV_ERROR(dev, "failed to read PAGE0_SWAUX_STATUS: %d\n",
>                               ret);
> -               return ret;
> +               goto exit;
>         }
>
>         switch (data & SWAUX_STATUS_MASK) {
> @@ -250,9 +274,11 @@ static ssize_t ps8640_aux_transfer(struct drm_dp_aux *aux,
>                 len = data & SWAUX_M_MASK;
>                 break;
>         case SWAUX_STATUS_INVALID:
> -               return -EOPNOTSUPP;
> +               ret = -EOPNOTSUPP;
> +               goto exit;
>         case SWAUX_STATUS_TIMEOUT:
> -               return -ETIMEDOUT;
> +               ret = -ETIMEDOUT;
> +               goto exit;
>         }
>
>         if (len && (request == DP_AUX_NATIVE_READ ||

It may be simpler to understand the diff if the transfer function still
exited the same way and a small wrapper function was put around this to
do the runtime PM operations.


	pm_runtime_get_sync();
	if (ps8640_hpd_asserted())
		ret = ps8640_aux_transfer_msg();
	pm_runtime_mark_last_busy();
	pm_runtime_put_autosuspend();

	return ret;


> @@ -587,6 +611,13 @@ static int ps8640_probe(struct i2c_client *client)
>         ps_bridge->aux.transfer = ps8640_aux_transfer;
>         drm_dp_aux_init(&ps_bridge->aux);
>
> +       pm_runtime_enable(dev);
> +       pm_runtime_set_autosuspend_delay(dev, 500);

Presumably 500 is chosen because the message transfer speed is faster
than that? Can we get a comment in the code for that?

> +       pm_runtime_use_autosuspend(dev);
> +       ret = devm_add_action_or_reset(dev, ps8640_runtime_disable, dev);
> +       if (ret)
> +               return ret;
> +
>         drm_bridge_add(&ps_bridge->bridge);
>
>         return 0;
