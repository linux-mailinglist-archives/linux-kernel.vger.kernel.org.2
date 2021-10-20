Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1A76435538
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 23:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbhJTVZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 17:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbhJTVZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 17:25:04 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D156FC061749
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 14:22:49 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id pi19-20020a17090b1e5300b0019fdd3557d3so3343556pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 14:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FCUhuGldTH9HYns0UAGDn312YQO4KkHAjojz27/KX6A=;
        b=LKELgfBOe6K5oYBeaDm2XlYuwvkcweZk0ZrU6jzO9J3wh/IFhP+J9GTpnDmS/U6FuU
         NcxjuIvtSHgf99hkuVlRqhlLCc4rVvKWAW880euPGqmIVl6jbLth5D2v0eLUEOz7s7Vc
         fdgV6E+fK2eZwivCIDtpqenxUMfdNmkVYCG1nDCHakj5yNY+6I3rkY4ctZHWJdytCSSC
         vkCN63FfJhXFcyTL6TfoEaUGiHOdCJLI0U1kclyNsGns7h2sOHvZn8uN1E7bR/mCLAjl
         f96imnC7OawmCghjlouTRkq+/lnnWvZjLmRtsIHFvhyarbrG+32cth1SMCaOeTbimw/7
         x7Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FCUhuGldTH9HYns0UAGDn312YQO4KkHAjojz27/KX6A=;
        b=n22deL6zyXSiRNMUfqItmAKu1dQqnxQvBUmy6ScOLVjRBoBWNZSmu5ls1b3RohrFxx
         TYDR5rkRC47mgIldcu7bF9s8wec8mBQ6ynpQ8am+J2xhqYppCF1gxGhWnx3QQClqmWJm
         GFsqFSlBAM9w/O1Vr/kPbtyv+G7MJT/foc7G1IiKdHV9vjdrWKaNBlDNAr6/XKgnVJxw
         T2N2ssHf9CaEMWMMaVlIhN7NoqO9fuHiMgxKm+7zJBnaeDB+abIAgUJ4RKnehPHmsy58
         XM6aY975TksLHnEIrrG8fH3YdVkc+/KcDIwJaObJs3kNXtoRdfwPUjR01Ku8+9vJ1aO/
         QO0A==
X-Gm-Message-State: AOAM533M5f4cH8ko9KDUnWFVELhkWnRFS54WXPIJ6sdWCk9W80eVVzDR
        25eTMo7pNFp+1Xx1yPvM0yz2tpAw3juSADGIQFf2cg==
X-Google-Smtp-Source: ABdhPJy3qAt+hJCyN5WtPOtSwnbd1e/GVwxow9dY6ehjsTZm6d8z2V7kZ5tEtZN4NTBX3nJK2JqKC9I5+D4XWjzfj0M=
X-Received: by 2002:a17:90a:d311:: with SMTP id p17mr1497224pju.155.1634764969062;
 Wed, 20 Oct 2021 14:22:49 -0700 (PDT)
MIME-Version: 1.0
References: <1634028078-2387-1-git-send-email-hongxing.zhu@nxp.com>
 <CAJ+vNU2b-=T_gTsRBvdF7SRUZopEFOU_Np8mEJn8bOpn5b5FaA@mail.gmail.com>
 <AS8PR04MB8676B2AC24E2769D47A1ED478CBD9@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <CAJ+vNU2AitmxCyam5FArmxAD41QUU=5CF_0JZhm+uzdkRbr7kw@mail.gmail.com> <AS8PR04MB8676840D7EDD56D10F9471288CBE9@AS8PR04MB8676.eurprd04.prod.outlook.com>
In-Reply-To: <AS8PR04MB8676840D7EDD56D10F9471288CBE9@AS8PR04MB8676.eurprd04.prod.outlook.com>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Wed, 20 Oct 2021 14:22:37 -0700
Message-ID: <CAJ+vNU2GU5=mM5+2Yg9gAuU0RSdJHWEU_+ykmz-qUWfsOnRJ8g@mail.gmail.com>
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

