Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8BFD4190F2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 10:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233532AbhI0IhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 04:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233403AbhI0Ig7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 04:36:59 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1BB4C061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 01:35:21 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1mUm6R-0005O5-FN; Mon, 27 Sep 2021 10:35:11 +0200
Message-ID: <b7604aa25a5d6746025fadeea42a7cc4b5f884ff.camel@pengutronix.de>
Subject: Re: [PATCH v2 3/4] arm64: dts: imx8mm: add the pcie phy support
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Richard Zhu <hongxing.zhu@nxp.com>, kishon@ti.com,
        vkoul@kernel.org, robh@kernel.org, galak@kernel.crashing.org,
        shawnguo@kernel.org
Cc:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
Date:   Mon, 27 Sep 2021 10:35:09 +0200
In-Reply-To: <1632641983-1455-4-git-send-email-hongxing.zhu@nxp.com>
References: <1632641983-1455-1-git-send-email-hongxing.zhu@nxp.com>
         <1632641983-1455-4-git-send-email-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, dem 26.09.2021 um 15:39 +0800 schrieb Richard Zhu:
> Add the PCIe PHY support on iMX8MM platforms.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi |  4 ++++
>  arch/arm64/boot/dts/freescale/imx8mm.dtsi     | 12 ++++++++++++

This should be split into 2 patches: one for the SoC and one for the
EVK board.

>  2 files changed, 16 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> index e033d0257b5a..e7f398433486 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> @@ -289,6 +289,10 @@ pca6416: gpio@20 {
>  	};
>  };
>  
> +&pcie_phy {
> +	status = "okay";
> +};
> +
>  &sai3 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_sai3>;
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> index e7648c3b8390..de231d531ba4 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> @@ -998,6 +998,18 @@ usbmisc2: usbmisc@32e50200 {
>  				reg = <0x32e50200 0x200>;
>  			};
>  
> +			pcie_phy: pcie-phy@32f00000 {
> +				compatible = "fsl,imx8mm-pcie-phy";
> +				reg = <0x32f00000 0x10000>;
> +				clocks = <&clk IMX8MM_CLK_PCIE1_PHY>;
> +				clock-names = "phy";
> +				assigned-clocks = <&clk IMX8MM_CLK_PCIE1_PHY>;
> +				assigned-clock-rates = <100000000>;
> +				assigned-clock-parents = <&clk IMX8MM_SYS_PLL2_100M>;
> +				#phy-cells = <0>;
> +				fsl,refclk-pad-mode = <1>;

Move this to the board DT, as the pad mode is a board level decision.
Also use the enum instead of raw value.

> +				status = "disabled";
> +			};
>  		};
>  
>  		dma_apbh: dma-controller@33000000 {


