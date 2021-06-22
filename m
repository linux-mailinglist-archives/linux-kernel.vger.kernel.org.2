Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE39E3B063C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 15:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbhFVNz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 09:55:57 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:36424 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbhFVNz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 09:55:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1624370020; x=1655906020;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=N+sS5iWqomWqs35o/HzwmRYlU0AVuRGn1OIuvMkrR0w=;
  b=kDtPrTJD/qXXchy82z3zYTqZ3rEbwnM4rStWS5w0rLWz7mScN5e+oGqn
   0N8DAD2UvTzXyVq05kKQ5nnbLZIVUf/rlcfVyOmBVz8ofm2ko3FVPrJ0J
   ak1hJB/JCSACANtA4NiPvZ5rRo5mbaXw+5Hsbw5UylVfwIJfdfMTPPdL1
   nrT5RLf3Pd7644nac4fA1y1VdqbQqvCwjhK1wj8+GU/Rzm5PKEefFA6TU
   PRkAu3frpecISuxqMYjMbSW2UIuHlFveWLJiKYRqrRdWuBjEzjiP9OvwX
   o/HitMUCqtU+QXbh/8z2nkblJRW8vsEaNmM0hXg9fn767fqTk7ZtfJjWb
   Q==;
IronPort-SDR: xOwIE68OalmjixTRvD/jNNVt1J4e+XBTrI4QdB7hrVFK6nL+LiELAWwHjBvxuvqw8x/YzeFIoS
 atspCSmkG+IfRkkqqDD3aNcC/NXGbiH/T5kMJ6gTeb1IALoAQZXGb4J/Vxn2chaYP/mAZHREe5
 aljW01qHXb2aaZW9AdTTAywyo3sf6Dwtf0vMrN5Yjg3A1JiGKeCEG568MRht5Phz7TLGM7fEvW
 SwMsTYZfpnaNuQh9BuVH0jckJrHQYcnol8LVmFzsKUsdVNFuHIC80IJTE3YXHei8OmL5IDKZyF
 jUU=
X-IronPort-AV: E=Sophos;i="5.83,291,1616482800"; 
   d="scan'208";a="126209312"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Jun 2021 06:53:40 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 22 Jun 2021 06:53:40 -0700
Received: from [10.171.246.67] (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Tue, 22 Jun 2021 06:53:38 -0700
Subject: Re: [PATCH] ARM: dts: at91: sama5d4_xplained: Mark optional
 AT25DF321A as disabled
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>
CC:     <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20210622134222.107806-1-tudor.ambarus@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <4d631b4c-7d0c-3a04-5ab6-00d09c792438@microchip.com>
Date:   Tue, 22 Jun 2021 15:53:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210622134222.107806-1-tudor.ambarus@microchip.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tudor,

On 22/06/2021 at 15:42, Tudor Ambarus wrote:
> sama5d4_xplained has an optional on-board serial DataFlash (AT25DF321A),
> which does not come populated on board by default. Mark it as disabled
> to avoid the following probe error:
> spi-nor spi0.0: unrecognized JEDEC id bytes: 00 00 00 00 00 00
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
>   arch/arm/boot/dts/at91-sama5d4_xplained.dts | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/at91-sama5d4_xplained.dts b/arch/arm/boot/dts/at91-sama5d4_xplained.dts
> index 0b3ad1b580b8..f397e2a68e5c 100644
> --- a/arch/arm/boot/dts/at91-sama5d4_xplained.dts
> +++ b/arch/arm/boot/dts/at91-sama5d4_xplained.dts
> @@ -40,7 +40,7 @@ uart0: serial@f8004000 {
>   
>   			spi0: spi@f8010000 {
>   				cs-gpios = <&pioC 3 0>, <0>, <0>, <0>;
> -				status = "okay";
> +				status = "disabled";
>   				m25p80@0 {
>   					compatible = "atmel,at25df321a";
>   					spi-max-frequency = <50000000>;

What about keeping SPI enabled and just having the status of m25p80 as 
disabled: honestly, I don't know if it works and if it's desirable, but 
might be closer to reality.

Tell me what you think.

Regards,
   Nicolas


-- 
Nicolas Ferre
