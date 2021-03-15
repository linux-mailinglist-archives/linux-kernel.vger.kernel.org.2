Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC5933B2DF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 13:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhCOMfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 08:35:10 -0400
Received: from mga14.intel.com ([192.55.52.115]:57156 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229591AbhCOMfD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 08:35:03 -0400
IronPort-SDR: cW9U5hcq9HmL+T3sYj/E6FZZHErGhnWJHbKxOrRb20lgqQ6Tf+bvfX4sEyBXgVwDQ2V2EZgL0v
 wMqEi3VS7xdg==
X-IronPort-AV: E=McAfee;i="6000,8403,9923"; a="188438200"
X-IronPort-AV: E=Sophos;i="5.81,249,1610438400"; 
   d="scan'208";a="188438200"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2021 05:35:02 -0700
IronPort-SDR: RJ6GDEBA3wPOFqp8VhbHNMrFjGOFCIsv4syef9hLQcHO2D6RKcrj7/S5ctRNM1dWttLAbmrwj3
 AUVQ8UfOa64w==
X-IronPort-AV: E=Sophos;i="5.81,249,1610438400"; 
   d="scan'208";a="371613548"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2021 05:35:01 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lLmR0-00Cfus-Kd; Mon, 15 Mar 2021 14:34:58 +0200
Date:   Mon, 15 Mar 2021 14:34:58 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Rodolfo Giometti <giometti@enneenne.com>,
        Ryan Govostes <rgovostes@whoi.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH resend v1 1/7] pps: clients: gpio: Bail out on error when
 requesting GPIO echo line
Message-ID: <YE9Uclf+f6Tqls0n@smile.fi.intel.com>
References: <20210309112403.36633-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210309112403.36633-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2021 at 01:23:57PM +0200, Andy Shevchenko wrote:
> When requesting optional GPIO echo line, bail out on error,
> so user will know that something wrong with the existing property.

Greg, can you apply this series?

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
> -- 
> 2.30.1
> 

-- 
With Best Regards,
Andy Shevchenko


