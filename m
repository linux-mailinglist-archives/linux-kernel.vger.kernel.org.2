Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0BAD4597C6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 23:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233691AbhKVWlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 17:41:09 -0500
Received: from sibelius.xs4all.nl ([83.163.83.176]:56015 "EHLO
        sibelius.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbhKVWlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 17:41:08 -0500
Received: from localhost (bloch.sibelius.xs4all.nl [local])
        by bloch.sibelius.xs4all.nl (OpenSMTPD) with ESMTPA id 3af5fc62;
        Mon, 22 Nov 2021 23:37:59 +0100 (CET)
Date:   Mon, 22 Nov 2021 23:37:59 +0100 (CET)
From:   Mark Kettenis <mark.kettenis@xs4all.nl>
To:     Janne Grunau <j@jannau.net>
Cc:     marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io,
        robh+dt@kernel.org, linus.walleij@linaro.org, maz@kernel.org,
        kettenis@openbsd.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211122222440.21177-4-j@jannau.net> (message from Janne Grunau
        on Mon, 22 Nov 2021 23:24:40 +0100)
Subject: Re: [PATCH v2 3/3] arm64: dts: apple: add #interrupt-cells property to pinctrl nodes
References: <20211122222440.21177-1-j@jannau.net> <20211122222440.21177-4-j@jannau.net>
Message-ID: <d3caf40ce7b7b5ee@bloch.sibelius.xs4all.nl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Janne Grunau <j@jannau.net>
> Date: Mon, 22 Nov 2021 23:24:40 +0100
> 
> Required for devices trying to use pinctrl devices as interrupt
> controller.
> 
> Fixes: 0a8282b83119 ("arm64: apple: Add pinctrl nodes")
> Signed-off-by: Janne Grunau <j@jannau.net>
> Cc: Mark Kettenis <kettenis@openbsd.org>
> Reviewed-by: Sven Peter <sven@svenpeter.dev>

Reviewed-by: Mark Kettenis <kettenis@openbsd.org>

> ---
>  arch/arm64/boot/dts/apple/t8103.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/apple/t8103.dtsi b/arch/arm64/boot/dts/apple/t8103.dtsi
> index fc8b2bb06ffe..c320c8baeb41 100644
> --- a/arch/arm64/boot/dts/apple/t8103.dtsi
> +++ b/arch/arm64/boot/dts/apple/t8103.dtsi
> @@ -143,6 +143,7 @@ pinctrl_ap: pinctrl@23c100000 {
>  			apple,npins = <212>;
>  
>  			interrupt-controller;
> +			#interrupt-cells = <2>;
>  			interrupt-parent = <&aic>;
>  			interrupts = <AIC_IRQ 190 IRQ_TYPE_LEVEL_HIGH>,
>  				     <AIC_IRQ 191 IRQ_TYPE_LEVEL_HIGH>,
> @@ -169,6 +170,7 @@ pinctrl_aop: pinctrl@24a820000 {
>  			apple,npins = <42>;
>  
>  			interrupt-controller;
> +			#interrupt-cells = <2>;
>  			interrupt-parent = <&aic>;
>  			interrupts = <AIC_IRQ 268 IRQ_TYPE_LEVEL_HIGH>,
>  				     <AIC_IRQ 269 IRQ_TYPE_LEVEL_HIGH>,
> @@ -189,6 +191,7 @@ pinctrl_nub: pinctrl@23d1f0000 {
>  			apple,npins = <23>;
>  
>  			interrupt-controller;
> +			#interrupt-cells = <2>;
>  			interrupt-parent = <&aic>;
>  			interrupts = <AIC_IRQ 330 IRQ_TYPE_LEVEL_HIGH>,
>  				     <AIC_IRQ 331 IRQ_TYPE_LEVEL_HIGH>,
> @@ -209,6 +212,7 @@ pinctrl_smc: pinctrl@23e820000 {
>  			apple,npins = <16>;
>  
>  			interrupt-controller;
> +			#interrupt-cells = <2>;
>  			interrupt-parent = <&aic>;
>  			interrupts = <AIC_IRQ 391 IRQ_TYPE_LEVEL_HIGH>,
>  				     <AIC_IRQ 392 IRQ_TYPE_LEVEL_HIGH>,
> -- 
> 2.34.0
> 
> 
