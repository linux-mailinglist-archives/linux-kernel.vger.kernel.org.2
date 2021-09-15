Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C104040C25A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 11:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237017AbhIOJGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 05:06:34 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:60288 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233048AbhIOJGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 05:06:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1631696714; x=1663232714;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=J9NSTBFBDD6Euze/JyKQc/2xOsESGf+Cb3hPj272mA4=;
  b=e4DwLs7y8SMIu9X7hPdqT2UoHxEMUlBlvSf9pQnrETot8OmV4fjxpjNa
   SiPbOiBBF+TyFi+PWYaHeJwqEm484uwlq9Dths2KZMRlIzY/S9P1M+8rU
   TmdRgS8SpE4lKjovDwv1K9tJf8h+ICUzqeVNCGsu5CJA5GJyCXRMmGxxC
   FERthqQsVKm0OGqq0iTbr+oDx18xAItT/dDwLsFue4eqDgbPoBKr+9pGK
   JjBuiiSTfGKum9JAAEkU/PmK9XfMkO0FYRwn1meyiQRc7fFCRzhC2yxDp
   Zzx6CMOKvMH410NM4f8o/Xkc6qLn99ePgMd1EQjG2skh4SZW4DHF5j8oa
   A==;
IronPort-SDR: 0B1ZF6LPSY9Q11FQ9mnvDdQ0pZ31w1VR2cRwuJaD+qj3S94L8zg1/7BwVIalRQn4hdg76GiIv5
 egkuaHwe4EgkzRpfPLmtfSpkbOYNVE/5/DWtcU4W2GLeCLciP7AT9ZvO40wEzaU6H3iUHD39k/
 Unuz27bojy94ssIhdPSTid4jbAR/PUseaSLXq/LN0aJBp3pEoUOLf/FCMPOlXFSgit07H33iel
 s3NfChqpkHkOPbsAFfjCuuBYTh0N4tJnt6zC4ID3sG79ALZq00LnJ+MPGFu6/Z5I8OuN3nQXL5
 Lql0igsXpZpkFl7poaTHT7L4
X-IronPort-AV: E=Sophos;i="5.85,295,1624345200"; 
   d="scan'208";a="69372614"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Sep 2021 02:05:13 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 15 Sep 2021 02:05:12 -0700
