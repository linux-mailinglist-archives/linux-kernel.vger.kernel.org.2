Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0620D390F3D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 06:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbhEZEQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 00:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbhEZEQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 00:16:40 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA881C061574;
        Tue, 25 May 2021 21:15:09 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id b25so320824oic.0;
        Tue, 25 May 2021 21:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:to:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LR/t0Vt7qvFIvvy6uNALsvjkfSl1ofhhwPuv6EYwxew=;
        b=gnmmOVwZQhAwv2besNqrPZWelhd0s3AdWLPImDKRi4sWthJrzKbbWZl0QiiEYosS0j
         9DJVRGh/2tFePuL1zoZuqr64BMexFLsoLqczxyDON7H1wdJS9ZRHYxFN326qlQqkATct
         v9+UpdJa0Lf/+FNbsylIhDXLYuCam/kehl4dZTQAOshhg07gw4MRdn/6c1l3HrJdJc0k
         Ibi9dqGsl9ZDdkrCvHd/UIIfsf64arvOVedYW/YfGKoRo2lNkwTocSEDe50hYAB4uiG6
         5SMLSEzlIN9XIYZDzIsfmiFeue11BTHXVfoNeo7Q8DgbdD08/p1qI72FrJkycD7fQadC
         +0DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:to:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LR/t0Vt7qvFIvvy6uNALsvjkfSl1ofhhwPuv6EYwxew=;
        b=geUEztTpQ7RfoIygNqGiGylsnM4zrAGvM9UEq5TTtRxJF48IfybD30yJVudtAWZe67
         m6HHtBUoZpjB/y2/I1Op1oOREL3IEnD7ovOx80rYi1yL21BqXUEywQ/IMa01hAeoND1L
         nAf0R4CkAFJnIHWfUYfGefdt4/3r5CAeZWT/7Le0Ss+Nztv21ECENJmbJy7I8PYoAQi7
         EAaCu5cBs9Koyxe6AIm1Kc49XLWBNOxfCvDn/+StpZyuCs0yUzohXaN6Y862x8FK7/MC
         uzPY1VoqWUtleDQXarRa6TxCbTsDCMXbnMfsXNyEvIN7Z5QjkcjQOKkuPHYG909MuxUA
         ZYvA==
X-Gm-Message-State: AOAM532z9IH5BYOozuoG0Az+rG+n5DYWRU5HsfAMdIs01QAdzKjCY7uz
        o9s31KWDhl8IcUCysmgbkHtEyKpEzq8=
X-Google-Smtp-Source: ABdhPJzgabL5J6fnK4qvcI0NV2swQsM8iDzjdiW32rJ5O/CRoiTATdoP5Ol3oG8vawPv7GjYPCE/DQ==
X-Received: by 2002:a05:6808:d47:: with SMTP id w7mr617183oik.104.1622002508582;
        Tue, 25 May 2021 21:15:08 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o20sm3936076oos.19.2021.05.25.21.15.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 May 2021 21:15:08 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Erik Rosen <erik.rosen@metormote.com>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210524150246.90546-1-erik.rosen@metormote.com>
 <20210524150246.90546-4-erik.rosen@metormote.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v3 3/6] hwmon: (pmbus/pim4328) Add support for reading
 direct format coefficients
