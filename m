Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4B6634EAC7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 16:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbhC3Oom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 10:44:42 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:36639 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232048AbhC3OoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 10:44:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617115460; x=1648651460;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=TM/UeIQyanN2fAuJWdspNb7LxLv7a/7pejv6Q0Lp/h0=;
  b=jQlIL3/80Cv2kWhF9T6bLZWoGxBZNrWuZPn1+ldfWbG4/5WjGUUvtZ2s
   cUokp82ooFxDOwTmNrZp+s5d1eP0buFuDgVzznayEANBHBOX9xRD9Mr0d
   yYj0zwrsrOq99hmNZAgV3uxFV56hDvI+gYV7NMkqEmbR5y0W2qTlIg9/l
   nnJGuR8V68RlbyyJGkJRjw+l9xvvhzXsDuKz6z4LeyO7StcnnYy/VVHBh
   uwnAxGCDN4qPw1sWj3X1p/fnuH1juw3ZNQ/qSjeYKSrKoRasvGvcx7oVk
   6yqi3zZCnA9q8qPQvrWcmoqk51GrSRVdlTvC7aHZqK+3j4KanaozPw7Ff
   Q==;
IronPort-SDR: djzAsSeyNsm5XrWA9oSK/q7884UfczOMUM91omyYXGT7UWt8fBhTK6Jxf6lMZSx2tIuo5Ya8ql
 JQ0MSH2jzReRAJdZVapnwdqfqHnIsSfS7B416ltK4w3yH5EzhdsxWFEEAUJ+dmc0q3e398ML8I
 htyEPQsnk14LDvwLRVOxqayzVa0FaOq7CEDV4CMyHTN/Qt5OQHKYKsrnUjydivpwP6PesjLs4Y
 zHX+FmxcOW7gaEbC7hkK4WTW4FHaRKt3QrA2gAZTLW9sPplIGQrmjalCvX4Akk4gIcLEWZ2Ogg
 mRY=
X-IronPort-AV: E=Sophos;i="5.81,291,1610434800"; 
   d="scan'208";a="49410323"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Mar 2021 07:44:20 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 30 Mar 2021 07:44:08 -0700
Received: from [10.171.246.97] (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Tue, 30 Mar 2021 07:44:06 -0700
Subject: Re: [PATCH] ARM: boot: dts: Fix a typo
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <rdunlap@infradead.org>
References: <20210318095237.28436-1-unixbhaskar@gmail.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <6321a5c0-c290-5ca8-239a-d42aed7599c4@microchip.com>
Date:   Tue, 30 Mar 2021 16:44:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210318095237.28436-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/03/2021 at 10:52, Bhaskar Chowdhury wrote:
> s/conlicts/conflicts/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> ---
>   arch/arm/boot/dts/sama5d3.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
> index 7c979652f330..d1841bffe3c5 100644
> --- a/arch/arm/boot/dts/sama5d3.dtsi
> +++ b/arch/arm/boot/dts/sama5d3.dtsi
> @@ -709,7 +709,7 @@ pinctrl_mmc0_dat4_7: mmc0_dat4_7 {
>                                                  atmel,pins =
>                                                          <AT91_PIOD 5 AT91_PERIPH_A AT91_PINCTRL_PULL_UP /* PD5 periph A MCI0_DA4 with pullup, conflicts with TIOA0, PWMH2 */
>                                                           AT91_PIOD 6 AT91_PERIPH_A AT91_PINCTRL_PULL_UP /* PD6 periph A MCI0_DA5 with pullup, conflicts with TIOB0, PWML2 */
> -                                                        AT91_PIOD 7 AT91_PERIPH_A AT91_PINCTRL_PULL_UP /* PD7 periph A MCI0_DA6 with pullup, conlicts with TCLK0, PWMH3 */
> +                                                        AT91_PIOD 7 AT91_PERIPH_A AT91_PINCTRL_PULL_UP /* PD7 periph A MCI0_DA6 with pullup, conflicts with TCLK0, PWMH3 */
>                                                           AT91_PIOD 8 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;       /* PD8 periph A MCI0_DA7 with pullup, conflicts with PWML3 */
>                                          };
>                                  };
> --
> 2.26.2
> 


-- 
Nicolas Ferre
