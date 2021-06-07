Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5582D39D946
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 12:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhFGKIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 06:08:06 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:22394 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbhFGKIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 06:08:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1623060373; x=1654596373;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=lV+AZBr72HWqir4MCHqVszfa7EgnJ+lkCksC2VNYDx4=;
  b=kfcaHWD8aGLCdu5rLzqCWyc1buHRFubx6EHJ4qO0UTJc6wVWLy3wKMLL
   WzZURTSZvm0jWOc6XiX/XBrBWo2oKI9oDE6LmD1U7Fj435wutJl7IVTBx
   JkRl0KD3pzG/Y5SpJzkJ0EV4eJ/la6EABu8W5zBcw8st3xb9djWrGRpME
   d4I1+H6p7QMLhjj/VTKyZZAEAsAZCoFg3FnCDfzZY5ee99yBfAyL1XiCz
   xMujZI+dSqf4RehHOCyCu/4yjFi7AV5kEP3v95MtggtI6qrpu7vY4frkh
   48Z7lLUiYy4moIVfxJelsRK7qJw+DzLZ+naGRM4BjHm/dhl7KBBgMYGal
   w==;
IronPort-SDR: +YLvSTeAFvBOYMKtT8IcvC8VkA8iUt+SA1pANY+AqEgIORKNm7TXq/gQPjxen+IqkvCo5zxS7s
 y5NiqkhRlB9bqI7GGxf3tnlzdBhuIFWscIOuMKY/74MjZ4L7G0W9yw4Vp2yoRe8QFMtobnkxtE
 T5yvmr8IZA9xaXNy+w8cev/tCcDcvMbnpfERRNmBLY7FGzADN5h7agNzklEM+UyAqpuf1wPP3H
 jYb4JuhpNJ29qXv89bkcFssuj83EzPBzHy0vhU1HeHdBPQoFZLUhNVPgy6Y8CWykoQmI3SNc2p
 osY=
X-IronPort-AV: E=Sophos;i="5.83,254,1616482800"; 
   d="scan'208";a="124309901"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Jun 2021 03:06:13 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 7 Jun 2021 03:06:13 -0700
Received: from [10.12.74.44] (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Mon, 7 Jun 2021 03:06:11 -0700
Subject: Re: [PATCH] ARM: configs: at91_dt_defconfig: configs for sam9x60
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20210406141152.10706-1-claudiu.beznea@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <61f275f3-4d5d-23aa-51da-1d30869d855b@microchip.com>
Date:   Mon, 7 Jun 2021 12:06:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210406141152.10706-1-claudiu.beznea@microchip.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2021 at 16:11, Claudiu Beznea wrote:
> Enable CONFIG_NO_HZ_IDLE and CONFIG_HIGH_RES_TIMERS=y to be used
> in conjunction with PIT64B present on SAM9X60.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Now queued in at91-defconfig

Thanks, best regards,
   Nicolas

> ---
>   arch/arm/configs/at91_dt_defconfig | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/configs/at91_dt_defconfig b/arch/arm/configs/at91_dt_defconfig
> index 6403b064e8dc..bd749977b566 100644
> --- a/arch/arm/configs/at91_dt_defconfig
> +++ b/arch/arm/configs/at91_dt_defconfig
> @@ -1,6 +1,8 @@
>   # CONFIG_LOCALVERSION_AUTO is not set
>   # CONFIG_SWAP is not set
>   CONFIG_SYSVIPC=y
> +CONFIG_NO_HZ_IDLE=y
> +CONFIG_HIGH_RES_TIMERS=y
>   CONFIG_LOG_BUF_SHIFT=14
>   CONFIG_BLK_DEV_INITRD=y
>   CONFIG_CC_OPTIMIZE_FOR_SIZE=y
> 


-- 
Nicolas Ferre
