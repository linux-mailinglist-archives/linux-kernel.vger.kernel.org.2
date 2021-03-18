Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDB4F34088C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 16:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbhCRPPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 11:15:48 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:33138 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhCRPPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 11:15:31 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12IFFLw6079956;
        Thu, 18 Mar 2021 10:15:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1616080521;
        bh=Cfkn5a8FJaGIEIwcyxDRfMGUxvWJW2WdVrOB3euXUlw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=G3rYFMw/KSknHl8lqnB+yZQPOnoPCSg3N0TRLLIHSzotK0WZiMPYa+bxWQaziDbIt
         ZFjgMPTQ2qMxRzgXeS2gJ0n310bUTQQuZPLuU8rcG+4SPV9vW82jGvMI/U1b/k6IpO
         C/OsalboEtVMLaBOaC/9ii6jhFvTC9rAguYpowA0=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12IFFLHS117439
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 18 Mar 2021 10:15:21 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 18
 Mar 2021 10:15:21 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 18 Mar 2021 10:15:20 -0500
Received: from [10.250.232.53] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12IFFG4A078700;
        Thu, 18 Mar 2021 10:15:17 -0500
Subject: Re: [PATCH v5 3/3] arm64: dts: ti: k3-j7200: Add support for higher
 speed modes and update delay select values for MMCSD subsystems
To:     Aswath Govindraju <a-govindraju@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210310161924.22256-1-a-govindraju@ti.com>
 <20210310161924.22256-4-a-govindraju@ti.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <00d1efaf-6041-5811-6d02-2eef338469ea@ti.com>
Date:   Thu, 18 Mar 2021 20:45:16 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210310161924.22256-4-a-govindraju@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/03/21 9:49 pm, Aswath Govindraju wrote:
> The following speed modes are now supported in J7200 SoC,
> - HS200 and HS400 modes at 1.8 V card voltage, in MMCSD0 subsystem [1].
> - UHS-I speed modes in MMCSD1 subsystem [1].
> 
> Add support for UHS-I modes by adding voltage regulator device tree nodes
> and corresponding pinmux details, to power cycle and voltage switch cards.
> Set respective tags in sdhci0 and remove no-1-8-v tag from sdhci1
> device tree nodes.
> 
> Also update the delay values for various speed modes supported, based on
> the latest J7200 datasheet[2]

nit: Better to mention the datasheet version (as it's not latest anymore).
> 
> [1] - section 12.3.6.1.1 MMCSD Features, in
>       https://www.ti.com/lit/ug/spruiu1a/spruiu1a.pdf
> 
> [2] - https://www.ti.com/lit/ds/symlink/dra821a.pdf

Er.. this link is already broken.

Thanks
Kishon
> 
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> ---
>  .../dts/ti/k3-j7200-common-proc-board.dts     | 42 +++++++++++++++++++
>  arch/arm64/boot/dts/ti/k3-j7200-main.dtsi     | 14 ++++++-
>  2 files changed, 54 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
> index b493f939b09a..6f90c3b1cf45 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
> @@ -16,6 +16,29 @@
>  		stdout-path = "serial2:115200n8";
>  		bootargs = "console=ttyS2,115200n8 earlycon=ns16550a,mmio32,0x02800000";
>  	};
> +
> +	vdd_mmc1: fixedregulator-sd {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vdd_mmc1";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-boot-on;
> +		enable-active-high;
> +		gpios = <&exp2 2 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	vdd_sd_dv: gpio-regulator-vdd-sd-dv {
> +		compatible = "regulator-gpio";
> +		regulator-name = "vdd_sd_dv";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vdd_sd_dv_pins_default>;
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-boot-on;
> +		gpios = <&main_gpio0 55 GPIO_ACTIVE_HIGH>;
> +		states = <1800000 0x0
> +			  3300000 0x1>;
> +	};
>  };
>  
>  &wkup_pmx0 {
> @@ -45,6 +68,13 @@
>  };
>  
>  &main_pmx0 {
> +	main_i2c0_pins_default: main-i2c0-pins-default {
> +		pinctrl-single,pins = <
> +			J721E_IOPAD(0xd4, PIN_INPUT_PULLUP, 0) /* (V3) I2C0_SCL */
> +			J721E_IOPAD(0xd8, PIN_INPUT_PULLUP, 0) /* (W2) I2C0_SDA */
> +		>;
> +	};
> +
>  	main_i2c1_pins_default: main-i2c1-pins-default {
>  		pinctrl-single,pins = <
>  			J721E_IOPAD(0xdc, PIN_INPUT_PULLUP, 3) /* (U3) ECAP0_IN_APWM_OUT.I2C1_SCL */
> @@ -70,6 +100,12 @@
>  			J721E_IOPAD(0x120, PIN_OUTPUT, 0) /* (T4) USB0_DRVVBUS */
>  		>;
>  	};
> +
> +	vdd_sd_dv_pins_default: vdd_sd_dv_pins_default {
> +		pinctrl-single,pins = <
> +			J721E_IOPAD(0xd0, PIN_INPUT, 7) /* (T5) SPI0_D1.GPIO0_55 */
> +		>;
> +	};
>  };
>  
>  &wkup_uart0 {
> @@ -157,6 +193,10 @@
>  };
>  
>  &main_i2c0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_i2c0_pins_default>;
> +	clock-frequency = <400000>;
> +
>  	exp1: gpio@20 {
>  		compatible = "ti,tca6416";
>  		reg = <0x20>;
> @@ -206,6 +246,8 @@
>  	/* SD card */
>  	pinctrl-0 = <&main_mmc1_pins_default>;
>  	pinctrl-names = "default";
> +	vmmc-supply = <&vdd_mmc1>;
> +	vqmmc-supply = <&vdd_sd_dv>;
>  	ti,driver-strength-ohm = <50>;
>  	disable-wp;
>  };
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
> index e60650a62b14..f86c493a44f1 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
> @@ -512,11 +512,16 @@
>  		ti,otap-del-sel-mmc-hs = <0x0>;
>  		ti,otap-del-sel-ddr52 = <0x6>;
>  		ti,otap-del-sel-hs200 = <0x8>;
> -		ti,otap-del-sel-hs400 = <0x0>;
> +		ti,otap-del-sel-hs400 = <0x5>;
> +		ti,itap-del-sel-legacy = <0x10>;
> +		ti,itap-del-sel-mmc-hs = <0xa>;
>  		ti,strobe-sel = <0x77>;
> +		ti,clkbuf-sel = <0x7>;
>  		ti,trm-icp = <0x8>;
>  		bus-width = <8>;
>  		mmc-ddr-1_8v;
> +		mmc-hs200-1_8v;
> +		mmc-hs400-1_8v;
>  		dma-coherent;
>  	};
>  
> @@ -534,7 +539,12 @@
>  		ti,otap-del-sel-sdr50 = <0xc>;
>  		ti,otap-del-sel-sdr104 = <0x5>;
>  		ti,otap-del-sel-ddr50 = <0xc>;
> -		no-1-8-v;
> +		ti,itap-del-sel-legacy = <0x0>;
> +		ti,itap-del-sel-sd-hs = <0x0>;
> +		ti,itap-del-sel-sdr12 = <0x0>;
> +		ti,itap-del-sel-sdr25 = <0x0>;
> +		ti,clkbuf-sel = <0x7>;
> +		ti,trm-icp = <0x8>;
>  		dma-coherent;
>  	};
>  
> 
