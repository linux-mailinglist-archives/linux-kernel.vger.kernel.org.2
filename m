Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A210A45E780
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 06:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358512AbhKZFoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 00:44:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358627AbhKZFmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 00:42:02 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AECFC06175F;
        Thu, 25 Nov 2021 21:38:42 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id ABC9941DF4;
        Fri, 26 Nov 2021 05:38:36 +0000 (UTC)
Subject: Re: [PATCH v3 4/4] arm64: dts: apple: t8103: Add cd321x nodes
To:     Janne Grunau <j@jannau.net>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211122225807.8105-1-j@jannau.net>
 <20211122225807.8105-5-j@jannau.net>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <ab7c83bc-f8a1-194d-4e62-25ba1845805b@marcan.st>
Date:   Fri, 26 Nov 2021 14:38:33 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211122225807.8105-5-j@jannau.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/11/2021 07.58, Janne Grunau wrote:
> All M1 Mac devices have 2 SoC connected USB-C ports and use cd321x USB
> type C port switch and power deliver controllers. I2c bus and adresses
> configuration are for all devices equal.
> The iMac (24-inch, 2021) has a configuration with 2 additional USB-C
> ports (j456) using two addiotional cd321x controllers.
> 
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
>   arch/arm64/boot/dts/apple/t8103-j456.dts  | 18 ++++++++++++++++++
>   arch/arm64/boot/dts/apple/t8103-jxxx.dtsi | 18 ++++++++++++++++++
>   2 files changed, 36 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/apple/t8103-j456.dts b/arch/arm64/boot/dts/apple/t8103-j456.dts
> index 7267e069355b..c6b8c28455f5 100644
> --- a/arch/arm64/boot/dts/apple/t8103-j456.dts
> +++ b/arch/arm64/boot/dts/apple/t8103-j456.dts
> @@ -21,6 +21,24 @@ aliases {
>   	};
>   };
>   
> +&i2c0 {
> +	hpm2: tps6598x@3b {
> +		compatible = "apple,cd321x";
> +		reg = <0x3b>;
> +		interrupt-parent = <&pinctrl_ap>;
> +		interrupts = <106 IRQ_TYPE_LEVEL_LOW>;
> +		interrupt-names = "irq";
> +	};
> +
> +	hpm3: tps6598x@3c {
> +		compatible = "apple,cd321x";
> +		reg = <0x3c>;
> +		interrupt-parent = <&pinctrl_ap>;
> +		interrupts = <106 IRQ_TYPE_LEVEL_LOW>;
> +		interrupt-names = "irq";
> +	};
> +};
> +
>   /*
>    * Force the bus number assignments so that we can declare some of the
>    * on-board devices and properties that are populated by the bootloader
> diff --git a/arch/arm64/boot/dts/apple/t8103-jxxx.dtsi b/arch/arm64/boot/dts/apple/t8103-jxxx.dtsi
> index 53d22b434d76..5f748f3f60d2 100644
> --- a/arch/arm64/boot/dts/apple/t8103-jxxx.dtsi
> +++ b/arch/arm64/boot/dts/apple/t8103-jxxx.dtsi
> @@ -39,6 +39,24 @@ &serial0 {
>   	status = "okay";
>   };
>   
> +&i2c0 {
> +	hpm0: tps6598x@38 {
> +		compatible = "apple,cd321x";
> +		reg = <0x38>;
> +		interrupt-parent = <&pinctrl_ap>;
> +		interrupts = <106 IRQ_TYPE_LEVEL_LOW>;
> +		interrupt-names = "irq";
> +	};
> +
> +	hpm1: tps6598x@3f {
> +		compatible = "apple,cd321x";
> +		reg = <0x3f>;
> +		interrupt-parent = <&pinctrl_ap>;
> +		interrupts = <106 IRQ_TYPE_LEVEL_LOW>;
> +		interrupt-names = "irq";
> +	};
> +};
> +
>   /*
>    * Force the bus number assignments so that we can declare some of the
>    * on-board devices and properties that are populated by the bootloader
> 

With sven's comments addressed,

Acked-by: Hector Martin <marcan@marcan.st>

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
