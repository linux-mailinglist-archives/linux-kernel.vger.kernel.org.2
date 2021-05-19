Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D051389609
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 21:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbhESTBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 15:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbhESTBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 15:01:51 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C4FC06175F;
        Wed, 19 May 2021 12:00:30 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id x8so13819956qkl.2;
        Wed, 19 May 2021 12:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:to:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pT7mPIIy3cB9XbSIBxYb+t+YqOX8OuaOhcFL3f0WgRM=;
        b=VtldLSg390D0ThDlK5x6ccSg/q1M8aShKk0lZC1j9/WBtpr5TkMc0E6c3FT9aks5XU
         TRZeLsukDvW59jMSwqHSaQDDzuQhIFF4U1s3y69f3nOlCdVUjCLnO1/OkwDwqgazvuxZ
         MI/MU+LAjmCFCzbJbvVpO6MuRyB6HC3FBMg9yN0ptqgDJBx2g+vYkmfsqTVnX5c2rGz6
         9IedYZGg/rIUBtiUZ6gj9eBjFb8DVzi+qsGblLwfeIwy1Wc+uzGKk+jSZVaEsvnFsK7K
         7ZswNUdMtIXZ3hRdJSD9x8+KSk7vpK4tLssn9Vht9NGW1ocbkqRsLOMN51WbjcogvS/F
         pRJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:to:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pT7mPIIy3cB9XbSIBxYb+t+YqOX8OuaOhcFL3f0WgRM=;
        b=hXAScTg+e/Xs/A67jgXJROf0cinR9ZLxb8N69QgENQD3oYW5P4kNSb/30k16f4PqdK
         c+IK1xqVxO8GpyYU2rEXYAvseCWHZq1HiNDJkntnhBWTQQnD7fJ8xb5BvdAH/F6SAT6e
         iw9W1WH4js5/ufYpZc70re+2TZ2Jm5fn+mPYjyP3dxGEtAzu8MwUcIed/H7mal41uIFB
         B6VEwyJz5LgHOf9Ph3lCm3RvfFRfJSR14EoHrteBFMAcU6FuRyNeFxWqCx7x3Rr9GoBG
         pZSYrviVYzS8JHBPOdyT9nwvtKZ3b19M5nU7569D1Fqpk/cNf1yhzr3VanozZCLBi1DG
         4DpA==
X-Gm-Message-State: AOAM533+EGwme0LloQj/N8JJmFDqBhWdQxjCCYXlPotTsDyb95RXalgX
        saQyy3gHfDFn3RAo/g7CHHuKqmBpLBg=
X-Google-Smtp-Source: ABdhPJzzh7OzBET+GMGsraqm3cPLf5wacoljf8hCIJWtcOMcF4u+fSEA0kMLRCvnlU4cgAZdYDcOew==
X-Received: by 2002:a05:620a:30d:: with SMTP id s13mr982606qkm.58.1621450829417;
        Wed, 19 May 2021 12:00:29 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g140sm429748qke.32.2021.05.19.12.00.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 May 2021 12:00:27 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     =?UTF-8?B?VsOhY2xhdiBLdWJlcm7DoXQ=?= <kubernat@cesnet.cz>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210512013052.903297-1-kubernat@cesnet.cz>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v5 1/5] hwmon: (max31790) Rework to use regmap
