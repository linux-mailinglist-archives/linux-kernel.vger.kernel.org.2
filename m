Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41F4440C1C1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 10:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236830AbhIOIbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 04:31:38 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:62459 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231610AbhIOIbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 04:31:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1631694618; x=1663230618;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=CuDyKY55ZbzDXbGqx9WS7l9zi6qqPhidS7v7vJGSuLs=;
  b=cd0EAcgXJQKSdy0rVllzJJtT79bINR5jAgQ7FOe4YwvbWdRN78VojbDB
   4iEftccpJNLxyn/DomwfDyPVXyb11T+Vm+VOAdxtiA8FeORbriXad+KNi
   +lk4QvrAZBe6TqFrI3f4XOaaC5KiwRePYNxHccMB3viP83BG+uhw0t+ej
   woHO1gmd3NKqCOfAB9kikNh2sFGH375kkZeLFWWtB2xcT2lqDxNVrk4a4
   +jCVXhX+UqFAaulJMlrhWKWZ4R9G7k1M28BudW4ATSpI0KwabmBcfraLN
   mdkGGlF39yuLjAvi2tZFrmv0q3Hz8RdrYFWPp7A6Nn1uZ6X/eE5RbjdGI
   A==;
IronPort-SDR: aPOA3TQeBHXmCnnIFjMal0zDrapdgayYa6Y7ITo+7FGmc4XV14hL1ApDDwGD5nCOJ7Vc/3VfZj
 AEbo+CReP32v++McuvAcPMshCYNIk9N1elJlSuErnXbI63Ib5kuI8xKhZjB7GKNVxiniHZL3/H
 meFEAgX/f5kGvVGPER2e95QyGSzFzVcHuom7jDlmqG9JMqSZXWhybqEin+gDfv3yuiTPc1YkrJ
 QixCqqoQuowHMcsYJhPcFDUpP+J/szVZCE1//HxWD3EXw9wlSfM1G4Z1QP+sSSpc7n60//qiW3
 t+uCmpAYz0CPuxvITk9VpwjH
X-IronPort-AV: E=Sophos;i="5.85,294,1624345200"; 
   d="scan'208";a="129372772"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Sep 2021 01:30:18 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 15 Sep 2021 01:30:17 -0700
Received: from [10.171.246.91] (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Wed, 15 Sep 2021 01:30:15 -0700
Subject: Re: [PATCH v4] ARM: dts: at91: sama5d27_wlsom1: add wifi device
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Eugen Hristev <eugen.hristev@microchip.com>
References: <20210825094055.642941-1-claudiu.beznea@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <b80be4c4-27ec-9e94-2bbb-5a2640af0514@microchip.com>
Date:   Wed, 15 Sep 2021 10:30:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210825094055.642941-1-claudiu.beznea@microchip.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/08/2021 at 11:40, Claudiu Beznea wrote:
> From: Eugen Hristev <eugen.hristev@microchip.com>
> 
> SAMA5D27 WLSOM1 boards has a WILC3000 device soldered. Add proper
> device tree nodes for this.
> 
> [eugen.hristev: original author of this code]
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> [nicolas.ferre: original author of this code]
> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> [claudiu.beznea: adapt such that make dtbs_check is happy, remove status
>   for wifi_pwrseq and wifi nodes]
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>

Thanks Claudiu for having handled this work!

I queue it in at91-dt for 5.16.
Best regards,
   Nicolas

> ---
> 
> Changes in v4:
> - keep only this patch as the rest from series were applied on mmc tree
> - remove status="okay" on wifi node and pwrseq node
> - adapt to remove all warnings thown by make dtbs_check
> 
>   arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi | 70 +++++++++++++++++++++
>   1 file changed, 70 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi b/arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi
> index 025a78310e3a..21c86171e462 100644
> --- a/arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi
> +++ b/arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi
> @@ -30,6 +30,14 @@ main_xtal {
>   			clock-frequency = <24000000>;
>   		};
>   	};
> +
> +	wifi_pwrseq: wifi_pwrseq {
> +		compatible = "mmc-pwrseq-wilc1000";
> +		reset-gpios = <&pioA PIN_PA27 GPIO_ACTIVE_HIGH>;
> +		powerdown-gpios = <&pioA PIN_PA29 GPIO_ACTIVE_HIGH>;
> +		pinctrl-0 = <&pinctrl_wilc_pwrseq>;
> +		pinctrl-names = "default";
> +	};
>   };
>   
>   &flx1 {
> @@ -310,5 +318,67 @@ pinctrl_qspi1_default: qspi1_default {
>   			 <PIN_PB10__QSPI1_IO3>;
>   		bias-pull-up;
>   	};
> +
> +	pinctrl_sdmmc1_default: sdmmc1_default {
> +		cmd-data {
> +			pinmux = <PIN_PA28__SDMMC1_CMD>,
> +				 <PIN_PA18__SDMMC1_DAT0>,
> +				 <PIN_PA19__SDMMC1_DAT1>,
> +				 <PIN_PA20__SDMMC1_DAT2>,
> +				 <PIN_PA21__SDMMC1_DAT3>;
> +			bias-disable;
> +		};
> +
> +		conf-ck {
> +			pinmux = <PIN_PA22__SDMMC1_CK>;
> +			bias-disable;
> +		};
> +	};
> +
> +	pinctrl_wilc_default: wilc_default {
> +		conf-irq {
> +			pinmux = <PIN_PB25__GPIO>;
> +			bias-disable;
> +		};
> +	};
> +
> +	pinctrl_wilc_pwrseq: wilc_pwrseq {
> +		conf-ce-nrst {
> +			pinmux = <PIN_PA27__GPIO>,
> +				 <PIN_PA29__GPIO>;
> +			bias-disable;
> +		};
> +
> +		conf-rtcclk {
> +			pinmux = <PIN_PB13__PCK1>;
> +			bias-disable;
> +		};
> +	};
> +};
> +
> +&sdmmc1 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	bus-width = <4>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_sdmmc1_default>;
> +	mmc-pwrseq = <&wifi_pwrseq>;
> +	no-1-8-v;
> +	non-removable;
> +	bus-width = <4>;
> +	status = "okay";
> +
> +	wilc: wifi@0 {
> +		reg = <0>;
> +		compatible = "microchip,wilc1000";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_wilc_default>;
> +		clocks = <&pmc PMC_TYPE_SYSTEM 9>;
> +		clock-names = "rtc";
> +		interrupts = <PIN_PB25 IRQ_TYPE_NONE>;
> +		interrupt-parent = <&pioA>;
> +		assigned-clocks = <&pmc PMC_TYPE_SYSTEM 9>;
> +		assigned-clock-rates = <32768>;
> +	};
>   };
>   
> 


-- 
Nicolas Ferre
