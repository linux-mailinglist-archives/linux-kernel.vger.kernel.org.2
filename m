Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27EBD414800
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 13:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235804AbhIVLmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 07:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235796AbhIVLmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 07:42:20 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C2AC061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 04:40:50 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1mT0cL-0006mg-9x; Wed, 22 Sep 2021 13:40:49 +0200
Subject: Re: [PATCH 6/6] arm64: dts: imx8m: remove unused "nvmem_macaddr_swap"
 property for FEC
To:     Joakim Zhang <qiangqing.zhang@nxp.com>,
        srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        shawnguo@kernel.org
Cc:     devicetree@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org
References: <20210908100257.17833-1-qiangqing.zhang@nxp.com>
 <20210908100257.17833-7-qiangqing.zhang@nxp.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <30969cc2-f091-6493-8b4d-ef8f2dd866b5@pengutronix.de>
Date:   Wed, 22 Sep 2021 13:40:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210908100257.17833-7-qiangqing.zhang@nxp.com>
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

On 08.09.21 12:02, Joakim Zhang wrote:
> Remove unused "nvmem_macaddr_swap" property for FEC, there is no info in both
> dt-binding and driver, so it's safe to remove it.
> 
> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>

Reviewed-by: Ahmad Fatoum <a.fatoum@pengutronix.de>

> ---
>  arch/arm64/boot/dts/freescale/imx8mm.dtsi | 1 -
>  arch/arm64/boot/dts/freescale/imx8mn.dtsi | 1 -
>  arch/arm64/boot/dts/freescale/imx8mp.dtsi | 1 -
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 1 -
>  4 files changed, 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> index fb14be932386..2210cfda4e60 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> @@ -948,7 +948,6 @@
>  				fsl,num-rx-queues = <3>;
>  				nvmem-cells = <&fec_mac_address>;
>  				nvmem-cell-names = "mac-address";
> -				nvmem_macaddr_swap;
>  				fsl,stop-mode = <&gpr 0x10 3>;
>  				status = "disabled";
>  			};
> diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> index 0a994e6edc0b..408024426315 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> @@ -951,7 +951,6 @@
>  				fsl,num-rx-queues = <3>;
>  				nvmem-cells = <&fec_mac_address>;
>  				nvmem-cell-names = "mac-address";
> -				nvmem_macaddr_swap;
>  				fsl,stop-mode = <&gpr 0x10 3>;
>  				status = "disabled";
>  			};
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> index 37188ff07f21..cb7867791d05 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> @@ -821,7 +821,6 @@
>  				nvmem-cells = <&eth_mac1>;
>  				nvmem-cell-names = "mac-address";
>  				fsl,stop-mode = <&gpr 0x10 3>;
> -				nvmem_macaddr_swap;
>  				status = "disabled";
>  			};
>  
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> index 1cb211e470ae..dc4e39ef9d39 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> @@ -1191,7 +1191,6 @@
>  				fsl,num-rx-queues = <3>;
>  				nvmem-cells = <&fec_mac_address>;
>  				nvmem-cell-names = "mac-address";
> -				nvmem_macaddr_swap;
>  				fsl,stop-mode = <&iomuxc_gpr 0x10 3>;
>  				status = "disabled";
>  			};
> 


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
