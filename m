Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A50634469E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 15:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbhCVOFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 10:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbhCVOFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 10:05:35 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9F0C061574;
        Mon, 22 Mar 2021 07:05:34 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id v24-20020a9d69d80000b02901b9aec33371so16034396oto.2;
        Mon, 22 Mar 2021 07:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dfjnv6L7Ciki+bKl8nLAWCT1xwGBzrkurx98NFEQRco=;
        b=rN1NzJ8mtolZFQLIqqxdiByRsOOR10E1Z3CAP0BArUuJKJCLHI4fUl/oH2o/7nOnIq
         njKADPnLEFBk3zw0d0jVQ/+B7I0jen0SGVONIZSP/jICVeEer1i5p27Aj49uiOoy31MX
         mG3UikIlV7Vvgx9Yx+5ERpCsHbz/H0buHtDTkZeEmWtPFn/r9iz5TbYLM/VD5nqWP+Gn
         5+B8YlkQoNx8dEHEpBmc+Ee8A3JHjNQJbuOaXUwtSMFezPCBqBmMHJACg5xnHBO47mHt
         i+mEWqDFBu9b7TWRxe20EIyn/fDPEuFgUtVZO2UZN/8qNHA5pspBSyGRO8Yo9fiP/uy1
         Up4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=dfjnv6L7Ciki+bKl8nLAWCT1xwGBzrkurx98NFEQRco=;
        b=g5JsHTzq8E7eXE9drifkWktk2/UkG1qKHo9FecyLOjJ1m/9UUDF2aqgNb6L1bL0TM4
         Wrf9JFF/i8cm9Ya7jZ/hLe5oVmE5nqTS0Hh2iakLx8iGC+O5kmitzRrSx3DKUnw+D9H2
         TmlEE9QVi7AYuf1pgnOikwLNJaiC58qQtnRQk/vpCNcHPr0YJVHKRUOBRwwNYUKYfrRp
         TV5i5slNbEj1aXigGV3aOVSBQ1A5Ib95xQFc8lNsfOHjIsTM2ZVDKEUjndPWOvTJYxqf
         lbBq34mfw1LsVjZJGhNhkkiTMcY+msaDd39lV1xY/ZxHkj17gb5sE4K86s/1809Axr6f
         QPFw==
X-Gm-Message-State: AOAM532raSgCOMG6BhFomAJMEvjlHr0DYXHOs3Kd+u3hW/4GkRR46zk2
        gyqSMM1aug2digkPYmwa1APV3oaX3GY=
X-Google-Smtp-Source: ABdhPJzwYXQ0zMFfAdt+UbSU977rek77eNMyQE/EPR8yx214XzX6QxC0mfhpMfMcPTZ36jqpxdZ+4A==
X-Received: by 2002:a9d:62d1:: with SMTP id z17mr132888otk.118.1616421934202;
        Mon, 22 Mar 2021 07:05:34 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w16sm3430366otq.15.2021.03.22.07.05.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Mar 2021 07:05:33 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 22 Mar 2021 07:05:32 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Hans de Goede <hdegoede@redhat.com>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Subject: Re: [RFC RESEND PATCH v2 4/8] hwmon: raspberry-pi: Clean-up few
 drivers by using managed work init
Message-ID: <20210322140532.GB140507@roeck-us.net>
References: <cover.1616395565.git.matti.vaittinen@fi.rohmeurope.com>
 <fc14075a0aae06678cde0bae80ec92d93378ac62.1616395565.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc14075a0aae06678cde0bae80ec92d93378ac62.1616395565.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 09:37:18AM +0200, Matti Vaittinen wrote:
> Few drivers implement remove call-back only for ensuring a delayed
> work gets cancelled prior driver removal. Clean-up these by switching
> to use devm_delayed_work_autocancel() instead.
> 
> This change is compile-tested only. All testing is appreciated.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/hwmon/raspberrypi-hwmon.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/hwmon/raspberrypi-hwmon.c b/drivers/hwmon/raspberrypi-hwmon.c
> index d3a64a35f7a9..805d396aa81b 100644
> --- a/drivers/hwmon/raspberrypi-hwmon.c
> +++ b/drivers/hwmon/raspberrypi-hwmon.c
> @@ -7,6 +7,7 @@
>   * Copyright (C) 2018 Stefan Wahren <stefan.wahren@i2se.com>
>   */
>  #include <linux/device.h>
> +#include <linux/devm-helpers.h>
>  #include <linux/err.h>
>  #include <linux/hwmon.h>
>  #include <linux/module.h>
> @@ -106,6 +107,7 @@ static int rpi_hwmon_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct rpi_hwmon_data *data;
> +	int ret;
>  
>  	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>  	if (!data)
> @@ -119,7 +121,10 @@ static int rpi_hwmon_probe(struct platform_device *pdev)
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
> @@ -128,18 +133,8 @@ static int rpi_hwmon_probe(struct platform_device *pdev)
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
> -- 
> 2.25.4
> 
> 
> -- 
> Matti Vaittinen, Linux device drivers
> ROHM Semiconductors, Finland SWDC
> Kiviharjunlenkki 1E
> 90220 OULU
> FINLAND
> 
> ~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
> Simon says - in Latin please.
> ~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
> Thanks to Simon Glass for the translation =] 
