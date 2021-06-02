Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B488D3988B4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 13:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbhFBL70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 07:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbhFBL7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 07:59:23 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2741C061574;
        Wed,  2 Jun 2021 04:57:27 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id i14-20020a9d624e0000b029033683c71999so2170327otk.5;
        Wed, 02 Jun 2021 04:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fb6RB9fi/rF6AK+iCW4g0jD1m+9qa/FYg2uv3qR8UrM=;
        b=qmPMNYMs9dRcamDOLeCFnuMl5E/b5gkvIKBLdy0uZO6pOIhRXpuFQkqkOJCyHFI5Zr
         iZ+GlfM0TSEO2HZR5kku4tjdHsfKuUbQ8vzid9YfN0naevMStikuUB9eiw+ClU5ZBe+j
         EQWfbdKDhnkh5gzonqlKheX6Eti0v0HocUGf6Nv7oZd1svlGEaB0jZPVVaks2fL4+/tb
         F1zaHPjVhb+C4K4PIFc2h+vzzmLlwAih4Ysay3oFYoG9gL8t12EqDA+6JzYKdAEszNea
         V1VMssza6C2+0Lph9oxc31LAnGXDi4Qf5PG+/HrM9ARXXmysOWDJlwAeN1a+DNlREmpQ
         ikRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=fb6RB9fi/rF6AK+iCW4g0jD1m+9qa/FYg2uv3qR8UrM=;
        b=VZds9Y1/GrBQgtdEUJ8bFXGhlPTFguNrMb/M7jUBIFzi0ZNc5mQw3+rFDasxYuN8X0
         eTn3/XOSEwB7lNOBUW4IsDTFAcZHZ3smzqjJrzrip0W8+9Vtgll5DKNDVoWi6wPYMUC6
         kligS24Uhvom5HYrZf1TEKIDH0GzEFbSJyDncbbfi7BECIZTXdO3IeFhp5T1vjOCctBF
         f4Zse/x5qK+DigxvOXpgYn/93qPHfhUd35pO4+nnv1sYif/sKQ7ixMCELEH6tiQ4s0d9
         WRVgpY2vvvoskUJXDCGFOoBnpdGSvzLX3pdbfP4JBZ9Y2UpKiO5AUZxSOLeZT+Wx9vr4
         0aHQ==
X-Gm-Message-State: AOAM532GHkzJQNzokQhdZMRB2WF9AawmCOScvbYha4s9rCaXWwAqXN22
        7cPdpBnuaeft55d/z2Ta2gyFgOFwx+Y=
X-Google-Smtp-Source: ABdhPJwc+wyUJg732ih2UqDXokblzLPIlaux3j0FQ3LzlB4lSfgawdW6C/eHkO+ni2zHmGgLCV5DRg==
X-Received: by 2002:a9d:460b:: with SMTP id y11mr16438977ote.330.1622635047058;
        Wed, 02 Jun 2021 04:57:27 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j26sm370740otp.15.2021.06.02.04.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 04:57:26 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 2 Jun 2021 04:57:25 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Joe Perches <joe@perches.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Navin Sankar Velliangiri <navin@linumiz.com>,
        linux-hwmon@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] hwmon: sht4x: Fix sht4x_read_values return value
