Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 441604209C4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 13:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbhJDLPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 07:15:32 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:4690 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbhJDLPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 07:15:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1633346023; x=1664882023;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=gOtLf8u+S23bwYD4PNFyGq+Jv7Hn4GfyITDmE5AV+lo=;
  b=Kdh9t9H/Oxn/QUxBfryXDtiQ4e3bbfi9CeREo6PTRJEJLwNNQncnU/Uz
   v4OWKTO2FnLgTj1KLe+JJvQyx9lXh1nxy8SXHELBaKGbJ/1c7M7kpC2/G
   Zh3nLcS1IRSxa5axvy094+vq/fQ6JqQc0EY9JSj4YC90/BbTPWzlvBtyb
   Y0ONxfGuhTf1te5ovP/bnB85IkSs0+710i/IiB555L340PjQLSBNaXHS1
   OqBcQu81pEFu25KsTAZI93Us+1SMUe3lyhwaNEcgcs4jC519ou+TZkDgw
   WOcwNryK0rNqOjzaJDVHEN/fyPgeVj0NDajmjdwMgLVtnZrWfyEMNUOlR
   Q==;
IronPort-SDR: /J0F2B9pTXaOzM4nQU1eHMUgIaAH7uS/3mjvFINYE0Nb0EV7eSibBxGq4ME79oDiNOLGBm/QE5
 41NamRbAEEq6Up/JJbYNKaQEi/l3gdUfEDGeSz+3/Nhln3yqi9G9+DcmVJkfRb0W2XxouK9RbV
 +zs3uFvW7LB2RC9XofKVLGvVOsXECNF5bfrpwYTIiEp7VPXWm69j8J839vPLg/2a+P7gUXLCgR
 93vOf686oeSivlADOkqU5erpmO5ZKdsKH7Md/L30nPjctujAOIPmYB8bxMnIAtBrb9E5Ip+Gof
 zxMjlIPY3q/+QA5mzuSoeeKD
X-IronPort-AV: E=Sophos;i="5.85,345,1624345200"; 
   d="scan'208";a="138355878"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Oct 2021 04:13:42 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 4 Oct 2021 04:13:41 -0700
Received: from [10.12.73.58] (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Mon, 4 Oct 2021 04:13:40 -0700
Subject: Re: [PATCH 0/2] ARM: dts: at91: sama7g5: fixes for sama7g5
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210915074836.6574-1-claudiu.beznea@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <74c845ea-82de-df4c-70de-b8d08eddf3db@microchip.com>
Date:   Mon, 4 Oct 2021 13:13:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210915074836.6574-1-claudiu.beznea@microchip.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/09/2021 at 09:48, Claudiu Beznea wrote:
> Hi,
> 
> The following patches fixes slew rate settings for SAMA7G5's GMACs and
> SDMMCs.
> 
> Thank you,
> Claudiu Beznea
> 
> Claudiu Beznea (2):
>    ARM: dts: at91: sama7g5ek: use proper slew-rate settings for GMACs
>    ARM: dts: at91: sama7g5ek: to not touch slew-rate for SDMMC pins

For both of them:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

And queued in at91-fixes for second batch of fixes for 5.15.

Best regards,
   Nicolas

>   arch/arm/boot/dts/at91-sama7g5ek.dts | 34 +++++++++++++++++++++++-----
>   1 file changed, 28 insertions(+), 6 deletions(-)
> 


-- 
Nicolas Ferre
