Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 607A5332577
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 13:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbhCIM11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 07:27:27 -0500
Received: from smtpweb147.aruba.it ([62.149.158.147]:39973 "EHLO
        smtpweb147.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbhCIM1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 07:27:19 -0500
Received: from [192.168.1.56] ([79.0.204.227])
        by Aruba Outgoing Smtp  with ESMTPSA
        id JbSIl6vHe1jmzJbSIl3MLw; Tue, 09 Mar 2021 13:27:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1615292838; bh=0cefqMk4tclHgG3aICIgkvolMra2WYcEokDzmkS1YSo=;
        h=Subject:To:From:Date:MIME-Version:Content-Type;
        b=Jabj857JO8ZgirMb1l+X370ywGH2HwYQpBv8fZJY/sLHStxs+PRrfv9qNwOjbx0OQ
         haFwtCozjmSN+ei3lZfLwuTzzdGf6GsY3clkXmjeI0a2mXzdPdEBD9nNkkBV1RCH0C
         lD78uaW4u9fh0rZ+2AUJ5l8E9f3MiIF7Twn3ZnEa2YqUoeB4++vW8CaWgCgJZm6JmS
         ZSw0mPOC7t1ByaesslGhrfqr7ygP1f5vUnD2XdMzUAWFFWAagT9RxdyW8tWZMVdDcF
         1O9VFpqUTbKxkyFidvdAZ6xp559yTGfJz3LtprlIiioKp1VJ51jE2kbK9KHz1BXwTx
         EqZv2SQeDZB7A==
Subject: Re: [PATCH resend v1 5/7] pps: clients: gpio: Make use of device
 properties
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Ryan Govostes <rgovostes@whoi.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20210309112403.36633-1-andriy.shevchenko@linux.intel.com>
 <20210309112403.36633-5-andriy.shevchenko@linux.intel.com>
From:   Rodolfo Giometti <giometti@enneenne.com>
Message-ID: <e8451cbd-2006-20a1-cc8d-897097490be1@enneenne.com>
Date:   Tue, 9 Mar 2021 13:27:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210309112403.36633-5-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfBPBDYuUTTJm56RDHtYo0YRDYXG0cWj8r6YvkstEykKK4yly2zN7WZVbTdDGiPwGBxfBnOIsgQvoZW8HDbe7uy5zCTnLvwVCPgT88gMT25tTAPZOCQKu
 bBiNY/KxeIvPmmwIrDhgGjmn7+iXdnsMj4aMByzts4XAHNIBzN9rgXc9DYkTOAAIwd57eRfJVbJDJXIByM5SHnnsMxzrESJWflhKGvqEc1D2Q2e2XcwPs/Cl
 iHbpxIcKJMuiz4YEljqU1oNNdt7pk5So0g0rnPZFlYmn/t/1OtXLxcL5sV+FFTyz
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/21 12:24, Andy Shevchenko wrote:
> Device property API allows to gather device resources from different sources,
> such as ACPI. Convert the drivers to unleash the power of device property API.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/pps/clients/pps-gpio.c | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pps/clients/pps-gpio.c b/drivers/pps/clients/pps-gpio.c
> index 291240dce79e..c6db3a3b257b 100644
> --- a/drivers/pps/clients/pps-gpio.c
> +++ b/drivers/pps/clients/pps-gpio.c
> @@ -12,14 +12,14 @@
>  #include <linux/init.h>
>  #include <linux/kernel.h>
>  #include <linux/interrupt.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  #include <linux/pps_kernel.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/list.h>
> -#include <linux/of_device.h>
> -#include <linux/of_gpio.h>
> +#include <linux/property.h>
>  #include <linux/timer.h>
>  #include <linux/jiffies.h>
>  
> @@ -102,7 +102,6 @@ static void pps_gpio_echo_timer_callback(struct timer_list *t)
>  static int pps_gpio_setup(struct platform_device *pdev)
>  {
>  	struct pps_gpio_device_data *data = platform_get_drvdata(pdev);
> -	struct device_node *np = pdev->dev.of_node;
>  	int ret;
>  	u32 value;
>  
> @@ -121,26 +120,24 @@ static int pps_gpio_setup(struct platform_device *pdev)
>  				     "failed to request ECHO GPIO\n");
>  
>  	if (data->echo_pin) {
> -		ret = of_property_read_u32(np,
> -			"echo-active-ms",
> -			&value);
> +		ret = device_property_read_u32(&pdev->dev, "echo-active-ms", &value);
>  		if (ret) {
>  			dev_err(&pdev->dev,
> -				"failed to get echo-active-ms from OF\n");
> +				"failed to get echo-active-ms from FW\n");
>  			return ret;
>  		}
>  		data->echo_active_ms = value;
>  		/* sanity check on echo_active_ms */
>  		if (!data->echo_active_ms || data->echo_active_ms > 999) {
>  			dev_err(&pdev->dev,
> -				"echo-active-ms: %u - bad value from OF\n",
> +				"echo-active-ms: %u - bad value from FW\n",
>  				data->echo_active_ms);
>  			return -EINVAL;
>  		}
>  	}
>  
> -	if (of_property_read_bool(np, "assert-falling-edge"))
> -		data->assert_falling_edge = true;
> +	data->assert_falling_edge =
> +		device_property_read_bool(&pdev->dev, "assert-falling-edge");
>  	return 0;
>  }
>  
> 

Acked-by: Rodolfo Giometti <giometti@enneenne.com>

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti
