Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32B3140B230
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 16:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234308AbhINO4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 10:56:22 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:45092 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231816AbhINO4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 10:56:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1631631302; x=1663167302;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=IjFR4kRJRpH81PfAAqBxjNLPUPgdsFh5sAVjP2zjExY=;
  b=rTYbQKL5cxYvwpacP+7glLOtXcdXpkdjwiznwhlSDv45t/QCY1wTfexK
   3GDIV6dAm402KfQg7JV5zNIKYscr1nemZAajnYM/MTCgJFjS9gfTwKG8u
   h4vjjL+7ZrnqcUdgOj0hDq2/FJzNt0uYMwohtARLN+69FUh5UYelrFgMS
   dw0DKka1MUR4qeW3kQ0Zizqqp2WUMGsYzqD51y/WRECLf/8QVQShffl7z
   szBHdkMyB3R24a7Z44itgcnBQKQDaO1a40zgjEbJGfB0e6sRYsKBWmz97
   /Hwezqy0wWgW4/Eml5W/h+45EbmInwvg0jX3hT9W91EwGMY5CsbDTT5R8
   g==;
IronPort-SDR: WgsuTRdUEvBb/bBim9+6LQs+HiHsZAD93+sz2jBX3vGvxDlpezogYYT6614ZRDfbRJAu/V3l7n
 zMUGxzTT1KhojNVkC0bpFpO+VH6GSrcXthkgeAXzRCSTMIP8o9bRheXmuTn08e6smYaiTkACGy
 5aAvyexFhHvpvEtXSCUzn0TF43dLoyQEFaX74EjfsbxCvAaA4MfU8023skkrbwdEpFCIcuWJaK
 EiMrAZzg3fZplCXRe9Tm5XWFsaxBb0MCAaSbKprcmsFoB9VxCSA1qfUJQzvjFLW8ECzn7GQ+cV
 h31XJL/EBml9VkD0Xvb06s1M
X-IronPort-AV: E=Sophos;i="5.85,292,1624345200"; 
   d="scan'208";a="144049782"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Sep 2021 07:55:01 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 14 Sep 2021 07:55:01 -0700
Received: from [10.171.246.26] (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Tue, 14 Sep 2021 07:54:59 -0700
Subject: Re: [PATCH v2 0/4] ARM: at91: add new nodes to DT and fix for PM
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <robh+dt@kernel.org>, <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210823131915.23857-1-claudiu.beznea@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <2406a3ff-9fe0-441e-b4c8-eb8d0e5f7027@microchip.com>
Date:   Tue, 14 Sep 2021 16:54:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210823131915.23857-1-claudiu.beznea@microchip.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/08/2021 at 15:19, Claudiu Beznea wrote:
> Hi,
> 
> The following patches enable UDDRC, DDR3 PHY, SECURAM and SHDWC IPs
> on SAMA7G5.
> 
> Besides this patch 1/1 avoid the panic on PM initialization code allowing
> the system to boot when PM is enabled but not enough information is
> provided in DT.

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Whole series queued to at91-fixes for 5.15 as without these patches the 
SAMA7G5 don't have power management at full capacity.

Best regards,
   Nicolas

> Changes in v2:
> - changes cover letter title from
>    "ARM: dts: at91: enable ips for sama7g5" to
>    "ARM: at91: add new nodes to DT and fix for PM"
> - update the device tree patches title and description
> - added patch "ARM: at91: pm: do not panic if ram controllers are not
>    enabled"
> 
> Claudiu Beznea (4):
>    ARM: at91: pm: do not panic if ram controllers are not enabled
>    ARM: dts: at91: sama7g5: add ram controllers
>    ARM: dts: at91: sama7g5: add securam node
>    ARM: dts: at91: sama7g5: add shdwc node
> 
>   arch/arm/boot/dts/at91-sama7g5ek.dts |  9 ++++
>   arch/arm/boot/dts/sama7g5.dtsi       | 34 ++++++++++++
>   arch/arm/mach-at91/pm.c              | 78 ++++++++++++++++++++++------
>   3 files changed, 105 insertions(+), 16 deletions(-)
> 


-- 
Nicolas Ferre
