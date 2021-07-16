Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 873CF3CBB63
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 19:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbhGPRxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 13:53:04 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:14562 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbhGPRxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 13:53:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1626457808; x=1657993808;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=Gy8vnRnpytrjXGRVLCZW4tMwNF7RWTvg3AMBlhrTbEQ=;
  b=n3xARnS2uwd+67Wcbh8zAQiXicajtZDpSCq68/vXye/iaqFfe/Z40Btd
   uNNxOtm8etgY9FYSCUSw7wisHqxivKaMLz3vStJ+4ErVNOtfOdslbhGgN
   vSL5V2G5Vvw+rcz++6nMzAxhBELC0hQxiOx50HbFsqC13Z2Tf8OBOMHku
   gBGrvuOdn2ThXY5j9pVdCcrfqCO3tHSccx7/UXA+Fc7RFlQ1xEajc61nT
   HSGgeDA8YQojdBSrudHEOZR6pjZO0fPto6D6SRHRmAYErTMUDthaUKrEU
   mIhrHYnTCbqnUI6oeX1LKTanASFbrAXH/hAXD5rHF4xSdMdPSERsZyPny
   g==;
IronPort-SDR: byR7ulJ4gpMZhxy9XTHH5LtX5NWbMVLLNolKRLEcDyHMYghNFk/L091EjwAuASmTo85XFppckM
 sYnC9q6dZ+u15/m4LLSUSIt1w9O0yclS1KeJuJmbVRNqVpM/qiTBUUGqUBE3mBg1aR2+bKDIHr
 vz6WtiwPKppfJu7nbUsSMBN+Fcivz/qVB4vTkmVztWGIpgfbpIevLn0huP4ibLfgLdPP683V93
 IJAYcUX3tyUQU0f8UiXEhpHOd9Lbr11lj4D91yhhfEx/GCNLHd0A8wu+Yhmq9aX8TLbssOm299
 Czgh0r9vt1onaOPntAaXS2la
X-IronPort-AV: E=Sophos;i="5.84,245,1620716400"; 
   d="scan'208";a="128592115"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Jul 2021 10:50:08 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 16 Jul 2021 10:50:07 -0700
Received: from [10.12.72.255] (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Fri, 16 Jul 2021 10:50:06 -0700
Subject: Re: [PATCH v2 1/2] ARM: at91: add new SoC sama7g5
To:     Eugen Hristev <eugen.hristev@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <alexandre.belloni@bootlin.com>
CC:     <linux-kernel@vger.kernel.org>, <ludovic.desroches@microchip.com>,
        "Claudiu Beznea" <claudiu.beznea@microchip.com>
References: <20210409113116.482199-1-eugen.hristev@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <a4de02fd-1469-4049-8c8d-03be64bec948@microchip.com>
Date:   Fri, 16 Jul 2021 19:50:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210409113116.482199-1-eugen.hristev@microchip.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/04/2021 at 13:31, Eugen Hristev wrote:
> Add new SoC from at91 family : sama7g5
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> [claudiu.beznea@microchip.com: Select PLL, generic clock and UTMI support]
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
and queued in at91-soc branch.

> ---
> Changes in v2:
> - squash previous patch
>   [PATCH 3/3] ARM: at91: Kconfig: select PLL, generic clock and utmi support
> into this one
> 
>   arch/arm/mach-at91/Kconfig | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
> diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
> index ccd7e80ce943..f52b46bccd85 100644
> --- a/arch/arm/mach-at91/Kconfig
> +++ b/arch/arm/mach-at91/Kconfig
> @@ -57,6 +57,16 @@ config SOC_SAMA5D4
>   	help
>   	  Select this if you are using one of Microchip's SAMA5D4 family SoC.
>   
> +config SOC_SAMA7G5
> +	bool "SAMA7G5 family"
> +	depends on ARCH_MULTI_V7
> +	select HAVE_AT91_GENERATED_CLK
> +	select HAVE_AT91_SAM9X60_PLL
> +	select HAVE_AT91_UTMI
> +	select SOC_SAMA7
> +	help
> +	  Select this if you are using one of Microchip's SAMA7G5 family SoC.
> +
>   config SOC_AT91RM9200
>   	bool "AT91RM9200"
>   	depends on ARCH_MULTI_V4T
> @@ -191,4 +201,9 @@ config SOC_SAMA5
>   config ATMEL_PM
>   	bool
>   
> +config SOC_SAMA7
> +	bool
> +	select ARM_GIC
> +	select MEMORY
> +	select SOC_SAM_V7
>   endif
> 


-- 
Nicolas Ferre
