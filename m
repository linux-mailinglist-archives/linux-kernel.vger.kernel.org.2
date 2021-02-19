Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0C831FB93
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 16:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbhBSPCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 10:02:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbhBSPBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 10:01:49 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60047C061574;
        Fri, 19 Feb 2021 07:01:06 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id g5so13979740ejt.2;
        Fri, 19 Feb 2021 07:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nOuajdZZT+pzxQ6QpHmUKL6Rqr7YpWjEliQ+MUsmWoE=;
        b=uGqkyRSD5lCzHh9SPsYmov7/F0MVm1dcJLGq0XMtQ6ZfjMPBgicWgWF8TiTHbCAlmU
         E8SaKZFYWS3tIajqwzix195vdmiU8pL5q23IkVXPO9FE+IXIoLmNSA9ZXS4vWdBeeSPy
         kgQTnj3Hs11GTXfC2Qd5lIuIQ7yjs74/Wh5U2rWOVws6IyFmt0Bc+c3/tRf12/EMwFHF
         eYtJ54Ok0kgLpVNpoPradtwCSr9J8FOvn9JnCTmUaKZhK3bSl5OeA5IBr929dAntH1YK
         Qet5geM0j0C1kzBI0hx1R7VJN9eRS4l7+jqk+aHysocJfq84B/F8kvcP2q11Cp3+XdVX
         kRtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nOuajdZZT+pzxQ6QpHmUKL6Rqr7YpWjEliQ+MUsmWoE=;
        b=Vr99szz20OIkorJmV5Nhj71WhCYEuEeBfmV93OH47vVzDPuK9fZsT7eBvt7b02+HGd
         P76Ag0lQOSHG4bKF76vhuAjQ/bbpelqIL7wJ/ian7cCna+qMfjoGHEZbiq0uLKKkB6Zj
         /BOio0S0cfKImZJJ4tTnUb7cSbCVo+VF4GGmXLBcR5Ikn/KMLJGqVyLq1uj2C/g6udn+
         5/wdi9CRnd+kojj3YPtxBX/X4XvCoejOK86ALEtftNbegIisMbpQ6ftGD6gipkKruPmR
         7d2l0U1BrtfF+FfiFL8ap/2Tum+gP8rcG8x42zWsjbGU8BDqNSp7USbn3DN/zNsbqiQt
         JRPQ==
X-Gm-Message-State: AOAM531pUstgK0kWBt/0Hzl0HAkinYTOBxzxeV92c+FYb/c19J1kMLIz
        s/ocnjxiOBcwez/71aaou74Z/R+wagszR1vHnHA=
X-Google-Smtp-Source: ABdhPJwZLox5wFGQ/4gNkIpaZonNXefAwsnQix8JuBeNoNb0+4vLt/Ktsp4S0+0B5tRyQr7Vme81jfmYyPErkxMEHkg=
X-Received: by 2002:a17:906:12db:: with SMTP id l27mr8945326ejb.500.1613746864944;
 Fri, 19 Feb 2021 07:01:04 -0800 (PST)
MIME-Version: 1.0
References: <20210218210504.375752-1-adrien.grassein@gmail.com>
 <20210218210504.375752-3-adrien.grassein@gmail.com> <CAG3jFyuQHxS9mc2k=1GSgwR40r8xbZ9wYguBYhQy8Sb4ma3gxA@mail.gmail.com>
In-Reply-To: <CAG3jFyuQHxS9mc2k=1GSgwR40r8xbZ9wYguBYhQy8Sb4ma3gxA@mail.gmail.com>
From:   Adrien Grassein <adrien.grassein@gmail.com>
Date:   Fri, 19 Feb 2021 16:00:54 +0100
Message-ID: <CABkfQAFRC7AP8qXHu=OCHWVR0+OAeVr+eXH+qprubroq9DiVDg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] drm/bridge: Introduce LT8912 DSI to HDMI bridge
To:     Robert Foss <robert.foss@linaro.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Robert,

Le ven. 19 f=C3=A9vr. 2021 =C3=A0 14:27, Robert Foss <robert.foss@linaro.or=
g> a =C3=A9crit :
>
> Hey Adrien,
>
>
> Thanks for the quick update.
No problem, I have some free time at the moment.
>
> On Thu, 18 Feb 2021 at 22:05, Adrien Grassein <adrien.grassein@gmail.com>=
 wrote:
