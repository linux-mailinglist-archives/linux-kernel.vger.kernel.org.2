Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0851332576
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 13:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbhCIM0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 07:26:22 -0500
Received: from smtpweb147.aruba.it ([62.149.158.147]:39973 "EHLO
        smtpweb147.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbhCIM0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 07:26:00 -0500
Received: from [192.168.1.56] ([79.0.204.227])
        by Aruba Outgoing Smtp  with ESMTPSA
        id JbR1l6tnJ1jmzJbR1l3L69; Tue, 09 Mar 2021 13:26:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1615292760; bh=ODdm2comzFDSE7V3GkyHm75fizuP3tpN5ROnkY/sfVU=;
        h=Subject:To:From:Date:MIME-Version:Content-Type;
        b=KVFkmkxQPK0838RmUaOjuX0ry26jf/qshiLptcOSHukD6RRxfKPKKE18Yjo7UmxDo
         0rF4O2A/45iWbGhnWUuSz78znIYIwQP/YcKkezl216bhdRtahSQkHhGSAaZPjwPRU1
         x1nsIt8A6Sj8RT1IEfDeeTtqvb8jqok5kG0eGyFUMnldfu17xgmqJJD4W3quRwVk1o
         tnAjayXbkO0CBbWy2jUrU/sqJeS5JuBVZweVlnNnW716xMyyVxMgPZw4Rc02nSKrRw
         ZSXlbMMToqY9hNDHaNSY8F224u5g+QC+RR93bOmNG3yBAP8OT5p1XON2Hq3pZJ2/cr
         zVpTDXtXof57g==
Subject: Re: [PATCH resend v1 4/7] pps: clients: gpio: Get rid of legacy
 platform data
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Ryan Govostes <rgovostes@whoi.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20210309112403.36633-1-andriy.shevchenko@linux.intel.com>
 <20210309112403.36633-4-andriy.shevchenko@linux.intel.com>
From:   Rodolfo Giometti <giometti@enneenne.com>
Message-ID: <7d336ff8-25b8-e4f1-ec43-09e9414660a4@enneenne.com>
Date:   Tue, 9 Mar 2021 13:25:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210309112403.36633-4-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfIwSjAeClB0sPUDq+4uy4YQ12T7PG8mhpZXkPjVEEReb681khwvOt4MkgORtegRvfIkUrTw+y7mPZFga/eVlOkN68VO3mG09qMPB2S/3IqT+ZWkoKE65
 X++ppiG1arC8gWAFBxUXl5bfmGS9JM8yjOQo7KxKPB45oQSNe9/meVdfdKc0CSD9Q2qRN55da6E0rx6YCcTL3Qn/cx4SFyKdJkiW28y4fyN+g2jw9op2Ie1G
 qxL/9EHj9ZTjlXFTACTYUUXteUiJRmlMtTsc2pg6AxsKS+CTSFVSmSiPpZlb48ee
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/21 12:24, Andy Shevchenko wrote:
> Platform data is a legacy interface to supply device properties
> to the driver. In this case we even don't have in-kernel users
> for it. Just remove it for good.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/pps/clients/pps-gpio.c | 17 +++--------------
>  include/linux/pps-gpio.h       | 19 -------------------
>  2 files changed, 3 insertions(+), 33 deletions(-)
>  delete mode 100644 include/linux/pps-gpio.h
> 
> diff --git a/drivers/pps/clients/pps-gpio.c b/drivers/pps/clients/pps-gpio.c
> index dc9ed6fc3dae..291240dce79e 100644
> --- a/drivers/pps/clients/pps-gpio.c
> +++ b/drivers/pps/clients/pps-gpio.c
> @@ -16,7 +16,6 @@
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  #include <linux/pps_kernel.h>
> -#include <linux/pps-gpio.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/list.h>
>  #include <linux/of_device.h>
> @@ -164,7 +163,6 @@ static int pps_gpio_probe(struct platform_device *pdev)
>  	struct pps_gpio_device_data *data;
>  	int ret;
>  	int pps_default_params;
> -	const struct pps_gpio_platform_data *pdata = pdev->dev.platform_data;
>  
>  	/* allocate space for device info */
>  	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> @@ -173,18 +171,9 @@ static int pps_gpio_probe(struct platform_device *pdev)
>  	platform_set_drvdata(pdev, data);
>  
>  	/* GPIO setup */
> -	if (pdata) {
> -		data->gpio_pin = pdata->gpio_pin;
> -		data->echo_pin = pdata->echo_pin;
> -
> -		data->assert_falling_edge = pdata->assert_falling_edge;
> -		data->capture_clear = pdata->capture_clear;
> -		data->echo_active_ms = pdata->echo_active_ms;
> -	} else {
> -		ret = pps_gpio_setup(pdev);
> -		if (ret)
> -			return -EINVAL;
> -	}
> +	ret = pps_gpio_setup(pdev);
> +	if (ret)
> +		return -EINVAL;
>  
>  	/* IRQ setup */
>  	ret = gpiod_to_irq(data->gpio_pin);
> diff --git a/include/linux/pps-gpio.h b/include/linux/pps-gpio.h
> deleted file mode 100644
> index 7bf49908be06..000000000000
> --- a/include/linux/pps-gpio.h
> +++ /dev/null
> @@ -1,19 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-or-later */
> -/*
> - * pps-gpio.h -- PPS client for GPIOs
> - *
> - * Copyright (C) 2011 James Nuss <jamesnuss@nanometrics.ca>
> - */
> -
> -#ifndef _PPS_GPIO_H
> -#define _PPS_GPIO_H
> -
> -struct pps_gpio_platform_data {
> -	struct gpio_desc *gpio_pin;
> -	struct gpio_desc *echo_pin;
> -	bool assert_falling_edge;
> -	bool capture_clear;
> -	unsigned int echo_active_ms;
> -};
> -
> -#endif /* _PPS_GPIO_H */
> 

Acked-by: Rodolfo Giometti <giometti@enneenne.com>

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti
