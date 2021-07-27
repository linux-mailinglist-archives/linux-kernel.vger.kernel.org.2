Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F31D3D7267
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 11:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236136AbhG0J4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 05:56:22 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:51049 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235950AbhG0J4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 05:56:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1627379781; x=1658915781;
  h=subject:from:to:cc:references:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=3k/EdUisHbJoZXLXTXFdtAGmALCzKPlZkW1MaTQW3bY=;
  b=IXfu2KamoTzOKAAfm4BFAhQ63LXPWcwGOlmXT+FzCHjZyiFlaqxlm1Ri
   3tDdDr/OdWa6LLrST9wbR60h2rkxII5DYbt197KGMdu4ODwML3D5gYYIx
   /iFFbQa6ASge0RxoWOGWoyS5f862kjdzX0069+OJ92PaDyAYlNsBaxS9H
   Bq8hlfyaTziSD678ZK93EAqRjl91j9+LX+IdZuDHreu2PM5RvjreseX6a
   bw0ZfwMjObp1upoACOoEeFLFerXxtGXKWNBDVyDO3xKIP3/tdfqUdr1Ec
   VHKCdZW41OqREedqLLEyll8MEeEVSGCKACqNQeySCQSwrCsKBk9QN/kUe
   Q==;
IronPort-SDR: IqLd0if36UfnB+A9exjhZ9ET3Bwjmh53nPqcKEvI71l4T+UVEMYv1M/aC63YUdP1xpZumk/4+X
 NW9qejvSUijvj6/lw9LrNWrg8ylmO7gu/8UJY5gKQxmbIHaPBBrzP0Tnfzk1/cL9/I98FJOpBf
 JqhUp31NHzIxvYyJgYj8iZfudwdC9Yj1i8ScKom5h71EerjonPovm8j6VoxbElHLIqUW1fYUke
 cmuMDGKp2xrAXUj5bPo9OL/nZZV3vhm5Kap682q026NasGkfCu8SBq+oCKUzHkfx8yXrYSnXw+
 8AnKrzwLHVyhUyPwUNqUjpVZ
X-IronPort-AV: E=Sophos;i="5.84,273,1620716400"; 
   d="scan'208";a="123590372"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Jul 2021 02:56:21 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 27 Jul 2021 02:56:20 -0700
Received: from [10.171.246.86] (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Tue, 27 Jul 2021 02:56:19 -0700
Subject: Re: [PATCH] ARM: dts: at91: sama5d4_xplained: change the key code of
 the gpio key
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
References: <20210727091351.44475-1-nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <030d92ba-920a-4b8e-b48a-d722e8fbca90@microchip.com>
Date:   Tue, 27 Jul 2021 11:56:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210727091351.44475-1-nicolas.ferre@microchip.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/07/2021 at 11:13, nicolas.ferre@microchip.com wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> From: Ludovic Desroches <ludovic.desroches@microchip.com>
> 
> Having a button code and not a key code causes issues with libinput.
> udev won't set ID_INPUT_KEY. If it is forced, then it causes a bug
> within libinput.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>

For the record: added to at91-dt for 5.15.

Regards,
   Nicolas

> ---
>   arch/arm/boot/dts/at91-sama5d4_xplained.dts | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/at91-sama5d4_xplained.dts b/arch/arm/boot/dts/at91-sama5d4_xplained.dts
> index 541779af049f..d241c24f0d83 100644
> --- a/arch/arm/boot/dts/at91-sama5d4_xplained.dts
> +++ b/arch/arm/boot/dts/at91-sama5d4_xplained.dts
> @@ -7,6 +7,7 @@
>    */
>   /dts-v1/;
>   #include "sama5d4.dtsi"
> +#include <dt-bindings/input/input.h>
> 
>   / {
>          model = "Atmel SAMA5D4 Xplained";
> @@ -250,7 +251,7 @@ gpio_keys {
>                  pb_user1 {
>                          label = "pb_user1";
>                          gpios = <&pioE 8 GPIO_ACTIVE_HIGH>;
> -                       linux,code = <0x100>;
> +                       linux,code = <KEY_PROG1>;
>                          wakeup-source;
>                  };
>          };
> --
> 2.32.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 


-- 
Nicolas Ferre
