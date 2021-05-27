Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC5B393730
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 22:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236127AbhE0UcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 16:32:24 -0400
Received: from mx01.ayax.eu ([188.137.98.110]:53964 "EHLO mx01.ayax.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235539AbhE0UcV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 16:32:21 -0400
X-Greylist: delayed 1861 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 May 2021 16:32:19 EDT
Received: from [192.168.192.146] (port=36442 helo=nx64de-df6d00)
        by mx01.ayax.eu with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gszymaszek@short.pl>)
        id 1lmMAD-0006Ov-L5; Thu, 27 May 2021 21:59:29 +0200
Date:   Thu, 27 May 2021 21:59:28 +0200
From:   Grzegorz Szymaszek <gszymaszek@short.pl>
Cc:     Grzegorz Szymaszek <gszymaszek@short.pl>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Marcin =?utf-8?Q?S=C5=82oniewski?= <marcin.sloniewski@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH] ARM: dts: stm32: fix stm32mp157c-odyssey card detect pin
Message-ID: <YK/6IHCBdIU3UBqs@nx64de-df6d00>
References: <YHH9+Xrn5Quge4Jt@nx64de-df6d00>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YHH9+Xrn5Quge4Jt@nx64de-df6d00>
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 10, 2021 at 09:35:21PM +0200, Grzegorz Szymaszek wrote:
> The microSD card detect pin is physically connected to the MPU pin PI3.
> The Device Tree configuration of the card detect pin was wrong—it was
> set to pin PB7 instead. If such configuration was used, the kernel would
> hang on “Waiting for root device” when booting from a microSD card.
> 
> Signed-off-by: Grzegorz Szymaszek <gszymaszek@short.pl>
> ---
>  arch/arm/boot/dts/stm32mp157c-odyssey.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/stm32mp157c-odyssey.dts b/arch/arm/boot/dts/stm32mp157c-odyssey.dts
> index a7ffec8f1516..be1dd5e9e744 100644
> --- a/arch/arm/boot/dts/stm32mp157c-odyssey.dts
> +++ b/arch/arm/boot/dts/stm32mp157c-odyssey.dts
> @@ -64,7 +64,7 @@ &sdmmc1 {
>  	pinctrl-0 = <&sdmmc1_b4_pins_a>;
>  	pinctrl-1 = <&sdmmc1_b4_od_pins_a>;
>  	pinctrl-2 = <&sdmmc1_b4_sleep_pins_a>;
> -	cd-gpios = <&gpiob 7 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
> +	cd-gpios = <&gpioi 3 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
>  	disable-wp;
>  	st,neg-edge;
>  	bus-width = <4>;
> -- 
> 2.30.2
> 

A gentle ping. FWIW, there was another patch that would deal with the
same issue:
<https://st-md-mailman.stormreply.com/pipermail/linux-stm32/2021-April/011132.html>,
but it took the more radical approach of of replacing cd-gpios with
broken-cd.

-- 
Grzegorz
