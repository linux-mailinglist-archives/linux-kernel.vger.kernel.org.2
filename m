Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5322F3518CC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 19:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235639AbhDARrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 13:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234644AbhDARjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 13:39:05 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C4CC08EC99
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 06:58:42 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id gb6so1223439pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 06:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CNpE2gp8qLbgXvartbLlAR/NP/W7kT+8WOqLZfb4q+I=;
        b=bTQOz07KyyMH0Xc7tcYG+lkUlWhuIlY1pOJGSjzN1yFczJNlIyJr5WyBdBY4e0t0lh
         53vrg6JGk/PqmqE6I4km2Z2Enfrxz5GTEv9TM1W6/UxGT4EedeQ1J0PDNZU0gBqUGXC5
         Bjdy+Z9JaenqG7Llw/PxC54ftX8zBeTaUMp5ylfIGnAi8fqkN1cHMLRUZvkMQCD9aKFb
         6iEzJJLVuhsM5OcKOtq6Yqcg1s1lxzLKUj0ZRg14lBhdfSrVRVXY+iMbbc7MOJkEZRM4
         oIU30ICfh02QexkAexH0zGkuUq50NZ0eYw7v8qcmq2H+lZO3DI9LMauhuCyGAJjdnAp9
         BvmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CNpE2gp8qLbgXvartbLlAR/NP/W7kT+8WOqLZfb4q+I=;
        b=tt0jUMhdgjz7Hp3GMrYc9RxovInp8BI7sw59LeNuKp/hc3Vq2kaPURJOrqU2k52q8f
         nAoJgF7Odgje60aeeGrvgjge7EHAEFE5GTN9T9D9zxjK2/HMfzU6H6dbAtSfnZBEGL18
         RP0CMWqvPiUEQQEkiHS6VhdaU7R+HqOIfgHUgg8Bwbmy3PXl8Aqv+xVFzwlIA5R845I7
         VFLuhtGbF/IlB5EgLDGElgQPn70t0v0VKOq6JZhMHXG51mMfHjOhx53fQsQsk5av+L6q
         hfo3e7m7fH8kHNjEGlfSg+04rzxcKSVLqJqma7XBeIzdLdqQUu5G4fvgheD+NkXvtepU
         2IRg==
X-Gm-Message-State: AOAM532mJGPjjhwhsEimPVPiczosXBjCu1lS8V2zm6BtPc13ZyV4WXJi
        9GuGDfqfC2Rl+sdzc68UMGxWy2IdwYNzasygm0v9aA==
X-Google-Smtp-Source: ABdhPJzGyb3TH1bcQokPZmz0z0bEO1ztrmO4yv2tG/p2LjILvX0nFDYD4lsZ77eb8hx+H9Cq4rddOCByHhsHQ1Zke8A=
X-Received: by 2002:a17:90a:4a8f:: with SMTP id f15mr9209197pjh.19.1617285522145;
 Thu, 01 Apr 2021 06:58:42 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1616135353.git.xji@analogixsemi.com> <f5d689c6ad6fd585292550950e9c69c31e551e61.1616135353.git.xji@analogixsemi.com>
In-Reply-To: <f5d689c6ad6fd585292550950e9c69c31e551e61.1616135353.git.xji@analogixsemi.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Thu, 1 Apr 2021 15:58:30 +0200
Message-ID: <CAG3jFytYMC80bJgtjfPzD1NL0wdYrk7PuYR3V5tXYyN-hceo5w@mail.gmail.com>
Subject: Re: [PATCH v6 5/5] drm/bridge: anx7625: add HDMI audio function
To:     Xin Ji <xji@analogixsemi.com>
Cc:     Nicolas Boichat <drinkcat@google.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>, Torsten Duwe <duwe@lst.de>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sheng Pan <span@analogixsemi.com>,
        Bernie Liang <bliang@analogixsemi.com>,
        Zhen Li <zhenli@analogixsemi.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devel@driverdev.osuosl.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Xin,

This patch looks good to me.

Reviewed-by: Robert Foss <robert.foss@linaro.org>

