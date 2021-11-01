Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3881441F0A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 18:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232708AbhKARPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 13:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbhKARPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 13:15:49 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789CAC061764
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 10:13:16 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id f8so11958200plo.12
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 10:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wdqCpUlvU6wF+mGxAfUmSzaTVGq81b17l3fG6ZaPWuo=;
        b=Q2DZHqK7daGgHSHRVvG2CfDT+/ho7RTvcEBSh85maNG/s4pZJQieO4kTP79fAbCAPA
         OPmIcixKqYcJKgsYKKollJkYWnvrRN023PdNFWI8amX/jxq6Oxd084q2FQikJkWtyv7X
         r480dj400zFRpTXsaRxEXEhov2ZQehXvBwvNjXx6COLgw4VO2n0ZzbOfwc81x1zcjv/E
         TWIIHrmkBHRRIT5MXAdeHMn1FT1lurhqVoaSrE2Fa4kKh5ARMi91O7pHSNk0eExOwvLZ
         bx8ZD7m3Y4SyYiVKoENMjTldSSWEJmbz7KOe6l6qCa9EiPEj42azRkFat7bjYgMypu9P
         lmnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wdqCpUlvU6wF+mGxAfUmSzaTVGq81b17l3fG6ZaPWuo=;
        b=Mljl+GnBjLi8bWzrpolleJay3yTtWUQjX00Qa++I7UbfCVWqE9K1rmu5CzeTcqO/Qy
         0YMSohidYKbWVa3EzWEucXiBNlfn5XEFtMOCNxHFzcLmPSP/md4HBxHopEGWBjqg1TDN
         lzqQB0mBb5X2MiCTK6XQDt0nE/XuQhYWqUQOroObRhb+MmKA3jomfKN+fzFScsrFiKwA
         yAHB1/EE0k0wtj0WyY8vO60vAzdUgSaOiQzg4od4iYRSd0DEExQmX4afo6Qv5CJJkYWM
         pc/DcewMJ5tPIkriwzL0R5i38dE2/KWQVdGW975BYBoCc6B7odCsDbi/i/VY1rjkH96+
         WSuw==
X-Gm-Message-State: AOAM533yznJYtLtIIHG4sSDZc9cJZBhN2OXb+nVwZlVuBWmA8OAqAHkE
        NoSjY2mvhNQRCzGewCfIldaEzwxR0WCzonHI0gwMDA==
X-Google-Smtp-Source: ABdhPJzez5x02qA8cmpUv9PKnmM5oQCuwvmbs6y9Eo9F3LZElN77MIoE271XFmpDHBMWRfJpYhLmGTpZfCvN/y41AuU=
X-Received: by 2002:a17:902:d48f:b0:141:f290:b75d with SMTP id
 c15-20020a170902d48f00b00141f290b75dmr5220502plg.12.1635786795870; Mon, 01
 Nov 2021 10:13:15 -0700 (PDT)
MIME-Version: 1.0
References: <1635406037-20900-1-git-send-email-hongxing.zhu@nxp.com>
 <1635406037-20900-6-git-send-email-hongxing.zhu@nxp.com> <8e182179c6c60f0b6cf8a89c1b829d8225a055d5.camel@toradex.com>
 <AS8PR04MB8676A86DE53D6C98456DDC7E8C879@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <CAJ+vNU0iggqkQgsqKz3Y8KQjZxd2d1aq-ujgG=rRKo6EjcN=0w@mail.gmail.com> <AS8PR04MB8676C9518B3285CE96EC741E8C8A9@AS8PR04MB8676.eurprd04.prod.outlook.com>
