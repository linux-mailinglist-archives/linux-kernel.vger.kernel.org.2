Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 264C73873B1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 09:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347396AbhERIAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 04:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347386AbhERIAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 04:00:13 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21EA3C06138B;
        Tue, 18 May 2021 00:58:49 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id u144so8969377oie.6;
        Tue, 18 May 2021 00:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cGceJw9ynrLb6PqaT2J4KLrD/fkfgdf+8+XJ9KkzUVM=;
        b=MGUr/DEJvrLOCKknISeWvchUBplHACUyFCCsCfn/jaEgK82Um36oyyFNU2idUgoqXo
         5+MpSHc88cfNZ6s3ecCYoFf3FMmi1I+NFm5iBbwkvjh+RWFUwhWCsvYXlslMB1gLpLZ1
         xuGT8vMJFXfj8ybQeFQXgViw/sUmZDN3mB9sVwB9bOBnRR3XnQJQsZyuXRQwfHxsBrjM
         xBaoZufGprFNJCNkZJSbDmbgwMkZSBP0a5rHbFYLvPHMXfDVn+68fUfOzRlwYKpOhdZW
         MQXShJg2xz5R/vrT86iXcBHBT+1VQ3t69rof23GD9mNVHs4GF/9shST63XflT7EL5PaP
         O7/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cGceJw9ynrLb6PqaT2J4KLrD/fkfgdf+8+XJ9KkzUVM=;
        b=AA5VQVpHu8Whac1s2dEC6/nIH8LI52BxdH2+RE6XrNbXesAE/AupASTgC+T0dpF/Cc
         i0hMhmhwoNeOqb0QlfnmnHwPj8gZjzk8iD9ui1VrAqUg61SnNAs0jRmDF9C0hBlzGFMV
         c0EyCpiFeSDaBAPUpxMabAGXaWP9tJqgyOZr0hKSgf6Vqph+hJcjHs9q4OE4rJ1T69ZX
         kTI3AdFyCUPBaKAUV6xcjuFbAjpZHiEVpf1BPTJ0ymJ3T6lxdobSwlb59l4K7OAUsloy
         crkUyQuPyJGCZCMwiXOyjBHI1aV2BVxBndFXbbEWIdnp+V7URZKurzWqgKX7PsVfYYfu
         +SbA==
X-Gm-Message-State: AOAM530twtiFEbAmJggVkj4a2nu6EHcngtor21I5FWE47lgwD8hGa6Ze
        r79Wy3OUUHnOKAUX8USB0Homg/0VWp/P5EAY1VAAwvZc
X-Google-Smtp-Source: ABdhPJyRHfy5b/oYi/cFX2KFqTdDCBOGJWuV4w8ZQgdQg2Kgt9h/qQESvrZvp/8MWPPUtKLdAf2uAC68R2MkQk7PZ0A=
X-Received: by 2002:a05:6808:1304:: with SMTP id y4mr2548940oiv.20.1621324728530;
 Tue, 18 May 2021 00:58:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210517171205.1581938-1-abelvesa@kernel.org> <20210517171205.1581938-8-abelvesa@kernel.org>
In-Reply-To: <20210517171205.1581938-8-abelvesa@kernel.org>
From:   Dong Aisheng <dongas86@gmail.com>
Date:   Tue, 18 May 2021 15:57:46 +0800
Message-ID: <CAA+hA=QYhkp60JBkv=9t1kJDJD-X+ZZGGBz=k6eXbFkWVwDDEw@mail.gmail.com>
Subject: Re: [PATCH 7/7] arm64: dts: imx8dxl: Add i.MX8DXL evk board support
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

