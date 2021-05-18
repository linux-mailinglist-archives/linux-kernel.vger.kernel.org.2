Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D36B538735E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 09:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344498AbhERHiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 03:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241604AbhERHiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 03:38:01 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461B8C061573;
        Tue, 18 May 2021 00:36:44 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id n32-20020a9d1ea30000b02902a53d6ad4bdso7874702otn.3;
        Tue, 18 May 2021 00:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OfZw/lq96na/xYrsyQ/RzuMTe0KIHr9IHhu6MjDs8dY=;
        b=MZ5ad5a1F62G1/eaQvUU1uNST4PmYQVtHm2Fw2/5ijStlzGJ3nEGWzE5ia+L8kehBc
         JeL0rIfBg4bqswzB47HZLvoGVM4GiIG9RBw2p5OtUlRm/UYfzcRABMzLq410stjARu7Q
         H3bdYQD4JzxG1FOhMuCT1v2vLju8GcUSnCzNZgbAaUTpFvaSHVc0CLivv417RLvJnDX7
         3iuywc6eUwji3hRI+//qhwl7Il1HmeLqexgU4GCZqRfYZgDlzjdQmwwjyUR/SBttNRYS
         wyA22/1HyJwJwkpopBzs+JPtg2t9kKZn0P3Pm8Z7wlbMlV+3MXxPBQ9LtQOPqA/TslcO
         VssQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OfZw/lq96na/xYrsyQ/RzuMTe0KIHr9IHhu6MjDs8dY=;
        b=DoIwCRkUpskLKIpJm58DXuurvVZ2wgkDrlf/9nk39IJNHItpUodl1YI12DlH5zdhqI
         D1UokS3fQCNNPgbnQ/fwC0SNRHafgv1WLvh0CMdNqR32yiWIohkaKbNVFYo/dSZs3rQW
         M7NFdRSf9BAxWRKOFS3Ofasn9Fr9wpJmNIEJVthNwpwT+OohW0YBNgAu974Js4sdPREb
         OvPcy1GXiYwwebHFncvLVY2xN0w7i4DqxuZkCS+Qy5vy+jeS0YAJEofggi/VhRCCO6eW
         QPkNgOJK+Wo8h5m5tusrY11liULW6DtAYweSlWzb35vTiBiJVaKiiRc5ir0MI2GeteIv
         bUFg==
X-Gm-Message-State: AOAM530VQpaRZbDqFATKr/RuaKYwdrEJcQOwzNqVMuNpYOlg02/5yTwD
        Yw1RK848xqKVVnHgJm8Kz7BTxpHlB5M4stPT89Q=
X-Google-Smtp-Source: ABdhPJw9KNOLSKD3vL3BqDv5yh3j2k21VdDNIWK56864n4TsT9TicwwTfHH7/tnVZQHhR7jS0ama6vCoYu9G+lMK6Gg=
X-Received: by 2002:a9d:6c81:: with SMTP id c1mr3162971otr.248.1621323403707;
 Tue, 18 May 2021 00:36:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210517171205.1581938-1-abelvesa@kernel.org> <20210517171205.1581938-2-abelvesa@kernel.org>
In-Reply-To: <20210517171205.1581938-2-abelvesa@kernel.org>
From:   Dong Aisheng <dongas86@gmail.com>
Date:   Tue, 18 May 2021 15:35:41 +0800
Message-ID: <CAA+hA=SVGCeroox_Ld7Etr20j8fRLwYGpc8Ee2reY6Koy3bX6g@mail.gmail.com>
Subject: Re: [PATCH 1/7] arm64: dts: freescale: Add the top level dtsi support
 for imx8dxl
