Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1203803F8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 09:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232950AbhENHFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 03:05:04 -0400
Received: from foss.arm.com ([217.140.110.172]:44112 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232460AbhENHFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 03:05:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E5CD41713;
        Fri, 14 May 2021 00:03:52 -0700 (PDT)
Received: from slackpad.fritz.box (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 885D53F718;
        Fri, 14 May 2021 00:03:51 -0700 (PDT)
Date:   Fri, 14 May 2021 08:03:46 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Tobias Schramm <t.schramm@manjaro.org>
Cc:     Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] ARM: dts: sun8i: v3s: add pwm controller to v3s
 dts
Message-ID: <20210514080346.6d028243@slackpad.fritz.box>
In-Reply-To: <20210513203527.2072090-3-t.schramm@manjaro.org>
References: <20210513203527.2072090-1-t.schramm@manjaro.org>
        <20210513203527.2072090-3-t.schramm@manjaro.org>
Organization: Arm Ltd.
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 May 2021 22:35:27 +0200
Tobias Schramm <t.schramm@manjaro.org> wrote:

> The Allwinner V3s and V3 SoCs feature a pwm controller identical to the
> one used in the Allwinner A20.
> This commit adds it to the V3s dtsi.
> 
> Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>

Address and size match the manual, and the register description look
identical between A20 and V3s.

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
>  arch/arm/boot/dts/sun8i-v3s.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun8i-v3s.dtsi b/arch/arm/boot/dts/sun8i-v3s.dtsi
> index eb4cb63fef13..456dee9de87f 100644
> --- a/arch/arm/boot/dts/sun8i-v3s.dtsi
> +++ b/arch/arm/boot/dts/sun8i-v3s.dtsi
> @@ -422,6 +422,15 @@ wdt0: watchdog@1c20ca0 {
>  			clocks = <&osc24M>;
>  		};
>  
> +		pwm: pwm@1c21400 {
> +			compatible = "allwinner,sun8i-v3s-pwm",
> +				     "allwinner,sun7i-a20-pwm";
> +			reg = <0x01c21400 0xc>;
> +			clocks = <&osc24M>;
> +			#pwm-cells = <3>;
> +			status = "disabled";
> +		};
> +
>  		lradc: lradc@1c22800 {
>  			compatible = "allwinner,sun4i-a10-lradc-keys";
>  			reg = <0x01c22800 0x400>;

