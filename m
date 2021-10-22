Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA4B4437B2D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 18:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233619AbhJVQ5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 12:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233413AbhJVQ5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 12:57:30 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E9AC061766
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 09:55:12 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 75so3867249pga.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 09:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XKk5S6zzVsLpJki6KUTEWM/bL8H8tlEpxuGdUAGLl0U=;
        b=ZoDtpaZS4cpVQQOKeR1r9y3j/BXLAxVmG1e5e0/Fgp6xIHmssCQBlBIwARimP9oy47
         ntqMdiGiscx3uY2O31gZfk2+xLzd4uWEEnmg6K+pWUXT8DDGQRq00C+esyx9vv2laA/p
         82QOLbwdZ3vdRqRY5Pm8XP4RQkTOyefm9NiwZyqE1wFY+EhcFBsyqfSjOonQ/152hAXp
         efmQOxvZUlr9mTsvN/hq2wvxecDZPr06xNX8DUuCtxYwlybn7QJREfbVRiVTZGYyBZbg
         fRq/vLw+yWaYQ/CzrBWolnvIr0X0W9vtvOk5UtTjaXbf3ik2tYn6c2jMbNb+5LHAFotZ
         /SZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XKk5S6zzVsLpJki6KUTEWM/bL8H8tlEpxuGdUAGLl0U=;
        b=qNzV8rgX4mA5fuvyX6yBInAt3vQT8QuLs1H1RgR9sbuDz77gjN30Dajiik40MOrGAo
         vzU/c2j4h3JpHYkiEPFXU3HVfVUj2yPIjnyXmV5S2Z3i6ToRXz5m6q3nTDTcw8OFCCVp
         rELoppOLQ1PXZuogWcF4wVaV3Mt9pMtvDLN2/tcScbmIksB3+jegOH2BlNyMGXj3o8VY
         qvNpnZ1od6SrdcKZLHkLd3WpFU27OQoC9eDrM+cfNV/4m0Y2G7Fgd9i51uF3vAb+w4tC
         zXNj+f6slg+0H7tVPf0sAjM6LtyMogJngZBW5EXP7nMCM0YNYaHw/kWDywn/V5yNbkWk
         kDXw==
X-Gm-Message-State: AOAM530EXJMcYM4gDDah9vCj0FTM5Kk4O6zzHWB2hgnj25CXjH2LrhKS
        GSaIEVALpSMH4Terhh1cPWk2ijfSylLvQH2+aOBdVg==
X-Google-Smtp-Source: ABdhPJzoKPJA+Npi33fozucBU+egiBMqOwtCUaF7Au9zs2T9f9BTF6ZYR/4JNltrZhWa99tRXVV72Zt8wSf2CHsQIJw=
X-Received: by 2002:a63:788e:: with SMTP id t136mr660555pgc.432.1634921711960;
 Fri, 22 Oct 2021 09:55:11 -0700 (PDT)
MIME-Version: 1.0
References: <1634028078-2387-1-git-send-email-hongxing.zhu@nxp.com>
 <CAJ+vNU2b-=T_gTsRBvdF7SRUZopEFOU_Np8mEJn8bOpn5b5FaA@mail.gmail.com>
 <AS8PR04MB8676B2AC24E2769D47A1ED478CBD9@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <CAJ+vNU2AitmxCyam5FArmxAD41QUU=5CF_0JZhm+uzdkRbr7kw@mail.gmail.com>
 <AS8PR04MB8676840D7EDD56D10F9471288CBE9@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <CAJ+vNU2GU5=mM5+2Yg9gAuU0RSdJHWEU_+ykmz-qUWfsOnRJ8g@mail.gmail.com>
 <AS8PR04MB867624A8A5B6AE27D6A9160F8CBF9@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <CAJ+vNU1Si_bv0_2j5AU-v_1QtUGqwU_4u=NksAVFFXXkkNC1Sw@mail.gmail.com>
 <AS8PR04MB8676D9FFB6506A09D104E32A8C809@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <CAJ+vNU0cLd7oex5uUyJenqs229gsgZe_Vpu3uyKGw1=B+Uu5YQ@mail.gmail.com>
In-Reply-To: <CAJ+vNU0cLd7oex5uUyJenqs229gsgZe_Vpu3uyKGw1=B+Uu5YQ@mail.gmail.com>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Fri, 22 Oct 2021 09:55:00 -0700
Message-ID: <CAJ+vNU0wcQtrKh5W7UZknEiV2o7MKLV90CCrJqGGw=x_VYwMGg@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] add the imx8m pcie phy driver and imx8mm pcie support
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Rob Herring <robh@kernel.org>,
        "galak@kernel.crashing.org" <galak@kernel.crashing.org>,
        Shawn Guo <shawnguo@kernel.org>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2021 at 8:59 AM Tim Harvey <tharvey@gateworks.com> wrote:
