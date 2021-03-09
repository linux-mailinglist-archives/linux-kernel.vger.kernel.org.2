Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 821DD332583
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 13:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbhCIMbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 07:31:11 -0500
Received: from smtpweb146.aruba.it ([62.149.158.146]:54070 "EHLO
        smtpweb146.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhCIMaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 07:30:46 -0500
Received: from [192.168.1.56] ([79.0.204.227])
        by Aruba Outgoing Smtp  with ESMTPSA
        id JbVdl6yxB1jmzJbVdl3PWd; Tue, 09 Mar 2021 13:30:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1615293046; bh=objXhWxM57lDd2uquN5CiYVQC8nDmaqM0hyQiEWgXjY=;
        h=Subject:To:From:Date:MIME-Version:Content-Type;
        b=GBBgnyRccx26RgpPTOx7C6mRmLH7wOdFdIF5+31eoltK1iRYQcV/qt35UXAsHqeMD
         KfuRjRQWSJr568yivUC0nOyRt/8pfq3nqPkEJW/FBJHsq1TAjo0zjil2rUHiYz671I
         MHw5LSiQ4Q+rNcSN71FMddTXiYOLEb8tbyT2lWNnsg0WBESmUJE8kHyo3cFoaxf1tN
         eksO7K1QgvmHguFgOgwkK8hwuvF4CHtAu5fduxqbNv8A+w6kVdni44RZHHTczvo0Qt
         VT16jZ8m43yxXlHfqPDKjCLva3EudfF9FdiZRylEE9mF03Yt0yNg+Q0Texf6zlWiei
         WPFauw4edwdWg==
Subject: Re: [PATCH resend v1 7/7] pps: clients: gpio: Rearrange optional
 stuff in pps_gpio_setup()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Ryan Govostes <rgovostes@whoi.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20210309112403.36633-1-andriy.shevchenko@linux.intel.com>
 <20210309112403.36633-7-andriy.shevchenko@linux.intel.com>
From:   Rodolfo Giometti <giometti@enneenne.com>
Message-ID: <958cff66-2396-79c6-13f0-bf375afb286b@enneenne.com>
Date:   Tue, 9 Mar 2021 13:30:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210309112403.36633-7-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfJY40D2rUH+t3uqfY5XGrkAVk+u2f+mL2rIFlwUQJzYDWRVzj/1raE0HzkM14VzEHVRVz8uFT680qhVnYxhhLvUFPuJ+/Ph9H5Tu+XckJhExxaLqrHdJ
 mAFmESee8/4HEx1oAXlkhx8BPe7X9GO4SInED/CG+rhPiWB+5KAlN2g+xNqIeKackecMh17Lja765lLTiseVxvXOxWzz+M1Uebs2U+mMZgC5HdcWxZEtlARo
 hVXf6SdQ9O34ae8TAfRqxcO57AlDxp5BFr7/CYgbc34FzU59pQFdJ6Teasaf7X8r
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/21 12:24, Andy Shevchenko wrote:
> Rearrange optional stuff in pps_gpio_setup() so it will go after mandatory one
> and with reduced indentation. This will increase readability of the sources.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/pps/clients/pps-gpio.c | 33 ++++++++++++++++++---------------
>  1 file changed, 18 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/pps/clients/pps-gpio.c b/drivers/pps/clients/pps-gpio.c
> index b097da5a659a..35799e6401c9 100644
> --- a/drivers/pps/clients/pps-gpio.c
> +++ b/drivers/pps/clients/pps-gpio.c
> @@ -110,28 +110,31 @@ static int pps_gpio_setup(struct device *dev)
>  		return dev_err_probe(dev, PTR_ERR(data->gpio_pin),
>  				     "failed to request PPS GPIO\n");
>  
> +	data->assert_falling_edge =
> +		device_property_read_bool(dev, "assert-falling-edge");
> +
>  	data->echo_pin = devm_gpiod_get_optional(dev, "echo", GPIOD_OUT_LOW);
>  	if (IS_ERR(data->echo_pin))
>  		return dev_err_probe(dev, PTR_ERR(data->echo_pin),
>  				     "failed to request ECHO GPIO\n");
>  
> -	if (data->echo_pin) {
> -		ret = device_property_read_u32(dev, "echo-active-ms", &value);
> -		if (ret) {
> -			dev_err(dev, "failed to get echo-active-ms from FW\n");
> -			return ret;
> -		}
> -		data->echo_active_ms = value;
> -		/* sanity check on echo_active_ms */
> -		if (!data->echo_active_ms || data->echo_active_ms > 999) {
> -			dev_err(dev, "echo-active-ms: %u - bad value from FW\n",
> -				data->echo_active_ms);
> -			return -EINVAL;
> -		}
> +	if (!data->echo_pin)
> +		return 0;
> +
> +	ret = device_property_read_u32(dev, "echo-active-ms", &value);
> +	if (ret) {
> +		dev_err(dev, "failed to get echo-active-ms from FW\n");
> +		return ret;
>  	}
>  
> -	data->assert_falling_edge =
> -		device_property_read_bool(dev, "assert-falling-edge");
> +	/* sanity check on echo_active_ms */
> +	if (!value || value > 999) {
> +		dev_err(dev, "echo-active-ms: %u - bad value from FW\n", value);
> +		return -EINVAL;
> +	}
> +
> +	data->echo_active_ms = value;
> +
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
