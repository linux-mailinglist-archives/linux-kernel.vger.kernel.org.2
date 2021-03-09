Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2C1E33256F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 13:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbhCIMYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 07:24:13 -0500
Received: from smtpweb147.aruba.it ([62.149.158.147]:39973 "EHLO
        smtpweb147.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbhCIMYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 07:24:10 -0500
Received: from [192.168.1.56] ([79.0.204.227])
        by Aruba Outgoing Smtp  with ESMTPSA
        id JbP3l6rNA1jmzJbP3l3J2r; Tue, 09 Mar 2021 13:23:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1615292638; bh=TXSSX9JzU1wv9wE+kK9LATPw89208zj66bzBcd5DdXE=;
        h=Subject:To:From:Date:MIME-Version:Content-Type;
        b=ijPGQdVn6JaUnCvKIb9/Dhj3aQ4RY2QGRx4Scgm5FBuJ6JDgOY0iz6Ml6LoGk3XM9
         tT7TW/QtCRmuZ1dXSriyj7o+dlUk2JEHOH+LsPNRm+tF7lrboCaTRZ5qqHJRo5tjhP
         M+ZlNQLkoWf40LvTyXf+TbdHXyCTGX+Wrs7tGjEzW8aUOwAdtBdwbuctVI021EMjBZ
         I+Z6ehAhKVEeOpiTUJBM3a4DzKBxTXwkOEOQL1v/qqiw+KDgCE/TvgjNLX7SSDGIBe
         dIOcH293w8TeJSW/aOfXjF+S8I7PUC2ZBS1IjjEBt4bvedz7uD45fAOX9xkisglNyi
         U2YF54GrmKpRw==
Subject: Re: [PATCH resend v1 1/7] pps: clients: gpio: Bail out on error when
 requesting GPIO echo line
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Ryan Govostes <rgovostes@whoi.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20210309112403.36633-1-andriy.shevchenko@linux.intel.com>
From:   Rodolfo Giometti <giometti@enneenne.com>
Message-ID: <bde071f7-6d98-d7bd-42d9-9e0f4d5d936d@enneenne.com>
Date:   Tue, 9 Mar 2021 13:23:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210309112403.36633-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfC2ATPhzH6vD5AHua1a34RNf/imkge3Hx6JG6nSVAr/PX/CWsZvoubswbog7tv+aND5bLwP+I/c1jEDl4BV8uIK0zd/IttaRnFbJaQcnjQ1z4vpgmgOe
 Wz02v0Ahckmo1vZ3Ku0/cyqCXlWvX2Ig4cE7KDbZfQ7xdIlfJDIiZKibLlpZVaOX8I08690YbVMx4O7w3IVpS1YLcD7MGGocE04vtLioOtjkBXoPy9y0itgp
 qGVHs4tFaCJxni8cWo2gD+3bG8HSGaLivB34eW8OevkKnReuf5UbiUwJokP3xakG
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/21 12:23, Andy Shevchenko wrote:
> When requesting optional GPIO echo line, bail out on error,
> so user will know that something wrong with the existing property.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/pps/clients/pps-gpio.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pps/clients/pps-gpio.c b/drivers/pps/clients/pps-gpio.c
> index e0de1df2ede0..f89c31aa66f1 100644
> --- a/drivers/pps/clients/pps-gpio.c
> +++ b/drivers/pps/clients/pps-gpio.c
> @@ -119,12 +119,12 @@ static int pps_gpio_setup(struct platform_device *pdev)
>  	data->echo_pin = devm_gpiod_get_optional(&pdev->dev,
>  			"echo",
>  			GPIOD_OUT_LOW);
> -	if (data->echo_pin) {
> -		if (IS_ERR(data->echo_pin)) {
> -			dev_err(&pdev->dev, "failed to request ECHO GPIO\n");
> -			return PTR_ERR(data->echo_pin);
> -		}
> +	if (IS_ERR(data->echo_pin)) {
> +		dev_err(&pdev->dev, "failed to request ECHO GPIO\n");
> +		return PTR_ERR(data->echo_pin);
> +	}
>  
> +	if (data->echo_pin) {
>  		ret = of_property_read_u32(np,
>  			"echo-active-ms",
>  			&value);
> 

Acked-by: Rodolfo Giometti <giometti@enneenne.com>

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti
