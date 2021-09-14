Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42DA140B286
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 17:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234013AbhINPIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 11:08:43 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:48078 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233858AbhINPIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 11:08:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1631632045; x=1663168045;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=WbzsE5CPbx1OvZmlMiX5JgPDXQPhCtNDGTNE8+SJ0yo=;
  b=FJ16zqQlLr+gxmofsoBVECzLdX1Yix6RkN9PtBolDLcWmUhlF4d7EE1U
   kz+k1Fnyk+VMxzYK6iiYJV4HLN2SD56+ynIunvupZC/yO85g+2ZqFPNfd
   TwJgnHYwxhRPyaBvODSf7g5tpVkl1WVxdAghGKncj1bViFpivUsPb81iQ
   l9PDGhVCn9LLC4eBb/nT16+nQ+ZaXQ1H/uAWBg1YcVFQO8fnqLVHm9yMZ
   g6S61l4qSFVoItdfDQ58GSvcsRS7kKsaOvm00+gpluxAZIoAUWdMcMTun
   6eA367z4tBeNdc7cLT91X1lBmMoyZRzJqmcLI0kC0tUIBkt6I8MytTijU
   Q==;
IronPort-SDR: aQqZBjit+kf9DbUG/qm9V5G5vf9iiAD2HVbEQp5rNcIyjSMP3Aj7aLet5INKqcSLEH/gQOf6tj
 wv1OZ8beZG7/S1a54PAX7ROXbvE6V3GFuKyVq+mVTpH6eI8OQMSvqCVa9XJLSio0XmT9APn7dM
 GAN+6uRvVuWldjkBp5xJvQDfww5k8D0HOhS2S0hbAYRotXdE/7+iAtdplMhm2uln+hyrS4sbvd
 +yxcOFgMiXhKswuH6Ga7gFGnrnrUgR4YVLOW1w4zmfbtGfi2i+4g18nT4uKE937cZYROtwCNn7
 W2BmTJezVf7v3Q2YPVgXA3mO
X-IronPort-AV: E=Sophos;i="5.85,292,1624345200"; 
   d="scan'208";a="144052717"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Sep 2021 08:07:24 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 14 Sep 2021 08:07:24 -0700
Received: from [10.171.246.26] (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Tue, 14 Sep 2021 08:07:23 -0700
Subject: Re: [PATCH] ARM: dts: at91: sama7g5: add chipid
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210908094329.182477-1-claudiu.beznea@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <50422bf9-01d5-3d11-ada1-f2f7ee155aba@microchip.com>
Date:   Tue, 14 Sep 2021 17:07:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210908094329.182477-1-claudiu.beznea@microchip.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/09/2021 at 11:43, Claudiu Beznea wrote:
> Add chipid node for sama7g5.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

> ---
> 
> Hi Nicolas,
> 
> This applies clean on top of series with title "ARM: at91: add new nodes
> to DT and fix for PM".

I think it can go in at91-fixes for 5.15 as it integrates nicely with 
the basic IP that we need enabled on this new SoC.

Best regards,
   Nicolas

> 
>   arch/arm/boot/dts/sama7g5.dtsi | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sama7g5.dtsi b/arch/arm/boot/dts/sama7g5.dtsi
> index e50806cf7660..6c58c151c6d9 100644
> --- a/arch/arm/boot/dts/sama7g5.dtsi
> +++ b/arch/arm/boot/dts/sama7g5.dtsi
> @@ -159,6 +159,11 @@ ps_wdt: watchdog@e001d180 {
>   			clocks = <&clk32k 0>;
>   		};
>   
> +		chipid@e0020000 {
> +			compatible = "microchip,sama7g5-chipid";
> +			reg = <0xe0020000 0x8>;
> +		};
> +
>   		sdmmc0: mmc@e1204000 {
>   			compatible = "microchip,sama7g5-sdhci", "microchip,sam9x60-sdhci";
>   			reg = <0xe1204000 0x4000>;
> 


-- 
Nicolas Ferre
