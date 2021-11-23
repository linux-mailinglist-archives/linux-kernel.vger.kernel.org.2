Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56848459F1A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 10:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234758AbhKWJUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 04:20:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbhKWJUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 04:20:53 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F57C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 01:17:45 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1mpRvs-0003fM-32; Tue, 23 Nov 2021 10:17:44 +0100
Subject: Re: [PATCH 1/7] arm64: dts: imx8mn-evk: add hardware reset for FEC
 PHY
To:     Joakim Zhang <qiangqing.zhang@nxp.com>, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     devicetree@vger.kernel.org, festevam@gmail.com, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org
References: <20211123080506.21424-1-qiangqing.zhang@nxp.com>
 <20211123080506.21424-2-qiangqing.zhang@nxp.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <9daa2635-4420-980e-3227-2fd790a02cf1@pengutronix.de>
Date:   Tue, 23 Nov 2021 10:17:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211123080506.21424-2-qiangqing.zhang@nxp.com>
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

On 23.11.21 09:05, Joakim Zhang wrote:
> Add hardware reset for FEC PHY.
> 
> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>

Reviewed-by: Ahmad Fatoum <a.fatoum@pengutronix.de>

> ---
>  arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
> index 85e65f8719ea..30e7c9d56090 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
> @@ -97,6 +97,8 @@
>  		ethphy0: ethernet-phy@0 {
>  			compatible = "ethernet-phy-ieee802.3-c22";
>  			reg = <0>;
> +			reset-gpios = <&gpio4 22 GPIO_ACTIVE_LOW>;
> +			reset-assert-us = <10000>;
>  		};
>  	};
>  };
> 


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