> >
> > Lontium Lt8912 is a DSI to HDMI bridge.
> >
> > Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
> > ---
> >  MAINTAINERS                             |   1 +
> >  drivers/gpu/drm/bridge/Kconfig          |  14 +
> >  drivers/gpu/drm/bridge/Makefile         |   1 +
> >  drivers/gpu/drm/bridge/lontium-lt8912.c | 760 ++++++++++++++++++++++++
> >  4 files changed, 776 insertions(+)
> >  create mode 100644 drivers/gpu/drm/bridge/lontium-lt8912.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 5d1ed281cd41..58f8f45a7c86 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -10462,6 +10462,7 @@ LONTIUM LT8912 MIPI TO HDMI BRIDGE
> >  M:     Adrien Grassein <adrien.grassein@gmail.com>
> >  S:     Maintained
> >  F:     Documentation/devicetree/bindings/display/bridge/lontium,lt8912=
.yaml
> > +F:     drivers/gpu/drm/bridge/lontium-lt8912.c
> >
> >  LSILOGIC MPT FUSION DRIVERS (FC/SAS/SPI)
> >  M:     Sathya Prakash <sathya.prakash@broadcom.com>
> > diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kc=
onfig
> > index e4110d6ca7b3..5b36d4b86e3c 100644
> > --- a/drivers/gpu/drm/bridge/Kconfig
> > +++ b/drivers/gpu/drm/bridge/Kconfig
> > @@ -48,6 +48,20 @@ config DRM_DISPLAY_CONNECTOR
> >           on ARM-based platforms. Saying Y here when this driver is not=
 needed
