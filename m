Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8104326617
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 18:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhBZRHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 12:07:11 -0500
Received: from mga14.intel.com ([192.55.52.115]:65016 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230040AbhBZRFZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 12:05:25 -0500
IronPort-SDR: OldlsLeSK1x3lAsir2KQ4z3RieaEKtyqvWwKX37qTYUxl9IQi+iS6GuyDzLs7eeXaqTXQcAC5N
 hq3KNnrOju/g==
X-IronPort-AV: E=McAfee;i="6000,8403,9907"; a="185248072"
X-IronPort-AV: E=Sophos;i="5.81,209,1610438400"; 
   d="scan'208";a="185248072"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2021 09:03:36 -0800
IronPort-SDR: H163A0v8r6xd8gSA5UP4M+NVoDU1cL2trpXdJug28WbJCR/gkcNAfn2cEw4c/QU9/egfMmYP/y
 osQ1jDe9ip+g==
X-IronPort-AV: E=Sophos;i="5.81,209,1610438400"; 
   d="scan'208";a="443137653"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2021 09:03:34 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lFgWa-008PHu-Fh; Fri, 26 Feb 2021 19:03:32 +0200
Date:   Fri, 26 Feb 2021 19:03:32 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Rodolfo Giometti <giometti@enneenne.com>,
        Ryan Govostes <rgovostes@whoi.edu>
Subject: Re: [PATCH v1 1/7] pps: clients: gpio: Bail out on error when
 requesting GPIO echo line
Message-ID: <YDkp5Jh8ZXWgr+zl@smile.fi.intel.com>
References: <20210216113154.70852-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210216113154.70852-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 16, 2021 at 01:31:48PM +0200, Andy Shevchenko wrote:
> When requesting optional GPIO echo line, bail out on error,
> so user will know that something wrong with the existing property.

Guys, any comments on this series?

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
> 2.30.0
> 

-- 
With Best Regards,
Andy Shevchenko


