Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 569983B734D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 15:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232920AbhF2NjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 09:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232535AbhF2NjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 09:39:04 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD447C061760;
        Tue, 29 Jun 2021 06:36:35 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id o11so23263575ejd.4;
        Tue, 29 Jun 2021 06:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=32vFRN7z5omgoPVrUXlvXHuIAEBAvCU++16V1o40YfQ=;
        b=P8mbYKF8/NUycXHIHmxKn9v+aCfEg9q7gIEJZOLbb3qLcgn0DG7h0hCtRbyZTLKlxc
         fWz4qayRVylDRh+rqyx97Q5aMs37f5pzlwu7vUCK18zZZ2hKs+rTR9nev/DKauRaLkgc
         hBWPgstg/UrUMdGA6/wQjJSL7xOBn8qlhRgaEDgvTJpa4B10R2TRhY3btPdt9JIdKkfu
         dADVXcI0ZxHu2i0cmsig4gKpqq45bMyq8OmlLEJSEvVv2Z6Uhaj4rVTIHVNGWkYjEz6b
         4H0FzFlrtZArkFRZ2siDZ+uWcb8pil3p+ZYTZGDX0YueTU+pyyRsG26o2Lalm2Run3W+
         lgPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=32vFRN7z5omgoPVrUXlvXHuIAEBAvCU++16V1o40YfQ=;
        b=mYoEgakCl1BRFDNw5kyrsY5Gnu3+om5isMnLncENN70A9aEiF36JuhDbSQlapXbAr/
         0CJP4Hglmpo/H3eYL9PX6f/tes6+YXH05G4Uoo1ICuuffUrA9KPEa5RZWwoPhz1wnIXR
         XLaHEgTEDVR7hXi+CVIRiulHiEuFAWPfDmZ0QWpI39PawoxFIZVPXX/k4CvbBBt80dsu
         difuIWm+7vDulPYcYBw14ziw+qdpqHz0PeK1wQcvWjfQZRuZE1DrOLmtulD2V69bR8r1
         aLCz59UlgITb14Zp65Zmy7L+XMmCxk/NupPWVtV8X1EWF+CBuozgAcmsKNWbcvIBi3wD
         j37A==
X-Gm-Message-State: AOAM531K2kDNC7g9KS+05gAi0y5zg7x7m1HDu3whA2h4L7bYBImJOVbS
        QtJcGO/DtTzKvyslO8iI3uayIYf5eSLo1tEzakc=
X-Google-Smtp-Source: ABdhPJzaWTEP4/WdrVuO2XYM02laTSOHQ2IvwusTYzJqSW1lTdc8flTrVKD1fZBT/WhHzmuu/YILPYoPg4b24eHir6Q=
X-Received: by 2002:a17:906:2844:: with SMTP id s4mr29851513ejc.263.1624973794318;
 Tue, 29 Jun 2021 06:36:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210604111005.6804-1-peng.fan@oss.nxp.com>
In-Reply-To: <20210604111005.6804-1-peng.fan@oss.nxp.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Tue, 29 Jun 2021 08:36:23 -0500
Message-ID: <CAHCN7xKYooBQzREdoa8ybhQUBXxy6RPaFX9rp1keD7_HgnVA9Q@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mm: add pgc/blk_ctl nodes
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
        Marek Vasut <marex@denx.de>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Schrempf Frieder <frieder.schrempf@kontron.de>,
        Abel Vesa <abel.vesa@nxp.com>, Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 4, 2021 at 5:37 AM Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> With PGC and BLK-CTL landed, we could add pgc and blk-ctl nodes,
> because some pgc domain relies on blk-ctl power domain, so
> they need to be added together.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>
> V1:
>  Depends on the blk-ctl patchset,
>  https://patchwork.kernel.org/project/linux-arm-kernel/cover/20210522134249.15322-1-peng.fan@oss.nxp.com/
>
>  Shawn,
>   Since the blk-ctl patchset is in good shape and tested, is it ok for
>   you to pick up?
>  Thanks
>
>  arch/arm64/boot/dts/freescale/imx8mm.dtsi | 128 ++++++++++++++++++++++
>  1 file changed, 128 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> index e7648c3b8390..0e01ff649956 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> @@ -7,6 +7,8 @@
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/input/input.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/power/imx8mm-power.h>
> +#include <dt-bindings/reset/imx8mq-reset.h>
>  #include <dt-bindings/thermal/thermal.h>
>
>  #include "imx8mm-pinfunc.h"
> @@ -609,6 +611,109 @@ src: reset-controller@30390000 {
>                                 interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
>                                 #reset-cells = <1>;
>                         };
> +
> +                       gpc: gpc@303a0000 {
> +                               compatible = "fsl,imx8mm-gpc";
> +                               reg = <0x303a0000 0x10000>;
> +                               interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
> +                               interrupt-parent = <&gic>;
> +                               interrupt-controller;
> +                               #interrupt-cells = <3>;
> +
> +                               pgc {
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
> +
> +                                       pgc_hsiomix: power-domain@0 {
> +                                               #power-domain-cells = <0>;
> +                                               reg = <IMX8MM_POWER_DOMAIN_HSIOMIX>;
> +                                               clocks = <&clk IMX8MM_CLK_USB1_CTRL_ROOT>;
> +                                       };
> +
> +                                       pgc_pcie: power-domain@1 {
> +                                               #power-domain-cells = <0>;
> +                                               reg = <IMX8MM_POWER_DOMAIN_PCIE>;
> +                                               power-domains = <&pgc_hsiomix>;
> +                                               clocks = <&clk IMX8MM_CLK_PCIE1_ROOT>;
> +                                       };
> +
> +                                       pgc_otg1: power-domain@2 {
> +                                               #power-domain-cells = <0>;
> +                                               reg = <IMX8MM_POWER_DOMAIN_OTG1>;
> +                                               power-domains = <&pgc_hsiomix>;
> +                                       };
> +
> +                                       pgc_otg2: power-domain@3 {
> +                                               #power-domain-cells = <0>;
> +                                               reg = <IMX8MM_POWER_DOMAIN_OTG2>;
> +                                               power-domains = <&pgc_hsiomix>;
> +                                       };
> +

Any change you could add the references to pgc_otg1 and pgc_otg2 to
their respective OTG nodes?  Without them, enabling OTG1 or OTG2 can
result in a hang unless it was started in U-Boot.

> +                                       pgc_gpumix: power-domain@4 {
> +                                               #power-domain-cells = <0>;
> +                                               reg = <IMX8MM_POWER_DOMAIN_GPUMIX>;
> +                                               clocks = <&clk IMX8MM_CLK_GPU_BUS_ROOT>,
> +                                                        <&clk IMX8MM_CLK_GPU_AHB>;
> +                                       };
> +
> +                                       pgc_gpu: power-domain@5 {
> +                                               #power-domain-cells = <0>;
> +                                               reg = <IMX8MM_POWER_DOMAIN_GPU>;
> +                                               clocks = <&clk IMX8MM_CLK_GPU_AHB>,
> +                                                        <&clk IMX8MM_CLK_GPU_BUS_ROOT>,
> +                                                        <&clk IMX8MM_CLK_GPU2D_ROOT>,
> +                                                        <&clk IMX8MM_CLK_GPU3D_ROOT>;
> +                                               resets = <&src IMX8MQ_RESET_GPU_RESET>;
> +                                               power-domains = <&pgc_gpumix>;
> +                                       };
> +
> +                                       pgc_vpumix: power-domain@6 {
> +                                               #power-domain-cells = <0>;
> +                                               reg = <IMX8MM_POWER_DOMAIN_VPUMIX>;
> +                                               clocks = <&clk IMX8MM_CLK_VPU_DEC_ROOT>;
> +                                               resets = <&src IMX8MQ_RESET_VPU_RESET>;
> +                                       };
> +
> +                                       pgc_vpu_g1: power-domain@7 {
> +                                               #power-domain-cells = <0>;
> +                                               power-domains =
> +                                               <&vpumix_blk_ctl IMX8MM_BLK_CTL_PD_VPU_BUS>;
> +                                               reg = <IMX8MM_POWER_DOMAIN_VPUG1>;
> +                                               clocks = <&clk IMX8MM_CLK_VPU_G1_ROOT>;
> +                                       };
> +
> +                                       pgc_vpu_g2: power-domain@8 {
> +                                               #power-domain-cells = <0>;
> +                                               power-domains =
> +                                               <&vpumix_blk_ctl IMX8MM_BLK_CTL_PD_VPU_BUS>;
> +                                               reg = <IMX8MM_POWER_DOMAIN_VPUG2>;
> +                                               clocks = <&clk IMX8MM_CLK_VPU_G2_ROOT>;
> +                                       };
> +
> +                                       pgc_vpu_h1: power-domain@9 {
> +                                               #power-domain-cells = <0>;
> +                                               power-domains =
> +                                               <&vpumix_blk_ctl IMX8MM_BLK_CTL_PD_VPU_BUS>;
> +                                               reg = <IMX8MM_POWER_DOMAIN_VPUH1>;
> +                                               clocks = <&clk IMX8MM_CLK_VPU_H1_ROOT>;
> +                                       };
> +
> +                                       pgc_dispmix: power-domain@10 {
> +                                               #power-domain-cells = <0>;
> +                                               reg = <IMX8MM_POWER_DOMAIN_DISPMIX>;
> +                                               clocks = <&clk IMX8MM_CLK_DISP_ROOT>,
> +                                                        <&clk IMX8MM_CLK_DISP_AXI_ROOT>,
> +                                                        <&clk IMX8MM_CLK_DISP_APB_ROOT>;
> +                                       };
> +
> +                                       pgc_mipi: power-domain@11 {
> +                                               #power-domain-cells = <0>;
> +                                               reg = <IMX8MM_POWER_DOMAIN_MIPI>;
> +                                               power-domains =
> +                                               <&dispmix_blk_ctl IMX8MM_BLK_CTL_PD_DISPMIX_BUS>;
> +                                       };
> +                               };
> +                       };
>                 };
>
>                 aips2: bus@30400000 {
> @@ -960,6 +1065,18 @@ aips4: bus@32c00000 {
>                         #size-cells = <1>;
>                         ranges = <0x32c00000 0x32c00000 0x400000>;
>
> +                       dispmix_blk_ctl: blk_ctl@32e28000 {
> +                               compatible = "fsl,imx8mm-dispmix-blk-ctl", "syscon";
> +                               reg = <0x32e28000 0x100>;
> +                               #power-domain-cells = <1>;
> +                               #reset-cells = <1>;
> +                               power-domains = <&pgc_dispmix>, <&pgc_mipi>;
> +                               power-domain-names = "dispmix", "mipi";
> +                               clocks = <&clk IMX8MM_CLK_DISP_ROOT>,
> +                                        <&clk IMX8MM_CLK_DISP_AXI_ROOT>,
> +                                        <&clk IMX8MM_CLK_DISP_APB_ROOT>;
> +                       };
> +
>                         usbotg1: usb@32e40000 {
>                                 compatible = "fsl,imx8mm-usb", "fsl,imx7d-usb";
>                                 reg = <0x32e40000 0x200>;
> @@ -1029,6 +1146,17 @@ gpmi: nand-controller@33002000{
>                         status = "disabled";
>                 };
>
> +               vpumix_blk_ctl: blk-ctl@38330000 {
> +                       compatible = "fsl,imx8mm-vpumix-blk-ctl", "syscon";
> +                       reg = <0x38330000 0x100>;
> +                       #power-domain-cells = <1>;
> +                       #reset-cells = <1>;
> +                       power-domains = <&pgc_vpumix>, <&pgc_vpu_g1>, <&pgc_vpu_g2>, <&pgc_vpu_h1>;
> +                       power-domain-names = "vpumix", "vpu-g1", "vpu-g2", "vpu-h1";
> +                       clocks = <&clk IMX8MM_CLK_VPU_DEC_ROOT>, <&clk IMX8MM_CLK_VPU_G1_ROOT>,
> +                                <&clk IMX8MM_CLK_VPU_G2_ROOT>, <&clk IMX8MM_CLK_VPU_H1_ROOT>;
> +               };
> +
>                 gic: interrupt-controller@38800000 {
>                         compatible = "arm,gic-v3";
>                         reg = <0x38800000 0x10000>, /* GIC Dist */
> --
> 2.30.0
>
