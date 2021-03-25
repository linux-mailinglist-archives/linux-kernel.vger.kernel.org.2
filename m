Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2728349963
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 19:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbhCYSUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 14:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbhCYSUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 14:20:01 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F277C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 11:20:00 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id r193so2817457ior.9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 11:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jztuZCsJ3dGtTwFcpg97sv7/WRCiv8qcjsd5QekOjAg=;
        b=bAa0pT0QLb7YWNM3N9UgKIMJ+0OpK6WlT+U4ZwR7hFjYH2O30GMT9mfyrs7cRerdO7
         BKT8BRqIBE169yPmDvXZ3oIZzftEUAfyQmTg7b2L0HCSK93/kPSUw+M4u+lYqAfkOLIx
         UCCMdTYFsBejhcueDUbVXgOmzRdMXcv7dR5PI/k9qBNKfkbI0TPwAGHvzpeMzKhbdRTB
         rSv2ouFwnhDIBpDFzK3Was9cdvjltQ8dfXtHHfEBMriOEDTlC6adbdFOOBGXHAuWfFG+
         /jEhDn8foPwDM72l3vl52rXynQLARQM6k0mRB/X7bTPcXLD819BfAawF28eSK0kGKwQO
         ACzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jztuZCsJ3dGtTwFcpg97sv7/WRCiv8qcjsd5QekOjAg=;
        b=qdGDUnVN6aR1qUA27d5+X4wJx4hXa+tkQR1Jdg70rcmv9H6CdwwEzeQvhu9GV4svlg
         BZgg9eWpco26DcFuHHrkZh1TBblEAIS0fv6AUvoqQIzTQFGSqdLbBW+QUzoEUwryu1N7
         u03iNpKFq7MPlh1EuvN0nfUwUruXeVC118yxbobxmMJoEK9dRwH0eL24cTsA2Teo5hKe
         +vcTYWdZVUUYNqFCZf/YQac3lJwxRDP8AIqw7WgrwCYYBiZl/KeNaJHMhjZu+5GznSvn
         GBj8NJXNvOh14Nw/OrEVxGqZjrL67MB5hxY3WpHPSfPI/0YsYRhRg+6jFwtpWEZrDdxp
         1QcQ==
X-Gm-Message-State: AOAM532inxa4rwxg5f5VcoQaZ71WuxhzkkndiGr7+6aBpp0JXnEpbAxy
        KCqb7lBukY4+Nr77siFlHcG0Y6QydrjspRyPxkkOTQ==
X-Google-Smtp-Source: ABdhPJzeHTjo12dsPjm8wvAgYcR7pyTo3HM6vo89+UsNYre8lKCzHJknkINEDtGgzipfVOOZZT4EQ1IZCaAFCOMFLkk=
X-Received: by 2002:a05:6638:1390:: with SMTP id w16mr8681618jad.83.1616696399826;
 Thu, 25 Mar 2021 11:19:59 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1616135353.git.xji@analogixsemi.com> <189a637c87827f78c433a053e3c2129ebec73188.1616135353.git.xji@analogixsemi.com>
In-Reply-To: <189a637c87827f78c433a053e3c2129ebec73188.1616135353.git.xji@analogixsemi.com>
From:   Sean Paul <sean@poorly.run>
Date:   Thu, 25 Mar 2021 14:19:23 -0400
Message-ID: <CAMavQKLN04F2rzu7J121N4GvQKh7kq9yXGk+fBSUjsC2nbiSiA@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] drm/bridge: anx7625: add HDCP support
To:     Xin Ji <xji@analogixsemi.com>
Cc:     Robert Foss <robert.foss@linaro.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        devel@driverdev.osuosl.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sheng Pan <span@analogixsemi.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        David Airlie <airlied@linux.ie>,
        Bernie Liang <bliang@analogixsemi.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Zhen Li <zhenli@analogixsemi.com>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Torsten Duwe <duwe@lst.de>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2021 at 2:35 AM Xin Ji <xji@analogixsemi.com> wrote:
