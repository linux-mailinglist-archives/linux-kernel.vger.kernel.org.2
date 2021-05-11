Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A56037A07A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 09:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbhEKHPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 03:15:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:60220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230355AbhEKHPB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 03:15:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 71B2861920;
        Tue, 11 May 2021 07:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620717235;
        bh=8Ng+KnzWu9dMfLHfX55NiwAREP/QuApMDcjkSM9xUN0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=UC2nTetGxX97hx4A4rBxNGIsduWo+WK38h26kaqQUBp0FzO4vWVhFEuw/IwwTi56+
         ULhzDH0MSRpCapYoqxShi5MUTpUv7HAd4DbB6wOCC9Ry6muwpGP5Ll1ToPixjmEhsr
         /pJG1YoCSb9cCRDkg1fufAUtLHveYouv0WVNxK2frYm9473wdG6uQv52EPRO4ULKM6
         lha5TuhW/JobVZQen+HCMBX5WdsvrbGQnQlL9ToRh6D55AFurFLuw+5my14ITvjxCv
         QxBGcc1SlLOLhLWjFbzKy2szYw/5pvyZyTb0I6/DKIVJhVC2Fvrbs3aUReX2LvFVd6
         ev3k2oS26qglA==
Subject: Re: [PATCH] arm64: dts: ti: k3*: Introduce reg definition for
 interrupt routers
To:     Nishanth Menon <nm@ti.com>, grygorii.strashko@ti.com
Cc:     lokeshvutla@ti.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20210510145508.8994-1-nm@ti.com>
From:   Tero Kristo <kristo@kernel.org>
Message-ID: <caaf3f33-2707-d44c-03a6-0906c3157dca@kernel.org>
Date:   Tue, 11 May 2021 10:13:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210510145508.8994-1-nm@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2021 17:55, Nishanth Menon wrote:
> Interrupt routers are memory mapped peripherals, that are organized
> in our dts bus hierarchy to closely represents the actual hardware
> behavior.
> 
> However, without explicitly calling out the reg property, using
> 2021.03+ dt-schema package, this exposes the following problem with
> dtbs_check:
> 
> /arch/arm64/boot/dts/ti/k3-am654-base-board.dt.yaml: bus@100000:
> interrupt-controller0: {'type': 'object'} is not allowed for
> {'compatible': ['ti,sci-intr'], .....
> 
> Even though we don't use interrupt router directly via memory mapped
> registers and have to use it via the system controller, the hardware
> block is memory mapped, so describe the base address in device tree.
> 
> This is a valid, comprehensive description of hardware and permitted
> by the existing ti,sci-intr schema.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>

Reviewed-by: Tero Kristo <kristo@kernel.org>

> ---
> 
> if possible, I'd like to pick this fixup for 5.13 window..
> 
>   arch/arm64/boot/dts/ti/k3-am64-main.dtsi        | 3 ++-
>   arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi         | 3 ++-
>   arch/arm64/boot/dts/ti/k3-am65-main.dtsi        | 6 ++++--
>   arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi      | 3 ++-
>   arch/arm64/boot/dts/ti/k3-j7200-main.dtsi       | 6 ++++--
>   arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi | 3 ++-
>   arch/arm64/boot/dts/ti/k3-j721e-main.dtsi       | 6 ++++--
>   arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi | 3 ++-
>   8 files changed, 22 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> index b2bcbf23eefd..a49e41021573 100644
> --- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> @@ -373,8 +373,9 @@ main_spi4: spi@20140000 {
>   		clocks = <&k3_clks 145 0>;
>   	};
>   
> -	main_gpio_intr: interrupt-controller0 {
> +	main_gpio_intr: interrupt-controller@a00000 {
>   		compatible = "ti,sci-intr";
> +		reg = <0x00 0xa00000 0x00 0x800>;
>   		ti,intr-trigger-type = <1>;
>   		interrupt-controller;
>   		interrupt-parent = <&gic500>;
> diff --git a/arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi
> index 99e94dee1bd4..deb19ae5e168 100644
> --- a/arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi
> @@ -74,8 +74,9 @@ mcu_spi1: spi@4b10000 {
>   		clocks = <&k3_clks 148 0>;
>   	};
>   
> -	mcu_gpio_intr: interrupt-controller1 {
> +	mcu_gpio_intr: interrupt-controller@4210000 {
>   		compatible = "ti,sci-intr";
> +		reg = <0x00 0x04210000 0x00 0x200>;
>   		ti,intr-trigger-type = <1>;
>   		interrupt-controller;
>   		interrupt-parent = <&gic500>;
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> index cb340d1b401f..037f9776c4c8 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> @@ -433,8 +433,9 @@ usb1_phy: phy@4110000 {
>   		#phy-cells = <0>;
>   	};
>   
> -	intr_main_gpio: interrupt-controller0 {
> +	intr_main_gpio: interrupt-controller@a00000 {
>   		compatible = "ti,sci-intr";
> +		reg = <0x0 0xa00000 0x0 0x400>;
>   		ti,intr-trigger-type = <1>;
>   		interrupt-controller;
>   		interrupt-parent = <&gic500>;
> @@ -454,8 +455,9 @@ main-navss {
>   
>   		ti,sci-dev-id = <118>;
>   
> -		intr_main_navss: interrupt-controller1 {
> +		intr_main_navss: interrupt-controller@310e0000 {
>   			compatible = "ti,sci-intr";
> +			reg = <0x0 0x310e0000 0x0 0x2000>;
>   			ti,intr-trigger-type = <4>;
>   			interrupt-controller;
>   			interrupt-parent = <&gic500>;
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
> index ed42f13e7663..62a18b110c52 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
> @@ -69,8 +69,9 @@ wkup_i2c0: i2c@42120000 {
>   		power-domains = <&k3_pds 115 TI_SCI_PD_EXCLUSIVE>;
>   	};
>   
> -	intr_wkup_gpio: interrupt-controller2 {
> +	intr_wkup_gpio: interrupt-controller@42200000 {
>   		compatible = "ti,sci-intr";
> +		reg = <0x42200000 0x200>;
>   		ti,intr-trigger-type = <1>;
>   		interrupt-controller;
>   		interrupt-parent = <&gic500>;
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
> index f86c493a44f1..4403ac0fc8a7 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
> @@ -68,8 +68,9 @@ gic_its: msi-controller@1820000 {
>   		};
>   	};
>   
> -	main_gpio_intr: interrupt-controller0 {
> +	main_gpio_intr: interrupt-controller@a00000 {
>   		compatible = "ti,sci-intr";
> +		reg = <0x00 0xa00000 0x00 0x800>;
>   		ti,intr-trigger-type = <1>;
>   		interrupt-controller;
>   		interrupt-parent = <&gic500>;
> @@ -86,8 +87,9 @@ main_navss: bus@30000000 {
>   		ranges = <0x00 0x30000000 0x00 0x30000000 0x00 0x0c400000>;
>   		ti,sci-dev-id = <199>;
>   
> -		main_navss_intr: interrupt-controller1 {
> +		main_navss_intr: interrupt-controller@310e0000 {
>   			compatible = "ti,sci-intr";
> +			reg = <0x00 0x310e0000 0x00 0x4000>;
>   			ti,intr-trigger-type = <4>;
>   			interrupt-controller;
>   			interrupt-parent = <&gic500>;
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
> index 5e74e43822c3..825b9f1931b7 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
> @@ -96,8 +96,9 @@ mcu_uart0: serial@40a00000 {
>   		clock-names = "fclk";
>   	};
>   
> -	wkup_gpio_intr: interrupt-controller2 {
> +	wkup_gpio_intr: interrupt-controller@42200000 {
>   		compatible = "ti,sci-intr";
> +		reg = <0x00 0x42200000 0x00 0x400>;
>   		ti,intr-trigger-type = <1>;
>   		interrupt-controller;
>   		interrupt-parent = <&gic500>;
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> index c2aa45a3ac79..512371e36a30 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> @@ -76,8 +76,9 @@ gic_its: msi-controller@1820000 {
>   		};
>   	};
>   
> -	main_gpio_intr: interrupt-controller0 {
> +	main_gpio_intr: interrupt-controller@a00000 {
>   		compatible = "ti,sci-intr";
> +		reg = <0x00 0xa00000 0x00 0x800>;
>   		ti,intr-trigger-type = <1>;
>   		interrupt-controller;
>   		interrupt-parent = <&gic500>;
> @@ -97,8 +98,9 @@ main-navss {
>   
>   		ti,sci-dev-id = <199>;
>   
> -		main_navss_intr: interrupt-controller1 {
> +		main_navss_intr: interrupt-controller@310e0000 {
>   			compatible = "ti,sci-intr";
> +			reg = <0x0 0x310e0000 0x0 0x4000>;
>   			ti,intr-trigger-type = <4>;
>   			interrupt-controller;
>   			interrupt-parent = <&gic500>;
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
> index d56e3475aee7..ad12a5c9f209 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
> @@ -96,8 +96,9 @@ mcu_uart0: serial@40a00000 {
>   		clock-names = "fclk";
>   	};
>   
> -	wkup_gpio_intr: interrupt-controller2 {
> +	wkup_gpio_intr: interrupt-controller@42200000 {
>   		compatible = "ti,sci-intr";
> +		reg = <0x00 0x42200000 0x00 0x400>;
>   		ti,intr-trigger-type = <1>;
>   		interrupt-controller;
>   		interrupt-parent = <&gic500>;
> 

