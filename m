Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 335DB426C41
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 15:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242323AbhJHOBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 10:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232200AbhJHOBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 10:01:15 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A54C061570;
        Fri,  8 Oct 2021 06:59:20 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id r43-20020a05683044ab00b0054716b40005so11782849otv.4;
        Fri, 08 Oct 2021 06:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8JsMyVbYXWHmQqAN8dzkyw1M7z5ypmR5kNNO4PCodYA=;
        b=lFJ4SIH1i8YA7eHqIHo94ZEIvRL90OSHuH59FDvwVO0DBsjCNuJsW9/LMvnsIWeC0+
         ZGEFfVomyHn2A5/Al6Ft5EbX6KuEpZeQnS+MSB7VeGwy8SjbFApcBwrU+OCD6P9HJWXp
         hspeRsf2Dhy+Ar+ROxqEgt4Ofk0HcKPqlt70upnG+ZS9trKpKOVFeGh3ckbOdKAlwlMv
         hJGX63Rbxjxklyr7b370w+tedTZlIM5N0+OLh7d3BwTrVnvAlRT2vlBruzMq++KLVcyW
         eaBg9aIhWAr2W1eUoT5qqi+bE4bZgbPgNQcBEsylh7NDoBOLH3Y31R9/ItkZLOGOH+cE
         zV+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=8JsMyVbYXWHmQqAN8dzkyw1M7z5ypmR5kNNO4PCodYA=;
        b=f9SUZlshb7TFk/zt6RX4rI+aZHsZap2gOMzc2//rGlIAxots0A0S/obWCivyzF9WOw
         ckKh0Igkc7msoqT+v+oFVe2SLKu5i8aNQsF82q9F/5dUk/xzF+hifUJQ4Bzu9K7WjBjJ
         fpeMUEHM/UqGkN++uRP1cVVYVrM7Q05r5pyR/5JroyX90tkEnZxY9GuCRoCbJ/UgD3w4
         9IYeyqIUmd5lKU0mtW7Yj2mTdvgK/1OY7d5bEUY2ITZyONMab98MzexzbEt+53HAV0Pl
         osnqjN5+Sfmz7qIO5HOxJKFbypVy4xshZwJHKkUFHClUH+QrkdAyzOLomjBNwgwxutOo
         Pwzg==
X-Gm-Message-State: AOAM531GxHZEG7rcuVdwarHojFgA0z9nGPLIppddW0JNqTclAQv+qQ7O
        5OFHsGRG4yCbYE1i/nIIAtCZdipgv3c=
X-Google-Smtp-Source: ABdhPJy9fPMAPHrZ+eyMwt0sZPpeq7DOmUfARxi/g/ZFPiENBMcVG1YnNp+8B13WIxPPMkUO3UHR6Q==
X-Received: by 2002:a05:6830:1c2f:: with SMTP id f15mr333690ote.63.1633701559955;
        Fri, 08 Oct 2021 06:59:19 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x10sm525693ooa.16.2021.10.08.06.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 06:59:19 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 8 Oct 2021 06:59:18 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] hwmon: (pmbus/lm25066) Add OF device ID table
Message-ID: <20211008135918.GA1577122@roeck-us.net>
References: <20210928092242.30036-1-zev@bewilderbeest.net>
 <20210928092242.30036-7-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210928092242.30036-7-zev@bewilderbeest.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 02:22:40AM -0700, Zev Weiss wrote:
> See commit 8881a19187e4 ("hwmon: (ucd9000) Add OF device ID table")
> for reasoning.
> 
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> ---
>  drivers/hwmon/pmbus/lm25066.c | 26 ++++++++++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/lm25066.c b/drivers/hwmon/pmbus/lm25066.c
> index dbbf8571c437..18d5a76f346d 100644
> --- a/drivers/hwmon/pmbus/lm25066.c
> +++ b/drivers/hwmon/pmbus/lm25066.c
> @@ -14,6 +14,7 @@
>  #include <linux/slab.h>
>  #include <linux/i2c.h>
>  #include <linux/log2.h>
> +#include <linux/of_device.h>
>  #include "pmbus.h"
>  
>  enum chips { lm25056, lm25066, lm5064, lm5066, lm5066i };
> @@ -444,12 +445,24 @@ static const struct i2c_device_id lm25066_id[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, lm25066_id);
>  
> +static const struct of_device_id __maybe_unused lm25066_of_match[] = {
> +	{ .compatible = "ti,lm25056", .data = (void*)lm25056, },
> +	{ .compatible = "ti,lm25066", .data = (void*)lm25066, },
> +	{ .compatible = "ti,lm5064",  .data = (void*)lm5064,  },
> +	{ .compatible = "ti,lm5066",  .data = (void*)lm5066,  },
> +	{ .compatible = "ti,lm5066i", .data = (void*)lm5066i, },

On a side note, you got lazy here. Should be "void *".

> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, lm25066_of_match);
> +
>  static int lm25066_probe(struct i2c_client *client)
>  {
>  	int config;
>  	struct lm25066_data *data;
>  	struct pmbus_driver_info *info;
>  	const struct __coeff *coeff;
> +	const struct of_device_id *of_id;
> +	const struct i2c_device_id *i2c_id;
>  
>  	if (!i2c_check_functionality(client->adapter,
>  				     I2C_FUNC_SMBUS_READ_BYTE_DATA))
> @@ -464,7 +477,15 @@ static int lm25066_probe(struct i2c_client *client)
>  	if (config < 0)
>  		return config;
>  
> -	data->id = i2c_match_id(lm25066_id, client)->driver_data;
> +	i2c_id = i2c_match_id(lm25066_id, client);
> +
> +	of_id = of_match_device(lm25066_of_match, &client->dev);
> +	if (of_id && (enum chips)of_id->data != i2c_id->driver_data)
> +		dev_notice(&client->dev,
> +		           "Device mismatch: %s in device tree, %s detected\n",
> +		           of_id->name, i2c_id->name);

Also, this used spaces instead of tabs for indentation.

Never mind, I fixed it up. But please run checkpatch on your patches.

Guenter

> +
> +	data->id = i2c_id->driver_data;
>  	info = &data->info;
>  
>  	info->pages = 1;
> @@ -521,7 +542,8 @@ static int lm25066_probe(struct i2c_client *client)
>  static struct i2c_driver lm25066_driver = {
>  	.driver = {
>  		   .name = "lm25066",
> -		   },
> +		   .of_match_table = of_match_ptr(lm25066_of_match),
> +	},
>  	.probe_new = lm25066_probe,
>  	.id_table = lm25066_id,
>  };