To:     Abel Vesa <abelvesa@kernel.org>
Cc:     Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Abel Vesa <abel.vesa@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 1:14 AM <abelvesa@kernel.org> wrote:
>
> From: Jacky Bai <ping.bai@nxp.com>
>
> The i.MX8DXL is a device targeting the automotive and industrial
> market segments. The flexibility of the architecture allows for
> use in a wide variety of general embedded applications. The chip
> is designed to achieve both high performance and low power consumption.
> The chip relies on the power efficient dual (2x) Cortex-A35 cluster.
>
> Add the reserved memory node property for dsp reserved memory,
> the wakeup-irq property for SCU node, the imx ion, the rpmsg and the
> cm4 rproc support.
>
> Signed-off-by: Jacky Bai <ping.bai@nxp.com>
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>

FIrst of all, did you run make dt_binding_check?
I wonder there're dt binding missing for a few nodes

> ---
>  arch/arm64/boot/dts/freescale/imx8dxl.dtsi | 286 +++++++++++++++++++++
>  1 file changed, 286 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8dxl.dtsi
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8dxl.dtsi b/arch/arm64/boot/dts/freescale/imx8dxl.dtsi
> new file mode 100644
> index 000000000000..43e0bcdc2469
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8dxl.dtsi
> @@ -0,0 +1,286 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2019-2021 NXP
> + */
> +
> +#include <dt-bindings/clock/imx8-clock.h>
> +#include <dt-bindings/firmware/imx/rsrc.h>
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/pinctrl/pads-imx8dxl.h>

this depends on pinctrl driver. Is that upstreamed already?

> +#include <dt-bindings/thermal/thermal.h>
> +
> +/ {
> +       interrupt-parent = <&gic>;
> +       #address-cells = <2>;
> +       #size-cells = <2>;
> +
> +       aliases {
> +               ethernet0 = &fec1;
> +               ethernet1 = &eqos;
> +               gpio0 = &lsio_gpio0;
> +               gpio1 = &lsio_gpio1;
> +               gpio2 = &lsio_gpio2;
> +               gpio3 = &lsio_gpio3;
> +               gpio4 = &lsio_gpio4;
> +               gpio5 = &lsio_gpio5;
> +               gpio6 = &lsio_gpio6;
> +               gpio7 = &lsio_gpio7;
> +               i2c2 = &i2c2;
> +               i2c3 = &i2c3;
> +               mmc0 = &usdhc1;
> +               mmc1 = &usdhc2;
> +               mu1 = &lsio_mu1;
> +               serial0 = &lpuart0;
> +               serial1 = &lpuart1;
> +               serial2 = &lpuart2;
> +               serial3 = &lpuart3;
> +       };
> +
> +       cpus: cpus {
> +               #address-cells = <2>;
> +               #size-cells = <0>;
> +
> +               /* We have 1 clusters with 2 Cortex-A35 cores */
> +               A35_0: cpu@0 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a35";
> +                       reg = <0x0 0x0>;
> +                       enable-method = "psci";
> +                       next-level-cache = <&A35_L2>;
> +                       clocks = <&clk IMX_SC_R_A35 IMX_SC_PM_CLK_CPU>;
> +                       #cooling-cells = <2>;
> +                       operating-points-v2 = <&a35_opp_table>;
> +               };
> +
> +               A35_1: cpu@1 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a35";
> +                       reg = <0x0 0x1>;
> +                       enable-method = "psci";
> +                       next-level-cache = <&A35_L2>;
> +                       clocks = <&clk IMX_SC_R_A35 IMX_SC_PM_CLK_CPU>;
> +                       #cooling-cells = <2>;
> +                       operating-points-v2 = <&a35_opp_table>;
> +               };
> +
> +               A35_L2: l2-cache0 {
> +                       compatible = "cache";
> +               };
> +       };
> +
> +       a35_opp_table: opp-table {
> +               compatible = "operating-points-v2";
> +               opp-shared;
> +
> +               opp-900000000 {
> +                       opp-hz = /bits/ 64 <900000000>;
> +                       opp-microvolt = <1000000>;
> +                       clock-latency-ns = <150000>;
> +               };
> +
> +               opp-1200000000 {
> +                       opp-hz = /bits/ 64 <1200000000>;
> +                       opp-microvolt = <1100000>;
> +                       clock-latency-ns = <150000>;
> +                       opp-suspend;
> +               };
> +       };
> +
> +       reserved-memory {
> +               #address-cells = <2>;
> +               #size-cells = <2>;
> +               ranges;
> +
> +               dsp_reserved: dsp@92400000 {
> +                       reg = <0 0x92400000 0 0x2000000>;
> +                       no-map;
> +               };
> +       };