On Tue, Oct 19, 2021 at 7:10 PM Richard Zhu <hongxing.zhu@nxp.com> wrote:
>
> > -----Original Message-----
> > From: Tim Harvey <tharvey@gateworks.com>
> > Sent: Tuesday, October 19, 2021 11:53 PM
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
> > On Mon, Oct 18, 2021 at 7:10 PM Richard Zhu <hongxing.zhu@nxp.com>
> > wrote:
> > >
> > >
> > > > -----Original Message-----
> > > > From: Tim Harvey <tharvey@gateworks.com>
> > > > Sent: Saturday, October 16, 2021 3:59 AM
> > > > To: Richard Zhu <hongxing.zhu@nxp.com>; Lucas Stach
> > > > <l.stach@pengutronix.de>
> > > > Cc: Kishon Vijay Abraham I <kishon@ti.com>; vkoul@kernel.org; Rob
> > > > Herring <robh@kernel.org>; galak@kernel.crashing.org; Shawn Guo
> > > > <shawnguo@kernel.org>; linux-phy@lists.infradead.org; Device Tree
> > > > Mailing List <devicetree@vger.kernel.org>; Linux ARM Mailing List
> > > > <linux-arm-kernel@lists.infradead.org>; open list
> > > > <linux-kernel@vger.kernel.org>; Sascha Hauer
> > > > <kernel@pengutronix.de>; dl-linux-imx <linux-imx@nxp.com>
> > > > Subject: Re: [PATCH v3 0/9] add the imx8m pcie phy driver and imx8mm
> > > > pcie support
> > > >
> > > > On Tue, Oct 12, 2021 at 2:06 AM Richard Zhu <hongxing.zhu@nxp.com>
> > > > wrote:
> > > > >
> > > > > refer to the discussion [1] when try to enable i.MX8MM PCIe
> > > > > support, one standalone PCIe PHY driver should be seperated from
> > > > > i.MX PCIe driver when enable i.MX8MM PCIe support.
> > > > >
> > > > > This patch-set adds the standalone PCIe PHY driver suport[1-5],
> > > > > and i.MX8MM PCIe support[6-9] to have whole view to review this
> > patch-set.
> > > > >
> > > > > The PCIe works on i.MX8MM EVK board based the the blkctrl power
> > > > > driver [2] and this PHY driver patch-set.
> > > > >
> > > > > [1]
> > > > > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2F
> > > > > patc
> > > > >
> > > >
> > hwork.ozlabs.org%2Fproject%2Flinux-pci%2Fpatch%2F20210510141509.929
> > > > 120
> > > > >
> > > >
> > -3-l.stach%40pengutronix.de%2F&amp;data=04%7C01%7Chongxing.zhu%40
> > > > nxp.c
> > > > >
> > > >
> > om%7C4e3d8ee008d94327f99108d9901634be%7C686ea1d3bc2b4c6fa92cd
> > > > 99c5c3016
> > > > >
> > > >
> > 35%7C0%7C0%7C637699247319711209%7CUnknown%7CTWFpbGZsb3d8ey
> > > > JWIjoiMC4wLj
> > > > >
> > > >
> > AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp
> > > > ;sdata=
> > > > >
> > > >
> > Z2TZCpdDUSoqrNB1X%2BXdoYNBe3dBDKUgkA4r%2F0TcdOg%3D&amp;reser
> > > > ved=0
> > > > > [2]
> > > > > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2F
> > > > > patc
> > > > >
> > > >
> > hwork.kernel.org%2Fproject%2Flinux-arm-kernel%2Fcover%2F202109102026
> > > > 40
> > > > > .980366-1-l.stach%40pengutronix.de%2F&amp;data=04%7C01%7Chon
> > gxin
> > > > g.zhu%
> > > > >
> > > >
> > 40nxp.com%7C4e3d8ee008d94327f99108d9901634be%7C686ea1d3bc2b4c6
> > > > fa92cd99
> > > > >
> > > >
> > c5c301635%7C0%7C0%7C637699247319711209%7CUnknown%7CTWFpbGZ
> > > > sb3d8eyJWIjo
> > > > >
> > > >
> > iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C10
> > > > 00&amp
> > > > > ;sdata=5h%2By%2FcBW%2BjFkyplUuN1nB5%2BAFHuwCUJBqvRh1RiPY
> > Mo
> > > > %3D&amp;rese
> > > > > rved=0
> > > > >
> > > > > Main changes v2 --> v3:
> > > > > - Regarding Lucas' comments.
> > > > >  - to have a whole view to review the patches, send out the
> > > > > i.MX8MM PCIe
> > > > support too.
> > > > >  - move the PHY related bits manipulations of the GPR/SRC to
> > > > > standalone
> > > > PHY driver.
> > > > >  - split the dts changes to SOC and board DT, and use the enum
> > > > > instead of
> > > > raw value.
> > > > >  - update the license of the dt-binding header file.
> > > > >
> > > > > Changes v1 --> v2:
> > > > > - Update the license of the dt-binding header file to make the license
> > > > >   compatible with dts files.
> > > > > - Fix the dt_binding_check errors.
> > > > >
> > > > > Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml    |   6
> > +++
> > > > > Documentation/devicetree/bindings/phy/fsl,imx8-pcie-phy.yaml |  79
> > > > +++++++++++++++++++++++++++++
> > > > > arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi                |
> > 53
> > > > ++++++++++++++++++++
> > > > > arch/arm64/boot/dts/freescale/imx8mm.dtsi                    |
> > > > 46 ++++++++++++++++-
> > > > > drivers/pci/controller/dwc/pci-imx6.c                        |
> > 63
> > > > ++++++++++++++++++++++-
> > > > > drivers/phy/freescale/Kconfig                                |
> > 9
> > > > ++++
> > > > > drivers/phy/freescale/Makefile                               |
> > 1
> > > > +
> > > > > drivers/phy/freescale/phy-fsl-imx8m-pcie.c                   |
> > 218
> > > >
> > ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> > > > ++++++++++++++++++
> > > > > include/dt-bindings/phy/phy-imx8-pcie.h                      |
> > 14
> > > > ++++++
> > > > > 9 files changed, 486 insertions(+), 3 deletions(-)
> > > > >
> > > > > [PATCH v3 1/9] dt-bindings: phy: phy-imx8-pcie: Add binding for
> > > > > the [PATCH v3 2/9] dt-bindings: phy: add imx8 pcie phy driver
> > > > > support [PATCH v3 3/9] arm64: dts: imx8mm: add the pcie phy
> > > > > support [PATCH v3 4/9] arm64: dts: imx8mm-evk: add the pcie phy
> > > > > support [PATCH v3 5/9]
> > > > > phy: freescale: pcie: initialize the imx8 pcie [PATCH v3 6/9]
> > > > > dt-bindings: imx6q-pcie: Add PHY phandles and name [PATCH v3 7/9]
> > > > > arm64: dts: imx8mm: add the pcie support [PATCH v3 8/9] arm64: dts:
> > > > > imx8mm-evk: add the pcie support on imx8mm [PATCH v3 9/9] PCI: imx:
> > > > > add the imx8mm pcie support
> > > >
> > > > Richard and Lucas,
> > > >
> > > > Thanks for your collective work on this series!
> > > >
> > > > I have imx8mm-venice boards to test this on both with and without
> > > > PCIe bridges. I've tested this on top of Shawn's imx/for-next (as
> > > > blk-ctl has been merged there) and end up hanging waiting for PHY ready
> > timeout.
> > > [Richard Zhu] Sorry to reply late. I run the tests based on pci/for-next
> > applied the blk-ctl issue by Lucas [2] in commit.
> > > Can you help to make a re-tests?
> > > As I know that the blk-ctl is not merged yet.
> > > Hi Lucas:
> > > Am I right?
> > >
> >
> > Richard,
> >
> > v5 of blk-ctl is merged into Shawn's for-next tree.
> >
> [Richard Zhu] Got that.
> Thanks.
>
> > > >
> > > > [    1.454308] imx6q-pcie 33800000.pcie:       IO
> > > > 0x001ff80000..0x001ff8ffff -> 0x0
> > > > [    1.466538] imx6q-pcie 33800000.pcie:      MEM
> > > > 0x0018000000..0x001fefffff -> 0x0
> > > > [    1.476344] libphy: fec_enet_mii_bus: probed
> > > > [    1.602631] phy phy-32f00000.pcie-phy.0: phy init failed --> -110
> > > > [    1.608775] imx6q-pcie 33800000.pcie: Waiting for PHY ready
> > timeout!
> > > >
> > > > I can verify that imx8_pcie_phy_probe returns successfully and the
> > > > the phy node (imx6_pcie->phy) was found.
> > > >
> > > > Here is the dt change I made for the imx8mm-venice-gw71xx-0x board
> > > > that has no bridge:
> > > [Richard Zhu] Refer to the changes, the external OSC is used as PCIe REF
> > clock(same to EVK board design), right?
> >
> > Correct, an ext osc is used like EVK.
> >
> > I applied v5 blk-ctl and your v3 series on top of pci/next and came up with the
> > same issue. Do you have a git repo I could try to make sure I'm not missing
> > anything?
> >
> > Also, as Lucas has requested some changes do you have a v4 coming soon that
> > I should wait for to try? I believe this has something to do with the phy reset
> > where some of his changes were requested.
> [Richard Zhu] Unfortunately, I don't have personal git repo. But I think we stand on same base-line.
> I tried on Shawn's next tree with my v3 series today.
> PCIe NVME device works fine on my i.MX8MM EVK board, although there is git-am failure in the last patch when I apply the v3 series.
> Part of the logs:
> "
> root@imx8_all:~# lspci
> 00:00.0 PCI bridge: Synopsys, Inc. Device abcd (rev 01)
> 01:00.0 Non-Volatile memory controller: Sandisk Corp Device 5002
> root@imx8_all:~# uname -a
> Linux imx8_all 5.15.0-rc1-00091-g8bd7cd1cc7f0-dirty #1 SMP PREEMPT Wed Oct 20 09:22:32 CST 2021 aarch64 aarch64 aarch64 GNU/Linux
> ...
> [    1.164144] imx6q-pcie 33800000.pcie: host bridge /soc@0/pcie@33800000 ranges:
> [    1.172114] imx6q-pcie 33800000.pcie:       IO 0x001ff80000..0x001ff8ffff -> 0x0000000000
> [    1.182447] imx6q-pcie 33800000.pcie:      MEM 0x0018000000..0x001fefffff -> 0x0018000000
> [    1.304429] imx6q-pcie 33800000.pcie: invalid resource

