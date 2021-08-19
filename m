Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDE73F1143
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 05:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236042AbhHSDKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 23:10:38 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:42441 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235792AbhHSDKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 23:10:36 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 0A5C2580E1A;
        Wed, 18 Aug 2021 23:10:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 18 Aug 2021 23:10:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm3; bh=9
        i9QMllYeg5+nC6Ll1fSgkfjKdj4Rpn64QXWOUpHZ+Q=; b=WYFNw2VHFiWGgs102
        Ipzg48hTvN/luWkimkLxpWvbPsJecwnsCYT3QbqP/PS1pfdejos53oFDTcSZ5Nh5
        EkwiNktGeBC7X2CNvQ6rNLYaD+I4/+NKgn3pp2YnIv7RLbGtya/frCtGozLzBsbJ
        DqE+Ym/1s95D/KlFc+YTtGeUxKJzwzQ5sgLhWF4Nv7yo3c04vXbcEjGa+Kpm52aX
        nuEiqY63RAJ1FxJudjdBkeZXZr/W52ufe0lSiGQShXxMyb+gOFFTsnnAwtBKAlSR
        XgfjlMi9b0vS078KNFZhzR2Rc9MayCFQlOFGgNJ/bdEQ6s7B4FLtsLj+J72tq+sB
        1Syog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=9i9QMllYeg5+nC6Ll1fSgkfjKdj4Rpn64QXWOUpHZ
        +Q=; b=a7LvSw4shsb1jPcd29eZOILwvGuUw4YvY6fksgnpSW1uv+5gGx6JSfKP2
        BfJsbZNs+EXUB/A0vDLyctANeSMVpt0Uv3nRHwPtg0PD8uZ48YuP9qzmiKxtOD+Q
        EzVpLlt0RO8uWFavXfuXjXCSigLzMr/XNr7dcVAhb/XsOm5bFmGOvE6ORTFM9ikx
        2ovEZTQAEKCTXBk9KgAevhNWsC3BUpv6+vENWt0Hr69ZohZFOEOBlZX2cdpAO9Ev
        Hw5YdrcBrHNxWRbKmjlNngyt5c128hjEuUhXovZ4az+N1t251+OE/XlfxGTj8w5f
        yh8RVgJOuvQxMm3DWGiQbTH0r/8Mw==
X-ME-Sender: <xms:hcsdYV-p2R3XI3IkIGbypFzDxcfi4l9N2AUyBBjF5HN1ptb24mQYTA>
    <xme:hcsdYZuTYhGfOewRPW2jzP0aMBQJx2HWkpQ3P4b45dfTx6B7HghwQdOew7n2shmGp
    Z0IKuZ_5qEI6pyOcg>
X-ME-Received: <xmr:hcsdYTBz2muayp04TfntJrcak4SRfbrOuEqVcjSouTceoQxa1aTFTVPaxStTJ-l5yhRDL9EtTe_BKD34FF70hZREJOzNTclcjKn0nIPCyoErVtAUKzpy3-lnhw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrleeigdeijecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpefgveffteelheffjeeukedvkedviedtheevgeefkeehueeiieeuteeu
    gfettdeggeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:hcsdYZeXo0RJrAz_g8FrremAB3kv4dWqH4yhe_SqSU0ZDb3efnGhBg>
    <xmx:hcsdYaP5UCH-UPJXa2ZroQWTH7utvS43fX_v7Gg-m4lMnfDCz-miqw>
    <xmx:hcsdYblY7ewpcygFqN6o5BfzWbFqpEpyzEh-TNiSwTv0dZEHL5Y2Yg>
    <xmx:iMsdYbkLX9VZuqLoLf39jYUz1IIytyY0KRzFpb32Gg59oMqGqHh2JA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Aug 2021 23:09:56 -0400 (EDT)
Subject: Re: [PATCH 07/17] pinctrl: sunxi: add support for R329 CPUX pin
 controller
To:     Icenowy Zheng <icenowy@sipeed.com>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Andre Przywara <andre.przywara@arm.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20210802062212.73220-1-icenowy@sipeed.com>
 <20210802062212.73220-8-icenowy@sipeed.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <2f6de069-7983-efc2-3c4a-7c1355c4cbc5@sholland.org>
