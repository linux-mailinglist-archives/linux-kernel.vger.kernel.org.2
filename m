Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08AC0355B96
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 20:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237046AbhDFSmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 14:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233773AbhDFSmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 14:42:19 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA200C06174A;
        Tue,  6 Apr 2021 11:42:10 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id x2so16160895oiv.2;
        Tue, 06 Apr 2021 11:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ipEu67V16uKxEpk1PJhr+zzhFe5FXArL/+A3yPf9Stc=;
        b=sSev9DX1Gj+6vtfbc+we4KXFatxNQTS1un0os+AxYviCIj3ed5+sSwKMmmyHRrV8Zy
         4s5EvyrMIIZrFFKHu8Koy5ucFsEJ6nxIHi9eKipF2uAKTzgq1E41chNYbziPGuAlwfPo
         JcdgHPI8OnL4yPkEH3coLu+T3duRHDYOvXAHOWmLlfrvSvTiTbGHFE4b8F5ZnrZaje/y
         97/Eln96UErxbq2dTK8aIDG8muhTzI7qUWHEMHwRQmqPK0Lktjg9j5KUcIGWKDLLl/Qr
         niFslrv9USriTPc4UnnhZ9fpYP/4O0EGxR8EKgchFiqJZWM0C0OMrXmvCTsWr9iZbzsV
         XuQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ipEu67V16uKxEpk1PJhr+zzhFe5FXArL/+A3yPf9Stc=;
        b=cHXKh4E7T/geZsW5ZBS7LivfTuC5ul3nJTK+IjyXLtBB6zohcKtJF36g24/WAxh426
         Npivg8P3rWKtOtBQ9tPChMxhd3FSwkj3E0Hsw/ChNm2mPJbXpaUOMM7V4JV6n8P2cTKQ
         7oWwFqvhOE9Rb5uy+JyTHD5+0GB/cxh+ctfdeaTk5E7uPfrRrosbovTMsPCp9Z9bGipE
         mxZNj5fKrk3++GBXRvsUWXjs9/IxVpUPmEFuQmmmWM7nho8WrksUem8Nw7U0MfSCnx+u
         gxEPCutBOW+KsreV9t51cS/k65XwRxWl7bV4N0eXXFc2dcv9OdL2tES5WdCXzPE4UuTr
         JfRQ==
X-Gm-Message-State: AOAM5300Rz5Y1TeZNrH+kqWdsUXSC6eRPEaP8wRyqA1O5Dap3ODIhROE
        uOb9vQZODHLNd9h/ZMViq+eHBNLF8TI=
X-Google-Smtp-Source: ABdhPJwRZh16YqBL08Sr2Ris6ltZ/w66zxJiOY+D92UUNtaHx43nZUwhDGCvuAkJDcuwYHRQBlACOQ==
X-Received: by 2002:a05:6808:68a:: with SMTP id k10mr4315436oig.120.1617734529986;
        Tue, 06 Apr 2021 11:42:09 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p3sm4870554otk.9.2021.04.06.11.42.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Apr 2021 11:42:09 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v2] hwmon: (sbtsi) Don't read sensor more than once if it
 doesn't respond
To:     Konstantin Aladyshev <aladyshev22@gmail.com>
Cc:     kunyi@google.com, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <ed438518-66ad-6e08-2a1b-597ac3f2ae8d@roeck-us.net>
 <20210406181624.713-1-aladyshev22@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <0ba1d271-78cd-c30a-e662-97ab8ba6451a@roeck-us.net>
Date:   Tue, 6 Apr 2021 11:42:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210406181624.713-1-aladyshev22@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/6/21 11:16 AM, Konstantin Aladyshev wrote:
> SBTSI sensors don't work when the CPU is off.
> In this case every 'i2c_smbus_read_byte_data' function would fail
> by a timeout.
> Currently temp1_max/temp1_min file reads can cause two such timeouts
> for every read.
> Restructure code so there will be no more than one timeout for every
> read operation.
> 
> Signed-off-by: Konstantin Aladyshev <aladyshev22@gmail.com>
> ---
> Changes in v2:
>   - Fix typo in a commit message
>   - Don't swap temp_int/temp_dec checks at the end of the 'sbtsi_read' function
> 

This doesn't explain the reason for the extra read operation for
limits. Preventing a second read in error cases is not an argument
for adding an extra read for non-error cases.

Guenter

>  drivers/hwmon/sbtsi_temp.c | 55 +++++++++++++++++++-------------------
>  1 file changed, 27 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/hwmon/sbtsi_temp.c b/drivers/hwmon/sbtsi_temp.c
> index e35357c48b8e..4ae48635bb31 100644
> --- a/drivers/hwmon/sbtsi_temp.c
> +++ b/drivers/hwmon/sbtsi_temp.c
> @@ -74,48 +74,47 @@ static int sbtsi_read(struct device *dev, enum hwmon_sensor_types type,
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
>  	if (temp_int < 0)
>  		return temp_int;
> 

