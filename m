Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D695F37A447
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 12:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbhEKKH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 06:07:26 -0400
Received: from lizzard.sbs.de ([194.138.37.39]:49821 "EHLO lizzard.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231422AbhEKKHV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 06:07:21 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 14BA5kJA023652
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 May 2021 12:05:46 +0200
Received: from [167.87.32.54] ([167.87.32.54])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 14BA1sqw007580;
        Tue, 11 May 2021 12:01:55 +0200
Subject: Re: [PATCH v2] arm64: dts: ti: k3-am65: Add support for UHS-I modes
 in MMCSD1 subsystem
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210511095339.16268-1-a-govindraju@ti.com>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <200b5648-b2d9-b4c9-f81a-b39c3baf81f9@siemens.com>
Date:   Tue, 11 May 2021 12:01:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210511095339.16268-1-a-govindraju@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.05.21 11:53, Aswath Govindraju wrote:
> UHS-I speed modes are supported in AM65 S.R. 2.0 SoC[1].
> 
> Add support by removing the no-1-8-v tag and including the voltage
> regulator device tree nodes for power cycling.
> 
> However, the 4 bit interface of AM65 SR 1.0 cannot be supported at 3.3 V or
> 1.8 V because of erratas i2025 and i2026 [2]. As the SD card is the primary
> boot mode for development usecases, continue to enable SD card and disable
> UHS-I modes in it to minimize any ageing issues happening because of
> erratas.
> 
> k3-am6528-iot2050-basic and k3-am6548-iot2050-advanced boards use S.R. 1.0
> version of AM65 SoC. Therefore, add no-1-8-v in sdhci1 device tree nodes
> for these boards.
> 
> [1] - https://www.ti.com/lit/ug/spruid7e/spruid7e.pdf
> [2] - https://www.ti.com/lit/er/sprz452e/sprz452e.pdf
> 
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am65-main.dtsi      |  1 -
>  .../boot/dts/ti/k3-am6528-iot2050-basic.dts   |  4 +++
>  .../arm64/boot/dts/ti/k3-am654-base-board.dts | 33 +++++++++++++++++++
>  .../dts/ti/k3-am6548-iot2050-advanced.dts     |  4 +++
>  4 files changed, 41 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> index cb340d1b401f..632f32fce4a1 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> @@ -301,7 +301,6 @@
>  		ti,otap-del-sel = <0x2>;
>  		ti,trm-icp = <0x8>;
>  		dma-coherent;
> -		no-1-8-v;
>  	};
>  
>  	scm_conf: scm-conf@100000 {
> diff --git a/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dts b/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dts
> index 4f7e3f2a6265..485266960d5f 100644
> --- a/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dts
> @@ -40,6 +40,10 @@
>  	status = "disabled";
>  };
>  
> +&sdhci1 {
> +	no-1-8-v;
> +};
> +

Let's move that to k3-am65-iot2050-common.dtsi, to avoid repeating
yourself. There is already a sdhci1 extension.

Jan

>  &main_pmx0 {
>  	main_uart0_pins_default: main-uart0-pins-default {
>  		pinctrl-single,pins = <
> diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
> index 9e87fb313a54..51c594b4dddb 100644
> --- a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
> @@ -91,6 +91,38 @@
>  		#clock-cells = <0>;
>  		clock-frequency = <24000000>;
>  	};
> +
> +	evm_12v0: fixedregulator-evm12v0 {
> +		/* main supply */
> +		compatible = "regulator-fixed";
> +		regulator-name = "evm_12v0";
> +		regulator-min-microvolt = <12000000>;
> +		regulator-max-microvolt = <12000000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
> +	vcc3v3_io: fixedregulator-vcc3v3io {
> +		/* Output of TPS54334 */
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc3v3_io";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +		vin-supply = <&evm_12v0>;
> +	};
> +
> +	vdd_mmc1_sd: fixedregulator-sd {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vdd_mmc1_sd";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-boot-on;
> +		enable-active-high;
> +		vin-supply = <&vcc3v3_io>;
> +		gpio = <&pca9554 4 GPIO_ACTIVE_HIGH>;
> +	};
>  };
>  
>  &wkup_pmx0 {
> @@ -350,6 +382,7 @@
>   * disable sdhci1
>   */
>  &sdhci1 {
> +	vmmc-supply = <&vdd_mmc1_sd>;
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&main_mmc1_pins_default>;
>  	ti,driver-strength-ohm = <50>;
> diff --git a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts
> index ec9617c13cdb..3643a19b5f33 100644
> --- a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts
> @@ -55,6 +55,10 @@
>  	disable-wp;
>  };
>  
> +&sdhci1 {
> +	no-1-8-v;
> +};
> +
>  &main_uart0 {
>  	status = "disabled";
>  };
> 

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux
