Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 824CB4147FA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 13:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235785AbhIVLlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 07:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235596AbhIVLlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 07:41:35 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F2EC061756
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 04:40:05 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1mT0bb-0006ak-Qj; Wed, 22 Sep 2021 13:40:03 +0200
Subject: Re: [PATCH 5/6] arm64: dts: imx8mm: add "cell-type" property for
 mac-address
To:     Joakim Zhang <qiangqing.zhang@nxp.com>,
        srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        shawnguo@kernel.org
Cc:     devicetree@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org
References: <20210908100257.17833-1-qiangqing.zhang@nxp.com>
 <20210908100257.17833-6-qiangqing.zhang@nxp.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <d24cdd9f-9498-fd3a-7650-91756a8c2227@pengutronix.de>
Date:   Wed, 22 Sep 2021 13:40:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210908100257.17833-6-qiangqing.zhang@nxp.com>
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
> Add "cell-type" property for mac-address nvmem cell to supporting mac
> address reverse byte.

s/imx8mm/imx8m/ in commit message title.
Do you intend to do this for older i.MX as well?

> 
> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mm.dtsi | 2 ++
>  arch/arm64/boot/dts/freescale/imx8mn.dtsi | 2 ++
>  arch/arm64/boot/dts/freescale/imx8mp.dtsi | 9 +++++++++
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 2 ++
>  4 files changed, 15 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> index e7648c3b8390..fb14be932386 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> @@ -7,6 +7,7 @@
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/input/input.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/nvmem/nvmem.h>
>  #include <dt-bindings/thermal/thermal.h>
>  
>  #include "imx8mm-pinfunc.h"
> @@ -539,6 +540,7 @@
>  
>  				fec_mac_address: mac-address@90 {
>  					reg = <0x90 6>;
> +					cell-type = <NVMEM_CELL_TYPE_MAC_ADDRESS>;
>  				};
>  			};
>  
> diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> index d4231e061403..0a994e6edc0b 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> @@ -7,6 +7,7 @@
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/input/input.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/nvmem/nvmem.h>
>  #include <dt-bindings/thermal/thermal.h>
>  
>  #include "imx8mn-pinfunc.h"
> @@ -544,6 +545,7 @@
>  
>  				fec_mac_address: mac-address@90 {
>  					reg = <0x90 6>;
> +					cell-type = <NVMEM_CELL_TYPE_MAC_ADDRESS>;
>  				};
>  			};
>  
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> index 9f7c7f587d38..37188ff07f21 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> @@ -7,6 +7,7 @@
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/input/input.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/nvmem/nvmem.h>
>  #include <dt-bindings/thermal/thermal.h>
>  
>  #include "imx8mp-pinfunc.h"
> @@ -358,6 +359,12 @@
>  
>  				eth_mac1: mac-address@90 {
>  					reg = <0x90 6>;
> +					cell-type = <NVMEM_CELL_TYPE_MAC_ADDRESS>;
> +				};
> +
> +				eth_mac2: mac-address@96 {
> +					reg = <0x96 6>;
> +					cell-type = <NVMEM_CELL_TYPE_MAC_ADDRESS>;
>  				};
>  			};
>  
> @@ -836,6 +843,8 @@
>  							 <&clk IMX8MP_SYS_PLL2_100M>,
>  							 <&clk IMX8MP_SYS_PLL2_125M>;
>  				assigned-clock-rates = <0>, <100000000>, <125000000>;
> +				nvmem-cells = <&eth_mac2>;
> +				nvmem-cell-names = "mac-address";
>  				intf_mode = <&gpr 0x4>;
>  				status = "disabled";
>  			};
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> index 91df9c5350ae..1cb211e470ae 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> @@ -10,6 +10,7 @@
>  #include <dt-bindings/gpio/gpio.h>
>  #include "dt-bindings/input/input.h"
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/nvmem/nvmem.h>
>  #include <dt-bindings/thermal/thermal.h>
>  #include <dt-bindings/interconnect/imx8mq.h>
>  #include "imx8mq-pinfunc.h"
> @@ -570,6 +571,7 @@
>  
>  				fec_mac_address: mac-address@90 {
>  					reg = <0x90 6>;
> +					cell-type = <NVMEM_CELL_TYPE_MAC_ADDRESS>;
>  				};
>  			};
>  
> 


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