>
> Add HDCP feature, enable HDCP function through chip internal key
> and downstream's capability.
>
> Signed-off-by: Xin Ji <xji@analogixsemi.com>
> ---
>  drivers/gpu/drm/bridge/analogix/anx7625.c | 147 ++++++++++++++++++++++
>  drivers/gpu/drm/bridge/analogix/anx7625.h |  36 ++++++
>  2 files changed, 183 insertions(+)
>
> diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
> index 8c514b46d361..b424a570effa 100644
> --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> @@ -633,6 +633,150 @@ static int anx7625_dpi_config(struct anx7625_data *ctx)
>         return ret;
>  }
>
> +static int anx7625_aux_dpcd_read(struct anx7625_data *ctx,
> +                                u8 addrh, u8 addrm, u8 addrl,
> +                                u8 len, u8 *buf)
> +{
> +       struct device *dev = &ctx->client->dev;
> +       int ret;
> +       u8 cmd;
> +
> +       if (len > MAX_DPCD_BUFFER_SIZE) {
> +               DRM_DEV_ERROR(dev, "exceed aux buffer len.\n");
> +               return -E2BIG;
> +       }
> +
> +       cmd = ((len - 1) << 4) | 0x09;
> +
> +       /* Set command and length */
> +       ret = anx7625_reg_write(ctx, ctx->i2c.rx_p0_client,
> +                               AP_AUX_COMMAND, cmd);
> +
> +       /* Set aux access address */
> +       ret |= anx7625_reg_write(ctx, ctx->i2c.rx_p0_client,
> +                                AP_AUX_ADDR_7_0, addrl);
> +       ret |= anx7625_reg_write(ctx, ctx->i2c.rx_p0_client,
> +                                AP_AUX_ADDR_15_8, addrm);
> +       ret |= anx7625_reg_write(ctx, ctx->i2c.rx_p0_client,
> +                                AP_AUX_ADDR_19_16, addrh);
> +
> +       /* Enable aux access */
> +       ret |= anx7625_write_or(ctx, ctx->i2c.rx_p0_client,
> +                               AP_AUX_CTRL_STATUS, AP_AUX_CTRL_OP_EN);
> +
> +       if (ret < 0) {
> +               DRM_DEV_ERROR(dev, "cannot access aux related register.\n");
> +               return -EIO;
> +       }
> +
> +       usleep_range(2000, 2100);
> +
> +       ret = wait_aux_op_finish(ctx);
> +       if (ret) {
> +               DRM_DEV_ERROR(dev, "aux IO error: wait aux op finish.\n");
> +               return ret;
> +       }
> +
> +       ret = anx7625_reg_block_read(ctx, ctx->i2c.rx_p0_client,
> +                                    AP_AUX_BUFF_START, len, buf);
> +       if (ret < 0) {
> +               DRM_DEV_ERROR(dev, "read dpcd register failed\n");
> +               return -EIO;
> +       }
> +
> +       return 0;
> +}
> +
> +static int anx7625_read_flash_status(struct anx7625_data *ctx)
> +{
> +       return anx7625_reg_read(ctx, ctx->i2c.rx_p0_client, R_RAM_CTRL);
> +}
> +
> +static int anx7625_hdcp_key_probe(struct anx7625_data *ctx)
> +{
> +       int ret, val;
> +       struct device *dev = &ctx->client->dev;
> +       u8 ident[32];
> +
> +       ret = anx7625_reg_write(ctx, ctx->i2c.rx_p0_client,
> +                               FLASH_ADDR_HIGH, 0x91);
> +       ret |= anx7625_reg_write(ctx, ctx->i2c.rx_p0_client,
> +                                FLASH_ADDR_LOW, 0xA0);
> +       if (ret < 0) {
> +               DRM_DEV_ERROR(dev, "IO error : set key flash address.\n");
> +               return ret;
> +       }
> +
> +       ret = anx7625_reg_write(ctx, ctx->i2c.rx_p0_client,
> +                               FLASH_LEN_HIGH, (FLASH_BUF_LEN - 1) >> 8);
> +       ret |= anx7625_reg_write(ctx, ctx->i2c.rx_p0_client,
> +                                FLASH_LEN_LOW, (FLASH_BUF_LEN - 1) & 0xFF);
> +       if (ret < 0) {
> +               DRM_DEV_ERROR(dev, "IO error : set key flash len.\n");
> +               return ret;
> +       }
> +
> +       ret = anx7625_reg_write(ctx, ctx->i2c.rx_p0_client,
> +                               R_FLASH_RW_CTRL, FLASH_READ);
> +       ret |= readx_poll_timeout(anx7625_read_flash_status,
> +                                 ctx, val,
> +                                 ((val & FLASH_DONE) || (val < 0)),
> +                                 2000,
> +                                 2000 * 150);
> +       if (ret) {
> +               DRM_DEV_ERROR(dev, "flash read access fail!\n");
> +               return -EIO;
> +       }
> +
> +       ret = anx7625_reg_block_read(ctx, ctx->i2c.rx_p0_client,
> +                                    FLASH_BUF_BASE_ADDR,
> +                                    FLASH_BUF_LEN, ident);
> +       if (ret < 0) {
> +               DRM_DEV_ERROR(dev, "read flash data fail!\n");
> +               return -EIO;
> +       }
> +
> +       if (ident[29] == 0xFF && ident[30] == 0xFF && ident[31] == 0xFF)
> +               return -EINVAL;
> +
> +       return 0;
> +}
> +
> +static int anx7625_hdcp_setting(struct anx7625_data *ctx)
> +{
> +       u8 bcap;
> +       int ret;
> +       struct device *dev = &ctx->client->dev;
> +
> +       ret = anx7625_hdcp_key_probe(ctx);
> +       if (ret) {
> +               DRM_DEV_DEBUG_DRIVER(dev, "disable HDCP by config\n");
> +               return anx7625_write_and(ctx, ctx->i2c.rx_p1_client,
> +                                        0xee, 0x9f);
> +       }
> +
> +       anx7625_aux_dpcd_read(ctx, 0x06, 0x80, 0x28, 1, &bcap);
> +       if (!(bcap & 0x01)) {
> +               DRM_DEV_DEBUG_DRIVER(dev, "bcap(0x%x) not support HDCP 1.4.\n",
> +                                    bcap);
> +               return anx7625_write_and(ctx, ctx->i2c.rx_p1_client,
> +                                        0xee, 0x9f);
> +       }
> +
> +       DRM_DEV_DEBUG_DRIVER(dev, "enable HDCP 1.4\n");
> +
> +       ret = anx7625_write_or(ctx, ctx->i2c.rx_p1_client, 0xee, 0x20);
> +
> +       /* Try auth flag */
> +       ret |= anx7625_write_or(ctx, ctx->i2c.rx_p1_client, 0xec, 0x10);
> +       /* Interrupt for DRM */
> +       ret |= anx7625_write_or(ctx, ctx->i2c.rx_p1_client, 0xff, 0x01);
> +       if (ret < 0)
> +               DRM_DEV_ERROR(dev, "fail to enable HDCP\n");
> +
> +       return ret;
> +}
> +
>  static void anx7625_dp_start(struct anx7625_data *ctx)
>  {
>         int ret;
> @@ -643,6 +787,9 @@ static void anx7625_dp_start(struct anx7625_data *ctx)
>                 return;
>         }
>
> +       /* HDCP config */
> +       anx7625_hdcp_setting(ctx);