Received: from [10.171.246.91] (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Wed, 15 Sep 2021 02:05:11 -0700
Subject: Re: [PATCH] ARM: dts: at91-sama5d27_som1_ek: Added I2C bus recovery
 support
To:     Durai Manickam KR <durai.manickamkr@microchip.com>,
        <robh+dt@kernel.org>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Hari.PrasathGE@microchip.com>
References: <20210914052113.85695-1-durai.manickamkr@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <e154c093-222d-0d84-9dba-45277c61cb5e@microchip.com>
Date:   Wed, 15 Sep 2021 11:05:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210914052113.85695-1-durai.manickamkr@microchip.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/09/2021 at 07:21, Durai Manickam KR wrote:
> SDA and SCL is configured as GPIO for I2C bus to recover during
> I2C bus malfunction.
> 
> Signed-off-by: Durai Manickam KR <durai.manickamkr@microchip.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Queued in at91-dt for 5.16.

Thanks Durai, best regards,
   Nicolas

> ---
>   arch/arm/boot/dts/at91-sama5d27_som1.dtsi   | 12 ++++++++++-
>   arch/arm/boot/dts/at91-sama5d27_som1_ek.dts | 23 +++++++++++++++++++--
>   2 files changed, 32 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/at91-sama5d27_som1.dtsi b/arch/arm/boot/dts/at91-sama5d27_som1.dtsi
> index e3251f3e3eaa..edce6bcf6cd6 100644
> --- a/arch/arm/boot/dts/at91-sama5d27_som1.dtsi
> +++ b/arch/arm/boot/dts/at91-sama5d27_som1.dtsi
> @@ -8,6 +8,7 @@
>    */
>   #include "sama5d2.dtsi"
>   #include "sama5d2-pinfunc.h"
> +#include <dt-bindings/gpio/gpio.h>
>   
>   / {
>   	model = "Atmel SAMA5D27 SoM1";
> @@ -95,8 +96,11 @@ ethernet-phy@7 {
>   
>   			i2c0: i2c@f8028000 {
>   				dmas = <0>, <0>;
> -				pinctrl-names = "default";
> +				pinctrl-names = "default", "gpio";
>   				pinctrl-0 = <&pinctrl_i2c0_default>;
> +				pinctrl-1 = <&pinctrl_i2c0_gpio>;
> +				sda-gpios = <&pioA PIN_PD21 GPIO_ACTIVE_HIGH>;
> +				scl-gpios = <&pioA PIN_PD22 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>   				status = "okay";
>   
>   				at24@50 {
> @@ -113,6 +117,12 @@ pinctrl_i2c0_default: i2c0_default {
>   					bias-disable;
>   				};
>   
> +				pinctrl_i2c0_gpio: i2c0_gpio {
> +					pinmux = <PIN_PD21__GPIO>,
> +						 <PIN_PD22__GPIO>;
> +					bias-disable;
> +				};
> +
>   				pinctrl_qspi1_default: qspi1_default {
>   					sck_cs {
>   						pinmux = <PIN_PB5__QSPI1_SCK>,
> diff --git a/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts b/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
> index 614999dcb990..0f10e05d6e23 100644
> --- a/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
> +++ b/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
> @@ -131,8 +131,11 @@ i2c3: i2c@600 {
>   					i2c-analog-filter;
>   					i2c-digital-filter;
>   					i2c-digital-filter-width-ns = <35>;
> -					pinctrl-names = "default";
> +					pinctrl-names = "default", "gpio";
>   					pinctrl-0 = <&pinctrl_mikrobus_i2c>;
> +					pinctrl-1 = <&pinctrl_i2c3_gpio>;
> +					sda-gpios = <&pioA PIN_PA24 GPIO_ACTIVE_HIGH>;
> +					scl-gpios = <&pioA PIN_PA23 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>   					status = "okay";
>   				};
>   			};
> @@ -216,8 +219,11 @@ i2c1: i2c@fc028000 {
>   				i2c-analog-filter;
>   				i2c-digital-filter;
>   				i2c-digital-filter-width-ns = <35>;
> -				pinctrl-names = "default";
> +				pinctrl-names = "default", "gpio";
>   				pinctrl-0 = <&pinctrl_i2c1_default>;
> +				pinctrl-1 = <&pinctrl_i2c1_gpio>;
> +				sda-gpios = <&pioA PIN_PD4 GPIO_ACTIVE_HIGH>;
> +				scl-gpios = <&pioA PIN_PD5 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>   				status = "okay";
>   			};
>   
> @@ -253,6 +259,13 @@ pinctrl_i2c1_default: i2c1_default {
>   					bias-disable;
>   				};
>   
> +				pinctrl_i2c1_gpio: i2c1_gpio {
> +                                        pinmux = <PIN_PD4__GPIO>,
> +                                                 <PIN_PD5__GPIO>;
> +                                        bias-disable;
> +                                };
> +
> +
>   				pinctrl_isc_base: isc_base {
>   					pinmux = <PIN_PC21__ISC_PCK>,
>   						 <PIN_PC22__ISC_VSYNC>,
> @@ -442,6 +455,12 @@ pinctrl_mikrobus_i2c: mikrobus1_i2c {
>   					bias-disable;
>   				};
>   
> +				pinctrl_i2c3_gpio: i2c3_gpio {
> +					pinmux = <PIN_PA24__GPIO>,
> +						 <PIN_PA23__GPIO>;
> +					bias-disable;
> +				};
> +
>   				pinctrl_flx4_default: flx4_uart_default {
>   					pinmux = <PIN_PC28__FLEXCOM4_IO0>,
>   						 <PIN_PC29__FLEXCOM4_IO1>,
> 


-- 
Nicolas Ferre
