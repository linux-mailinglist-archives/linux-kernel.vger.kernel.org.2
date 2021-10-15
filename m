Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F268342FCA4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 21:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242825AbhJOUA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 16:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233148AbhJOUAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 16:00:54 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF09C061570
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 12:58:47 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id 187so9228889pfc.10
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 12:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hz7r6BFvrOpau2uIaTsoIcbuj0JbSeYr97U3tKgGrH0=;
        b=SpBE04GJFNNhNYW/kryW2MKmHha47IJ0WgEQ8+cG4TJ01igQOsA35GS6dgtz2u4m52
         /TbLL/aaM5vZXTZv03P2IWWpEpiAz02ENwkPWBv4WfHr/98PcRPO5hK4H4yGovPIyuP1
         lIqnwbZSd1gWvYDWyySn840nDh6fUCxpw7LpVkPeNuMyMH664Z/IpNiw9XeUj/jdzQht
         y5qneoks49EB2GDj/M5zDhpdlTxfMIEyFZP9tfAAcZ4rz5OLwGMVHqCt5PIgBJY5Kfbb
         ADK0xFuY5W15GEXL9W7Uz1NRJWZOaZ7fhUN/vQ1u+X6qkH5JnufVIIMN1VqEXBI715oe
         CRgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hz7r6BFvrOpau2uIaTsoIcbuj0JbSeYr97U3tKgGrH0=;
        b=yBWu0MT0kJ3g4BSO93B5M8QYKaBpHdOEpKGHIHgBQVJcJtjnUgSrwqZJ5SLSCaTEv9
         goz7Q3DIerGdujkLLG2v2Ucmgw2wcVnoHySjmJWC/3Pb5jNaln9y1yGy85aevkKjuvR4
         AfpA8FPNlcbbBJdFsW4TBmPdAPonNgovQ81q5X4j4ynOqp074ag2/HMMo3s5x3440KH3
         y8bBRRG50kKepenr4SAVq0/UnB3qLOhX75SuRENFe2IM5pJ5hjXT1UWOAbz4uiECc9bU
         JOeAnoD+lBwCFsF6N3SzY7dRsmAp8fGU+CO9H+PpyRhhs7jSAna1ukwRpsNSfmBmXQQ4
         SyWw==
X-Gm-Message-State: AOAM531THNrbkN+94hjlkxczg4+gn0LVtaG8JV34bkx4os2GESdhTSe7
        wuE+ivZk+T7iDqRDh/VVpTUpUXBq8u9wlJwn9DhkVQ==
X-Google-Smtp-Source: ABdhPJwldtXheq6baEagvFBbH5VIZUkfUG3EfF0IXS7sHnDsvap6NnSPbGjxoQEI9zenss4unhQh8IgpS1byZWESBwg=
X-Received: by 2002:a62:77d8:0:b0:44c:8618:1bed with SMTP id
 s207-20020a6277d8000000b0044c86181bedmr13681759pfc.27.1634327927074; Fri, 15
 Oct 2021 12:58:47 -0700 (PDT)
MIME-Version: 1.0
References: <1634028078-2387-1-git-send-email-hongxing.zhu@nxp.com>
In-Reply-To: <1634028078-2387-1-git-send-email-hongxing.zhu@nxp.com>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Fri, 15 Oct 2021 12:58:36 -0700
Message-ID: <CAJ+vNU2b-=T_gTsRBvdF7SRUZopEFOU_Np8mEJn8bOpn5b5FaA@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] add the imx8m pcie phy driver and imx8mm pcie support
To:     Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>, vkoul@kernel.org,
        Rob Herring <robh@kernel.org>, galak@kernel.crashing.org,
        Shawn Guo <shawnguo@kernel.org>, linux-phy@lists.infradead.org,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2021 at 2:06 AM Richard Zhu <hongxing.zhu@nxp.com> wrote:
