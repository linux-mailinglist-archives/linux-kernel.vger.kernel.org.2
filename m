Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 129A6458186
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 03:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236865AbhKUCgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 21:36:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:40810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236578AbhKUCgJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 21:36:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B9E99603E5;
        Sun, 21 Nov 2021 02:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637461985;
        bh=1vJkUHmxjXjLq+QS2nKtQb+a1e39GkVQQpl+uQJLPyc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FPzj7A0ssEJN1IVQsrt4+UxkwucUOsK/nj6SsOtpUJoCgumPCFC/JE6uWUvx8g9mV
         6cvP/2ucBnkdTEmjzrTqjpxo9v8m8D0ctefrFn5eW7XjcUeAWz8yQuj9y5uvYzAxpO
         HHSJjoEaz0fNXJ0OAqnjx/N4Tk+8fA++mh03X7pXz9QKGf57G78QPMLLvlZI0ZbVm6
         ii+AQ0L/jSuCODsc3fhh56geS1281nQhy/e7JnJS5my1vAm1MAx8p48YJ/+3Zm3OZA
         g9b0vLhjN2cMtt8Ok/PnSZGPn4yZk5zF1XzkLsPJxBYOEE3mz0oqJWAB7MKPbnHvhx
         ZMw4ot4XWwNIQ==
Date:   Sun, 21 Nov 2021 10:32:58 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Heiko Thiery <heiko.thiery@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Michael Walle <michael@walle.cc>
Subject: Re: [PATCH] arm64: dts: fsl: imx8mq-kontron-pitx-imx8m: get rid of
 unneeded off-on-delay-us
Message-ID: <20211121023258.GG31998@dragon>
References: <20211020054842.10246-1-heiko.thiery@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020054842.10246-1-heiko.thiery@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2021 at 07:48:43AM +0200, Heiko Thiery wrote:
> The default delay value for power cycle the sd card is 1ms. Since this is
> sufficient we can remove this value here.
> 
> Fixes: 5dbadc848259 ("arm64: dts: fsl: add support for Kontron pitx-imx8m board")

This is more like a small cleanup/optimization than a fix to me.

Shawn

> Signed-off-by: Heiko Thiery <heiko.thiery@gmail.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dts | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dts b/arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dts
> index f593e4ff62e1..e4429a1c874d 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dts
> @@ -51,7 +51,6 @@ reg_usdhc2_vmmc: regulator-usdhc2-vmmc {
>  		regulator-min-microvolt = <3300000>;
>  		regulator-max-microvolt = <3300000>;
>  		gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
> -		off-on-delay-us = <20000>;
>  		enable-active-high;
>  	};
>  };
> -- 
> 2.30.2
> 
