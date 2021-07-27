Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1D943D719A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 10:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236040AbhG0Iys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 04:54:48 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:57159 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236028AbhG0Iyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 04:54:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1627376088; x=1658912088;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=oPqp3tPNFQ8Q2GIuy+UWJSLNOrQzvPAMpNotFpWP9kk=;
  b=KY6jfRyFMMBlFBQH1HD+4I0KkZ3Aa9kjUw6NsKg4+aIie2Ly8v2JLJHV
   t8zzaJAsZSfnsA+V+oFYP04wgkNyQAODMB9w6cBUBsPDzPdb5B6FQshub
   0i8VA1uKfEQep+PucfmKog/nOT7JhPoqZmm+W2sSg+m6fVobjRG0xmwxs
   OUPUeuAynGNlu+QRfhWDKzV+G+WHj0elYdfDR3VsOh2FcOJNA/wZFMnLk
   g++Llw0ybcA27eoV04ChGcPvyhPdf9gYHC1sKPLxrSDVSmi5NNzuC0BF3
   FORUcjyIUmtojH6jZjOa10Bv5pjzG5qiuRSp3XaX6r7psriTD0dzoeqtT
   Q==;
IronPort-SDR: m7uaYb2YaK3TVZQGgR/Ic9xyT19LLFk5ICZLuXfPOuNR1R8heGE35HWiyLKejvbs6pFfz7ST/r
 4XnhW1pkjGObmtZqEWQbSoNXSURTINUZJqZFUyWsgjctO5WMC4q1OU0V0BNq6a22nForZbhdYt
 alkKvSOhIKwQErJhQukltKMSCbfZ9E3Qx2ZYA9ahbgkH9V/JAWZyMTUjWKjhV9XKP3xC3Ax9Cr
 dsyNe1ab4M40tJNaRV1NZJQ0ADG7mGX+DwITe9ICu+Fe6n0PHtqa224f+oGsffCAYvTFWC2Crp
 4QyTHRgFeJ7N6ycvdVp5M3OB
X-IronPort-AV: E=Sophos;i="5.84,272,1620716400"; 
   d="scan'208";a="126076206"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Jul 2021 01:54:47 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 27 Jul 2021 01:54:07 -0700
Received: from [10.171.246.86] (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Tue, 27 Jul 2021 01:54:05 -0700
Subject: Re: [PATCH 2/2] ARM: dts: at91: add conflict note for d3
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210727074006.1609989-1-claudiu.beznea@microchip.com>
 <20210727074006.1609989-2-claudiu.beznea@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <ca86505c-9872-8605-5887-c1c6532ca186@microchip.com>
Date:   Tue, 27 Jul 2021 10:54:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210727074006.1609989-2-claudiu.beznea@microchip.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/07/2021 at 09:40, Claudiu Beznea wrote:
> Pin feeding d3 led may be in conflict with EBI CS0, USART2 CTS.
> Add a note for this.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Queued for 5.15 in at91-dt.

Regards,
   Nicolas

> ---
>   arch/arm/boot/dts/at91-sama5d3_xplained.dts | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/at91-sama5d3_xplained.dts b/arch/arm/boot/dts/at91-sama5d3_xplained.dts
> index cc55d1684322..d72c042f2850 100644
> --- a/arch/arm/boot/dts/at91-sama5d3_xplained.dts
> +++ b/arch/arm/boot/dts/at91-sama5d3_xplained.dts
> @@ -399,7 +399,7 @@ d2 {
>   		};
>   
>   		d3 {
> -			label = "d3";
> +			label = "d3"; /* Conflict with EBI CS0, USART2 CTS. */
>   			gpios = <&pioE 24 GPIO_ACTIVE_HIGH>;
>   		};
>   	};
> 


-- 
Nicolas Ferre
