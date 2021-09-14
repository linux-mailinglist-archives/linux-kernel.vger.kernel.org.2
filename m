Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2AC40A210
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 02:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238771AbhINAdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 20:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235668AbhINAdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 20:33:33 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A731DC061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 17:32:16 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id a15so14622453iot.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 17:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fc2qpd7/HkED54Dmv5q2n398ZaaGwNXVhIhrR+B9+xg=;
        b=fzBPJpuTidCguo+0rpVlS9ym+yazP5tQsqID/R/IBgyphfqbxgahDj1x5RehTy+98X
         +ZGJ1PxOCKK46fxVEihbOpl06s9gLSmHjeu1H9ECcc4Mdn2o31bvHIhC0aBQs8KLG6Gj
         Ib5rp1ioVdAUNCCvwvScdVCMBRQgtzl69rCMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fc2qpd7/HkED54Dmv5q2n398ZaaGwNXVhIhrR+B9+xg=;
        b=eD2PkU7UWYbGjDI4b3Afgl7+svyfevd4jQZNBEjD60IcO9AxWnF8S8CqofKZCGF5Vc
         uXbN/OKbl0oQNLI2eDWtBBfmRY9WibRbNM7FRVgbxc1FpxH+JwwVTwoWy8ArRFwvW/d6
         zozDGc/PWI9KyxUWykkAL0vtN1R8cPAJegNBrcFquI5rz1O6iKDdtKE8pxTQi0rBFETQ
         w/S5GdAjmW+v7EmlcuLbflD4hQmZkKzNod+nA8sAXecCrXCcfc0J+XriEZmJH3Aux9dz
         VPO/vDVNkJJxUax1FQybFFuSUSJkfzzQKbUw2RHibPVFCkjX5JlTr7S+RGkE/9Dvm4jn
         RszQ==
X-Gm-Message-State: AOAM530LnuDoTGf1jXb7A8Il1jVH7ag+LH7mDU5CX8k9QPXA+gLx4SUD
        SptyWdeu1NjYk8Gj2bu+jrOGDtHt68HIpw==
X-Google-Smtp-Source: ABdhPJyd7N/7jcS8Jzd3ylRvVT1MexhjG86xwWZeSHoTMRy+UZmGtJSybLp6/+tC6p2u169W8NpG0w==
X-Received: by 2002:a05:6638:1352:: with SMTP id u18mr12257392jad.147.1631579535841;
        Mon, 13 Sep 2021 17:32:15 -0700 (PDT)
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com. [209.85.166.175])
        by smtp.gmail.com with ESMTPSA id s1sm5769992iln.12.2021.09.13.17.32.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Sep 2021 17:32:15 -0700 (PDT)
Received: by mail-il1-f175.google.com with SMTP id a1so12080663ilj.6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 17:32:15 -0700 (PDT)
X-Received: by 2002:a92:da0c:: with SMTP id z12mr9860853ilm.120.1631579534828;
 Mon, 13 Sep 2021 17:32:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210913143255.RFC.v2.1.I8ad7a535bb18a1f41f3858f83379beedb397a9db@changeid>
In-Reply-To: <20210913143255.RFC.v2.1.I8ad7a535bb18a1f41f3858f83379beedb397a9db@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 13 Sep 2021 17:32:01 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XDn3XWt5USOmkhikYMUqY1gt7MQfOQhu7v+soy=u3_0g@mail.gmail.com>
Message-ID: <CAD=FV=XDn3XWt5USOmkhikYMUqY1gt7MQfOQhu7v+soy=u3_0g@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/2] drm/bridge: parade-ps8640: Use regmap APIs
To:     Philip Chen <philipchen@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Sep 13, 2021 at 2:33 PM Philip Chen <philipchen@chromium.org> wrote:
>
> diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bridge/parade-ps8640.c
> index 685e9c38b2db..1b2414601538 100644
> --- a/drivers/gpu/drm/bridge/parade-ps8640.c
> +++ b/drivers/gpu/drm/bridge/parade-ps8640.c
> @@ -9,6 +9,7 @@
>  #include <linux/i2c.h>
>  #include <linux/module.h>
>  #include <linux/of_graph.h>
> +#include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
>
>  #include <drm/drm_bridge.h>
> @@ -31,6 +32,11 @@
>
>  #define NUM_MIPI_LANES         4
>
> +#define COMMON_PS8640_REGMAP_CONFIG \
> +       .reg_bits = 8, \
> +       .val_bits = 8, \
> +       .cache_type = REGCACHE_NONE

At some point we should see if we get any speed gains by actually
caching, but that could be done later and isn't terribly high
priority.


> +
>  /*
>   * PS8640 uses multiple addresses:
>   * page[0]: for DP control
> @@ -64,12 +70,48 @@ struct ps8640 {
>         struct drm_bridge *panel_bridge;
>         struct mipi_dsi_device *dsi;
>         struct i2c_client *page[MAX_DEVS];
> +       struct regmap   *regmap[MAX_DEVS];
>         struct regulator_bulk_data supplies[2];
>         struct gpio_desc *gpio_reset;
>         struct gpio_desc *gpio_powerdown;
>         bool powered;
>  };
>
> +static const struct regmap_config ps8640_regmap_config[] = {
> +       [PAGE0_DP_CNTL] = {
> +               COMMON_PS8640_REGMAP_CONFIG,
> +               .max_register = 0xbf
> +       },
> +       [PAGE1_VDO_BDG] = {
> +               COMMON_PS8640_REGMAP_CONFIG,
> +               .max_register = 0xff
> +       },
> +       [PAGE2_TOP_CNTL] = {
> +               COMMON_PS8640_REGMAP_CONFIG,
> +               .max_register = 0xff
> +       },
> +       [PAGE3_DSI_CNTL1] = {
> +               COMMON_PS8640_REGMAP_CONFIG,
> +               .max_register = 0xff
> +       },
> +       [PAGE4_MIPI_PHY] = {
> +               COMMON_PS8640_REGMAP_CONFIG,
> +               .max_register = 0xff
> +       },
> +       [PAGE5_VPLL] = {
> +               COMMON_PS8640_REGMAP_CONFIG,
> +               .max_register = 0x7f
> +       },
> +       [PAGE6_DSI_CNTL2] = {
> +               COMMON_PS8640_REGMAP_CONFIG,
> +               .max_register = 0xff
> +       },
> +       [PAGE7_SPI_CNTL] = {
> +               COMMON_PS8640_REGMAP_CONFIG,
> +               .max_register = 0xff
> +       }

nit: stylistically it's nice to add a "," after the last brace too.
It's not technically needed but it makes diffs cleaner if another
config is later added.


> @@ -362,6 +390,10 @@ static int ps8640_probe(struct i2c_client *client)
>
>         ps_bridge->page[PAGE0_DP_CNTL] = client;
>
> +       ps_bridge->regmap[PAGE0_DP_CNTL] = devm_regmap_init_i2c(client, ps8640_regmap_config);
> +       if (IS_ERR(ps_bridge->regmap[PAGE0_DP_CNTL]))
> +               return PTR_ERR(ps_bridge->regmap[PAGE0_DP_CNTL]);

I'm a huge fan of dev_err_probe(). I wonder if it makes sense to use
it here? Untested:

if (IS_ERR(ps_bridge->regmap[PAGE0_DP_CNTL]))
  return dev_err_probe(dev, PTR_ERR(ps_bridge->regmap[PAGE0_DP_CNTL]),
                       "Error initting page 0 regmap\n");


All of that is just nits, so:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