Date:   Wed, 18 Aug 2021 22:09:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20210802062212.73220-8-icenowy@sipeed.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/2/21 1:22 AM, Icenowy Zheng wrote:
> Allwinner R329 SoC has two pin controllers similar to ones on previous
> SoCs, one in CPUX power domain and another in CPUS.
> 
> This patch adds support for the CPUX domain pin controller.
> 
> Signed-off-by: Icenowy Zheng <icenowy@sipeed.com>
> ---
>  drivers/pinctrl/sunxi/Kconfig               |   5 +
>  drivers/pinctrl/sunxi/Makefile              |   1 +
>  drivers/pinctrl/sunxi/pinctrl-sun50i-r329.c | 410 ++++++++++++++++++++
>  3 files changed, 416 insertions(+)
>  create mode 100644 drivers/pinctrl/sunxi/pinctrl-sun50i-r329.c
> 
> diff --git a/drivers/pinctrl/sunxi/Kconfig b/drivers/pinctrl/sunxi/Kconfig
> index 33751a6a0757..c662e8b1b351 100644
> --- a/drivers/pinctrl/sunxi/Kconfig
> +++ b/drivers/pinctrl/sunxi/Kconfig
> @@ -129,4 +129,9 @@ config PINCTRL_SUN50I_H616_R
>  	default ARM64 && ARCH_SUNXI
>  	select PINCTRL_SUNXI
>  
> +config PINCTRL_SUN50I_R329
> +	bool "Support for the Allwinner R329 PIO"
> +	default ARM64 && ARCH_SUNXI
> +	select PINCTRL_SUNXI
> +
>  endif
> diff --git a/drivers/pinctrl/sunxi/Makefile b/drivers/pinctrl/sunxi/Makefile
> index d3440c42b9d6..e33f7c5f1ff9 100644
> --- a/drivers/pinctrl/sunxi/Makefile
> +++ b/drivers/pinctrl/sunxi/Makefile
> @@ -25,5 +25,6 @@ obj-$(CONFIG_PINCTRL_SUN50I_H6)		+= pinctrl-sun50i-h6.o
>  obj-$(CONFIG_PINCTRL_SUN50I_H6_R)	+= pinctrl-sun50i-h6-r.o
>  obj-$(CONFIG_PINCTRL_SUN50I_H616)	+= pinctrl-sun50i-h616.o
>  obj-$(CONFIG_PINCTRL_SUN50I_H616_R)	+= pinctrl-sun50i-h616-r.o
> +obj-$(CONFIG_PINCTRL_SUN50I_R329)	+= pinctrl-sun50i-r329.o
>  obj-$(CONFIG_PINCTRL_SUN9I_A80)		+= pinctrl-sun9i-a80.o
>  obj-$(CONFIG_PINCTRL_SUN9I_A80_R)	+= pinctrl-sun9i-a80-r.o
> diff --git a/drivers/pinctrl/sunxi/pinctrl-sun50i-r329.c b/drivers/pinctrl/sunxi/pinctrl-sun50i-r329.c
> new file mode 100644
> index 000000000000..742f437ec0b6
> --- /dev/null
> +++ b/drivers/pinctrl/sunxi/pinctrl-sun50i-r329.c
> @@ -0,0 +1,410 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Allwinner R329 SoC pinctrl driver.
> + *
> + * Copyright (C) 2021 Sipeed
> + * based on the H616 pinctrl driver
> + *   Copyright (C) 2020 Arm Ltd.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/pinctrl/pinctrl.h>
> +
> +#include "pinctrl-sunxi.h"
> +
> +static const struct sunxi_desc_pin r329_pins[] = {
> +	/* Hole */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 0),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "uart2"),		/* TX */
> +		  SUNXI_FUNCTION(0x3, "pwm"),		/* PWM0 */
> +		  SUNXI_FUNCTION(0x4, "jtag"),		/* MS */
> +		  SUNXI_FUNCTION(0x5, "ledc"),		/* DO */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 0)),	/* PB_EINT0 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 1),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "uart2"),		/* RX */
> +		  SUNXI_FUNCTION(0x3, "pwm"),		/* PWM1 */
> +		  SUNXI_FUNCTION(0x4, "jtag"),		/* CK */
> +		  SUNXI_FUNCTION(0x5, "i2s0"),		/* MCLK */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 1)),	/* PB_EINT1 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 2),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "uart2"),		/* RTS */
> +		  SUNXI_FUNCTION(0x3, "pwm"),		/* PWM2 */
> +		  SUNXI_FUNCTION(0x4, "jtag"),		/* DO */
> +		  SUNXI_FUNCTION(0x5, "i2s0"),		/* LRCK */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 2)),	/* PB_EINT2 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 3),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "uart2"),		/* CTS */
> +		  SUNXI_FUNCTION(0x3, "pwm"),		/* PWM3 */
> +		  SUNXI_FUNCTION(0x4, "jtag"),		/* DI */
> +		  SUNXI_FUNCTION(0x5, "i2s0"),		/* BCLK */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 3)),	/* PB_EINT3 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 4),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "uart0"),		/* TX */
> +		  SUNXI_FUNCTION(0x3, "pwm"),		/* PWM4 */
> +		  SUNXI_FUNCTION(0x4, "i2s0_dout0"),
> +		  SUNXI_FUNCTION(0x5, "i2s0_din1"),
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 4)),	/* PB_EINT4 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 5),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "uart0"),		/* RX */
> +		  SUNXI_FUNCTION(0x3, "pwm"),		/* PWM5 */
> +		  SUNXI_FUNCTION(0x4, "i2s0_dout1"),
> +		  SUNXI_FUNCTION(0x5, "i2s0_din0"),
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 5)),	/* PB_EINT5 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 6),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "ir"),		/* RX */
> +		  SUNXI_FUNCTION(0x3, "pwm"),		/* PWM6 */
> +		  SUNXI_FUNCTION(0x4, "i2s0"),		/* DOUT2 */
> +		  SUNXI_FUNCTION(0x5, "i2c0"),		/* SCK */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 6)),	/* PB_EINT6 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 7),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "ir"),		/* TX */
> +		  SUNXI_FUNCTION(0x3, "pwm"),		/* PWM7 */
> +		  SUNXI_FUNCTION(0x4, "i2s0"),		/* DOUT3 */
> +		  SUNXI_FUNCTION(0x5, "i2c0"),		/* SDA */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 7)),	/* PB_EINT7 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 8),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "ir_tx"),
> +		  SUNXI_FUNCTION(0x3, "pwm"),		/* PWM8 */
> +		  SUNXI_FUNCTION(0x4, "ir_rx"),
> +		  SUNXI_FUNCTION(0x5, "ledc"),		/* DO */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 8)),	/* PB_EINT8 */
> +	/* Hole */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 0),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "nand0"),		/* RB0 */
> +		  SUNXI_FUNCTION(0x3, "mmc0"),		/* CLK */
> +		  SUNXI_FUNCTION(0x4, "spi0")),		/* CS */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 1),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "nand0"),		/* RE */
> +		  SUNXI_FUNCTION(0x3, "mmc0"),		/* CMD */
> +		  SUNXI_FUNCTION(0x4, "spi0")),		/* MISO */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 2),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "nand0"),		/* CE0 */
> +		  SUNXI_FUNCTION(0x3, "mmc0"),		/* D2 */
> +		  SUNXI_FUNCTION(0x4, "spi0")),		/* WP */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 3),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "nand0"),		/* CLE */
> +		  SUNXI_FUNCTION(0x3, "mmc0"),		/* D1 */
> +		  SUNXI_FUNCTION(0x4, "spi0")),		/* MOSI */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 4),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "nand0"),		/* ALE */
> +		  SUNXI_FUNCTION(0x3, "mmc0"),		/* D0 */
> +		  SUNXI_FUNCTION(0x4, "spi0")),		/* CLK */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 5),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "nand0"),		/* WE */
> +		  SUNXI_FUNCTION(0x3, "mmc0"),		/* D3 */
> +		  SUNXI_FUNCTION(0x4, "spi0")),		/* HOLD */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 6),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "nand0"),		/* DQ0 */
> +		  SUNXI_FUNCTION(0x3, "mmc0")),		/* RST */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 7),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "nand0"),		/* DQ1 */
> +		  SUNXI_FUNCTION(0x5, "boot_sel")),
> +	/* Hole */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(F, 0),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "nand"),		/* DQ7 */

