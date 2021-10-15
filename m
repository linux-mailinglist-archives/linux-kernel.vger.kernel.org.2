Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EFA342FB08
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 20:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242649AbhJOScv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 14:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237667AbhJOScr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 14:32:47 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E02C061570
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 11:30:41 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1mbRyR-0002Jg-8A; Fri, 15 Oct 2021 20:30:31 +0200
Message-ID: <81462d405b92472c699f47c0d49e980cda857426.camel@pengutronix.de>
Subject: Re: [PATCH v3 3/9] arm64: dts: imx8mm: add the pcie phy support
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Richard Zhu <hongxing.zhu@nxp.com>, tharvey@gateworks.com,
        kishon@ti.com, vkoul@kernel.org, robh@kernel.org,
        galak@kernel.crashing.org, shawnguo@kernel.org
Cc:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
Date:   Fri, 15 Oct 2021 20:30:28 +0200
In-Reply-To: <1634028078-2387-4-git-send-email-hongxing.zhu@nxp.com>
References: <1634028078-2387-1-git-send-email-hongxing.zhu@nxp.com>
         <1634028078-2387-4-git-send-email-hongxing.zhu@nxp.com>
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

Am Dienstag, dem 12.10.2021 um 16:41 +0800 schrieb Richard Zhu:
> Add the PCIe PHY support on iMX8MM platforms.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mm.dtsi | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> index c2f3f118f82e..ac5d11466608 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> @@ -1135,6 +1135,19 @@ usbmisc2: usbmisc@32e50200 {
>  				reg = <0x32e50200 0x200>;
>  			};
>  
> +			pcie_phy: pcie-phy@32f00000 {
> +				compatible = "fsl,imx8mm-pcie-phy";
> +				reg = <0x32f00000 0x10000>;
> +				clocks = <&clk IMX8MM_CLK_PCIE1_PHY>;
> +				clock-names = "phy";

Clock name specified in the binding is "ref".

> +				assigned-clocks = <&clk IMX8MM_CLK_PCIE1_PHY>;
> +				assigned-clock-rates = <100000000>;
> +				assigned-clock-parents = <&clk IMX8MM_SYS_PLL2_100M>;
> +				resets = <&src IMX8MQ_RESET_PCIEPHY>;
> +				reset-names = "pciephy";
> +				#phy-cells = <0>;
> +				status = "disabled";
> +			};
>  		};
>  
>  		dma_apbh: dma-controller@33000000 {


