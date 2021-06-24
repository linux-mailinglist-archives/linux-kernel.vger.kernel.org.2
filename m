Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3A83B2EAC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 14:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbhFXMNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 08:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbhFXMNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 08:13:47 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C6AC061574
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 05:11:27 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id q14so8193545eds.5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 05:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hl72FS2y9n4jB9a1L7Hg43gY2B5zO77yYR8Igj/hYDI=;
        b=Nf6mocvXO8NeZN8KVnMZdEwN0VGtlu+nF63Hc3crZMEB2Pa88argC2qEH737O17A8t
         Mdt8H36DcAhBkk3FQNKViV8IKxUqV0Uj3qixjwf2n9qZmfcXTn7QQe/u3gVFOFrcQry8
         0ckG508FS/iQx+qUUVHHJn4RFaUABamSFqZWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hl72FS2y9n4jB9a1L7Hg43gY2B5zO77yYR8Igj/hYDI=;
        b=f74FKEvFNoXzNkNNuruliTPF3KbPkjKok5nv+uIrxtE/1FM/v3c+83agV0SAjxrGdP
         AUAYXvybOmDGcCeCOzrc/VHR5Y2k+iUQ/CJ6XD2bqbatuLubzmZ4ddU8MKoFEtura1jh
         z9OTPAOx2YQOwRJUnY58EejAQUmidtXOpQBWnBQmCFNnJzyWQtlkyDXwdoaP9WVIohQE
         tPP9UhPIYaxguRDcTt3z178j6NCp7W7GxCWqsbtBq3fVt317LuG/t/Ya9J5OW4IBZukM
         DS8RfuiGAncXws6iKmA83vgGitVgXGk/Fa75Qy3j4FQQ2NSUdWm+QCey0oG5MAepic0N
         d/hw==
X-Gm-Message-State: AOAM532KNnXhgeJmdgcFu9EHiSCAqpQVx3zSZ6hUNgKzKXEOpqfdkks0
        ig4bLPvyhQJk3sV6SNCveQkeuvAetBECxlfDCPdHMw==
X-Google-Smtp-Source: ABdhPJwqpXFeexELh7KyE5nGxtsdMgSuFak/f1DLFia8mgKPPcd1rTqdF6kez5LClGR9uYcVsP2D2Hk5itPE6rlPQDI=
X-Received: by 2002:aa7:cf03:: with SMTP id a3mr6764586edy.27.1624536686322;
 Thu, 24 Jun 2021 05:11:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210621072424.111733-1-jagan@amarulasolutions.com>
 <20210621072424.111733-3-jagan@amarulasolutions.com> <YNO0LHNVSWjrh1ZS@pendragon.ideasonboard.com>
In-Reply-To: <YNO0LHNVSWjrh1ZS@pendragon.ideasonboard.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Thu, 24 Jun 2021 17:41:14 +0530
Message-ID: <CAMty3ZDmzPha7zdWVHkcuRCjA_LsWqSLyWQMhkOiRMmQmTNXjA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/9] drm: bridge: Add Samsung SEC MIPI DSIM bridge driver
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Peng Fan <peng.fan@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Tomasz Figa <t.figa@samsung.com>,
        Fancy Fang <chen.fang@nxp.com>,
        devicetree <devicetree@vger.kernel.org>,
        Francis Laniel <francis.laniel@amarulasolutions.com>,
        Matteo Lisi <matteo.lisi@engicam.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Milco Pratesi <milco.pratesi@engicam.com>,
        Anthony Brandon <anthony@amarulasolutions.com>,
        linux-phy@lists.infradead.org,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On Thu, Jun 24, 2021 at 3:53 AM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Jagan,
