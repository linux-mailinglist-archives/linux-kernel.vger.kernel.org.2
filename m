Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0AB43BB0B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 21:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237001AbhJZTi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 15:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238874AbhJZTit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 15:38:49 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54497C061570
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 12:36:25 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id t4so161731oie.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 12:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=/L9zxAjJJySGUMIg0XED9nw/dqrOKwLK8zXSIkYpfT0=;
        b=jzMLcW5uA2WnsQKrrF5mFUfrtYgp6gV61oiLCj1oIaEQWo5Z3oL7OXyru1NPaPDc1x
         H1p75JvahzCvKeYA3Fi0Hx9Pp+UYo02xLDL5vHVzSHyOYpgej5eNcdE8gnEvbPjYfEo3
         4ULX53Wk7w8A/k9E2u/PC5eBFNJjtgJlRs+R8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=/L9zxAjJJySGUMIg0XED9nw/dqrOKwLK8zXSIkYpfT0=;
        b=otUen6T3v3/Obkx6NwV3TuHte9iJk/rqBe9hHi64jXUt1g0zrmuOtsfLR+lqx5iii7
         Bc0wyk+J4NJBGTJcTvfUjUz5BkBAoBySPxDV/qAtTjPDok8coDv+Lzv6oBbGJ0GjcWMr
         pvBVBko7GvL1QX5C6AaG45rJh931EfsIOa15d4HxoHrBtQdPiq5YU6B5XFPi76ChAbq+
         yUGKD8cUd0qIpy5SZPFsEWN74qzpz3Rt7c9pY4Q8+CyK3Tc96vAIOOmGTnUeDXtsJpBh
         JKYaKWFQziaMM+z8Skq0H71PYBXbyb7yJwdURa1mEvv4QzyDr9Gtee1MfQVZQYhDhX35
         u1zQ==
X-Gm-Message-State: AOAM531p0hXiEeF1AwVEilQQ/WDPoVPFujBoCdyAMDN6sJ/jSZOFIeQV
        E2y8jnDtO83L87sxJl9alWwYck2ObJm9GOQxxZ42sy3Ypzc=
X-Google-Smtp-Source: ABdhPJyi8T0lV7Ybo4JQXXI6MrAlS2+rpxwjPPjxwdN3D/0+4+YM1H1L1xzczkm5DKsF7JHdhMZQxOyHCMEWvLDZ6nM=
X-Received: by 2002:a05:6808:1d9:: with SMTP id x25mr567814oic.64.1635276984552;
 Tue, 26 Oct 2021 12:36:24 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 26 Oct 2021 12:36:24 -0700
MIME-Version: 1.0
In-Reply-To: <20211026121058.v3.1.I9d81c3b44f350707b5373d00524af77c4aae862b@changeid>
References: <20211026121058.v3.1.I9d81c3b44f350707b5373d00524af77c4aae862b@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Tue, 26 Oct 2021 12:36:24 -0700
Message-ID: <CAE-0n50C82He9KCyXRTQGwQxqS6CWhm3w6Vv-5ayKYEfZyt-jg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] drm/bridge: parade-ps8640: Enable runtime power management
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

Quoting Philip Chen (2021-10-26 12:11:09)
> Fit ps8640 driver into runtime power management framework:
>
> First, break _poweron() to 3 parts: (1) turn on power and wait for
> ps8640's internal MCU to finish init (2) check panel HPD (which is
> proxied by GPIO9) (3) the other configs. As runtime_resume() can be
> called before panel is powered, we only add (1) to _resume() and leave
> (2)(3) to _pre_enable(). We also add (2) to _aux_transfer() as we want
> to ensure panel HPD is asserted before we start AUX CH transactions.
>
> Second, the original driver has a mysterious delay of 50 ms between (2)
> and (3). Since Parade's support can't explain what the delay is for,
> and we don't see removing the delay break any boards at hand, remove
> the delay to fit into this driver change.
>
> In addition, rename "powered" to "pre_enabled" and don't check for it
> in the pm_runtime calls. The pm_runtime calls are already refcounted
> so there's no reason to check there. The other user of "powered",
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
>
> Changes in v3:
> - Fix typo/wording in the commit message.
> - Add ps8640_aux_transfer_msg() for AUX operation. In
>   ps8640_aux_transfer(), wrap around ps8640_aux_transfer_msg()
>   with PM operations and HPD check.
> - Document why autosuspend_delay is set to 500ms.
>
>  drivers/gpu/drm/bridge/parade-ps8640.c | 186 +++++++++++++++----------
>  1 file changed, 115 insertions(+), 71 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bridge/parade-ps8640.c
> index 3aaa90913bf8..ac42a3473770 100644
> --- a/drivers/gpu/drm/bridge/parade-ps8640.c
> +++ b/drivers/gpu/drm/bridge/parade-ps8640.c
> @@ -9,6 +9,7 @@
>  #include <linux/i2c.h>
>  #include <linux/module.h>
>  #include <linux/of_graph.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
>
> @@ -100,7 +101,7 @@ struct ps8640 {
>         struct regulator_bulk_data supplies[2];
>         struct gpio_desc *gpio_reset;
>         struct gpio_desc *gpio_powerdown;
> -       bool powered;
> +       bool pre_enabled;
>  };
>
>  static const struct regmap_config ps8640_regmap_config[] = {
> @@ -148,8 +149,29 @@ static inline struct ps8640 *aux_to_ps8640(struct drm_dp_aux *aux)
>         return container_of(aux, struct ps8640, aux);
>  }
>
> -static ssize_t ps8640_aux_transfer(struct drm_dp_aux *aux,
> -                                  struct drm_dp_aux_msg *msg)
> +static void ps8640_ensure_hpd(struct ps8640 *ps_bridge)

static int ps8640_ensure_hpd?

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
> +               dev_warn(dev, "HPD didn't go high: %d\n", ret);
> +
> +       return ret;
> +}
> +
> +static ssize_t ps8640_aux_transfer_msg(struct drm_dp_aux *aux,
> +                                      struct drm_dp_aux_msg *msg)
>  {
>         struct ps8640 *ps_bridge = aux_to_ps8640(aux);
>         struct regmap *map = ps_bridge->regmap[PAGE0_DP_CNTL];

Otherwise

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