> >           will not cause any issue.
> >
> > +config DRM_LONTIUM_LT8912
> > +       tristate "Lontium LT8912 DSI/HDMI bridge"
> > +       depends on OF
> > +       select DRM_PANEL_BRIDGE
> > +       select DRM_KMS_HELPER
> > +       select REGMAP_I2C
> > +       help
> > +         Driver for Lontium LT8912 DSI to HDMI bridge
> > +         chip driver.
> > +         Please say Y if you have such hardware.
> > +
> > +         Say M here if you want to support this hardware as a module.
> > +         The module will be named "lontium-lt8912".
> > +
> >  config DRM_LONTIUM_LT9611
> >         tristate "Lontium LT9611 DSI/HDMI bridge"
> >         select SND_SOC_HDMI_CODEC if SND_SOC
> > diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/M=
akefile
> > index 86e7acc76f8d..5a1b201cea1f 100644
> > --- a/drivers/gpu/drm/bridge/Makefile
> > +++ b/drivers/gpu/drm/bridge/Makefile
> > @@ -2,6 +2,7 @@
> >  obj-$(CONFIG_DRM_CDNS_DSI) +=3D cdns-dsi.o
> >  obj-$(CONFIG_DRM_CHRONTEL_CH7033) +=3D chrontel-ch7033.o
> >  obj-$(CONFIG_DRM_DISPLAY_CONNECTOR) +=3D display-connector.o
> > +obj-$(CONFIG_DRM_LONTIUM_LT8912) +=3D lontium-lt8912.o
> >  obj-$(CONFIG_DRM_LONTIUM_LT9611) +=3D lontium-lt9611.o
> >  obj-$(CONFIG_DRM_LONTIUM_LT9611UXC) +=3D lontium-lt9611uxc.o
> >  obj-$(CONFIG_DRM_LVDS_CODEC) +=3D lvds-codec.o
> > diff --git a/drivers/gpu/drm/bridge/lontium-lt8912.c b/drivers/gpu/drm/=
bridge/lontium-lt8912.c
> > new file mode 100644
> > index 000000000000..8bdb584d22ce
> > --- /dev/null
> > +++ b/drivers/gpu/drm/bridge/lontium-lt8912.c
> > @@ -0,0 +1,760 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
> > + */
> > +
> > +#include <linux/device.h>
> > +#include <linux/delay.h>
> > +#include <linux/i2c.h>
> > +#include <linux/gpio.h>
> > +#include <linux/of_gpio.h>
> > +#include <linux/regmap.h>
> > +
> > +#include <drm/drm_probe_helper.h>
> > +#include <drm/drm_atomic_helper.h>
> > +#include <drm/drm_mipi_dsi.h>
> > +#include <drm/drm_of.h>
> > +
> > +#include <video/videomode.h>
> > +
> > +#define I2C_MAIN 0
> > +#define I2C_ADDR_MAIN 0x48
> > +
> > +#define I2C_CEC_DSI 1
> > +#define I2C_ADDR_CEC_DSI 0x49
> > +
> > +#define I2C_MAX_IDX 2
> > +
> > +struct lt8912 {
> > +       struct device *dev;
> > +       struct drm_bridge bridge;
> > +       struct drm_connector connector;
> > +
> > +       struct i2c_client *i2c_client[I2C_MAX_IDX];
> > +       struct regmap *regmap[I2C_MAX_IDX];
> > +
> > +       struct device_node *host_node;
> > +       struct drm_bridge *hdmi_port;
> > +
> > +       struct mipi_dsi_device *dsi;
> > +
> > +       struct gpio_desc *gp_reset;
> > +
> > +       struct videomode mode;
> > +
> > +       u8 data_lanes;
> > +       bool is_power_on;
> > +       bool is_attached;
> > +};
> > +
> > +static int lt8912_write_init_config(struct lt8912 *lt)
> > +{
> > +       const struct reg_sequence seq[] =3D {
> > +               /* Digital clock en*/
> > +               {0x08, 0xff},
> > +               {0x09, 0xff},
> > +               {0x0a, 0xff},
> > +               {0x0b, 0x7c},
> > +               {0x0c, 0xff},
> > +               {0x42, 0x04},
> > +
> > +               /*Tx Analog*/
> > +               {0x31, 0xb1},
> > +               {0x32, 0xb1},
> > +               {0x33, 0x0e},
> > +               {0x37, 0x00},
> > +               {0x38, 0x22},
> > +               {0x60, 0x82},
> > +
> > +               /*Cbus Analog*/
> > +               {0x39, 0x45},
> > +               {0x3a, 0x00},
> > +               {0x3b, 0x00},
> > +
> > +               /*HDMI Pll Analog*/
> > +               {0x44, 0x31},
> > +               {0x55, 0x44},
> > +               {0x57, 0x01},
> > +               {0x5a, 0x02},
> > +
> > +               /*MIPI Analog*/
> > +               {0x3e, 0xd6},
> > +               {0x3f, 0xd4},
> > +               {0x41, 0x3c},
> > +               {0xB2, 0x00},
> > +       };
> > +
> > +       return regmap_multi_reg_write(lt->regmap[I2C_MAIN], seq, ARRAY_=
SIZE(seq));
> > +}
> > +
> > +static int lt8912_write_mipi_basic_config(struct lt8912 *lt)
> > +{
> > +       const struct reg_sequence seq[] =3D {
> > +               {0x12, 0x04},
> > +               {0x14, 0x00},
> > +               {0x15, 0x00},
> > +               {0x1a, 0x03},
> > +               {0x1b, 0x03},
> > +       };
> > +
> > +       return regmap_multi_reg_write(lt->regmap[I2C_CEC_DSI], seq, ARR=
AY_SIZE(seq));
> > +};
> > +
> > +static int lt8912_write_dds_config(struct lt8912 *lt)
> > +{
> > +       const struct reg_sequence seq[] =3D {
> > +               {0x4e, 0xff},
> > +               {0x4f, 0x56},
> > +               {0x50, 0x69},
> > +               {0x51, 0x80},
> > +               {0x1f, 0x5e},
> > +               {0x20, 0x01},
> > +               {0x21, 0x2c},
> > +               {0x22, 0x01},
> > +               {0x23, 0xfa},
> > +               {0x24, 0x00},
> > +               {0x25, 0xc8},
> > +               {0x26, 0x00},
> > +               {0x27, 0x5e},
> > +               {0x28, 0x01},
> > +               {0x29, 0x2c},
> > +               {0x2a, 0x01},
> > +               {0x2b, 0xfa},
> > +               {0x2c, 0x00},
> > +               {0x2d, 0xc8},
> > +               {0x2e, 0x00},
> > +               {0x42, 0x64},
> > +               {0x43, 0x00},
> > +               {0x44, 0x04},
> > +               {0x45, 0x00},
> > +               {0x46, 0x59},
> > +               {0x47, 0x00},
> > +               {0x48, 0xf2},
> > +               {0x49, 0x06},
> > +               {0x4a, 0x00},
> > +               {0x4b, 0x72},
> > +               {0x4c, 0x45},
> > +               {0x4d, 0x00},
> > +               {0x52, 0x08},
> > +               {0x53, 0x00},
> > +               {0x54, 0xb2},
> > +               {0x55, 0x00},
> > +               {0x56, 0xe4},
> > +               {0x57, 0x0d},
> > +               {0x58, 0x00},
> > +               {0x59, 0xe4},
> > +               {0x5a, 0x8a},
> > +               {0x5b, 0x00},
> > +               {0x5c, 0x34},
> > +               {0x1e, 0x4f},
> > +               {0x51, 0x00},
> > +       };
> > +
> > +       return regmap_multi_reg_write(lt->regmap[I2C_CEC_DSI], seq, ARR=
AY_SIZE(seq));
> > +}
> > +
> > +static int lt8912_write_rxlogicres_config(struct lt8912 *lt)
> > +{
> > +       int ret;
> > +
> > +       ret =3D regmap_write(lt->regmap[I2C_MAIN], 0x03, 0x7f);
> > +       usleep_range(10000, 20000);
> > +       ret |=3D regmap_write(lt->regmap[I2C_MAIN], 0x03, 0xff);
> > +
> > +       return ret;
> > +};
> > +
> > +static int lt8912_write_lvds_config(struct lt8912 *lt)
> > +{
> > +       const struct reg_sequence seq[] =3D {
> > +               {0x44, 0x30},
> > +               {0x51, 0x05},
> > +               {0x50, 0x24},
> > +               {0x51, 0x2d},
> > +               {0x52, 0x04},
> > +               {0x69, 0x0e},
> > +               {0x69, 0x8e},
> > +               {0x6a, 0x00},
> > +               {0x6c, 0xb8},
> > +               {0x6b, 0x51},
> > +               {0x04, 0xfb},
> > +               {0x04, 0xff},
> > +               {0x7f, 0x00},
> > +               {0xa8, 0x13},
> > +               {0x02, 0xf7},
> > +               {0x02, 0xff},
> > +               {0x03, 0xcf},
> > +               {0x03, 0xff},
> > +       };
> > +
> > +       return regmap_multi_reg_write(lt->regmap[I2C_CEC_DSI], seq, ARR=
AY_SIZE(seq));
> > +};
> > +
> > +static inline struct lt8912 *bridge_to_lt8912(struct drm_bridge *b)
> > +{
> > +       return container_of(b, struct lt8912, bridge);
> > +}
> > +
> > +static inline struct lt8912 *connector_to_lt8912(struct drm_connector =
*c)
> > +{
> > +       return container_of(c, struct lt8912, connector);
> > +}
> > +
> > +static const struct regmap_config lt8912_regmap_config =3D {
> > +       .reg_bits =3D 8,
> > +       .val_bits =3D 8,
> > +       .max_register =3D 0xff,
> > +};
> > +
> > +static int lt8912_init_i2c(struct lt8912 *lt)
> > +{
> > +       unsigned int i;
> > +       int ret;
> > +       /*
> > +        * At this time we only initialize 2 chips, but the lt8912 prov=
ides
> > +        * a third interface for the audio over HDMI configuration.
> > +        */
> > +       struct i2c_board_info info[] =3D {
> > +               { I2C_BOARD_INFO("lt8912p0", I2C_ADDR_MAIN), },
> > +               { I2C_BOARD_INFO("lt8912p1", I2C_ADDR_CEC_DSI), },
> > +       };
> > +
> > +       if (!lt)
> > +               return -ENODEV;
> > +
> > +       for (i =3D 0; i < ARRAY_SIZE(info); i++) {
> > +               /*
> > +                * lt->i2c_client[0] was already allocated earlier by t=
he
> > +                * kernel (via DT).
> > +                */
> > +               if (i > 0) {
> > +                       lt->i2c_client[i] =3D i2c_new_dummy_device(lt->=
i2c_client[0]->adapter,
> > +                                                                info[i=
].addr);
> > +                       if (!lt->i2c_client[i])
> > +                               return -ENODEV;
> > +               }
> > +               lt->regmap[i] =3D devm_regmap_init_i2c(lt->i2c_client[i=
],
> > +                                                    &lt8912_regmap_con=
fig);
> > +               if (IS_ERR(lt->regmap[i])) {
> > +                       ret =3D PTR_ERR(lt->regmap[i]);
> > +                       return ret;
> > +               }
> > +       }
> > +       return 0;
> > +}
>
> I had a 2nd look at prior art for bridges with multiple I2C addresses,
> and I think I prefer the implementation in anx7625. Instead of having
> one I2C address provided by the DT and one by the driver, all are
> provided by the driver. If you have any even better suggestions, I'd
> be curious to hear them.
>
> https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/bridge/anal=
ogix/anx7625.c#L1646
>

I check this implementation. I am not a kernel expert (nor a kernel
dev) but I think that
one i2c device is allocated twice (one is provided via DTB, via the
reg property).

I can alloc all the devices on the driver (it is what I did before I
publish my patch set, and so
that was the aim of the for loop).

> > +
> > +static int lt8912_free_i2c(struct lt8912 *lt)
> > +{
> > +       unsigned int i;
> > +
> > +       for (i =3D 1; i < I2C_MAX_IDX; i++)
> > +               i2c_unregister_device(lt->i2c_client[i]);
> > +
> > +       return 0;
> > +}
> > +
> > +static int lt8912_hard_power_on(struct lt8912 *lt)
> > +{
> > +       gpiod_set_value_cansleep(lt->gp_reset, 0);
> > +       msleep(20);
> > +
> > +       return 0;
> > +}
> > +
> > +static void lt8912_hard_power_off(struct lt8912 *lt)
> > +{
> > +       gpiod_set_value_cansleep(lt->gp_reset, 1);
> > +       msleep(20);
> > +       lt->is_power_on =3D false;
> > +}
> > +
> > +static int lt8912_video_setup(struct lt8912 *lt)
> > +{
> > +       u32 hactive, h_total, hpw, hfp, hbp;
> > +       u32 vactive, v_total, vpw, vfp, vbp;
> > +       u8 settle =3D 0x08;
> > +       int ret;
> > +
> > +       if (!lt)
> > +               return -EINVAL;
> > +
> > +       hactive =3D lt->mode.hactive;
> > +       hfp =3D lt->mode.hfront_porch;
> > +       hpw =3D lt->mode.hsync_len;
> > +       hbp =3D lt->mode.hback_porch;
> > +       h_total =3D hactive + hfp + hpw + hbp;
> > +
> > +       vactive =3D lt->mode.vactive;
> > +       vfp =3D lt->mode.vfront_porch;
> > +       vpw =3D lt->mode.vsync_len;
> > +       vbp =3D lt->mode.vback_porch;
> > +       v_total =3D vactive + vfp + vpw + vbp;
> > +
> > +       if (vactive <=3D 600)
> > +               settle =3D 0x04;
> > +       else if (vactive =3D=3D 1080)
> > +               settle =3D 0x0a;
> > +
> > +       ret =3D regmap_write(lt->regmap[I2C_CEC_DSI], 0x10, 0x01);
> > +       ret |=3D regmap_write(lt->regmap[I2C_CEC_DSI], 0x11, settle);
> > +       ret |=3D regmap_write(lt->regmap[I2C_CEC_DSI], 0x18, hpw);
> > +       ret |=3D regmap_write(lt->regmap[I2C_CEC_DSI], 0x19, vpw);
> > +       ret |=3D regmap_write(lt->regmap[I2C_CEC_DSI], 0x1c, hactive & =
0xff);
> > +       ret |=3D regmap_write(lt->regmap[I2C_CEC_DSI], 0x1d, hactive >>=
 8);
> > +
> > +       ret |=3D regmap_write(lt->regmap[I2C_CEC_DSI], 0x2f, 0x0c);
> > +
> > +       ret |=3D regmap_write(lt->regmap[I2C_CEC_DSI], 0x34, h_total & =
0xff);
> > +       ret |=3D regmap_write(lt->regmap[I2C_CEC_DSI], 0x35, h_total >>=
 8);
> > +
> > +       ret |=3D regmap_write(lt->regmap[I2C_CEC_DSI], 0x36, v_total & =
0xff);
> > +       ret |=3D regmap_write(lt->regmap[I2C_CEC_DSI], 0x37, v_total >>=
 8);
> > +
> > +       ret |=3D regmap_write(lt->regmap[I2C_CEC_DSI], 0x38, vbp & 0xff=
);
> > +       ret |=3D regmap_write(lt->regmap[I2C_CEC_DSI], 0x39, vbp >> 8);
> > +
> > +       ret |=3D regmap_write(lt->regmap[I2C_CEC_DSI], 0x3a, vfp & 0xff=
);
> > +       ret |=3D regmap_write(lt->regmap[I2C_CEC_DSI], 0x3b, vfp >> 8);
> > +
> > +       ret |=3D regmap_write(lt->regmap[I2C_CEC_DSI], 0x3c, hbp & 0xff=
);
> > +       ret |=3D regmap_write(lt->regmap[I2C_CEC_DSI], 0x3d, hbp >> 8);
> > +
> > +       ret |=3D regmap_write(lt->regmap[I2C_CEC_DSI], 0x3e, hfp & 0xff=
);
> > +       ret |=3D regmap_write(lt->regmap[I2C_CEC_DSI], 0x3f, hfp >> 8);
> > +
> > +       return ret;
> > +}
> > +
> > +static int lt8912_soft_power_on(struct lt8912 *lt)
> > +{
> > +       if (!lt->is_power_on) {
> > +               u32 lanes =3D lt->data_lanes;
> > +
> > +               lt8912_write_init_config(lt);
> > +               regmap_write(lt->regmap[I2C_CEC_DSI], 0x13, lanes & 3);
> > +
> > +               lt8912_write_mipi_basic_config(lt);
> > +
> > +               lt->is_power_on =3D true;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static int lt8912_video_on(struct lt8912 *lt)
> > +{
> > +       int ret;
> > +
> > +       ret =3D lt8912_video_setup(lt);
> > +       if (ret < 0)
> > +               goto end;
> > +
> > +       ret =3D lt8912_write_dds_config(lt);
> > +       if (ret < 0)
> > +               goto end;
> > +
> > +       ret =3D lt8912_write_rxlogicres_config(lt);
> > +       if (ret < 0)
> > +               goto end;
> > +
> > +       ret =3D lt8912_write_lvds_config(lt);
> > +       if (ret < 0)
> > +               goto end;
> > +
> > +end:
> > +       return ret;
> > +}
> > +
> > +static enum drm_connector_status
> > +lt8912_connector_detect(struct drm_connector *connector, bool force)
> > +{
> > +       struct lt8912 *lt =3D connector_to_lt8912(connector);
> > +
> > +       return drm_bridge_detect(lt->hdmi_port);
> > +}
> > +
> > +static const struct drm_connector_funcs lt8912_connector_funcs =3D {
> > +       .detect =3D lt8912_connector_detect,
> > +       .fill_modes =3D drm_helper_probe_single_connector_modes,
> > +       .destroy =3D drm_connector_cleanup,
> > +       .reset =3D drm_atomic_helper_connector_reset,
> > +       .atomic_duplicate_state =3D drm_atomic_helper_connector_duplica=
te_state,
> > +       .atomic_destroy_state =3D drm_atomic_helper_connector_destroy_s=
tate,
> > +};
> > +
> > +static enum drm_mode_status
> > +lt8912_connector_mode_valid(struct drm_connector *connector,
> > +                           struct drm_display_mode *mode)
> > +{
> > +       if (mode->clock > 150000)
> > +               return MODE_CLOCK_HIGH;
> > +
> > +       if (mode->hdisplay > 1920)
> > +               return MODE_BAD_HVALUE;
> > +
> > +       if (mode->vdisplay > 1080)
> > +               return MODE_BAD_VVALUE;
> > +
> > +       return MODE_OK;
> > +}
> > +
> > +static int lt8912_connector_get_modes(struct drm_connector *connector)
> > +{
> > +       struct edid *edid;
> > +       int ret, num =3D 0;
> > +       struct lt8912 *lt =3D connector_to_lt8912(connector);
> > +       u32 bus_format =3D MEDIA_BUS_FMT_RGB888_1X24;
> > +
> > +       edid =3D drm_bridge_get_edid(lt->hdmi_port, connector);
> > +       if (edid) {
> > +               drm_connector_update_edid_property(connector, edid);
> > +               num =3D drm_add_edid_modes(connector, edid);
> > +       } else
> > +               return ret;
> > +
> > +       ret =3D drm_display_info_set_bus_formats(&connector->display_in=
fo,
> > +                                              &bus_format, 1);
> > +       if (ret)
> > +               num =3D ret;
> > +
> > +       kfree(edid);
> > +       return num;
> > +}
> > +
> > +static const struct drm_connector_helper_funcs lt8912_connector_helper=
_funcs =3D {
> > +       .get_modes =3D lt8912_connector_get_modes,
> > +       .mode_valid =3D lt8912_connector_mode_valid,
> > +};
> > +
> > +static void lt8912_bridge_mode_set(struct drm_bridge *bridge,
> > +                                  const struct drm_display_mode *mode,
> > +                                  const struct drm_display_mode *adj)
> > +{
> > +       struct lt8912 *lt =3D bridge_to_lt8912(bridge);
> > +
> > +       drm_display_mode_to_videomode(adj, &lt->mode);
> > +}
> > +
> > +static void lt8912_bridge_enable(struct drm_bridge *bridge)
> > +{
> > +       struct lt8912 *lt =3D bridge_to_lt8912(bridge);
> > +
> > +       lt8912_video_on(lt);
> > +}
> > +
> > +static int lt8912_attach_dsi(struct lt8912 *lt)
> > +{
> > +       struct device *dev =3D lt->dev;
> > +       struct mipi_dsi_host *host;
> > +       struct mipi_dsi_device *dsi;
> > +       int ret =3D -1;
> > +       const struct mipi_dsi_device_info info =3D { .type =3D "lt8912"=
,
> > +                                                  .channel =3D 0,
> > +                                                  .node =3D NULL,
> > +                                                };
> > +
> > +       host =3D of_find_mipi_dsi_host_by_node(lt->host_node);
> > +       if (!host) {
> > +               dev_err(dev, "failed to find dsi host\n");
> > +               return -EPROBE_DEFER;
> > +       }
> > +
> > +       dsi =3D mipi_dsi_device_register_full(host, &info);
> > +       if (IS_ERR(dsi)) {
> > +               ret =3D PTR_ERR(dsi);
> > +               dev_err(dev, "failed to create dsi device (%d)\n", ret)=
;
> > +               goto err_dsi_device;
> > +       }
> > +
> > +       lt->dsi =3D dsi;
> > +
> > +       dsi->lanes =3D lt->data_lanes;
> > +       dsi->format =3D MIPI_DSI_FMT_RGB888;
> > +
> > +       dsi->mode_flags =3D MIPI_DSI_MODE_VIDEO |
> > +                         MIPI_DSI_MODE_VIDEO_BURST |
> > +                         MIPI_DSI_MODE_LPM |
> > +                         MIPI_DSI_MODE_EOT_PACKET;
> > +
> > +       ret =3D mipi_dsi_attach(dsi);
> > +       if (ret < 0) {
> > +               dev_err(dev, "failed to attach dsi to host\n");
> > +               goto err_dsi_attach;
> > +       }
> > +
> > +       return 0;
> > +
> > +err_dsi_attach:
> > +       mipi_dsi_device_unregister(dsi);
> > +err_dsi_device:
> > +       return ret;
> > +}
> > +
> > +static void lt8912_detach_dsi(struct lt8912 *lt)
> > +{
> > +       mipi_dsi_detach(lt->dsi);
> > +       mipi_dsi_device_unregister(lt->dsi);
> > +}
> > +
> > +static void lt8912_bridge_connector_hpd_event(void *arg,
> > +                                             enum drm_connector_status=
 status)
> > +{
> > +       struct lt8912 *lt =3D arg;
> > +
> > +       if (lt->hdmi_port->dev)
> > +               drm_helper_hpd_irq_event(lt->hdmi_port->dev);
> > +}
> > +
> > +static int lt8912_bridge_connector_init(struct drm_bridge *bridge)
> > +{
> > +       int ret;
> > +       struct lt8912 *lt =3D bridge_to_lt8912(bridge);
> > +       struct drm_connector *connector =3D &lt->connector;
> > +
> > +       if (lt->hdmi_port->ops & DRM_BRIDGE_OP_DETECT) {
> > +               connector->polled =3D DRM_CONNECTOR_POLL_HPD;
> > +       } else {
> > +               connector->polled =3D DRM_CONNECTOR_POLL_CONNECT |
> > +                                   DRM_CONNECTOR_POLL_DISCONNECT;
> > +       }
> > +
> > +       if (lt->hdmi_port->ops & DRM_BRIDGE_OP_HPD) {
> > +               drm_bridge_hpd_enable(lt->hdmi_port,
> > +                                     lt8912_bridge_connector_hpd_event=
,
> > +                                     lt);
> > +       }
> > +
> > +       ret =3D drm_connector_init(bridge->dev, connector,
> > +                                &lt8912_connector_funcs,
> > +                                lt->hdmi_port->type);
> > +       if (ret)
> > +               goto exit;
> > +
> > +       drm_connector_helper_add(connector, &lt8912_connector_helper_fu=
ncs);
> > +
> > +       connector->dpms =3D DRM_MODE_DPMS_OFF;
> > +       drm_connector_attach_encoder(connector, bridge->encoder);
> > +exit:
> > +       return ret;
> > +}
> > +
> > +static int lt8912_bridge_attach(struct drm_bridge *bridge,
> > +                               enum drm_bridge_attach_flags flags)
> > +{
> > +       struct lt8912 *lt =3D bridge_to_lt8912(bridge);
> > +       int ret;
> > +
> > +       if (!(flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR)) {
> > +               ret =3D lt8912_bridge_connector_init(bridge);
> > +               if (ret) {
> > +                       dev_err(lt->dev, "Failed to init bridge ! (%d)\=
n", ret);
> > +                       return ret;
> > +               }
> > +       }
> > +
> > +
> > +       ret =3D lt8912_hard_power_on(lt);
> > +       if (ret)
> > +               return ret;
> > +
> > +       ret =3D lt8912_soft_power_on(lt);
> > +       if (ret)
> > +               goto error;
> > +
> > +       ret =3D lt8912_attach_dsi(lt);
> > +       if (ret)
> > +               goto error;
> > +
> > +       lt->is_attached =3D true;
> > +
> > +       return 0;
> > +
> > +error:
> > +       lt8912_hard_power_off(lt);
> > +       return ret;
> > +}
> > +
> > +static void lt8912_bridge_detach(struct drm_bridge *bridge)
> > +{
> > +       struct lt8912 *lt =3D bridge_to_lt8912(bridge);
> > +
> > +       if (lt->is_attached) {
> > +               if (lt->hdmi_port->ops & DRM_BRIDGE_OP_HPD)
> > +                       drm_bridge_hpd_disable(lt->hdmi_port);
> > +               lt8912_detach_dsi(lt);
> > +               lt8912_hard_power_off(lt);
> > +       }
> > +}
> > +
> > +static enum drm_connector_status
> > +lt8912_bridge_detect(struct drm_bridge *bridge)
> > +{
> > +       struct lt8912 *lt =3D bridge_to_lt8912(bridge);
> > +
> > +       return drm_bridge_detect(lt->hdmi_port);
> > +}
> > +
> > +static struct edid *lt8912_bridge_get_edid(struct drm_bridge *bridge,
> > +                                              struct drm_connector *co=
nnector)
> > +{
> > +       struct lt8912 *lt =3D bridge_to_lt8912(bridge);
> > +
> > +       return drm_bridge_get_edid(lt->hdmi_port, connector);
> > +}
> > +
> > +static const struct drm_bridge_funcs lt8912_bridge_funcs =3D {
> > +       .attach =3D lt8912_bridge_attach,
> > +       .detach =3D lt8912_bridge_detach,
> > +       .mode_set =3D lt8912_bridge_mode_set,
> > +       .enable =3D lt8912_bridge_enable,
> > +       .detect =3D lt8912_bridge_detect,
> > +       .get_edid =3D lt8912_bridge_get_edid,
> > +};
> > +
> > +static int lt8912_parse_dt(struct lt8912 *lt)
> > +{
> > +       struct gpio_desc *gp_reset;
> > +       struct device *dev =3D lt->dev;
> > +       int ret =3D 0;
> > +       struct device_node *port_node;
> > +       struct device_node *endpoint;
> > +
> > +       gp_reset =3D devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HI=
GH);
> > +       if (IS_ERR(gp_reset)) {
> > +               ret =3D PTR_ERR(gp_reset);
> > +               if (ret !=3D -EPROBE_DEFER)
> > +                       dev_err(dev, "Failed to get reset gpio: %d\n", =
ret);
> > +               return ret;
> > +       }
> > +       lt->gp_reset =3D gp_reset;
> > +
> > +
> > +       endpoint =3D of_graph_get_endpoint_by_regs(dev->of_node, 0, -1)=
;
> > +       if (IS_ERR(endpoint)) {
> > +               ret =3D PTR_ERR(endpoint);
> > +               goto end;
> > +       }
> > +
> > +       lt->data_lanes =3D of_property_count_u32_elems(endpoint, "data-=
lanes");
> > +       of_node_put(endpoint);
> > +
> > +       lt->host_node =3D of_graph_get_remote_node(dev->of_node, 0, -1)=
;
> > +       if (!lt->host_node) {
> > +               dev_err(lt->dev, "%s: Failed to get remote port\n", __f=
unc__);
> > +               ret =3D -ENODEV;
> > +               goto end;
> > +       }
> > +
> > +       port_node =3D of_graph_get_remote_node(dev->of_node, 1, -1);
> > +       if (!port_node) {
> > +               dev_err(lt->dev, "%s: Failed to get connector port\n", =
__func__);
> > +               ret =3D -ENODEV;
> > +               goto err_free_host_node;
> > +       }
> > +
> > +       lt->hdmi_port =3D of_drm_find_bridge(port_node);
> > +       if (IS_ERR(lt->hdmi_port)) {
> > +               dev_err(lt->dev, "%s: Failed to get hdmi port\n", __fun=
c__);
> > +               ret =3D PTR_ERR(lt->hdmi_port);
> > +               of_node_put(lt->host_node);
> > +               goto end;
> > +       }
> > +
> > +       if (!of_device_is_compatible(port_node, "hdmi-connector")) {
> > +               dev_err(lt->dev, "%s: Failed to get hdmi port\n", __fun=
c__);
> > +               ret =3D -EINVAL;
> > +       }
> > +
> > +       of_node_put(port_node);
> > +
> > +end:
> > +       return ret;
> > +
> > +err_free_host_node:
> > +       of_node_put(lt->host_node);
> > +       return ret;
> > +}
> > +
> > +static int lt8912_put_dt(struct lt8912 *lt)
> > +{
> > +       of_node_put(lt->host_node);
> > +       return 0;
> > +}
> > +
> > +static int lt8912_probe(struct i2c_client *client,
> > +        const struct i2c_device_id *id)
> > +{
> > +       static struct lt8912 *lt;
> > +       int ret =3D 0;
> > +       struct device *dev =3D &client->dev;
> > +
> > +       lt =3D devm_kzalloc(dev, sizeof(struct lt8912), GFP_KERNEL);
> > +       if (!lt)
> > +               return -ENOMEM;
> > +
> > +       lt->dev =3D dev;
> > +       lt->i2c_client[0] =3D client;
> > +
> > +       ret =3D lt8912_parse_dt(lt);
> > +       if (ret)
> > +               goto err_dt_parse;
> > +
> > +       ret =3D lt8912_init_i2c(lt);
> > +       if (ret)
> > +               goto err_i2c;
> > +
> > +       i2c_set_clientdata(client, lt);
> > +
> > +       lt->bridge.funcs =3D &lt8912_bridge_funcs;
> > +       lt->bridge.of_node =3D dev->of_node;
> > +       lt->bridge.ops =3D lt->hdmi_port->ops;
>
> This is not entirely kosher, bridge.ops should mirror what is
> implemented by bridge.funcs.
>
> I would expect DRM_BRIDGE_OP_HPD and possibly DRM_BRIDGE_OP_DETECT to
> be enabled, since the hardware brief mentions supporting hot plug
> detection.
> drm_bridge_funcs.hpd_enable & drm_bridge_funcs.hpd_disable should both
> also be implemented. If the hardware supports HPD, the driver is
> required to support it as well.
>
> lt8912_product_brief.pdf: https://allg.one/0R71
>
> Have you seen the lt8912 driver in the Toradex tree? It mentions HPD
> and the relevant registers, but doesn't implement support for it
>
> http://git.toradex.com/cgit/linux-toradex.git/tree/drivers/gpu/drm/bridge=
/lt8912.c?h=3Dcolibri&id=3D331ac1cf6e09d90e7d9ab39445bc8812ff33f178#n248
>

Yes I read the product brief and I know that this chip can do HPD. The
problem is that it is not working (so far) on my board.
Second point, my driver uses an "hdmi-connector" that does HPD and DDC
(for EDID=C3=A0 for me (to avoid duplicating some code).
It's why I rely on the bridge (hdmi-connector) ops for my own ops.

> > +
> > +       drm_bridge_add(&lt->bridge);
> > +
> > +       return 0;
> > +
> > +err_i2c:
> > +       lt8912_put_dt(lt);
> > +err_dt_parse:
> > +       return ret;
> > +}
> > +
> > +static int lt8912_remove(struct i2c_client *client)
> > +{
> > +       struct lt8912 *lt =3D i2c_get_clientdata(client);
> > +
> > +       lt8912_bridge_detach(&lt->bridge);
> > +       drm_bridge_remove(&lt->bridge);
> > +       lt8912_free_i2c(lt);
> > +       lt8912_put_dt(lt);
> > +
> > +       return 0;
> > +}
> > +
> > +static const struct of_device_id lt8912_dt_match[] =3D {
> > +       {.compatible =3D "lontium,lt8912"},
> > +       {}
> > +};
> > +MODULE_DEVICE_TABLE(of, lt8912_dt_match);
> > +
> > +static const struct i2c_device_id lt8912_id[] =3D {
> > +       {"lt8912", 0},
> > +       {},
> > +};
> > +MODULE_DEVICE_TABLE(i2c, lt8912_id);
> > +
> > +static struct i2c_driver lt8912_i2c_driver =3D {
> > +       .driver =3D {
> > +               .name =3D "lt8912",
> > +               .of_match_table =3D lt8912_dt_match,
> > +               .owner =3D THIS_MODULE,
> > +       },
> > +       .probe =3D lt8912_probe,
> > +       .remove =3D lt8912_remove,
> > +       .id_table =3D lt8912_id,
> > +};
> > +module_i2c_driver(lt8912_i2c_driver);
> > +
> > +MODULE_AUTHOR("Adrien Grassein <adrien.grassein@gmail.com>");
> > +MODULE_DESCRIPTION("lt8912 drm driver");
> > +MODULE_LICENSE("GPL v2");
> > --
> > 2.25.1
> >

Thanks,
Adrien
