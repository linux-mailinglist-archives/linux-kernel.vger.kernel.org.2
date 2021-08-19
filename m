Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFC013F1186
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 05:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235806AbhHSDXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 23:23:31 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:56263 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230424AbhHSDX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 23:23:28 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 64445580E09;
        Wed, 18 Aug 2021 23:22:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 18 Aug 2021 23:22:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm3; bh=J
        0hKvQPS8dExpxRPdMBJPpKCELXT/DpiSuWLnUrwnKk=; b=XmDbbMMi0IPdHkIga
        /Dr8Tcd3+4kKG99+hsVFpZ8PWkmKP7DRNGI5dYUHBL7geWxnR5eqtQQCk70p+lcI
        kYxoJKhIGg4qFXAMqVLpIRfMHpyBO1QGSBaVJEiBensGTSGrF6Lgqsh2sgL7fosk
        sCT4n5+3donYmJJUbihq5V58gqOXigNjdmwXo9SCH6FuVSs9ganQASdjl8ubk5mq
        FWm9c3tTNwejfXAryN/vLWsc7FTh3nCbShvd8kzMhaUrCeGCLCcb8yzjLSpmPY9Q
        xafPqIPPqI+jU2Lp5e0ka4iNH9jBwyT6f7lM5gz33tFY63pxE7N7u+yuoPqS0t/0
        b3l3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=J0hKvQPS8dExpxRPdMBJPpKCELXT/DpiSuWLnUrwn
        Kk=; b=ngovGQUngFRyRuClX8be3K6k1jC+4uCvbnmVt54Wfz/yB+pA/HPNQsYqu
        2lp+npdjHgOyoy/smMOFrZsyKXw1JEnV1ZnmXelrh6siqyYX6IujJErtRUNcm4zo
        9di1i9pxHWaZKLdp7cbL+Y0ynvNIzr0oZgOkzVlRx31gtxZ2xtJDti8ZvY7zb8ju
        SgtaQOIyUw+FoRJftCJWQtVqDVPCFcExVxZWLNfkJ6w1EjxRjt8xRR73w28hgMZ0
        GT05EC3zUU1S72cLGcMXx1aHMXEt/9ISfET3RCnwr1u0vedcHqI90Kv4B6LpEHCP
        yDom5UmUlVj35Ru58naO43kz0T7gw==
X-ME-Sender: <xms:ic4dYctXnVyGbbCuoZnLILjFa_1O61BSBqU3sg-PVTmaAXIMG2kn1g>
    <xme:ic4dYZff-AwFXcLnXGaNvZY5n_tdOSUrIAH1uf3EORrlyRkaCEqEEicwdrgclM1vF
    daSp4z9HP1WiMQr_Q>
X-ME-Received: <xmr:ic4dYXw1bSdCgFIonTgyW2oF58c1yQFSdQ7rXJzvK0CHjleQ_8NDBfL23D5LpgcQ31I2BIRhT9JgkZBjr4Y1GqcKdom903OWNzeWY4ZEU5Cc8SWnTTOIqN68wg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrleeigdeilecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpefgveffteelheffjeeukedvkedviedtheevgeefkeehueeiieeuteeu
    gfettdeggeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:ic4dYfOZwAIZHuHzXbSDJVFZWdzuj9Dv92M-pViBEwG4HW-nW0c5qA>
    <xmx:ic4dYc-imRgA87x1MS9NpA0kECZNEi0LTntWvJXK-Xkddonkzgq0Cg>
    <xmx:ic4dYXXoaptD7lpuOOrSE9Ea07w-sS8iJ-E681liFt8Ez0LTPEv2_Q>
    <xmx:jM4dYXUCkL91RXkzfsOzSzKbtB5HL_UkD2_FuHZ4LJ0Px1ecDEY1Kw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Aug 2021 23:22:49 -0400 (EDT)
Subject: Re: [PATCH 08/17] pinctrl: sunxi: add support for R329 R-PIO pin
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
 <20210802062212.73220-9-icenowy@sipeed.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <e9937a23-8a8a-ebec-0a44-0d15a06b7e89@sholland.org>
