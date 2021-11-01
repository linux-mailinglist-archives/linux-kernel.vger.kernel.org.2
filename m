Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7433944237D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 23:36:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbhKAWid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 18:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232260AbhKAWia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 18:38:30 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1497C061714
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 15:35:56 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1mhfuB-0001Jc-7E; Mon, 01 Nov 2021 23:35:51 +0100
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Subject: Re: [PATCH] arm64: dts: imx8m: add syscon node for display_blk_ctrl
 module regs
To:     Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>, Alice Guo <alice.guo@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Adam Ford <aford173@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>
References: <20211101222857.6940-1-tomm.merciai@gmail.com>
Message-ID: <c04d4af6-8c7b-da23-d562-78324948ac35@pengutronix.de>
Date:   Mon, 1 Nov 2021 23:35:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211101222857.6940-1-tomm.merciai@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Tommaso,

On 01.11.21 23:28, Tommaso Merciai wrote:
> Add system controller node for registers of module Display Block Control
> (DISPLAY_BLK_CTRL, base address: 0x32e28000).
> The DISPLAY_BLK_CTRL module contains general purpose registers (GPRs),
> which control varied features of the associated peripherals.
> Reference: IMX8MMRM Rev. 3, 11/2020, p 3897
> ---
>  arch/arm64/boot/dts/freescale/imx8mm.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> index 2f632e8ca388..3e496b457e1a 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> @@ -961,6 +961,11 @@ aips4: bus@32c00000 {
>  			#size-cells = <1>;
>  			ranges = <0x32c00000 0x32c00000 0x400000>;
>  
> +			dispmix_gpr: display-gpr@32e28000 {
> +				compatible = "fsl, imx8mm-iomuxc-gpr", "syscon";

Please read vendor patches before submitting them. The space
is out-of-place in the compatible and the compatible is wrong:
This doesn't look like a i.MX8MM pin controller.

Cheers,
Ahmad

> +				reg = <0x32e28000 0x100>;
> +			};
> +
>  			usbotg1: usb@32e40000 {
>  				compatible = "fsl,imx8mm-usb", "fsl,imx7d-usb";
>  				reg = <0x32e40000 0x200>;
> 


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
