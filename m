Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04F1F332581
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 13:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbhCIMaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 07:30:39 -0500
Received: from smtpweb146.aruba.it ([62.149.158.146]:54070 "EHLO
        smtpweb146.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbhCIMaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 07:30:19 -0500
Received: from [192.168.1.56] ([79.0.204.227])
        by Aruba Outgoing Smtp  with ESMTPSA
        id JbVBl6yNY1jmzJbVBl3P4E; Tue, 09 Mar 2021 13:30:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1615293018; bh=WBhMi32POILGBSu20dZO8sVhqwyzDNZmto+c/lJnBok=;
        h=Subject:To:From:Date:MIME-Version:Content-Type;
        b=J9EllWpf/KIb2N55ePj85kcVfYqIYU3P5TMi9Tlgp1KN6Kgv8chaCrb/HTWaAnghm
         1u0Dsx5ssD2RSJu+5ROZfK6rNYP1PzAaO9N2cZ+B/uNEkAvD1Op6Uj6TPfPmch6wZF
         POTH9VMuW3/aofvfSz/1mKvNPjowPM46eVkxL+pDYubyACMNeYmMXZrP6k6gwyX5Tn
         fHvcRI2RnPsxoVYkA6qW2eOt6qTN6LZ3RdOOuO1uIhff9HslTFAHCBcZB0tCF99ak3
         NqW3aEgRn3NINK1qDfMb+vQbOTPuGlyxVM7gmguqYbueDoWy3E6LDVAQ6M0tm1OeZi
         hnkVcTeVinn2A==
Subject: Re: [PATCH resend v1 6/7] pps: clients: gpio: Use struct device
 pointer directly
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Ryan Govostes <rgovostes@whoi.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20210309112403.36633-1-andriy.shevchenko@linux.intel.com>
 <20210309112403.36633-6-andriy.shevchenko@linux.intel.com>
From:   Rodolfo Giometti <giometti@enneenne.com>
Message-ID: <b053ef4f-3c64-1b24-e26f-fc948b029afa@enneenne.com>
Date:   Tue, 9 Mar 2021 13:30:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210309112403.36633-6-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfNCeUeOrhbGrE5wqmQGL01LdR63oVDbWbgKlHhHcpBeKc57KiSyjJH2DOJ+GbBWr13PU9/LZFl/XFQjpWx3wvitBDXVaL8gk+CQxL3qOjhxnJNv94UBB
 bi0cALTI4J706jq+t+ztiHos++1q+W4RxyY3WdhymhdwNkodFeNgzBtFcrZ4YqJwQN6hCeZF+u0kua2Xi/GYK7PpyR8WEjx2avpiHaSxcP4JAGWkqQGjFWNL
 FuEA4isnAKNLHCNZvew/GygOaI6XTPjYBLUODmpB5A7+RxpC2FOdA0YzMSfZsz2d
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/21 12:24, Andy Shevchenko wrote:
> In most parts of the code the platform device is not used.
> Use struct device pointer directly to reduce code size and
> increase readability.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/pps/clients/pps-gpio.c | 42 +++++++++++++++-------------------
>  1 file changed, 19 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/pps/clients/pps-gpio.c b/drivers/pps/clients/pps-gpio.c
> index c6db3a3b257b..b097da5a659a 100644
> --- a/drivers/pps/clients/pps-gpio.c
> +++ b/drivers/pps/clients/pps-gpio.c
> @@ -99,45 +99,39 @@ static void pps_gpio_echo_timer_callback(struct timer_list *t)
>  	gpiod_set_value(info->echo_pin, 0);
>  }
>  
> -static int pps_gpio_setup(struct platform_device *pdev)
> +static int pps_gpio_setup(struct device *dev)
>  {
> -	struct pps_gpio_device_data *data = platform_get_drvdata(pdev);
> +	struct pps_gpio_device_data *data = dev_get_drvdata(dev);
>  	int ret;
>  	u32 value;
>  
> -	data->gpio_pin = devm_gpiod_get(&pdev->dev,
> -		NULL,	/* request "gpios" */
> -		GPIOD_IN);
> +	data->gpio_pin = devm_gpiod_get(dev, NULL, GPIOD_IN);
>  	if (IS_ERR(data->gpio_pin))
> -		return dev_err_probe(&pdev->dev, PTR_ERR(data->gpio_pin),
> +		return dev_err_probe(dev, PTR_ERR(data->gpio_pin),
>  				     "failed to request PPS GPIO\n");
>  
> -	data->echo_pin = devm_gpiod_get_optional(&pdev->dev,
> -			"echo",
> -			GPIOD_OUT_LOW);
> +	data->echo_pin = devm_gpiod_get_optional(dev, "echo", GPIOD_OUT_LOW);
>  	if (IS_ERR(data->echo_pin))
> -		return dev_err_probe(&pdev->dev, PTR_ERR(data->echo_pin),
> +		return dev_err_probe(dev, PTR_ERR(data->echo_pin),
>  				     "failed to request ECHO GPIO\n");
>  
>  	if (data->echo_pin) {
> -		ret = device_property_read_u32(&pdev->dev, "echo-active-ms", &value);
> +		ret = device_property_read_u32(dev, "echo-active-ms", &value);
>  		if (ret) {
> -			dev_err(&pdev->dev,
> -				"failed to get echo-active-ms from FW\n");
> +			dev_err(dev, "failed to get echo-active-ms from FW\n");
>  			return ret;
>  		}
>  		data->echo_active_ms = value;
>  		/* sanity check on echo_active_ms */
>  		if (!data->echo_active_ms || data->echo_active_ms > 999) {
> -			dev_err(&pdev->dev,
> -				"echo-active-ms: %u - bad value from FW\n",
> +			dev_err(dev, "echo-active-ms: %u - bad value from FW\n",
>  				data->echo_active_ms);
>  			return -EINVAL;
>  		}
>  	}
>  
>  	data->assert_falling_edge =
> -		device_property_read_bool(&pdev->dev, "assert-falling-edge");
> +		device_property_read_bool(dev, "assert-falling-edge");
>  	return 0;
>  }
>  
> @@ -158,24 +152,26 @@ get_irqf_trigger_flags(const struct pps_gpio_device_data *data)
>  static int pps_gpio_probe(struct platform_device *pdev)
>  {
>  	struct pps_gpio_device_data *data;
> +	struct device *dev = &pdev->dev;
>  	int ret;
>  	int pps_default_params;
>  
>  	/* allocate space for device info */
> -	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>  	if (!data)
>  		return -ENOMEM;
> -	platform_set_drvdata(pdev, data);
> +
> +	dev_set_drvdata(dev, data);
>  
>  	/* GPIO setup */
> -	ret = pps_gpio_setup(pdev);
> +	ret = pps_gpio_setup(dev);
>  	if (ret)
>  		return -EINVAL;
>  
>  	/* IRQ setup */
>  	ret = gpiod_to_irq(data->gpio_pin);
>  	if (ret < 0) {
> -		dev_err(&pdev->dev, "failed to map GPIO to IRQ: %d\n", ret);
> +		dev_err(dev, "failed to map GPIO to IRQ: %d\n", ret);
>  		return -EINVAL;
>  	}
>  	data->irq = ret;
> @@ -201,17 +197,17 @@ static int pps_gpio_probe(struct platform_device *pdev)
>  		pps_default_params |= PPS_CAPTURECLEAR | PPS_OFFSETCLEAR;
>  	data->pps = pps_register_source(&data->info, pps_default_params);
>  	if (IS_ERR(data->pps)) {
> -		dev_err(&pdev->dev, "failed to register IRQ %d as PPS source\n",
> +		dev_err(dev, "failed to register IRQ %d as PPS source\n",
>  			data->irq);
>  		return PTR_ERR(data->pps);
>  	}
>  
>  	/* register IRQ interrupt handler */
> -	ret = devm_request_irq(&pdev->dev, data->irq, pps_gpio_irq_handler,
> +	ret = devm_request_irq(dev, data->irq, pps_gpio_irq_handler,
>  			get_irqf_trigger_flags(data), data->info.name, data);
>  	if (ret) {
>  		pps_unregister_source(data->pps);
> -		dev_err(&pdev->dev, "failed to acquire IRQ %d\n", data->irq);
> +		dev_err(dev, "failed to acquire IRQ %d\n", data->irq);
>  		return -EINVAL;
>  	}
>  
> 

Acked-by: Rodolfo Giometti <giometti@enneenne.com>

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti
