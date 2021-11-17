Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABFEA454CB7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 19:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239804AbhKQSF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 13:05:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239797AbhKQSFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 13:05:55 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2043C061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 10:02:56 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id n15-20020a17090a160f00b001a75089daa3so5918760pja.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 10:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YeksuhhtUSz3GhzKKAUUL77SPdpKkfceYUSYzKoqHp8=;
        b=Pv5crV2pxyRv+BFsVoplyB6KW7BdHUcRbArMKYrck50DfuMy1IjZNb84b3/ACs1LP0
         Q/LoHQfoY0mLKaGEPN8FPB8Moir+NEpe8yJXR8IOd3bYFjLzV69IjLlsUzj4gAfK8Q3C
         8qCYKEL353V04wGUaOSMw0aaZIlXR5Mu5fLU8G3Br1PUKiYNkNllFWLiDq10Rpj/JxB8
         f/cVGbf7LuXTpapKhMbmsZ8p9Rq2j5+a5j16xGA2D4zBl4bxSr/uMgv2yHmjqRYO3J6J
         ZsiD2BUnkAijC8mpiT/o0J1KgEZeuEutfgnhij1DB3tZRWXTYbY9VHw2DjmYeh325eqU
         wpRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YeksuhhtUSz3GhzKKAUUL77SPdpKkfceYUSYzKoqHp8=;
        b=2NFHZICguyc5hyqgEdvzpfyQgsRPYGKgI9cAS1DCiK1Tt/xMEc9HhAsPDMUmZZyeUA
         Wp57BSHTWsLwcZL+3LLuP8DVKzxyPcEhvzIYardQ0Ykoqm5kqNZkh9eX+xPIf/fEu5mi
         P+Manfjhx1Y27vg22RHYHYe/COZoiFn8J+B2bCiv2UMNpsDt0dYM79+L8LtRqXp8CJ+q
         NUbrfYd26xCbGEZtOpYU+RfGv98nmJ2xU0VO68abiYI49ir2SLWwVFCFwmsX5azIA0ng
         4/uLtSPf4W2+E9dPlzXIjYryw4YMqmgaw18A280aFvSTOgcknc4al9RqD7QjqGtbKpvE
         HLxQ==
X-Gm-Message-State: AOAM5327V2iJTYslXpfYwnFwN9Zcqw9CLTcBQtOmThTgazLjcOI6JJrU
        dwQd4QH0tVbvOP4/KxZS+oZlkw0pjzkvEjnm3Ik7hw==
X-Google-Smtp-Source: ABdhPJwi+mtQ6SLVOKdkUsgwBPIY98hwm8sA7tdtwSHEH+HdOwI1VSXIr/L2aA6SjU4q5muVeSSgOIwkzlVrdzLIM3k=
X-Received: by 2002:a17:90b:17cc:: with SMTP id me12mr1866025pjb.179.1637172176108;
 Wed, 17 Nov 2021 10:02:56 -0800 (PST)
MIME-Version: 1.0
References: <1635820355-27009-1-git-send-email-hongxing.zhu@nxp.com>
 <CAJ+vNU3r0aC8GrTQ2z5BqsCFCAXP+BWt2ntqsNy8DBd--nxdvQ@mail.gmail.com>
 <AS8PR04MB86760660BD24E4C2BD98F6318C999@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <AS8PR04MB867632F01C9B0524BE994A5F8C9A9@AS8PR04MB8676.eurprd04.prod.outlook.com>
In-Reply-To: <AS8PR04MB867632F01C9B0524BE994A5F8C9A9@AS8PR04MB8676.eurprd04.prod.outlook.com>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Wed, 17 Nov 2021 10:02:45 -0800
Message-ID: <CAJ+vNU0VZ1S7RoJuT-9KD7+V_s_qpvZzawR9cVejVjmnQkxBQA@mail.gmail.com>
Subject: Re: [PATCH v5 0/8] Add the imx8m pcie phy driver and imx8mm pcie support
To:     Hongxing Zhu <hongxing.zhu@nxp.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
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