Please be consistent between "nand" and "nand0". "nand0" looks like it is much
more common.

> +		  SUNXI_FUNCTION(0x3, "sim0"),		/* VPPEN */
> +		  SUNXI_FUNCTION(0x4, "jtag"),		/* MS */
> +		  SUNXI_FUNCTION(0x5, "mmc0"),		/* D1 */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 0)),	/* PF_EINT0 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(F, 1),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "nand"),		/* DQ6 */
> +		  SUNXI_FUNCTION(0x3, "sim0"),		/* VPPPP */
> +		  SUNXI_FUNCTION(0x4, "jtag"),		/* DI */
> +		  SUNXI_FUNCTION(0x5, "mmc0"),		/* D0 */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 1)),	/* PF_EINT1 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(F, 2),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "nand"),		/* DQ5 */
> +		  SUNXI_FUNCTION(0x3, "sim0"),		/* PWREN */
> +		  SUNXI_FUNCTION(0x4, "uart"),		/* TX */

Should be "uart0".

> +		  SUNXI_FUNCTION(0x5, "mmc0"),		/* CLK */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 2)),	/* PF_EINT2 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(F, 3),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "nand"),		/* DQ4 */
> +		  SUNXI_FUNCTION(0x3, "sim0"),		/* CLK */
> +		  SUNXI_FUNCTION(0x4, "jtag"),		/* DO */
> +		  SUNXI_FUNCTION(0x5, "mmc0"),		/* CMD */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 3)),	/* PF_EINT3 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(F, 4),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "nand"),		/* DQS */
> +		  SUNXI_FUNCTION(0x3, "sim0"),		/* DATA */
> +		  SUNXI_FUNCTION(0x4, "uart"),		/* RX */

