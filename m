Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDF1A35483C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 23:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241275AbhDEVlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 17:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbhDEVl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 17:41:28 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0031C061756;
        Mon,  5 Apr 2021 14:41:21 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id d12so12967979oiw.12;
        Mon, 05 Apr 2021 14:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AEl7r6LIhZzMFZ70Dj9LSgbTDdvmj7Qwm2JaMIYfONM=;
        b=Yj068MHONwgQOfhaOgOM5+vIxOsjJzYhS9ghG/uzEjFOw1DTpVVG35GcNC7l4QZ/bt
         KCrvfOi7rlsSuwXjA0blCiesKQ+lyyepJXIJfzQQ+CvJN757uWr+ErprDwzU66CCPvj4
         KQCgne63me5h9VEC7Bsa7mVZ+T9XA7MRRGZf2OIRiMUFswvaPiUZnHLVyEkDzw+Vu3v+
         9jXumg1lMCev4oqdMSWl6tsO+sw+BROkrkx8hOl2v7d94CwxuqA/Bnw5vJVxhuEsreSo
         LKTWYfv0sf59ZD+4+hPA/cxgYrOsrA4ik0zSaVfV5Q1Iudo5uTAtYwM86s61wsvORVMF
         I1/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=AEl7r6LIhZzMFZ70Dj9LSgbTDdvmj7Qwm2JaMIYfONM=;
        b=RtON8wkx+H5e0NS38heK608sMuwh+0uldDbQbl0L3ZEfle7/RcUja87rmLWSTyhSn8
         ooXlKA4sAY97ymIKvJwvkpEhkCLT7ua5SI9MsI0xXZXjBxHDZu3pDRJgLVVh8vTyAZwn
         c/cdrK5MsWddqxPrhWrJewmvSLP/2w7PFL4yCdZ0XkHIYTiTva6NL3IKScqCnWlPjyRN
         5riQhjAOclRAKUWFiqTeWpALvx0/wPSNqXOI3b8zlxgWdUE2ayRn3Kr56byXqEv/4zFU
         OdqJfz16Yltil0lK+K5PnG4roIFhtcJ+sJwl/Oo36TKA4zxukNE8DQpc8Da/zrEaMGaf
         UMQQ==
X-Gm-Message-State: AOAM5326yPoXtf0PL1awwb1K+VZk2z341V9nwnzXeWPuKSH0thoMWMCP
        cyFOS2Dpb8KzL3kCE9hTTEtOWFDiPRY=
X-Google-Smtp-Source: ABdhPJygYxtuq48q94g4p2FlWUfTbwMcW3bb3+o7Ai5La+LdEX1it6l9piN3GnV6WVy41kVFoQjZEw==
X-Received: by 2002:aca:ed94:: with SMTP id l142mr813049oih.177.1617658880627;
        Mon, 05 Apr 2021 14:41:20 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r22sm4139428otg.4.2021.04.05.14.41.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Apr 2021 14:41:19 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH] hwmon: (sbtsi) Don't read sensor more than once if it
 doesn't respond
To:     Konstantin Aladyshev <aladyshev22@gmail.com>
Cc:     kunyi@google.com, Konstantin Aladyshev <aladyshev@nicevt.ru>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210401214543.4073-1-aladyshev22@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <ed438518-66ad-6e08-2a1b-597ac3f2ae8d@roeck-us.net>
Date:   Mon, 5 Apr 2021 14:41:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210401214543.4073-1-aladyshev22@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/1/21 2:45 PM, Konstantin Aladyshev wrote:
> From: Konstantin Aladyshev <aladyshev@nicevt.ru>
> 
> SBTSI sensors don't work when the CPU is off.
> In this case every 'i2c_smbus_read_byte_data' function would fail
> by a timeout.
> Currently temp1_max/temp1_min file reads can cause two such timeouts
> for every read.
> Restructure code so there will be no more than one timeout for every
> read opeartion.
> 

operation

