Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4333842FB0B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 20:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237149AbhJOSez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 14:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234599AbhJOSex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 14:34:53 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B170FC061762
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 11:32:46 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1mbS0T-0002bh-5X; Fri, 15 Oct 2021 20:32:37 +0200
Message-ID: <ca1e71abe4c87ae2be6e3a3fa92ac79a6da4b6c4.camel@pengutronix.de>
Subject: Re: [PATCH v3 4/9] arm64: dts: imx8mm-evk: add the pcie phy support
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Richard Zhu <hongxing.zhu@nxp.com>, tharvey@gateworks.com,
        kishon@ti.com, vkoul@kernel.org, robh@kernel.org,
        galak@kernel.crashing.org, shawnguo@kernel.org
Cc:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
Date:   Fri, 15 Oct 2021 20:32:35 +0200
In-Reply-To: <1634028078-2387-5-git-send-email-hongxing.zhu@nxp.com>
References: <1634028078-2387-1-git-send-email-hongxing.zhu@nxp.com>
         <1634028078-2387-5-git-send-email-hongxing.zhu@nxp.com>
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
> Add the PCIe PHY support on iMX8MM EVK boards.
> And set the default reference clock mode.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> index e033d0257b5a..2d0684ac82f6 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> @@ -5,6 +5,7 @@
>  
>  /dts-v1/;
>  
> +#include <dt-bindings/phy/phy-imx8-pcie.h>
>  #include <dt-bindings/usb/pd.h>
>  #include "imx8mm.dtsi"
>  
> @@ -289,6 +290,12 @@ pca6416: gpio@20 {
>  	};
>  };
>  
> +&pcie_phy {
> +	fsl,refclk-pad-mode = <IMX8_PCIE_REFCLK_PAD_INPUT>;
> +	clocks = <&clk IMX8MM_CLK_DUMMY>;

Please add a fixed clock DT node for the external clock generator and
use this one instead of the dummy clock here.

Regards,
Lucas

> +	status = "okay";
> +};
> +
>  &sai3 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_sai3>;


