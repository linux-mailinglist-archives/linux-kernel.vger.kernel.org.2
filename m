Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18C5933FE29
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 05:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbhCRE1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 00:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhCRE0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 00:26:53 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06E9C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 21:26:52 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id v26so920548iox.11
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 21:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ql2dgaEyzlxz1rnlLy2Wg/nnnp7tmOxMWx8bJq2EFZU=;
        b=W8cx8DyHSkSFRXpWsBNRnLfWNZxWBaqqHtgHrd/WpU0n2AEAEWHPGDzYqFXwZW576h
         EcVKZzyxSb3zHtDCDhhYE4iNDuWSd50c4Pvl1YOJtIE6BKhTjwNRAddrDPPyJdHLDLVM
         491KnMySN0siPXOHZisSPMAhdy2AKATWs/m0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ql2dgaEyzlxz1rnlLy2Wg/nnnp7tmOxMWx8bJq2EFZU=;
        b=L/1fvAhIxWWC/y2n1WZ/ES83IYTafOQD9veO1zTZaMr2SNZaol1S8/eYyZbz634Kf+
         YvlSfYEY4AOWrtjbFwaeDj6TUebdRZPDn0aFwxLctMMjFWaozAA46DCP9/MtOUA8q8a5
         wNCOO+6sBmJwI/dJVl0a24DjTFPbmKaFkbcynYbui5AjbSMzQc+ETJXHZnj8BtyZMWjh
         ixDANh2ZbVzOritiDy78fWV6h6qYkz0ng/EOCL1YLBHmTkxorG0PAUsFQoXgpg1paClI
         V0B50o1UQ1gOQnrBwtK7BPPw9na2FnqzZTlZgs4PcfxP+h/DU3MRxkhQWxDHNd579vuM
         kCFw==
X-Gm-Message-State: AOAM530veeBJKaPilpK9/bfuTu5aWJdTgWSe9lzFXpDLKF7VOSWPcKSl
        WayCYFos5M+IL+Q1eUaReq3oMY6Fn3kTceCHWQ9p3w==
X-Google-Smtp-Source: ABdhPJyiT+pK5YW1/xho4IDNMJd1L9KoZwDrKi/f2JRgrLZDLUc4ArB1kHW9DAPXHK1IuoyC3hGih7UIy39ozt/dTSQ=
X-Received: by 2002:a05:6638:43:: with SMTP id a3mr5366562jap.102.1616041612173;
 Wed, 17 Mar 2021 21:26:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210224061409.3996755-1-hsinyi@chromium.org> <20210224061409.3996755-2-hsinyi@chromium.org>
In-Reply-To: <20210224061409.3996755-2-hsinyi@chromium.org>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Thu, 18 Mar 2021 12:26:25 +0800
Message-ID: <CAJMQK-ho9Ncqd=muCv-aMsHSRhgKtC3H6asxR=+3CODpeiWQWQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] drm/bridge: anx7625: disable regulators when power off
To:     Xin Ji <xji@analogixsemi.com>,
        dri-devel <dri-devel@lists.freedesktop.org>
Cc:     David Airlie <airlied@linux.ie>,
        Robert Foss <robert.foss@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Devicetree List <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 24, 2021 at 2:14 PM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>
> When suspending the driver, anx7625_power_standby() will be called to
> turn off reset-gpios and enable-gpios. However, power supplies are not
> disabled. To save power, the driver can get the power supply regulators
> and turn off them in anx7625_power_standby().
>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Reviewed-by: Robert Foss <robert.foss@linaro.org>
> ---

Ping on the thread, thanks.

>  drivers/gpu/drm/bridge/analogix/anx7625.c | 34 +++++++++++++++++++++++
>  drivers/gpu/drm/bridge/analogix/anx7625.h |  1 +
>  2 files changed, 35 insertions(+)
>
> diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
> index 65cc05982f826..23283ba0c4f93 100644
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
> index 193ad86c54503..e4a086b3a3d7b 100644
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
> 2.30.1.766.gb4fecdf3b7-goog
>
