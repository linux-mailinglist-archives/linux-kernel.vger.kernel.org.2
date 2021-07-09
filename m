Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7163C2147
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 11:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbhGIJO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 05:14:26 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:58287 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbhGIJOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 05:14:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1625821903; x=1657357903;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=Pz7WNWySVatMp4bt5JkhaYRlAr6dhFqTdqnq8VFzyUE=;
  b=zCmP9D+6ZrchL+pnpD92bMIs9Umfr4fPdb7od0CZS8faw/qAUr6b9/OM
   lkZ5rTlBrM3bi+PeL34h1042YNoGtYoa3lPVStkh1rFKPhPsOpNQCVOyK
   QZ8OUiDCJoEZz3QRrpIj7hTqScBJlLrTMfl/0M/YKXIwDe+Kh7em68heJ
   0VNYAUlj4Y+c9wSejooErD3ZtcDkumNjJ6SUONNc2FulGBXZjDSbEuidh
   FJg2HspPaa62u7HPc3sVIgGzZ/8SA+tnI63c8wub8zhjCpJcbnzLGA+FB
   b6muwrwnVQZkDr/Iv6n0zYjNmshFsOjejB9e0BMLVQUync0HJnVJD59cS
   g==;
IronPort-SDR: 1YdfGPFimhGM/kjXPIh8ghVS/t+e8Hwn+/J8RiRMTM6I53PE25crNpkuW6UicJ+NQs7pNGzzRI
 o0uyxjm0NyI8say8jTgn/vNPsXyofwduyqg42a5BY1eIguJ95M2TbG4SSsTuRg/oH1Sfp5dtid
 A34AVH2/LAfg0l0vrJUi4q5alf8MUWT7Q7EPUZTC3QvbBfNgx+pkpdePQkZxeLhABUj36pN3Dv
 Qxg9KtD3jvhe/m3cX/LA+iMPzYYeY+u2g8+xdyu/cxvybc2NbQeAXC9GI00ASy6rkw8SZPLSEd
 gCM=
X-IronPort-AV: E=Sophos;i="5.84,226,1620716400"; 
   d="scan'208";a="61672924"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Jul 2021 02:11:42 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 9 Jul 2021 02:11:42 -0700
Received: from [10.12.72.46] (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Fri, 9 Jul 2021 02:11:40 -0700
Subject: Re: [PATCH 1/2] mfd: atmel-flexcom: remove #ifdef CONFIG_PM_SLEEP
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        <lee.jones@linaro.org>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <romain.izard.pro@gmail.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20210705113104.579535-1-claudiu.beznea@microchip.com>
 <20210705113104.579535-2-claudiu.beznea@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <fcdd81f2-c52d-758f-9788-b5b471302f77@microchip.com>
Date:   Fri, 9 Jul 2021 11:11:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210705113104.579535-2-claudiu.beznea@microchip.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/2021 at 13:31, Claudiu Beznea wrote:
> Remove compilation flag and use __maybe_unused and pm_ptr instead.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

> ---
>   drivers/mfd/atmel-flexcom.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mfd/atmel-flexcom.c b/drivers/mfd/atmel-flexcom.c
> index d2f5c073fdf3..962f66dc8813 100644
> --- a/drivers/mfd/atmel-flexcom.c
> +++ b/drivers/mfd/atmel-flexcom.c
> @@ -87,8 +87,7 @@ static const struct of_device_id atmel_flexcom_of_match[] = {
>   };
>   MODULE_DEVICE_TABLE(of, atmel_flexcom_of_match);
>   
> -#ifdef CONFIG_PM_SLEEP
> -static int atmel_flexcom_resume(struct device *dev)
> +static int __maybe_unused atmel_flexcom_resume(struct device *dev)
>   {
>   	struct atmel_flexcom *ddata = dev_get_drvdata(dev);
>   	int err;
> @@ -105,7 +104,6 @@ static int atmel_flexcom_resume(struct device *dev)
>   
>   	return 0;
>   }
> -#endif
>   
>   static SIMPLE_DEV_PM_OPS(atmel_flexcom_pm_ops, NULL,
>   			 atmel_flexcom_resume);
> @@ -114,7 +112,7 @@ static struct platform_driver atmel_flexcom_driver = {
>   	.probe	= atmel_flexcom_probe,
>   	.driver	= {
>   		.name		= "atmel_flexcom",
> -		.pm		= &atmel_flexcom_pm_ops,
> +		.pm		= pm_ptr(&atmel_flexcom_pm_ops),
>   		.of_match_table	= atmel_flexcom_of_match,
>   	},
>   };
> 


-- 
Nicolas Ferre
