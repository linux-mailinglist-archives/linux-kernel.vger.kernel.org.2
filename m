Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 563CF322D70
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 16:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233214AbhBWPYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 10:24:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232618AbhBWPYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 10:24:04 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A0AC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 07:23:21 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id p21so12535318pgl.12
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 07:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BS3pCRX5Z7JbSvWaVr5WdMtid9oF4IO16PyoAmTAdYs=;
        b=umiXC0bwlKvnb4qm9BVVyHZqGMk6C4GQfUWno0FK4eLXjmZJ/JeTjWqxbWHsJHtn23
         KlyxaDSGc3R+G4Xy+zMV5Vvsxl6xzRnpMbp5D5YAyk5xS0NOQvKvqwoVwlmKVxLN8XkY
         0KD0xinoz5uDPczB/zl1Am4TwLFcFZR4L1zE/r61IBRfb/XTF808c8yffbvo03BKypcL
         7Nr5zKRg5hulJXmVHEHCQH70gvHrCqpN7vBLIAc6PZPHeUbvRd0cEMVvlj4VPyfSb7gH
         QJ0E48z1iFhd2gdHmwJNYzaUT2HHfPIuUuH303O9irfl4Xtl6uArkYi9EOKp3Rf6yQRY
         BC1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BS3pCRX5Z7JbSvWaVr5WdMtid9oF4IO16PyoAmTAdYs=;
        b=Kq8TailNph3hJtBYDvpBL1pZUjWNvuiZqO6x/b6rtpCSMwy1IJJ1RC5cBA/RNwnI+3
         HK5X6jwi/W4Mq2rGE5zrsoQfcnkLYLmfVtR+goOykDr5l1edrz+ujxYO2Uy+PKkfXrVT
         Vtgbb/mZgpll62POBPhVq8YmjcOmnALBgFVsFskG6izsvrC7CQQkZXa6YrYox6iNvMrI
         Xy6008McdQjHOsT7E+OkGqoGeM/A91UpjhPAlGHGwgZtxiU0/cuuQDblox/EYWjlIPc0
         x5vW2h+5wdb1jy+ljAmzi5SXgj823EDSWlRnimbvMJYV7KSz7BtlmkY5zwJvw16v3JE5
         yuaA==
X-Gm-Message-State: AOAM5338H8BEcn9jVeHIrxUXY8kHxn6bvftkJCIrkSvxENHenldiaJ5X
        r5ZNBp127PU1bIhEZD0aMwjnUepmkwfKD4MnJHCE5g==
X-Google-Smtp-Source: ABdhPJybS9amQzmPHnSi0zL+AAlY+4Lgs5kmZTEVwWrd5xts9iyiJyU9q2MiRJdEbUzBM33b45DsnKD2LSIlUlSrzNY=
X-Received: by 2002:aa7:9281:0:b029:1ec:48b2:811c with SMTP id
 j1-20020aa792810000b02901ec48b2811cmr27116567pfa.18.1614093801409; Tue, 23
 Feb 2021 07:23:21 -0800 (PST)
MIME-Version: 1.0
References: <20210115070250.2271571-1-hsinyi@chromium.org> <20210115070250.2271571-2-hsinyi@chromium.org>
In-Reply-To: <20210115070250.2271571-2-hsinyi@chromium.org>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Tue, 23 Feb 2021 16:23:10 +0100
Message-ID: <CAG3jFytPDLWygTGeyCYEqJYcwD=UDAe6hagL5zTjrSKXoN5aMA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] drm/bridge: anx7625: disable regulators when power off
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Xin Ji <xji@analogixsemi.com>, David Airlie <airlied@linux.ie>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Hsin-Yi,

This patch looks good to me, feel free to add my r-b.
Reviewed-by: Robert Foss <robert.foss@linaro.org>

On Fri, 15 Jan 2021 at 08:05, Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>
> When suspending the driver, anx7625_power_standby() will be called to
> turn off reset-gpios and enable-gpios. However, power supplies are not
> disabled. To save power, the driver can get the power supply regulators
> and turn off them in anx7625_power_standby().
>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
> Change:
> v3: add delays between regulators power on
> ---
>  drivers/gpu/drm/bridge/analogix/anx7625.c | 34 +++++++++++++++++++++++
>  drivers/gpu/drm/bridge/analogix/anx7625.h |  1 +
>  2 files changed, 35 insertions(+)
>
> diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
> index 65cc05982f82..23283ba0c4f9 100644
> --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> @@ -11,6 +11,7 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
> +#include <linux/regulator/consumer.h>
>  #include <linux/slab.h>
>  #include <linux/types.h>
>  #include <linux/workqueue.h>
> @@ -875,12 +876,25 @@ static int sp_tx_edid_read(struct anx7625_data *ctx,
>  static void anx7625_power_on(struct anx7625_data *ctx)
>  {
>         struct device *dev = &ctx->client->dev;
> +       int ret, i;
>
>         if (!ctx->pdata.low_power_mode) {
>                 DRM_DEV_DEBUG_DRIVER(dev, "not low power mode!\n");
>                 return;
>         }
>
> +       for (i = 0; i < ARRAY_SIZE(ctx->pdata.supplies); i++) {
> +               ret = regulator_enable(ctx->pdata.supplies[i].consumer);
> +               if (ret < 0) {
> +                       DRM_DEV_DEBUG_DRIVER(dev, "cannot enable supply %d: %d\n",
> +                                            i, ret);
> +                       goto reg_err;
> +               }
> +               usleep_range(2000, 2100);
> +       }
> +
> +       usleep_range(4000, 4100);
> +
>         /* Power on pin enable */
>         gpiod_set_value(ctx->pdata.gpio_p_on, 1);
>         usleep_range(10000, 11000);
> @@ -889,11 +903,16 @@ static void anx7625_power_on(struct anx7625_data *ctx)
>         usleep_range(10000, 11000);
>
>         DRM_DEV_DEBUG_DRIVER(dev, "power on !\n");
> +       return;
> +reg_err:
> +       for (--i; i >= 0; i--)
> +               regulator_disable(ctx->pdata.supplies[i].consumer);
>  }
>
>  static void anx7625_power_standby(struct anx7625_data *ctx)
>  {
>         struct device *dev = &ctx->client->dev;
> +       int ret;
>
>         if (!ctx->pdata.low_power_mode) {
>                 DRM_DEV_DEBUG_DRIVER(dev, "not low power mode!\n");
> @@ -904,6 +923,12 @@ static void anx7625_power_standby(struct anx7625_data *ctx)
>         usleep_range(1000, 1100);
>         gpiod_set_value(ctx->pdata.gpio_p_on, 0);
>         usleep_range(1000, 1100);
> +
> +       ret = regulator_bulk_disable(ARRAY_SIZE(ctx->pdata.supplies),
> +                                    ctx->pdata.supplies);
> +       if (ret < 0)
> +               DRM_DEV_DEBUG_DRIVER(dev, "cannot disable supplies %d\n", ret);
> +
>         DRM_DEV_DEBUG_DRIVER(dev, "power down\n");
>  }
>
> @@ -1742,6 +1767,15 @@ static int anx7625_i2c_probe(struct i2c_client *client,
>         platform->client = client;
>         i2c_set_clientdata(client, platform);
>
> +       pdata->supplies[0].supply = "vdd10";
> +       pdata->supplies[1].supply = "vdd18";
> +       pdata->supplies[2].supply = "vdd33";
> +       ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(pdata->supplies),
> +                                     pdata->supplies);
> +       if (ret) {
> +               DRM_DEV_ERROR(dev, "fail to get power supplies: %d\n", ret);
> +               return ret;
> +       }
>         anx7625_init_gpio(platform);
>
>         atomic_set(&platform->power_status, 0);
> diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.h b/drivers/gpu/drm/bridge/analogix/anx7625.h
> index 193ad86c5450..e4a086b3a3d7 100644
> --- a/drivers/gpu/drm/bridge/analogix/anx7625.h
> +++ b/drivers/gpu/drm/bridge/analogix/anx7625.h
> @@ -350,6 +350,7 @@ struct s_edid_data {
>  struct anx7625_platform_data {
>         struct gpio_desc *gpio_p_on;
>         struct gpio_desc *gpio_reset;
> +       struct regulator_bulk_data supplies[3];
>         struct drm_bridge *panel_bridge;
>         int intp_irq;
>         u32 low_power_mode;
> --
> 2.30.0.284.gd98b1dd5eaa7-goog
>
