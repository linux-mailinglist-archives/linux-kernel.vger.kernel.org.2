Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6890A332573
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 13:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbhCIMZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 07:25:19 -0500
Received: from smtpweb147.aruba.it ([62.149.158.147]:39973 "EHLO
        smtpweb147.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbhCIMZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 07:25:07 -0500
Received: from [192.168.1.56] ([79.0.204.227])
        by Aruba Outgoing Smtp  with ESMTPSA
        id JbQAl6skf1jmzJbQAl3KDz; Tue, 09 Mar 2021 13:25:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1615292707; bh=sL9nF7AOdYs3XiB8N1ibpRKX3i5PP8HuGzrTcAexPx8=;
        h=Subject:To:From:Date:MIME-Version:Content-Type;
        b=TUll/KMaVTzV8lKVPEsXd8t6L68i+jsHZCXl6c5z1J5KvUwMYI2zj1yAyDESewbFi
         k4igVQJjmhn9xhd6w2OPprf7Ue54YIKEWzDLGXseGCBjDLxWX5lUwL6Eq4/LEKv5ip
         eqHFq4j+ks3mHcjJLLs2nT1bC4cXlw5Ii2lhEgLT4Y9t0LkJHVMfXKipcQkD/15FjK
         /oi5ecOVrPXq2S+WixtqqP4S2K3xAP0lWz9JpU8qXFjLdIB7g+Ur12cRg7AEg5juWC
         9ntT8JXksLR+cFBxhrElrjd1XsdVJc352/uN8GxyRJwS/NS17L5cwjirNx5IB+/1D2
         M1T1B2z5etIIw==
Subject: Re: [PATCH resend v1 2/7] pps: clients: gpio: Use dev_err_probe() to
 avoid log noise
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Ryan Govostes <rgovostes@whoi.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20210309112403.36633-1-andriy.shevchenko@linux.intel.com>
 <20210309112403.36633-2-andriy.shevchenko@linux.intel.com>
From:   Rodolfo Giometti <giometti@enneenne.com>
Message-ID: <e22021ef-28b7-54ad-91e8-7a4bac0b878b@enneenne.com>
Date:   Tue, 9 Mar 2021 13:25:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210309112403.36633-2-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfArjjZQn26j3EOI86MrhKaaAo1cb6uB/NJajzlmwIBpz0SapOtgiBU8qH7LWBDGdAQd7sHkRpis7IkrpToQ3vERIh/F+SbjTXL3CsRFscC62pUaPr6rs
 d0PuKwYBMVPbo+H/ytwaWsWavHYpz58cPbbBji3FhPwcCbnP1rtGHfinMUPI9jFiiHGAbq5bLZjqxI+YNGZzP05G1+e5bXqFWc7ovl2FZmZHfVUOqGLY8PyS
 nrnZlL83BawVxzB9DK6Dy2hw7ugm3yAHeDOJllNA7NLHaec18xM3s+IY32bTpakE
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/21 12:23, Andy Shevchenko wrote:
> When GPIO APIs return -EPROBE_DEFER there is no need to print the message,
> especially taking into consideration that it may repeat several times.
> Use dev_err_probe() to avoid log noise in such cases.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/pps/clients/pps-gpio.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pps/clients/pps-gpio.c b/drivers/pps/clients/pps-gpio.c
> index f89c31aa66f1..78c9680e8063 100644
> --- a/drivers/pps/clients/pps-gpio.c
> +++ b/drivers/pps/clients/pps-gpio.c
> @@ -110,19 +110,16 @@ static int pps_gpio_setup(struct platform_device *pdev)
>  	data->gpio_pin = devm_gpiod_get(&pdev->dev,
>  		NULL,	/* request "gpios" */
>  		GPIOD_IN);
> -	if (IS_ERR(data->gpio_pin)) {
> -		dev_err(&pdev->dev,
> -			"failed to request PPS GPIO\n");
> -		return PTR_ERR(data->gpio_pin);
> -	}
> +	if (IS_ERR(data->gpio_pin))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(data->gpio_pin),
> +				     "failed to request PPS GPIO\n");
>  
>  	data->echo_pin = devm_gpiod_get_optional(&pdev->dev,
>  			"echo",
>  			GPIOD_OUT_LOW);
> -	if (IS_ERR(data->echo_pin)) {
> -		dev_err(&pdev->dev, "failed to request ECHO GPIO\n");
> -		return PTR_ERR(data->echo_pin);
> -	}
> +	if (IS_ERR(data->echo_pin))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(data->echo_pin),
> +				     "failed to request ECHO GPIO\n");
>  
>  	if (data->echo_pin) {
>  		ret = of_property_read_u32(np,
> 

Acked-by: Rodolfo Giometti <giometti@enneenne.com>

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti
