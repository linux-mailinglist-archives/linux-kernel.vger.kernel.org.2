Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A26DD39471B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 20:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbhE1Sk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 14:40:26 -0400
Received: from lizzard.sbs.de ([194.138.37.39]:55070 "EHLO lizzard.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229463AbhE1SkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 14:40:25 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 14SIcR71006113
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 May 2021 20:38:28 +0200
Received: from [139.22.36.59] ([139.22.36.59])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 14SIYn0b029435;
        Fri, 28 May 2021 20:34:49 +0200
Subject: Re: [PATCH v3] arm64: dts: ti: k3-am65: Add support for UHS-I modes
 in MMCSD1 subsystem
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210511164849.20016-1-a-govindraju@ti.com>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <7157b8ca-74e4-b7dd-c069-533db6a1cf0c@siemens.com>
Date:   Fri, 28 May 2021 20:34:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210511164849.20016-1-a-govindraju@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.05.21 18:48, Aswath Govindraju wrote:
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
> version of AM65 SoC. Therefore, add no-1-8-v in sdhci1 device tree node of
> the common iot2050 device tree file.
> 
> [1] - https://www.ti.com/lit/ug/spruid7e/spruid7e.pdf, section 12.3.6.1.1
> [2] - https://www.ti.com/lit/er/sprz452e/sprz452e.pdf
> 
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> ---
> 
> changes since v2:
> - moved the no-1-8-v tag to common iot2050 dtsi file.
> 
> changes since v1:
> - added no-1-8-v tag in sdhci1 dt nodes of k3-am6528-iot2050-basic and
>   k3-am6548-iot2050-advanced boards as they use S.R.1.0 version AM65 SoC.
> 
>  .../boot/dts/ti/k3-am65-iot2050-common.dtsi   |  1 +
>  arch/arm64/boot/dts/ti/k3-am65-main.dtsi      |  1 -
>  .../arm64/boot/dts/ti/k3-am654-base-board.dts | 33 +++++++++++++++++++
>  3 files changed, 34 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
> index de763ca9251c..46cc348cd4be 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
> @@ -555,6 +555,7 @@
>  	pinctrl-0 = <&main_mmc1_pins_default>;
>  	ti,driver-strength-ohm = <50>;
>  	disable-wp;
> +	no-1-8-v;
>  };
>  

Acked-by: Jan Kiszka <jan.kiszka@siemens.com>

Jan

>  &usb0 {
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
> 

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux
