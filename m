Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4901335883E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 17:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbhDHPZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 11:25:00 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:25890 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbhDHPY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 11:24:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617895488; x=1649431488;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=u6Zd5gHK15XZ96TCqv4rGVGxDiJcq1/ihXydIACao3Y=;
  b=M8eSaXHKvGg6PHvuCwcJndYlHh3+DwVnshkAIHQ2yX2znvh8ol6X66Ab
   Bcwh7P0U0HuIaXzVQPInvsH96nmJRsA/m/309SPIwyVB0g0Nhj/I0vk8m
   Rot3212l0Uz4x8sHCaOvYo4W7pSMKm/D2dqDh7xFCQm5QlmiH9THCCTEn
   InMx4gStmWUSmDyQpxmm/AIeuB9RmZNgbO/jVQ8RriXvb/xrTQGyvY04k
   u6VIslLPPsjhDwKuYelFpR1NHE2rqHdG6mmnxVmEVaa9Q/0p7223bzSds
   g0leWwWwxGFiG53CiRtC8wKgqGui0OXzl9S1BtbrlQGceL70CF3+Qr4BH
   w==;
IronPort-SDR: hd9Gq1kIB/1wl4RSQFt5qkbChDr2f1DGZRoSvOLxd6HybmI7nuSaJ+8FglGfgc2oH4IWNVbR39
 NShTFsvj0/eMOP/IFn71kwKFVaVdJuLyUQcpYX82mNK2VIQqIOaZ1LjztedGN7xTCKvhqsdtQ3
 ouDBJDb/ebJxPRPiilcaIcoBt2CO3oZvtnqMmJfRRyp3V274medZydCXM3Emc1dnkOj6D+wubd
 IAekEwyxeKPZjprG8CWFRbP7LXmEYv/Sl9m9g1nncOmq+vvyIoSR7x5iMyEOL2hfC5aPmQVA80
 Oj8=
X-IronPort-AV: E=Sophos;i="5.82,206,1613458800"; 
   d="scan'208";a="112913194"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Apr 2021 08:24:47 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 8 Apr 2021 08:24:42 -0700
Received: from [10.12.88.246] (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Thu, 8 Apr 2021 08:24:40 -0700
Subject: Re: [PATCH 22/24] ARM: at91: sama7: introduce sama7 SoC family
To:     Claudiu Beznea - M18063 <Claudiu.Beznea@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     Ludovic Desroches - M43218 <Ludovic.Desroches@microchip.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Eugen Hristev - M18282 <Eugen.Hristev@microchip.com>
References: <20210331105908.23027-1-claudiu.beznea@microchip.com>
 <20210331105908.23027-23-claudiu.beznea@microchip.com>
 <YGSc1L8yW0KniOsx@piout.net>
 <a908274a-c4d2-faab-54a4-31fd0ffeab7e@microchip.com>
 <21bd4417-a754-8ee6-370e-4fb4e0f1fef9@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <51dbcf0b-4ee6-10c9-9598-a451cca16905@microchip.com>
Date:   Thu, 8 Apr 2021 17:24:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <21bd4417-a754-8ee6-370e-4fb4e0f1fef9@microchip.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/04/2021 at 12:24, Claudiu Beznea - M18063 wrote:
> On 01.04.2021 12:38, Claudiu Beznea - M18063 wrote:
>> On 31.03.2021 19:01, Alexandre Belloni wrote:
>>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>>
>>> On 31/03/2021 13:59:06+0300, Claudiu Beznea wrote:
>>>> From: Eugen Hristev <eugen.hristev@microchip.com>
>>>>
>>>> Introduce new family of SoCs, sama7, and first SoC, sama7g5.
>>>>
>>>> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
>>>> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
>>>> ---
>>>>   arch/arm/mach-at91/Makefile |  1 +
>>>>   arch/arm/mach-at91/sama7.c  | 48 +++++++++++++++++++++++++++++++++++++
>>>>   2 files changed, 49 insertions(+)
>>>>   create mode 100644 arch/arm/mach-at91/sama7.c
>>>>
>>>> diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
>>>> index f565490f1b70..6cc6624cddac 100644
>>>> --- a/arch/arm/mach-at91/Makefile
>>>> +++ b/arch/arm/mach-at91/Makefile
>>>> @@ -9,6 +9,7 @@ obj-$(CONFIG_SOC_AT91SAM9)    += at91sam9.o
>>>>   obj-$(CONFIG_SOC_SAM9X60)    += sam9x60.o
>>>>   obj-$(CONFIG_SOC_SAMA5)              += sama5.o
>>>>   obj-$(CONFIG_SOC_SAMV7)              += samv7.o
>>>> +obj-$(CONFIG_SOC_SAMA7)              += sama7.o
>>>>
>>>>   # Power Management
>>>>   obj-$(CONFIG_ATMEL_PM)               += pm.o pm_suspend.o
>>>> diff --git a/arch/arm/mach-at91/sama7.c b/arch/arm/mach-at91/sama7.c
>>>> new file mode 100644
>>>> index 000000000000..e04cadb569ad
>>>> --- /dev/null
>>>> +++ b/arch/arm/mach-at91/sama7.c
>>>> @@ -0,0 +1,48 @@
>>>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>>> +/*
>>>> + * Setup code for SAMA7
>>>> + *
>>>> + * Copyright (C) 2021 Microchip Technology, Inc. and its subsidiaries
>>>> + *
>>>> + */
>>>> +
>>>> +#include <linux/of.h>
>>>> +#include <linux/of_platform.h>
>>>> +
>>>> +#include <asm/mach/arch.h>
>>>> +#include <asm/system_misc.h>
>>>> +
>>>> +#include "generic.h"
>>>> +
>>>> +static void __init sama7_common_init(void)
>>>> +{
>>>> +     of_platform_default_populate(NULL, NULL, NULL);
>>>
>>> Is this necessary? This is left as a workaround for the old SoCs using
>>> pinctrl-at91. I guess this will be using pio4 so this has to be removed.
>>
>> OK, I'll have a look. BTW, SAMA5D2 which is also using PIO4 calls
>> of_platform_default_populate(NULL, NULL, NULL);
> 
> Without this call the PM code (arch/arm/mach-at/pm.c) is not able to locate
> proper DT nodes:
> 
> [    0.194615] at91_pm_backup_init: failed to find securam device!
> [    0.201393] at91_pm_sram_init: failed to find sram device!
> [    0.207449] AT91: PM not supported, due to no SRAM allocated

Okay, so we can't afford removing these calls to sama5d2 and upcoming 
sama7g5 right now.

Is it a common pattern to have to reach DT content in the early stages 
that explicit call to of_platform_default_populate() tries to solve?

Best regards,
   Nicolas


>>>> +}
>>>> +
>>>> +static void __init sama7_dt_device_init(void)
>>>> +{
>>>> +     sama7_common_init();
>>>> +}
>>>> +
>>>> +static const char *const sama7_dt_board_compat[] __initconst = {
>>>> +     "microchip,sama7",
>>>> +     NULL
>>>> +};
>>>> +
>>>> +DT_MACHINE_START(sama7_dt, "Microchip SAMA7")
>>>> +     /* Maintainer: Microchip */
>>>> +     .init_machine   = sama7_dt_device_init,
>>>> +     .dt_compat      = sama7_dt_board_compat,
>>>> +MACHINE_END
>>>> +
>>>> +static const char *const sama7g5_dt_board_compat[] __initconst = {
>>>> +     "microchip,sama7g5",
>>>> +     NULL
>>>> +};
>>>> +
>>>> +DT_MACHINE_START(sama7g5_dt, "Microchip SAMA7G5")
>>>> +     /* Maintainer: Microchip */
>>>> +     .init_machine   = sama7_dt_device_init,
>>>> +     .dt_compat      = sama7g5_dt_board_compat,
>>>> +MACHINE_END
>>>> +
>>>> --
>>>> 2.25.1
>>>>
>>>
>>> --
>>> Alexandre Belloni, co-owner and COO, Bootlin
>>> Embedded Linux and Kernel engineering
>>> https://bootlin.com
>>>
>>
> 


-- 
Nicolas Ferre