"uart0" here as well.

> +		  SUNXI_FUNCTION(0x5, "mmc0"),		/* D3 */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 4)),	/* PF_EINT4 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(F, 5),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "nand"),		/* DQ2 */
> +		  SUNXI_FUNCTION(0x3, "sim0"),		/* RST */
> +		  SUNXI_FUNCTION(0x4, "jtag"),		/* CK */
> +		  SUNXI_FUNCTION(0x5, "mmc0"),		/* D2 */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 5)),	/* PF_EINT5 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(F, 6),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "nand"),		/* DQ1 */
> +		  SUNXI_FUNCTION(0x3, "sim0"),		/* DET */
> +		  SUNXI_FUNCTION(0x4, "spdif_in"),
> +		  SUNXI_FUNCTION(0x5, "spdif_out"),
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 6)),	/* PF_EINT6 */
> +	/* Hole */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 0),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "mmc1_clk"),
> +		  SUNXI_FUNCTION(0x3, "mmc1_d2"),
> +		  /* 0x4 is also mmc1_d2 */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 0)),	/* PG_EINT0 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 1),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "mmc1_cmd"),
> +		  SUNXI_FUNCTION(0x3, "mmc1_d3"),
> +		  SUNXI_FUNCTION(0x4, "mmc1_clk"),
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 1)),	/* PG_EINT1 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 2),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "mmc1_d0"),
> +		  SUNXI_FUNCTION(0x3, "mmc1_cmd"),
> +		  SUNXI_FUNCTION(0x4, "mmc1_d3"),

Missing function 5 "pll".

> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 2)),	/* PG_EINT2 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 3),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "mmc1_d1"),
> +		  SUNXI_FUNCTION(0x3, "mmc1_clk"),
> +		  /* 0x4 is also mmc1_d1 */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 3)),	/* PG_EINT3 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 4),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "mmc1_d2"),
> +		  SUNXI_FUNCTION(0x3, "mmc1_d0"),
> +		  /* 0x4 is also mmc1_d0 */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 4)),	/* PG_EINT4 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 5),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "mmc1_d3"),
> +		  SUNXI_FUNCTION(0x3, "mmc1_d1"),
> +		  SUNXI_FUNCTION(0x4, "mmc1_cmd"),
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 5)),	/* PG_EINT5 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 6),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "uart1"),		/* TX */
> +		  SUNXI_FUNCTION(0x3, "i2c0"),		/* SCK */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 6)),	/* PG_EINT6 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 7),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "uart1"),		/* RX */
> +		  SUNXI_FUNCTION(0x3, "i2c0"),		/* SDA */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 7)),	/* PG_EINT7 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 8),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "uart1"),		/* RTS */
> +		  SUNXI_FUNCTION(0x3, "i2c1"),		/* SCK */
> +		  SUNXI_FUNCTION(0x5, "spi1"),		/* HOLD/DBI-DCX/DBI-WRX */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 8)),	/* PG_EINT8 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 9),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "uart1"),		/* CTS */
> +		  SUNXI_FUNCTION(0x3, "i2c1"),		/* SDA */
> +		  SUNXI_FUNCTION(0x5, "spi1"),		/* WP/DBI-TE */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 9)),	/* PG_EINT9 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 10),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x3, "i2s1"),		/* MCLK */
> +		  SUNXI_FUNCTION(0x3, "ledc"),		/* DO */

