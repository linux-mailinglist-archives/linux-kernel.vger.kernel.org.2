Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA91A38D612
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 15:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbhEVNnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 09:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbhEVNnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 09:43:00 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A55C061574;
        Sat, 22 May 2021 06:41:35 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id i8-20020a4aa1080000b0290201edd785e7so5237706ool.1;
        Sat, 22 May 2021 06:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:to:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6q8b1N4MxU8JhrPvdZs1GsjYLUNjhqrng5So4JodxJc=;
        b=s4J31AQDxIfkUDrXCTiZJClwfIXFmxjXh5NWzVM2vm+vsZBywqa30tWoKTY7I9swID
         qGT21w/c/JbuW/OikBh+vOh/Db5csjuLSg1upgu5cZ57Q6/5xb1EHuFhZu8NyM3BqAcg
         poZCHmtoOgDxdPWrVhF7LNn0NoOZTZJPnYVlgACWKtivuKAVuZTabYTjwp8VGDiaV2YQ
         OoTRh++SZK8PQ0awpNcMEv6ix2vSTvmieDuHIHB3qX9vDnsURIDuApoenVe34U36jVdg
         ViYGZHJ3qQHJDrnVuuouQHNbTw2xmZSwzO30X7LmlSQaByXmdPk1tGiEyQ1zZUpjolOL
         C4wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:to:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6q8b1N4MxU8JhrPvdZs1GsjYLUNjhqrng5So4JodxJc=;
        b=pw7zO24WlmUBe1Qrm+6GhGvIBdGPcmwCYawIFyXBxDsaYROccJ8lD2xOeAIOXBOnKL
         7slpWFsaMf/EhtairYP8idrzze/w/miBEy+kvB6Qf8sQgf79l9woXDEae9mK34xQsw0O
         fL5x8oS/1Yw0i0tJMKpaADChSG9hx26zgKt7AAcMhMUOhJ4QpWjovlJ3IBqttx21zx3e
         HlCRPGVvr5DYsjjaFCAerCC+Av8vucs+bdAYDAnhkDSKiS4GQVVObBReCz6YtKh7S4M5
         oxEuRheqhCaRDhyaecYquYPYWFiX2CbXd1n8m8rNLH+QQ7QA6rielnFFMRMyBpfq+U0V
         MNNg==
X-Gm-Message-State: AOAM533fEl4LzUndncyzLHLHg74qKIqI8S4vCUckqKxQ/O+iJDraSGTp
        W07TuDGxBATe73Y3hcQjrW+PuMhz+tE=
X-Google-Smtp-Source: ABdhPJyjpHx6voET46fAH6m5fZRnU7WXKwfKKro8RpIUVCcIKyM3F7kGLQIbUWhv/XrdF1jBJC+HZA==
X-Received: by 2002:a4a:dd99:: with SMTP id h25mr3364272oov.63.1621690893825;
        Sat, 22 May 2021 06:41:33 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h59sm1860042otb.29.2021.05.22.06.41.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 May 2021 06:41:33 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Erik Rosen <erik.rosen@metormote.com>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210522105528.87629-1-erik.rosen@metormote.com>
 <20210522105528.87629-4-erik.rosen@metormote.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 3/6] hwmon: (pmbus/pim4328) Add support for reading
 direct format coefficients