You should really use the "Content Protection" property to
enable/disable HDCP instead of force-enabling it at all times.

Sean

> +
>         if (ctx->pdata.is_dpi)
>                 ret = anx7625_dpi_config(ctx);
>         else
> diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.h b/drivers/gpu/drm/bridge/analogix/anx7625.h
> index beee95da2155..c6f93e4df0ed 100644
> --- a/drivers/gpu/drm/bridge/analogix/anx7625.h
> +++ b/drivers/gpu/drm/bridge/analogix/anx7625.h
> @@ -154,9 +154,45 @@
>
>  #define  I2C_ADDR_7E_FLASH_CONTROLLER  0x7E
>
> +#define FLASH_SRAM_SEL          0x00
> +#define SRAM_ADDR_HIGH          0x01
> +#define SRAM_ADDR_LOW           0x02
> +#define SRAM_LEN_HIGH           0x03
> +#define SRAM_LEN_LOW            0x04
>  #define FLASH_LOAD_STA          0x05
>  #define FLASH_LOAD_STA_CHK     BIT(7)
>
> +#define R_RAM_CTRL              0x05
> +/* bit positions */
> +#define FLASH_DONE              BIT(7)
> +#define BOOT_LOAD_DONE          BIT(6)
> +#define CRC_OK                  BIT(5)
> +#define LOAD_DONE               BIT(4)
> +#define O_RW_DONE               BIT(3)
> +#define FUSE_BUSY               BIT(2)
> +#define DECRYPT_EN              BIT(1)
> +#define LOAD_START              BIT(0)
> +
> +#define FLASH_ADDR_HIGH         0x0F
> +#define FLASH_ADDR_LOW          0x10
> +#define FLASH_LEN_HIGH          0x31
> +#define FLASH_LEN_LOW           0x32
> +
> +#define R_FLASH_RW_CTRL         0x33
> +/* bit positions */
> +#define READ_DELAY_SELECT       BIT(7)
> +#define GENERAL_INSTRUCTION_EN  BIT(6)
> +#define FLASH_ERASE_EN          BIT(5)
> +#define RDID_READ_EN            BIT(4)
> +#define REMS_READ_EN            BIT(3)
> +#define WRITE_STATUS_EN         BIT(2)
> +#define FLASH_READ              BIT(1)
> +#define FLASH_WRITE             BIT(0)
> +
> +#define FLASH_BUF_BASE_ADDR     0x60
> +#define FLASH_BUF_LEN           0x20
> +#define FLASH_KEY_OFFSET        0x8000
> +
>  #define  XTAL_FRQ_SEL    0x3F
>  /* bit field positions */
>  #define  XTAL_FRQ_SEL_POS    5
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
