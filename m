Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 347AB4360B5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 13:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbhJULti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 07:49:38 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:35080 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbhJULth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 07:49:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1634816841; x=1666352841;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=p+VO7ithOuP0XnGZg+W3xd0diUiv+mQ77fVNQVDV3jU=;
  b=L9vcPFUupbWsX4J12U9EA5lbp82nbb4BeeUfQ23qQ5HEEVepSZBC33DI
   eEsgPEJ9O+SlBTtgYNsGaSNJW93zAJIbq5iert5xRMKCce6QtajnL+RXZ
   3i9UdjApp1bAPjWltMh5yKqQ0oR0Auuni4Rw7cRJBPvLL5rr/fHfyGHd5
   nmx7qepf7GhdzKdSd8fB808t1ss11Sg6E+g0P8i9rbbdhiHRFS55AZLzf
   AmXyfQKHY2xxdt/dqGiYkhj3+DiIyrablu1/WaudxOqqJLpo+qNv6KiSi
   ckFXoPL+hPvEvMuUh/Fi7YvjOZ0UrfjJ+gX6cZtuHMlCHCgIq/QefHjgV
   Q==;
IronPort-SDR: RgqHskO2oQGEMsN1uyJsqOgybAkMqhCKZWAJItUnpXIiuFMVOetI/aD6rNhvP+snoPvJ/7gCTT
 cEsbk/Na8kYgaI7YbN1tuUTkivBq5y75dClVD56x3Vi+z1D2UQyp8GOa0D+6oQ7FGAe4Bg9mnx
 SoZ0JIxZhqUTN7TK3RrXTuR4REc/EWNhLoPHv1x0GY9qGatUpMPfEtC12/gsMDLkLtssd67l3F
 +rTpaP0btExGsnkXPj39AUPv8h8bc5Ym+tnPYg1NCO9/Ny9/gGVwda9Hj0RlLGlj9gReQH7rtZ
 Dcex0BENudHRXBPboLsz1feL
X-IronPort-AV: E=Sophos;i="5.87,169,1631602800"; 
   d="scan'208";a="140598015"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Oct 2021 04:47:21 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 21 Oct 2021 04:47:21 -0700
Received: from [10.159.245.112] (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Thu, 21 Oct 2021 04:47:19 -0700
Subject: Re: [PATCH 0/3] ARM: dts: at91: enable leftover IPs
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20211020094656.3343242-1-claudiu.beznea@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <3e0c9bdb-f224-3c0b-cb11-c089185824d1@microchip.com>
Date:   Thu, 21 Oct 2021 13:47:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211020094656.3343242-1-claudiu.beznea@microchip.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/10/2021 at 11:46, Claudiu Beznea wrote:
> Hi,
> 
> The following series add DT nodes for TCB and RTC blocks on SAMA7G5.
> 
> Thank you,
> Claudiu Beznea

For whole series:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Queued in at91-dt for 5.16. I plan to send a PR tomorrow.

Best regards,
   Nicolas

> Claudiu Beznea (2):
>    ARM: dts: at91: sama7g5: add tcb nodes
>    ARM: dts: at91: sama7g5-ek: use blocks 0 and 1 of TCB0 as cs and ce
> 
> Eugen Hristev (1):
>    ARM: dts: at91: sama7g5: add rtc node
> 
>   arch/arm/boot/dts/at91-sama7g5ek.dts | 12 ++++++++++++
>   arch/arm/boot/dts/sama7g5.dtsi       | 27 +++++++++++++++++++++++++++
>   2 files changed, 39 insertions(+)
> 


-- 
Nicolas Ferre