Message-ID: <24ff79b6-29f5-6921-7418-9ba93bcf7193@roeck-us.net>
Date:   Sat, 22 May 2021 06:41:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210522105528.87629-4-erik.rosen@metormote.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/22/21 3:55 AM, Erik Rosen wrote:
> Add support for reading and decoding direct format coefficients to
> the PMBus core driver. If the new flag PMBUS_USE_COEFFICIENTS_CMD
> is set, the driver will use the COEFFICIENTS register together with
> the information in the pmbus_sensor_attr structs to initialize
> relevant coefficients for the direct mode format.
> 
> Signed-off-by: Erik Rosen <erik.rosen@metormote.com>
> ---
>   drivers/hwmon/pmbus/pmbus_core.c | 93 ++++++++++++++++++++++++++++++++
>   include/linux/pmbus.h            |  8 +++
>   2 files changed, 101 insertions(+)
> 
> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
> index 460cbfd716e4..03c169bf5633 100644
> --- a/drivers/hwmon/pmbus/pmbus_core.c
> +++ b/drivers/hwmon/pmbus/pmbus_core.c
> @@ -2177,6 +2177,38 @@ static int pmbus_find_attributes(struct i2c_client *client,
>   	return ret;
>   }
>   
> +static int pmbus_init_coefficients(struct i2c_client *client,
> +				   struct pmbus_data *data, int page,

This seems wrong. Coefficients are not maintained per page but per class,
and (re-)reading them for each supported page doesn't really add value or
even make sense.

> +				   enum pmbus_sensor_classes sensor_class,
> +				   const struct pmbus_sensor_attr *attrs,
> +				   int nattrs)
> +{
> +	int i, status;
> +
> +	for (i = 0; i < nattrs; i++) {
> +		if (attrs->class == sensor_class &&
> +		    (attrs->func & data->info->func[page])) {
> +			status = pmbus_read_coefficients(client,
> +							 (struct pmbus_driver_info *)data->info,
> +							 sensor_class,
> +							 attrs->reg);
> +			if (status < 0) {
> +				dev_err(&client->dev,
> +					"Failed to read coefficients for register: %x\n",
> +					attrs->reg);
> +				return status;
> +			}
> +			return 0;
> +		}
> +		attrs++;
> +	}
> +
> +	dev_err(&client->dev, "No coefficients found for register: %x\n",
> +		attrs->reg);
> +

attrs points beyond the array size here, so attrs->reg does not point
to a valid array element. The problem would also not be the register
this happens to point to, but the class (ie the chip does not support
a sensor of the requested class).

Not sure if this should trigger a message or error in the first place.
It won't matter since the chip will never need those coefficients.
If anything, this would be a misconfiguration (the driver should
not set direct format for this sensor class), and the return value
should be -EINVAL.

Either case, I wonder if this can be handled with less complex code,
ie without having to check data->info->func[] for all pages. How
about just walking through attrs and try all class matches until
one is found that works (ie not return on error but keep trying) ?

> +	return -ENODEV;
> +}
> +
>   /*
>    * Identify chip parameters.
>    * This function is called for all chips.
> @@ -2185,6 +2217,7 @@ static int pmbus_identify_common(struct i2c_client *client,
>   				 struct pmbus_data *data, int page)
>   {
>   	int vout_mode = -1;
> +	int ret;
>   
>   	if (pmbus_check_byte_register(client, page, PMBUS_VOUT_MODE))
>   		vout_mode = _pmbus_read_byte_data(client, page,
> @@ -2214,6 +2247,66 @@ static int pmbus_identify_common(struct i2c_client *client,
>   		}
>   	}
>   
> +	if (data->flags & PMBUS_USE_COEFFICIENTS_CMD) {

I think there should be a separate function to handle that,
to be called only once, not once per page.

> +		if (!i2c_check_functionality(client->adapter,
> +					     I2C_FUNC_SMBUS_BLOCK_PROC_CALL))
> +			return -ENODEV;
> +
> +		if (data->info->format[PSC_VOLTAGE_IN] == direct) {
> +			ret = pmbus_init_coefficients(client, data, page,
> +						      PSC_VOLTAGE_IN,
> +						      voltage_attributes,
> +						      ARRAY_SIZE(voltage_attributes));
> +			if (ret)
> +				return ret;
> +		}

It might be useful to have a little structure with {class, attribute list pointer,
attribute list size} and walk through that in a loop instead of repeating essentially
the same code multiple times.

> +
> +		if (data->info->format[PSC_VOLTAGE_OUT] == direct) {
> +			ret = pmbus_init_coefficients(client, data, page,
> +						      PSC_VOLTAGE_OUT,
> +						      voltage_attributes,
> +						      ARRAY_SIZE(voltage_attributes));
> +			if (ret)
> +				return ret;
> +		}
> +
> +		if (data->info->format[PSC_CURRENT_IN] == direct) {
> +			ret = pmbus_init_coefficients(client, data, page,
> +						      PSC_CURRENT_IN,
> +						      current_attributes,
> +						      ARRAY_SIZE(current_attributes));
> +			if (ret)
> +				return ret;
> +		}
> +
> +		if (data->info->format[PSC_CURRENT_OUT] == direct) {
> +			ret = pmbus_init_coefficients(client, data, page,
> +						      PSC_CURRENT_OUT,
> +						      current_attributes,
> +						      ARRAY_SIZE(current_attributes));
> +			if (ret)
> +				return ret;
> +		}
> +
> +		if (data->info->format[PSC_POWER] == direct) {
> +			ret = pmbus_init_coefficients(client, data, page,
> +						      PSC_POWER,
> +						      power_attributes,
> +						      ARRAY_SIZE(power_attributes));
> +			if (ret)
> +				return ret;
> +		}
> +
> +		if (data->info->format[PSC_TEMPERATURE] == direct) {
> +			ret = pmbus_init_coefficients(client, data, page,
> +						      PSC_TEMPERATURE,
> +						      temp_attributes,
> +						      ARRAY_SIZE(temp_attributes));
> +			if (ret)
> +				return ret;
> +		}
> +	}
> +
>   	pmbus_clear_fault_page(client, page);
>   	return 0;
>   }
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

