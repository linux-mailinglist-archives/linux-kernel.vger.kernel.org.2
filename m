Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 978A23108F9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 11:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbhBEKYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 05:24:18 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:39363 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbhBEKVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 05:21:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1612520492; x=1644056492;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=tcfAJDncwohmiRretyO/wet4EMTaW11wNI2LIzAPShA=;
  b=nAkzLheDk7RvK8yHfRPfWPPCYwUpemW7ihCckkFLFUL0z8rayaXH8i5q
   CAKPH3eiSrfXImgCW5FY7Z3Wfd8kVG+f/innpBAboD1hjc7W9iyLMHIff
   spTRZM0/KLCnNLB8wZV1gpDRouFvR2lGeRwsKX4G/b8ggac/1o3am2MMW
   B64CAJC2Xq1IQg0GQ+B/DLHxY1lQAfyVVQFRs4rbbi9li/BnMvrZ2Y7WX
   U3PMGmjjFexUvKp8AVoX5zmtgaWSsEDNL9FZl3wGOI9mbt61zexp8MGql
   rDJobLjcGpMNnAnV0yuQAlpJtsm4iJ19//S5zKvmxf4OzXBQyUeZKJYo6
   A==;
IronPort-SDR: yVQIjDFOHIoeWNbWhQPOTZ1acGzmBi/5v3P24pah9rB/W2zGZhGoTxfq4Nl4pkPqdxI2CprCox
 UCBxbqNHjWsaCiy9fL6WKtYibHxCFb3WOP7yExv0aHFPWxZpWSKmEKZBiuNf8RjS05z4MADZvJ
 UPT7Izkt4T29iTk3ob7weadRAjBMB6Sy9ov0MORQmK0KfyjraLcwBSYQgj2EGl2VxXaZHvn6Rs
 DINw92d/ZEIcHr1i8siDqVVDrDsSNheHyJAx7NX0w2zCElScrgKTILKWZHp1pKXZ9qasJiCDni
 WWo=
X-IronPort-AV: E=Sophos;i="5.81,154,1610434800"; 
   d="scan'208";a="108141749"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Feb 2021 03:20:16 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 5 Feb 2021 03:20:14 -0700
Received: from [10.12.68.39] (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 5 Feb 2021 03:20:13 -0700
Subject: Re: [PATCH] ARM: configs: at91: enable drivers for sam9x60
To:     Tudor Ambarus - M18064 <Tudor.Ambarus@microchip.com>,
        "Claudiu Beznea - M18063" <Claudiu.Beznea@microchip.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        Ludovic Desroches - M43218 <Ludovic.Desroches@microchip.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <1612518871-9311-1-git-send-email-claudiu.beznea@microchip.com>
 <56ee9cda-7943-2f5e-c068-51eff7b021b3@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <225500e7-d3c8-f2bf-dd8c-4704c663493d@microchip.com>
Date:   Fri, 5 Feb 2021 11:20:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <56ee9cda-7943-2f5e-c068-51eff7b021b3@microchip.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/02/2021 at 11:12, Tudor Ambarus - M18064 wrote:
> On 2/5/21 11:54 AM, Claudiu Beznea wrote:
>> Enable drivers for sam9x60/sam9x60-ek:
>> - shutdown controller
>> - CAN
>> - AT24 EEPROM (present on SAM9X60-EK)
>> - MCP23S08 (present on SAM9X60-EK)
>> - AES, TDES, SHA
> 
> Crypto IPs are present only sam9x60. Should we have them as modules?

That's fine with me if we keep them as built-in.
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Regards,
   Nicolas

>> And use "make savedefconfig".
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> 
> With or without the Crypto IPs as modules:
> 
> Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
>> ---
>>   arch/arm/configs/at91_dt_defconfig | 12 +++++++-----
>>   1 file changed, 7 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm/configs/at91_dt_defconfig b/arch/arm/configs/at91_dt_defconfig
>> index 5f3415c743ec..e274f8c492d2 100644
>> --- a/arch/arm/configs/at91_dt_defconfig
>> +++ b/arch/arm/configs/at91_dt_defconfig
>> @@ -17,8 +17,6 @@ CONFIG_SOC_SAM9X60=y
>>   # CONFIG_ATMEL_CLOCKSOURCE_PIT is not set
>>   CONFIG_AEABI=y
>>   CONFIG_UACCESS_WITH_MEMCPY=y
>> -CONFIG_ZBOOT_ROM_TEXT=0x0
>> -CONFIG_ZBOOT_ROM_BSS=0x0
>>   CONFIG_ARM_APPENDED_DTB=y
>>   CONFIG_ARM_ATAG_DTB_COMPAT=y
>>   CONFIG_CMDLINE="console=ttyS0,115200 initrd=0x21100000,25165824 root=/dev/ram0 rw"
>> @@ -38,6 +36,8 @@ CONFIG_IP_PNP_BOOTP=y
>>   CONFIG_IP_PNP_RARP=y
>>   # CONFIG_INET_DIAG is not set
>>   CONFIG_IPV6_SIT_6RD=y
>> +CONFIG_CAN=y
>> +CONFIG_CAN_AT91=y
>>   CONFIG_CFG80211=y
>>   CONFIG_MAC80211=y
>>   CONFIG_DEVTMPFS=y
>> @@ -58,6 +58,7 @@ CONFIG_BLK_DEV_RAM=y
>>   CONFIG_BLK_DEV_RAM_COUNT=4
>>   CONFIG_BLK_DEV_RAM_SIZE=8192
>>   CONFIG_ATMEL_SSC=y
>> +CONFIG_EEPROM_AT24=m
>>   CONFIG_SCSI=y
>>   CONFIG_BLK_DEV_SD=y
>>   # CONFIG_SCSI_LOWLEVEL is not set
>> @@ -91,7 +92,6 @@ CONFIG_RT2800USB_UNKNOWN=y
>>   CONFIG_RTL8187=m
>>   CONFIG_RTL8192CU=m
>>   # CONFIG_RTLWIFI_DEBUG is not set
>> -CONFIG_INPUT_POLLDEV=y
>>   CONFIG_INPUT_JOYDEV=y
>>   CONFIG_INPUT_EVDEV=y
>>   # CONFIG_KEYBOARD_ATKBD is not set
>> @@ -111,8 +111,8 @@ CONFIG_I2C_GPIO=y
>>   CONFIG_SPI=y
>>   CONFIG_SPI_ATMEL=y
>>   CONFIG_SPI_ATMEL_QUADSPI=y
>> +CONFIG_PINCTRL_MCP23S08=m
>>   CONFIG_POWER_RESET=y
>> -# CONFIG_POWER_RESET_AT91_SAMA5D2_SHDWC is not set
>>   CONFIG_POWER_SUPPLY=y
>>   # CONFIG_HWMON is not set
>>   CONFIG_WATCHDOG=y
>> @@ -208,7 +208,9 @@ CONFIG_NLS_UTF8=y
>>   CONFIG_CRYPTO_ECB=y
>>   CONFIG_CRYPTO_USER_API_HASH=m
>>   CONFIG_CRYPTO_USER_API_SKCIPHER=m
>> -# CONFIG_CRYPTO_HW is not set
>> +CONFIG_CRYPTO_DEV_ATMEL_AES=y
>> +CONFIG_CRYPTO_DEV_ATMEL_TDES=y
>> +CONFIG_CRYPTO_DEV_ATMEL_SHA=y
>>   CONFIG_CRC_CCITT=y
>>   CONFIG_FONTS=y
>>   CONFIG_FONT_8x8=y
>> --
>> 2.7.4
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
> 


-- 
Nicolas Ferre
