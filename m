Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A74C03F8A6D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 16:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242755AbhHZOvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 10:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232815AbhHZOvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 10:51:08 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB56C061757
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 07:50:20 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1mJGhv-00067q-BV; Thu, 26 Aug 2021 16:50:19 +0200
Subject: Re: [PATCH] ARM: dts: stm32: set the DCMI pins on stm32mp157c-odyssey
To:     Grzegorz Szymaszek <gszymaszek@short.pl>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Marcin Sloniewski <marcin.sloniewski@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
References: <YSepFyt8o+5lAsrA@nx64de-df6d00>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <6e6f91ab-d2b7-69d2-ccfb-6282945e5ab6@pengutronix.de>
Date:   Thu, 26 Aug 2021 16:50:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YSepFyt8o+5lAsrA@nx64de-df6d00>
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

On 26.08.21 16:45, Grzegorz Szymaszek wrote:
> The Seeed Odyssey-STM32MP157C board has a 20-pin DVP camera output. The
> DCMI pins used on this output are defined in the pin state definition
> &pinctrl/dcmi-1, AKA &dcmi_pins_b (added in mainline commit
> 02814a41529a55dbfb9fbb2a3728e78e70646ea6). Set these pins as the default
> pinctrl of the DCMI peripheral in the board device tree.
> 
> The pins are not used for any other purpose, so it seems safe to assume
> most users will not need to override (delete) what this patch provides.
> status defaults to "disabled", so the peripheral will not be
> unnecessarily started. And the users who actually intend to make use of
> a camera on the DVP port will have this little part of the configuration
> ready.
> 
> Signed-off-by: Grzegorz Szymaszek <gszymaszek@short.pl>

Reviewed-by: Ahmad Fatoum <a.fatoum@pengutronix.de>

> ---
>  arch/arm/boot/dts/stm32mp157c-odyssey.dts | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stm32mp157c-odyssey.dts b/arch/arm/boot/dts/stm32mp157c-odyssey.dts
> index be1dd5e9e744..554f5d3bcdc3 100644
> --- a/arch/arm/boot/dts/stm32mp157c-odyssey.dts
> +++ b/arch/arm/boot/dts/stm32mp157c-odyssey.dts
> @@ -22,6 +22,12 @@ chosen {
>  	};
>  };
>  
> +&dcmi {
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&dcmi_pins_b>;
> +	pinctrl-1 = <&dcmi_sleep_pins_b>;
> +};
> +
>  &ethernet0 {
>  	status = "okay";
>  	pinctrl-0 = <&ethernet0_rgmii_pins_a>;
> 


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
