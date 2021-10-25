Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83700439D37
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 19:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbhJYRRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 13:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbhJYRRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 13:17:08 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8517CC061745
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 10:14:44 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id r28so7260300pga.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 10:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CFdJLM2Vp/QmqJfdcQj3c9WWwK/FP6pLAkHlGi/eCVA=;
        b=cQ9gtxW2x9U5AEQy7+SbXAeC4IxuG7BOowr9Ko84Ot8gY1SVBOrp4kg7G5CLYBcia4
         0q2Tgk941iFnRmh4AA6oDEBfrritvpUsxxdbvUasbpFijcZuIxvpvYHZ0Nl3993pWhQ1
         ZmzNIOLl6F0Ahw9tgAZ68+AsJecQHv6Iuu5r0wpqI+cfUzf30h5+5qbw+kbtwLJz5Ap4
         QNGh/HgkgCzTshWJUEhdIsnJU4bZh+zzznZk5KfKpqi6UK++3NqeKtipz+ZUm+6eSnaX
         ms4i6xuWbIQsa6B2rMxLmU+lIpUtwEHfxDV2mdyblZUnoEmwLmLm54HY/VDqAWgmByc2
         IgIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CFdJLM2Vp/QmqJfdcQj3c9WWwK/FP6pLAkHlGi/eCVA=;
        b=186awYGwBbO9vpQasQJNAXx9WHLKwg7zGM/8N+vndyVGMD784jk+R8l6+73OnAY6Y9
         CRNhEsFUxf82ir83Hrgm+gmWWsbmUZkmuadvNAaJYl1akwsgirRKgxSJd+nQzMDMX5/s
         HorDJnaX9H2YA5+jRsLoeS9YFHHnPXNag2FDXuWJp8wuTVaVOzxPNMRqYmdCW/bb4rVl
         XDMr6HmsnmhsAsidrMYfOIHONLgFcopyTGvvvAEfeTa7Vn0KamXIMdEMMBDlpAZshiRN
         z9sTZREedp95ur0Iy+5PKvQp4/pmYSKIzbsbIzzenNnNqY6jjYVhBPP4e7nN1Z5SxKm2
         a1CA==
X-Gm-Message-State: AOAM531/2kjBEf1Xl+8j/0ZHmgiJBWI15ho3ZMATYnLhoiHPuj5rqkmc
        T7aEEE2bmtt7JWTFAum2ylDTm1PM7dZ1OEaB1QQxNw==
X-Google-Smtp-Source: ABdhPJw5ZIvs95aeu0xnzri81XBPnOsaPUfUcqvss/UDUpWb2pPZYOpBJA2unPj8Xje7zPYhnAS2oFN3JICwEGNH2wk=
X-Received: by 2002:aa7:96f8:0:b0:47b:eb13:e0b6 with SMTP id
 i24-20020aa796f8000000b0047beb13e0b6mr9280116pfq.27.1635182083874; Mon, 25
 Oct 2021 10:14:43 -0700 (PDT)
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
 <CAJ+vNU0wcQtrKh5W7UZknEiV2o7MKLV90CCrJqGGw=x_VYwMGg@mail.gmail.com>
 <AS8PR04MB867697878533A37B72D7E4AA8C839@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <AS8PR04MB867620E1A1E940275CD38B528C839@AS8PR04MB8676.eurprd04.prod.outlook.com>
In-Reply-To: <AS8PR04MB867620E1A1E940275CD38B528C839@AS8PR04MB8676.eurprd04.prod.outlook.com>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Mon, 25 Oct 2021 10:14:32 -0700
Message-ID: <CAJ+vNU1nTYSHPZ1Twmy4k4pKuH7xQy95gTOJXx+mcTMZRfj-TA@mail.gmail.com>
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