Richard,

What is this 'invalid resource' about? I see that with my downstream
IMX8MM PCIe driver as well and have been asked about it.

> [    1.316305] imx6q-pcie 33800000.pcie: iATU unroll: enabled
> [    1.321799] imx6q-pcie 33800000.pcie: Detected iATU regions: 4 outbound, 4 inbound
> [    1.429803] imx6q-pcie 33800000.pcie: Link up
> [    1.534497] imx6q-pcie 33800000.pcie: Link up
> [    1.538870] imx6q-pcie 33800000.pcie: Link up, Gen2
> [    1.550364] imx6q-pcie 33800000.pcie: Link up
> [    1.550487] imx6q-pcie 33800000.pcie: PCI host bridge to bus 0000:00
> [    1.565545] pci_bus 0000:00: root bus resource [bus 00-ff]
> [    1.573834] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
> [    1.580055] pci_bus 0000:00: root bus resource [mem 0x18000000-0x1fefffff]
> [    1.586968] pci 0000:00:00.0: [16c3:abcd] type 01 class 0x060400
> [    1.592997] pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x000fffff]
> [    1.599282] pci 0000:00:00.0: reg 0x38: [mem 0x00000000-0x0000ffff pref]
> [    1.606033] pci 0000:00:00.0: supports D1
> [    1.610053] pci 0000:00:00.0: PME# supported from D0 D1 D3hot D3cold
> [    1.618206] pci 0000:01:00.0: [15b7:5002] type 00 class 0x010802
> [    1.624293] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00003fff 64bit]
> [    1.631177] pci 0000:01:00.0: reg 0x20: [mem 0x00000000-0x000000ff 64bit]
> [    1.638409] pci 0000:01:00.0: 4.000 Gb/s available PCIe bandwidth, limited by 5.0 GT/s PCIe x1 link at 0000:00:00.0 (capable of 31.504 Gb/s with 8.0 GT/s PCIe x4 link)
> [    1.664931] pci 0000:00:00.0: BAR 0: assigned [mem 0x18000000-0x180fffff]
> [    1.671745] pci 0000:00:00.0: BAR 14: assigned [mem 0x18100000-0x181fffff]
> [    1.678634] pci 0000:00:00.0: BAR 6: assigned [mem 0x18200000-0x1820ffff pref]
> [    1.685873] pci 0000:01:00.0: BAR 0: assigned [mem 0x18100000-0x18103fff 64bit]
> [    1.693222] pci 0000:01:00.0: BAR 4: assigned [mem 0x18104000-0x181040ff 64bit]
> [    1.700577] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
> [    1.705814] pci 0000:00:00.0:   bridge window [mem 0x18100000-0x181fffff]
> [    1.712972] pcieport 0000:00:00.0: PME: Signaling with IRQ 216
> "
> Regarding the log you pasted, it seems that the clock is not feed to PHY properly.
>
> Anyway, let's waiting for the v4 series, then make a try. Thanks for your great help to make the double tests.
>

My boards do not use CLKREQ# so I do not have that defined in pinmux
and I found that if I add MX8MM_IOMUXC_I2C4_SCL_PCIE1_CLKREQ_B PCIe
works on my board but this isn't a solution just a work-around (I have
boards that use the only two possible pins for CLKREQ as other
features).

Similarly you will find on the imx8mm-evk if you comment out the
CLKREQ (which isn't required) the imx8mmevk will end up hanging like
my boards:
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
index 5ce43daa0c8b..f0023b48f475 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
@@ -448,7 +448,9 @@

        pinctrl_pcie0: pcie0grp {
                fsl,pins = <
+/*
                        MX8MM_IOMUXC_I2C4_SCL_PCIE1_CLKREQ_B    0x61
+*/
                        MX8MM_IOMUXC_SAI2_RXFS_GPIO4_IO21       0x41
                >;
        };

I have PCIe working with a driver that I ported from NXP's kernel
which differs from your driver in that the PCIe PHY is not abstracted
to its own driver so I think this has something to do with the order
in which the phy is reset or initialized? The configuration of gpr14
bits looks correct to me.

Best regards,

Tim