On Tue, Nov 16, 2021 at 7:38 PM Hongxing Zhu <hongxing.zhu@nxp.com> wrote:
>
> <snipped...>
> > > Subject: Re: [PATCH v5 0/8] Add the imx8m pcie phy driver and imx8mm
> > > pcie support
> > >
> > > On Mon, Nov 1, 2021 at 7:58 PM Richard Zhu <hongxing.zhu@nxp.com>
> > > wrote:
> > > >
> > > > Refer to the discussion [1] when try to enable i.MX8MM PCIe support,
> > > > one standalone PCIe PHY driver should be seperated from i.MX PCIe
> > > > driver when enable i.MX8MM PCIe support.
> > > >
> > > > This patch-set adds the standalone PCIe PHY driver suport[1-5], and
> > > > i.MX8MM PCIe support[6-8] to have whole view to review this
> > > patch-set.
> > > >
> > > > The PCIe works on i.MX8MM EVK board based the the blkctrl power
> > > driver
> > > > [2] and this patch-set. And tested by Tim and Marcel on the
> > > > different reference clock modes boards.
> > > >
> > > > [1]
> > > >
> > >
> > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpa
> > > tc
> > > >
> > >
> > hwork.ozlabs.org%2Fproject%2Flinux-pci%2Fpatch%2F20210510141509.
> > > 929120
> > > >
> > >
> > -3-l.stach%40pengutronix.de%2F&amp;data=04%7C01%7Chongxing.zhu
> > > %40nxp.c
> > > >
> > >
> > om%7C489971db9c0f4308600208d9a88b2b05%7C686ea1d3bc2b4c6fa9
> > > 2cd99c5c3016
> > > >
> > >
> > 35%7C0%7C0%7C637726137953234928%7CUnknown%7CTWFpbGZsb3d
> > > 8eyJWIjoiMC4wLj
> > > >
> > >
> > AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&
> > > amp;sdata=
> > > >
> > >
> > ltuNZqIAsEH6%2B1KE4cqNOiUul3Ex%2BWmYcyqD%2BFJuUrs%3D&amp;
> > > reserved=0
> > > > [2]
> > > >
> > >
> > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpa
> > > tc
> > > >
> > >
> > hwork.kernel.org%2Fproject%2Flinux-arm-kernel%2Fcover%2F20210910
> > > 202640
> > > > .980366-1-l.stach%40pengutronix.de%2F&amp;data=04%7C01%7Ch
> > on
> > > gxing.zhu%
> > > >
> > >
> > 40nxp.com%7C489971db9c0f4308600208d9a88b2b05%7C686ea1d3bc2
> > > b4c6fa92cd99
> > > >
> > >
> > c5c301635%7C0%7C0%7C637726137953234928%7CUnknown%7CTWFp
> > > bGZsb3d8eyJWIjo
> > > >
> > >
> > iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%
> > > 7C3000&amp
> > > > ;sdata=MrT3Re3YttE9AoqmGHksTqt4jF4vitRPz5lkgpZqSZ4%3D&amp;r
> > es
> > > erved=0
> > > >
> > > > Main changes v4 --> v5:
> > > > - Set the AUX_EN always 1b'1, thus it can fix the regression
> > > > introduced
> > > in v4
> > > >   series on Marcel's board.
> > > > - Use the lower-case letter in the devicetreee refer to Marcel's
> > > comments.
> > > > - Since the default value of the deemphasis parameters are zero,
> > > > only
> > > set
> > > >   the deemphasis registers when the input paramters are none zero.
> > > >
> > > > Main changes v3 --> v4:
> > > > - Update the yaml to fix syntax error, add maxitems and drop
> > > > description of phy
> > > > - Correct the clock name in PHY DT node.
> > > > - Squash the EVK board relalted dts changes into one patch, and drop
> > > the
> > > >   useless dummy clock and gpio suffix in DT nodes.
> > > > - Add board specific de-emphasis parameters as DT properties. Thus
> > > each board
> > > >   can specify its actual de-emphasis values.
> > > > - Update the commit log of PHY driver.
> > > > - Remove the useless codes from PCIe driver, since they are moved to
> > > > PHY driver
> > > > - After the discussion and verification of the CLKREQ#
> > > > configurations
> > > with Tim,
> > > >   agree to add an optional boolean property
> > > > "fsl,clkreq-unsupported",
> > > indicates
> > > >   the CLKREQ# signal is hooked or not in HW designs.
> > > > - Add "Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>"
> > > > tag,
> > > since
> > > >   Marcel help to test the v3 patch-set.
> > > >
> > > > Main changes v2 --> v3:
> > > > - Regarding Lucas' comments.
> > > >  - to have a whole view to review the patches, send out the
> > i.MX8MM
> > > PCIe support too.
> > > >  - move the PHY related bits manipulations of the GPR/SRC to
> > > standalone PHY driver.
> > > >  - split the dts changes to SOC and board DT, and use the enum
> > > > instead
> > > of raw value.
> > > >  - update the license of the dt-binding header file.
> > > >
> > > > Changes v1 --> v2:
> > > > - Update the license of the dt-binding header file to make the license
> > > >   compatible with dts files.
> > > > - Fix the dt_binding_check errors.
> > > >
> > > > Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml    |
> > 6
> > > +++
> > > > Documentation/devicetree/bindings/phy/fsl,imx8-pcie-phy.yaml |
> > 95
> > > ++++++++++++++++++++++++++++++++
> > > > arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> > |
> > > 55 +++++++++++++++++++
> > > > arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > |
> > > 46 +++++++++++++++-
> > > > drivers/pci/controller/dwc/pci-imx6.c                        |
> > > 73 ++++++++++++++++++++++---
> > > > drivers/phy/freescale/Kconfig
> > |
> > > 9 ++++
> > > > drivers/phy/freescale/Makefile
> > |
> > > 1 +
> > > > drivers/phy/freescale/phy-fsl-imx8m-pcie.c                   |
> > > 237
> > >
> > +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> > > +++++++++++++++++++++
> > > > include/dt-bindings/phy/phy-imx8-pcie.h                      |
> > > 14 +++++
> > > > 9 files changed, 528 insertions(+), 8 deletions(-)
> > > >
> > > > [PATCH v5 1/8] dt-bindings: phy: phy-imx8-pcie: Add binding for the
> > > > [PATCH v5 2/8] dt-bindings: phy: Add imx8 pcie phy driver support
> > > > [PATCH v5 3/8] dt-bindings: imx6q-pcie: Add PHY phandles and name
> > > > [PATCH v5 4/8] arm64: dts: imx8mm: Add the pcie phy support
> > [PATCH
> > > v5
> > > > 5/8] phy: freescale: pcie: Initialize the imx8 pcie [PATCH v5 6/8]
> > > > arm64: dts: imx8mm: Add the pcie support [PATCH v5 7/8] arm64:
> > dts:
> > > > imx8mm-evk: Add the pcie support on imx8mm [PATCH v5 8/8] PCI:
> > > imx:
> > > > Add the imx8mm pcie support
> > >
> > > Richard,
> > >
> > > Are you posting a v6 of this series or have we already missed the
> > > window for 5.16?
> > [Richard Zhu] Hi Tim:
> > Thanks for your kindly reminder.
> > In my original plan, I prefer to merge the codes refine firstly, then issue
> > the v6 patch-set after the rebase.
> > https://patchwork.kernel.org/project/linux-arm-kernel/cover/163574747
> > 8-25562-1-git-send-email-hongxing.zhu@nxp.com/
> > Unfortunately, I don't get ack from Lucas for other four patches.
> > Anyway, I would post the v6 patch-set immediately after merge Rob's
> > comments.
> >
> > Best Regards
> > Richard Zhu
> > >
> > > Best regards,
> > >
> [Richard Zhu] Hi Tim:
> The V6 patch-set listed below had been issued.
> " https://patchwork.kernel.org/project/linux-phy/cover/1637028976-9201-1-git-send-email-hongxing.zhu@nxp.com/"
> GENERIC PHY FRAMEWORK maintainer Kishon and Vinod had been contained in the
>  mail-loop.
> Do you know who I can ping to pick up the PHY part of this patch-set?
>

Richard,

Thanks for posting the v6 series. Hopefully you can get Rob's ACK on
the last dt-binding patch. I'm not sure who would pick up patches in
drivers/phy - I don't see a maintainer for that dir. Perhaps Lucas
knows?

I noticed you did not send your v5 or v6 patchset to
linux-pci@vger.kernel.org so its missing from
https://patchwork.kernel.org/project/linux-pci/list/ and maybe that's
why you haven't gotten ack's yet?

Best regards,

Tim


Tim