> Signed-off-by: Konstantin Aladyshev <aladyshev@nicevt.ru>
> ---
>  drivers/hwmon/sbtsi_temp.c | 59 +++++++++++++++++++-------------------
>  1 file changed, 29 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/hwmon/sbtsi_temp.c b/drivers/hwmon/sbtsi_temp.c
> index e35357c48b8e..e09a8cf6de45 100644
> --- a/drivers/hwmon/sbtsi_temp.c
> +++ b/drivers/hwmon/sbtsi_temp.c
> @@ -74,53 +74,52 @@ static int sbtsi_read(struct device *dev, enum hwmon_sensor_types type,
>  		      u32 attr, int channel, long *val)
>  {
>  	struct sbtsi_data *data = dev_get_drvdata(dev);
> +	u8 temp_int_reg, temp_dec_reg;
>  	s32 temp_int, temp_dec;
>  	int err;
>  
>  	switch (attr) {
>  	case hwmon_temp_input:
> -		/*
> -		 * ReadOrder bit specifies the reading order of integer and
> -		 * decimal part of CPU temp for atomic reads. If bit == 0,
> -		 * reading integer part triggers latching of the decimal part,
> -		 * so integer part should be read first. If bit == 1, read
> -		 * order should be reversed.
> -		 */
> -		err = i2c_smbus_read_byte_data(data->client, SBTSI_REG_CONFIG);
> -		if (err < 0)
> -			return err;
> -
> -		mutex_lock(&data->lock);
> -		if (err & BIT(SBTSI_CONFIG_READ_ORDER_SHIFT)) {
> -			temp_dec = i2c_smbus_read_byte_data(data->client, SBTSI_REG_TEMP_DEC);
> -			temp_int = i2c_smbus_read_byte_data(data->client, SBTSI_REG_TEMP_INT);
> -		} else {
> -			temp_int = i2c_smbus_read_byte_data(data->client, SBTSI_REG_TEMP_INT);
> -			temp_dec = i2c_smbus_read_byte_data(data->client, SBTSI_REG_TEMP_DEC);
> -		}
> -		mutex_unlock(&data->lock);
> +		temp_int_reg = SBTSI_REG_TEMP_INT;
> +		temp_dec_reg = SBTSI_REG_TEMP_DEC;
>  		break;
>  	case hwmon_temp_max:
> -		mutex_lock(&data->lock);
> -		temp_int = i2c_smbus_read_byte_data(data->client, SBTSI_REG_TEMP_HIGH_INT);
> -		temp_dec = i2c_smbus_read_byte_data(data->client, SBTSI_REG_TEMP_HIGH_DEC);
> -		mutex_unlock(&data->lock);
> +		temp_int_reg = SBTSI_REG_TEMP_HIGH_INT;
> +		temp_dec_reg = SBTSI_REG_TEMP_HIGH_DEC;
>  		break;
>  	case hwmon_temp_min:
> -		mutex_lock(&data->lock);
> -		temp_int = i2c_smbus_read_byte_data(data->client, SBTSI_REG_TEMP_LOW_INT);
> -		temp_dec = i2c_smbus_read_byte_data(data->client, SBTSI_REG_TEMP_LOW_DEC);
> -		mutex_unlock(&data->lock);
> +		temp_int_reg = SBTSI_REG_TEMP_LOW_INT;
> +		temp_dec_reg = SBTSI_REG_TEMP_LOW_DEC;
>  		break;
>  	default:
>  		return -EINVAL;
>  	}
>  
> +	/*
> +	 * ReadOrder bit specifies the reading order of integer and
> +	 * decimal part of CPU temp for atomic reads. If bit == 0,
> +	 * reading integer part triggers latching of the decimal part,
> +	 * so integer part should be read first. If bit == 1, read
> +	 * order should be reversed.
> +	 */
> +	err = i2c_smbus_read_byte_data(data->client, SBTSI_REG_CONFIG);
> +	if (err < 0)
> +		return err;
> +

It seems the "fix" is to always execute above code, which presumably
fails if the CPU is off. The downside of this approach is that it forces
an unnecessary extra and unnecessary i2c operation when reading
the limits.

The real fix would be to check for error after each i2c operation,
not only after both operations are complete.

> +	mutex_lock(&data->lock);
> +	if (err & BIT(SBTSI_CONFIG_READ_ORDER_SHIFT)) {
> +		temp_dec = i2c_smbus_read_byte_data(data->client, temp_dec_reg);
> +		temp_int = i2c_smbus_read_byte_data(data->client, temp_int_reg);
> +	} else {
> +		temp_int = i2c_smbus_read_byte_data(data->client, temp_int_reg);
> +		temp_dec = i2c_smbus_read_byte_data(data->client, temp_dec_reg);
> +	}
> +	mutex_unlock(&data->lock);
>  
> -	if (temp_int < 0)
> -		return temp_int;
>  	if (temp_dec < 0)
>  		return temp_dec;
> +	if (temp_int < 0)
> +		return temp_int;

I don't see a value in swapping the checks.

Guenter

>  
>  	*val = sbtsi_reg_to_mc(temp_int, temp_dec);
>  
> 

