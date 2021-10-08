Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E647A426BFF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 15:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbhJHNyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 09:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232821AbhJHNyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 09:54:23 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94FB2C061570;
        Fri,  8 Oct 2021 06:52:28 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id g62-20020a9d2dc4000000b0054752cfbc59so11851162otb.1;
        Fri, 08 Oct 2021 06:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+i4BnWwioMXqufQiZh2zuVnG+g9/2NgvXRETnHtcmTQ=;
        b=eaBQ4tyXliwaoPiOnTCH+g9OK5zg68yY2536ktnyZPqaidaPjKzJvpyjQxwRcBl0A8
         DlfOPjip2D2vdpCD7RGkSGilsKwjR5XVmYL6EH9qf2SZ1XKd57rZY29aHCpctO/JV8vJ
         j4neB7ZKpPzLMPr2MLie2hThEXGYNyE/OGvxMhS9g4kKzIrPHncgv0o/u6sFx0IqJJ/T
         1+CMGx+IDECPDGHcp2zsDb3XIPtOlBgZvvgzDH3vXS/vlP0xAk+Lo+e0fkPVX5nRkx79
         3G1hhbRZpWZxAdKd9HqL+pDta6+NW+KR6AK/0oelV6mGlG88fxUthtmrxcJIS7dxwvGV
         i3Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=+i4BnWwioMXqufQiZh2zuVnG+g9/2NgvXRETnHtcmTQ=;
        b=XE7Jxqcy+F2VA5xXlHY5LQHnj0VyZmvY18rEnu5KyDOcUHd3OM3OE2Ew7HmSNxDSzR
         p5wEtoWCZ+zkgGFtTavgXfcvKddtZ0U+z5IefHh09U4jaQ6VuyD14Dk6lC4289c1Ct+Y
         j3JRvYw0qM7uWE7WVl6XVOTu6Yhvjfu0fgsztyOaDTmHIfFT8Au7FqrpayMRVElvBr1r
         3abxRXiXnDndsBP71koD63voqYA2tdPhU5gIBS4iUGX+7Dk1kwGD8sXQiD2QSzIZ33tY
         d3dzCuy9bHFh8mUY0Pc3DdMEjOyKPkze/7UwZbboFEVYMTLGZWT831UEuYBRFI0P7Wz2
         HjQA==
X-Gm-Message-State: AOAM5319ov9wJQcb2qcMcSmMLb0u2ZEaHRrN3tK8295xt6Ov3TkIcHbP
        hQ9dSC5mExdjvmnUSrjyD+k=
X-Google-Smtp-Source: ABdhPJyX1g5WIFgiFMAAG5OCUYF8HFUYpdaJ53EUERXJqxtMq5b7ctNVA4GCcByYcek7Ze/bcvDj7Q==
X-Received: by 2002:a9d:4049:: with SMTP id o9mr9057064oti.161.1633701147944;
        Fri, 08 Oct 2021 06:52:27 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l25sm513275oot.36.2021.10.08.06.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 06:52:27 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 8 Oct 2021 06:52:26 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] hwmon: (pmbus/lm25066) Add OF device ID table
Message-ID: <20211008135226.GA1366565@roeck-us.net>
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
The actual reasoning should be provided here, not a reference to another
commit. Never mind, I did that.

> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>

Applied.

Thanks,
Guenter

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
