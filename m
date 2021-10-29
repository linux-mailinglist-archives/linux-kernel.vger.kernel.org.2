Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCF7144016A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 19:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbhJ2Rrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 13:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbhJ2Rrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 13:47:37 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F41C061570
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 10:45:09 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id x7so4899267pfh.7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 10:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=b0whYJmcB0jB6pJojgKADy8b4ZuzyqAW5Yum6n3qtZM=;
        b=nQomA4mbZ2UHLPvDns1D/25xRZvNOn1MxebhUEjYX3KEzcK/CsrugvsRPiCkCnGQBt
         +9SXtjyxAmt3hVInXOIGee4RZxxneF0vz40JgKcpfPMuufvPis87qbtKxLpnYR1+qcZT
         74FVbBCqO4yznrAh4b3Qlbw+PieO/GVD85A2/i3UUWLDrrU4sI20wwGTuTdHDu33yXR5
         XBzdwaqV5nOHTp42Fg+g4JcQSScY4RAT0QNMujZXZyvtKzovDE/CeOZ5kBsaUttd54w2
         TTmzjow8k++Ali4TTiy2ul8w/pPrpoeDiZpiqYJ0a6EiAdQmSc8UocVwnSgMZ2CDM8yf
         pB+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=b0whYJmcB0jB6pJojgKADy8b4ZuzyqAW5Yum6n3qtZM=;
        b=aXgeXFz3rqqpR59d4F3HyhBYPfc+d5rWWyh4omH3wy3X2WfABYL/LnZRtExjoQ2IiE
         E7rb0UOT+R+pUjCLIEERoXKzWb9E2H3TW7hHOc9WYAP2uDl+WPscVLu4V+6h5JE6S30U
         MJtOLAGIVBO+XHfIJHo7LnlB4mgLpQdeLKiNemf8OvYxNEY2u6oQqKl1ZylbZQzUWo3q
         ELOj+o0JlmNtVArcBPrr2nlp9tvcXrUAN/LAHKvPRoDpOxtBcc3jiyZYs/zMeNpljd6E
         yFBlGMpDoxFoFbPVnTuX2ihhlyfmHRQci34G5HhMhwjHbuQc/QkQR76kaH2DWCd0gOzT
         o0Hg==
X-Gm-Message-State: AOAM533OniDh1JKUm/t68/aCoh2iHVEyEODlIM2jvNyUk/mH/2Q49YYa
        tQc4ylFVb4iaGub8ZNutGmN99oSxr4xV3676UOB6ZQ==
X-Google-Smtp-Source: ABdhPJylbJBntPJCmTgb6kablqvflLQTyVhPTi/x4VT6rljBmEef/wGDO8GZfqQFTMbSpnM1OQAaXt4NB71LaxX0SUs=
X-Received: by 2002:aa7:8149:0:b0:44c:916c:1fdb with SMTP id
 d9-20020aa78149000000b0044c916c1fdbmr12597647pfn.34.1635529508590; Fri, 29
 Oct 2021 10:45:08 -0700 (PDT)
MIME-Version: 1.0
References: <1635406037-20900-1-git-send-email-hongxing.zhu@nxp.com>
 <1635406037-20900-6-git-send-email-hongxing.zhu@nxp.com> <8e182179c6c60f0b6cf8a89c1b829d8225a055d5.camel@toradex.com>
 <AS8PR04MB8676A86DE53D6C98456DDC7E8C879@AS8PR04MB8676.eurprd04.prod.outlook.com>
In-Reply-To: <AS8PR04MB8676A86DE53D6C98456DDC7E8C879@AS8PR04MB8676.eurprd04.prod.outlook.com>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Fri, 29 Oct 2021 10:44:57 -0700
Message-ID: <CAJ+vNU0iggqkQgsqKz3Y8KQjZxd2d1aq-ujgG=rRKo6EjcN=0w@mail.gmail.com>
Subject: Re: [PATCH v4 5/8] phy: freescale: pcie: Initialize the imx8 pcie
 standalone phy driver
To:     Richard Zhu <hongxing.zhu@nxp.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc:     "kishon@ti.com" <kishon@ti.com>,
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

