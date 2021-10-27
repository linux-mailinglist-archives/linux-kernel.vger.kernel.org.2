Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A42AB43CDD5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 17:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242827AbhJ0Pnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 11:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242768AbhJ0Pna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 11:43:30 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F666C061745
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 08:41:05 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id q2-20020a17090a2e0200b001a0fd4efd49so3552053pjd.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 08:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fpUrNfqpSc4o/+KH5TSzQCvENvaioW4oKZrOwYfWr/4=;
        b=M7bGqYi0mgATpDUPr30lnON4IdJK5IXwkqpXEGN7vd6HuCDRITsnDlQvJfi8qqm9cW
         LyvmuX3QiaNj96rN3PufnAf3vo8YHqsieQtdunSatkHcG79g5VrpmC9tdXy1LiLN6Hu0
         NI0d2qnAGFuSC9g8jxGrb/xwmKDPWSMvUNDhHJkSDTWtnoyuWnwLx/rMa8agvwEru7cp
         n/tTh4DOas/Q2bDDr8zoLLx+c2QJAU6NtHexlL9azC9E0cSkPsSVvAujz7X/HDfjQ2Tb
         Oy/i+Enm0Ar2h5u6LkVb7fIyha6UxIxRHjBwCiHKZ0Kd15pF/dI5mAdIzss6JSzsGwUx
         eR4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fpUrNfqpSc4o/+KH5TSzQCvENvaioW4oKZrOwYfWr/4=;
        b=RD+0NjdCmiZgESvqsAx2ldbKXHzfus997oU250WikaiW2pIXO3xxYOa/GYpaX0WQ7M
         jEGtyNYfAcsowvUFr/P9kGc26oBdnXWcb0cylqzMeFyfED0jvwf+dNAHSVVyqsqQs2hA
         ICIfrILwMbbXaUWjskGjlyUzPLgsNI9KhRXPh+EIEg92KxF7nmZ94bZaA/2twZr9bZ1d
         VRK1sB/Vcyp7cpOyKKMv8Tp/PnWxmAqESRltklz6iL2sptsTtS4u5tSfrEmpE6Ok5jf5
         4rEypdgZmoBFKivcgdy/aWAn0yyhmU8fxgUE4qmWkUR+89eSLZRnSgzIK1KkFSXQLPo0
         SUwg==
X-Gm-Message-State: AOAM530O/Ly1j/CIOUtMz95PIUGavDL9HL4v8+o3uJQK8Hcgg9hZVv2R
        iRjYhFrtW7ANEQfdx1NwMyOJ4qkI6xxv+RYWN/VHPA==
X-Google-Smtp-Source: ABdhPJw0ZGAJfqD9WZv/p4JETDE+8crqqVpH7Qz3SgSEW2s1/PhIqKWxo1vYCrwGipxXluC64jSeZsy+Eh/EsB8jVzM=
X-Received: by 2002:a17:902:c407:b0:13f:68f:6753 with SMTP id
 k7-20020a170902c40700b0013f068f6753mr28617057plk.39.1635349264713; Wed, 27
 Oct 2021 08:41:04 -0700 (PDT)
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
 <CAJ+vNU1nTYSHPZ1Twmy4k4pKuH7xQy95gTOJXx+mcTMZRfj-TA@mail.gmail.com>
 <AS8PR04MB86767EED0FB08363A80D86508C849@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <CAJ+vNU0YmmmHxS=jo8U=RQFGH6CpabHCJP=xt5F=1HD0552Cvg@mail.gmail.com> <AS8PR04MB8676AA107627892553C8B3878C859@AS8PR04MB8676.eurprd04.prod.outlook.com>
In-Reply-To: <AS8PR04MB8676AA107627892553C8B3878C859@AS8PR04MB8676.eurprd04.prod.outlook.com>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Wed, 27 Oct 2021 08:40:53 -0700
Message-ID: <CAJ+vNU2LyWkNqE_anrndtTLgj9DjpB9FYyAeroj-oCiDa6H6Lg@mail.gmail.com>
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