>
> Thank you for the patch.
>
> On Mon, Jun 21, 2021 at 12:54:17PM +0530, Jagan Teki wrote:
> > Samsung SEC MIPI DSIM Bridge controller is MIPI DSI bridge
> > available in NXP's i.MX8M Mini and Nano Processors.
> >
> > Add bridge driver for it.
> >
> > Cc: Andrzej Hajda <a.hajda@samsung.com>
> > Cc: Neil Armstrong <narmstrong@baylibre.com>
> > Cc: Robert Foss <robert.foss@linaro.org>
> > Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > ---
> >  drivers/gpu/drm/bridge/Kconfig    |   15 +
> >  drivers/gpu/drm/bridge/Makefile   |    1 +
> >  drivers/gpu/drm/bridge/sec-dsim.c | 1535 +++++++++++++++++++++++++++++
> >  3 files changed, 1551 insertions(+)
> >  create mode 100644 drivers/gpu/drm/bridge/sec-dsim.c
> >
> > diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> > index 19109c0b5481..a183eb165a35 100644
> > --- a/drivers/gpu/drm/bridge/Kconfig
> > +++ b/drivers/gpu/drm/bridge/Kconfig
> > @@ -189,6 +189,21 @@ config DRM_PARADE_PS8640
> >         The PS8640 is a high-performance and low-power
> >         MIPI DSI to eDP converter
> >
> > +config DRM_SEC_MIPI_DSIM
> > +     tristate "Samsung SEC MIPI DSIM Bridge controller"
> > +     depends on DRM
> > +     depends on COMMON_CLK
> > +     depends on OF && HAS_IOMEM
> > +     select DRM_KMS_HELPER
> > +     select DRM_MIPI_DSI
> > +     select DRM_PANEL_BRIDGE
> > +     select GENERIC_PHY_MIPI_DPHY
> > +     select MFD_SYSCON
> > +     select REGMAP_MMIO
> > +     help
> > +       This enables the Samsung SEC MIPI DSIM Bridge controller as
> > +       for example found on NXP's i.MX8M Mini and Nano Processors.
> > +
> >  config DRM_SIL_SII8620
> >       tristate "Silicon Image SII8620 HDMI/MHL bridge"
> >       depends on OF
> > diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/Makefile
> > index 88e4edf81087..ff802a4ffe65 100644
> > --- a/drivers/gpu/drm/bridge/Makefile
> > +++ b/drivers/gpu/drm/bridge/Makefile
> > @@ -12,6 +12,7 @@ obj-$(CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW) += megachips-stdpxxxx-ge-b850v
> >  obj-$(CONFIG_DRM_NXP_PTN3460) += nxp-ptn3460.o
> >  obj-$(CONFIG_DRM_PARADE_PS8622) += parade-ps8622.o
> >  obj-$(CONFIG_DRM_PARADE_PS8640) += parade-ps8640.o
> > +obj-$(CONFIG_DRM_SEC_MIPI_DSIM) += sec-dsim.o
> >  obj-$(CONFIG_DRM_SIL_SII8620) += sil-sii8620.o
> >  obj-$(CONFIG_DRM_SII902X) += sii902x.o
> >  obj-$(CONFIG_DRM_SII9234) += sii9234.o
> > diff --git a/drivers/gpu/drm/bridge/sec-dsim.c b/drivers/gpu/drm/bridge/sec-dsim.c
> > new file mode 100644
> > index 000000000000..5b6645bb94e7
> > --- /dev/null
> > +++ b/drivers/gpu/drm/bridge/sec-dsim.c
> > @@ -0,0 +1,1535 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Samsung SEC MIPI DSIM Bridge
> > + *
> > + * Copyright (C) 2018 NXP
> > + * Copyright (c) 2014 Samsung Electronics Co., Ltd
> > + * Copyright (C) 2021 Amarula Solutions(India)
> > + *
> > + * Based on the drivers/gpu/drm/exynos/exynos_drm_dsi.c
> > + *
> > + * Authors:
> > + * Tomasz Figa <t.figa@samsung.com>
> > + * Andrzej Hajda <a.hajda@samsung.com>
> > + * Fancy Fang <chen.fang@nxp.com>
> > + * Jagan Teki <jagan@amarulasolutions.com>
> > + */
> > +
> > +#include <asm/unaligned.h>
> > +#include <linux/bitfield.h>
> > +#include <linux/clk.h>
> > +#include <linux/completion.h>
> > +#include <linux/delay.h>
> > +#include <linux/module.h>
> > +#include <linux/of_device.h>
> > +#include <linux/of_graph.h>
> > +#include <linux/phy/phy.h>
> > +#include <linux/regmap.h>
> > +
> > +#include <drm/drm_atomic_helper.h>
> > +#include <drm/drm_bridge.h>
> > +#include <drm/drm_mipi_dsi.h>
> > +#include <drm/drm_panel.h>
> > +#include <drm/drm_of.h>
> > +#include <drm/drm_print.h>
> > +
> > +#include <video/mipi_display.h>
> > +
> > +#define DRIVER_NAME                  "sec-dsim"
> > +
> > +/* dsim registers */
> > +#define DSIM_VERSION                 0x00
> > +#define DSIM_STATUS                  0x04
> > +#define DSIM_RGB_STATUS                      0x08
> > +#define DSIM_SWRST                   0x0c
> > +#define DSIM_CLKCTRL                 0x10
> > +#define DSIM_TIMEOUT                 0x14
> > +#define DSIM_CONFIG                  0x18
> > +#define DSIM_ESCMODE                 0x1c
> > +#define DSIM_MDRESOL                 0x20
> > +#define DSIM_MVPORCH                 0x24
> > +#define DSIM_MHPORCH                 0x28
> > +#define DSIM_MSYNC                   0x2c
> > +#define DSIM_SDRESOL                 0x30
> > +#define DSIM_INTSRC                  0x34
> > +#define DSIM_INTMSK                  0x38
> > +#define DSIM_PKTHDR                  0x3c
> > +#define DSIM_PAYLOAD                 0x40
> > +#define DSIM_RXFIFO                  0x44
> > +#define DSIM_FIFOTHLD                        0x48
> > +#define DSIM_FIFOCTRL                        0x4c
> > +#define DSIM_MEMACCHR                        0x50
> > +#define DSIM_MULTI_PKT                       0x78
> > +#define DSIM_PLLCTRL_1G                      0x90
> > +#define DSIM_PLLCTRL                 0x94
> > +#define DSIM_PLLCTRL1                        0x98
> > +#define DSIM_PLLCTRL2                        0x9c
> > +#define DSIM_PLLTMR                  0xa0
>
> Looking at the register set, it seems to match the Exynos 5433,
> supported by drivers/gpu/drm/exynos/exynos_drm_dsi.c. Can we leverage
> that driver instead of adding a new one for the same IP core ?

I thought the same initially, but the PLLOut computation seems
different than the one in the i.MX8MM Reference Manual. I need to find
whether this exynos_dsi is compatible or working on my i.MX8MM
platform and send the next version changes accordingly. thanks.

--
Jagan Teki,
