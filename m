Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 932C63CD4F2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 14:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237064AbhGSL7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 07:59:52 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:42442 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbhGSL7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 07:59:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1626698431; x=1658234431;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=LphTvQ9qQb/eskQE8zd6P6M+Q9NSt9+K+RJ/M9CLCnk=;
  b=VCa+slt6zz3ZgNoaMWlaqZYImO2IHDjduH/lJxiGyn4NkFCF92au1HDD
   PujFVXTjDrijGqibylZ43eYyV9q89bDQa3bziz/hrxw/XkYvkQdagtar8
   DAeD2lvbBVlzVWDphJNpGXwfWLfj4gYFwhXGaVdj18Ivr3DQB9LM/ExWh
   oa/Bl2PDKk+uinCDTFS5XFekRH8j84ZYjv1rISY1COwUaNXLcLr4M90Ck
   RfLvxo9I2ZyhV2h7f/2vvbh9Mk/8xXZoH0i4wsP/wlkmjqDKNfSGrYp4K
   pfSM9gOk6Hjwv/QaaUwrVFhsQfhgydmW0U619rzIzyIY3Ku7s1XBrMQUl
   g==;
IronPort-SDR: O6qEEB/cRuNp99ePHwqQGzBnFR4+MHFMQO8aNZH3MyRvSWZOznqmb4irre1NphFj9W+Y/h6Zx4
 VQHfczD3gXm/b6nF6pLaSaNo2eypDYBYl6dS1PxiPifyi+U4w4FdXkbt3E+6D+Glcr6W4MM9Mt
 sav8EcTDM6jdmQ1aN0oek+Eck3zZxdAFOSQponaLrhzchmKKt0UJDOiLT3GKzr34zxx/+dAUUT
 03IXas2r7Vn8Pei3M+xzcEIzBFb61lP6CebLXCgfShknH3GpWtV1cnZWVrQLf0jnVApnpEtR9R
 LfCFcDtiSxEvjCI6HQGiiZWe
X-IronPort-AV: E=Sophos;i="5.84,252,1620716400"; 
   d="scan'208";a="125075524"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Jul 2021 05:40:30 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 19 Jul 2021 05:40:30 -0700
Received: from [10.12.68.173] (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Mon, 19 Jul 2021 05:40:28 -0700
Subject: Re: [PATCH 1/2] ARM: at91: fix link error
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        <linux@armlinux.org.uk>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>
CC:     <eugen.hristev@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <sfr@canb.auug.org.au>
References: <20210719080317.1045832-1-claudiu.beznea@microchip.com>
 <20210719080317.1045832-2-claudiu.beznea@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <9f5f6c1b-835c-46ae-6466-70aaafccd6e9@microchip.com>
Date:   Mon, 19 Jul 2021 14:40:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210719080317.1045832-2-claudiu.beznea@microchip.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Claudiu,

On 19/07/2021 at 10:03, Claudiu Beznea wrote:
> PM support for SAMA7G5 has been submitted to mailing list before SAMA7G5
> soc support thus the SAMA7G5 was not present in AT91 Kconfig file at
> that moment. SoC support for SAMA7G5 hasn't added the proper PM flags to
> Kconfig thus the link error bellow:
> 
> arch/arm/mach-at91/sama7.o: In function `sama7_dt_device_init':
> sama7.c:(.init.text+0x18): undefined reference to `sama7_pm_init'
> make: *** [Makefile:1176: vmlinux] Error 1
> 
> Add proper flags to AT91 Kconfig file to solve the issue.
> 
> Fixes: 5617a08dd9e1 ("ARM: at91: pm: add pm support for SAMA7G5")
> Fixes: 18d694ecd91e ("ARM: at91: add new SoC sama7g5")
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>   arch/arm/mach-at91/Kconfig | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
> index f52b46bccd85..b09bb2279f7f 100644
> --- a/arch/arm/mach-at91/Kconfig
> +++ b/arch/arm/mach-at91/Kconfig
> @@ -204,6 +204,9 @@ config ATMEL_PM
>   config SOC_SAMA7
>   	bool
>   	select ARM_GIC
> +	select ATMEL_PM if PM
> +	select ATMEL_SDRAMC
>   	select MEMORY
>   	select SOC_SAM_V7
> +	select SRAM if PM

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

I squashed this patch in 18d694ecd91e ("ARM: at91: add new SoC 
sama7g5"), verified that it compiles and rebased the at91-soc branch on 
it. The commit message is as follow (wrapped):

ARM: at91: add new SoC sama7g5

Add new SoC from at91 family : sama7g5

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
[claudiu.beznea@microchip.com: Select PLL, generic clock and UTMI 
support, add PM configs]
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Link: 
https://lore.kernel.org/r/20210409113116.482199-1-eugen.hristev@microchip.com
Link: 
https://lore.kernel.org/r/20210719080317.1045832-2-claudiu.beznea@microchip.com

Added lore link will allow us to trace this part of the discussion.
Here is the new branch:
https://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.git/log/?h=at91-soc

Tell me if it's good for you.

Thanks for having fixed that so quickly. Best regards,
   Nicolas


-- 
Nicolas Ferre
