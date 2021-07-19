Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DEB03CD50D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 14:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237094AbhGSMFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 08:05:24 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:13093 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237018AbhGSMFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 08:05:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1626698764; x=1658234764;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=yLRoIPvTygYkIwv7dlQXZQXfrF3+CqCP047UYUYgMDM=;
  b=PBrX9Hyv/25R5a5bBmTHZTVV8IfYj79Fv8Al4C/yShV58+B4Y6188wnr
   Sn8auED6PqBb584SzlpeCwFsLjd1zcZzzAHqhdZZ5zCCiyR1svXtcXIFA
   umyrrUgVuyNjQK1OKJIUY7XwR2pDmtHojLmbxXBxk1WkvSMAizKdwIFKI
   jjOyhFonEjv98reJEmIcaZSDVp9MG6HGC34tYMuvmMBoFJNWLeSKbv+UO
   ugQLZJyAPxRE01U2unAx1zIjpfC/1xmfEkZVU0KfSBEHZu+2IDOhQwqax
   gRQvaHxbhhIih9TnBEAS0H8nOCg96BqPvM0+th+y77EByh7ID9mCXqoAj
   Q==;
IronPort-SDR: lcnFj/fDNWXhCfJ3rljfzAl1AXrFxUY4ujUTIux3kPTx7gIS3JjtYXqdbgK811E4THaqSWlKgK
 HlzuiNFX175zWqrpo4rZa5UBS+rJT7R+xewYQMPyoTpyGSsjBDTQZq8sfp/Zjjm8XEDQkOxQcC
 4rnyoGB5b634aope+lYmGUiuoX0nWSVEXJBynRKMI6/j3MsAMgH1MLE7RCBC6qlXwpgxnlMO2z
 xMPuxiTR42mGfeiXLC6CodoWGwNIxjexzwMhaQ+3/0PS5Sg5MRkdwxTCE3ZySWwGGtSpfP7qmb
 XmeZfkV1Aw0RuLfP58M97g/h
X-IronPort-AV: E=Sophos;i="5.84,252,1620716400"; 
   d="scan'208";a="128841869"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Jul 2021 05:46:03 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 19 Jul 2021 05:46:03 -0700
Received: from [10.12.68.173] (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Mon, 19 Jul 2021 05:46:01 -0700
Subject: Re: [PATCH 2/2] clk: at91: add register definition for sama7g5's
 master clock
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        <linux@armlinux.org.uk>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>
CC:     <eugen.hristev@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <sfr@canb.auug.org.au>
References: <20210719080317.1045832-1-claudiu.beznea@microchip.com>
 <20210719080317.1045832-3-claudiu.beznea@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <3bee1689-5e1d-e65f-e66c-95d4521ea9f4@microchip.com>
Date:   Mon, 19 Jul 2021 14:46:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210719080317.1045832-3-claudiu.beznea@microchip.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/07/2021 at 10:03, Claudiu Beznea wrote:
> Add register definitions for SAMA7G5's master clock. These would be
> also used by architecture specific power saving code.
> 
> Fixes: 6cb0e54412a3 ("ARM: at91: pm: add support for MCK1..4 save/restore for ulp modes")
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

> ---
> 
> Hi Stephen,
> 
> This is a part from patch at [1]. I keep it at minimum (only definitions)
> for faster acceptance as the build is broken on arm multi_v7_defconfig
> without it).
> In next version of patch at [1] I will update it accordingly.

Stephen,

Before hearing from you I inserted this patch in our at91-soc branch 
that is part of linux-next. With this at least the build don't break 
anymore.

Tell me if you want to have an immutable branch that we could share with 
it on top of 5.14-rc1 or if it's fine if we add the same patch in both 
of our trees.

Best regards,
   Nicolas


> [1] https://lore.kernel.org/linux-clk/20210401122726.28528-5-claudiu.beznea@microchip.com/
> 
>   include/linux/clk/at91_pmc.h | 26 ++++++++++++++++++++++++++
>   1 file changed, 26 insertions(+)
> 
> diff --git a/include/linux/clk/at91_pmc.h b/include/linux/clk/at91_pmc.h
> index a4f82e836a7c..ccb3f034bfa9 100644
> --- a/include/linux/clk/at91_pmc.h
> +++ b/include/linux/clk/at91_pmc.h
> @@ -137,6 +137,32 @@
>   #define			AT91_PMC_PLLADIV2_ON		(1 << 12)
>   #define		AT91_PMC_H32MXDIV	BIT(24)
>   
> +#define	AT91_PMC_MCR_V2		0x30				/* Master Clock Register [SAMA7G5 only] */
> +#define		AT91_PMC_MCR_V2_ID_MSK	(0xF)
> +#define			AT91_PMC_MCR_V2_ID(_id)		((_id) & AT91_PMC_MCR_V2_ID_MSK)
> +#define		AT91_PMC_MCR_V2_CMD	(1 << 7)
> +#define		AT91_PMC_MCR_V2_DIV	(7 << 8)
> +#define			AT91_PMC_MCR_V2_DIV1		(0 << 8)
> +#define			AT91_PMC_MCR_V2_DIV2		(1 << 8)
> +#define			AT91_PMC_MCR_V2_DIV4		(2 << 8)
> +#define			AT91_PMC_MCR_V2_DIV8		(3 << 8)
> +#define			AT91_PMC_MCR_V2_DIV16		(4 << 8)
> +#define			AT91_PMC_MCR_V2_DIV32		(5 << 8)
> +#define			AT91_PMC_MCR_V2_DIV64		(6 << 8)
> +#define			AT91_PMC_MCR_V2_DIV3		(7 << 8)
> +#define		AT91_PMC_MCR_V2_CSS	(0x1F << 16)
> +#define			AT91_PMC_MCR_V2_CSS_MD_SLCK	(0 << 16)
> +#define			AT91_PMC_MCR_V2_CSS_TD_SLCK	(1 << 16)
> +#define			AT91_PMC_MCR_V2_CSS_MAINCK	(2 << 16)
> +#define			AT91_PMC_MCR_V2_CSS_MCK0	(3 << 16)
> +#define			AT91_PMC_MCR_V2_CSS_SYSPLL	(5 << 16)
> +#define			AT91_PMC_MCR_V2_CSS_DDRPLL	(6 << 16)
> +#define			AT91_PMC_MCR_V2_CSS_IMGPLL	(7 << 16)
> +#define			AT91_PMC_MCR_V2_CSS_BAUDPLL	(8 << 16)
> +#define			AT91_PMC_MCR_V2_CSS_AUDIOPLL	(9 << 16)
> +#define			AT91_PMC_MCR_V2_CSS_ETHPLL	(10 << 16)
> +#define		AT91_PMC_MCR_V2_EN	(1 << 28)
> +
>   #define AT91_PMC_XTALF		0x34			/* Main XTAL Frequency Register [SAMA7G5 only] */
>   
>   #define	AT91_PMC_USB		0x38			/* USB Clock Register [some SAM9 only] */
> 


-- 
Nicolas Ferre