this could be added when enabling DSP in case any changes required in upstream

> +
> +       rpmsg: rpmsg{
> +               compatible = "fsl,imx8qxp-rpmsg";

I belive this is still not supported in upstream
so drop it first

> +               /* up to now, the following channels are used in imx rpmsg
> +                * - tx1/rx1: messages channel.
> +                * - general interrupt1: remote proc finish re-init rpmsg stack
> +                *   when A core is partition reset.
> +                */
> +               mbox-names = "tx", "rx", "rxdb";
> +               mboxes = <&lsio_mu5 0 1
> +                         &lsio_mu5 1 1
> +                         &lsio_mu5 3 1>;
> +               mub-partition = <3>;
> +               status = "disabled";
> +       };
> +
> +       imx8dxl_cm4: imx8dxl_cm4@0 {
> +               compatible = "fsl,imx8qxp-cm4";

i'd suggest drop it first and add in separate patch
as it's still not supported

> +               rsc-da = <0x90000000>;
> +               mbox-names = "tx", "rx", "rxdb";
> +               mboxes = <&lsio_mu5 0 1
> +                         &lsio_mu5 1 1
> +                         &lsio_mu5 3 1>;
> +               mub-partition = <3>;
> +               core-index = <0>;
> +               core-id = <IMX_SC_R_M4_0_PID0>;
> +               status = "disabled";
> +               power-domains = <&pd IMX_SC_R_M4_0_PID0>,
> +                               <&pd IMX_SC_R_M4_0_MU_1A>;
> +       };
> +
> +       gic: interrupt-controller@51a00000 {
> +               compatible = "arm,gic-v3";
> +               reg = <0x0 0x51a00000 0 0x10000>, /* GIC Dist */
> +                     <0x0 0x51b00000 0 0xc0000>; /* GICR (RD_base + SGI_base) */
> +               #interrupt-cells = <3>;
> +               interrupt-controller;
> +               interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +       };
> +
> +       pmu {
> +               compatible = "arm,armv8-pmuv3";
> +               interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
> +       };
> +
> +       psci {
> +               compatible = "arm,psci-1.0";
> +               method = "smc";
> +       };
> +
> +       scu {
> +               compatible = "fsl,imx-scu";
> +               mbox-names = "tx0",
> +                            "rx0",
> +                            "gip3";
> +               mboxes = <&lsio_mu1 0 0
> +                         &lsio_mu1 1 0
> +                         &lsio_mu1 3 3>;
> +
> +               pd: imx8dxl-pd {
> +                       compatible = "fsl,imx8dxl-scu-pd", "fsl,scu-pd";
> +                       #power-domain-cells = <1>;
> +                       wakeup-irq = <160 163 235 236 237 228 229 230 231 238
> +                                    239 240 166 169>;

drop this property first which is still not supported

> +               };
> +
> +               clk: clock-controller {
> +                       compatible = "fsl,imx8dxl-clk", "fsl,scu-clk";
> +                       #clock-cells = <2>;
> +                       clocks = <&xtal32k &xtal24m>;
> +                       clock-names = "xtal_32KHz", "xtal_24Mhz";
> +               };
> +
> +               iomuxc: pinctrl {
> +                       compatible = "fsl,imx8dxl-iomuxc";

make sure pinctrl upstreamed

> +               };
> +
> +               ocotp: imx8qx-ocotp {
> +                       compatible = "fsl,imx8dxl-scu-ocotp", "fsl,imx8qxp-scu-ocotp";

need update binding doc as well

> +                       #address-cells = <1>;
> +                       #size-cells = <1>;
> +
> +                       fec_mac0: mac@2c4 {
> +                               reg = <0x2c4 6>;
> +                       };
> +
> +                       fec_mac1: mac@2c6 {
> +                               reg = <0x2c6 6>;
> +                       };
> +               };
> +
> +               rtc: rtc {
> +                       compatible = "fsl,imx8dxl-sc-rtc", "fsl,imx8qxp-sc-rtc";

pls update dt binding as well

> +               };
> +
> +               watchdog {
> +                       compatible = "fsl,imx-sc-wdt";
> +                       timeout-sec = <60>;
> +               };
> +
> +               tsens: thermal-sensor {
> +                       compatible = "fsl,imx-sc-thermal";
> +                       #thermal-sensor-cells = <1>;
> +               };
> +       };
> +
> +       timer {
> +               compatible = "arm,armv8-timer";
> +               interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>, /* Physical Secure */
> +                            <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>, /* Physical Non-Secure */
> +                            <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>, /* Virtual */
> +                            <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>; /* Hypervisor */
> +       };
> +
> +       thermal_zones: thermal-zones {
> +               cpu-thermal0 {
> +                       polling-delay-passive = <250>;
> +                       polling-delay = <2000>;
> +                       thermal-sensors = <&tsens IMX_SC_R_SYSTEM>;
> +
> +                       trips {
> +                               cpu_alert0: trip0 {
> +                                       temperature = <107000>;
> +                                       hysteresis = <2000>;
> +                                       type = "passive";
> +                               };
> +                               cpu_crit0: trip1 {
> +                                       temperature = <127000>;
> +                                       hysteresis = <2000>;
> +                                       type = "critical";
> +                               };
> +                       };
> +                       cooling-maps {
> +                               map0 {
> +                                       trip = <&cpu_alert0>;
> +                                       cooling-device =
> +                                       <&A35_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                       <&A35_1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +                               };
> +                       };
> +               };
> +       };
> +
> +       clk_dummy: clock-dummy {
> +               compatible = "fixed-clock";
> +               #clock-cells = <0>;
> +               clock-frequency = <0>;
> +               clock-output-names = "clk_dummy";
> +       };
> +
> +       xtal32k: clock-xtal32k {
> +               compatible = "fixed-clock";
> +               #clock-cells = <0>;
> +               clock-frequency = <32768>;
> +               clock-output-names = "xtal_32KHz";
> +       };
> +
> +       xtal24m: clock-xtal24m {
> +               compatible = "fixed-clock";
> +               #clock-cells = <0>;
> +               clock-frequency = <24000000>;
> +               clock-output-names = "xtal_24MHz";
> +       };
> +
> +       imx_ion {
> +               compatible = "fsl,mxc-ion";

drop this unsupported node

Regards
Aisheng

> +               fsl,heap-id = <0>;
> +       };
> +
> +       sc_pwrkey: sc-powerkey {
> +               compatible = "fsl,imx8-pwrkey";
> +               linux,keycode = <KEY_POWER>;
> +               wakeup-source;
> +       };
> +
> +       /* sorted in register address */
> +       #include "imx8-ss-adma.dtsi"
> +       #include "imx8-ss-conn.dtsi"
> +       #include "imx8-ss-ddr.dtsi"
> +       #include "imx8-ss-lsio.dtsi"
> +};
> +
> +#include "imx8dxl-ss-adma.dtsi"
> +#include "imx8dxl-ss-conn.dtsi"
> +#include "imx8dxl-ss-lsio.dtsi"
> +#include "imx8dxl-ss-ddr.dtsi"
> --
> 2.31.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