On Fri, 19 Mar 2021 at 07:35, Xin Ji <xji@analogixsemi.com> wrote:
>
> Add audio HDMI codec function support, enable it through device true flag
> "analogix,audio-enable".
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Xin Ji <xji@analogixsemi.com>
> ---
>  drivers/gpu/drm/bridge/analogix/anx7625.c | 227 ++++++++++++++++++++++
>  drivers/gpu/drm/bridge/analogix/anx7625.h |   5 +
>  2 files changed, 232 insertions(+)
>
> diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
> index b424a570effa..02bb169d9c57 100644
> --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> @@ -30,6 +30,8 @@
>  #include <drm/drm_print.h>
>  #include <drm/drm_probe_helper.h>
>
> +#include <sound/hdmi-codec.h>
> +
>  #include <video/display_timing.h>
>
>  #include "anx7625.h"
> @@ -150,6 +152,20 @@ static int anx7625_write_and(struct anx7625_data *ctx,
>         return anx7625_reg_write(ctx, client, offset, (val & (mask)));
>  }
>
> +static int anx7625_write_and_or(struct anx7625_data *ctx,
> +                               struct i2c_client *client,
> +                               u8 offset, u8 and_mask, u8 or_mask)
> +{
> +       int val;
> +
> +       val = anx7625_reg_read(ctx, client, offset);
> +       if (val < 0)
> +               return val;
> +
> +       return anx7625_reg_write(ctx, client,
> +                                offset, (val & and_mask) | (or_mask));
> +}
> +
>  static int anx7625_config_bit_matrix(struct anx7625_data *ctx)
>  {
>         int i, ret;
> @@ -1498,6 +1514,9 @@ static int anx7625_parse_dt(struct device *dev,
>         else
>                 DRM_DEV_DEBUG_DRIVER(dev, "found MIPI DSI host node.\n");
>
> +       if (of_property_read_bool(np, "analogix,audio-enable"))
> +               pdata->audio_en = 1;
> +
>         ret = drm_of_find_panel_or_bridge(np, 1, 0, &panel, NULL);
>         if (ret < 0) {
>                 if (ret == -ENODEV)
> @@ -1568,6 +1587,208 @@ static enum drm_connector_status anx7625_sink_detect(struct anx7625_data *ctx)
>                                      connector_status_disconnected;
>  }
>
> +static int anx7625_audio_hw_params(struct device *dev, void *data,
> +                                  struct hdmi_codec_daifmt *fmt,
> +                                  struct hdmi_codec_params *params)
> +{
> +       struct anx7625_data *ctx = dev_get_drvdata(dev);
> +       int wl, ch, rate;
> +       int ret = 0;
> +
> +       if (fmt->fmt != HDMI_DSP_A) {
> +               DRM_DEV_ERROR(dev, "only supports DSP_A\n");
> +               return -EINVAL;
> +       }
> +
> +       DRM_DEV_DEBUG_DRIVER(dev, "setting %d Hz, %d bit, %d channels\n",
> +                            params->sample_rate, params->sample_width,
> +                            params->cea.channels);
> +
> +       ret |= anx7625_write_and_or(ctx, ctx->i2c.tx_p2_client,
> +                                   AUDIO_CHANNEL_STATUS_6,
> +                                   ~I2S_SLAVE_MODE,
> +                                   TDM_SLAVE_MODE);
> +
> +       /* Word length */
> +       switch (params->sample_width) {
> +       case 16:
> +               wl = AUDIO_W_LEN_16_20MAX;
> +               break;
> +       case 18:
> +               wl = AUDIO_W_LEN_18_20MAX;
> +               break;
> +       case 20:
> +               wl = AUDIO_W_LEN_20_20MAX;
> +               break;
> +       case 24:
> +               wl = AUDIO_W_LEN_24_24MAX;
> +               break;
> +       default:
> +               DRM_DEV_DEBUG_DRIVER(dev, "wordlength: %d bit not support",
> +                                    params->sample_width);
> +               return -EINVAL;
> +       }
> +       ret |= anx7625_write_and_or(ctx, ctx->i2c.tx_p2_client,
> +                                   AUDIO_CHANNEL_STATUS_5,
> +                                   0xf0, wl);
> +
> +       /* Channel num */
> +       switch (params->cea.channels) {
> +       case 2:
> +               ch = I2S_CH_2;
> +               break;
> +       case 4:
> +               ch = TDM_CH_4;
> +               break;
> +       case 6:
> +               ch = TDM_CH_6;
> +               break;
> +       case 8:
> +               ch = TDM_CH_8;
> +               break;
> +       default:
> +               DRM_DEV_DEBUG_DRIVER(dev, "channel number: %d not support",
> +                                    params->cea.channels);
> +               return -EINVAL;
> +       }
> +       ret |= anx7625_write_and_or(ctx, ctx->i2c.tx_p2_client,
> +                              AUDIO_CHANNEL_STATUS_6, 0x1f, ch << 5);
> +       if (ch > I2S_CH_2)
> +               ret |= anx7625_write_or(ctx, ctx->i2c.tx_p2_client,
> +                               AUDIO_CHANNEL_STATUS_6, AUDIO_LAYOUT);
> +       else
> +               ret |= anx7625_write_and(ctx, ctx->i2c.tx_p2_client,
> +                               AUDIO_CHANNEL_STATUS_6, ~AUDIO_LAYOUT);
> +
> +       /* FS */
> +       switch (params->sample_rate) {
> +       case 32000:
> +               rate = AUDIO_FS_32K;
> +               break;
> +       case 44100:
> +               rate = AUDIO_FS_441K;
> +               break;
> +       case 48000:
> +               rate = AUDIO_FS_48K;
> +               break;
> +       case 88200:
> +               rate = AUDIO_FS_882K;
> +               break;
> +       case 96000:
> +               rate = AUDIO_FS_96K;
> +               break;
> +       case 176400:
> +               rate = AUDIO_FS_1764K;
> +               break;
> +       case 192000:
> +               rate = AUDIO_FS_192K;
> +               break;
> +       default:
> +               DRM_DEV_DEBUG_DRIVER(dev, "sample rate: %d not support",
> +                                    params->sample_rate);
> +               return -EINVAL;
> +       }
> +       ret |= anx7625_write_and_or(ctx, ctx->i2c.tx_p2_client,
> +                                   AUDIO_CHANNEL_STATUS_4,
> +                                   0xf0, rate);
> +       ret |= anx7625_write_or(ctx, ctx->i2c.rx_p0_client,
> +                               AP_AV_STATUS, AP_AUDIO_CHG);
> +       if (ret < 0) {
> +               DRM_DEV_ERROR(dev, "IO error : config audio.\n");
> +               return -EIO;
> +       }
> +
> +       return 0;
> +}
> +
> +static void anx7625_audio_shutdown(struct device *dev, void *data)
> +{
> +       DRM_DEV_DEBUG_DRIVER(dev, "stop audio\n");
> +}
> +
> +static int anx7625_hdmi_i2s_get_dai_id(struct snd_soc_component *component,
> +                                      struct device_node *endpoint)
> +{
> +       struct of_endpoint of_ep;
> +       int ret;
> +
> +       ret = of_graph_parse_endpoint(endpoint, &of_ep);
> +       if (ret < 0)
> +               return ret;
> +
> +       /*
> +        * HDMI sound should be located at external DPI port
> +        * Didn't have good way to check where is internal(DSI)
> +        * or external(DPI) bridge
> +        */
> +       return 0;
> +}
> +
> +static void
> +anx7625_audio_update_connector_status(struct anx7625_data *ctx,
> +                                     enum drm_connector_status status)
> +{
> +       if (ctx->plugged_cb && ctx->codec_dev) {
> +               ctx->plugged_cb(ctx->codec_dev,
> +                               status == connector_status_connected);
> +       }
> +}
> +
> +static int anx7625_audio_hook_plugged_cb(struct device *dev, void *data,
> +                                        hdmi_codec_plugged_cb fn,
> +                                        struct device *codec_dev)
> +{
> +       struct anx7625_data *ctx = data;
> +
> +       ctx->plugged_cb = fn;
> +       ctx->codec_dev = codec_dev;
> +       anx7625_audio_update_connector_status(ctx, anx7625_sink_detect(ctx));
> +
> +       return 0;
> +}
> +
> +static const struct hdmi_codec_ops anx7625_codec_ops = {
> +       .hw_params      = anx7625_audio_hw_params,
> +       .audio_shutdown = anx7625_audio_shutdown,
> +       .get_dai_id     = anx7625_hdmi_i2s_get_dai_id,
> +       .hook_plugged_cb = anx7625_audio_hook_plugged_cb,
> +};
> +
> +static void anx7625_unregister_audio(struct anx7625_data *ctx)
> +{
> +       struct device *dev = &ctx->client->dev;
> +
> +       if (ctx->audio_pdev) {
> +               platform_device_unregister(ctx->audio_pdev);
> +               ctx->audio_pdev = NULL;
> +       }
> +
> +       DRM_DEV_DEBUG_DRIVER(dev, "unbound to %s", HDMI_CODEC_DRV_NAME);
> +}
> +
> +static int anx7625_register_audio(struct device *dev, struct anx7625_data *ctx)
> +{
> +       struct hdmi_codec_pdata codec_data = {
> +               .ops = &anx7625_codec_ops,
> +               .max_i2s_channels = 8,
> +               .i2s = 1,
> +               .data = ctx,
> +       };
> +
> +       ctx->audio_pdev = platform_device_register_data(dev,
> +                                                       HDMI_CODEC_DRV_NAME,
> +                                                       PLATFORM_DEVID_AUTO,
> +                                                       &codec_data,
> +                                                       sizeof(codec_data));
> +
> +       if (IS_ERR(ctx->audio_pdev))
> +               return IS_ERR(ctx->audio_pdev);
> +
> +       DRM_DEV_DEBUG_DRIVER(dev, "bound to %s", HDMI_CODEC_DRV_NAME);
> +
> +       return 0;
> +}
> +
>  static int anx7625_attach_dsi(struct anx7625_data *ctx)
>  {
>         struct mipi_dsi_device *dsi;
> @@ -2064,6 +2285,9 @@ static int anx7625_i2c_probe(struct i2c_client *client,
>                                     DRM_MODE_CONNECTOR_DisplayPort;
>         drm_bridge_add(&platform->bridge);
>
> +       if (platform->pdata.audio_en)
> +               anx7625_register_audio(dev, platform);
> +
>         DRM_DEV_DEBUG_DRIVER(dev, "probe done\n");
>
>         return 0;
> @@ -2089,6 +2313,9 @@ static int anx7625_i2c_remove(struct i2c_client *client)
>
>         anx7625_unregister_i2c_dummy_clients(platform);
>
> +       if (platform->pdata.audio_en)
> +               anx7625_unregister_audio(platform);
> +
>         kfree(platform);
>         return 0;
>  }
> diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.h b/drivers/gpu/drm/bridge/analogix/anx7625.h
> index c6f93e4df0ed..d6be2a83fad9 100644
> --- a/drivers/gpu/drm/bridge/analogix/anx7625.h
> +++ b/drivers/gpu/drm/bridge/analogix/anx7625.h
> @@ -111,6 +111,7 @@
>  #define AUDIO_CHANNEL_STATUS_6 0xd5
>  #define TDM_SLAVE_MODE 0x10
>  #define I2S_SLAVE_MODE 0x08
> +#define AUDIO_LAYOUT   0x01
>
>  #define AUDIO_CONTROL_REGISTER 0xe6
>  #define TDM_TIMING_MODE 0x08
> @@ -400,6 +401,7 @@ struct anx7625_platform_data {
>         int intp_irq;
>         int is_dpi;
>         int mipi_lanes;
> +       int audio_en;
>         int dp_lane0_swing_reg_cnt;
>         int lane0_reg_data[DP_TX_SWING_REG_CNT];
>         int dp_lane1_swing_reg_cnt;
> @@ -420,6 +422,7 @@ struct anx7625_i2c_client {
>
>  struct anx7625_data {
>         struct anx7625_platform_data pdata;
> +       struct platform_device *audio_pdev;
>         atomic_t power_status;
>         int hpd_status;
>         int hpd_high_cnt;
> @@ -429,6 +432,8 @@ struct anx7625_data {
>         struct anx7625_i2c_client i2c;
>         struct i2c_client *last_client;
>         struct s_edid_data slimport_edid_p;
> +       struct device *codec_dev;
> +       hdmi_codec_plugged_cb plugged_cb;
>         struct work_struct work;
>         struct workqueue_struct *workqueue;
>         char edid_block;
> --
> 2.25.1
>