On Tue, May 18, 2021 at 1:16 AM <abelvesa@kernel.org> wrote:
>
> From: Jacky Bai <ping.bai@nxp.com>
>
> Add i.MX8DXL EVK board support.
>
> Signed-off-by: Jacky Bai <ping.bai@nxp.com>
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/Makefile        |   1 +
>  arch/arm64/boot/dts/freescale/imx8dxl-evk.dts | 429 ++++++++++++++++++
>  2 files changed, 430 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
>
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index 44890d56c194..feaa7b4054ce 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -60,6 +60,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mq-pico-pi.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mq-thor96.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mq-zii-ultra-rmb3.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mq-zii-ultra-zest.dtb
> +dtb-$(CONFIG_ARCH_MXC) += imx8dxl-evk.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8qm-mek.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8qxp-ai_ml.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8qxp-colibri-eval-v3.dtb
> diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
> new file mode 100644
> index 000000000000..28ab4fd76aaa
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
> @@ -0,0 +1,429 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2019-2021 NXP
> + */
> +
> +/dts-v1/;
> +
> +#include "imx8dxl.dtsi"
> +
> +/ {
> +       model = "Freescale i.MX8DXL EVK";
> +       compatible = "fsl,imx8dxl-evk", "fsl,imx8dxl";
> +
> +       chosen {
> +               stdout-path = &lpuart0;
> +       };
> +
> +       memory@80000000 {
> +               device_type = "memory";
> +               reg = <0x00000000 0x80000000 0 0x40000000>;
> +       };
> +
> +       reserved-memory {
> +               #address-cells = <2>;
> +               #size-cells = <2>;
> +               ranges;
> +
> +               /*
> +                * 0x8800_0000 ~ 0x8FFF_FFFF is reserved for M4
> +                * Shouldn't be used at A core and Linux side.
> +                *
> +                */
> +               m4_reserved: m4@0x88000000 {
> +                       no-map;
> +                       reg = <0 0x88000000 0 0x8000000>;
> +               };
> +
> +               rpmsg_reserved: rpmsg@0x90200000 {
> +                       no-map;
> +                       reg = <0 0x90200000 0 0x200000>;
> +               };

suggest adding reserve memory along with function enablement

> +
> +               /* global autoconfigured region for contiguous allocations */
> +               linux,cma {
> +                       compatible = "shared-dma-pool";
> +                       reusable;
> +                       size = <0 0x14000000>;
> +                       alloc-ranges = <0 0x98000000 0 0x14000000>;
> +                       linux,cma-default;
> +               };
> +
> +               vdev0vring0: vdev0vring0@90000000 {
> +                       reg = <0 0x90000000 0 0x8000>;
> +                       no-map;
> +               };
> +
> +               vdev0vring1: vdev0vring1@90008000 {
> +                       reg = <0 0x90008000 0 0x8000>;
> +                       no-map;
> +               };
> +
> +               vdev1vring0: vdev1vring0@90010000 {
> +                       reg = <0 0x90010000 0 0x8000>;
> +                       no-map;
> +               };
> +
> +               vdev1vring1: vdev1vring1@90018000 {
> +                       reg = <0 0x90018000 0 0x8000>;
> +                       no-map;
> +               };
> +
> +               vdevbuffer: vdevbuffer {
> +                       compatible = "shared-dma-pool";
> +                       reg = <0 0x90400000 0 0x100000>;
> +                       no-map;
> +               };

ditto

> +       };
> +
> +       modem_reset: modem-reset {
> +               compatible = "gpio-reset";
> +               reset-gpios = <&pca6416_2 0 GPIO_ACTIVE_LOW>;
> +               reset-delay-us = <2000>;
> +               reset-post-delay-ms = <40>;
> +               #reset-cells = <0>;
> +       };
> +
> +       reg_usdhc2_vmmc: usdhc2-vmmc {
> +               compatible = "regulator-fixed";
> +               regulator-name = "SD1_SPWR";
> +               regulator-min-microvolt = <3000000>;
> +               regulator-max-microvolt = <3000000>;
> +               gpio = <&lsio_gpio4 30 GPIO_ACTIVE_HIGH>;
> +               enable-active-high;
> +               off-on-delay-us = <3480>;
> +       };
> +};
> +
> +&imx8dxl_cm4 {
> +       memory-region = <&vdev0vring0>, <&vdev0vring1>, <&vdevbuffer>,
> +                       <&vdev1vring0>, <&vdev1vring1>;
> +       status = "disabled";
> +};

drop first

> +
> +&i2c2 {
> +       #address-cells = <1>;
> +       #size-cells = <0>;
> +       clock-frequency = <100000>;
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_i2c2>;
> +       status = "okay";
> +
> +       pca6416_1: gpio@20 {
> +               compatible = "ti,tca6416";
> +               reg = <0x20>;
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +       };
> +
> +       pca6416_2: gpio@21 {
> +               compatible = "ti,tca6416";
> +               reg = <0x21>;
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +       };
> +
> +       pca9548_1: pca9548@70 {
> +               compatible = "nxp,pca9548";
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               reg = <0x70>;
> +
> +               i2c@0 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x0>;
> +
> +                       max7322: gpio@68 {
> +                               compatible = "maxim,max7322";
> +                               reg = <0x68>;
> +                               gpio-controller;
> +                               #gpio-cells = <2>;
> +                               status = "disabled";
> +                       };
> +               };
> +
> +               i2c@4 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x4>;
> +               };
> +
> +               i2c@5 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x5>;
> +               };
> +
> +               i2c@6 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x6>;
> +               };
> +       };
> +};
> +
> +&i2c3 {
> +       #address-cells = <1>;
> +       #size-cells = <0>;
> +       clock-frequency = <100000>;
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_i2c3>;
> +       status = "okay";
> +
> +       pca6416_3: gpio@20 {
> +               compatible = "ti,tca6416";
> +               reg = <0x20>;
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +               interrupt-parent = <&lsio_gpio2>;
> +               interrupts = <5 IRQ_TYPE_EDGE_RISING>;
> +       };
> +
> +       pca9548_2: pca9548@70 {
> +               compatible = "nxp,pca9548";
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               reg = <0x70>;
> +
> +               i2c@0 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x0>;
> +               };
> +
> +               i2c@1 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x1>;
> +               };
> +
> +               i2c@2 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x2>;
> +               };
> +
> +               i2c@3 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x3>;
> +               };
> +
> +               i2c@4 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x4>;
> +               };
> +       };
> +};
> +
> +&lpuart0 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_lpuart0>;
> +       status = "okay";
> +};
> +
> +&lpuart1 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_lpuart1>;
> +       resets = <&modem_reset>;
> +       status = "okay";
> +};
> +
> +&lsio_gpio4 {
> +       status = "okay";
> +};
> +
> +&lsio_gpio5 {
> +       status = "okay";
> +};
> +
> +&thermal_zones {
> +       pmic-thermal0 {
> +               polling-delay-passive = <250>;
> +               polling-delay = <2000>;
> +               thermal-sensors = <&tsens IMX_SC_R_PMIC_0>;
> +               trips {
> +                       pmic_alert0: trip0 {
> +                               temperature = <110000>;
> +                               hysteresis = <2000>;
> +                               type = "passive";
> +                       };
> +                       pmic_crit0: trip1 {
> +                               temperature = <125000>;
> +                               hysteresis = <2000>;
> +                               type = "critical";
> +                       };
> +               };
> +               cooling-maps {
> +                       map0 {
> +                               trip = <&pmic_alert0>;
> +                               cooling-device =
> +                                       <&A35_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                       <&A35_1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +                       };
> +               };
> +       };
> +};
> +
> +&usdhc1 {
> +               pinctrl-names = "default", "state_100mhz", "state_200mhz";
> +               pinctrl-0 = <&pinctrl_usdhc1>;
> +               pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
> +               pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
> +               bus-width = <8>;
> +               no-sd;
> +               no-sdio;
> +               non-removable;
> +               status = "okay";
> +};
> +
> +&usdhc2 {
> +               pinctrl-names = "default", "state_100mhz", "state_200mhz";
> +               pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
> +               pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
> +               pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
> +               bus-width = <4>;
> +               vmmc-supply = <&reg_usdhc2_vmmc>;
> +               cd-gpios = <&lsio_gpio5 1 GPIO_ACTIVE_LOW>;
> +               wp-gpios = <&lsio_gpio5 0 GPIO_ACTIVE_HIGH>;
> +               max-frequency = <100000000>;
> +               status = "okay";
> +};
> +
> +&iomuxc {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_hog>;
> +
> +       pinctrl_hog: hoggrp {
> +               fsl,pins = <
> +                       IMX8DXL_COMP_CTL_GPIO_1V8_3V3_GPIORHB_PAD       0x000514a0
> +                       IMX8DXL_COMP_CTL_GPIO_1V8_3V3_GPIORHK_PAD       0x000014a0
> +                       IMX8DXL_SPI3_CS0_ADMA_ACM_MCLK_OUT1             0x0600004c
> +                       IMX8DXL_SNVS_TAMPER_OUT1_LSIO_GPIO2_IO05_IN     0x0600004c
> +               >;
> +       };
> +
> +       pinctrl_i2c2: i2c2grp {
> +               fsl,pins = <
> +                       IMX8DXL_SPI1_SCK_ADMA_I2C2_SDA          0x06000021
> +                       IMX8DXL_SPI1_SDO_ADMA_I2C2_SCL          0x06000021
> +               >;
> +       };
> +
> +       pinctrl_i2c3: i2c3grp {
> +               fsl,pins = <
> +                       IMX8DXL_SPI1_CS0_ADMA_I2C3_SDA          0x06000021
> +                       IMX8DXL_SPI1_SDI_ADMA_I2C3_SCL          0x06000021
> +               >;
> +       };
> +
> +       pinctrl_lpuart0: lpuart0grp {
> +               fsl,pins = <
> +                       IMX8DXL_UART0_RX_ADMA_UART0_RX          0x06000020
> +                       IMX8DXL_UART0_TX_ADMA_UART0_TX          0x06000020
> +               >;
> +       };
> +
> +       pinctrl_lpuart1: lpuart1grp {
> +               fsl,pins = <
> +                       IMX8DXL_UART1_TX_ADMA_UART1_TX          0x06000020
> +                       IMX8DXL_UART1_RX_ADMA_UART1_RX          0x06000020
> +                       IMX8DXL_UART1_RTS_B_ADMA_UART1_RTS_B    0x06000020
> +                       IMX8DXL_UART1_CTS_B_ADMA_UART1_CTS_B    0x06000020
> +               >;
> +       };
> +
> +       pinctrl_usdhc1: usdhc1grp {
> +               fsl,pins = <
> +                       IMX8DXL_EMMC0_CLK_CONN_EMMC0_CLK        0x06000041
> +                       IMX8DXL_EMMC0_CMD_CONN_EMMC0_CMD        0x00000021
> +                       IMX8DXL_EMMC0_DATA0_CONN_EMMC0_DATA0    0x00000021
> +                       IMX8DXL_EMMC0_DATA1_CONN_EMMC0_DATA1    0x00000021
> +                       IMX8DXL_EMMC0_DATA2_CONN_EMMC0_DATA2    0x00000021
> +                       IMX8DXL_EMMC0_DATA3_CONN_EMMC0_DATA3    0x00000021
> +                       IMX8DXL_EMMC0_DATA4_CONN_EMMC0_DATA4    0x00000021
> +                       IMX8DXL_EMMC0_DATA5_CONN_EMMC0_DATA5    0x00000021
> +                       IMX8DXL_EMMC0_DATA6_CONN_EMMC0_DATA6    0x00000021
> +                       IMX8DXL_EMMC0_DATA7_CONN_EMMC0_DATA7    0x00000021
> +                       IMX8DXL_EMMC0_STROBE_CONN_EMMC0_STROBE  0x00000041
> +               >;
> +       };
> +
> +       pinctrl_usdhc1_100mhz: usdhc1grp100mhz {
> +               fsl,pins = <
> +                       IMX8DXL_EMMC0_CLK_CONN_EMMC0_CLK        0x06000041
> +                       IMX8DXL_EMMC0_CMD_CONN_EMMC0_CMD        0x00000021
> +                       IMX8DXL_EMMC0_DATA0_CONN_EMMC0_DATA0    0x00000021
> +                       IMX8DXL_EMMC0_DATA1_CONN_EMMC0_DATA1    0x00000021
> +                       IMX8DXL_EMMC0_DATA2_CONN_EMMC0_DATA2    0x00000021
> +                       IMX8DXL_EMMC0_DATA3_CONN_EMMC0_DATA3    0x00000021
> +                       IMX8DXL_EMMC0_DATA4_CONN_EMMC0_DATA4    0x00000021
> +                       IMX8DXL_EMMC0_DATA5_CONN_EMMC0_DATA5    0x00000021
> +                       IMX8DXL_EMMC0_DATA6_CONN_EMMC0_DATA6    0x00000021
> +                       IMX8DXL_EMMC0_DATA7_CONN_EMMC0_DATA7    0x00000021
> +                       IMX8DXL_EMMC0_STROBE_CONN_EMMC0_STROBE  0x00000041
> +               >;
> +       };
> +
> +       pinctrl_usdhc1_200mhz: usdhc1grp200mhz {
> +               fsl,pins = <
> +                       IMX8DXL_EMMC0_CLK_CONN_EMMC0_CLK        0x06000041
> +                       IMX8DXL_EMMC0_CMD_CONN_EMMC0_CMD        0x00000021
> +                       IMX8DXL_EMMC0_DATA0_CONN_EMMC0_DATA0    0x00000021
> +                       IMX8DXL_EMMC0_DATA1_CONN_EMMC0_DATA1    0x00000021
> +                       IMX8DXL_EMMC0_DATA2_CONN_EMMC0_DATA2    0x00000021
> +                       IMX8DXL_EMMC0_DATA3_CONN_EMMC0_DATA3    0x00000021
> +                       IMX8DXL_EMMC0_DATA4_CONN_EMMC0_DATA4    0x00000021
> +                       IMX8DXL_EMMC0_DATA5_CONN_EMMC0_DATA5    0x00000021
> +                       IMX8DXL_EMMC0_DATA6_CONN_EMMC0_DATA6    0x00000021
> +                       IMX8DXL_EMMC0_DATA7_CONN_EMMC0_DATA7    0x00000021
> +                       IMX8DXL_EMMC0_STROBE_CONN_EMMC0_STROBE  0x00000041
> +               >;
> +       };
> +
> +       pinctrl_usdhc2_gpio: usdhc2gpiogrp {
> +               fsl,pins = <
> +                       IMX8DXL_ENET0_RGMII_TX_CTL_LSIO_GPIO4_IO30      0x00000040 /* RESET_B */
> +                       IMX8DXL_ENET0_RGMII_TXD1_LSIO_GPIO5_IO00        0x00000021 /* WP */
> +                       IMX8DXL_ENET0_RGMII_TXD2_LSIO_GPIO5_IO01        0x00000021 /* CD */
> +               >;
> +       };
> +
> +       pinctrl_usdhc2: usdhc2grp {
> +               fsl,pins = <
> +                       IMX8DXL_ENET0_RGMII_RXC_CONN_USDHC1_CLK         0x06000041
> +                       IMX8DXL_ENET0_RGMII_RX_CTL_CONN_USDHC1_CMD      0x00000021
> +                       IMX8DXL_ENET0_RGMII_RXD0_CONN_USDHC1_DATA0      0x00000021
> +                       IMX8DXL_ENET0_RGMII_RXD1_CONN_USDHC1_DATA1      0x00000021
> +                       IMX8DXL_ENET0_RGMII_RXD2_CONN_USDHC1_DATA2      0x00000021
> +                       IMX8DXL_ENET0_RGMII_RXD3_CONN_USDHC1_DATA3      0x00000021
> +                       IMX8DXL_ENET0_RGMII_TXD0_CONN_USDHC1_VSELECT    0x00000021
> +               >;
> +       };
> +
> +       pinctrl_usdhc2_100mhz: usdhc2grp100mhz {
> +               fsl,pins = <
> +                       IMX8DXL_ENET0_RGMII_RXC_CONN_USDHC1_CLK         0x06000041
> +                       IMX8DXL_ENET0_RGMII_RX_CTL_CONN_USDHC1_CMD      0x00000021
> +                       IMX8DXL_ENET0_RGMII_RXD0_CONN_USDHC1_DATA0      0x00000021
> +                       IMX8DXL_ENET0_RGMII_RXD1_CONN_USDHC1_DATA1      0x00000021
> +                       IMX8DXL_ENET0_RGMII_RXD2_CONN_USDHC1_DATA2      0x00000021
> +                       IMX8DXL_ENET0_RGMII_RXD3_CONN_USDHC1_DATA3      0x00000021
> +                       IMX8DXL_ENET0_RGMII_TXD0_CONN_USDHC1_VSELECT    0x00000021
> +               >;
> +       };
> +
> +       pinctrl_usdhc2_200mhz: usdhc2grp200mhz {
> +               fsl,pins = <
> +                       IMX8DXL_ENET0_RGMII_RXC_CONN_USDHC1_CLK         0x06000041
> +                       IMX8DXL_ENET0_RGMII_RX_CTL_CONN_USDHC1_CMD      0x00000021
> +                       IMX8DXL_ENET0_RGMII_RXD0_CONN_USDHC1_DATA0      0x00000021
> +                       IMX8DXL_ENET0_RGMII_RXD1_CONN_USDHC1_DATA1      0x00000021
> +                       IMX8DXL_ENET0_RGMII_RXD2_CONN_USDHC1_DATA2      0x00000021
> +                       IMX8DXL_ENET0_RGMII_RXD3_CONN_USDHC1_DATA3      0x00000021
> +                       IMX8DXL_ENET0_RGMII_TXD0_CONN_USDHC1_VSELECT    0x00000021
> +               >;
> +       };
> +};
> --
> 2.31.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
