Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B88A4130A4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 11:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbhIUJTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 05:19:00 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:50140 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbhIUJS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 05:18:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1632215850; x=1663751850;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=hUMllGOoYzTmjqIhqnZOzOKkorjLROGbWzbTKWsglI0=;
  b=RQaIcbo5C+ym4EdtWqUAKh12C4E0SPIFuQxGkI3/w3k2Nu/VhuPhqlfo
   XYOFgWRNJ4prefin2R8FK41HLvJ3lkBYvcqbAkXXbwZikWlbEOWq/5Hzy
   r3ADJoNnQ8GKxauH06EHrVvxR5x2bmGJKZc87DChfG7Xvks0XyvQImTRo
   7SqNdstBAK/Gc0EbZm4e+2TiL+7lntAgaw6xtaXhWVi8ZrdO3WFTvK6Mg
   1L5C+OzL6qD+zTHjn/wynGZwwncBcSZzA3hpWnE09lZKdQQ0dhN/z3gqY
   xR5/rzLSzBJhDTtiHKubS/1mQy/xuu1UEn0bVF5aQjeHLibM1E5mb5Lkk
   Q==;
IronPort-SDR: qXwr1fKg7YRNfsAqJeecQc0Ppb6TUDRG0T/571J1Ma61N2PCLs3bhy8vVZj6NuLUAfZqs4Esfe
 4MYdxkuSIVMI0RXmUbX2GiDQHCUk1/akrTTXpYcgPur+Kp0MQMLONF+ednVu46Ij2JudqU2gX8
 8Y6nmTyaTFKc46TvL2xhD96SCXmWTo3RfizQRHc1KSd+fClrMNeWX1OTFV/AI3u2lvgTJcf7Ed
 XX+pxYiGFKFBLopCBfVSv+Zbd79OdOU/08tbs6MG3uC69nB3B2boGQnPMU2VJ8RJ1nIIIn4qI1
 HCH9kU27Mm/R4EsqYIKpHR6z
X-IronPort-AV: E=Sophos;i="5.85,310,1624345200"; 
   d="scan'208";a="144948671"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Sep 2021 02:17:30 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 21 Sep 2021 02:17:30 -0700
Received: from [10.171.246.85] (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Tue, 21 Sep 2021 02:17:28 -0700
Subject: Re: [PATCH] ARM: dts: at91-sama5d2_icp.dts: Added I2C bus recovery
 support
To:     Durai Manickam KR <durai.manickamkr@microchip.com>,
        <robh+dt@kernel.org>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Hari.PrasathGE@microchip.com>
References: <20210921064344.889304-1-durai.manickamkr@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <55cb9b7f-f49b-13ce-77e3-1377e714ee45@microchip.com>
Date:   Tue, 21 Sep 2021 11:17:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210921064344.889304-1-durai.manickamkr@microchip.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/2021 at 08:43, Durai Manickam KR wrote:
> SDA and SCL is configured as GPIO for I2C bus to recover during
> I2C bus malfunction.
> 
> Signed-off-by: Durai Manickam KR <durai.manickamkr@microchip.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
And queued on at91-dt for 5.16.

Thanks, best regards,
   Nicolas

> ---
>   arch/arm/boot/dts/at91-sama5d2_icp.dts | 22 ++++++++++++++++++++--
>   1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/at91-sama5d2_icp.dts b/arch/arm/boot/dts/at91-sama5d2_icp.dts
> index e06b58724ca8..806eb1d911d7 100644
> --- a/arch/arm/boot/dts/at91-sama5d2_icp.dts
> +++ b/arch/arm/boot/dts/at91-sama5d2_icp.dts
> @@ -307,8 +307,11 @@ regulator-state-mem {
>   };
>   
>   &i2c0 { /* mikrobus i2c */
> -	pinctrl-names = "default";
> +	pinctrl-names = "default", "gpio";
>   	pinctrl-0 = <&pinctrl_mikrobus_i2c>;
> +	pinctrl-1 = <&pinctrl_i2c0_gpio>;
> +	sda-gpios = <&pioA PIN_PD21 GPIO_ACTIVE_HIGH>;
> +	scl-gpios = <&pioA PIN_PD22 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>   	i2c-digital-filter;
>   	i2c-digital-filter-width-ns = <35>;
>   	status = "okay";
> @@ -316,8 +319,11 @@ &i2c0 { /* mikrobus i2c */
>   
>   &i2c1 {
>   	dmas = <0>, <0>;
> -	pinctrl-names = "default";
> +	pinctrl-names = "default", "gpio";
>   	pinctrl-0 = <&pinctrl_i2c1_default>;
> +	pinctrl-1 = <&pinctrl_i2c1_gpio>;
> +	sda-gpios = <&pioA PIN_PD19 GPIO_ACTIVE_HIGH>;
> +	scl-gpios = <&pioA PIN_PD20 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>   	i2c-digital-filter;
>   	i2c-digital-filter-width-ns = <35>;
>   	status = "okay";
> @@ -402,6 +408,12 @@ pinctrl_i2c1_default: i2c1_default {
>   		bias-disable;
>   	};
>   
> +	pinctrl_i2c1_gpio: i2c1_gpio {
> +                pinmux = <PIN_PD19__GPIO>,
> +                         <PIN_PD20__GPIO>;
> +                bias-disable;
> +        };
> +
>   	pinctrl_key_gpio_default: key_gpio_default {
>   		pinmux = <PIN_PD0__GPIO>;
>   		bias-pull-up;
> @@ -463,6 +475,12 @@ pinctrl_mikrobus_i2c: mikrobus_i2c {
>   		bias-disable;
>   	};
>   
> +	pinctrl_i2c0_gpio: i2c0_gpio {
> +		pinmux = <PIN_PD21__GPIO>,
> +			 <PIN_PD22__GPIO>;
> +		bias-disable;
> +	};
> +
>   	pinctrl_mikrobus1_an: mikrobus1_an {
>   		pinmux = <PIN_PD26__GPIO>;
>   		bias-disable;
> 


-- 
Nicolas Ferre