On Tue, Oct 26, 2021 at 11:18 PM Richard Zhu <hongxing.zhu@nxp.com> wrote:
>
> > -----Original Message-----
> > From: Tim Harvey <tharvey@gateworks.com>
> > Sent: Wednesday, October 27, 2021 12:06 AM
> > To: Richard Zhu <hongxing.zhu@nxp.com>
> > Cc: Lucas Stach <l.stach@pengutronix.de>; Kishon Vijay Abraham I
> > <kishon@ti.com>; vkoul@kernel.org; Rob Herring <robh@kernel.org>;
> > galak@kernel.crashing.org; Shawn Guo <shawnguo@kernel.org>;
> > linux-phy@lists.infradead.org; Device Tree Mailing List
> > <devicetree@vger.kernel.org>; Linux ARM Mailing List
> > <linux-arm-kernel@lists.infradead.org>; open list
> > <linux-kernel@vger.kernel.org>; Sascha Hauer <kernel@pengutronix.de>;
> > dl-linux-imx <linux-imx@nxp.com>
> > Subject: Re: [PATCH v3 0/9] add the imx8m pcie phy driver and imx8mm pcie
> > support
> >
> > On Mon, Oct 25, 2021 at 10:41 PM Richard Zhu <hongxing.zhu@nxp.com>
> > wrote:
> > >
> > > > -----Original Message-----
> > > > From: Tim Harvey <tharvey@gateworks.com>
> > > > Sent: Tuesday, October 26, 2021 1:15 AM
> > > > To: Richard Zhu <hongxing.zhu@nxp.com>
> > > > Cc: Lucas Stach <l.stach@pengutronix.de>; Kishon Vijay Abraham I
> > > > <kishon@ti.com>; vkoul@kernel.org; Rob Herring <robh@kernel.org>;
> > > > galak@kernel.crashing.org; Shawn Guo <shawnguo@kernel.org>;
> > > > linux-phy@lists.infradead.org; Device Tree Mailing List
> > > > <devicetree@vger.kernel.org>; Linux ARM Mailing List
> > > > <linux-arm-kernel@lists.infradead.org>; open list
> > > > <linux-kernel@vger.kernel.org>; Sascha Hauer
> > > > <kernel@pengutronix.de>; dl-linux-imx <linux-imx@nxp.com>
> > > > Subject: Re: [PATCH v3 0/9] add the imx8m pcie phy driver and imx8mm
> > > > pcie support
> > > >
> > > > On Mon, Oct 25, 2021 at 12:23 AM Richard Zhu <hongxing.zhu@nxp.com>
> > > > wrote:
> > > > >
> > > > > Snipped...
> > > > >
> > > > > > > > > > > > My boards do not use CLKREQ# so I do not have that
> > > > > > > > > > > > defined in pinmux and I found that if I add
> > > > > > > > > > > > MX8MM_IOMUXC_I2C4_SCL_PCIE1_CLKREQ_B
> > > > > > > > > > PCIe
> > > > > > > > > > > > works on my board but this isn't a solution just a
> > > > > > > > > > > > work-around (I have boards that use the only two
> > > > > > > > > > > > possible pins for CLKREQ as other
> > > > > > > > > > features).
> > > > > > > > > > > >
> > > > > > > > > > > > Similarly you will find on the imx8mm-evk if you
> > > > > > > > > > > > comment out the CLKREQ (which isn't required) the
> > > > > > > > > > > > imx8mmevk will end up hanging like my
> > > > > > > > > > boards:
> > > > > > > > > > > [Richard Zhu] Hi Tim:
> > > > > > > > > > > Regarding the SPEC, the CLKREQ# is mandatory required,
> > > > > > > > > > > and should be
> > > > > > > > > > configured as an open drain, active low signal.
> > > > > > > > > > > And this signal should be driven low by the PCIe M.2
> > > > > > > > > > > device to request the
> > > > > > > > > > REF clock be available(active low).
> > > > > > > > > > > So, there is such kind of CLKREQ# pin definition on
> > > > > > > > > > > i.MX8MM EVK
> > > > > > > board.
> > > > > > > > > > >
> > > > > > > > > > > Anyway, I think the external OSC circuit should be
> > > > > > > > > > > always running if there is
> > > > > > > > > > no CLKREQ# on your HW board design.
> > > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > The way I understand it is CLKREQ# allows the host to
> > > > > > > > > > disable the REFCLK when not needed for power savings so
> > > > > > > > > > it would seem optional to implement that and if not
> > > > > > > > > > implemented should be left unconnected on
> > > > > > > the card.
> > > > > > > > > >
> > > > > > > > > [Richard Zhu] No, not that way. Regarding the SPEC, this
> > > > > > > > > signal is
> > > > > > > mandatory required.
> > > > > > > > > Especially for the L1ss usages. This signal would be
> > > > > > > > > OD(open drain), bi-directional, and might be driven
> > > > > > > > > low/high by RC or EP automatically if
> > > > > > > L1ss modes are enabled.
> > > > > > > > > You can make reference to the
> > > > > > > > > "ECN_L1_PM_Substates_with_CLKREQ_31_May_2013_Rev10a",
> > or
> > > > the
> > > > > > > chapter 5.5 L1 PM Substates of "PCI Express Base Specification, Rev.
> > > > > > > 4.0 Version 1.0".
> > > > > > > > >
> > > > > > > >
> > > > > > > > CLKREQ is only mandatory if you wish to support clock power
> > > > > > > > management. Many boards with a PCI host controller do not
> > > > > > > > support this.
> > > > > > [Richard Zhu] Okay, understood.
> > > > > >
> > > > > > > >
> > > > > > > > > > > > diff --git
> > > > > > > > > > > > a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> > > > > > > > > > > > b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> > > > > > > > > > > > index 5ce43daa0c8b..f0023b48f475 100644
> > > > > > > > > > > > --- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> > > > > > > > > > > > +++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> > > > > > > > > > > > @@ -448,7 +448,9 @@
> > > > > > > > > > > >
> > > > > > > > > > > >         pinctrl_pcie0: pcie0grp {
> > > > > > > > > > > >                 fsl,pins = <
> > > > > > > > > > > > +/*
> > > > > > > > > > > >
> > > > > > > > > > > > MX8MM_IOMUXC_I2C4_SCL_PCIE1_CLKREQ_B    0x61
> > > > > > > > > > > > +*/
> > > > > > > > > > > >
> > > > > > > > > > MX8MM_IOMUXC_SAI2_RXFS_GPIO4_IO21
> > > > > > > > > > > > 0x41
> > > > > > > > > > > >                 >;
> > > > > > > > > > > >         };
> > > > > > > > > > > >
> > > > > > > > > > > > I have PCIe working with a driver that I ported from
> > > > > > > > > > > > NXP's kernel which differs from your driver in that
> > > > > > > > > > > > the PCIe PHY is not abstracted to its own driver so
> > > > > > > > > > > > I think this has something to do with the order in
> > > > > > > > > > > > which the phy is reset or
> > > > > > initialized?
> > > > > > > > > > > > The configuration of
> > > > > > > > > > gpr14 bits looks correct to me.
> > > > > > > > > > > [Richard Zhu] The CLKREQ# PIN definition shouldn't be
> > masked.
> > > > > > > > > > > In the NXP's local BSP kernel, I just force CLKREQ#
> > > > > > > > > > > low to level up the HW
> > > > > > > > > > compatibility.
> > > > > > > > > > > That's might the reason why the PCIe works on your HW
> > > > > > > > > > > board although the
> > > > > > > > > > CLKREQ# PIN is not defined.
> > > > > > > > > > > This method is a little rude and violate the SPEC, and
> > > > > > > > > > > not recommended
> > > > > > > > > > although it levels up the HW compatibility.
> > > > > > > > > > > So I drop this method in this series.
> > > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > Sorry, I don't understand what you are saying here. Is
> > > > > > > > > > there a change you are going to make to v4 that will
> > > > > > > > > > make this work for the evk and my boards? What is that change
> > exactly?
> > > > > > > > > [Richard Zhu] No. What I said above is that the CLKREQ# is
> > > > > > > > > forced to be low in NXP local BSP kernel. I guess this
> > > > > > > > > might be the reason why your
> > > > > > > board works.
> > > > > > > > >
> > > > > > > > > BIT11 and BIT10 of IOMUXC_GPR14 can be used to force the
> > > > > > > > > CLKREQ# to
> > > > > > > be low.
> > > > > > > > > Set CLKREQ_OVERRIDE_EN(bit10) 1b1, then write one zero to
> > > > > > > CLKREQ_OVERRIDE(bit11).
> > > > > > > > >
> > > > > > > >
> > > > > > > > Ok, that makes sense. Those bits are not explained well in
> > > > > > > > the IMX8MMRM. As my board's external REFCLK is always
> > > > > > > > enabled that must gate the clock internally to the host controller
> > block.
> > > > > > > >
> > > > > > > > I can confirm that asserting those GPR14 bits does resolve my
> > issue:
> > > > > > > >
> > > > > > > > #define IMX8MM_GPR_PCIE_CLKREQ_OVERRIDE_VAL    BIT(11)
> > > > > > > > #define IMX8MM_GPR_PCIE_CLKREQ_OVERRIDE_EN
> > BIT(10)
> > > > > > > >
> > > > > > > >        /*
> > > > > > > >         * for boards that do not connect CLKREQ#,
> > > > > > > >         * override CLKREQ# and drive it low internally
> > > > > > > >         */
> > > > > > > >        regmap_update_bits(imx8_phy->iomuxc_gpr,
> > > > IOMUXC_GPR14,
> > > > > > > >
> > > > > > > IMX8MM_GPR_PCIE_CLKREQ_OVERRIDE_VAL, 0);
> > > > > > > >        regmap_update_bits(imx8_phy->iomuxc_gpr,
> > > > IOMUXC_GPR14,
> > > > > > > >
> > > > > > > IMX8MM_GPR_PCIE_CLKREQ_OVERRIDE_EN, 1);
> > > > > > [Richard Zhu] regmap bits operations should manipulate according
> > bits.
> > > > > > The BIT(10) and BIT(11) should be touched actually.
> > > > > >
> > > > > > > >
> > > > > > > > Should this be added as a 'fsl,clkreq-unsupported' flag that
> > > > > > > > needs to be set true to implement the above code?
> > > > > > > >
> > > > > > >
> > > > > > > Richard,
> > > > > > >
> > > > > > > Sorry - spoke too soon. My test was flawed as I still was
> > > > > > > pinmuxing CLKREQ in my dt to work around the issue and after
> > > > > > > removed the above did not resolve my issue. The setting of
> > > > > > > OVERRIDE_EN was wrong above (should not be set to '1' but
> > > > > > > BIT(10)
> > > > > > > instead) but this code already exists in
> > > > > > > imx6_pcie_enable_ref_clk and is used for IMX8MM per your patch
> > so this is not the issue.
> > > > > > >
> > > > > > > What makes my board work is to clear GPR14 bit9 (like the NXP
> > > > > > > kernel
> > > > > > > does) so I don't think this bit does what we think it does
> > > > > > > (select between internal and ext clk). I think setting it
> > > > > > > enables clock gating via
> > > > > > CLKREQ#.
> > > > > > >
> > > > > > > This also points out that perhaps the CLKREQ_OVERRIDE logic
> > > > > > > should be moved to the new phy driver for IMX8MM.
> > > > > > [Richard Zhu] It sounds reasonable to consider to force the
> > > > > > CLKREQ# to be low.
> > > > > > I will think about that and add this in later v5 patch-set if
> > > > > > nobody has different concerns.
> > > > > > Thanks.
> > > > > [Richard Zhu] Hi Tim:
> > > > > As you mentioned above, the CLKREQ# GPIO PIN is not used for PCIe
> > > > > on
> > > > your board, right?
> > > > > " (I have boards that use the only two possible pins for CLKREQ as
> > > > > other
> > > > features)"
> > > > >
> > > > > Did the override configuration of the clkreq# will bring
> > > > > unexpected results
> > > > for other features on your board?
> > > > >
> > > >
> > > > What I mean is that imx8mm-venice-gw7901.dts uses both I2C4 and
> > > > UART4 and because I2C4_SCL and UART4_RXD are the only two pads that
> > > > could be pinmuxed for CLKREQ# I can't use the workaround of pin muxing
> > it.
> > > >
> > > > Currently your driver only works on my imx8mm-venice-* boards if I
> > > > add one of the following on boards that don't connect those pads (or
> > > > if I clear
> > > > IMX8MM_GPR_PCIE_REF_USE_PAD):
> > > > MX8MM_IOMUXC_I2C4_SCL_PCIE1_CLKREQ_B
> > > > MX8MM_IOMUXC_UART4_RXD_PCIE1_CLKREQ_B
> > > >
> > > > Note your 'PCI: imx: add the imx8mm pcie support' patch [1] does
> > > > enable this code already in the imx6_pcie_enable_ref_clk function to
> > > > override REF_CLK and drive it low:
> > > >
> > > > offset = imx6_pcie_grp_offset(imx6_pcie);
> > > > /*
> > > > * Set the over ride low and enabled
> > > > * make sure that REF_CLK is turned on.
> > > > */
> > > > regmap_update_bits(imx6_pcie->iomuxc_gpr, offset,
> > > >    IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE,
> > > >    0);
> > > > regmap_update_bits(imx6_pcie->iomuxc_gpr, offset,
> > > >    IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN,
> > > >    IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN);
> > > >
> > > > So this is already being run and yet my boards still do not work
> > > > unless I clr IMX8MM_GPR_PCIE_REF_USE_PAD like this which is what the
> > > > NXP downstream driver does:
> > > > regmap_update_bits(imx8_phy->iomuxc_gpr, IOMUXC_GPR14,
> > > > IMX8MM_GPR_PCIE_REF_USE_PAD, 0);
> > > >
> > > > This is why I'm not sure that bit does what you think it does... I
> > > > feel like that bit enables 'Use CLKREQ# to enable CLK'.
> > > >
> > > > You tell me the descriptions for GPR14 are wrong in the reference manual.
> > > > Please provide correct descriptions for us so we can sort this out.
> > > >
> > > [Richard Zhu] Hi Tim:
> > > The BIT9 of GPR14 is used as "GPR_PCIE1_PHY_I_AUX_EN_OVERRIDE_EN"
> > > and BIT19 is used as "GPR_PCIE1_PHY_FUNC_I_AUX_EN" on i.MX8MM.
> > > I think the two bits descriptions are used to describe the BIT19 and BIT9
> > together refer to my guess.
> > > {GPR_PCIE1_PHY_I_AUX_EN_OVERRIDE_EN(BIT9),
> > > GPR_PCIE1_PHY_FUNC_I_AUX_EN(BIT19) }
> > > 2'b00: External Reference Clock I/O (for PLL) Disable
> > > 2'b01: External Reference Clock I/O (for PLL) Enable
> > > 2'b10: External Reference Clock I/O (for PLL) Disable
> > > 2'b11: External Reference Clock I/O (for PLL) output is controlled by
> > > CLKREQ#
> > >
> > > The option1&3 should be forbidden, since the external REF CLK I/O should
> > be enabled on your board and EVK board.
> > > In the option2&4, the BIT19 should be set to be 1'b1.'
> > >
> > > So, regarding my understand, if the CLKREQ# is not pinmuxed in your use
> > case, the IMX8MM_GPR_PCIE_REF_USE_PAD (BIT9) should be 1'b0.
> > >
> >
> > Richard,
> >
> > Ok, if this is the case then drivers/pci/controller/dwc/pci-imx6.c for IMX8MM
> > should not touch GPR14 and '[v3,9/9] PCI: imx: add the imx8mm pcie support'
> > should have this on top and squashed:
> > diff --git a/drivers/pci/controller/dwc/pci-imx6.c
> > b/drivers/pci/controller/dwc/pci-imx6.c
> > index 7c89bd1a6441..458d54c8e385 100644
> > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > @@ -452,8 +452,12 @@ static int imx6_pcie_enable_ref_clk(struct
> > imx6_pcie *imx6_pcie)
> >                 break;
> >         case IMX7D:
> >                 break;
> > -       case IMX8MQ:
> >         case IMX8MM:
> > +               ret = clk_prepare_enable(imx6_pcie->pcie_aux);
> > +               if (ret)
> > +                       dev_err(dev, "unable to enable pcie_aux
> > clock\n");
> > +               break;
> > +       case IMX8MQ:
> >                 ret = clk_prepare_enable(imx6_pcie->pcie_aux);
> >                 if (ret) {
> >                         dev_err(dev, "unable to enable pcie_aux
> > clock\n");
> >
> [Richard Zhu] Sorry, I might don't understand what's meaning of the changes.
> What're the differences between before and after the changes?
>

The above change to your patch 'only' calls clk_prepare_enable for
IMX8MM and does not touch GPR14 bits as the IMX8MQ case does (because
as you point out the GPR14 bits differ between IMX8MM and IMX8MQ).

> >
> > And your '[v3,5/9] phy: freescale: pcie: initialize the imx8 pcie standalone phy
> > driver' should have this on top and squashed:
> > diff --git a/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
> > b/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
> > index 317cf61bff37..27ca0b9f1d92 100644
> > --- a/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
> > +++ b/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
> > @@ -43,7 +43,7 @@
> >  #define IMX8MM_GPR_PCIE_CMN_RST                BIT(18)
> >  #define IMX8MM_GPR_PCIE_POWER_OFF      BIT(17)
> >  #define IMX8MM_GPR_PCIE_SSC_EN         BIT(16)
> > -#define IMX8MM_GPR_PCIE_REF_USE_PAD    BIT(9)
> > +#define IMX8MM_GPR_PCIE_AUX_EN_OVERRIDE        BIT(9)
> >
> >  struct imx8_pcie_phy {
> >         u32                     refclk_pad_mode;
> > @@ -63,12 +63,12 @@ static int imx8_pcie_phy_init(struct phy *phy)
> >         reset_control_assert(imx8_phy->reset);
> >
> >         regmap_update_bits(imx8_phy->iomuxc_gpr, IOMUXC_GPR14,
> > -                          IMX8MM_GPR_PCIE_REF_USE_PAD,
> > -                          imx8_phy->refclk_pad_mode == 1 ?
> > -                          IMX8MM_GPR_PCIE_REF_USE_PAD : 0);
> > +                          IMX8MM_GPR_PCIE_AUX_EN_OVERRIDE,
> > +                          0);
> >         regmap_update_bits(imx8_phy->iomuxc_gpr, IOMUXC_GPR14,
> >                            IMX8MM_GPR_PCIE_AUX_EN,
> > -                          IMX8MM_GPR_PCIE_AUX_EN);
> > +                          imx8_phy->refclk_pad_mode ==
> > IMX8_PCIE_REFCLK_PAD_INPUT ?
> > +                          IMX8MM_GPR_PCIE_AUX_EN : 0);
> >         regmap_update_bits(imx8_phy->iomuxc_gpr, IOMUXC_GPR14,
> >                            IMX8MM_GPR_PCIE_POWER_OFF, 0);
> >         regmap_update_bits(imx8_phy->iomuxc_gpr, IOMUXC_GPR14, @@
> > -76,7 +76,7 @@ static int imx8_pcie_phy_init(struct phy *phy)
> >
> >         regmap_update_bits(imx8_phy->iomuxc_gpr, IOMUXC_GPR14,
> >                            IMX8MM_GPR_PCIE_REF_CLK_SEL,
> > -                          imx8_phy->refclk_pad_mode == 1 ?
> > +                          imx8_phy->refclk_pad_mode ==
> > IMX8_PCIE_REFCLK_PAD_INPUT ?
> >                            IMX8MM_GPR_PCIE_REF_CLK_EXT :
> >                            IMX8MM_GPR_PCIE_REF_CLK_PLL);
> >         usleep_range(100, 200);
> >
> > I tested this and it works both on imx8mm-evk and imx8mm-venice-* which
> > both have external clkgen.
> >
> > However, the above does not set IMX8MM_GPR_PCIE_AUX_EN_OVERRIDE
> > for the case where CLKREQ# is connected and thus should be used so I think
> > we need to add a property for that to define if CLKREQ# is hooked up or not. I
> > tested enabling IMX8MM_GPR_PCIE_AUX_EN_OVERRIDE and as expected
> > that worked on the imx8mm-evk which hooks up CLKREQ# but not
> > imx8mm-venice which does not hook up CLKREQ#.
> >
> > What do you think about adding a property for this?
> [Richard Zhu] First of all, thanks a lot for your help to figure out the details.
> Agree with your proposal.
> One optional property "fsl,clkreq-unsupported" would be added for the CLKREQ# not hooked case later.
>
> diff --git a/Documentation/devicetree/bindings/phy/fsl,imx8-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/fsl,imx8-pcie-phy.yaml
> index 097ba2a28fb4..2264452924cc 100644
> --- a/Documentation/devicetree/bindings/phy/fsl,imx8-pcie-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/fsl,imx8-pcie-phy.yaml
> @@ -58,6 +58,11 @@ properties:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      default: 0
>
> +  fsl,clkreq-unsupported:
> +    type: boolean
> +    description: A boolean property whoes presence indicates the CLKREQ#
> +      signal isn't supported in the HW board design (optional required).
> +

A boolean property indicating the CLKREQ# signal is not supported in
the board design (optional)

>
> diff --git a/drivers/phy/freescale/phy-fsl-imx8m-pcie.c b/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
> index 07eea39283ed..4b4402eaddcc 100644
> --- a/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
> +++ b/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
> @@ -43,7 +43,7 @@
>  #define IMX8MM_GPR_PCIE_CMN_RST                BIT(18)
>  #define IMX8MM_GPR_PCIE_POWER_OFF      BIT(17)
>  #define IMX8MM_GPR_PCIE_SSC_EN         BIT(16)
> -#define IMX8MM_GPR_PCIE_REF_USE_PAD    BIT(9)
> +#define IMX8MM_GPR_PCIE_AUX_EN_OVERRIDE        BIT(9)
>
>  struct imx8_pcie_phy {
>         void __iomem            *base;
> @@ -54,6 +54,7 @@ struct imx8_pcie_phy {
>         u32                     refclk_pad_mode;
>         u32                     tx_deemph_gen1;
>         u32                     tx_deemph_gen2;
> +       bool                    clkreq_unused;
>  };
>
>  static int imx8_pcie_phy_init(struct phy *phy)
> @@ -65,13 +66,15 @@ static int imx8_pcie_phy_init(struct phy *phy)
>         reset_control_assert(imx8_phy->reset);
>
>         pad_mode = imx8_phy->refclk_pad_mode;
> +       /* Set AUX_EN_OVERRIDE 1'b0, when the CLKREQ# isn't hooked */
>         regmap_update_bits(imx8_phy->iomuxc_gpr, IOMUXC_GPR14,
> -                          IMX8MM_GPR_PCIE_REF_USE_PAD,
> -                          pad_mode == IMX8MM_GPR_PCIE_REF_USE_PAD ?
> -                          IMX8MM_GPR_PCIE_REF_USE_PAD : 0);
> +                          IMX8MM_GPR_PCIE_AUX_EN_OVERRIDE,
> +                          imx8_phy->clkreq_unused ?
> +                          0 : IMX8MM_GPR_PCIE_AUX_EN_OVERRIDE);
>         regmap_update_bits(imx8_phy->iomuxc_gpr, IOMUXC_GPR14,
>                            IMX8MM_GPR_PCIE_AUX_EN,
> -                          IMX8MM_GPR_PCIE_AUX_EN);
> +                          pad_mode == IMX8_PCIE_REFCLK_PAD_INPUT ?
> +                          IMX8MM_GPR_PCIE_AUX_EN : 0);
>         regmap_update_bits(imx8_phy->iomuxc_gpr, IOMUXC_GPR14,
>                            IMX8MM_GPR_PCIE_POWER_OFF, 0);
>         regmap_update_bits(imx8_phy->iomuxc_gpr, IOMUXC_GPR14,
> @@ -171,6 +174,11 @@ static int imx8_pcie_phy_probe(struct platform_device *pdev)
>                                  &imx8_phy->tx_deemph_gen2))
>                 imx8_phy->tx_deemph_gen2 = 0;
>
> +       if (of_property_read_bool(np, "fsl,clkreq-unsupported"))
> +               imx8_phy->clkreq_unused = true;
> +       else
> +               imx8_phy->clkreq_unused = false;
> +
>         imx8_phy->clk = devm_clk_get(dev, "ref");
>         if (IS_ERR(imx8_phy->clk)) {
>                 dev_err(dev, "failed to get imx pcie phy clock\n");
>

Yes this looks good and works both on venice (with
'fsl,clkreq-unsupported' added) and on imx8mm-evk.

Thanks for working through this with me and please cc me on your v4 submission.

Best regards,

Tim
