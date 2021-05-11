Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3AE837A085
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 09:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbhEKHQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 03:16:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:60438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230333AbhEKHQH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 03:16:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A6AF061926;
        Tue, 11 May 2021 07:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620717301;
        bh=Ol3Y3NGUoh+XLbyDQdLjaDsjUT2yr2pIhlJoigW1IRI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=SlfDAwDlc2JbUfweLW37FbFNwsd086fIdg3r6tNg1yy2Atb8mdRA5xYtDzZfTLv8B
         YkTocbqXLewhM1i+FjoUHMCDeB7E4e8fBB4z2v7yEEunQZpN/oajGRL3oZIdahCfCk
         RjusI4cZNFOc2moNCgRsI+ednBAkNf0mHPMGMK4jKU0lObVKtQj/jjmewUuyralaco
         DZTDWlE5KsCQP3VRvTtUQEW6SG98zBDB7W21cYJQJ08im4JGAbg5fnm5u+PZJ4uW1D
         LJaPqZfZGXHGQepFlN+7kT99NL/zgrZZHUAjGAob8ZT3T5rWPm8jE6UpE2Ckluty0t
         BxGZR3ikpflkQ==
Subject: Re: [PATCH] arm64: dts: ti: k3-am65|j721e|am64: Map the dma /
 navigator subsystem via explicit ranges
To:     Nishanth Menon <nm@ti.com>, vigneshr@ti.com,
        grygorii.strashko@ti.com
Cc:     lokeshvutla@ti.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20210510145429.8752-1-nm@ti.com>
From:   Tero Kristo <kristo@kernel.org>
Message-ID: <6efd1297-d174-d915-44f7-a4ad6ff46b52@kernel.org>
Date:   Tue, 11 May 2021 10:14:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210510145429.8752-1-nm@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2021 17:54, Nishanth Menon wrote:
> Instead of using empty ranges property, lets map explicitly the address
> range that is mapped onto the dma / navigator subsystems (navss/dmss).
> 
> This is also exposed via the dtbs_check with dt-schema newer than
> 2021.03 version by throwing out following:
> arch/arm64/boot/dts/ti/k3-am654-base-board.dt.yaml: bus@100000: main-navss:
> {'type': 'object'} is not allowed for
> {'compatible': ['simple-mfd'], '#address-cells': [[2]], .....
> 
> This has already been correctly done for J7200, however was missed for
> other k3 SoCs. Fix that oversight.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>

Reviewed-by: Tero Kristo <kristo@kernel.org>

> ---
> 
> if possible, I'd like to pick this fixup for 5.13 window..
> 
>   arch/arm64/boot/dts/ti/k3-am64-main.dtsi        | 4 ++--
>   arch/arm64/boot/dts/ti/k3-am65-main.dtsi        | 4 ++--
>   arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi         | 4 ++--
>   arch/arm64/boot/dts/ti/k3-j721e-main.dtsi       | 4 ++--
>   arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi | 4 ++--
>   5 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> index a49e41021573..bb19db04a746 100644
> --- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> @@ -42,12 +42,12 @@ gic_its: msi-controller@1820000 {
>   		};
>   	};
>   
> -	dmss: dmss {
> +	dmss: bus@48000000 {
>   		compatible = "simple-mfd";
>   		#address-cells = <2>;
>   		#size-cells = <2>;
>   		dma-ranges;
> -		ranges;
> +		ranges = <0x00 0x48000000 0x00 0x48000000 0x00 0x06400000>;
>   
>   		ti,sci-dev-id = <25>;
>   
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> index 037f9776c4c8..fea8260d33a8 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> @@ -445,11 +445,11 @@ intr_main_gpio: interrupt-controller@a00000 {
>   		ti,interrupt-ranges = <0 392 32>;
>   	};
>   
> -	main-navss {
> +	main_navss: bus@30800000 {
>   		compatible = "simple-mfd";
>   		#address-cells = <2>;
>   		#size-cells = <2>;
> -		ranges;
> +		ranges = <0x0 0x30800000 0x0 0x30800000 0x0 0xbc00000>;
>   		dma-coherent;
>   		dma-ranges;
>   
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
> index 0388c02c2203..f5b8ef2f5f77 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
> @@ -116,11 +116,11 @@ adc {
>   		};
>   	};
>   
> -	mcu-navss {
> +	mcu_navss: bus@28380000 {
>   		compatible = "simple-mfd";
>   		#address-cells = <2>;
>   		#size-cells = <2>;
> -		ranges;
> +		ranges = <0x00 0x28380000 0x00 0x28380000 0x00 0x03880000>;
>   		dma-coherent;
>   		dma-ranges;
>   
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> index 512371e36a30..b2d25af872e2 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> @@ -88,11 +88,11 @@ main_gpio_intr: interrupt-controller@a00000 {
>   		ti,interrupt-ranges = <8 392 56>;
>   	};
>   
> -	main-navss {
> +	main_navss: bus@30000000 {
>   		compatible = "simple-mfd";
>   		#address-cells = <2>;
>   		#size-cells = <2>;
> -		ranges;
> +		ranges = <0x00 0x30000000 0x00 0x30000000 0x00 0x0c400000>;
>   		dma-coherent;
>   		dma-ranges;
>   
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
> index ad12a5c9f209..172629fa3c7c 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
> @@ -250,11 +250,11 @@ adc {
>   		};
>   	};
>   
> -	mcu-navss {
> +	mcu_navss: bus@28380000 {
>   		compatible = "simple-mfd";
>   		#address-cells = <2>;
>   		#size-cells = <2>;
> -		ranges;
> +		ranges = <0x00 0x28380000 0x00 0x28380000 0x00 0x03880000>;
>   		dma-coherent;
>   		dma-ranges;
>   
> 

