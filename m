Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E120351B40
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236353AbhDASHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234250AbhDARw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 13:52:29 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8D9C08EC8B
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 06:53:49 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id q10so1582587pgj.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 06:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yD5b/gzLfWxFprD6vkCUufgtg2euX6KlqW93zfrVx5U=;
        b=UjU4CBW9ynxiOtzRKTacMyLjU9ADrMWJ08Kvf5VBMhosAqV5BksTrv88PzwDEQ9+wt
         /3MjXN1s4o+4txzeTou50dTwf/DB6AtH02VQc3/RSTxcSKiFvF0nXmMnTAcmMKtCorGT
         iKMlGgMXRaRTlghAw8oIzMdtzqRC0eMiYrUMTGA84RINgqGxzhEqSPVmTkw1XTXeK8gh
         KK/YH81iiwfj8DFkjuG+wlZjnbJOqutOTWd0Jf/LyGqv8AarBIQ9rDv3/iz7CDK5zYCs
         65AqRKAJ632pgvwGasbVuPF5iTEHcUlICPvzEAbiaszqe8u1Vdouxtrwt+5blClwGpSE
         AbCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yD5b/gzLfWxFprD6vkCUufgtg2euX6KlqW93zfrVx5U=;
        b=r1M/oiyWMR/YDqT3V6+cp0ELg0uBaGFKuEFKMi8u9LLTZ15Drp5uP0/NosGFNbq2QI
         pwwp1jbcgWvMR9PjUlq5XqDnbbpPOgxzSe0UwMAUrujB/kBN56l+hEfFioT1ZO1EIDBM
         yVap2lmEnPLaFW/VN5OY99NJhQawmIM6KJvZrA1eZ6LtWhLvz68t5kWh3GlScngOSBhR
         ZN6LIMzY6Vuz/GHvg2U6kqyu4pnUZwg+b0Q+IK8b3vSO7DaZlygI/zReTTQFUkZJvj/G
         r+dMBaawLRrLijqkUrDbqvawDNWUX6Csv+lhK6Mdco/3ToOrP9YH3vzJNYf8inf38Y2F
         Y01w==
X-Gm-Message-State: AOAM532QiRbCmzWvyZ074bK2YqCxZpKzhAEKz+BF1ME7lDQvglpdTss0
        hrDFMgokB51qFJX548/6PKfvU8MVt43IrExkJrSqAA==
X-Google-Smtp-Source: ABdhPJy5DYOPKKnRX114DQl0YHOOuo+r3HgpopfnEbz9F1iol7spMs9Is0Zt6IXeGUVhI52/sDE8h3+deu5556yN03A=
X-Received: by 2002:aa7:980a:0:b029:20c:5402:5de9 with SMTP id
 e10-20020aa7980a0000b029020c54025de9mr7703266pfl.18.1617285228504; Thu, 01
 Apr 2021 06:53:48 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1616135353.git.xji@analogixsemi.com> <3e47928977e1386d78de7eb05be6a73d9ffaa616.1616135353.git.xji@analogixsemi.com>
In-Reply-To: <3e47928977e1386d78de7eb05be6a73d9ffaa616.1616135353.git.xji@analogixsemi.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Thu, 1 Apr 2021 15:53:37 +0200
Message-ID: <CAG3jFysh_Pg0pBaSN-mHNO01wMG5APkH9iJ63q_1tRgbtXUH-g@mail.gmail.com>
Subject: Re: [PATCH v6 3/5] drm/bridge: anx7625: add MIPI DPI input feature support
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

This patch looks good to me, feel free to add my r-b.

Reviewed-by: Robert Foss <robert.foss@linaro.org>