>
> On Thu, Oct 21, 2021 at 5:43 PM Richard Zhu <hongxing.zhu@nxp.com> wrote:
> >
> > > -----Original Message-----
> > > From: Tim Harvey <tharvey@gateworks.com>
> > > Sent: Friday, October 22, 2021 12:25 AM
> > > To: Richard Zhu <hongxing.zhu@nxp.com>
> > > Cc: Lucas Stach <l.stach@pengutronix.de>; Kishon Vijay Abraham I
> > > <kishon@ti.com>; vkoul@kernel.org; Rob Herring <robh@kernel.org>;
> > > galak@kernel.crashing.org; Shawn Guo <shawnguo@kernel.org>;
> > > linux-phy@lists.infradead.org; Device Tree Mailing List
> > > <devicetree@vger.kernel.org>; Linux ARM Mailing List
> > > <linux-arm-kernel@lists.infradead.org>; open list
> > > <linux-kernel@vger.kernel.org>; Sascha Hauer <kernel@pengutronix.de>;
> > > dl-linux-imx <linux-imx@nxp.com>
> > > Subject: Re: [PATCH v3 0/9] add the imx8m pcie phy driver and imx8mm pcie
> > > support
> > >
> > > On Wed, Oct 20, 2021 at 8:32 PM Richard Zhu <hongxing.zhu@nxp.com>
> > > wrote:
> > > >
> > > > <snipped...>
> > > > >
> > > > > Richard,
> > > > >
> > > > > What is this 'invalid resource' about? I see that with my downstream
> > > > > IMX8MM PCIe driver as well and have been asked about it.
> > > > >
> > > > [Richard Zhu] Hi Tim:
> > > > This complain is caused by the following codes in pcie-designware.c driver.
> > > > I'm not sure that why there is only size assignment after the res valid check,
> > > and do nothing if the res is invalid.
> > > > It seems that it is an expected design logic refer to the later codes.
> > > >                 if (!pci->atu_base) {
> > > >                         struct resource *res =
> > > >
> > > platform_get_resource_byname(pdev, IORESOURCE_MEM, "atu");
> > > >                         if (res)
> > > >                                 pci->atu_size = resource_size(res);
> > > >                         pci->atu_base =
> > > devm_ioremap_resource(dev, res);
> > > >                         if (IS_ERR(pci->atu_base))
> > > >                                 pci->atu_base = pci->dbi_base +
> > > DEFAULT_DBI_ATU_OFFSET;
> > > >                 }
> > > >
> > > > Since the default offset is used on i.MX8MM, the "atu" is not specified in
> > > i.MX8MM PCIe DT node, so there is no real res at all.
> > > > Then, devm_ioremap_resource() would complain the invalid resource.
> > >
> > > I think you are saying a change should be made like this:
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware.c
> > > b/drivers/pci/controller/dwc/pcie-designware.c
> > > index a945f0c0e73d..3254f60d1713 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > > @@ -671,10 +671,11 @@ void dw_pcie_iatu_detect(struct dw_pcie *pci)
> > >                 if (!pci->atu_base) {
> > >                         struct resource *res =
> > >
> > > platform_get_resource_byname(pdev,
> > > IORESOURCE_MEM, "atu");
> > > -                       if (res)
> > > +                       if (res) {
> > >                                 pci->atu_size = resource_size(res);
> > > -                       pci->atu_base = devm_ioremap_resource(dev,
> > > res);
> > > -                       if (IS_ERR(pci->atu_base))
> > > +                               pci->atu_base =
> > > devm_ioremap_resource(dev, res);
> > > +                       }
> > > +                       if (!pci->atu_base || IS_ERR(pci->atu_base))
> > >                                 pci->atu_base = pci->dbi_base +
> > > DEFAULT_DBI_ATU_OFFSET;
> > >                 }
> > >
> > > so that it looks like this:
> > >                 if (!pci->atu_base) {
> > >                         struct resource *res =
> > >
> > > platform_get_resource_byname(pdev,
> > > IORESOURCE_MEM, "atu");
> > >                         if (res) {
> > >                                 pci->atu_size = resource_size(res);
> > >                                 pci->atu_base =
> > > devm_ioremap_resource(dev, res);
> > >                         }
> > >                         if (!pci->atu_base || IS_ERR(pci->atu_base))
> > >                                 pci->atu_base = pci->dbi_base +
> > > DEFAULT_DBI_ATU_OFFSET;
> > >                 }
> > >
> > > Right?
> > [Richard Zhu] Yes, it is. The res shouldn't be remapped if it is invalid resource memory.
>
> Ok, I will submit a patch for that.
>
> >
> > >
> > > >
> > > > > > [    1.316305] imx6q-pcie 33800000.pcie: iATU unroll: enabled
> > > > > > [    1.321799] imx6q-pcie 33800000.pcie: Detected iATU regions: 4
> > > > > outbound, 4 inbound
> > > > > > [    1.429803] imx6q-pcie 33800000.pcie: Link up
> > > > > > [    1.534497] imx6q-pcie 33800000.pcie: Link up
> > > > > > [    1.538870] imx6q-pcie 33800000.pcie: Link up, Gen2
> > > > > > [    1.550364] imx6q-pcie 33800000.pcie: Link up
> > > > > > [    1.550487] imx6q-pcie 33800000.pcie: PCI host bridge to bus
> > > 0000:00
> > > > > > [    1.565545] pci_bus 0000:00: root bus resource [bus 00-ff]
> > > > > > [    1.573834] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
> > > > > > [    1.580055] pci_bus 0000:00: root bus resource [mem
> > > > > 0x18000000-0x1fefffff]
> > > > > > [    1.586968] pci 0000:00:00.0: [16c3:abcd] type 01 class 0x060400
> > > > > > [    1.592997] pci 0000:00:00.0: reg 0x10: [mem
> > > 0x00000000-0x000fffff]
> > > > > > [    1.599282] pci 0000:00:00.0: reg 0x38: [mem
> > > 0x00000000-0x0000ffff
> > > > > pref]
> > > > > > [    1.606033] pci 0000:00:00.0: supports D1
> > > > > > [    1.610053] pci 0000:00:00.0: PME# supported from D0 D1 D3hot
> > > > > D3cold
> > > > > > [    1.618206] pci 0000:01:00.0: [15b7:5002] type 00 class 0x010802
> > > > > > [    1.624293] pci 0000:01:00.0: reg 0x10: [mem
> > > 0x00000000-0x00003fff
> > > > > 64bit]
> > > > > > [    1.631177] pci 0000:01:00.0: reg 0x20: [mem
> > > 0x00000000-0x000000ff
> > > > > 64bit]
> > > > > > [    1.638409] pci 0000:01:00.0: 4.000 Gb/s available PCIe bandwidth,
> > > > > limited by 5.0 GT/s PCIe x1 link at 0000:00:00.0 (capable of 31.504
> > > > > Gb/s with
> > > > > 8.0 GT/s PCIe x4 link)
> > > > > > [    1.664931] pci 0000:00:00.0: BAR 0: assigned [mem
> > > > > 0x18000000-0x180fffff]
> > > > > > [    1.671745] pci 0000:00:00.0: BAR 14: assigned [mem
> > > > > 0x18100000-0x181fffff]
> > > > > > [    1.678634] pci 0000:00:00.0: BAR 6: assigned [mem
> > > > > 0x18200000-0x1820ffff pref]
> > > > > > [    1.685873] pci 0000:01:00.0: BAR 0: assigned [mem
> > > > > 0x18100000-0x18103fff 64bit]
> > > > > > [    1.693222] pci 0000:01:00.0: BAR 4: assigned [mem
> > > > > 0x18104000-0x181040ff 64bit]
> > > > > > [    1.700577] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
> > > > > > [    1.705814] pci 0000:00:00.0:   bridge window [mem
> > > > > 0x18100000-0x181fffff]
> > > > > > [    1.712972] pcieport 0000:00:00.0: PME: Signaling with IRQ 216
> > > > > > "
> > > > > > Regarding the log you pasted, it seems that the clock is not feed
> > > > > > to PHY
> > > > > properly.
> > > > > >
> > > > > > Anyway, let's waiting for the v4 series, then make a try. Thanks
> > > > > > for your
> > > > > great help to make the double tests.
> > > > > >
> > > > >
> > > > > My boards do not use CLKREQ# so I do not have that defined in pinmux
> > > > > and I found that if I add MX8MM_IOMUXC_I2C4_SCL_PCIE1_CLKREQ_B
> > > PCIe
> > > > > works on my board but this isn't a solution just a work-around (I
> > > > > have boards that use the only two possible pins for CLKREQ as other
> > > features).
> > > > >
> > > > > Similarly you will find on the imx8mm-evk if you comment out the
> > > > > CLKREQ (which isn't required) the imx8mmevk will end up hanging like my
> > > boards:
> > > > [Richard Zhu] Hi Tim:
> > > > Regarding the SPEC, the CLKREQ# is mandatory required, and should be
> > > configured as an open drain, active low signal.
> > > > And this signal should be driven low by the PCIe M.2 device to request the
> > > REF clock be available(active low).
> > > > So, there is such kind of CLKREQ# pin definition on i.MX8MM EVK board.
> > > >
> > > > Anyway, I think the external OSC circuit should be always running if there is
> > > no CLKREQ# on your HW board design.
> > > >
> > >
> > > The way I understand it is CLKREQ# allows the host to disable the REFCLK
> > > when not needed for power savings so it would seem optional to implement
> > > that and if not implemented should be left unconnected on the card.
> > >
> > [Richard Zhu] No, not that way. Regarding the SPEC, this signal is mandatory required.
> > Especially for the L1ss usages. This signal would be OD(open drain), bi-directional, and might be
> > driven low/high by RC or EP automatically if L1ss modes are enabled.
> > You can make reference to the "ECN_L1_PM_Substates_with_CLKREQ_31_May_2013_Rev10a", or
> > the chapter 5.5 L1 PM Substates of "PCI Express Base Specification, Rev. 4.0 Version 1.0".
> >
>
> CLKREQ is only mandatory if you wish to support clock power
> management. Many boards with a PCI host controller do not support
> this.
>
> > > > > diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> > > > > b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> > > > > index 5ce43daa0c8b..f0023b48f475 100644
> > > > > --- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> > > > > +++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> > > > > @@ -448,7 +448,9 @@
> > > > >
> > > > >         pinctrl_pcie0: pcie0grp {
> > > > >                 fsl,pins = <
> > > > > +/*
> > > > >
> > > > > MX8MM_IOMUXC_I2C4_SCL_PCIE1_CLKREQ_B    0x61
> > > > > +*/
> > > > >
> > > MX8MM_IOMUXC_SAI2_RXFS_GPIO4_IO21
> > > > > 0x41
> > > > >                 >;
> > > > >         };
> > > > >
> > > > > I have PCIe working with a driver that I ported from NXP's kernel
> > > > > which differs from your driver in that the PCIe PHY is not
> > > > > abstracted to its own driver so I think this has something to do
> > > > > with the order in which the phy is reset or initialized? The configuration of
> > > gpr14 bits looks correct to me.
> > > > [Richard Zhu] The CLKREQ# PIN definition shouldn't be masked.
> > > > In the NXP's local BSP kernel, I just force CLKREQ# low to level up the HW
> > > compatibility.
> > > > That's might the reason why the PCIe works on your HW board although the
> > > CLKREQ# PIN is not defined.
> > > > This method is a little rude and violate the SPEC, and not recommended
> > > although it levels up the HW compatibility.
> > > > So I drop this method in this series.
> > > >
> > >
> > > Sorry, I don't understand what you are saying here. Is there a change you are
> > > going to make to v4 that will make this work for the evk and my boards? What
> > > is that change exactly?
> > [Richard Zhu] No. What I said above is that the CLKREQ# is forced to be low in NXP
> > local BSP kernel. I guess this might be the reason why your board works.
> >
> > BIT11 and BIT10 of IOMUXC_GPR14 can be used to force the CLKREQ# to be low.
> > Set CLKREQ_OVERRIDE_EN(bit10) 1b1, then write one zero to CLKREQ_OVERRIDE(bit11).
> >
>
> Ok, that makes sense. Those bits are not explained well in the
> IMX8MMRM. As my board's external REFCLK is always enabled that must
> gate the clock internally to the host controller block.
>
> I can confirm that asserting those GPR14 bits does resolve my issue:
>
> #define IMX8MM_GPR_PCIE_CLKREQ_OVERRIDE_VAL    BIT(11)
> #define IMX8MM_GPR_PCIE_CLKREQ_OVERRIDE_EN     BIT(10)
>
>        /*
>         * for boards that do not connect CLKREQ#,
>         * override CLKREQ# and drive it low internally
>         */
>        regmap_update_bits(imx8_phy->iomuxc_gpr, IOMUXC_GPR14,
>                           IMX8MM_GPR_PCIE_CLKREQ_OVERRIDE_VAL, 0);
>        regmap_update_bits(imx8_phy->iomuxc_gpr, IOMUXC_GPR14,
>                           IMX8MM_GPR_PCIE_CLKREQ_OVERRIDE_EN, 1);
>
> Should this be added as a 'fsl,clkreq-unsupported' flag that needs to
> be set true to implement the above code?
>

Richard,

Sorry - spoke too soon. My test was flawed as I still was pinmuxing
CLKREQ in my dt to work around the issue and after removed the above
did not resolve my issue. The setting of OVERRIDE_EN was wrong above
(should not be set to '1' but BIT(10) instead) but this code already
exists in imx6_pcie_enable_ref_clk and is used for IMX8MM per your
patch so this is not the issue.

What makes my board work is to clear GPR14 bit9 (like the NXP kernel
does) so I don't think this bit does what we think it does (select
between internal and ext clk). I think setting it enables clock gating
via CLKREQ#.

This also points out that perhaps the CLKREQ_OVERRIDE logic should be
moved to the new phy driver for IMX8MM.

Best regards,

Tim
