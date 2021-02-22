Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B950E321226
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 09:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbhBVIlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 03:41:21 -0500
Received: from mail-ed1-f48.google.com ([209.85.208.48]:32864 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhBVIlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 03:41:14 -0500
Received: by mail-ed1-f48.google.com with SMTP id c6so20838835ede.0;
        Mon, 22 Feb 2021 00:40:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B8/se+9b5rm/zb8+7j4TLt7/sbWPl6iL+HMKwsHbZZs=;
        b=jsnSEbudB2NHqmO+lXJYsapyAPdspqB0tc1ticcfff4vpOmiePaZbVbM7vDcxAjlpY
         infyvTupbAQaqGmMrlJqzG6ROpaLxQIUGCJmk7bbwCZB9Y/Qmyy/xQ6gY0IV6JxC2JhF
         gaFC0XudSUF5zKIVRvqJEh21cvKLo9bsAhXl9n4fNf0S38Yla0YQ2FNSwEj/BZ4w55L6
         1mnKYhqqwEv7IrZndUv96DWTahvVRIFSqDjNN1n6Tu7QFdylruj8PIpH60nOLA13+85O
         e8TWBZB1Sb9M07lQMG5mrZ1n4L+sh0QtMBJ1OYHayaa5L9z75CupFjIWH9ovuwdxatI7
         nc4g==
X-Gm-Message-State: AOAM532gZucLyOcvhFnjvd8W2JXcmlaHiktJKoHG3OQp3C7s+O4nuE4G
        5c0e+bUiDRMyfC0E922SxRk=
X-Google-Smtp-Source: ABdhPJwhCYP7PG10WsHAO2VYvFZZvKxhBTZpDCKgw1xHf/2Jo6lRRkC6Ft2rnyuTnxx4qKapmSfqUg==
X-Received: by 2002:a05:6402:4382:: with SMTP id o2mr21923880edc.371.1613983230131;
        Mon, 22 Feb 2021 00:40:30 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id g3sm11582497edk.75.2021.02.22.00.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 00:40:29 -0800 (PST)
Date:   Mon, 22 Feb 2021 09:40:27 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Heiko Thiery <heiko.thiery@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, Michael Walle <michael@walle.cc>
Subject: Re: [PATCH 2/2] arm64: dts: fsl: add support for Kontron pitx-imx8m
 board
Message-ID: <20210222084027.jd3eop7j4czoqqim@kozik-lap>
References: <20210218123327.25486-1-heiko.thiery@gmail.com>
 <20210218123327.25486-3-heiko.thiery@gmail.com>
 <20210221121111.nsenzgenwb6pu3o7@kozik-lap>
 <CAEyMn7YN4xqcFxR0QHUDp8cc1QP62HgpGMCYAjh0RfWL-iRQCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEyMn7YN4xqcFxR0QHUDp8cc1QP62HgpGMCYAjh0RfWL-iRQCA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 22, 2021 at 08:46:52AM +0100, Heiko Thiery wrote:
> Hi Krysztof,
> 
> Am So., 21. Feb. 2021 um 13:11 Uhr schrieb Krzysztof Kozlowski
> <krzk@kernel.org>:
> >
> > On Thu, Feb 18, 2021 at 01:33:29PM +0100, Heiko Thiery wrote:
> > > The Kontron pitx-imx8m board is based on an i.MX8MQ soc.
> > >
> > > Signed-off-by: Heiko Thiery <heiko.thiery@gmail.com>
> > > ---
> > >  arch/arm64/boot/dts/freescale/Makefile        |   1 +
> > >  .../freescale/imx8mq-kontron-pitx-imx8m.dts   | 675 ++++++++++++++++++
> > >  2 files changed, 676 insertions(+)
> > >  create mode 100644 arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dts
> > >
> > > diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> > > index 6438db3822f8..9fc2c6f64407 100644
> > > --- a/arch/arm64/boot/dts/freescale/Makefile
> > > +++ b/arch/arm64/boot/dts/freescale/Makefile
> > > @@ -47,6 +47,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mp-evk.dtb
> > >  dtb-$(CONFIG_ARCH_MXC) += imx8mp-phyboard-pollux-rdk.dtb
> > >  dtb-$(CONFIG_ARCH_MXC) += imx8mq-evk.dtb
> > >  dtb-$(CONFIG_ARCH_MXC) += imx8mq-hummingboard-pulse.dtb
> > > +dtb-$(CONFIG_ARCH_MXC) += imx8mq-kontron-pitx-imx8m.dtb
> > >  dtb-$(CONFIG_ARCH_MXC) += imx8mq-librem5-devkit.dtb
> > >  dtb-$(CONFIG_ARCH_MXC) += imx8mq-librem5-r2.dtb
> > >  dtb-$(CONFIG_ARCH_MXC) += imx8mq-librem5-r3.dtb
> > > diff --git a/arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dts b/arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dts
> > > new file mode 100644
> > > index 000000000000..79805928204e
> > > --- /dev/null
> > > +++ b/arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dts
> > > @@ -0,0 +1,675 @@
> > > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > > +/*
> > > + * Device Tree File for the Kontron pitx-imx8m board.
> > > + *
> > > + * Copyright (C) 2021 Heiko Thiery <heiko.thiery@gmail.com>
> > > + */
> > > +
> > > +/dts-v1/;
> > > +
> > > +#include "imx8mq.dtsi"
> > > +#include <dt-bindings/net/ti-dp83867.h>
> > > +
> > > +/ {
> > > +     model = "Kontron pITX-imx8m";
> > > +     compatible = "kontron,pitx-imx8m", "fsl,imx8mq";
> > > +
> > > +     aliases {
> > > +             i2c0 = &i2c1;
> > > +             i2c1 = &i2c2;
> > > +             i2c2 = &i2c3;
> > > +             mmc0 = &usdhc1;
> > > +             mmc1 = &usdhc2;
> > > +             serial0 = &uart1;
> > > +             serial1 = &uart2;
> > > +             serial2 = &uart3;
> > > +             spi0 = &qspi0;
> > > +             spi1 = &ecspi2;
> > > +     };
> > > +
> > > +     chosen {
> > > +             stdout-path = "serial2:115200n8";
> > > +     };
> > > +
> > > +     regulators {
> > > +             compatible = "simple-bus";
> > > +             #address-cells = <1>;
> > > +             #size-cells = <0>;
> > > +
> > > +             reg_usdhc2_vmmc: regulator-v-3v3-sd {
> >
> > That's a messed unit addressing. You have here simple-bus but no unit
> > addresses. Move it out of regulators node and run make dtc W=1 (it would
> > point you this issue).
> 
> Ok, I will change that.
> 
> But I'm not able to run dtc on my dts. dtc throws an error.
> 
> # dtc -I dts -O dtb imx8mq-kontron-pitx-imx8m.dts
> Error: imx8mq-kontron-pitx-imx8m.dts:10.1-9 syntax error
> FATAL ERROR: Unable to parse input tree
> 
> It is about the includes. How can I run dtc for a intree dts to add
> the -W option?

make dtbs W=1

> 
> > > +                     compatible = "regulator-fixed";
> > > +                     regulator-name = "V_3V3_SD";
> > > +                     regulator-min-microvolt = <3300000>;
> > > +                     regulator-max-microvolt = <3300000>;
> > > +                     gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
> > > +                     off-on-delay-us = <20000>;
> > > +                     enable-active-high;
> > > +             };
> > > +     };
> > > +
> > > +     usb_hub_reset: usb-hub-reset {
> > > +             compatible = "gpio-reset";
> > > +             reset-gpios = <&gpio3 4 GPIO_ACTIVE_LOW>;
> > > +             reset-delay-us = <3000>;
> > > +             reset-post-delay-ms = <50>;
> > > +             #reset-cells = <0>;
> > > +     };
> > > +
> > > +     tpm_reset: tpm-reset {
> > > +             compatible = "gpio-reset";
> > > +             reset-gpios = <&gpio3 2 GPIO_ACTIVE_LOW>;
> > > +             reset-delay-us = <2>;
> > > +             reset-post-delay-ms = <60>;
> > > +             #reset-cells = <0>;
> > > +     };
> > > +
> > > +     pcie0_refclk: pcie0-refclk {
> >
> > Generic node names (from the dt spec candidate is "clock").
> 
> Should I simply set the node name to pcie0-clock? And pcie1-clock for
> the next one?

I am fine with "pcie0-clock" or just "clock-0".

> 
> > > +             compatible = "fixed-clock";
> > > +             #clock-cells = <0>;
> > > +             clock-frequency = <100000000>;
> > > +     };
> > > +
> > > +     pcie1_refclk: pcie1-refclk {
> >
> > Same.
> >
> > > +             compatible = "fixed-clock";
> > > +             #clock-cells = <0>;
> > > +             clock-frequency = <100000000>;
> > > +     };
> > > +
> > > +     gpio-keys {
> > > +             compatible = "gpio-keys";
> > > +             pinctrl-names = "default";
> > > +             pinctrl-0 = <&pinctrl_gpio_keys>;
> > > +
> > > +             pciewake {
> > > +                     label = "PCIE_Wake";
> > > +                     gpios = <&gpio1 8 GPIO_ACTIVE_LOW>;
> > > +                     linux,input-type = <4>; /* EV_MSC */
> > > +                     linux,code = <3>; /* MSC_RAW */
> > > +                     gpio-key,wakeup;
> > > +             };
> > > +     };
> > > +};
> > > +
> > > +&ecspi2 {
> > > +     #address-cells = <1>;
> > > +     #size-cells = <0>;
> > > +     pinctrl-names = "default";
> > > +     pinctrl-0 = <&pinctrl_ecspi2 &pinctrl_ecspi2_cs>;
> > > +     cs-gpios = <&gpio5 13 GPIO_ACTIVE_LOW>;
> > > +     status = "okay";
> > > +
> > > +     slb9670@0 {
> >
> > This needs a generic node name.
> 
> I will change to tpm@0.

Thanks.

> 
> >
> > > +             compatible = "infineon,slb9670";
> > > +             reg = <0>;
> > > +             resets = <&tpm_reset>;
> > > +             spi-max-frequency = <43000000>;
> > > +     };
> > > +};
> > > +
> > > +&fec1 {
> > > +     pinctrl-names = "default";
> > > +     pinctrl-0 = <&pinctrl_fec1>;
> > > +     phy-mode = "rgmii-id";
> > > +     phy-handle = <&ethphy0>;
> > > +     phy-reset-gpios = <&gpio1 11 GPIO_ACTIVE_LOW>;
> > > +     fsl,magic-packet;
> > > +     status = "okay";
> > > +
> > > +     mdio {
> > > +             #address-cells = <1>;
> > > +             #size-cells = <0>;
> > > +
> > > +             ethphy0: ethernet-phy@0 {
> > > +                     compatible = "ethernet-phy-ieee802.3-c22";
> > > +                     reg = <0>;
> > > +                     ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_25_NS>;
> > > +                     ti,tx-internal-delay = <DP83867_RGMIIDCTL_2_75_NS>;
> > > +                     ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
> > > +             };
> > > +     };
> > > +};
> > > +
> > > +&i2c1 {
> > > +     clock-frequency = <400000>;
> > > +     pinctrl-names = "default";
> > > +     pinctrl-0 = <&pinctrl_i2c1>;
> > > +     status = "okay";
> > > +
> > > +     pmic@8 {
> > > +             compatible = "fsl,pfuze100";
> > > +             fsl,pfuze-support-disable-sw;
> > > +             reg = <0x8>;
> > > +
> > > +             regulators {
> > > +                     sw1a_reg: sw1ab {
> > > +                             regulator-name = "V_0V9_GPU";
> > > +                             regulator-min-microvolt = <825000>;
> > > +                             regulator-max-microvolt = <1100000>;
> > > +                     };
> > > +
> > > +                     sw1c_reg: sw1c {
> > > +                             regulator-name = "V_0V9_VPU";
> > > +                             regulator-min-microvolt = <825000>;
> > > +                             regulator-max-microvolt = <1100000>;
> > > +                     };
> > > +
> > > +                     sw2_reg: sw2 {
> > > +                             regulator-name = "V_1V1_NVCC_DRAM";
> > > +                             regulator-min-microvolt = <1100000>;
> > > +                             regulator-max-microvolt = <1100000>;
> > > +                             regulator-always-on;
> > > +                     };
> > > +
> > > +                     sw3a_reg: sw3ab {
> > > +                             regulator-name = "V_1V0_DRAM";
> > > +                             regulator-min-microvolt = <825000>;
> > > +                             regulator-max-microvolt = <1100000>;
> > > +                             regulator-always-on;
> > > +                     };
> > > +
> > > +                     sw4_reg: sw4 {
> > > +                             regulator-name = "V_1V8_S0";
> > > +                             regulator-min-microvolt = <1800000>;
> > > +                             regulator-max-microvolt = <1800000>;
> > > +                             regulator-always-on;
> > > +                     };
> > > +
> > > +                     swbst_reg: swbst {
> > > +                             regulator-min-microvolt = <5000000>;
> > > +                             regulator-max-microvolt = <5150000>;
> > > +                     };
> > > +
> > > +                     snvs_reg: vsnvs {
> > > +                             regulator-name = "V_0V9_SNVS";
> > > +                             regulator-min-microvolt = <1000000>;
> > > +                             regulator-max-microvolt = <3000000>;
> > > +                             regulator-always-on;
> > > +                     };
> > > +
> > > +                     vref_reg: vrefddr {
> > > +                             regulator-name = "V_0V55_VREF_DDR";
> > > +                             regulator-always-on;
> > > +                     };
> > > +
> > > +                     vgen1_reg: vgen1 {
> > > +                             regulator-name = "V_1V5_CSI";
> > > +                             regulator-min-microvolt = <800000>;
> > > +                             regulator-max-microvolt = <1550000>;
> > > +                     };
> > > +
> > > +                     vgen2_reg: vgen2 {
> > > +                             regulator-name = "V_0V9_PHY";
> > > +                             regulator-min-microvolt = <850000>;
> > > +                             regulator-max-microvolt = <975000>;
> > > +                             regulator-always-on;
> > > +                     };
> > > +
> > > +                     vgen3_reg: vgen3 {
> > > +                             regulator-name = "V_1V8_PHY";
> > > +                             regulator-min-microvolt = <1675000>;
> > > +                             regulator-max-microvolt = <1975000>;
> > > +                             regulator-always-on;
> > > +                     };
> > > +
> > > +                     vgen4_reg: vgen4 {
> > > +                             regulator-name = "V_1V8_VDDA";
> > > +                             regulator-min-microvolt = <1625000>;
> > > +                             regulator-max-microvolt = <1875000>;
> > > +                             regulator-always-on;
> > > +                     };
> > > +
> > > +                     vgen5_reg: vgen5 {
> > > +                             regulator-name = "V_3V3_PHY";
> > > +                             regulator-min-microvolt = <3075000>;
> > > +                             regulator-max-microvolt = <3625000>;
> > > +                             regulator-always-on;
> > > +                     };
> > > +
> > > +                     vgen6_reg: vgen6 {
> > > +                             regulator-name = "V_2V8_CAM";
> > > +                             regulator-min-microvolt = <1800000>;
> > > +                             regulator-max-microvolt = <3300000>;
> > > +                             regulator-always-on;
> > > +                     };
> > > +             };
> > > +     };
> > > +
> > > +     max6650@1b {
> >
> > Generic node name.
> 
> I could not find a matching name like "fan" in the devicetree
> specification. What about using "fan-ctrl"?

So maybe "fan-controller"?

> 
> >
> > > +             compatible = "maxim,max6650";
> > > +             reg = <0x1b>;
> > > +             maxim,fan-microvolt = <5000000>;
> > > +     };
> > > +
> > > +     rtc@32 {
> > > +             compatible = "microcrystal,rv8803";
> > > +             reg = <0x32>;
> > > +     };
> > > +
> > > +     lm75@4b {
> >
> > Node name: sensor.
> 
> Ok
> 
> >
> > > +             compatible = "national,lm75b";
> > > +             reg = <0x4b>;
> > > +     };
> > > +
> > > +     eeprom@51 {
> > > +             compatible = "atmel,24c32";
> > > +             reg = <0x51>;
> > > +             pagesize = <32>;
> > > +     };
> > > +};
> > > +
> > > +&i2c2 {
> > > +     clock-frequency = <100000>;
> > > +     pinctrl-names = "default";
> > > +     pinctrl-0 = <&pinctrl_i2c2>;
> > > +     status = "okay";
> > > +};
> > > +
> > > +&i2c3 {
> > > +     clock-frequency = <100000>;
> > > +     pinctrl-names = "default";
> > > +     pinctrl-0 = <&pinctrl_i2c3>;
> > > +     status = "okay";
> > > +
> > > +     wm8904: audio-codec@1a {
> > > +             compatible = "wlf,wm8904";
> > > +             reg = <0x1a>;
> > > +             clocks = <&clk IMX8MQ_CLK_SAI2_ROOT>;
> > > +             clock-names = "mclk";
> > > +             clock-frequency = <24000000>;
> > > +     };
> > > +};
> > > +
> > > +/* M.2 B-key slot */
> > > +&pcie0 {
> > > +     pinctrl-names = "default";
> > > +     pinctrl-0 = <&pinctrl_pcie0>;
> > > +     disable-gpio = <&gpio5 29 GPIO_ACTIVE_LOW>;
> > > +     reset-gpio = <&gpio1 9 GPIO_ACTIVE_LOW>;
> > > +     clocks = <&clk IMX8MQ_CLK_PCIE1_ROOT>,
> > > +              <&clk IMX8MQ_CLK_PCIE1_AUX>,
> > > +              <&clk IMX8MQ_CLK_PCIE1_PHY>,
> > > +              <&pcie0_refclk>;
> > > +     clock-names = "pcie", "pcie_aux", "pcie_phy", "pcie_bus";
> > > +     ext_osc = <1>;
> > > +     status = "okay";
> > > +};
> > > +
> > > +/* Intel Ethernet Controller I210/I211 */
> > > +&pcie1 {
> > > +     clocks = <&clk IMX8MQ_CLK_PCIE2_ROOT>,
> > > +              <&clk IMX8MQ_CLK_PCIE2_AUX>,
> > > +              <&clk IMX8MQ_CLK_PCIE2_PHY>,
> > > +              <&pcie1_refclk>;
> > > +     clock-names = "pcie", "pcie_aux", "pcie_phy", "pcie_bus";
> > > +     ext_osc = <1>;
> > > +     fsl,max-link-speed = <1>;
> > > +     status = "okay";
> > > +};
> > > +
> > > +&pgc_gpu {
> > > +     power-supply = <&sw1a_reg>;
> > > +};
> > > +
> > > +&pgc_vpu {
> > > +     power-supply = <&sw1c_reg>;
> > > +};
> > > +
> > > +&qspi0 {
> > > +     pinctrl-names = "default";
> > > +     pinctrl-0 = <&pinctrl_qspi>;
> > > +     status = "okay";
> > > +
> > > +     flash@0 {
> > > +             compatible = "jedec,spi-nor";
> > > +             #address-cells = <1>;
> > > +             #size-cells = <1>;
> > > +             reg = <0>;
> > > +             spi-tx-bus-width = <4>;
> > > +             spi-rx-bus-width = <4>;
> > > +             m25p,fast-read;
> > > +             spi-max-frequency = <50000000>;
> > > +     };
> > > +};
> > > +
> > > +&snvs_pwrkey {
> > > +     status = "okay";
> > > +};
> > > +
> > > +&uart1 {
> > > +     pinctrl-names = "default";
> > > +     pinctrl-0 = <&pinctrl_uart1>;
> > > +     assigned-clocks = <&clk IMX8MQ_CLK_UART1>;
> > > +     assigned-clock-parents = <&clk IMX8MQ_SYS1_PLL_80M>;
> > > +     status = "okay";
> > > +};
> > > +
> > > +&uart2 {
> > > +     pinctrl-names = "default";
> > > +     pinctrl-0 = <&pinctrl_uart2>;
> > > +     assigned-clocks = <&clk IMX8MQ_CLK_UART2>;
> > > +     assigned-clock-parents = <&clk IMX8MQ_SYS1_PLL_80M>;
> > > +     status = "okay";
> > > +};
> > > +
> > > +&uart3 {
> > > +     pinctrl-names = "default";
> > > +     pinctrl-0 = <&pinctrl_uart3>;
> > > +     fsl,uart-has-rtscts;
> > > +     assigned-clocks = <&clk IMX8MQ_CLK_UART3>;
> > > +     assigned-clock-parents = <&clk IMX8MQ_SYS1_PLL_80M>;
> > > +     status = "okay";
> > > +};
> > > +
> > > +&usb_dwc3_0 {
> > > +     pinctrl-names = "default";
> > > +     pinctrl-0 = <&pinctrl_usb0>;
> > > +     dr_mode = "otg";
> > > +     hnp-disable;
> > > +     srp-disable;
> > > +     adp-disable;
> > > +     maximum-speed = "high-speed";
> > > +     status = "okay";
> > > +};
> > > +
> > > +&usb3_phy0 {
> > > +     status = "okay";
> > > +};
> > > +
> > > +&usb_dwc3_1 {
> > > +     resets = <&usb_hub_reset>;
> > > +     dr_mode = "host";
> > > +     status = "okay";
> > > +};
> > > +
> > > +&usb3_phy1 {
> > > +     status = "okay";
> > > +};
> > > +
> > > +&usdhc1 {
> > > +     assigned-clocks = <&clk IMX8MQ_CLK_USDHC1>;
> > > +     assigned-clock-rates = <400000000>;
> > > +     pinctrl-names = "default", "state_100mhz", "state_200mhz";
> > > +     pinctrl-0 = <&pinctrl_usdhc1>;
> > > +     pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
> > > +     pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
> > > +     vqmmc-supply = <&sw4_reg>;
> > > +     bus-width = <8>;
> > > +     non-removable;
> > > +     no-sd;
> > > +     no-sdio;
> > > +     status = "okay";
> > > +};
> > > +
> > > +&usdhc2 {
> > > +     assigned-clocks = <&clk IMX8MQ_CLK_USDHC2>;
> > > +     assigned-clock-rates = <200000000>;
> > > +     pinctrl-names = "default", "state_100mhz", "state_200mhz";
> > > +     pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
> > > +     pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
> > > +     pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
> > > +     bus-width = <4>;
> > > +     cd-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
> > > +     wp-gpios = <&gpio2 20 GPIO_ACTIVE_HIGH>;
> > > +     vmmc-supply = <&reg_usdhc2_vmmc>;
> > > +     status = "okay";
> > > +};
> > > +
> > > +&wdog1 {
> > > +     pinctrl-names = "default";
> > > +     pinctrl-0 = <&pinctrl_wdog>;
> > > +     fsl,ext-reset-output;
> > > +     status = "okay";
> > > +};
> > > +
> > > +&iomuxc {
> > > +     pinctrl-names = "default";
> > > +     pinctrl-0 = <&pinctrl_hog>;
> > > +
> > > +     pinctrl_hog: hoggrp {
> > > +             fsl,pins = <
> > > +                     MX8MQ_IOMUXC_NAND_CE1_B_GPIO3_IO2               0x19 /* TPM Reset */
> > > +                     MX8MQ_IOMUXC_NAND_CE3_B_GPIO3_IO4               0x19 /* USB2 Hub Reset */
> > > +             >;
> > > +     };
> > > +
> > > +     pinctrl_gpio: gpiogrp {
> > > +             fsl,pins = <
> > > +                     MX8MQ_IOMUXC_NAND_CLE_GPIO3_IO5                 0x19 /* GPIO0 */
> > > +                     MX8MQ_IOMUXC_NAND_RE_B_GPIO3_IO15               0x19 /* GPIO1 */
> > > +                     MX8MQ_IOMUXC_NAND_WE_B_GPIO3_IO17               0x19 /* GPIO2 */
> > > +                     MX8MQ_IOMUXC_NAND_WP_B_GPIO3_IO18               0x19 /* GPIO3 */
> > > +                     MX8MQ_IOMUXC_NAND_READY_B_GPIO3_IO16            0x19 /* GPIO4 */
> > > +                     MX8MQ_IOMUXC_NAND_DATA04_GPIO3_IO10             0x19 /* GPIO5 */
> > > +                     MX8MQ_IOMUXC_NAND_DATA05_GPIO3_IO11             0x19 /* GPIO6 */
> > > +                     MX8MQ_IOMUXC_NAND_DATA06_GPIO3_IO12             0x19 /* GPIO7 */
> > > +             >;
> > > +     };
> > > +
> > > +     pinctrl_pcie0: pcie0grp {
> > > +             fsl,pins = <
> > > +                     MX8MQ_IOMUXC_GPIO1_IO09_GPIO1_IO9               0x16 /* PCIE_PERST */
> > > +                     MX8MQ_IOMUXC_UART4_TXD_GPIO5_IO29               0x16 /* W_DISABLE */
> > > +             >;
> > > +     };
> > > +
> > > +     pinctrl_gpio_keys: gpio-keysgrp {
> > > +             fsl,pins = <
> > > +                     MX8MQ_IOMUXC_GPIO1_IO08_GPIO1_IO8               0x16 /* PCIE_WAKE */
> > > +             >;
> > > +     };
> > > +
> > > +     pinctrl_fec1: fec1grp {
> > > +             fsl,pins = <
> > > +                     MX8MQ_IOMUXC_ENET_MDC_ENET1_MDC                 0x3
> > > +                     MX8MQ_IOMUXC_ENET_MDIO_ENET1_MDIO               0x23
> > > +                     MX8MQ_IOMUXC_ENET_TD3_ENET1_RGMII_TD3           0x1f
> > > +                     MX8MQ_IOMUXC_ENET_TD2_ENET1_RGMII_TD2           0x1f
> > > +                     MX8MQ_IOMUXC_ENET_TD1_ENET1_RGMII_TD1           0x1f
> > > +                     MX8MQ_IOMUXC_ENET_TD0_ENET1_RGMII_TD0           0x1f
> > > +                     MX8MQ_IOMUXC_ENET_RD3_ENET1_RGMII_RD3           0x91
> > > +                     MX8MQ_IOMUXC_ENET_RD2_ENET1_RGMII_RD2           0x91
> > > +                     MX8MQ_IOMUXC_ENET_RD1_ENET1_RGMII_RD1           0x91
> > > +                     MX8MQ_IOMUXC_ENET_RD0_ENET1_RGMII_RD0           0x91
> > > +                     MX8MQ_IOMUXC_ENET_TXC_ENET1_RGMII_TXC           0x1f
> > > +                     MX8MQ_IOMUXC_ENET_RXC_ENET1_RGMII_RXC           0x91
> > > +                     MX8MQ_IOMUXC_ENET_RX_CTL_ENET1_RGMII_RX_CTL     0x91
> > > +                     MX8MQ_IOMUXC_ENET_TX_CTL_ENET1_RGMII_TX_CTL     0x1f
> > > +                     MX8MQ_IOMUXC_GPIO1_IO11_GPIO1_IO11              0x16
> > > +                     MX8MQ_IOMUXC_GPIO1_IO15_GPIO1_IO15              0x16
> > > +             >;
> > > +     };
> > > +
> > > +     pinctrl_i2c1: i2c1grp {
> > > +             fsl,pins = <
> > > +                     MX8MQ_IOMUXC_I2C1_SCL_I2C1_SCL                  0x4000007f
> > > +                     MX8MQ_IOMUXC_I2C1_SDA_I2C1_SDA                  0x4000007f
> > > +             >;
> > > +     };
> > > +
> > > +     pinctrl_i2c2: i2c2grp {
> > > +             fsl,pins = <
> > > +                     MX8MQ_IOMUXC_I2C2_SCL_I2C2_SCL                  0x4000007f
> > > +                     MX8MQ_IOMUXC_I2C2_SDA_I2C2_SDA                  0x4000007f
> > > +             >;
> > > +     };
> > > +
> > > +     pinctrl_i2c3: i2c3grp {
> > > +             fsl,pins = <
> > > +                     MX8MQ_IOMUXC_I2C3_SCL_I2C3_SCL                  0x4000007f
> > > +                     MX8MQ_IOMUXC_I2C3_SDA_I2C3_SDA                  0x4000007f
> > > +             >;
> > > +     };
> > > +
> > > +     pinctrl_qspi: qspigrp {
> > > +             fsl,pins = <
> > > +                     MX8MQ_IOMUXC_NAND_ALE_QSPI_A_SCLK               0x82
> > > +                     MX8MQ_IOMUXC_NAND_CE0_B_QSPI_A_SS0_B            0x82
> > > +                     MX8MQ_IOMUXC_NAND_DATA00_QSPI_A_DATA0           0x82
> > > +                     MX8MQ_IOMUXC_NAND_DATA01_QSPI_A_DATA1           0x82
> > > +                     MX8MQ_IOMUXC_NAND_DATA02_QSPI_A_DATA2           0x82
> > > +                     MX8MQ_IOMUXC_NAND_DATA03_QSPI_A_DATA3           0x82
> > > +
> >
> > No need for empty line.
> 
> Ok
> 
> >
> > > +             >;
> > > +     };
> > > +
> > > +     pinctrl_ecspi2: ecspi2grp {
> > > +             fsl,pins = <
> > > +                     MX8MQ_IOMUXC_ECSPI2_MOSI_ECSPI2_MOSI            0x19
> > > +                     MX8MQ_IOMUXC_ECSPI2_MISO_ECSPI2_MISO            0x19
> > > +                     MX8MQ_IOMUXC_ECSPI2_SCLK_ECSPI2_SCLK            0x19
> > > +             >;
> > > +     };
> > > +
> > > +     pinctrl_ecspi2_cs: ecspi2cs {
> >
> > ecspi2csgrp to match schema
> 
> Ok
> 
> >
> > Please run dtbs_check on your DTS.
> 
> When I run "make dtbs_check" it runs quite a long time and stops with
> an error. But as far as I can say there is an error coming from the
> included "imx8mq.dtsi".
> 
> You can see the output here: https://pastebin.com/raw/iU2geBDh

Looks fine (except the error tool :) ).

Best regards,
Krzysztof