Message-ID: <edf5c762-16c0-f6a7-a4f5-90065bc9781a@roeck-us.net>
Date:   Tue, 25 May 2021 21:15:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210524150246.90546-4-erik.rosen@metormote.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/24/21 8:02 AM, Erik Rosen wrote:
> Add support for reading and decoding direct format coefficients to
> the PMBus core driver. If the new flag PMBUS_USE_COEFFICIENTS_CMD
> is set, the driver will use the COEFFICIENTS register together with
> the information in the pmbus_sensor_attr structs to initialize
> relevant coefficients for the direct mode format.
> 
> Signed-off-by: Erik Rosen <erik.rosen@metormote.com>
> ---
>   drivers/hwmon/pmbus/pmbus_core.c | 82 ++++++++++++++++++++++++++++++++
>   include/linux/pmbus.h            |  8 ++++
>   2 files changed, 90 insertions(+)
> 
> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
> index 460cbfd716e4..32e29f6dee38 100644
> --- a/drivers/hwmon/pmbus/pmbus_core.c
> +++ b/drivers/hwmon/pmbus/pmbus_core.c
> @@ -2177,6 +2177,77 @@ static int pmbus_find_attributes(struct i2c_client *client,
>   	return ret;
>   }
>   
> +/*
> + * The pmbus_class_attr_map structure maps one sensor class to
> + * it's corresponding sensor attributes array.
> + */
> +struct pmbus_class_attr_map {
> +	enum pmbus_sensor_classes class;
> +	u8 nattr;

u8 doesn't save anything and on most architectures makes the code more
complicated. Just use int.

> +	const struct pmbus_sensor_attr *attr;
> +};
> +
> +static const struct pmbus_class_attr_map class_attr_map[] = {
> +	{
> +		.class = PSC_VOLTAGE_IN,
> +		.attr = voltage_attributes,
> +		.nattr = ARRAY_SIZE(voltage_attributes),
> +	}, {
> +		.class = PSC_VOLTAGE_OUT,
> +		.attr = voltage_attributes,
> +		.nattr = ARRAY_SIZE(voltage_attributes),
> +	}, {
> +		.class = PSC_CURRENT_IN,
> +		.attr = current_attributes,
> +		.nattr = ARRAY_SIZE(current_attributes),
> +	}, {
> +		.class = PSC_CURRENT_OUT,
> +		.attr = current_attributes,
> +		.nattr = ARRAY_SIZE(current_attributes),
> +	}, {
> +		.class = PSC_POWER,
> +		.attr = power_attributes,
> +		.nattr = ARRAY_SIZE(power_attributes),
> +	}, {
> +		.class = PSC_TEMPERATURE,
> +		.attr = temp_attributes,
> +		.nattr = ARRAY_SIZE(temp_attributes),
> +	}
> +};
> +
> +static int pmbus_init_coefficients(struct i2c_client *client,
> +				   struct pmbus_data *data)
> +{
> +	int i, n;
> +	int ret = 0;

Unnecessary initialization

> +	const struct pmbus_class_attr_map *map;
> +	const struct pmbus_sensor_attr *attr;
> +
> +	for (i = 0; i < ARRAY_SIZE(class_attr_map); i++) {
> +		map = &class_attr_map[i];
> +		if (data->info->format[map->class] != direct)
> +			continue;
> +		for (n = 0; n < map->nattr; n++) {
> +			attr = &map->attr[n];
> +			if (map->class != attr->class)
> +				continue;
> +			ret = pmbus_read_coefficients(client,
> +						      (struct pmbus_driver_info *)data->info,

This is not a good idea. data->info points to a constant. Is there a reason
to pass data instead of info as argument to this function ?

> +						      attr->class,
> +						      attr->reg);
> +			if (ret >= 0)
> +				break;
> +		}
> +		if (ret < 0) {
> +			dev_err(&client->dev, "No coefficients found for sensor class %d\n",
> +				map->class); > +			return -EINVAL;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>   /*
>    * Identify chip parameters.
>    * This function is called for all chips.
> @@ -2296,6 +2367,17 @@ static int pmbus_init_common(struct i2c_client *client, struct pmbus_data *data,
>   			return ret;
>   		}
>   	}
> +
> +	if (data->flags & PMBUS_USE_COEFFICIENTS_CMD) {
> +		if (!i2c_check_functionality(client->adapter,
> +					     I2C_FUNC_SMBUS_BLOCK_PROC_CALL))
> +			return -ENODEV;
> +
> +		ret = pmbus_init_coefficients(client, data);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
>   	return 0;
>   }
>   
> diff --git a/include/linux/pmbus.h b/include/linux/pmbus.h
> index f720470b1bab..7fdc282dab5a 100644
> --- a/include/linux/pmbus.h
> +++ b/include/linux/pmbus.h
> @@ -52,6 +52,14 @@
>    */
>   #define PMBUS_NO_WRITE_PROTECT			BIT(4)
>   
> +/*
> + * PMBUS_USE_COEFFICIENTS_CMD
> + *
> + * When this flag is set the PMBus core driver will use the COEFFICIENTS
> + * register to initialize the coefficients for the direct mode format.
> + */
> +#define PMBUS_USE_COEFFICIENTS_CMD		BIT(5)
> +
>   struct pmbus_platform_data {
>   	u32 flags;		/* Device specific flags */
>   
> 

