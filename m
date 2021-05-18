Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D28B0387398
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 09:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347335AbhERHzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 03:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346903AbhERHzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 03:55:36 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F98C061573;
        Tue, 18 May 2021 00:54:19 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id s5-20020a05683004c5b029032307304915so625145otd.7;
        Tue, 18 May 2021 00:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wgWT8glNh9NlJS5p0NFisrV3DtTQRZ5P1kbkf3d41QA=;
        b=MdYWBIN7cbTWoEBFbZ7ETFLm228xKDEN/+CLdNnF7CpKpKpjc/xc0sU9CosMA+hsdK
         hh45r0O+HS7y7ii2MQy7MIg3VK8dPZMY+yDyhDZkSZZchXi7uh5vld2kVoax2oZp70Qh
         AY793J7ddr7VoL1XjSBL0GCS0BGmMZws+/WdbjP3gkPua/4eCkdZRazYNZF3rr3u17Xr
         2bQA0swuD4r4A4Y3zQ3xCJJsV5Y/GK+iVpLVmCm/q8Xsw6RePq/Z5qpOzYnfwrbeiaxh
         mCuSOQOZsn7g07giOJf+jmT/uhTNJ/XrBRDXLVWVW0MzPtK8yism81RjMp7pxwRsWVt/
         e+uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wgWT8glNh9NlJS5p0NFisrV3DtTQRZ5P1kbkf3d41QA=;
        b=ZPFO4XaFLpqj4VXlrBucZLydrAcmQon9KDczQQlmJcSxHExEShn+2dWDyB3W4Ei/iE
         uxrNGQMCoMPP7AtfegNMINUqkwyDe6VKTAd9oIUpuL6zo0EgY3Dfjk/LCtpmrU8I86YJ
         wik9PWbh5EbLSvHqk9mo+jKmzxYLmXM3Q51mlY86W27QXnEHJ0ybqaluOJwO17F6It5L
         njuYCnboS0GPNAyzEyofx+g7yWuspkOYrqTBIE7e7kXcMhp6y7tyae2U5+nK/JKIXMst
         7HysKgHMeC9Ne2PxgEnNzvqfS8AOTDlIpUGC7Z2RmNJ36h70cU/uKtQZ93n5+OKpwTbW
         wCHA==
X-Gm-Message-State: AOAM5314MCNuTRpBb93CCZF+DjSMBgHQMwBBjQZcTaS+o7kQzpmV0LyS
        /Udpi+XP4Td89BnL/X1i4w6B/3x9UupUFknb3fY=
X-Google-Smtp-Source: ABdhPJz1gwU0uszCDNnZoynqlsVmncT7Aet0+fx1EcUJy1lbg2YOnBzrGLogRpw+jzBDLcDw+VlHcu/IAG72u0Omq+w=
X-Received: by 2002:a9d:4115:: with SMTP id o21mr3237071ote.52.1621324458608;
 Tue, 18 May 2021 00:54:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210517171205.1581938-1-abelvesa@kernel.org> <20210517171205.1581938-5-abelvesa@kernel.org>
In-Reply-To: <20210517171205.1581938-5-abelvesa@kernel.org>
From:   Dong Aisheng <dongas86@gmail.com>
Date:   Tue, 18 May 2021 15:53:16 +0800
Message-ID: <CAA+hA=R6WVLmVU8vS-T2q51V4x5havrQvmOEeYKAgJMu96X2Nw@mail.gmail.com>
Subject: Re: [PATCH 4/7] arm64: dts: freescale: Add the imx8dxl connectivity
 subsys dtsi
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

On Tue, May 18, 2021 at 1:15 AM <abelvesa@kernel.org> wrote:
>
> From: Jacky Bai <ping.bai@nxp.com>
>
> On i.MX8DXL, the Connectivity subsystem includes below peripherals:
> 1x ENET with AVB support, 1x ENET with TSN support, 2x USB OTG,
> 1x eMMC, 2x SD, 1x NAND.
>
> Signed-off-by: Jacky Bai <ping.bai@nxp.com>
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
>  .../boot/dts/freescale/imx8dxl-ss-conn.dtsi   | 133 ++++++++++++++++++
>  1 file changed, 133 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8dxl-ss-conn.dtsi
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-ss-conn.dtsi b/arch/arm64/boot/dts/freescale/imx8dxl-ss-conn.dtsi
> new file mode 100644
> index 000000000000..c10801926de3
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8dxl-ss-conn.dtsi
> @@ -0,0 +1,133 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2019-2021 NXP
> + */
> +
> +/delete-node/ &enet1_lpcg;
> +/delete-node/ &fec2;
> +
> +&conn_subsys {
> +       conn_enet0_root_clk: clock-conn-enet0-root {
> +               compatible = "fixed-clock";
> +               #clock-cells = <0>;
> +               clock-frequency = <250000000>;
> +               clock-output-names = "conn_enet0_root_clk";
> +       };
> +
> +       eqos: ethernet@5b050000 {
> +               compatible = "nxp,imx8dxl-dwmac-eqos", "snps,dwmac-5.10a";
> +               reg = <0x5b050000 0x10000>;
> +               interrupt-parent = <&gic>;
> +               interrupts = <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>,
> +                            <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>;
> +               interrupt-names = "eth_wake_irq", "macirq";
> +               clocks = <&eqos_lpcg 2>,
> +                        <&eqos_lpcg 4>,
> +                        <&eqos_lpcg 0>,
> +                        <&eqos_lpcg 3>,
> +                        <&eqos_lpcg 1>;

need fix LPCG index
pls refer to binding doc

> +               clock-names = "stmmaceth", "pclk", "ptp_ref", "tx", "mem";
> +               assigned-clocks = <&clk IMX_SC_R_ENET_1 IMX_SC_PM_CLK_PER>;
> +               assigned-clock-rates = <125000000>;
> +               power-domains = <&pd IMX_SC_R_ENET_1>;
> +               clk_csr = <0>;
> +               status = "disabled";
> +       };
> +
> +       usbotg2: usb@5b0e0000 {
> +               compatible = "fsl,imx8dxl-usb", "fsl,imx7ulp-usb";
> +               reg = <0x5b0e0000 0x200>;
> +               interrupt-parent = <&gic>;
> +               interrupts = <GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH>;
> +               fsl,usbphy = <&usbphy2>;
> +               fsl,usbmisc = <&usbmisc2 0>;
> +               /*
> +                * usbotg1 and usbotg2 share one clcok
> +                * scfw disable clock access and keep it always on
> +                * in case other core (M4) use one of these.
> +                */
> +               clocks = <&clk_dummy>;
> +               ahb-burst-config = <0x0>;
> +               tx-burst-size-dword = <0x10>;
> +               rx-burst-size-dword = <0x10>;
> +               #stream-id-cells = <1>;
> +               power-domains = <&pd IMX_SC_R_USB_1>;
> +               status = "disabled";
> +       };
> +
> +       usbmisc2: usbmisc@5b0e0200 {
> +               #index-cells = <1>;
> +               compatible = "fsl,imx8dxl-usbmisc", "fsl,imx7ulp-usbmisc";
> +               reg = <0x5b0e0200 0x200>;
> +       };
> +
> +       usbphy2: usbphy@0x5b110000 {
> +               compatible = "fsl,imx8dxl-usbphy", "fsl,imx7ulp-usbphy";
> +               reg = <0x5b110000 0x1000>;
> +               clocks = <&usb2_2_lpcg 0>;
> +               status = "disabled";
> +       };
> +
> +       eqos_lpcg: clock-controller@5b240000 {
> +               compatible = "fsl,imx8qxp-lpcg";
> +               reg = <0x5b240000 0x10000>;
> +               #clock-cells = <1>;
> +               clocks = <&conn_enet0_root_clk>,
> +                        <&conn_axi_clk>,
> +                        <&conn_axi_clk>,
> +                        <&clk IMX_SC_R_ENET_1 IMX_SC_PM_CLK_PER>,
> +                        <&conn_ipg_clk>;
> +               bit-offset = <0 8 16 20 24>;
> +               clock-output-names = "eqos_ptp",
> +                                    "eqos_mem_clk",
> +                                    "eqos_aclk",
> +                                    "eqos_clk",
> +                                    "eqos_csr_clk";
> +               power-domains = <&pd IMX_SC_R_ENET_1>;
> +       };
> +
> +       usb2_2_lpcg: clock-controller@5b280000 {
> +               compatible = "fsl,imx8qxp-lpcg";
> +               reg = <0x5b280000 0x10000>;
> +               #clock-cells = <1>;
> +
> +               bit-offset = <28>;
> +               clocks = <&conn_ipg_clk>;
> +               clock-output-names = "usboh3_2_phy_ipg_clk";
> +       };
> +
> +};
> +
> +&enet0_lpcg {
> +       clocks = <&conn_enet0_root_clk>,
> +                <&conn_enet0_root_clk>,
> +                <&conn_axi_clk>,
> +                <&clk IMX_SC_R_ENET_0 IMX_SC_C_TXCLK>,
> +                <&conn_ipg_clk>,
> +                <&conn_ipg_clk>;
> +};
> +
> +&fec1 {
> +       compatible = "fsl,imx8dxl-fec", "fsl,imx8qm-fec";
> +       interrupts = <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>,
> +                    <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>,
> +                    <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>,
> +                    <GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>;
> +       assigned-clocks = <&clk IMX_SC_R_ENET_0 IMX_SC_C_CLKDIV>;
> +       assigned-clock-rates = <125000000>;
> +};
> +
> +&usdhc1 {
> +       compatible = "fsl,imx8dxl-usdhc", "fsl,imx8qxp-usdhc";
> +       interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
> +};
> +
> +&usdhc2 {
> +       compatible = "fsl,imx8dxl-usdhc", "fsl,imx8qxp-usdhc";
> +       interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>;
> +};
> +
> +&usdhc3 {
> +       compatible = "fsl,imx8dxl-usdhc", "fsl,imx8qxp-usdhc";
> +       interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
> +};
> --
> 2.31.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