>
> refer to the discussion [1] when try to enable i.MX8MM PCIe support,
> one standalone PCIe PHY driver should be seperated from i.MX PCIe
> driver when enable i.MX8MM PCIe support.
>
> This patch-set adds the standalone PCIe PHY driver suport[1-5], and i.MX8MM
> PCIe support[6-9] to have whole view to review this patch-set.
>
> The PCIe works on i.MX8MM EVK board based the the blkctrl power driver
> [2] and this PHY driver patch-set.
>
> [1] https://patchwork.ozlabs.org/project/linux-pci/patch/20210510141509.929120-3-l.stach@pengutronix.de/
> [2] https://patchwork.kernel.org/project/linux-arm-kernel/cover/20210910202640.980366-1-l.stach@pengutronix.de/
>
> Main changes v2 --> v3:
> - Regarding Lucas' comments.
>  - to have a whole view to review the patches, send out the i.MX8MM PCIe support too.
>  - move the PHY related bits manipulations of the GPR/SRC to standalone PHY driver.
>  - split the dts changes to SOC and board DT, and use the enum instead of raw value.
>  - update the license of the dt-binding header file.
>
> Changes v1 --> v2:
> - Update the license of the dt-binding header file to make the license
>   compatible with dts files.
> - Fix the dt_binding_check errors.
>
> Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml    |   6 +++
> Documentation/devicetree/bindings/phy/fsl,imx8-pcie-phy.yaml |  79 +++++++++++++++++++++++++++++
> arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi                |  53 ++++++++++++++++++++
> arch/arm64/boot/dts/freescale/imx8mm.dtsi                    |  46 ++++++++++++++++-
> drivers/pci/controller/dwc/pci-imx6.c                        |  63 ++++++++++++++++++++++-
> drivers/phy/freescale/Kconfig                                |   9 ++++
> drivers/phy/freescale/Makefile                               |   1 +
> drivers/phy/freescale/phy-fsl-imx8m-pcie.c                   | 218 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> include/dt-bindings/phy/phy-imx8-pcie.h                      |  14 ++++++
> 9 files changed, 486 insertions(+), 3 deletions(-)
>
> [PATCH v3 1/9] dt-bindings: phy: phy-imx8-pcie: Add binding for the
> [PATCH v3 2/9] dt-bindings: phy: add imx8 pcie phy driver support
> [PATCH v3 3/9] arm64: dts: imx8mm: add the pcie phy support
> [PATCH v3 4/9] arm64: dts: imx8mm-evk: add the pcie phy support
> [PATCH v3 5/9] phy: freescale: pcie: initialize the imx8 pcie
> [PATCH v3 6/9] dt-bindings: imx6q-pcie: Add PHY phandles and name
> [PATCH v3 7/9] arm64: dts: imx8mm: add the pcie support
> [PATCH v3 8/9] arm64: dts: imx8mm-evk: add the pcie support on imx8mm
> [PATCH v3 9/9] PCI: imx: add the imx8mm pcie support

Richard and Lucas,

Thanks for your collective work on this series!

I have imx8mm-venice boards to test this on both with and without PCIe
bridges. I've tested this on top of Shawn's imx/for-next (as blk-ctl
has been merged there) and end up hanging waiting for PHY ready
timeout.

[    1.454308] imx6q-pcie 33800000.pcie:       IO
0x001ff80000..0x001ff8ffff -> 0x0
[    1.466538] imx6q-pcie 33800000.pcie:      MEM
0x0018000000..0x001fefffff -> 0x0
[    1.476344] libphy: fec_enet_mii_bus: probed
[    1.602631] phy phy-32f00000.pcie-phy.0: phy init failed --> -110
[    1.608775] imx6q-pcie 33800000.pcie: Waiting for PHY ready timeout!

I can verify that imx8_pcie_phy_probe returns successfully and the the
phy node (imx6_pcie->phy) was found.

Here is the dt change I made for the imx8mm-venice-gw71xx-0x board
that has no bridge:
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx.dtsi
b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx.dtsi
index 91544576f145..e89e9cf7318e 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx.dtsi
@@ -5,6 +5,7 @@

 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/leds/common.h>
+#include <dt-bindings/phy/phy-imx8-pcie.h>

 / {
        aliases {
@@ -33,6 +34,12 @@
                };
        };

+       pcie0_refclk: pcie0-refclk {
+               compatible = "fixed-clock";
+               #clock-cells = <0>;
+               clock-frequency = <100000000>;
+       };
+
        pps {
                compatible = "pps-gpio";
                pinctrl-names = "default";
@@ -101,6 +108,27 @@
        status = "okay";
 };

