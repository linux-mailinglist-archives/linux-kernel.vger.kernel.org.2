Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83906332575
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 13:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbhCIMZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 07:25:51 -0500
Received: from smtpweb147.aruba.it ([62.149.158.147]:39973 "EHLO
        smtpweb147.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbhCIMZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 07:25:35 -0500
Received: from [192.168.1.56] ([79.0.204.227])
        by Aruba Outgoing Smtp  with ESMTPSA
        id JbQcl6tJC1jmzJbQcl3Kgl; Tue, 09 Mar 2021 13:25:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1615292734; bh=UWAUAplEP8b+A+9LN2FR75EcgDrWFf010llBazCV7i4=;
        h=Subject:To:From:Date:MIME-Version:Content-Type;
        b=CpTxn7viRafxj6HmIQi/EEZzvzl06A+OY+Gt6fagcz6xl1EVXyUQ1Rwg2lWeXAvuT
         rf+iU2IvWKA6caryGc3+avjAfsHa4FJZs9xdQrM95Bm6+QZItb+JIn9E2XTJXhVhbh
         88KFEwkkRcN1x9gyb8AuI8TunDtihUALCK2bOm3AU0U0VAJOAz3D9b0vGk4yrnKUl8
         fUIKSr0dvHl9i5bhpqz6/LIUztgHHz130xI0xJhl+yTDX+ayoLY0EDr1iF7z4KGkLI
         F1U43W5olojeK6tbpi04hGrOMBX4RnLWtCTsxqOECeymP6HmeXBWBuimU1wUyBckuS
         6YKHQ3s339LGQ==
Subject: Re: [PATCH resend v1 3/7] pps: clients: gpio: Remove redundant
 condition in ->remove()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Ryan Govostes <rgovostes@whoi.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20210309112403.36633-1-andriy.shevchenko@linux.intel.com>
 <20210309112403.36633-3-andriy.shevchenko@linux.intel.com>
From:   Rodolfo Giometti <giometti@enneenne.com>
Message-ID: <14d42964-3d70-070f-2481-263745c50f7b@enneenne.com>
Date:   Tue, 9 Mar 2021 13:25:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210309112403.36633-3-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfLAE+NBbeBGn9D3lRNporH4llNCTNfE77ZGkI6ObehSuJeQcpedl0UYoZuXIsfeJh2tbcQFOvykzLZ4mY+XrbnpKsy1KMBgk1lD4wjsBMy+OAvXpVYVN
 fmiM8iPz8maTXIraDcbBn5a58vslMkdcSpKh322FYaIN1gKm7q+VL4+qVp9gXoWFcvi+dfMwtlod+lkrHEuLy2/0kl/nGKm9Eoly3pg40uMCZcPlqIQkogjN
 XBlCTDAaGbsUlZWpp1Nm1atkFZjOerJn5yowFh/Ny4U9BOjrhJNTHpTHUt0YKx9q
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/21 12:23, Andy Shevchenko wrote:
> The timer along with GPIO API are NULL-aware, there is no need to test
> against existing GPIO echo line.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/pps/clients/pps-gpio.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pps/clients/pps-gpio.c b/drivers/pps/clients/pps-gpio.c
> index 78c9680e8063..dc9ed6fc3dae 100644
> --- a/drivers/pps/clients/pps-gpio.c
> +++ b/drivers/pps/clients/pps-gpio.c
> @@ -240,11 +240,9 @@ static int pps_gpio_remove(struct platform_device *pdev)
>  	struct pps_gpio_device_data *data = platform_get_drvdata(pdev);
>  
>  	pps_unregister_source(data->pps);
> -	if (data->echo_pin) {
> -		del_timer_sync(&data->echo_timer);
> -		/* reset echo pin in any case */
> -		gpiod_set_value(data->echo_pin, 0);
> -	}
> +	del_timer_sync(&data->echo_timer);
> +	/* reset echo pin in any case */
> +	gpiod_set_value(data->echo_pin, 0);
>  	dev_info(&pdev->dev, "removed IRQ %d as PPS source\n", data->irq);
>  	return 0;
>  }
> 

Acked-by: Rodolfo Giometti <giometti@enneenne.com>

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti
