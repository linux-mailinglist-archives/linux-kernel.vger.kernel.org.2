Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEBD64375EF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 13:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232673AbhJVL2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 07:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232539AbhJVL2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 07:28:37 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0720C061764;
        Fri, 22 Oct 2021 04:26:19 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id i65so5426649ybb.2;
        Fri, 22 Oct 2021 04:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4+1iWewdO/AOypFcUk7ro7SB4/2etVS8UVIHu5F//bk=;
        b=lzSpt3xjpHPhIjHkqPYMJ8yopGn3Hg78ECzZvlXCiSVzaSPXgf1aQPT4wkfSBGmtwN
         F87lcG0fJOR1L7P9URqtYYzAS5CDO59Jm7COtML/qyZYZM22rlmZ0Who7gqiOkLoHCxH
         X+xaB6nv6Syj3kS9VhTF/4uFmB7a/IbJhg5BM+TqHfPlDH84kxZz7UH1CWMNpTzt0yrX
         6wfFzdojQVFG+Tfo99gyM18ePlzUWrC3g3dVdg7Jigjjq0OJ/N/z6Y4zhaZAhtuKg2gZ
         x/9EqHGYWVjkqldEOxteS0AQ0XKnkrGWsyLoiFWX3U3F42ok5sa20fq/1a+sqN2Iw18G
         3QPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4+1iWewdO/AOypFcUk7ro7SB4/2etVS8UVIHu5F//bk=;
        b=B6FfmMFnuW2uwN/Qwmh6fAFjTosUGMVgiENt6XY3UVqgUGQso8K2jhLTVIo4+FhOEy
         bY/OjDPhaByO2uQ4nVlJeayKEcUszFIMg+8RcBz7UhEJHVKzPNGjN3fiv0yfZ4nIKJ4H
         MrxgyfX3aUUMJ3IsDVnTuCXXm3cOCeYdcnaZNBA2GtvWP5o9h4RuOMaZ4nGiPQxn80hD
         3SUPQYIzg94T77x6fP0+OyUOfkgL2hI+WAzJSWBMMFxoMRuCU/iYJZd0agN09CMZdaDU
         xCldi4Rc5hQ4ghkXEY88ajxBf2FN4d2e9B3MmHew36DqQhdDJXI/Hh4A4TG0Pnrxip7v
         QJVQ==
X-Gm-Message-State: AOAM530+tsmybYFGs+CyEYbr60ifQqjz1V7jzwl/abjRxhUuPjj4o3rP
        qxBEu69QvtSlIpNQY1CEZ8f9wQrFFiVso9Tv8/c=
X-Google-Smtp-Source: ABdhPJy1gOHdMe1MOq61g6BzYs93uYXzWyK00GdYBEiqUQwvh0oI7LkwOW8smQ4Hz7ZNjhHfOfh0MJi3Uoq0xtlKazM=
X-Received: by 2002:a25:1c02:: with SMTP id c2mr13902799ybc.218.1634901978978;
 Fri, 22 Oct 2021 04:26:18 -0700 (PDT)
MIME-Version: 1.0
References: <20211013101938.28061-1-yifeng.zhao@rock-chips.com>
 <20211013101938.28061-3-yifeng.zhao@rock-chips.com> <YXKXULdyPuv1BirB@matsya>
In-Reply-To: <YXKXULdyPuv1BirB@matsya>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Fri, 22 Oct 2021 07:26:07 -0400
Message-ID: <CAMdYzYqJs_uT1DT9EFydAmWCoRuizkA==HoMW8VTd68dg0hQ2A@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] phy/rockchip: add naneng combo phy for RK3568
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Yifeng Zhao <yifeng.zhao@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-phy@lists.infradead.org,
        "Kishon Vijay Abraham, I" <kishon@ti.com>, p.zabel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2021 at 6:51 AM Vinod Koul <vkoul@kernel.org> wrote:
>
> On 13-10-21, 18:19, Yifeng Zhao wrote:
> > This patch implements a combo phy driver for Rockchip SoCs
> > with NaNeng IP block. This phy can be used as pcie-phy, usb3-phy,
> > sata-phy or sgmii-phy.
> >
> > Signed-off-by: Yifeng Zhao <yifeng.zhao@rock-chips.com>
> > ---
> >
> > Changes in v2:
> > - Using api devm_platform_get_and_ioremap_resource.
> > - Modify rockchip_combphy_set_Mode.
> > - Add some PHY registers definition.
> >
> >  drivers/phy/rockchip/Kconfig                  |   8 +
> >  drivers/phy/rockchip/Makefile                 |   1 +
> >  .../rockchip/phy-rockchip-naneng-combphy.c    | 650 ++++++++++++++++++
> >  3 files changed, 659 insertions(+)
> >  create mode 100644 drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
> >
> > diff --git a/drivers/phy/rockchip/Kconfig b/drivers/phy/rockchip/Kconfig
> > index e812adad7242..9022e395c056 100644
> > --- a/drivers/phy/rockchip/Kconfig
> > +++ b/drivers/phy/rockchip/Kconfig
> > @@ -66,6 +66,14 @@ config PHY_ROCKCHIP_INNO_DSIDPHY
> >         Enable this to support the Rockchip MIPI/LVDS/TTL PHY with
> >         Innosilicon IP block.
> >
> > +config PHY_ROCKCHIP_NANENG_COMBO_PHY
> > +     tristate "Rockchip NANENG COMBO PHY Driver"
> > +     depends on ARCH_ROCKCHIP && OF
> > +     select GENERIC_PHY
> > +     help
> > +       Enable this to support the Rockchip PCIe/USB3.0/SATA/QSGMII
> > +       combo PHY with NaNeng IP block.
> > +
> >  config PHY_ROCKCHIP_PCIE
> >       tristate "Rockchip PCIe PHY Driver"
> >       depends on (ARCH_ROCKCHIP && OF) || COMPILE_TEST
> > diff --git a/drivers/phy/rockchip/Makefile b/drivers/phy/rockchip/Makefile
> > index f0eec212b2aa..a5041efb5b8f 100644
> > --- a/drivers/phy/rockchip/Makefile
> > +++ b/drivers/phy/rockchip/Makefile
> > @@ -6,6 +6,7 @@ obj-$(CONFIG_PHY_ROCKCHIP_INNO_CSIDPHY)       += phy-rockchip-inno-csidphy.o
> >  obj-$(CONFIG_PHY_ROCKCHIP_INNO_DSIDPHY)      += phy-rockchip-inno-dsidphy.o
> >  obj-$(CONFIG_PHY_ROCKCHIP_INNO_HDMI) += phy-rockchip-inno-hdmi.o
> >  obj-$(CONFIG_PHY_ROCKCHIP_INNO_USB2) += phy-rockchip-inno-usb2.o
> > +obj-$(CONFIG_PHY_ROCKCHIP_NANENG_COMBO_PHY)  += phy-rockchip-naneng-combphy.o
> >  obj-$(CONFIG_PHY_ROCKCHIP_PCIE)              += phy-rockchip-pcie.o
> >  obj-$(CONFIG_PHY_ROCKCHIP_TYPEC)     += phy-rockchip-typec.o
> >  obj-$(CONFIG_PHY_ROCKCHIP_USB)               += phy-rockchip-usb.o
> > diff --git a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
> > new file mode 100644
> > index 000000000000..fbfc5fbbd5b8
> > --- /dev/null
> > +++ b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
> > @@ -0,0 +1,650 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Rockchip PIPE USB3.0 PCIE SATA combphy driver
> > + *
> > + * Copyright (C) 2021 Rockchip Electronics Co., Ltd.
> > + */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/delay.h>
> > +#include <linux/io.h>
> > +#include <linux/iopoll.h>
> > +#include <linux/kernel.h>
> > +#include <linux/mfd/syscon.h>
> > +#include <linux/module.h>
> > +#include <linux/of_device.h>
> > +#include <linux/phy/phy.h>
> > +#include <linux/regmap.h>
> > +#include <linux/reset.h>
> > +#include <dt-bindings/phy/phy.h>
> > +
> > +#define BIT_WRITEABLE_SHIFT          16
> > +#define REF_CLOCK_24MHz                      24000000
> > +#define REF_CLOCK_25MHz                      25000000
> > +#define REF_CLOCK_100MHz             100000000
> > +/* RK3568 T22 COMBO PHY REG */
> > +#define RK3568_T22_PHYREG5           (0x5 << 2)
> > +#define T22_PHYREG5_PLL_DIV_MASK     GENMASK(7, 6)
> > +#define T22_PHYREG5_PLL_DIV_SHIFT    6
> > +#define T22_PHYREG5_PLL_DIV_2                1
> > +
> > +#define RK3568_T22_PHYREG6           (0x6 << 2)
> > +#define T22_PHYREG6_TX_RTERM_MASK    GENMASK(7, 4)
> > +#define T22_PHYREG6_TX_RTERM_SHIFT   4
> > +#define T22_PHYREG6_TX_RTERM_50OHM   0x8
> > +#define T22_PHYREG6_RX_RTERM_MASK    GENMASK(3, 0)
> > +#define T22_PHYREG6_RX_RTERM_SHIFT   0
> > +#define T22_PHYREG6_RX_RTERM_44OHM   0xF
> > +
> > +#define RK3568_T22_PHYREG7           (0x7 << 2)
>
> Pls use GENMASK for these?
>
> > +#define T22_PHYREG7_SSC_EN           BIT(4)
> > +
> > +#define RK3568_T22_PHYREG10          (0xA << 2)
> > +#define T22_PHYREG10_SU_TRIM_0_7     0xF0
> > +
> > +#define RK3568_T22_PHYREG11          (0xB << 2)
> > +#define T22_PHYREG11_PLL_LPF_ADJ     0x4
> > +
> > +#define RK3568_T22_PHYREG12          (0xC << 2)
> > +#define T22_PHYREG12_RESISTER_MASK   GENMASK(5, 4)
> > +#define T22_PHYREG12_RESISTER_SHIFT  0x4
>
> bitfield.h has nice helpers which can extract/program values and avoid
> one to define these shifts

They aren't values, they are registers.
This is a remnant from the downstream driver's attempt at obfuscating
the register it's touching.
Please define these correctly.

> --
> ~Vinod
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
