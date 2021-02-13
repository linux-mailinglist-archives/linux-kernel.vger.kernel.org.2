Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E44731AB41
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 13:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbhBMMRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Feb 2021 07:17:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:49474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229592AbhBMMRh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Feb 2021 07:17:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2F2DD64DEE;
        Sat, 13 Feb 2021 12:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613218617;
        bh=KmbflJ0YoHgNgSPRqx42Vo2X8eq2xvdTxstvXNBq98g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NTHIZigHAZm0j/4W2rVu23c40EQGnBtw7q1Cy3IBQKoPAPpD303jetVUkWLvh/l2a
         9dXhacPN+Y5H5m7sI0QSWyddhdxZ0lbYlDe/2gTM0MNpLYEwyA+D/ONkVVi7hWpGzB
         98wnjyk37TStd48VWctFZqkyL426Qpju++mgORsg=
Date:   Sat, 13 Feb 2021 13:16:52 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     mazziesaccount@gmail.com, Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [RFC PATCH 3/7] hwmon: raspberry-pi: Clean-up few drivers by
 using managed work init
Message-ID: <YCfDNG4rx0sRZEaG@kroah.com>
References: <cover.1613216412.git.matti.vaittinen@fi.rohmeurope.com>
 <1ee4b1bcc926b60e513e8f5cd586e744de2cb12d.1613216412.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ee4b1bcc926b60e513e8f5cd586e744de2cb12d.1613216412.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 13, 2021 at 02:07:02PM +0200, Matti Vaittinen wrote:
> Few drivers implement remove call-back only for ensuring a delayed
> work gets cancelled prior driver removal. Clean-up these by switching
> to use devm_delayed_work_autocancel() instead.
> 
> This change is compile-tested only. All testing is appreciated.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---
>  drivers/hwmon/raspberrypi-hwmon.c | 16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/hwmon/raspberrypi-hwmon.c b/drivers/hwmon/raspberrypi-hwmon.c
> index d3a64a35f7a9..acfa674932bc 100644
> --- a/drivers/hwmon/raspberrypi-hwmon.c
> +++ b/drivers/hwmon/raspberrypi-hwmon.c
> @@ -106,6 +106,7 @@ static int rpi_hwmon_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct rpi_hwmon_data *data;
> +	int ret;
>  
>  	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>  	if (!data)
> @@ -119,7 +120,10 @@ static int rpi_hwmon_probe(struct platform_device *pdev)
>  							       &rpi_chip_info,
>  							       NULL);
>  
> -	INIT_DELAYED_WORK(&data->get_values_poll_work, get_values_poll);
> +	ret = devm_delayed_work_autocancel(dev, &data->get_values_poll_work,
> +					   get_values_poll);
> +	if (ret)
> +		return ret;
>  	platform_set_drvdata(pdev, data);
>  
>  	if (!PTR_ERR_OR_ZERO(data->hwmon_dev))
> @@ -128,18 +132,8 @@ static int rpi_hwmon_probe(struct platform_device *pdev)
>  	return PTR_ERR_OR_ZERO(data->hwmon_dev);
>  }
>  
> -static int rpi_hwmon_remove(struct platform_device *pdev)
> -{
> -	struct rpi_hwmon_data *data = platform_get_drvdata(pdev);
> -
> -	cancel_delayed_work_sync(&data->get_values_poll_work);
> -
> -	return 0;
> -}
> -
>  static struct platform_driver rpi_hwmon_driver = {
>  	.probe = rpi_hwmon_probe,
> -	.remove = rpi_hwmon_remove,
>  	.driver = {
>  		.name = "raspberrypi-hwmon",
>  	},

So if I manually unbind the driver from the device, and then unload the
driver, what happens?

thanks,

greg k-h
