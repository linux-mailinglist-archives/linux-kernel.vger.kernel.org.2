Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2E130F45B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 15:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236460AbhBDN4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 08:56:18 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:42636 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236459AbhBDNzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 08:55:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1612446933; x=1643982933;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=lvKfoNbpb5meeE09ZP+tlSH1L7Ziidd6SFvdYvQvwjw=;
  b=c/jRaSfM9uDfflPCN1pSaYGX6nR+czv8kTwTKWv2ayLa7gDIX0GjQdox
   Z8ChsY4PpdP8AritVGJ6T7Nba3Nr1wH/1oz4QNpKH21jT7PMnMAL8awbW
   xAmi1liCFyErcRtDBb+jsRbhPxeEH3bOQ3E2BjX1vNdja6MQe2QT9/2r7
   u0GHRcebKh3HJ1uo7gH1OxZbYNGiosS4ueRm3YAQEujOvUMm+9w7wr/r5
   nMimTnxsKL8dZJfs+lGbkgB2/aj0b7m1LgutwKF6MZzQgbNopnHWJGawu
   SRn4LLS0gOYL3hYToYJCNWuBKRqVW+cB3p5EVuyX1GcY2wWOKUrMkzpQg
   w==;
IronPort-SDR: +9XZrmL8iSDlKUmqXIkMsW8sH409sHeG36WWppfIt7nehxdM4gPO7u1HkB6JMHvRbaHLqniZpd
 qirJrJhj1qJW27pqP4n5hrsyNsESI9tFJCiUGyP4/uuOex/xInPpfJ0xhAJXM9waFSB53v/3fy
 BAaYlimsa1hVcuNqyRFjgYbq18BmGTUzNdLRsvLOjkGocVX0I/nxfcwgm1PhlDqYtNMzgsy8Y2
 mJzcmMT9W0cwUy6x5kUc6cVW8Q/LN/P/XGjROiwNZT+HYR3ppt6f0WHFrDFv5uoYGrZIBMvJy+
 8CU=
X-IronPort-AV: E=Sophos;i="5.79,401,1602572400"; 
   d="scan'208";a="108512934"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Feb 2021 06:54:11 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 4 Feb 2021 06:54:11 -0700
Received: from [10.171.246.84] (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 4 Feb 2021 06:54:05 -0700
Subject: Re: [PATCH] clk: at91: Fix the declaration of the clocks
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <gregkh@linuxfoundation.org>, <saravanak@google.com>,
        <geert@linux-m68k.org>
CC:     <mirq-linux@rere.qmqm.pl>, <claudiu.beznea@microchip.com>,
        <a.fatoum@pengutronix.de>, <krzk@kernel.org>,
        <codrin.ciubotariu@microchip.com>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20210203154332.470587-1-tudor.ambarus@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <a220097d-c3eb-4496-488b-0142baef2be7@microchip.com>
Date:   Thu, 4 Feb 2021 14:54:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210203154332.470587-1-tudor.ambarus@microchip.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/02/2021 at 16:43, Tudor Ambarus wrote:
> These are all "early clocks" that require initialization just at
> of_clk_init() time. Use CLK_OF_DECLARE() to declare them.
> 
> This also fixes a problem that was spotted when fw_devlink was
> set to 'on' by default: the boards failed to boot. The reason is
> that CLK_OF_DECLARE_DRIVER() clears the OF_POPULATED and causes
> the consumers of the clock to be postponed by fw_devlink until
> the second initialization routine of the clock has been completed.
> One of the consumers of the clock is the timer, which is used as a
> clocksource, and needs the clock initialized early. Postponing the
> timers caused the fail at boot.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Looks good to me:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Thanks for the fix Tudor! Best regards,
   Nicolas

> ---
> Tested on sama5d2_xplained.
> 
>   drivers/clk/at91/at91rm9200.c  |  3 +--
>   drivers/clk/at91/at91sam9260.c | 16 ++++++++--------
>   drivers/clk/at91/at91sam9g45.c |  3 +--
>   drivers/clk/at91/at91sam9n12.c |  3 +--
>   drivers/clk/at91/at91sam9rl.c  |  3 ++-
>   drivers/clk/at91/at91sam9x5.c  | 20 ++++++++++----------
>   drivers/clk/at91/sama5d2.c     |  3 ++-
>   drivers/clk/at91/sama5d3.c     |  2 +-
>   drivers/clk/at91/sama5d4.c     |  3 ++-
>   9 files changed, 28 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/clk/at91/at91rm9200.c b/drivers/clk/at91/at91rm9200.c
> index 0fad1009f315..428a6f4b9ebc 100644
> --- a/drivers/clk/at91/at91rm9200.c
> +++ b/drivers/clk/at91/at91rm9200.c
> @@ -215,5 +215,4 @@ static void __init at91rm9200_pmc_setup(struct device_node *np)
>    * deferring properly. Once this is fixed, this can be switched to a platform
>    * driver.
>    */
> -CLK_OF_DECLARE_DRIVER(at91rm9200_pmc, "atmel,at91rm9200-pmc",
> -		      at91rm9200_pmc_setup);
> +CLK_OF_DECLARE(at91rm9200_pmc, "atmel,at91rm9200-pmc", at91rm9200_pmc_setup);
> diff --git a/drivers/clk/at91/at91sam9260.c b/drivers/clk/at91/at91sam9260.c
> index ceb5495f723a..b29843bea278 100644
> --- a/drivers/clk/at91/at91sam9260.c
> +++ b/drivers/clk/at91/at91sam9260.c
> @@ -491,26 +491,26 @@ static void __init at91sam9260_pmc_setup(struct device_node *np)
>   {
>   	at91sam926x_pmc_setup(np, &at91sam9260_data);
>   }
> -CLK_OF_DECLARE_DRIVER(at91sam9260_pmc, "atmel,at91sam9260-pmc",
> -		      at91sam9260_pmc_setup);
> +
> +CLK_OF_DECLARE(at91sam9260_pmc, "atmel,at91sam9260-pmc", at91sam9260_pmc_setup);
>   
>   static void __init at91sam9261_pmc_setup(struct device_node *np)
>   {
>   	at91sam926x_pmc_setup(np, &at91sam9261_data);
>   }
> -CLK_OF_DECLARE_DRIVER(at91sam9261_pmc, "atmel,at91sam9261-pmc",
> -		      at91sam9261_pmc_setup);
> +
> +CLK_OF_DECLARE(at91sam9261_pmc, "atmel,at91sam9261-pmc", at91sam9261_pmc_setup);
>   
>   static void __init at91sam9263_pmc_setup(struct device_node *np)
>   {
>   	at91sam926x_pmc_setup(np, &at91sam9263_data);
>   }
> -CLK_OF_DECLARE_DRIVER(at91sam9263_pmc, "atmel,at91sam9263-pmc",
> -		      at91sam9263_pmc_setup);
> +
> +CLK_OF_DECLARE(at91sam9263_pmc, "atmel,at91sam9263-pmc", at91sam9263_pmc_setup);
>   
>   static void __init at91sam9g20_pmc_setup(struct device_node *np)
>   {
>   	at91sam926x_pmc_setup(np, &at91sam9g20_data);
>   }
> -CLK_OF_DECLARE_DRIVER(at91sam9g20_pmc, "atmel,at91sam9g20-pmc",
> -		      at91sam9g20_pmc_setup);
> +
> +CLK_OF_DECLARE(at91sam9g20_pmc, "atmel,at91sam9g20-pmc", at91sam9g20_pmc_setup);
> diff --git a/drivers/clk/at91/at91sam9g45.c b/drivers/clk/at91/at91sam9g45.c
> index 0214333dedd3..15da0dfe3ef2 100644
> --- a/drivers/clk/at91/at91sam9g45.c
> +++ b/drivers/clk/at91/at91sam9g45.c
> @@ -228,5 +228,4 @@ static void __init at91sam9g45_pmc_setup(struct device_node *np)
>    * The TCB is used as the clocksource so its clock is needed early. This means
>    * this can't be a platform driver.
>    */
> -CLK_OF_DECLARE_DRIVER(at91sam9g45_pmc, "atmel,at91sam9g45-pmc",
> -		      at91sam9g45_pmc_setup);
> +CLK_OF_DECLARE(at91sam9g45_pmc, "atmel,at91sam9g45-pmc", at91sam9g45_pmc_setup);
> diff --git a/drivers/clk/at91/at91sam9n12.c b/drivers/clk/at91/at91sam9n12.c
> index f9db5316a7f1..7fe435f4b46b 100644
> --- a/drivers/clk/at91/at91sam9n12.c
> +++ b/drivers/clk/at91/at91sam9n12.c
> @@ -255,5 +255,4 @@ static void __init at91sam9n12_pmc_setup(struct device_node *np)
>    * The TCB is used as the clocksource so its clock is needed early. This means
>    * this can't be a platform driver.
>    */
> -CLK_OF_DECLARE_DRIVER(at91sam9n12_pmc, "atmel,at91sam9n12-pmc",
> -		      at91sam9n12_pmc_setup);
> +CLK_OF_DECLARE(at91sam9n12_pmc, "atmel,at91sam9n12-pmc", at91sam9n12_pmc_setup);
> diff --git a/drivers/clk/at91/at91sam9rl.c b/drivers/clk/at91/at91sam9rl.c
> index 66736e03cfef..ecbabf5162bd 100644
> --- a/drivers/clk/at91/at91sam9rl.c
> +++ b/drivers/clk/at91/at91sam9rl.c
> @@ -186,4 +186,5 @@ static void __init at91sam9rl_pmc_setup(struct device_node *np)
>   err_free:
>   	kfree(at91sam9rl_pmc);
>   }
> -CLK_OF_DECLARE_DRIVER(at91sam9rl_pmc, "atmel,at91sam9rl-pmc", at91sam9rl_pmc_setup);
> +
> +CLK_OF_DECLARE(at91sam9rl_pmc, "atmel,at91sam9rl-pmc", at91sam9rl_pmc_setup);
> diff --git a/drivers/clk/at91/at91sam9x5.c b/drivers/clk/at91/at91sam9x5.c
> index 79b9d3667228..5cce48c64ea2 100644
> --- a/drivers/clk/at91/at91sam9x5.c
> +++ b/drivers/clk/at91/at91sam9x5.c
> @@ -302,33 +302,33 @@ static void __init at91sam9g15_pmc_setup(struct device_node *np)
>   {
>   	at91sam9x5_pmc_setup(np, at91sam9g15_periphck, true);
>   }
> -CLK_OF_DECLARE_DRIVER(at91sam9g15_pmc, "atmel,at91sam9g15-pmc",
> -		      at91sam9g15_pmc_setup);
> +
> +CLK_OF_DECLARE(at91sam9g15_pmc, "atmel,at91sam9g15-pmc", at91sam9g15_pmc_setup);
>   
>   static void __init at91sam9g25_pmc_setup(struct device_node *np)
>   {
>   	at91sam9x5_pmc_setup(np, at91sam9g25_periphck, false);
>   }
> -CLK_OF_DECLARE_DRIVER(at91sam9g25_pmc, "atmel,at91sam9g25-pmc",
> -		      at91sam9g25_pmc_setup);
> +
> +CLK_OF_DECLARE(at91sam9g25_pmc, "atmel,at91sam9g25-pmc", at91sam9g25_pmc_setup);
>   
>   static void __init at91sam9g35_pmc_setup(struct device_node *np)
>   {
>   	at91sam9x5_pmc_setup(np, at91sam9g35_periphck, true);
>   }
> -CLK_OF_DECLARE_DRIVER(at91sam9g35_pmc, "atmel,at91sam9g35-pmc",
> -		      at91sam9g35_pmc_setup);
> +
> +CLK_OF_DECLARE(at91sam9g35_pmc, "atmel,at91sam9g35-pmc", at91sam9g35_pmc_setup);
>   
>   static void __init at91sam9x25_pmc_setup(struct device_node *np)
>   {
>   	at91sam9x5_pmc_setup(np, at91sam9x25_periphck, false);
>   }
> -CLK_OF_DECLARE_DRIVER(at91sam9x25_pmc, "atmel,at91sam9x25-pmc",
> -		      at91sam9x25_pmc_setup);
> +
> +CLK_OF_DECLARE(at91sam9x25_pmc, "atmel,at91sam9x25-pmc", at91sam9x25_pmc_setup);
>   
>   static void __init at91sam9x35_pmc_setup(struct device_node *np)
>   {
>   	at91sam9x5_pmc_setup(np, at91sam9x35_periphck, true);
>   }
> -CLK_OF_DECLARE_DRIVER(at91sam9x35_pmc, "atmel,at91sam9x35-pmc",
> -		      at91sam9x35_pmc_setup);
> +
> +CLK_OF_DECLARE(at91sam9x35_pmc, "atmel,at91sam9x35-pmc", at91sam9x35_pmc_setup);
> diff --git a/drivers/clk/at91/sama5d2.c b/drivers/clk/at91/sama5d2.c
> index 9a5cbc7cd55a..3d1f78176c3e 100644
> --- a/drivers/clk/at91/sama5d2.c
> +++ b/drivers/clk/at91/sama5d2.c
> @@ -372,4 +372,5 @@ static void __init sama5d2_pmc_setup(struct device_node *np)
>   err_free:
>   	kfree(sama5d2_pmc);
>   }
> -CLK_OF_DECLARE_DRIVER(sama5d2_pmc, "atmel,sama5d2-pmc", sama5d2_pmc_setup);
> +
> +CLK_OF_DECLARE(sama5d2_pmc, "atmel,sama5d2-pmc", sama5d2_pmc_setup);
> diff --git a/drivers/clk/at91/sama5d3.c b/drivers/clk/at91/sama5d3.c
> index 87009ee8effc..d376257807d2 100644
> --- a/drivers/clk/at91/sama5d3.c
> +++ b/drivers/clk/at91/sama5d3.c
> @@ -255,4 +255,4 @@ static void __init sama5d3_pmc_setup(struct device_node *np)
>    * The TCB is used as the clocksource so its clock is needed early. This means
>    * this can't be a platform driver.
>    */
> -CLK_OF_DECLARE_DRIVER(sama5d3_pmc, "atmel,sama5d3-pmc", sama5d3_pmc_setup);
> +CLK_OF_DECLARE(sama5d3_pmc, "atmel,sama5d3-pmc", sama5d3_pmc_setup);
> diff --git a/drivers/clk/at91/sama5d4.c b/drivers/clk/at91/sama5d4.c
> index 57fff790188b..5cbaac68da44 100644
> --- a/drivers/clk/at91/sama5d4.c
> +++ b/drivers/clk/at91/sama5d4.c
> @@ -286,4 +286,5 @@ static void __init sama5d4_pmc_setup(struct device_node *np)
>   err_free:
>   	kfree(sama5d4_pmc);
>   }
> -CLK_OF_DECLARE_DRIVER(sama5d4_pmc, "atmel,sama5d4-pmc", sama5d4_pmc_setup);
> +
> +CLK_OF_DECLARE(sama5d4_pmc, "atmel,sama5d4-pmc", sama5d4_pmc_setup);
> 


-- 
Nicolas Ferre
