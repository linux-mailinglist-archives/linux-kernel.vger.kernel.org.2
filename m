Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75D483CBC3C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 21:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbhGPTSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 15:18:08 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:26706 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbhGPTSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 15:18:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1626462912; x=1657998912;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=8U5DGB2TdzlKP/fZFToSpozYLtnCWs8WBkuswUfkGJw=;
  b=S5QB/kZiRhsOgztv3VKHhPK5KrM5t6iXnX7Gd+/9xb4B50zj0/ThLv++
   KkYZBOGJTpufX7+tn28L81kb8AJjph0bAOLbuBp2C4FoGuu0CuEV6oY1B
   XSKaOrZ+oB/68j97PSde04DrLKZ9IO7Ve+UGbDYEao4g3NnsOgcPNXu0p
   BLpxfN/kv90MRV7fT9ikae51lFC8S2b2DOZKWsSnlH9snHlcNMP1iESBk
   iV9PUaKebosP08DxfHVCQ1wzzR/DaRwblbYFRZXMJIpSbdA+TfNkO0TTQ
   dDsmnCg7xS9KTsKUByJELPojlSdpCy4lDmiZB+s8fDwKMamoAKUlsqlC7
   A==;
IronPort-SDR: ePfvIckaZLnozUk7Lp0p0j1+qPW4QMEdd5b2vyw+qDS6qbHdEYaigaYGrjOTBEo1YETI8gOtr4
 1qOczaLSXyWynmQND7HoCoW0W7xDeF/DioDO0Wyj8bRKYKUJD+VlDIY6rgPQLwm8l5OWcQ1soz
 OFlxGNRBJh2Fuv6o5Rl1P7X7Fjc27D6yx8sQV2oWTITUY6KLAgK5c1EGGTu8OhzJbNcYjWJTy9
 tE9aUFl6wggbvDKZ1kk68AKOW8ydNTqgvBNynmN7gzj1mLXtM+cLHthpwYN05YAF0CjxSoo4oq
 1YV1sn43E2p0iqN5ySY2z9Ua
X-IronPort-AV: E=Sophos;i="5.84,245,1620716400"; 
   d="scan'208";a="62523801"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Jul 2021 12:15:11 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 16 Jul 2021 12:15:11 -0700
Received: from [10.12.72.255] (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Fri, 16 Jul 2021 12:15:09 -0700
Subject: Re: [PATCH v2] ARM: dts: at91: sama5d4_xplained: Remove spi0 node
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>
CC:     <claudiu.beznea@microchip.com>, <eugen.hristev@microchip.com>,
        <codrin.ciubotariu@microchip.com>, <emil.velikov@collabora.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20210716154739.835738-1-tudor.ambarus@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <550ed90d-d28f-d191-f00a-c073e133d063@microchip.com>
Date:   Fri, 16 Jul 2021 21:15:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210716154739.835738-1-tudor.ambarus@microchip.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/07/2021 at 17:47, Tudor Ambarus wrote:
> sama5d4_xplained has an optional on-board serial DataFlash (AT25DF321A),
> which does not come populated on board by default. Since the spi0 node
> does not have any child populated by default, thus no user on
> sama5d4_xplained, remove it. This avoids the following error in SPI NOR,
> which reads the values of the pulled downed lines, unrecognizing the flash:
> 
> spi-nor spi0.0: unrecognized JEDEC id bytes: 00 00 00 00 00 00
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Queued in at91-dt.

Regards,
   Nicolas

> ---
>   arch/arm/boot/dts/at91-sama5d4_xplained.dts | 10 ----------
>   1 file changed, 10 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/at91-sama5d4_xplained.dts b/arch/arm/boot/dts/at91-sama5d4_xplained.dts
> index 0b3ad1b580b8..046796c5b9b0 100644
> --- a/arch/arm/boot/dts/at91-sama5d4_xplained.dts
> +++ b/arch/arm/boot/dts/at91-sama5d4_xplained.dts
> @@ -38,16 +38,6 @@ uart0: serial@f8004000 {
>   				status = "okay";
>   			};
>   
> -			spi0: spi@f8010000 {
> -				cs-gpios = <&pioC 3 0>, <0>, <0>, <0>;
> -				status = "okay";
> -				m25p80@0 {
> -					compatible = "atmel,at25df321a";
> -					spi-max-frequency = <50000000>;
> -					reg = <0>;
> -				};
> -			};
> -
>   			i2c0: i2c@f8014000 {
>   				i2c-digital-filter;
>   				status = "okay";
> 


-- 
Nicolas Ferre
