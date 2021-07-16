Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E71AD3CBB69
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 19:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbhGPRxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 13:53:42 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:50476 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbhGPRxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 13:53:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1626457845; x=1657993845;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=0XCNUXyzZbIQRUxJJuPo7R5Sn7+x+bHhLXptl3tXDMk=;
  b=Q5v+z40tC/+OWfBnXBSNsPe/9eMa5YzmFHdYBRHVf72TqwPEmM/J9x5V
   y2EvdOIwhUMmt5V8udZ4TFCjLA1gmWOB3jawj2fdmls4Z4ntMMikGMnM9
   wBOTxpaahICi4NwOdDI1eTUewEFbhpn7r/u1+knWFrI1j9/hukLcI1MR4
   khzfAeCkTQs/0I7JdzCnXuhvnljqu7O9j2zmKURcgQfklyAjLx1zcEk7K
   DD1OfG+M59OWx2j+8EZV9tTE7MqRkaCA2AajESqt0fogUujQSYEoncefb
   kxFb/Ix+7VmBT3MDcBm6sN5zVhqZ/MxgJ9ijDU8zvvUQh5sZW71+pePl5
   A==;
IronPort-SDR: vzeL2XMf6Ys8Ewk58TsooypCEHgpaa+QRzhXJB7gVfWsKOZspJWDBqT9EITzy88fC+msUmLCkh
 82jbWNfIKl8/nExL7cAWVvNPCyWI3pyNbTQ3h1xPX6VNB7JBolMw7/53dP2b3GkiUmT+gckHAH
 RLdX4imldRM2kS8VN7/6TuoOmbQKBGBEBGOmLTAvKqaRyN0aDbx1vYZ7+Yzj37ZrnuQplYCf//
 JB9AiVH1sz/AZIWulZHmad7+34BVZxgRpCo+Eatji6wQjiejpandxm8T6bT1v2PfMTkDIw95v1
 lNw+hzgim1OT7Fe9d5REkCsO
X-IronPort-AV: E=Sophos;i="5.84,245,1620716400"; 
   d="scan'208";a="136209293"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Jul 2021 10:50:44 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 16 Jul 2021 10:50:44 -0700
Received: from [10.12.72.255] (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Fri, 16 Jul 2021 10:50:43 -0700
Subject: Re: [PATCH v2 2/2] ARM: at91: debug: add sama7g5 low level debug uart
To:     Eugen Hristev <eugen.hristev@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <alexandre.belloni@bootlin.com>
CC:     <linux-kernel@vger.kernel.org>, <ludovic.desroches@microchip.com>
References: <20210409113116.482199-1-eugen.hristev@microchip.com>
 <20210409113116.482199-2-eugen.hristev@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <8f2c9199-cd9d-17f8-56f8-2c970c1844e8@microchip.com>
Date:   Fri, 16 Jul 2021 19:50:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210409113116.482199-2-eugen.hristev@microchip.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/04/2021 at 13:31, Eugen Hristev wrote:
> Add sama7g5 SoC debug uart on Flexcom3. This is the UART that the
> ROM bootloader uses.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
and queued in at91-soc branch for 5.15.

> ---
>   arch/arm/Kconfig.debug | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> index 9e0b5e7f12af..7598624ce6dd 100644
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -191,6 +191,14 @@ choice
>   		  their output to the USART1 port on SAMV7 based
>   		  machines.
>   
> +	config DEBUG_AT91_SAMA7G5_FLEXCOM3
> +		bool "Kernel low-level debugging on SAMA7G5 FLEXCOM3"
> +		select DEBUG_AT91_UART
> +		depends on SOC_SAMA7G5
> +		help
> +		  Say Y here if you want kernel low-level debugging support
> +		  on the FLEXCOM3 port of SAMA7G5.
> +
>   	config DEBUG_BCM2835
>   		bool "Kernel low-level debugging on BCM2835 PL011 UART"
>   		depends on ARCH_BCM2835 && ARCH_MULTI_V6
> @@ -1657,6 +1665,7 @@ config DEBUG_UART_PHYS
>   	default 0xd4017000 if DEBUG_MMP_UART2
>   	default 0xd4018000 if DEBUG_MMP_UART3
>   	default 0xe0000000 if DEBUG_SPEAR13XX
> +	default 0xe1824200 if DEBUG_AT91_SAMA7G5_FLEXCOM3
>   	default 0xe4007000 if DEBUG_HIP04_UART
>   	default 0xe6c40000 if DEBUG_RMOBILE_SCIFA0
>   	default 0xe6c50000 if DEBUG_RMOBILE_SCIFA1
> @@ -1718,6 +1727,7 @@ config DEBUG_UART_VIRT
>   	default 0xc8821000 if DEBUG_RV1108_UART1
>   	default 0xc8912000 if DEBUG_RV1108_UART0
>   	default 0xe0010fe0 if ARCH_RPC
> +	default 0xe0824200 if DEBUG_AT91_SAMA7G5_FLEXCOM3
>   	default 0xf0010000 if DEBUG_ASM9260_UART
>   	default 0xf0100000 if DEBUG_DIGICOLOR_UA0
>   	default 0xf01fb000 if DEBUG_NOMADIK_UART
> 


-- 
Nicolas Ferre