Date:   Wed, 18 Aug 2021 22:22:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20210802062212.73220-9-icenowy@sipeed.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/2/21 1:22 AM, Icenowy Zheng wrote:
> Allwinner R320 SoC has a pin controller in the CPUS power domain.
> 
> Add support for it.
> 
> Signed-off-by: Icenowy Zheng <icenowy@sipeed.com>
> ---
>  drivers/pinctrl/sunxi/Kconfig                 |   5 +
>  drivers/pinctrl/sunxi/Makefile                |   1 +
>  drivers/pinctrl/sunxi/pinctrl-sun50i-r329-r.c | 292 ++++++++++++++++++
>  3 files changed, 298 insertions(+)
>  create mode 100644 drivers/pinctrl/sunxi/pinctrl-sun50i-r329-r.c
> 
> diff --git a/drivers/pinctrl/sunxi/Kconfig b/drivers/pinctrl/sunxi/Kconfig
> index c662e8b1b351..abd60ff8daec 100644
> --- a/drivers/pinctrl/sunxi/Kconfig
> +++ b/drivers/pinctrl/sunxi/Kconfig
> @@ -134,4 +134,9 @@ config PINCTRL_SUN50I_R329
>  	default ARM64 && ARCH_SUNXI
>  	select PINCTRL_SUNXI
>  
> +config PINCTRL_SUN50I_R329_R
> +	bool "Support for the Allwinner R329 R-PIO"
> +	default ARM64 && ARCH_SUNXI
> +	select PINCTRL_SUNXI
> +
>  endif
> diff --git a/drivers/pinctrl/sunxi/Makefile b/drivers/pinctrl/sunxi/Makefile
> index e33f7c5f1ff9..245840a7959e 100644
> --- a/drivers/pinctrl/sunxi/Makefile
> +++ b/drivers/pinctrl/sunxi/Makefile
> @@ -26,5 +26,6 @@ obj-$(CONFIG_PINCTRL_SUN50I_H6_R)	+= pinctrl-sun50i-h6-r.o
>  obj-$(CONFIG_PINCTRL_SUN50I_H616)	+= pinctrl-sun50i-h616.o
>  obj-$(CONFIG_PINCTRL_SUN50I_H616_R)	+= pinctrl-sun50i-h616-r.o
>  obj-$(CONFIG_PINCTRL_SUN50I_R329)	+= pinctrl-sun50i-r329.o
> +obj-$(CONFIG_PINCTRL_SUN50I_R329_R)	+= pinctrl-sun50i-r329-r.o
>  obj-$(CONFIG_PINCTRL_SUN9I_A80)		+= pinctrl-sun9i-a80.o
>  obj-$(CONFIG_PINCTRL_SUN9I_A80_R)	+= pinctrl-sun9i-a80-r.o
> diff --git a/drivers/pinctrl/sunxi/pinctrl-sun50i-r329-r.c b/drivers/pinctrl/sunxi/pinctrl-sun50i-r329-r.c
> new file mode 100644
> index 000000000000..dc4792c685ba
> --- /dev/null
> +++ b/drivers/pinctrl/sunxi/pinctrl-sun50i-r329-r.c
> @@ -0,0 +1,292 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Allwinner H616 R_PIO pin controller driver

This needs to be updated.

> + *
> + * Copyright (C) 2020 Arm Ltd.
> + * Based on former work, which is:
> + *   Copyright (C) 2017 Icenowy Zheng <icenowy@aosc.io>
> + */
> +
> +#include <linux/init.h>
> +#include <linux/platform_device.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/pinctrl/pinctrl.h>
> +#include <linux/reset.h>
> +
> +#include "pinctrl-sunxi.h"
> +
> +static const struct sunxi_desc_pin sun50i_r329_r_pins[] = {
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(L, 0),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "s_i2s"),		/* LRCK */

"s_i2s0" for these would match existing drivers (and the manual).

Everything else matches the manual.

Regards,
Samuel