Message-ID: <f34293db-7159-9022-1a8c-829310fe84e7@roeck-us.net>
Date:   Wed, 19 May 2021 12:00:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210512013052.903297-1-kubernat@cesnet.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/21 6:30 PM, Václav Kubernát wrote:
> Converting the driver to use regmap makes it more generic. It also makes
> it a lot easier to debug through debugfs.
> 
> Signed-off-by: Václav Kubernát <kubernat@cesnet.cz>
> ---
>   drivers/hwmon/Kconfig    |   1 +
>   drivers/hwmon/max31790.c | 254 ++++++++++++++++++++-------------------
>   2 files changed, 133 insertions(+), 122 deletions(-)
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 54f04e61fb83..c2ec57672c4e 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1092,6 +1092,7 @@ config SENSORS_MAX6697
>   config SENSORS_MAX31790
>   	tristate "Maxim MAX31790 sensor chip"
>   	depends on I2C
> +	select REGMAP_I2C
>   	help
>   	  If you say yes here you get support for 6-Channel PWM-Output
>   	  Fan RPM Controller.
> diff --git a/drivers/hwmon/max31790.c b/drivers/hwmon/max31790.c
> index 2c6b333a28e9..e3765ce4444a 100644
> --- a/drivers/hwmon/max31790.c
> +++ b/drivers/hwmon/max31790.c
> @@ -12,6 +12,7 @@
>   #include <linux/init.h>
>   #include <linux/jiffies.h>
>   #include <linux/module.h>
> +#include <linux/regmap.h>
>   #include <linux/slab.h>
>   
>   /* MAX31790 registers */
> @@ -46,92 +47,53 @@
>   
>   #define NR_CHANNEL			6
>   
> +#define MAX31790_REG_USER_BYTE_67	0x67
> +
> +#define BULK_TO_U16(msb, lsb)		(((msb) << 8) + (lsb))
> +#define U16_MSB(num)			(((num) & 0xFF00) >> 8)
> +#define U16_LSB(num)			((num) & 0x00FF)
> +
> +static const struct regmap_range max31790_ro_range = {
> +	.range_min = MAX31790_REG_TACH_COUNT(0),
> +	.range_max = MAX31790_REG_PWMOUT(0) - 1,

This should be:
	.range_max = MAX31790_REG_PWM_DUTY_CYCLE(5) + 1,

> +};
> +
> +static const struct regmap_access_table max31790_wr_table = {
> +	.no_ranges = &max31790_ro_range,
> +	.n_no_ranges = 1,
> +};
> +
> +static const struct regmap_range max31790_volatile_ranges[] = {
> +	regmap_reg_range(MAX31790_REG_TACH_COUNT(0), MAX31790_REG_TACH_COUNT(12)),
> +	regmap_reg_range(MAX31790_REG_FAN_FAULT_STATUS2, MAX31790_REG_FAN_FAULT_STATUS1),

This should be:

         regmap_reg_range(MAX31790_REG_PWM_DUTY_CYCLE(0), MAX31790_REG_PWM_DUTY_CYCLE(5) + 1),
         regmap_reg_range(MAX31790_REG_TACH_COUNT(0), MAX31790_REG_TACH_COUNT(11) + 1),
         regmap_reg_range(MAX31790_REG_FAN_FAULT_STATUS2, MAX31790_REG_FAN_FAULT_STATUS1),

> +};
> +
> +static const struct regmap_access_table max31790_volatile_table = {
> +	.no_ranges = max31790_volatile_ranges,
> +	.n_no_ranges = 2,
> +	.n_yes_ranges = 0

         .yes_ranges = max31790_volatile_ranges,
         .n_yes_ranges = ARRAY_SIZE(max31790_volatile_ranges),

Initializing with 0 is not necessary for static variables.

> +};
> +

As I have already said and now confirmed, specifying volatile ranges as no_ranges
is wrong. This only "works" because the cache method is specified implicitly as
REGCACHE_NONE, ie it has no effect.

> +static const struct regmap_config max31790_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.reg_stride = 1,
> +	.max_register = MAX31790_REG_USER_BYTE_67,

Add:
	.num_reg_defaults_raw = MAX31790_REG_USER_BYTE_67 + 1,
	.cache_type = REGCACHE_FLAT,

for caching to really work.
	
> +	.wr_table = &max31790_wr_table,
> +	.volatile_table = &max31790_volatile_table
> +};
> +
>   /*
>    * Client data (each client gets its own)
>    */
>   struct max31790_data {
> -	struct i2c_client *client;
> +	struct regmap *regmap;
> +
>   	struct mutex update_lock;
> -	bool valid; /* zero until following fields are valid */
> -	unsigned long last_updated; /* in jiffies */
> -
> -	/* register values */
>   	u8 fan_config[NR_CHANNEL];
>   	u8 fan_dynamics[NR_CHANNEL];
> -	u16 fault_status;
> -	u16 tach[NR_CHANNEL * 2];
> -	u16 pwm[NR_CHANNEL];
> -	u16 target_count[NR_CHANNEL];
>   };
>   
> -static struct max31790_data *max31790_update_device(struct device *dev)
> -{
> -	struct max31790_data *data = dev_get_drvdata(dev);
> -	struct i2c_client *client = data->client;
> -	struct max31790_data *ret = data;
> -	int i;
> -	int rv;
> -
> -	mutex_lock(&data->update_lock);
> -
> -	if (time_after(jiffies, data->last_updated + HZ) || !data->valid) {
> -		rv = i2c_smbus_read_byte_data(client,
> -				MAX31790_REG_FAN_FAULT_STATUS1);
> -		if (rv < 0)
> -			goto abort;
> -		data->fault_status = rv & 0x3F;
> -
> -		rv = i2c_smbus_read_byte_data(client,
> -				MAX31790_REG_FAN_FAULT_STATUS2);
> -		if (rv < 0)
> -			goto abort;
> -		data->fault_status |= (rv & 0x3F) << 6;
> -
> -		for (i = 0; i < NR_CHANNEL; i++) {
> -			rv = i2c_smbus_read_word_swapped(client,
> -					MAX31790_REG_TACH_COUNT(i));
> -			if (rv < 0)
> -				goto abort;
> -			data->tach[i] = rv;
> -
> -			if (data->fan_config[i]
> -			    & MAX31790_FAN_CFG_TACH_INPUT) {
> -				rv = i2c_smbus_read_word_swapped(client,
> -					MAX31790_REG_TACH_COUNT(NR_CHANNEL
> -								+ i));
> -				if (rv < 0)
> -					goto abort;
> -				data->tach[NR_CHANNEL + i] = rv;
> -			} else {
> -				rv = i2c_smbus_read_word_swapped(client,
> -						MAX31790_REG_PWMOUT(i));
> -				if (rv < 0)
> -					goto abort;
> -				data->pwm[i] = rv;
> -
> -				rv = i2c_smbus_read_word_swapped(client,
> -						MAX31790_REG_TARGET_COUNT(i));
> -				if (rv < 0)
> -					goto abort;
> -				data->target_count[i] = rv;
> -			}
> -		}
> -
> -		data->last_updated = jiffies;
> -		data->valid = true;
> -	}
> -	goto done;
> -
> -abort:
> -	data->valid = false;
> -	ret = ERR_PTR(rv);
> -
> -done:
> -	mutex_unlock(&data->update_lock);
> -
> -	return ret;
> -}
> -
>   static const u8 tach_period[8] = { 1, 2, 4, 8, 16, 32, 32, 32 };
>   
>   static u8 get_tach_period(u8 fan_dynamics)
> @@ -159,28 +121,75 @@ static u8 bits_for_tach_period(int rpm)
>   	return bits;
>   }
>   
> +static int read_reg_byte(struct regmap *regmap, u8 reg)
> +{
> +	int rv;
> +	int val;
> +
> +	rv = regmap_read(regmap, reg, &val);
> +	if (rv < 0)
> +		return rv;
> +
> +	return val;
> +}
> +
> +static int read_reg_word(struct regmap *regmap, u8 reg)
> +{
> +	int rv;
> +	u8 val_bulk[2];
> +
> +	rv = regmap_bulk_read(regmap, reg, val_bulk, 2);
> +	if (rv < 0)
> +		return rv;
> +
> +	return BULK_TO_U16(val_bulk[0], val_bulk[1]);
> +}
> +
> +static int write_reg_word(struct regmap *regmap, u8 reg, u16 val)
> +{
> +	u8 bulk_val[2];
> +
> +	bulk_val[0] = U16_MSB(val);
> +	bulk_val[1] = U16_LSB(val);
> +
> +	return regmap_bulk_write(regmap, reg, bulk_val, 2);
> +}
> +
>   static int max31790_read_fan(struct device *dev, u32 attr, int channel,
>   			     long *val)
>   {
> -	struct max31790_data *data = max31790_update_device(dev);
> -	int sr, rpm;
> -
> -	if (IS_ERR(data))
> -		return PTR_ERR(data);
> +	struct max31790_data *data = dev_get_drvdata(dev);
> +	struct regmap *regmap = data->regmap;
> +	int tach, fault;
>   
>   	switch (attr) {
>   	case hwmon_fan_input:
> -		sr = get_tach_period(data->fan_dynamics[channel]);
> -		rpm = RPM_FROM_REG(data->tach[channel], sr);
> -		*val = rpm;
> +		tach = read_reg_word(regmap, MAX31790_REG_TACH_COUNT(channel));
> +		if (tach < 0)
> +			return tach;
> +
> +		*val = RPM_FROM_REG(tach, get_tach_period(data->fan_dynamics[channel]));
>   		return 0;
>   	case hwmon_fan_target:
> -		sr = get_tach_period(data->fan_dynamics[channel]);
> -		rpm = RPM_FROM_REG(data->target_count[channel], sr);
> -		*val = rpm;
> +		tach = read_reg_word(regmap, MAX31790_REG_TARGET_COUNT(channel));
> +		if (tach < 0)
> +			return tach;
> +
> +		*val = RPM_FROM_REG(tach, get_tach_period(data->fan_dynamics[channel]));
>   		return 0;
>   	case hwmon_fan_fault:
> -		*val = !!(data->fault_status & (1 << channel));
> +		if (channel > 6)
> +			fault = read_reg_byte(regmap, MAX31790_REG_FAN_FAULT_STATUS2);
> +		else
> +			fault = read_reg_byte(regmap, MAX31790_REG_FAN_FAULT_STATUS1);
> +
> +		if (fault < 0)
> +			return fault;
> +
> +		if (channel > 6)
> +			*val = !!(fault & (1 << (channel - 6)));
> +		else
> +			*val = !!(fault & (1 << channel));
>   		return 0;
>   	default:
>   		return -EOPNOTSUPP;
> @@ -191,7 +200,7 @@ static int max31790_write_fan(struct device *dev, u32 attr, int channel,
>   			      long val)
>   {
>   	struct max31790_data *data = dev_get_drvdata(dev);
> -	struct i2c_client *client = data->client;
> +	struct regmap *regmap = data->regmap;
>   	int target_count;
>   	int err = 0;
>   	u8 bits;
> @@ -207,9 +216,10 @@ static int max31790_write_fan(struct device *dev, u32 attr, int channel,
>   			((data->fan_dynamics[channel] &
>   			  ~MAX31790_FAN_DYN_SR_MASK) |
>   			 (bits << MAX31790_FAN_DYN_SR_SHIFT));
> -		err = i2c_smbus_write_byte_data(client,
> -					MAX31790_REG_FAN_DYNAMICS(channel),
> -					data->fan_dynamics[channel]);
> +
> +		err = regmap_write(regmap,
> +				   MAX31790_REG_FAN_DYNAMICS(channel),
> +				   data->fan_dynamics[channel]);
>   		if (err < 0)
>   			break;
>   
> @@ -217,11 +227,11 @@ static int max31790_write_fan(struct device *dev, u32 attr, int channel,
>   		target_count = RPM_TO_REG(val, sr);
>   		target_count = clamp_val(target_count, 0x1, 0x7FF);
>   
> -		data->target_count[channel] = target_count << 5;
> +		target_count = target_count << 5;
>   
> -		err = i2c_smbus_write_word_swapped(client,
> -					MAX31790_REG_TARGET_COUNT(channel),
> -					data->target_count[channel]);
> +		err = write_reg_word(regmap,
> +				     MAX31790_REG_TARGET_COUNT(channel),
> +				     target_count);
>   		break;
>   	default:
>   		err = -EOPNOTSUPP;
> @@ -258,22 +268,22 @@ static umode_t max31790_fan_is_visible(const void *_data, u32 attr, int channel)
>   static int max31790_read_pwm(struct device *dev, u32 attr, int channel,
>   			     long *val)
>   {
> -	struct max31790_data *data = max31790_update_device(dev);
> -	u8 fan_config;
> -
> -	if (IS_ERR(data))
> -		return PTR_ERR(data);
> -
> -	fan_config = data->fan_config[channel];
> +	struct max31790_data *data = dev_get_drvdata(dev);
> +	struct regmap *regmap = data->regmap;
> +	int read;
>   
>   	switch (attr) {
>   	case hwmon_pwm_input:
> -		*val = data->pwm[channel] >> 8;
> +		read = read_reg_word(regmap, MAX31790_REG_PWMOUT(channel));
> +		if (read < 0)
> +			return read;
> +
> +		*val = read >> 8;
>   		return 0;
>   	case hwmon_pwm_enable:
> -		if (fan_config & MAX31790_FAN_CFG_RPM_MODE)
> +		if (data->fan_config[channel] & MAX31790_FAN_CFG_RPM_MODE)
>   			*val = 2;
> -		else if (fan_config & MAX31790_FAN_CFG_TACH_INPUT_EN)
> +		else if (data->fan_config[channel] & MAX31790_FAN_CFG_TACH_INPUT_EN)
>   			*val = 1;
>   		else
>   			*val = 0;
> @@ -287,7 +297,7 @@ static int max31790_write_pwm(struct device *dev, u32 attr, int channel,
>   			      long val)
>   {
>   	struct max31790_data *data = dev_get_drvdata(dev);
> -	struct i2c_client *client = data->client;
> +	struct regmap *regmap = data->regmap;
>   	u8 fan_config;
>   	int err = 0;
>   
> @@ -299,10 +309,7 @@ static int max31790_write_pwm(struct device *dev, u32 attr, int channel,
>   			err = -EINVAL;
>   			break;
>   		}
> -		data->pwm[channel] = val << 8;
> -		err = i2c_smbus_write_word_swapped(client,
> -						   MAX31790_REG_PWMOUT(channel),
> -						   data->pwm[channel]);
> +		err = write_reg_word(regmap, MAX31790_REG_PWMOUT(channel), val << 8);
>   		break;
>   	case hwmon_pwm_enable:
>   		fan_config = data->fan_config[channel];
> @@ -321,9 +328,9 @@ static int max31790_write_pwm(struct device *dev, u32 attr, int channel,
>   			break;
>   		}
>   		data->fan_config[channel] = fan_config;
> -		err = i2c_smbus_write_byte_data(client,
> -					MAX31790_REG_FAN_CONFIG(channel),
> -					fan_config);
> +		err = regmap_write(regmap,
> +				   MAX31790_REG_FAN_CONFIG(channel),
> +				   fan_config);
>   		break;
>   	default:
>   		err = -EOPNOTSUPP;
> @@ -426,20 +433,18 @@ static const struct hwmon_chip_info max31790_chip_info = {
>   	.info = max31790_info,
>   };
>   
> -static int max31790_init_client(struct i2c_client *client,
> +static int max31790_init_client(struct regmap *regmap,
>   				struct max31790_data *data)
>   {
>   	int i, rv;
>   
>   	for (i = 0; i < NR_CHANNEL; i++) {
> -		rv = i2c_smbus_read_byte_data(client,
> -				MAX31790_REG_FAN_CONFIG(i));
> +		rv = read_reg_byte(regmap, MAX31790_REG_FAN_CONFIG(i % NR_CHANNEL));
>   		if (rv < 0)
>   			return rv;
>   		data->fan_config[i] = rv;
>   
> -		rv = i2c_smbus_read_byte_data(client,
> -				MAX31790_REG_FAN_DYNAMICS(i));
> +		rv = read_reg_byte(regmap, MAX31790_REG_FAN_DYNAMICS(i));
>   		if (rv < 0)
>   			return rv;
>   		data->fan_dynamics[i] = rv;
> @@ -464,13 +469,18 @@ static int max31790_probe(struct i2c_client *client)
>   	if (!data)
>   		return -ENOMEM;
>   
> -	data->client = client;
>   	mutex_init(&data->update_lock);
>   
> +	data->regmap = devm_regmap_init_i2c(client, &max31790_regmap_config);
> +	if (IS_ERR(data->regmap)) {
> +		dev_err(dev, "failed to allocate register map\n");
> +		return PTR_ERR(data->regmap);
> +	}
> +
>   	/*
>   	 * Initialize the max31790 chip
>   	 */
> -	err = max31790_init_client(client, data);
> +	err = max31790_init_client(data->regmap, data);
>   	if (err)
>   		return err;
>   
> 

