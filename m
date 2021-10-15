Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC49342FDC2
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 00:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243220AbhJOWDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 18:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbhJOWDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 18:03:36 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48004C061570;
        Fri, 15 Oct 2021 15:01:29 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 34-20020a9d0325000000b00552cae0decbso4454303otv.0;
        Fri, 15 Oct 2021 15:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kXV+8u2z0PXq5hQF/5zRjzhxcWTJ/etl98iykZqGjRo=;
        b=q5jUN3iISavANR/5hqWdaF7w3sLkmv5Znul2j/+Gj4v3HTZfdPYNMsi9b58+Mq4xk+
         Svl1wXXRo5UyYsngFd1Q7FSoPawfHvguBEv2xB4a7NhjAQ317D+iz/0J94qb4qpGbJ6q
         ZuP+1xfA2pEtJOmI5c+sn2BUd7lCE0vQnPA2w8frQ4QhalJqQtAZrUBkKP73stvKnRe0
         YAJW1gqJJ8QqXHCATripPh03+2dFRg2fRY8fGafDd677dfBkJ/t+UFYjsZG9NFpbOWQe
         89xvQr6DD7ZxL7HgYBpaDgVacI+DBkY+IpB3PJv7K9IOW/MycM21+ZyC9kEyAQjnMzdS
         0KjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kXV+8u2z0PXq5hQF/5zRjzhxcWTJ/etl98iykZqGjRo=;
        b=g9I1Yrpzue6CG6V0EF7pGLu6Re6QJIVcVmn1tX6Y4tFOl2YdyacXMjVfXD8NpU/AHv
         Zv7pTVt6QxYJe2p/iANRUOo3d9XWL8/+IOu31xEjohPN3OfvgAGwZmDbd86DzSV7Kw3x
         ovRULxzSLr1yrD1J22dWYUge31tg4zrNXvfrJSmoB+HdaMd4DdtBO8GMlE9NFOmRaaCx
         9AoUSYPga8Iz9c7kguM+RqGtHHn4YhuSNJrHCK1dA3a76wHJrQEsKPVxhVDgh+eU3GH3
         U2o2g/esP2KhHcCGwiudKkSa0FPAASyO5lOH0hPXdTeuO29V4Mb5EPLynO65USW0zl4I
         qQ0Q==
X-Gm-Message-State: AOAM533nz2kPRbK13K2MaO9JM4kIF5XO+ictmburn5mHtbbKvm3vvCtb
        cevI1cBgIuuX/pfBf4K4zSnmdXnd6Gc=
X-Google-Smtp-Source: ABdhPJwEI//gt0Tt1gWwC/bBEhRY2aU0gksh1u+LZLzt21IR7jIdC3yZ9FgiZBSQte8Fz7TMAvCsmA==
X-Received: by 2002:a05:6830:81a:: with SMTP id r26mr9957716ots.176.1634335288429;
        Fri, 15 Oct 2021 15:01:28 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z8sm1183857oof.47.2021.10.15.15.01.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Oct 2021 15:01:27 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH] hwmon: (ad7414) cleanup codestyle
To:     Sohaib Mohamed <sohaib.amhmd@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211015122843.135814-1-sohaib.amhmd@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <c46c3b62-ee95-8d01-2f45-0110ecf942b8@roeck-us.net>
Date:   Fri, 15 Oct 2021 15:01:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211015122843.135814-1-sohaib.amhmd@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/15/21 5:28 AM, Sohaib Mohamed wrote:
> - Add a blank line after declarations
> - Prefer using '"%s...", __func__' to using 'ad7414_probe'
> - Don't split strings across lines
> 
> Signed-off-by: Sohaib Mohamed <sohaib.amhmd@gmail.com>

Please refrain from such cleanup patches unless you also make functional changes to a driver.

Guenter

> ---
>   drivers/hwmon/ad7414.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/ad7414.c b/drivers/hwmon/ad7414.c
> index 0afb89c4629d..52df6005812c 100644
> --- a/drivers/hwmon/ad7414.c
> +++ b/drivers/hwmon/ad7414.c
> @@ -107,6 +107,7 @@ static ssize_t temp_input_show(struct device *dev,
>   			       struct device_attribute *attr, char *buf)
>   {
>   	struct ad7414_data *data = ad7414_update_device(dev);
> +
>   	return sprintf(buf, "%d\n", ad7414_temp_from_reg(data->temp_input));
>   }
>   static SENSOR_DEVICE_ATTR_RO(temp1_input, temp_input, 0);
> @@ -116,6 +117,7 @@ static ssize_t max_min_show(struct device *dev, struct device_attribute *attr,
>   {
>   	int index = to_sensor_dev_attr(attr)->index;
>   	struct ad7414_data *data = ad7414_update_device(dev);
> +
>   	return sprintf(buf, "%d\n", data->temps[index] * 1000);
>   }
>   
> @@ -152,6 +154,7 @@ static ssize_t alarm_show(struct device *dev, struct device_attribute *attr,
>   	int bitnr = to_sensor_dev_attr(attr)->index;
>   	struct ad7414_data *data = ad7414_update_device(dev);
>   	int value = (data->temp_input >> bitnr) & 1;
> +
>   	return sprintf(buf, "%d\n", value);
>   }
>   
> @@ -192,7 +195,7 @@ static int ad7414_probe(struct i2c_client *client)
>   	/* Make sure the chip is powered up. */
>   	conf = i2c_smbus_read_byte_data(client, AD7414_REG_CONF);
>   	if (conf < 0)
> -		dev_warn(dev, "ad7414_probe unable to read config register.\n");
> +		dev_warn(dev, "%s unable to read config register.\n", __func__);
>   	else {
>   		conf &= ~(1 << 7);
>   		i2c_smbus_write_byte_data(client, AD7414_REG_CONF, conf);
> @@ -227,8 +230,7 @@ static struct i2c_driver ad7414_driver = {
>   
>   module_i2c_driver(ad7414_driver);
>   
> -MODULE_AUTHOR("Stefan Roese <sr at denx.de>, "
> -	      "Frank Edelhaeuser <frank.edelhaeuser at spansion.com>");
> +MODULE_AUTHOR("Stefan Roese <sr at denx.de>, Frank Edelhaeuser <frank.edelhaeuser at spansion.com>");
>   
>   MODULE_DESCRIPTION("AD7414 driver");
>   MODULE_LICENSE("GPL");
> 