Should be function 4.

> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 10)),	/* PG_EINT10 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 11),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "uart3"),		/* TX */
> +		  SUNXI_FUNCTION(0x3, "i2s1"),		/* LRCK */
> +		  SUNXI_FUNCTION(0x5, "spi1"),		/* CS/DBI-CSX */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 11)),	/* PG_EINT11 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 12),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "uart3"),		/* RX */
> +		  SUNXI_FUNCTION(0x3, "i2s1"),		/* BCLK */
> +		  SUNXI_FUNCTION(0x5, "spi1"),		/* CLK/DBI-SCLK */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 12)),	/* PG_EINT12 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 13),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "uart3"),		/* RTS */
> +		  SUNXI_FUNCTION(0x3, "i2s1_dout0"),
> +		  SUNXI_FUNCTION(0x4, "i2s1_din1"),
> +		  SUNXI_FUNCTION(0x5, "spi1"),		/* MOSI/DBI-SDO */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 13)),	/* PG_EINT13 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 14),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "uart3"),		/* CTS */
> +		  SUNXI_FUNCTION(0x3, "i2s1_dout1"),
> +		  SUNXI_FUNCTION(0x4, "i2s1_din0"),
> +		  SUNXI_FUNCTION(0x5, "spi1"),		/* MISO/DBI-SDI/DBI-TE/DBI-DCX */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 14)),	/* PG_EINT14 */
> +	/* Hole */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 0),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "i2c0"),		/* SCK */
> +		  SUNXI_FUNCTION(0x3, "uart0"),		/* TX */
> +		  SUNXI_FUNCTION(0x4, "spi1"),		/* CS/DBI-CSX */
> +		  SUNXI_FUNCTION(0x5, "pwm"),		/* PWM0 */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 0)),	/* PH_EINT0 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 1),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "i2c0"),		/* SDA */
> +		  SUNXI_FUNCTION(0x3, "uart0"),		/* RX */
> +		  SUNXI_FUNCTION(0x4, "spi1"),		/* CLK/DBI-SCLK */
> +		  SUNXI_FUNCTION(0x5, "pwm"),		/* PWM1 */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 1)),	/* PH_EINT1 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 2),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "i2c1"),		/* SCK */
> +		  SUNXI_FUNCTION(0x3, "ledc"),		/* DO */
> +		  SUNXI_FUNCTION(0x4, "spi1"),		/* MOSI/DBI-SDO */
> +		  SUNXI_FUNCTION(0x5, "ir"),		/* RX */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 2)),	/* PH_EINT2 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 3),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "i2c1"),		/* SDA */
> +		  SUNXI_FUNCTION(0x3, "spdif"),		/* OUT */
> +		  SUNXI_FUNCTION(0x4, "spi1"),		/* MISO/DBI-SDI/DBI-TE/DBI-DCX */
> +		  SUNXI_FUNCTION(0x5, "ir"),		/* TX */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 3)),	/* PH_EINT3 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 4),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "uart3"),		/* TX */
> +		  SUNXI_FUNCTION(0x3, "spi1_cs"),	/* CS/DBI-CSX */
> +		  SUNXI_FUNCTION(0x4, "spi1_hold"),	/* HOLD/DBI-DCX/DBI-WRX */
> +		  SUNXI_FUNCTION(0x5, "pwm"),		/* PWM2 */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 4)),	/* PH_EINT4 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 5),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "uart3"),		/* RX */
> +		  SUNXI_FUNCTION(0x3, "spi1_clk"),	/* CLK/DBI-SCLK */
> +		  SUNXI_FUNCTION(0x4, "spi1_wp"),	/* WP/DBI-TE */
> +		  SUNXI_FUNCTION(0x5, "pwm"),		/* PWM3 */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 5)),	/* PH_EINT5 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 6),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "uart3"),		/* RTS */
> +		  SUNXI_FUNCTION(0x3, "spi1"),		/* MOSI/SPI-DBO */
> +		  SUNXI_FUNCTION(0x4, "i2c0"),		/* SCK */
> +		  SUNXI_FUNCTION(0x5, "pwm"),		/* PWM4 */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 6)),	/* PH_EINT6 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 7),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "uart3"),		/* CTS */
> +		  SUNXI_FUNCTION(0x3, "spi1"),		/* MISO/DBI-SDI/DBI-TE/DBI-DCX */
> +		  SUNXI_FUNCTION(0x4, "i2c0"),		/* SDA */
> +		  SUNXI_FUNCTION(0x5, "pwm"),		/* PWM5 */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 7)),	/* PH_EINT7 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 8),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "i2c1"),		/* SDA */
> +		  SUNXI_FUNCTION(0x3, "spi1"),		/* WP/DBI-TE */
> +		  SUNXI_FUNCTION(0x4, "ledc"),		/* DO */
> +		  SUNXI_FUNCTION(0x5, "ir"),		/* TX */