On Fri, Oct 29, 2021 at 1:45 AM Richard Zhu <hongxing.zhu@nxp.com> wrote:
>
>
> > -----Original Message-----
> > From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> > Sent: Friday, October 29, 2021 4:13 PM
> > To: kishon@ti.com; vkoul@kernel.org; robh@kernel.org;
> > l.stach@pengutronix.de; shawnguo@kernel.org;
> > tharvey@gateworks.com; galak@kernel.crashing.org; Richard Zhu
> > <hongxing.zhu@nxp.com>
> > Cc: linux-phy@lists.infradead.org; linux-arm-kernel@lists.infradead.org=
;
> > kernel@pengutronix.de; devicetree@vger.kernel.org;
> > linux-kernel@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>
> > Subject: Re: [PATCH v4 5/8] phy: freescale: pcie: Initialize the imx8 p=
cie
> > standalone phy driver
> >
> > On Thu, 2021-10-28 at 15:27 +0800, Richard Zhu wrote:
> > > Add the standalone i.MX8 PCIe PHY driver.
> > >
> > > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > > Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> >
> > Unfortunately, this version no longer works for our
> > IMX8_PCIE_REFCLK_PAD_OUTPUT use-case. Further comments in- lined
> > below.
> >
> [Richard Zhu] Sorry to hear about that. Then, it seems that this bit shou=
ld be
>  set anyway.
> It's hard to understand this bit refer to the RM document. Sigh =E2=98=B9=
.
> Would set the AUX_EN bit later.
>
> > > ---
> > >  drivers/phy/freescale/Kconfig              |   9 +
> > >  drivers/phy/freescale/Makefile             |   1 +
> > >  drivers/phy/freescale/phy-fsl-imx8m-pcie.c | 234
> > > +++++++++++++++++++++
> > >  3 files changed, 244 insertions(+)
> > >  create mode 100644 drivers/phy/freescale/phy-fsl-imx8m-pcie.c
> > >
> > > diff --git a/drivers/phy/freescale/Kconfig
> > > b/drivers/phy/freescale/Kconfig index 320630ffe3cd..de9ee7020f76
> > > 100644
> > > --- a/drivers/phy/freescale/Kconfig
> > > +++ b/drivers/phy/freescale/Kconfig
> > > @@ -14,3 +14,12 @@ config PHY_MIXEL_MIPI_DPHY
> > >         help
> > >           Enable this to add support for the Mixel DSI PHY as
> > found
> > >           on NXP's i.MX8 family of SOCs.
> > > +
> > > +config PHY_FSL_IMX8M_PCIE
> > > +       tristate "Freescale i.MX8 PCIE PHY"
> >
> > Above description is missing the M as in i.MX 8M.
> [Richard Zhu] Okay, would be added later.
> Thanks.
>
> >
> > > +       depends on OF && HAS_IOMEM
> > > +       select GENERIC_PHY
> > > +       default ARCH_MXC && ARM64
> > > +       help
> > > +         Enable this to add support for the PCIE PHY as found on
> > > +         i.MX8M family of SOCs.
> > > diff --git a/drivers/phy/freescale/Makefile
> > > b/drivers/phy/freescale/Makefile index 1d02e3869b45..55d07c742ab0
> > > 100644
> > > --- a/drivers/phy/freescale/Makefile
> > > +++ b/drivers/phy/freescale/Makefile
> > > @@ -1,3 +1,4 @@
> > >  # SPDX-License-Identifier: GPL-2.0-only
> > >  obj-$(CONFIG_PHY_FSL_IMX8MQ_USB)       +=3D
> > phy-fsl-imx8mq-usb.o
> > >  obj-$(CONFIG_PHY_MIXEL_MIPI_DPHY)      +=3D
> > phy-fsl-imx8-mipi-dphy.o
> > > +obj-$(CONFIG_PHY_FSL_IMX8M_PCIE)       +=3D
> > phy-fsl-imx8m-pcie.o
> > > diff --git a/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
> > > b/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
> > > new file mode 100644
> > > index 000000000000..4b4402eaddcc
> > > --- /dev/null
> > > +++ b/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
> > > @@ -0,0 +1,234 @@
> > > +// SPDX-License-Identifier: GPL-2.0+
> > > +/*
> > > + * Copyright 2021 NXP
> > > + */
> > > +
> > > +#include <linux/clk.h>
> > > +#include <linux/io.h>
> > > +#include <linux/iopoll.h>
> > > +#include <linux/delay.h>
> > > +#include <linux/mfd/syscon.h>
> > > +#include <linux/mfd/syscon/imx7-iomuxc-gpr.h>
> > > +#include <linux/module.h>
> > > +#include <linux/phy/phy.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/regmap.h>
> > > +#include <linux/reset.h>
> > > +#include <dt-bindings/phy/phy-imx8-pcie.h>
> > > +
> > > +#define IMX8MM_PCIE_PHY_CMN_REG061     0x184 #define
> > > +ANA_PLL_CLK_OUT_TO_EXT_IO_EN  BIT(0) #define
> > > +IMX8MM_PCIE_PHY_CMN_REG062     0x188 #define
> > > +ANA_PLL_CLK_OUT_TO_EXT_IO_SEL BIT(3) #define
> > > +IMX8MM_PCIE_PHY_CMN_REG063     0x18C #define
> > > +AUX_PLL_REFCLK_SEL_SYS_PLL    GENMASK(7, 6) #define
> > > +IMX8MM_PCIE_PHY_CMN_REG064     0x190
> > #define  ANA_AUX_RX_TX_SEL_TX
> > > +BIT(7)
> > #define  ANA_AUX_RX_TERM_GND_EN                BIT(3)
> > #define
> > > +ANA_AUX_TX_TERM               BIT(2) #define
> > > +IMX8MM_PCIE_PHY_CMN_REG065     0x194
> > #define  ANA_AUX_RX_TERM
> > > +(BIT(7) | BIT(4))
> > #define  ANA_AUX_TX_LVL
> > > +GENMASK(3, 0) #define
> > IMX8MM_PCIE_PHY_CMN_REG75      0x1D4 #define
> > > +PCIE_PHY_CMN_REG75_PLL_DONE   0x3 #define
> > PCIE_PHY_TRSV_REG5
> > > +0x414 #define  PCIE_PHY_TRSV_REG5_GEN1_DEEMP 0x2D #define
> > > +PCIE_PHY_TRSV_REG6             0x418 #define
> > > +PCIE_PHY_TRSV_REG6_GEN2_DEEMP 0xF
> > > +
> > > +#define IMX8MM_GPR_PCIE_REF_CLK_SEL    GENMASK(25, 24)
> > #define
> > > +IMX8MM_GPR_PCIE_REF_CLK_PLL
> > > +FIELD_PREP(IMX8MM_GPR_PCIE_REF_CLK_SEL, 0x3) #define
> > > +IMX8MM_GPR_PCIE_REF_CLK_EXT
> > > +FIELD_PREP(IMX8MM_GPR_PCIE_REF_CLK_SEL, 0x2) #define
> > > +IMX8MM_GPR_PCIE_AUX_EN         BIT(19) #define
> > > +IMX8MM_GPR_PCIE_CMN_RST                BIT(18)
> > #define
> > > +IMX8MM_GPR_PCIE_POWER_OFF      BIT(17) #define
> > IMX8MM_GPR_PCIE_SSC_EN
> > > +BIT(16) #define
> > IMX8MM_GPR_PCIE_AUX_EN_OVERRIDE        BIT(9)
> > > +
> > > +struct imx8_pcie_phy {
> > > +       void __iomem            *base;
> > > +       struct clk              *clk;
> > > +       struct phy              *phy;
> > > +       struct regmap           *iomuxc_gpr;
> > > +       struct reset_control    *reset;
> > > +       u32                     refclk_pad_mode;
> > > +       u32                     tx_deemph_gen1;
> > > +       u32                     tx_deemph_gen2;
> > > +       bool                    clkreq_unused; };
> > > +
> > > +static int imx8_pcie_phy_init(struct phy *phy) {
> > > +       int ret;
> > > +       u32 val, pad_mode;
> > > +       struct imx8_pcie_phy *imx8_phy =3D phy_get_drvdata(phy);
> > > +
> > > +       reset_control_assert(imx8_phy->reset);
> > > +
> > > +       pad_mode =3D imx8_phy->refclk_pad_mode;
> > > +       /* Set AUX_EN_OVERRIDE 1'b0, when the CLKREQ# isn't
> > hooked */
> > > +       regmap_update_bits(imx8_phy->iomuxc_gpr,
> > IOMUXC_GPR14,
> > >
> > +                          IMX8MM_GPR_PCIE_AUX_EN_
> > OVERRIDE,
> > > +                          imx8_phy->clkreq_unused ?
> > > +                          0 :
> > IMX8MM_GPR_PCIE_AUX_EN_OVERRIDE);
> > > +       regmap_update_bits(imx8_phy->iomuxc_gpr,
> > IOMUXC_GPR14,
> > > +                          IMX8MM_GPR_PCIE_AUX_EN,
> > > +                          pad_mode =3D=3D
> > IMX8_PCIE_REFCLK_PAD_INPUT ?
> > > +                          IMX8MM_GPR_PCIE_AUX_EN :
> > 0);
> >
> > V3 had IMX8MM_GPR_PCIE_AUX_EN always enabled. Turns out V4
> > stopped working for our output use-case as it only enables it for the i=
nput
> > use-case. If I enable this one always it starts working again.
> [Richard Zhu] See my comment above.
> Sorry to bring the regression on your board.
>

Marcel,

Your board does not use an external clk, but does it hook up CLKREQ#
from the socket to either I2C4_SCL or UART4_RXD and pin muxed as such?

For my board that uses an external clk and does not connect CLKREQ# to
the IMX8MM I need to disable that bit. As Richard says we have invalid
documentation for these bits unfortunately which is not helping.

Richard, when we do figure out proper documentation for these bits I
suggest you also add a comment block right above their #defines in the
phy driver with the correct documentation to avoid future confusion.
NXP has had so many mistakes in the various IMX8M RM's and I fear they
will never get fixed.

Best regards,

Tim