Message-ID: <20210602115725.GA2901603@roeck-us.net>
References: <60eedce497137eb34448c0c77e01ec9d9c972ad7.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60eedce497137eb34448c0c77e01ec9d9c972ad7.camel@perches.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 29, 2021 at 02:13:52AM -0700, Joe Perches wrote:
> Kernel doc for sht4x_read_values() shows 0 on success, 1 on failure but
> the return value on success is actually always positive as it is set to
> SHT4X_RESPONSE_LENGTH by a successful call to i2c_master_recv().
> 
> Miscellanea:
> 
> o Update the kernel doc for sht4x_read_values to 0 for success or -ERRNO
> o Remove incorrectly used kernel doc /** header for other _read functions
> o Typo fix succesfull->successful
> o Reverse a test to unindent a block and use goto unlock
> o Declare cmd[SHT4X_CMD_LEN] rather than cmd[]
> 
> At least for gcc 10.2, object size is reduced a tiny bit.
> 
> $ size drivers/hwmon/sht4x.o*
>    text	   data	    bss	    dec	    hex	filename
>    1752	    404	    256	   2412	    96c	drivers/hwmon/sht4x.o.new
>    1825	    404	    256	   2485	    9b5	drivers/hwmon/sht4x.o.old
> 
> Signed-off-by: Joe Perches <joe@perches.com>

Thanks, applied.

Guenter

> ---
> 
> compiled, untested, no hardware
> 
>  drivers/hwmon/sht4x.c | 95 ++++++++++++++++++++++++---------------------------
>  1 file changed, 45 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/hwmon/sht4x.c b/drivers/hwmon/sht4x.c
> index 1dc51ee2a72ba..09c2a0b064444 100644
> --- a/drivers/hwmon/sht4x.c
> +++ b/drivers/hwmon/sht4x.c
> @@ -67,7 +67,7 @@ struct sht4x_data {
>  /**
>   * sht4x_read_values() - read and parse the raw data from the SHT4X
>   * @sht4x_data: the struct sht4x_data to use for the lock
> - * Return: 0 if succesfull, 1 if not
> + * Return: 0 if successful, -ERRNO if not
>   */
>  static int sht4x_read_values(struct sht4x_data *data)
>  {
> @@ -75,51 +75,53 @@ static int sht4x_read_values(struct sht4x_data *data)
>  	u16 t_ticks, rh_ticks;
>  	unsigned long next_update;
>  	struct i2c_client *client = data->client;
> -	u8 crc, raw_data[SHT4X_RESPONSE_LENGTH],
> -	cmd[] = {SHT4X_CMD_MEASURE_HPM};
> +	u8 crc;
> +	u8 cmd[SHT4X_CMD_LEN] = {SHT4X_CMD_MEASURE_HPM};
> +	u8 raw_data[SHT4X_RESPONSE_LENGTH];
>  
>  	mutex_lock(&data->lock);
>  	next_update = data->last_updated +
>  		      msecs_to_jiffies(data->update_interval);
> -	if (!data->valid || time_after(jiffies, next_update)) {
> -		ret = i2c_master_send(client, cmd, SHT4X_CMD_LEN);
> -		if (ret < 0)
> -			goto unlock;
> -
> -		usleep_range(SHT4X_MEAS_DELAY,
> -			     SHT4X_MEAS_DELAY + SHT4X_DELAY_EXTRA);
> -
> -		ret = i2c_master_recv(client, raw_data, SHT4X_RESPONSE_LENGTH);
> -		if (ret != SHT4X_RESPONSE_LENGTH) {
> -			if (ret >= 0)
> -				ret = -ENODATA;
> -
> -			goto unlock;
> -		}
> -
> -		t_ticks = raw_data[0] << 8 | raw_data[1];
> -		rh_ticks = raw_data[3] << 8 | raw_data[4];
> -
> -		crc = crc8(sht4x_crc8_table, &raw_data[0], SHT4X_WORD_LEN, CRC8_INIT_VALUE);
> -		if (crc != raw_data[2]) {
> -			dev_err(&client->dev, "data integrity check failed\n");
> -			ret = -EIO;
> -			goto unlock;
> -		}
> -
> -		crc = crc8(sht4x_crc8_table, &raw_data[3], SHT4X_WORD_LEN, CRC8_INIT_VALUE);
> -		if (crc != raw_data[5]) {
> -			dev_err(&client->dev, "data integrity check failed\n");
> -			ret = -EIO;
> -			goto unlock;
> -		}
> -
> -		data->temperature = ((21875 * (int32_t)t_ticks) >> 13) - 45000;
> -		data->humidity = ((15625 * (int32_t)rh_ticks) >> 13) - 6000;
> -		data->last_updated = jiffies;
> -		data->valid = true;
> +
> +	if (data->valid && time_before_eq(jiffies, next_update))
> +		goto unlock;
> +
> +	ret = i2c_master_send(client, cmd, SHT4X_CMD_LEN);
> +	if (ret < 0)
> +		goto unlock;
> +
> +	usleep_range(SHT4X_MEAS_DELAY, SHT4X_MEAS_DELAY + SHT4X_DELAY_EXTRA);
> +
> +	ret = i2c_master_recv(client, raw_data, SHT4X_RESPONSE_LENGTH);
> +	if (ret != SHT4X_RESPONSE_LENGTH) {
> +		if (ret >= 0)
> +			ret = -ENODATA;
> +		goto unlock;
> +	}
> +
> +	t_ticks = raw_data[0] << 8 | raw_data[1];
> +	rh_ticks = raw_data[3] << 8 | raw_data[4];
> +
> +	crc = crc8(sht4x_crc8_table, &raw_data[0], SHT4X_WORD_LEN, CRC8_INIT_VALUE);
> +	if (crc != raw_data[2]) {
> +		dev_err(&client->dev, "data integrity check failed\n");
> +		ret = -EIO;
> +		goto unlock;
>  	}
>  
> +	crc = crc8(sht4x_crc8_table, &raw_data[3], SHT4X_WORD_LEN, CRC8_INIT_VALUE);
> +	if (crc != raw_data[5]) {
> +		dev_err(&client->dev, "data integrity check failed\n");
> +		ret = -EIO;
> +		goto unlock;
> +	}
> +
> +	data->temperature = ((21875 * (int32_t)t_ticks) >> 13) - 45000;
> +	data->humidity = ((15625 * (int32_t)rh_ticks) >> 13) - 6000;
> +	data->last_updated = jiffies;
> +	data->valid = true;
> +	ret = 0;
> +
>  unlock:
>  	mutex_unlock(&data->lock);
>  	return ret;
> @@ -132,19 +134,14 @@ static ssize_t sht4x_interval_write(struct sht4x_data *data, long val)
>  	return 0;
>  }
>  
> -/**
> - * sht4x_interval_read() - read the minimum poll interval
> - *			   in milliseconds
> - */
> +/* sht4x_interval_read() - read the minimum poll interval in milliseconds */
>  static size_t sht4x_interval_read(struct sht4x_data *data, long *val)
>  {
>  	*val = data->update_interval;
>  	return 0;
>  }
>  
> -/**
> - * sht4x_temperature1_read() - read the temperature in millidegrees
> - */
> +/* sht4x_temperature1_read() - read the temperature in millidegrees */
>  static int sht4x_temperature1_read(struct sht4x_data *data, long *val)
>  {
>  	int ret;
> @@ -158,9 +155,7 @@ static int sht4x_temperature1_read(struct sht4x_data *data, long *val)
>  	return 0;
>  }
>  
> -/**
> - * sht4x_humidity1_read() - read a relative humidity in millipercent
> - */
> +/* sht4x_humidity1_read() - read a relative humidity in millipercent */
>  static int sht4x_humidity1_read(struct sht4x_data *data, long *val)
>  {
>  	int ret;