You have PH8 and PH9 functions 2 through 5 swapped.

And I won't be surprised if I missed something too :)

Regards,
Samuel

> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 8)),	/* PH_EINT8 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 9),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "i2c1"),		/* SCK */
> +		  SUNXI_FUNCTION(0x3, "spi1"),		/* HOLD/DBI-DCX/DBI-WRX */
> +		  SUNXI_FUNCTION(0x4, "spdif"),		/* IN */
> +		  SUNXI_FUNCTION(0x5, "ir"),		/* RX */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 9)),	/* PH_EINT9 */
> +};
> +static const unsigned int r329_irq_bank_map[] = { 1, 5, 6, 7 };
> +
> +static const struct sunxi_pinctrl_desc r329_pinctrl_data = {
> +	.pins = r329_pins,
> +	.npins = ARRAY_SIZE(r329_pins),
> +	.irq_banks = ARRAY_SIZE(r329_irq_bank_map),
> +	.irq_bank_map = r329_irq_bank_map,
> +	.io_bias_cfg_variant = BIAS_VOLTAGE_PIO_POW_MODE_SEL,
> +};
> +
> +static int r329_pinctrl_probe(struct platform_device *pdev)
> +{
> +	return sunxi_pinctrl_init(pdev, &r329_pinctrl_data);
> +}
> +
> +static const struct of_device_id r329_pinctrl_match[] = {
> +	{ .compatible = "allwinner,sun50i-r329-pinctrl", },
> +	{}
> +};
> +
> +static struct platform_driver r329_pinctrl_driver = {
> +	.probe	= r329_pinctrl_probe,
> +	.driver	= {
> +		.name		= "sun50i-r329-pinctrl",
> +		.of_match_table	= r329_pinctrl_match,
> +	},
> +};
> +builtin_platform_driver(r329_pinctrl_driver);
> 

