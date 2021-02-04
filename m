Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E45230FAA4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 19:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238874AbhBDSFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 13:05:05 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:31973 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238788AbhBDSCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 13:02:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1612461728; x=1643997728;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=dnXE7xmcK3Ot2opeYKq2ulphRSXsA/67yehAYHGuSto=;
  b=vqnyaIo5HAC97aAnVqs7MT34RAPab1n0Vq7YhBvz9/8SxNUeGFrx+FUJ
   CTb/DONs6LUURNtzBNrBIe8qWziMrGGaiNkPSjJBiV4bboasMc+jNMmoc
   /YK47wQaXrCsQrQYE+YSgPidsDoVRw3y599S+WKU67Mmdqn81WLmzeK8s
   DzyWWYSPKnZDQqEzRujFySE/59lAPp4z5/z2k52PaLnOjUxbNPLae669p
   gam7SrQaoaGrXP29OfxLhw9opGrJaldIyWwBxd1tP5byPWvCx5i6kX23D
   w5vimnX4pxtPdrrxkLtt3s34lnMweu+u10Aq/FbYhgoQFhDKVLBkHDfmT
   w==;
IronPort-SDR: EeOXda4atNBli6NCN51qD/R7gn6lAcotO4e8x08l9TT9sTqzpzcCaE13vYUcDAJgC72Qf19Yfu
 bfrnvryMLdYRH/mE5Icqntt2KoCaCi6tRGsskkPE+uxsKomhyvybjp4wm8N80+wf5FB1TwSB2R
 i5c1pAiK7rc4LsXJ0u11r5u4O2dJTA4xDgAwEBoUX0/qTe45r/KsAxncZswJNxch5UMn1jkLsc
 5ytVURdwMcaiggSkKU3brsE7yxUdDFpDdCBuMpMPPyH3rJbn8swaoVWIP0XOe5tKgIBbB2BHo2
 rO0=
X-IronPort-AV: E=Sophos;i="5.81,153,1610434800"; 
   d="scan'208";a="113846012"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Feb 2021 11:00:53 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 4 Feb 2021 11:00:52 -0700
Received: from [10.171.246.84] (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 4 Feb 2021 11:00:49 -0700
Subject: Re: [PATCH] drivers: soc: atmel: fix type for same7
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Arnd Bergmann <arnd@kernel.org>
CC:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Kai Stuhlemmer <kai.stuhlemmer@ebee.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20210204154934.1880048-1-arnd@kernel.org>
 <20210204155218.GB3940495@piout.net>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <467e6503-1af5-4eb9-a819-ecc3a52b2451@microchip.com>
Date:   Thu, 4 Feb 2021 19:00:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210204155218.GB3940495@piout.net>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/02/2021 at 16:52, Alexandre Belloni wrote:
> On 04/02/2021 16:49:25+0100, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> A missing comma caused a build failure:
>>
>> drivers/soc/atmel/soc.c:196:24: error: too few arguments provided to function-like macro invocation
>>
>> Fixes: af3a10513cd6 ("drivers: soc: atmel: add per soc id and version match masks")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Thanks Arnd, thanks Alexandre.

As you realized, we didn't compiled with MMU-less types of configuration 
(CONFIG_SOC_SAMV7), sorry about that!

Best regards,
   Nicolas

>> ---
>> It is broken in the soc tree at the moment, I can pick up
>> the fix directly if I get an Ack
>> ---
>>   drivers/soc/atmel/soc.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/soc/atmel/soc.c b/drivers/soc/atmel/soc.c
>> index a2967846809f..a490ad7e090f 100644
>> --- a/drivers/soc/atmel/soc.c
>> +++ b/drivers/soc/atmel/soc.c
>> @@ -191,7 +191,7 @@ static const struct at91_soc socs[] __initconst = {
>>        AT91_SOC(SAME70Q20_CIDR_MATCH, AT91_CIDR_MATCH_MASK,
>>                 AT91_CIDR_VERSION_MASK, SAME70Q20_EXID_MATCH,
>>                 "same70q20", "same7"),
>> -     AT91_SOC(SAME70Q19_CIDR_MATCH, AT91_CIDR_MATCH_MASK
>> +     AT91_SOC(SAME70Q19_CIDR_MATCH, AT91_CIDR_MATCH_MASK,
>>                 AT91_CIDR_VERSION_MASK, SAME70Q19_EXID_MATCH,
>>                 "same70q19", "same7"),
>>        AT91_SOC(SAMS70Q21_CIDR_MATCH, AT91_CIDR_MATCH_MASK,
>> --
>> 2.29.2
>>
> 
> --
> Alexandre Belloni, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
> 


-- 
Nicolas Ferre