On Fri, 19 Mar 2021 at 07:34, Xin Ji <xji@analogixsemi.com> wrote:
>
> Add MIPI rx DPI input support.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Xin Ji <xji@analogixsemi.com>
> ---
>  drivers/gpu/drm/bridge/analogix/anx7625.c | 245 ++++++++++++++++------
>  drivers/gpu/drm/bridge/analogix/anx7625.h |  18 +-
>  2 files changed, 203 insertions(+), 60 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
> index 04536cc7afe7..8c514b46d361 100644
> --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> @@ -150,18 +150,18 @@ static int anx7625_write_and(struct anx7625_data *ctx,
>         return anx7625_reg_write(ctx, client, offset, (val & (mask)));
>  }
>
> -static int anx7625_write_and_or(struct anx7625_data *ctx,
> -                               struct i2c_client *client,
> -                               u8 offset, u8 and_mask, u8 or_mask)
> +static int anx7625_config_bit_matrix(struct anx7625_data *ctx)
>  {
> -       int val;
> +       int i, ret;
>
> -       val = anx7625_reg_read(ctx, client, offset);
> -       if (val < 0)
> -               return val;
> +       ret = anx7625_write_or(ctx, ctx->i2c.tx_p2_client,
> +                              AUDIO_CONTROL_REGISTER, 0x80);
> +       for (i = 0; i < 13; i++)
> +               ret |= anx7625_reg_write(ctx, ctx->i2c.tx_p2_client,
> +                                        VIDEO_BIT_MATRIX_12 + i,
> +                                        0x18 + i);
>
> -       return anx7625_reg_write(ctx, client,
> -                                offset, (val & and_mask) | (or_mask));
> +       return ret;
>  }
>
>  static int anx7625_read_ctrl_status_p0(struct anx7625_data *ctx)
> @@ -219,38 +219,6 @@ static int anx7625_video_mute_control(struct anx7625_data *ctx,
>         return ret;
>  }
>
> -static int anx7625_config_audio_input(struct anx7625_data *ctx)
> -{
> -       struct device *dev = &ctx->client->dev;
> -       int ret;
> -
> -       /* Channel num */
> -       ret = anx7625_reg_write(ctx, ctx->i2c.tx_p2_client,
> -                               AUDIO_CHANNEL_STATUS_6, I2S_CH_2 << 5);
> -
> -       /* FS */
> -       ret |= anx7625_write_and_or(ctx, ctx->i2c.tx_p2_client,
> -                                   AUDIO_CHANNEL_STATUS_4,
> -                                   0xf0, AUDIO_FS_48K);
> -       /* Word length */
> -       ret |= anx7625_write_and_or(ctx, ctx->i2c.tx_p2_client,
> -                                   AUDIO_CHANNEL_STATUS_5,
> -                                   0xf0, AUDIO_W_LEN_24_24MAX);
> -       /* I2S */
> -       ret |= anx7625_write_or(ctx, ctx->i2c.tx_p2_client,
> -                               AUDIO_CHANNEL_STATUS_6, I2S_SLAVE_MODE);
> -       ret |= anx7625_write_and(ctx, ctx->i2c.tx_p2_client,
> -                                AUDIO_CONTROL_REGISTER, ~TDM_TIMING_MODE);
> -       /* Audio change flag */
> -       ret |= anx7625_write_or(ctx, ctx->i2c.rx_p0_client,
> -                               AP_AV_STATUS, AP_AUDIO_CHG);
> -
> -       if (ret < 0)
> -               DRM_DEV_ERROR(dev, "fail to config audio.\n");
> -
> -       return ret;
> -}
> -
>  /* Reduction of fraction a/b */
>  static void anx7625_reduction_of_a_fraction(unsigned long *a, unsigned long *b)
>  {
> @@ -410,7 +378,7 @@ static int anx7625_dsi_video_timing_config(struct anx7625_data *ctx)
>         ret |= anx7625_write_and(ctx, ctx->i2c.rx_p1_client,
>                         MIPI_LANE_CTRL_0, 0xfc);
>         ret |= anx7625_write_or(ctx, ctx->i2c.rx_p1_client,
> -                               MIPI_LANE_CTRL_0, 3);
> +                               MIPI_LANE_CTRL_0, ctx->pdata.mipi_lanes - 1);
>
>         /* Htotal */
>         htotal = ctx->dt.hactive.min + ctx->dt.hfront_porch.min +
> @@ -595,6 +563,76 @@ static int anx7625_dsi_config(struct anx7625_data *ctx)
>         return ret;
>  }
>
> +static int anx7625_api_dpi_config(struct anx7625_data *ctx)
> +{
> +       struct device *dev = &ctx->client->dev;
> +       u16 freq = ctx->dt.pixelclock.min / 1000;
> +       int ret;
> +
> +       /* configure pixel clock */
> +       ret = anx7625_reg_write(ctx, ctx->i2c.rx_p0_client,
> +                               PIXEL_CLOCK_L, freq & 0xFF);
> +       ret |= anx7625_reg_write(ctx, ctx->i2c.rx_p0_client,
> +                                PIXEL_CLOCK_H, (freq >> 8));
> +
> +       /* set DPI mode */
> +       /* set to DPI PLL module sel */
> +       ret |= anx7625_reg_write(ctx, ctx->i2c.rx_p1_client,
> +                                MIPI_DIGITAL_PLL_9, 0x20);
> +       /* power down MIPI */
> +       ret |= anx7625_reg_write(ctx, ctx->i2c.rx_p1_client,
> +                                MIPI_LANE_CTRL_10, 0x08);
> +       /* enable DPI mode */
> +       ret |= anx7625_reg_write(ctx, ctx->i2c.rx_p1_client,
> +                                MIPI_DIGITAL_PLL_18, 0x1C);
> +       /* set first edge */
> +       ret |= anx7625_reg_write(ctx, ctx->i2c.tx_p2_client,
> +                                VIDEO_CONTROL_0, 0x06);
> +       if (ret < 0)
> +               DRM_DEV_ERROR(dev, "IO error : dpi phy set failed.\n");
> +
> +       return ret;
> +}
> +
> +static int anx7625_dpi_config(struct anx7625_data *ctx)
> +{
> +       struct device *dev = &ctx->client->dev;
> +       int ret;
> +
> +       DRM_DEV_DEBUG_DRIVER(dev, "config dpi\n");
> +
> +       /* DSC disable */
> +       ret = anx7625_write_and(ctx, ctx->i2c.rx_p0_client,
> +                               R_DSC_CTRL_0, ~DSC_EN);
> +       if (ret < 0) {
> +               DRM_DEV_ERROR(dev, "IO error : disable dsc failed.\n");
> +               return ret;
> +       }
> +
> +       ret = anx7625_config_bit_matrix(ctx);
> +       if (ret < 0) {
> +               DRM_DEV_ERROR(dev, "config bit matrix failed.\n");
> +               return ret;
> +       }
> +
> +       ret = anx7625_api_dpi_config(ctx);
> +       if (ret < 0) {
> +               DRM_DEV_ERROR(dev, "mipi phy(dpi) setup failed.\n");
> +               return ret;
> +       }
> +
> +       /* set MIPI RX EN */
> +       ret = anx7625_write_or(ctx, ctx->i2c.rx_p0_client,
> +                              AP_AV_STATUS, AP_MIPI_RX_EN);
> +       /* clear mute flag */
> +       ret |= anx7625_write_and(ctx, ctx->i2c.rx_p0_client,
> +                                AP_AV_STATUS, (u8)~AP_MIPI_MUTE);
> +       if (ret < 0)
> +               DRM_DEV_ERROR(dev, "IO error : enable mipi rx failed.\n");
> +
> +       return ret;
> +}
> +
>  static void anx7625_dp_start(struct anx7625_data *ctx)
>  {
>         int ret;
> @@ -605,9 +643,10 @@ static void anx7625_dp_start(struct anx7625_data *ctx)
>                 return;
>         }
>
> -       anx7625_config_audio_input(ctx);
> -
> -       ret = anx7625_dsi_config(ctx);
> +       if (ctx->pdata.is_dpi)
> +               ret = anx7625_dpi_config(ctx);
> +       else
> +               ret = anx7625_dsi_config(ctx);
>
>         if (ret < 0)
>                 DRM_DEV_ERROR(dev, "MIPI phy setup error.\n");
> @@ -1051,6 +1090,7 @@ static void anx7625_start_dp_work(struct anx7625_data *ctx)
>                 return;
>         }
>
> +       ctx->hpd_status = 1;
>         ctx->hpd_high_cnt++;
>
>         /* Not support HDCP */
> @@ -1060,8 +1100,10 @@ static void anx7625_start_dp_work(struct anx7625_data *ctx)
>         ret |= anx7625_write_or(ctx, ctx->i2c.rx_p1_client, 0xec, 0x10);
>         /* Interrupt for DRM */
>         ret |= anx7625_write_or(ctx, ctx->i2c.rx_p1_client, 0xff, 0x01);
> -       if (ret < 0)
> +       if (ret < 0) {
> +               DRM_DEV_ERROR(dev, "fail to setting HDCP/auth\n");
>                 return;
> +       }
>
>         ret = anx7625_reg_read(ctx, ctx->i2c.rx_p1_client, 0x86);
>         if (ret < 0)
> @@ -1080,6 +1122,10 @@ static void anx7625_hpd_polling(struct anx7625_data *ctx)
>         int ret, val;
>         struct device *dev = &ctx->client->dev;
>
> +       /* Interrupt mode, no need poll HPD status, just return */
> +       if (ctx->pdata.intp_irq)
> +               return;
> +
>         if (atomic_read(&ctx->power_status) != 1) {
>                 DRM_DEV_DEBUG_DRIVER(dev, "No need to poling HPD status.\n");
>                 return;
> @@ -1130,6 +1176,21 @@ static void anx7625_remove_edid(struct anx7625_data *ctx)
>         ctx->slimport_edid_p.edid_block_num = -1;
>  }
>
> +static void anx7625_dp_adjust_swing(struct anx7625_data *ctx)
> +{
> +       int i;
> +
> +       for (i = 0; i < ctx->pdata.dp_lane0_swing_reg_cnt; i++)
> +               anx7625_reg_write(ctx, ctx->i2c.tx_p1_client,
> +                                 DP_TX_LANE0_SWING_REG0 + i,
> +                                 ctx->pdata.lane0_reg_data[i] & 0xFF);
> +
> +       for (i = 0; i < ctx->pdata.dp_lane1_swing_reg_cnt; i++)
> +               anx7625_reg_write(ctx, ctx->i2c.tx_p1_client,
> +                                 DP_TX_LANE1_SWING_REG0 + i,
> +                                 ctx->pdata.lane1_reg_data[i] & 0xFF);
> +}
> +
>  static void dp_hpd_change_handler(struct anx7625_data *ctx, bool on)
>  {
>         struct device *dev = &ctx->client->dev;
> @@ -1145,9 +1206,8 @@ static void dp_hpd_change_handler(struct anx7625_data *ctx, bool on)
>         } else {
>                 DRM_DEV_DEBUG_DRIVER(dev, " HPD high\n");
>                 anx7625_start_dp_work(ctx);
> +               anx7625_dp_adjust_swing(ctx);
>         }
> -
> -       ctx->hpd_status = 1;
>  }
>
>  static int anx7625_hpd_change_detect(struct anx7625_data *ctx)
> @@ -1224,20 +1284,72 @@ static irqreturn_t anx7625_intr_hpd_isr(int irq, void *data)
>         return IRQ_HANDLED;
>  }
>
> +static int anx7625_get_swing_setting(struct device *dev,
> +                                    struct anx7625_platform_data *pdata)
> +{
> +       int num_regs;
> +
> +       if (of_get_property(dev->of_node,
> +                           "analogix,lane0-swing", &num_regs)) {
> +               if (num_regs > DP_TX_SWING_REG_CNT)
> +                       num_regs = DP_TX_SWING_REG_CNT;
> +
> +               pdata->dp_lane0_swing_reg_cnt = num_regs;
> +               of_property_read_u32_array(dev->of_node, "analogix,lane0-swing",
> +                                          pdata->lane0_reg_data, num_regs);
> +       }
> +
> +       if (of_get_property(dev->of_node,
> +                           "analogix,lane1-swing", &num_regs)) {
> +               if (num_regs > DP_TX_SWING_REG_CNT)
> +                       num_regs = DP_TX_SWING_REG_CNT;
> +
> +               pdata->dp_lane1_swing_reg_cnt = num_regs;
> +               of_property_read_u32_array(dev->of_node, "analogix,lane1-swing",
> +                                          pdata->lane1_reg_data, num_regs);
> +       }
> +
> +       return 0;
> +}
> +
>  static int anx7625_parse_dt(struct device *dev,
>                             struct anx7625_platform_data *pdata)
>  {
> -       struct device_node *np = dev->of_node;
> +       struct device_node *np = dev->of_node, *ep0;
>         struct drm_panel *panel;
>         int ret;
> +       int bus_type, mipi_lanes;
>
> +       anx7625_get_swing_setting(dev, pdata);
> +
> +       pdata->is_dpi = 1; /* default dpi mode */
>         pdata->mipi_host_node = of_graph_get_remote_node(np, 0, 0);
>         if (!pdata->mipi_host_node) {
>                 DRM_DEV_ERROR(dev, "fail to get internal panel.\n");
>                 return -ENODEV;
>         }
>
> -       DRM_DEV_DEBUG_DRIVER(dev, "found dsi host node.\n");
> +       bus_type = 5;
> +       mipi_lanes = MAX_LANES_SUPPORT;
> +       ep0 = of_graph_get_endpoint_by_regs(np, 0, 0);
> +       if (ep0) {
> +               if (of_property_read_u32(ep0, "bus-type", &bus_type))
> +                       bus_type = 0;
> +
> +               mipi_lanes = of_property_count_u32_elems(ep0, "data-lanes");
> +       }
> +
> +       if (bus_type == 5) /* bus type is Parallel(DSI) */
> +               pdata->is_dpi = 0;
> +
> +       pdata->mipi_lanes = mipi_lanes;
> +       if (pdata->mipi_lanes > MAX_LANES_SUPPORT || pdata->mipi_lanes <= 0)
> +               pdata->mipi_lanes = MAX_LANES_SUPPORT;
> +
> +       if (pdata->is_dpi)
> +               DRM_DEV_DEBUG_DRIVER(dev, "found MIPI DPI host node.\n");
> +       else
> +               DRM_DEV_DEBUG_DRIVER(dev, "found MIPI DSI host node.\n");
>
>         ret = drm_of_find_panel_or_bridge(np, 1, 0, &panel, NULL);
>         if (ret < 0) {
> @@ -1300,9 +1412,13 @@ static enum drm_connector_status anx7625_sink_detect(struct anx7625_data *ctx)
>  {
>         struct device *dev = &ctx->client->dev;
>
> -       DRM_DEV_DEBUG_DRIVER(dev, "sink detect, return connected\n");
> +       DRM_DEV_DEBUG_DRIVER(dev, "sink detect\n");
> +
> +       if (ctx->pdata.panel_bridge)
> +               return connector_status_connected;
>
> -       return connector_status_connected;
> +       return ctx->hpd_status ? connector_status_connected :
> +                                    connector_status_disconnected;
>  }
>
>  static int anx7625_attach_dsi(struct anx7625_data *ctx)
> @@ -1330,7 +1446,7 @@ static int anx7625_attach_dsi(struct anx7625_data *ctx)
>                 return -EINVAL;
>         }
>
> -       dsi->lanes = 4;
> +       dsi->lanes = ctx->pdata.mipi_lanes;
>         dsi->format = MIPI_DSI_FMT_RGB888;
>         dsi->mode_flags = MIPI_DSI_MODE_VIDEO   |
>                 MIPI_DSI_MODE_VIDEO_SYNC_PULSE  |
> @@ -1376,10 +1492,12 @@ static int anx7625_bridge_attach(struct drm_bridge *bridge,
>                 return -ENODEV;
>         }
>
> -       err = anx7625_attach_dsi(ctx);
> -       if (err) {
> -               DRM_DEV_ERROR(dev, "Fail to attach to dsi : %d\n", err);
> -               return err;
> +       if (!ctx->pdata.is_dpi) {
> +               err = anx7625_attach_dsi(ctx);
> +               if (err) {
> +                       DRM_DEV_ERROR(dev, "Fail to attach to dsi : %d\n", err);
> +                       return err;
> +               }
>         }
>
>         if (ctx->pdata.panel_bridge) {
> @@ -1478,6 +1596,10 @@ static bool anx7625_bridge_mode_fixup(struct drm_bridge *bridge,
>
>         DRM_DEV_DEBUG_DRIVER(dev, "drm mode fixup set\n");
>
> +       /* No need fixup for external monitor */
> +       if (!ctx->pdata.panel_bridge)
> +               return true;
> +
>         hsync = mode->hsync_end - mode->hsync_start;
>         hfp = mode->hsync_start - mode->hdisplay;
>         hbp = mode->htotal - mode->hsync_end;
> @@ -1786,8 +1908,13 @@ static int anx7625_i2c_probe(struct i2c_client *client,
>
>         platform->bridge.funcs = &anx7625_bridge_funcs;
>         platform->bridge.of_node = client->dev.of_node;
> -       platform->bridge.ops = DRM_BRIDGE_OP_EDID | DRM_BRIDGE_OP_HPD;
> -       platform->bridge.type = DRM_MODE_CONNECTOR_eDP;
> +       platform->bridge.ops = DRM_BRIDGE_OP_EDID;
> +       if (!platform->pdata.panel_bridge)
> +               platform->bridge.ops |= DRM_BRIDGE_OP_HPD |
> +                                       DRM_BRIDGE_OP_DETECT;
> +       platform->bridge.type = platform->pdata.panel_bridge ?
> +                                   DRM_MODE_CONNECTOR_eDP :
> +                                   DRM_MODE_CONNECTOR_DisplayPort;
>         drm_bridge_add(&platform->bridge);
>
>         DRM_DEV_DEBUG_DRIVER(dev, "probe done\n");
> diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.h b/drivers/gpu/drm/bridge/analogix/anx7625.h
> index 193ad86c5450..beee95da2155 100644
> --- a/drivers/gpu/drm/bridge/analogix/anx7625.h
> +++ b/drivers/gpu/drm/bridge/analogix/anx7625.h
> @@ -141,12 +141,20 @@
>  #define  HORIZONTAL_BACK_PORCH_H      0x22  /* Bit[7:4] are reserved */
>
>  /******** END of I2C Address 0x72 *********/
> +
> +/***************************************************************/
> +/* Register definition of device address 0x7a */
> +#define DP_TX_SWING_REG_CNT            0x14
> +#define DP_TX_LANE0_SWING_REG0         0x00
> +#define DP_TX_LANE1_SWING_REG0         0x14
> +/******** END of I2C Address 0x7a *********/
> +
>  /***************************************************************/
>  /* Register definition of device address 0x7e */
>devm_drm_panel_bridge_add
>  #define  I2C_ADDR_7E_FLASH_CONTROLLER  0x7E
>
> -#define FLASH_LOAD_STA 0x05
> +#define FLASH_LOAD_STA          0x05
>  #define FLASH_LOAD_STA_CHK     BIT(7)
>
>  #define  XTAL_FRQ_SEL    0x3F
> @@ -347,11 +355,19 @@ struct s_edid_data {
>
>  /***************** Display End *****************/
>
> +#define MAX_LANES_SUPPORT      4
> +
>  struct anx7625_platform_data {
>         struct gpio_desc *gpio_p_on;
>         struct gpio_desc *gpio_reset;
>         struct drm_bridge *panel_bridge;
>         int intp_irq;
> +       int is_dpi;
> +       int mipi_lanes;
> +       int dp_lane0_swing_reg_cnt;
> +       int lane0_reg_data[DP_TX_SWING_REG_CNT];
> +       int dp_lane1_swing_reg_cnt;
> +       int lane1_reg_data[DP_TX_SWING_REG_CNT];
>         u32 low_power_mode;
>         struct device_node *mipi_host_node;
>  };
> --
> 2.25.1
>
