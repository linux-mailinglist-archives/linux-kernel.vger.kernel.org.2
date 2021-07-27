Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 241A33D717A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 10:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236010AbhG0ItL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 04:49:11 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:19438 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236006AbhG0Is5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 04:48:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1627375738; x=1658911738;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=H7cxyPBXpHayUHASlywKvaAintb45qDRBM/KvwBW+N4=;
  b=b0kYZ1N0H5rTHuuuAEqVgFEe/wTMTI5HRaUdVCqjkuBK66jmwTTLvaa3
   2VRKAaDTVjDumkvltKzqMFnUuwZkgbssAZmdYg32ys1/PBooGR6Ha0jJN
   E4KCFEUs0DMxFSg/Jr3OQ/Q3pvumDZ858b4+09diLTisRzfu5vprtepnV
   6sbZnlGqt1XcX7c/qJ1b/a5VPkW7g8OR+TtMaetlyjZf2VkC0bAArAVjo
   Bcn+XPxvRWkU4RFS5sZR8rjb2/3peoTEPx+izNw0YI3SnaGUIGNMAUHw5
   llvTy6vJyBUOu6IyrCMCklEM1PWt4uyia6T6aunB9ehfK3TsQf85Hx1NE
   Q==;
IronPort-SDR: am5gsVYqlFpHkwNzAdymzjWvddYeZU/OQLtV7Y+aTiDu4+HhXRTYq+hNWTzDxp3g1ptFHNub9s
 bh07RRI7+Y6mIEVwnOqjCFRWHyJWyr35LnIsZsQLO0WFieX/qQKkBFDWa/voMhZhamVvkgiUd4
 m/v+E3UEGgBZKaKwscHcORWwWpC+99Wi9XTrzwDO5PdHQNqy5dg48iKWqdnppcrGygLWXl4VFf
 WJoWrn5p8rftX+d343RYMEMNIq6NTYeWiynIJ4l82k2ojolJ1dNrKwH5RB2N2cc/KB7d/EBN9I
 29qupNRemQY2WH9NB4RYu4UA
X-IronPort-AV: E=Sophos;i="5.84,272,1620716400"; 
   d="scan'208";a="123582470"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Jul 2021 01:48:54 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 27 Jul 2021 01:48:54 -0700
Received: from [10.171.246.86] (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Tue, 27 Jul 2021 01:48:52 -0700
Subject: Re: [PATCH] ARM: dts: at91: sama5d27_som1_ek: enable ADC node
To:     Eugen Hristev <eugen.hristev@microchip.com>, <robh+dt@kernel.org>
CC:     <alexandre.belloni@bootlin.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <ludovic.desroches@microchip.com>
References: <20210622101742.14535-1-eugen.hristev@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <85a473cb-e688-f457-1320-390619f07033@microchip.com>
Date:   Tue, 27 Jul 2021 10:48:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210622101742.14535-1-eugen.hristev@microchip.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/06/2021 at 12:17, Eugen Hristev wrote:
> Enable the ADC for AN pins on Mikrobus1 and Mikrobus2 on the board.
> These correspond to channels AD6 and AD7 in the controller.
> 
>   # cat /sys/bus/iio/devices/iio\:device0/in_voltage6_raw
>   240
>   # cat /sys/bus/iio/devices/iio\:device0/in_voltage7_raw
>   16380
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Queued on at91-dt for 5.15. Best regards,
   Nicolas


> ---
>   arch/arm/boot/dts/at91-sama5d27_som1_ek.dts | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts b/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
> index a9e6fee55a2a..261a7dbcfdee 100644
> --- a/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
> +++ b/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
> @@ -224,8 +224,10 @@ i2c1: i2c@fc028000 {
>   			adc: adc@fc030000 {
>   				vddana-supply = <&vddana>;
>   				vref-supply = <&advref>;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&pinctrl_mikrobus1_an &pinctrl_mikrobus2_an>;
>   
> -				status = "disabled";
> +				status = "okay";
>   			};
>   
>   			pinctrl@fc038000 {
> 


-- 
Nicolas Ferre
