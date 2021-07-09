Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A715E3C2149
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 11:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbhGIJPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 05:15:05 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:55685 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbhGIJPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 05:15:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1625821942; x=1657357942;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=suvuqOpmnLcuB5pV+C0e6aLAInf00mqzn7nTH4IXlK0=;
  b=EGZ7DxO/IpV1AzdlS43FNCtgpqBWF1fCAQvphDydTL2uT3BC8hqz2FW9
   a6cjOREMNyV2R6k5+LGuvrOL2dLuc2RkiLk0ahvyp9iknsyx4loreWjKl
   LjrPZbHrJIfTqgaTAPUrUYoYXWlvIdegTQpdXEkHMnKfgiuRa2EBiqW7L
   hIOIbtd5wh6tfV0YMFfgC9g1PfofdIWaXeAjGgnRhyJZb/WN0Zph2YLbF
   QvzvUs7Xunsa7GrpLN1q7UciGKhYYOWEXcaNudtChqrWIN/suphWsgwFx
   6rhxG7x8quUaoFmmlDG9TUz27Kk5I0TmhY2v6QyUS/XY9SqtMsT3YA3Cm
   Q==;
IronPort-SDR: 8bFCyPfhgHX+z/cK5QUUsd6Yh2Ax4TVNGnj9RwTkRYyeI5s2vzEps9PXq3J6wtgbfUbj/fuop2
 zCGIrYPzXzVFWbI/RWPnf8zXob1cd9C4ucbsuO24FzAfXyn69d6qfEIpQl4NOZvkukMZ7TyfVu
 wRu5d9BeG+Bf7Sihs2kyRGlmcbJ4WtCAeZrwoKKjRo7Xy8SPCVi+RA7EKxkQT4qqoVInP0ODOJ
 jvjD9aARiNNIk2fFGxv63rNe25RD3tAZCByvXAuZGoXym6onixq8wiPw3zf8L/E1LtHwDZWaGY
 a+I=
X-IronPort-AV: E=Sophos;i="5.84,226,1620716400"; 
   d="scan'208";a="128226803"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Jul 2021 02:12:17 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 9 Jul 2021 02:12:17 -0700
Received: from [10.12.72.46] (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Fri, 9 Jul 2021 02:12:15 -0700
Subject: Re: [PATCH 2/2] mfd: atmel-flexcom: use resume_noirq
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        <lee.jones@linaro.org>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <romain.izard.pro@gmail.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20210705113104.579535-1-claudiu.beznea@microchip.com>
 <20210705113104.579535-3-claudiu.beznea@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <17c5f1a8-f2d3-6f82-1b61-e3a9a1e1f8eb@microchip.com>
Date:   Fri, 9 Jul 2021 11:12:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210705113104.579535-3-claudiu.beznea@microchip.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/2021 at 13:31, Claudiu Beznea wrote:
> Flexcom IP embeds 3 other IPs: usart, i2c, spi and selects the operation
> mode (usart, i2c, spi) via mode register (FLEX_MR). On i2c bus there might
> be connected critical devices (like PMIC) which on suspend/resume should
> be suspended/resumed at the end/beginning. i2c uses
> .suspend_noirq/.resume_noirq for this kind of purposes. Align flexcom
> to use .resume_noirq as it should be resumed before the embedded IPs.
> Otherwise the embedded devices might behave badly.
> 
> Fixes: 7fdec11015c3 ("atmel_flexcom: Support resuming after a chip reset")
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Thanks Claudiu, best regards,
   Nicolas

> ---
>   drivers/mfd/atmel-flexcom.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mfd/atmel-flexcom.c b/drivers/mfd/atmel-flexcom.c
> index 962f66dc8813..559eb4d352b6 100644
> --- a/drivers/mfd/atmel-flexcom.c
> +++ b/drivers/mfd/atmel-flexcom.c
> @@ -87,7 +87,7 @@ static const struct of_device_id atmel_flexcom_of_match[] = {
>   };
>   MODULE_DEVICE_TABLE(of, atmel_flexcom_of_match);
>   
> -static int __maybe_unused atmel_flexcom_resume(struct device *dev)
> +static int __maybe_unused atmel_flexcom_resume_noirq(struct device *dev)
>   {
>   	struct atmel_flexcom *ddata = dev_get_drvdata(dev);
>   	int err;
> @@ -105,8 +105,9 @@ static int __maybe_unused atmel_flexcom_resume(struct device *dev)
>   	return 0;
>   }
>   
> -static SIMPLE_DEV_PM_OPS(atmel_flexcom_pm_ops, NULL,
> -			 atmel_flexcom_resume);
> +static const struct dev_pm_ops atmel_flexcom_pm_ops = {
> +	.resume_noirq = atmel_flexcom_resume_noirq,
> +};
>   
>   static struct platform_driver atmel_flexcom_driver = {
>   	.probe	= atmel_flexcom_probe,
> 


-- 
Nicolas Ferre