In-Reply-To: <AS8PR04MB8676C9518B3285CE96EC741E8C8A9@AS8PR04MB8676.eurprd04.prod.outlook.com>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Mon, 1 Nov 2021 10:13:04 -0700
Message-ID: <CAJ+vNU1kPHPxT1JbpVCqxOLAnf6rWjY8C2aiL9Tb66Rdnby1eA@mail.gmail.com>
Subject: Re: [PATCH v4 5/8] phy: freescale: pcie: Initialize the imx8 pcie
 standalone phy driver
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "galak@kernel.crashing.org" <galak@kernel.crashing.org>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 1, 2021 at 1:19 AM Richard Zhu <hongxing.zhu@nxp.com> wrote:
>
> > -----Original Message-----
> > From: Tim Harvey <tharvey@gateworks.com>
> > Sent: Saturday, October 30, 2021 1:45 AM
> > To: Richard Zhu <hongxing.zhu@nxp.com>; Marcel Ziswiler
> > <marcel.ziswiler@toradex.com>
> > Cc: kishon@ti.com; vkoul@kernel.org; robh@kernel.org;
> > l.stach@pengutronix.de; shawnguo@kernel.org;
> > galak@kernel.crashing.org; linux-phy@lists.infradead.org;
> > linux-arm-kernel@lists.infradead.org; kernel@pengutronix.de;
> > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; dl-linux-imx
> > <linux-imx@nxp.com>
> > Subject: Re: [PATCH v4 5/8] phy: freescale: pcie: Initialize the imx8 p=
cie
> > standalone phy driver
> >
> > On Fri, Oct 29, 2021 at 1:45 AM Richard Zhu <hongxing.zhu@nxp.com>
> > wrote:
> > >
> > >
> > > > -----Original Message-----
> > > > From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> > > > Sent: Friday, October 29, 2021 4:13 PM
> > > > To: kishon@ti.com; vkoul@kernel.org; robh@kernel.org;
> > > > l.stach@pengutronix.de; shawnguo@kernel.org;
> > tharvey@gateworks.com;
> > > > galak@kernel.crashing.org; Richard Zhu <hongxing.zhu@nxp.com>
> > > > Cc: linux-phy@lists.infradead.org;
> > > > linux-arm-kernel@lists.infradead.org;
> > > > kernel@pengutronix.de; devicetree@vger.kernel.org;
> > > > linux-kernel@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>
> > > > Subject: Re: [PATCH v4 5/8] phy: freescale: pcie: Initialize the
> > > > imx8 pcie standalone phy driver
> > > >
> > > > On Thu, 2021-10-28 at 15:27 +0800, Richard Zhu wrote:
> > > > > Add the standalone i.MX8 PCIe PHY driver.
> > > > >
> > > > > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > > > > Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> > > >
> > > > Unfortunately, this version no longer works for our
> > > > IMX8_PCIE_REFCLK_PAD_OUTPUT use-case. Further comments in-
> > lined
> > > > below.
> > > >
> > > [Richard Zhu] Sorry to hear about that. Then, it seems that this bit
> > > should be  set anyway.
> > > It's hard to understand this bit refer to the RM document. Sigh =E2=
=98=B9.
> > > Would set the AUX_EN bit later.
> > >
> > > > > ---
> > > > >  drivers/phy/freescale/Kconfig              |   9 +
> > > > >  drivers/phy/freescale/Makefile             |   1 +
> > > > >  drivers/phy/freescale/phy-fsl-imx8m-pcie.c | 234
> > > > > +++++++++++++++++++++
> > > > >  3 files changed, 244 insertions(+)  create mode 100644
> > > > > drivers/phy/freescale/phy-fsl-imx8m-pcie.c
> > > > >
> > > > > diff --git a/drivers/phy/freescale/Kconfig
> > > > > b/drivers/phy/freescale/Kconfig index 320630ffe3cd..de9ee7020f76
> > > > > 100644
> > > > > --- a/drivers/phy/freescale/Kconfig
> > > > > +++ b/drivers/phy/freescale/Kconfig
> > > > > @@ -14,3 +14,12 @@ config PHY_MIXEL_MIPI_DPHY
> > > > >         help
> > > > >           Enable this to add support for the Mixel DSI PHY as
> > > > found
> > > > >           on NXP's i.MX8 family of SOCs.
> > > > > +
> > > > > +config PHY_FSL_IMX8M_PCIE
> > > > > +       tristate "Freescale i.MX8 PCIE PHY"
> > > >
> > > > Above description is missing the M as in i.MX 8M.
> > > [Richard Zhu] Okay, would be added later.
> > > Thanks.
> > >
> > > >
> > > > > +       depends on OF && HAS_IOMEM
> > > > > +       select GENERIC_PHY
> > > > > +       default ARCH_MXC && ARM64
> > > > > +       help
> > > > > +         Enable this to add support for the PCIE PHY as found on
> > > > > +         i.MX8M family of SOCs.
> > > > > diff --git a/drivers/phy/freescale/Makefile
> > > > > b/drivers/phy/freescale/Makefile index
> > 1d02e3869b45..55d07c742ab0
> > > > > 100644
> > > > > --- a/drivers/phy/freescale/Makefile
> > > > > +++ b/drivers/phy/freescale/Makefile
> > > > > @@ -1,3 +1,4 @@
> > > > >  # SPDX-License-Identifier: GPL-2.0-only
> > > > >  obj-$(CONFIG_PHY_FSL_IMX8MQ_USB)       +=3D
> > > > phy-fsl-imx8mq-usb.o
> > > > >  obj-$(CONFIG_PHY_MIXEL_MIPI_DPHY)      +=3D
> > > > phy-fsl-imx8-mipi-dphy.o
> > > > > +obj-$(CONFIG_PHY_FSL_IMX8M_PCIE)       +=3D
> > > > phy-fsl-imx8m-pcie.o
> > > > > diff --git a/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
> > > > > b/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
> > > > > new file mode 100644
> > > > > index 000000000000..4b4402eaddcc
> > > > > --- /dev/null
> > > > > +++ b/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
> > > > > @@ -0,0 +1,234 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0+
> > > > > +/*
> > > > > + * Copyright 2021 NXP
> > > > > + */
> > > > > +
> > > > > +#include <linux/clk.h>
> > > > > +#include <linux/io.h>
> > > > > +#include <linux/iopoll.h>
> > > > > +#include <linux/delay.h>
> > > > > +#include <linux/mfd/syscon.h>
> > > > > +#include <linux/mfd/syscon/imx7-iomuxc-gpr.h>
> > > > > +#include <linux/module.h>
> > > > > +#include <linux/phy/phy.h>
> > > > > +#include <linux/platform_device.h> #include <linux/regmap.h>
> > > > > +#include <linux/reset.h> #include
> > > > > +<dt-bindings/phy/phy-imx8-pcie.h>
> > > > > +
> > > > > +#define IMX8MM_PCIE_PHY_CMN_REG061     0x184 #define
> > > > > +ANA_PLL_CLK_OUT_TO_EXT_IO_EN  BIT(0) #define
> > > > > +IMX8MM_PCIE_PHY_CMN_REG062     0x188 #define
> > > > > +ANA_PLL_CLK_OUT_TO_EXT_IO_SEL BIT(3) #define
> > > > > +IMX8MM_PCIE_PHY_CMN_REG063     0x18C #define
> > > > > +AUX_PLL_REFCLK_SEL_SYS_PLL    GENMASK(7, 6) #define
> > > > > +IMX8MM_PCIE_PHY_CMN_REG064     0x190
> > > > #define  ANA_AUX_RX_TX_SEL_TX
> > > > > +BIT(7)
> > > > #define  ANA_AUX_RX_TERM_GND_EN                BIT(3)
> > > > #define
> > > > > +ANA_AUX_TX_TERM               BIT(2) #define
> > > > > +IMX8MM_PCIE_PHY_CMN_REG065     0x194
> > > > #define  ANA_AUX_RX_TERM
> > > > > +(BIT(7) | BIT(4))
> > > > #define  ANA_AUX_TX_LVL
> > > > > +GENMASK(3, 0) #define
> > > > IMX8MM_PCIE_PHY_CMN_REG75      0x1D4 #define
> > > > > +PCIE_PHY_CMN_REG75_PLL_DONE   0x3 #define
> > > > PCIE_PHY_TRSV_REG5
> > > > > +0x414 #define  PCIE_PHY_TRSV_REG5_GEN1_DEEMP 0x2D
> > #define
> > > > > +PCIE_PHY_TRSV_REG6             0x418 #define
> > > > > +PCIE_PHY_TRSV_REG6_GEN2_DEEMP 0xF
> > > > > +
> > > > > +#define IMX8MM_GPR_PCIE_REF_CLK_SEL    GENMASK(25, 24)
> > > > #define
> > > > > +IMX8MM_GPR_PCIE_REF_CLK_PLL
> > > > > +FIELD_PREP(IMX8MM_GPR_PCIE_REF_CLK_SEL, 0x3) #define
> > > > > +IMX8MM_GPR_PCIE_REF_CLK_EXT
> > > > > +FIELD_PREP(IMX8MM_GPR_PCIE_REF_CLK_SEL, 0x2) #define
> > > > > +IMX8MM_GPR_PCIE_AUX_EN         BIT(19) #define
> > > > > +IMX8MM_GPR_PCIE_CMN_RST                BIT(18)
> > > > #define
> > > > > +IMX8MM_GPR_PCIE_POWER_OFF      BIT(17) #define
> > > > IMX8MM_GPR_PCIE_SSC_EN
> > > > > +BIT(16) #define
> > > > IMX8MM_GPR_PCIE_AUX_EN_OVERRIDE        BIT(9)
> > > > > +
> > > > > +struct imx8_pcie_phy {
> > > > > +       void __iomem            *base;
> > > > > +       struct clk              *clk;
> > > > > +       struct phy              *phy;
> > > > > +       struct regmap           *iomuxc_gpr;
> > > > > +       struct reset_control    *reset;
> > > > > +       u32                     refclk_pad_mode;
> > > > > +       u32                     tx_deemph_gen1;
> > > > > +       u32                     tx_deemph_gen2;
> > > > > +       bool                    clkreq_unused; };
> > > > > +
> > > > > +static int imx8_pcie_phy_init(struct phy *phy) {
> > > > > +       int ret;
> > > > > +       u32 val, pad_mode;
> > > > > +       struct imx8_pcie_phy *imx8_phy =3D phy_get_drvdata(phy);
> > > > > +
> > > > > +       reset_control_assert(imx8_phy->reset);
> > > > > +
> > > > > +       pad_mode =3D imx8_phy->refclk_pad_mode;
> > > > > +       /* Set AUX_EN_OVERRIDE 1'b0, when the CLKREQ# isn't
> > > > hooked */
> > > > > +       regmap_update_bits(imx8_phy->iomuxc_gpr,
> > > > IOMUXC_GPR14,
> > > > >
> > > > +                          IMX8MM_GPR_PCIE_AUX_EN_
> > > > OVERRIDE,
> > > > > +                          imx8_phy->clkreq_unused ?
> > > > > +                          0 :
> > > > IMX8MM_GPR_PCIE_AUX_EN_OVERRIDE);
> > > > > +       regmap_update_bits(imx8_phy->iomuxc_gpr,
> > > > IOMUXC_GPR14,
> > > > > +                          IMX8MM_GPR_PCIE_AUX_EN,
> > > > > +                          pad_mode =3D=3D
> > > > IMX8_PCIE_REFCLK_PAD_INPUT ?
> > > > > +                          IMX8MM_GPR_PCIE_AUX_EN :
> > > > 0);
> > > >
> > > > V3 had IMX8MM_GPR_PCIE_AUX_EN always enabled. Turns out V4
> > stopped
> > > > working for our output use-case as it only enables it for the input
> > > > use-case. If I enable this one always it starts working again.
> > > [Richard Zhu] See my comment above.
> > > Sorry to bring the regression on your board.
> > >
> >
> > Marcel,
> >
> > Your board does not use an external clk, but does it hook up CLKREQ#
> > from the socket to either I2C4_SCL or UART4_RXD and pin muxed as
> > such?
> >
> > For my board that uses an external clk and does not connect CLKREQ# to
> > the IMX8MM I need to disable that bit. As Richard says we have invalid
> > documentation for these bits unfortunately which is not helping.
> >
> > Richard, when we do figure out proper documentation for these bits I
> > suggest you also add a comment block right above their #defines in the
> > phy driver with the correct documentation to avoid future confusion.
> > NXP has had so many mistakes in the various IMX8M RM's and I fear they
> > will never get fixed.
> [Richard Zhu] Hi Tim:
> I took look at the validation codes, and found that the AUX_EN is always
>  set to be 1b'1. Whatever the reference clock mode is selected.
> I'm sending a query email to design team, but I'm not sure I can get resp=
onse
> in time.
> Can you help to take a double tests at your board when AUX_EN(bit19 of GP=
R14)
> is set to be 1b'1 firstly?
> Thanks in advanced.
>

Richard and Marcel,

I apologize, my mistake I was referring to GPR14 bit 9 and not bit19
in my testing above.

I tested leaving bit 9 set and this still works on my boards with ext
clk and no CLKREQ# as well as imx8mm-evk with ext clk and CLKREQ#.

So the change on top of your v4 would be:

diff --git a/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
b/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
index 4b4402eaddcc..003f575b36f0 100644
--- a/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
+++ b/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
@@ -73,8 +73,7 @@ static int imx8_pcie_phy_init(struct phy *phy)
                           0 : IMX8MM_GPR_PCIE_AUX_EN_OVERRIDE);
        regmap_update_bits(imx8_phy->iomuxc_gpr, IOMUXC_GPR14,
                           IMX8MM_GPR_PCIE_AUX_EN,
-                          pad_mode =3D=3D IMX8_PCIE_REFCLK_PAD_INPUT ?
-                          IMX8MM_GPR_PCIE_AUX_EN : 0);
+                          IMX8MM_GPR_PCIE_AUX_EN);
        regmap_update_bits(imx8_phy->iomuxc_gpr, IOMUXC_GPR14,
                           IMX8MM_GPR_PCIE_POWER_OFF, 0);
        regmap_update_bits(imx8_phy->iomuxc_gpr, IOMUXC_GPR14,

Marcel, does this look right for your board?

Best regards,

Tim