+&pcie0 {
+       pinctrl-names = "default";
+       pinctrl-0 = <&pinctrl_pcie0>;
+       reset-gpio = <&gpio4 6 GPIO_ACTIVE_LOW>;
+       clocks = <&clk IMX8MM_CLK_PCIE1_ROOT>, <&clk IMX8MM_CLK_PCIE1_AUX>,
+                <&clk IMX8MM_CLK_DUMMY>, <&pcie0_refclk>;
+       clock-names = "pcie", "pcie_aux", "pcie_phy", "pcie_bus";
+       assigned-clocks = <&clk IMX8MM_CLK_PCIE1_AUX>,
+                         <&clk IMX8MM_CLK_PCIE1_CTRL>;
+       assigned-clock-rates = <10000000>, <250000000>;
+       assigned-clock-parents = <&clk IMX8MM_SYS_PLL2_50M>,
+                                <&clk IMX8MM_SYS_PLL2_250M>;
+       status = "okay";
+};
+
+&pcie_phy {
+       fsl,refclk-pad-mode = <IMX8_PCIE_REFCLK_PAD_INPUT>;
+       clocks = <&clk IMX8MM_CLK_DUMMY>;
+       status = "okay";
+};
+
 /* GPS */
 &uart1 {
        pinctrl-names = "default";
@@ -162,6 +190,12 @@
                >;
        };

+       pinctrl_pcie0: pciegrp {
+               fsl,pins = <
+                       MX8MM_IOMUXC_SAI1_RXD4_GPIO4_IO6        0x41
+               >;
+       };
+
        pinctrl_pps: ppsgrp {
                fsl,pins = <
                        MX8MM_IOMUXC_GPIO1_IO15_GPIO1_IO15      0x41

and here are the changes to the imx8mm-venice-gw72xx-0x dt - this
board has a PCIe bridge:

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx.dtsi
b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx.dtsi
index b12ead847302..260ea93ebfc2 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx.dtsi
@@ -5,9 +5,11 @@

 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/leds/common.h>
+#include <dt-bindings/phy/phy-imx8-pcie.h>

 / {
        aliases {
+               ethernet1 = &eth1;
                usb0 = &usbotg1;
                usb1 = &usbotg2;
        };
@@ -33,6 +35,12 @@
                };
        };

+       pcie0_refclk: pcie0-refclk {
+               compatible = "fixed-clock";
+               #clock-cells = <0>;
+               clock-frequency = <100000000>;
+       };
+
        pps {
                compatible = "pps-gpio";
                pinctrl-names = "default";
@@ -122,6 +130,53 @@
        status = "okay";
 };

+&pcie0 {
+       pinctrl-names = "default";
+       pinctrl-0 = <&pinctrl_pcie0>;
+       reset-gpio = <&gpio4 6 GPIO_ACTIVE_LOW>;
+       clocks = <&clk IMX8MM_CLK_PCIE1_ROOT>, <&clk IMX8MM_CLK_PCIE1_AUX>,
+                <&clk IMX8MM_CLK_DUMMY>, <&pcie0_refclk>;
+       clock-names = "pcie", "pcie_aux", "pcie_phy", "pcie_bus";
+       assigned-clocks = <&clk IMX8MM_CLK_PCIE1_AUX>,
+                         <&clk IMX8MM_CLK_PCIE1_CTRL>;
+       assigned-clock-rates = <10000000>, <250000000>;
+       assigned-clock-parents = <&clk IMX8MM_SYS_PLL2_50M>,
+                                <&clk IMX8MM_SYS_PLL2_250M>;
+       status = "okay";
+
+       pcie@0,0 {
+               reg = <0x0000 0 0 0 0>;
+               #address-cells = <1>;
+               #size-cells = <0>;
+
+               pcie@1,0 {
+                       reg = <0x0000 0 0 0 0>;
+                       #address-cells = <1>;
+                       #size-cells = <0>;
+
+                       pcie@2,3 {
+                               reg = <0x1800 0 0 0 0>;
+                               #address-cells = <1>;
+                               #size-cells = <0>;
+
+                               eth1: pcie@5,0 {
+                                       reg = <0x0000 0 0 0 0>;
+                                       #address-cells = <1>;
+                                       #size-cells = <0>;
+
+                                       local-mac-address = [00 00 00 00 00 00];
+                               };
+                       };
+               };
+       };
+};
+
+&pcie_phy {
+       fsl,refclk-pad-mode = <IMX8_PCIE_REFCLK_PAD_INPUT>;
+       clocks = <&clk IMX8MM_CLK_DUMMY>;
+       status = "okay";
+};
+
 /* off-board header */
 &sai3 {
        pinctrl-names = "default";
@@ -214,6 +269,12 @@
                >;
        };

+       pinctrl_pcie0: pciegrp {
+               fsl,pins = <
+                       MX8MM_IOMUXC_SAI1_RXD4_GPIO4_IO6        0x41
+               >;
+       };
+
        pinctrl_pps: ppsgrp {
                fsl,pins = <
                        MX8MM_IOMUXC_GPIO1_IO15_GPIO1_IO15      0x41


Any ideas?

Perhaps