On Mon, Oct 25, 2021 at 12:23 AM Richard Zhu <hongxing.zhu@nxp.com> wrote:
>
> Snipped...
>
> > > > > > > > My boards do not use CLKREQ# so I do not have that defined
> > > > > > > > in pinmux and I found that if I add
> > > > > > > > MX8MM_IOMUXC_I2C4_SCL_PCIE1_CLKREQ_B
> > > > > > PCIe
> > > > > > > > works on my board but this isn't a solution just a
> > > > > > > > work-around (I have boards that use the only two possible
> > > > > > > > pins for CLKREQ as other
> > > > > > features).
> > > > > > > >
> > > > > > > > Similarly you will find on the imx8mm-evk if you comment out
> > > > > > > > the CLKREQ (which isn't required) the imx8mmevk will end up
> > > > > > > > hanging like my
> > > > > > boards:
> > > > > > > [Richard Zhu] Hi Tim:
> > > > > > > Regarding the SPEC, the CLKREQ# is mandatory required, and
> > > > > > > should be
> > > > > > configured as an open drain, active low signal.
> > > > > > > And this signal should be driven low by the PCIe M.2 device to
> > > > > > > request the
> > > > > > REF clock be available(active low).
> > > > > > > So, there is such kind of CLKREQ# pin definition on i.MX8MM
> > > > > > > EVK
> > > board.
> > > > > > >
> > > > > > > Anyway, I think the external OSC circuit should be always
> > > > > > > running if there is
> > > > > > no CLKREQ# on your HW board design.
> > > > > > >
> > > > > >
> > > > > > The way I understand it is CLKREQ# allows the host to disable
> > > > > > the REFCLK when not needed for power savings so it would seem
> > > > > > optional to implement that and if not implemented should be left
> > > > > > unconnected on
> > > the card.
> > > > > >
> > > > > [Richard Zhu] No, not that way. Regarding the SPEC, this signal is
> > > mandatory required.
> > > > > Especially for the L1ss usages. This signal would be OD(open
> > > > > drain), bi-directional, and might be driven low/high by RC or EP
> > > > > automatically if
> > > L1ss modes are enabled.
> > > > > You can make reference to the
> > > > > "ECN_L1_PM_Substates_with_CLKREQ_31_May_2013_Rev10a", or the
> > > chapter 5.5 L1 PM Substates of "PCI Express Base Specification, Rev.
> > > 4.0 Version 1.0".
> > > > >
> > > >
> > > > CLKREQ is only mandatory if you wish to support clock power
> > > > management. Many boards with a PCI host controller do not support
> > > > this.
> > [Richard Zhu] Okay, understood.
> >
> > > >
> > > > > > > > diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> > > > > > > > b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> > > > > > > > index 5ce43daa0c8b..f0023b48f475 100644
> > > > > > > > --- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> > > > > > > > +++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> > > > > > > > @@ -448,7 +448,9 @@
> > > > > > > >
> > > > > > > >         pinctrl_pcie0: pcie0grp {
> > > > > > > >                 fsl,pins = <
> > > > > > > > +/*
> > > > > > > >
> > > > > > > > MX8MM_IOMUXC_I2C4_SCL_PCIE1_CLKREQ_B    0x61
> > > > > > > > +*/
> > > > > > > >
> > > > > > MX8MM_IOMUXC_SAI2_RXFS_GPIO4_IO21
> > > > > > > > 0x41
> > > > > > > >                 >;
> > > > > > > >         };
> > > > > > > >
> > > > > > > > I have PCIe working with a driver that I ported from NXP's
> > > > > > > > kernel which differs from your driver in that the PCIe PHY
> > > > > > > > is not abstracted to its own driver so I think this has
> > > > > > > > something to do with the order in which the phy is reset or
> > initialized?
> > > > > > > > The configuration of
> > > > > > gpr14 bits looks correct to me.
> > > > > > > [Richard Zhu] The CLKREQ# PIN definition shouldn't be masked.
> > > > > > > In the NXP's local BSP kernel, I just force CLKREQ# low to
> > > > > > > level up the HW
> > > > > > compatibility.
> > > > > > > That's might the reason why the PCIe works on your HW board
> > > > > > > although the
> > > > > > CLKREQ# PIN is not defined.
> > > > > > > This method is a little rude and violate the SPEC, and not
> > > > > > > recommended
> > > > > > although it levels up the HW compatibility.
> > > > > > > So I drop this method in this series.
> > > > > > >
> > > > > >
> > > > > > Sorry, I don't understand what you are saying here. Is there a
> > > > > > change you are going to make to v4 that will make this work for
> > > > > > the evk and my boards? What is that change exactly?
> > > > > [Richard Zhu] No. What I said above is that the CLKREQ# is forced
> > > > > to be low in NXP local BSP kernel. I guess this might be the
> > > > > reason why your
> > > board works.
> > > > >
> > > > > BIT11 and BIT10 of IOMUXC_GPR14 can be used to force the CLKREQ#
> > > > > to
> > > be low.
> > > > > Set CLKREQ_OVERRIDE_EN(bit10) 1b1, then write one zero to
> > > CLKREQ_OVERRIDE(bit11).
> > > > >
> > > >
> > > > Ok, that makes sense. Those bits are not explained well in the
> > > > IMX8MMRM. As my board's external REFCLK is always enabled that must
> > > > gate the clock internally to the host controller block.
> > > >
> > > > I can confirm that asserting those GPR14 bits does resolve my issue:
> > > >
> > > > #define IMX8MM_GPR_PCIE_CLKREQ_OVERRIDE_VAL    BIT(11)
> > > > #define IMX8MM_GPR_PCIE_CLKREQ_OVERRIDE_EN     BIT(10)
> > > >
> > > >        /*
> > > >         * for boards that do not connect CLKREQ#,
> > > >         * override CLKREQ# and drive it low internally
> > > >         */
> > > >        regmap_update_bits(imx8_phy->iomuxc_gpr, IOMUXC_GPR14,
> > > >
> > > IMX8MM_GPR_PCIE_CLKREQ_OVERRIDE_VAL, 0);
> > > >        regmap_update_bits(imx8_phy->iomuxc_gpr, IOMUXC_GPR14,
> > > >
> > > IMX8MM_GPR_PCIE_CLKREQ_OVERRIDE_EN, 1);
> > [Richard Zhu] regmap bits operations should manipulate according bits.
> > The BIT(10) and BIT(11) should be touched actually.
> >
> > > >
> > > > Should this be added as a 'fsl,clkreq-unsupported' flag that needs
> > > > to be set true to implement the above code?
> > > >
> > >
> > > Richard,
> > >
> > > Sorry - spoke too soon. My test was flawed as I still was pinmuxing
> > > CLKREQ in my dt to work around the issue and after removed the above
> > > did not resolve my issue. The setting of OVERRIDE_EN was wrong above
> > > (should not be set to '1' but BIT(10) instead) but this code already
> > > exists in imx6_pcie_enable_ref_clk and is used for IMX8MM per your
> > > patch so this is not the issue.
> > >
> > > What makes my board work is to clear GPR14 bit9 (like the NXP kernel
> > > does) so I don't think this bit does what we think it does (select
> > > between internal and ext clk). I think setting it enables clock gating via
> > CLKREQ#.
> > >
> > > This also points out that perhaps the CLKREQ_OVERRIDE logic should be
> > > moved to the new phy driver for IMX8MM.
> > [Richard Zhu] It sounds reasonable to consider to force the CLKREQ# to be
> > low.
> > I will think about that and add this in later v5 patch-set if nobody has different
> > concerns.
> > Thanks.
> [Richard Zhu] Hi Tim:
> As you mentioned above, the CLKREQ# GPIO PIN is not used for PCIe on your board, right?
> " (I have boards that use the only two possible pins for CLKREQ as other features)"
>
> Did the override configuration of the clkreq# will bring unexpected results for other features on your board?
>

What I mean is that imx8mm-venice-gw7901.dts uses both I2C4 and UART4
and because I2C4_SCL and UART4_RXD are the only two pads that could be
pinmuxed for CLKREQ# I can't use the workaround of pin muxing it.

Currently your driver only works on my imx8mm-venice-* boards if I add
one of the following on boards that don't connect those pads (or if I
clear IMX8MM_GPR_PCIE_REF_USE_PAD):
MX8MM_IOMUXC_I2C4_SCL_PCIE1_CLKREQ_B
MX8MM_IOMUXC_UART4_RXD_PCIE1_CLKREQ_B

Note your 'PCI: imx: add the imx8mm pcie support' patch [1] does
enable this code already in the imx6_pcie_enable_ref_clk function to
override REF_CLK and drive it low:

offset = imx6_pcie_grp_offset(imx6_pcie);
/*
* Set the over ride low and enabled
* make sure that REF_CLK is turned on.
*/
regmap_update_bits(imx6_pcie->iomuxc_gpr, offset,
   IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE,
   0);
regmap_update_bits(imx6_pcie->iomuxc_gpr, offset,
   IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN,
   IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN);

So this is already being run and yet my boards still do not work
unless I clr IMX8MM_GPR_PCIE_REF_USE_PAD like this which is what the
NXP downstream driver does:
regmap_update_bits(imx8_phy->iomuxc_gpr, IOMUXC_GPR14,
IMX8MM_GPR_PCIE_REF_USE_PAD, 0);

This is why I'm not sure that bit does what you think it does... I
feel like that bit enables 'Use CLKREQ# to enable CLK'.

You tell me the descriptions for GPR14 are wrong in the reference
manual. Please provide correct descriptions for us so we can sort this
out.

Best regards,

Tim
[1] https://patchwork.kernel.org/project/linux-arm-kernel/patch/1634028078-2387-10-git-send-email-hongxing.zhu@nxp.com/
