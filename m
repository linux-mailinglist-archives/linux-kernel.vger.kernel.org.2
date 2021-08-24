Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3203F6AD7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 23:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235291AbhHXVIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 17:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232860AbhHXVIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 17:08:44 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBFA9C061757;
        Tue, 24 Aug 2021 14:07:59 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id c19-20020a9d6153000000b0051829acbfc7so49711436otk.9;
        Tue, 24 Aug 2021 14:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=F3GB465O2lUEqt18QGkFlYPZzYcYqoP4JEAWpA3yfkA=;
        b=IuHHmuaE50rVxkT7EKWoYEpESXg7lYJ4Hl4hVfntMdnpsSQ47V/vMGf478jw7q6cU2
         DTDlgRvMa7pQFzXKPT8uD4pt6ZmvokLBBhDFQbnY39YVx/UoE3RLVmSV82j8CI3Dv01P
         yDcCro232pE0CCQI0e9ZpYTiNRzR/oj/zwk9fhRN9o0ZcY4QqVmpwvx2/RobLKVuBkee
         YERlDYel252jXWfc5pfV+Ysw9FC+166mbFk/UwgUaZAWiN+GH+5U+x3/W0XyaIPyy/cQ
         gCKRFPZxhHQe7AfchWL/jgTzFqsuif/CNwOwFlbWb0Fw3WSIyR0yo14atzI57NfzLh7Y
         w/vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=F3GB465O2lUEqt18QGkFlYPZzYcYqoP4JEAWpA3yfkA=;
        b=FG+3eUQ1e8QZUnm/KQucquCjZ2o9VxygJlL2g7QRGrT1aex0p9EdGz7SrI6wQ9Toft
         IbXYbhLNiLSw8tMykiFzNEccoyRhpBunjvx5uNiIhxYg4yTdA0fZ/W0K7t+FQUS6l20s
         eaxH0OWJq8JiZ0j9EEqNbc00ltqJ1l40PNHXQ/Xitaq5567hSwRgcm4xlQoNF5xUH2MB
         Pe8Qmbpd8AcyWEazs/lamKuWj+1GMdCur+MP2qd1/sYiXSzmaWSGT02rJqikIgdpvtZU
         AYZq9HaQAy3FdJquYTTIrUR9fphhooOLwalghnZfvZzj4Slyxbl5UeCn4HFHJ74bTITF
         4vlA==
X-Gm-Message-State: AOAM531Fel2ZmriaOuROwP4jILioYNrMWF+XLmRUF4aA+0zyYLoigmBt
        POJ0R6aHCO9TpKYOfMzFvBr6aX1SuGI=
X-Google-Smtp-Source: ABdhPJzdHrc7If63xuV8yOyYzJvA3Cnq4pt+qhbyHEZgyeVg4pazhzFn+UcrDzQDc6+nFSMsmULuOQ==
X-Received: by 2002:a05:6808:51:: with SMTP id v17mr4226651oic.94.1629839278922;
        Tue, 24 Aug 2021 14:07:58 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i27sm4943143ots.12.2021.08.24.14.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 14:07:58 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 24 Aug 2021 14:07:57 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] hwmon: (adt7470) Convert to
 devm_hwmon_device_register_with_info API
Message-ID: <20210824210757.GA3418382@roeck-us.net>
References: <20210623002058.3133-1-chris.packham@alliedtelesis.co.nz>
 <20210623002058.3133-2-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210623002058.3133-2-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chris,

On Wed, Jun 23, 2021 at 12:20:57PM +1200, Chris Packham wrote:
> Use the devm_hwmon_device_register_with_info and convert to using regmap
> with better error handling.
> 
> While at it clean up some checkpatch warnings.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

I have now tried several times to review this patch, and I always
get stuck due to its complexity. Would it be possible to split it into
multiple individual patches to simplify review ? There should be at
least two patches, one to introduce regmap and the second to convert
the driver to use devm_hwmon_device_register_with_info.

Thanks,
Guenter

> ---
> 
> Technically this is a v2 of an earlier patch[1] but because it's been a
> while and there are fairly major changes since the earlier version it's
> probably best considered as a new patch.
> 
> I haven't gone all the way to remove the local caching in favor of fully
> utilizing regmap because there are some complications with the way the
> remote temperature sensors work so some caching is inevitable.
> --
> [1] - https://lore.kernel.org/linux-hwmon/20201019223423.31488-3-chris.packham@alliedtelesis.co.nz/
> 
>  drivers/hwmon/adt7470.c | 1082 ++++++++++++++++++---------------------
>  1 file changed, 511 insertions(+), 571 deletions(-)
> 
> diff --git a/drivers/hwmon/adt7470.c b/drivers/hwmon/adt7470.c
> index 2e8feacccf84..24d210def09b 100644
> --- a/drivers/hwmon/adt7470.c
> +++ b/drivers/hwmon/adt7470.c
> @@ -6,8 +6,6 @@
>   * Author: Darrick J. Wong <darrick.wong@oracle.com>
>   */
>  
> -#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> -
>  #include <linux/module.h>
>  #include <linux/jiffies.h>
>  #include <linux/i2c.h>
> @@ -18,6 +16,7 @@
>  #include <linux/delay.h>
>  #include <linux/log2.h>
>  #include <linux/kthread.h>
> +#include <linux/regmap.h>
>  #include <linux/slab.h>
>  #include <linux/util_macros.h>
>  
> @@ -35,7 +34,10 @@ static const unsigned short normal_i2c[] = { 0x2C, 0x2E, 0x2F, I2C_CLIENT_END };
>  #define ADT7470_REG_PWM_MAX_BASE_ADDR		0x38
>  #define ADT7470_REG_PWM_MAX_MAX_ADDR		0x3B
>  #define ADT7470_REG_CFG				0x40
> +#define		ADT7470_STRT_MASK		0x01
> +#define		ADT7470_TEST_MASK		0x02
>  #define		ADT7470_FSPD_MASK		0x04
> +#define		ADT7470_T05_STB_MASK		0x80
>  #define ADT7470_REG_ALARM1			0x41
>  #define		ADT7470_R1T_ALARM		0x01
>  #define		ADT7470_R2T_ALARM		0x02
> @@ -137,7 +139,7 @@ static const unsigned short normal_i2c[] = { 0x2C, 0x2E, 0x2F, I2C_CLIENT_END };
>  #define ADT7470_FREQ_SHIFT	4
>  
>  struct adt7470_data {
> -	struct i2c_client	*client;
> +	struct regmap		*regmap;
>  	struct mutex		lock;
>  	char			sensors_valid;
>  	char			limits_valid;
> @@ -154,7 +156,7 @@ struct adt7470_data {
>  	u16			fan_min[ADT7470_FAN_COUNT];
>  	u16			fan_max[ADT7470_FAN_COUNT];
>  	u16			alarm;
> -	u16			alarms_mask;
> +	unsigned int		alarms_mask;
>  	u8			force_pwm_max;
>  	u8			pwm[ADT7470_PWM_COUNT];
>  	u8			pwm_max[ADT7470_PWM_COUNT];
> @@ -171,51 +173,76 @@ struct adt7470_data {
>   * 16-bit registers on the ADT7470 are low-byte first.  The data sheet says
>   * that the low byte must be read before the high byte.
>   */
> -static inline int adt7470_read_word_data(struct i2c_client *client, u8 reg)
> +static inline int adt7470_read_word_data(struct adt7470_data *data, unsigned int reg,
> +					 unsigned int *val)
>  {
> -	u16 foo;
> -	foo = i2c_smbus_read_byte_data(client, reg);
> -	foo |= ((u16)i2c_smbus_read_byte_data(client, reg + 1) << 8);
> -	return foo;
> +	u8 regval[2];
> +	int err;
> +
> +	err = regmap_bulk_read(data->regmap, reg, &regval, 2);
> +	if (err < 0)
> +		return err;
> +
> +	*val = regval[0] | (regval[1] << 8);
> +
> +	return 0;
>  }
>  
> -static inline int adt7470_write_word_data(struct i2c_client *client, u8 reg,
> -					  u16 value)
> +static inline int adt7470_write_word_data(struct adt7470_data *data, unsigned int reg,
> +					  unsigned int val)
>  {
> -	return i2c_smbus_write_byte_data(client, reg, value & 0xFF)
> -	       || i2c_smbus_write_byte_data(client, reg + 1, value >> 8);
> +	u8 regval[2];
> +
> +	regval[0] = val & 0xFF;
> +	regval[1] = val >> 8;
> +
> +	return regmap_bulk_write(data->regmap, reg, &regval, 2);
>  }
>  
>  /* Probe for temperature sensors.  Assumes lock is held */
> -static int adt7470_read_temperatures(struct i2c_client *client,
> -				     struct adt7470_data *data)
> +static int adt7470_read_temperatures(struct adt7470_data *data)
>  {
>  	unsigned long res;
> +	unsigned int pwm_cfg[2];
> +	int err;
>  	int i;
> -	u8 cfg, pwm[4], pwm_cfg[2];
> +	u8 pwm[ADT7470_FAN_COUNT];
>  
>  	/* save pwm[1-4] config register */
> -	pwm_cfg[0] = i2c_smbus_read_byte_data(client, ADT7470_REG_PWM_CFG(0));
> -	pwm_cfg[1] = i2c_smbus_read_byte_data(client, ADT7470_REG_PWM_CFG(2));
> +	err = regmap_read(data->regmap, ADT7470_REG_PWM_CFG(0), &pwm_cfg[0]);
> +	if (err < 0)
> +		return err;
> +	err = regmap_read(data->regmap, ADT7470_REG_PWM_CFG(2), &pwm_cfg[1]);
> +	if (err < 0)
> +		return err;
>  
>  	/* set manual pwm to whatever it is set to now */
> -	for (i = 0; i < ADT7470_FAN_COUNT; i++)
> -		pwm[i] = i2c_smbus_read_byte_data(client, ADT7470_REG_PWM(i));
> +	err = regmap_bulk_read(data->regmap, ADT7470_REG_PWM(0), &pwm[0],
> +			       ADT7470_PWM_COUNT);
> +	if (err < 0)
> +		return err;
>  
>  	/* put pwm in manual mode */
> -	i2c_smbus_write_byte_data(client, ADT7470_REG_PWM_CFG(0),
> -		pwm_cfg[0] & ~(ADT7470_PWM_AUTO_MASK));
> -	i2c_smbus_write_byte_data(client, ADT7470_REG_PWM_CFG(2),
> -		pwm_cfg[1] & ~(ADT7470_PWM_AUTO_MASK));
> +	err = regmap_update_bits(data->regmap, ADT7470_REG_PWM_CFG(0),
> +				 ADT7470_PWM_AUTO_MASK, 0);
> +	if (err < 0)
> +		return err;
> +	err = regmap_update_bits(data->regmap, ADT7470_REG_PWM_CFG(2),
> +				 ADT7470_PWM_AUTO_MASK, 0);
> +	if (err < 0)
> +		return err;
>  
>  	/* write pwm control to whatever it was */
> -	for (i = 0; i < ADT7470_FAN_COUNT; i++)
> -		i2c_smbus_write_byte_data(client, ADT7470_REG_PWM(i), pwm[i]);
> +	err = regmap_bulk_write(data->regmap, ADT7470_REG_PWM(0), &pwm[0],
> +				ADT7470_PWM_COUNT);
> +	if (err < 0)
> +		return err;
>  
>  	/* start reading temperature sensors */
> -	cfg = i2c_smbus_read_byte_data(client, ADT7470_REG_CFG);
> -	cfg |= 0x80;
> -	i2c_smbus_write_byte_data(client, ADT7470_REG_CFG, cfg);
> +	err = regmap_update_bits(data->regmap, ADT7470_REG_CFG,
> +				 ADT7470_T05_STB_MASK, ADT7470_T05_STB_MASK);
> +	if (err < 0)
> +		return err;
>  
>  	/* Delay is 200ms * number of temp sensors. */
>  	res = msleep_interruptible((data->num_temp_sensors >= 0 ?
> @@ -223,26 +250,31 @@ static int adt7470_read_temperatures(struct i2c_client *client,
>  				    TEMP_COLLECTION_TIME));
>  
>  	/* done reading temperature sensors */
> -	cfg = i2c_smbus_read_byte_data(client, ADT7470_REG_CFG);
> -	cfg &= ~0x80;
> -	i2c_smbus_write_byte_data(client, ADT7470_REG_CFG, cfg);
> +	err = regmap_update_bits(data->regmap, ADT7470_REG_CFG,
> +				 ADT7470_T05_STB_MASK, 0);
> +	if (err < 0)
> +		return err;
>  
>  	/* restore pwm[1-4] config registers */
> -	i2c_smbus_write_byte_data(client, ADT7470_REG_PWM_CFG(0), pwm_cfg[0]);
> -	i2c_smbus_write_byte_data(client, ADT7470_REG_PWM_CFG(2), pwm_cfg[1]);
> +	err = regmap_write(data->regmap, ADT7470_REG_PWM_CFG(0), pwm_cfg[0]);
> +	if (err < 0)
> +		return err;
> +	err = regmap_write(data->regmap, ADT7470_REG_PWM_CFG(2), pwm_cfg[1]);
> +	if (err < 0)
> +		return err;
>  
> -	if (res) {
> -		pr_err("ha ha, interrupted\n");
> +	if (res)
>  		return -EAGAIN;
> -	}
>  
>  	/* Only count fans if we have to */
>  	if (data->num_temp_sensors >= 0)
>  		return 0;
>  
> +	err = regmap_bulk_read(data->regmap, ADT7470_TEMP_REG(0), &data->temp[0],
> +			       ADT7470_TEMP_COUNT);
> +	if (err < 0)
> +		return err;
>  	for (i = 0; i < ADT7470_TEMP_COUNT; i++) {
> -		data->temp[i] = i2c_smbus_read_byte_data(client,
> -						ADT7470_TEMP_REG(i));
>  		if (data->temp[i])
>  			data->num_temp_sensors = i + 1;
>  	}
> @@ -254,12 +286,16 @@ static int adt7470_update_thread(void *p)
>  {
>  	struct i2c_client *client = p;
>  	struct adt7470_data *data = i2c_get_clientdata(client);
> +	int err = 0;
>  
>  	while (!kthread_should_stop()) {
>  		mutex_lock(&data->lock);
> -		adt7470_read_temperatures(client, data);
> +		err = adt7470_read_temperatures(data);
>  		mutex_unlock(&data->lock);
>  
> +		if (err < 0)
> +			dev_warn(&client->dev, "temperature read failed %d\n", err);
> +
>  		set_current_state(TASK_INTERRUPTIBLE);
>  		if (kthread_should_stop())
>  			break;
> @@ -272,89 +308,106 @@ static int adt7470_update_thread(void *p)
>  
>  static int adt7470_update_sensors(struct adt7470_data *data)
>  {
> -	struct i2c_client *client = data->client;
> -	u8 cfg;
> +	unsigned int val;
> +	int err;
>  	int i;
>  
>  	if (!data->temperatures_probed)
> -		adt7470_read_temperatures(client, data);
> +		err = adt7470_read_temperatures(data);
>  	else
> -		for (i = 0; i < ADT7470_TEMP_COUNT; i++)
> -			data->temp[i] = i2c_smbus_read_byte_data(client,
> -						ADT7470_TEMP_REG(i));
> +		err = regmap_bulk_read(data->regmap, ADT7470_TEMP_REG(0), &data->temp[0],
> +				       ADT7470_TEMP_COUNT);
> +	if (err < 0)
> +		return err;
>  
> -	for (i = 0; i < ADT7470_FAN_COUNT; i++)
> -		data->fan[i] = adt7470_read_word_data(client,
> -						ADT7470_REG_FAN(i));
> -
> -	for (i = 0; i < ADT7470_PWM_COUNT; i++) {
> -		int reg;
> -		int reg_mask;
> -
> -		data->pwm[i] = i2c_smbus_read_byte_data(client,
> -						ADT7470_REG_PWM(i));
> -
> -		if (i % 2)
> -			reg_mask = ADT7470_PWM2_AUTO_MASK;
> -		else
> -			reg_mask = ADT7470_PWM1_AUTO_MASK;
> -
> -		reg = ADT7470_REG_PWM_CFG(i);
> -		if (i2c_smbus_read_byte_data(client, reg) & reg_mask)
> -			data->pwm_automatic[i] = 1;
> -		else
> -			data->pwm_automatic[i] = 0;
> -
> -		reg = ADT7470_REG_PWM_AUTO_TEMP(i);
> -		cfg = i2c_smbus_read_byte_data(client, reg);
> -		if (!(i % 2))
> -			data->pwm_auto_temp[i] = cfg >> 4;
> -		else
> -			data->pwm_auto_temp[i] = cfg & 0xF;
> +	for (i = 0; i < ADT7470_FAN_COUNT; i++) {
> +		err = adt7470_read_word_data(data, ADT7470_REG_FAN(i), &val);
> +		if (err < 0)
> +			return err;
> +		data->fan[i] =	val;
>  	}
>  
> -	if (i2c_smbus_read_byte_data(client, ADT7470_REG_CFG) &
> -	    ADT7470_FSPD_MASK)
> -		data->force_pwm_max = 1;
> -	else
> -		data->force_pwm_max = 0;
> +	err = regmap_bulk_read(data->regmap, ADT7470_REG_PWM(0), &data->pwm[0], ADT7470_PWM_COUNT);
> +	if (err < 0)
> +		return err;
>  
> -	data->alarm = i2c_smbus_read_byte_data(client, ADT7470_REG_ALARM1);
> -	if (data->alarm & ADT7470_OOL_ALARM)
> -		data->alarm |= ALARM2(i2c_smbus_read_byte_data(client,
> -							ADT7470_REG_ALARM2));
> -	data->alarms_mask = adt7470_read_word_data(client,
> -						   ADT7470_REG_ALARM1_MASK);
> +	for (i = 0; i < ADT7470_PWM_COUNT; i++) {
> +		unsigned int mask;
>  
> -	return 0;
> +		if (i % 2)
> +			mask = ADT7470_PWM2_AUTO_MASK;
> +		else
> +			mask = ADT7470_PWM1_AUTO_MASK;
> +
> +		err = regmap_read(data->regmap, ADT7470_REG_PWM_CFG(i), &val);
> +		if (err < 0)
> +			return err;
> +		data->pwm_automatic[i] = !!(val & mask);
> +
> +		err = regmap_read(data->regmap, ADT7470_REG_PWM_AUTO_TEMP(i), &val);
> +		if (err < 0)
> +			return err;
> +		if (!(i % 2))
> +			data->pwm_auto_temp[i] = val >> 4;
> +		else
> +			data->pwm_auto_temp[i] = val & 0xF;
> +	}
> +
> +	err = regmap_read(data->regmap, ADT7470_REG_ALARM1, &val);
> +	if (err < 0)
> +		return err;
> +	data->alarm = val;
> +	if (data->alarm & ADT7470_OOL_ALARM) {
> +		err = regmap_read(data->regmap, ADT7470_REG_ALARM2, &val);
> +		if (err < 0)
> +			return err;
> +		data->alarm |= ALARM2(val);
> +	}
> +
> +	return adt7470_read_word_data(data, ADT7470_REG_ALARM1_MASK, &data->alarms_mask);
>  }
>  
>  static int adt7470_update_limits(struct adt7470_data *data)
>  {
> -	struct i2c_client *client = data->client;
> +	unsigned int val;
> +	int err;
>  	int i;
>  
>  	for (i = 0; i < ADT7470_TEMP_COUNT; i++) {
> -		data->temp_min[i] = i2c_smbus_read_byte_data(client,
> -						ADT7470_TEMP_MIN_REG(i));
> -		data->temp_max[i] = i2c_smbus_read_byte_data(client,
> -						ADT7470_TEMP_MAX_REG(i));
> +		err = regmap_read(data->regmap, ADT7470_TEMP_MIN_REG(i), &val);
> +		if (err < 0)
> +			return err;
> +		data->temp_min[i] = (s8)val;
> +		err = regmap_read(data->regmap, ADT7470_TEMP_MAX_REG(i), &val);
> +		if (err < 0)
> +			return err;
> +		data->temp_max[i] = (s8)val;
>  	}
>  
>  	for (i = 0; i < ADT7470_FAN_COUNT; i++) {
> -		data->fan_min[i] = adt7470_read_word_data(client,
> -						ADT7470_REG_FAN_MIN(i));
> -		data->fan_max[i] = adt7470_read_word_data(client,
> -						ADT7470_REG_FAN_MAX(i));
> +		err = adt7470_read_word_data(data, ADT7470_REG_FAN_MIN(i), &val);
> +		if (err < 0)
> +			return err;
> +		data->fan_min[i] = val;
> +		err = adt7470_read_word_data(data, ADT7470_REG_FAN_MAX(i), &val);
> +		if (err < 0)
> +			return err;
> +		data->fan_max[i] = val;
>  	}
>  
>  	for (i = 0; i < ADT7470_PWM_COUNT; i++) {
> -		data->pwm_max[i] = i2c_smbus_read_byte_data(client,
> -						ADT7470_REG_PWM_MAX(i));
> -		data->pwm_min[i] = i2c_smbus_read_byte_data(client,
> -						ADT7470_REG_PWM_MIN(i));
> -		data->pwm_tmin[i] = i2c_smbus_read_byte_data(client,
> -						ADT7470_REG_PWM_TMIN(i));
> +		err = regmap_read(data->regmap, ADT7470_REG_PWM_MAX(i), &val);
> +		if (err < 0)
> +			return err;
> +		data->pwm_max[i] = val;
> +		err = regmap_read(data->regmap, ADT7470_REG_PWM_MIN(i), &val);
> +		if (err < 0)
> +			return err;
> +		data->pwm_min[i] = val;
> +		err = regmap_read(data->regmap, ADT7470_REG_PWM_TMIN(i), &val);
> +		if (err < 0)
> +			return err;
> +		data->pwm_tmin[i] = (s8)val;
>  	}
>  
>  	return 0;
> @@ -443,10 +496,7 @@ static ssize_t num_temp_sensors_show(struct device *dev,
>  				     struct device_attribute *devattr,
>  				     char *buf)
>  {
> -	struct adt7470_data *data = adt7470_update_device(dev);
> -
> -	if (IS_ERR(data))
> -		return PTR_ERR(data);
> +	struct adt7470_data *data = dev_get_drvdata(dev);
>  
>  	return sprintf(buf, "%d\n", data->num_temp_sensors);
>  }
> @@ -472,98 +522,66 @@ static ssize_t num_temp_sensors_store(struct device *dev,
>  	return count;
>  }
>  
> -static ssize_t temp_min_show(struct device *dev,
> -			     struct device_attribute *devattr, char *buf)
> +static int adt7470_temp_read(struct device *dev, u32 attr, int channel, long *val)
>  {
> -	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>  	struct adt7470_data *data = adt7470_update_device(dev);
>  
>  	if (IS_ERR(data))
>  		return PTR_ERR(data);
>  
> -	return sprintf(buf, "%d\n", 1000 * data->temp_min[attr->index]);
> +	switch (attr) {
> +	case hwmon_temp_input:
> +		*val = 1000 * data->temp[channel];
> +		break;
> +	case hwmon_temp_min:
> +		*val = 1000 * data->temp_min[channel];
> +		break;
> +	case hwmon_temp_max:
> +		*val = 1000 * data->temp_max[channel];
> +		break;
> +	case hwmon_temp_alarm:
> +		*val = !!(data->alarm & channel);
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return 0;
>  }
>  
> -static ssize_t temp_min_store(struct device *dev,
> -			      struct device_attribute *devattr,
> -			      const char *buf, size_t count)
> +static int adt7470_temp_write(struct device *dev, u32 attr, int channel, long val)
>  {
> -	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>  	struct adt7470_data *data = dev_get_drvdata(dev);
> -	struct i2c_client *client = data->client;
> -	long temp;
> +	int err;
>  
> -	if (kstrtol(buf, 10, &temp))
> -		return -EINVAL;
> +	val = clamp_val(val, -128000, 127000);
> +	val = DIV_ROUND_CLOSEST(val, 1000);
>  
> -	temp = clamp_val(temp, -128000, 127000);
> -	temp = DIV_ROUND_CLOSEST(temp, 1000);
> +	switch (attr) {
> +	case hwmon_temp_min:
> +		mutex_lock(&data->lock);
> +		data->temp_min[channel] = val;
> +		err = regmap_write(data->regmap, ADT7470_TEMP_MIN_REG(channel), val);
> +		mutex_unlock(&data->lock);
> +		break;
> +	case hwmon_temp_max:
> +		mutex_lock(&data->lock);
> +		data->temp_max[channel] = val;
> +		err = regmap_write(data->regmap, ADT7470_TEMP_MAX_REG(channel), val);
> +		mutex_unlock(&data->lock);
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
>  
> -	mutex_lock(&data->lock);
> -	data->temp_min[attr->index] = temp;
> -	i2c_smbus_write_byte_data(client, ADT7470_TEMP_MIN_REG(attr->index),
> -				  temp);
> -	mutex_unlock(&data->lock);
> -
> -	return count;
> -}
> -
> -static ssize_t temp_max_show(struct device *dev,
> -			     struct device_attribute *devattr, char *buf)
> -{
> -	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> -	struct adt7470_data *data = adt7470_update_device(dev);
> -
> -	if (IS_ERR(data))
> -		return PTR_ERR(data);
> -
> -	return sprintf(buf, "%d\n", 1000 * data->temp_max[attr->index]);
> -}
> -
> -static ssize_t temp_max_store(struct device *dev,
> -			      struct device_attribute *devattr,
> -			      const char *buf, size_t count)
> -{
> -	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> -	struct adt7470_data *data = dev_get_drvdata(dev);
> -	struct i2c_client *client = data->client;
> -	long temp;
> -
> -	if (kstrtol(buf, 10, &temp))
> -		return -EINVAL;
> -
> -	temp = clamp_val(temp, -128000, 127000);
> -	temp = DIV_ROUND_CLOSEST(temp, 1000);
> -
> -	mutex_lock(&data->lock);
> -	data->temp_max[attr->index] = temp;
> -	i2c_smbus_write_byte_data(client, ADT7470_TEMP_MAX_REG(attr->index),
> -				  temp);
> -	mutex_unlock(&data->lock);
> -
> -	return count;
> -}
> -
> -static ssize_t temp_show(struct device *dev, struct device_attribute *devattr,
> -			 char *buf)
> -{
> -	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> -	struct adt7470_data *data = adt7470_update_device(dev);
> -
> -	if (IS_ERR(data))
> -		return PTR_ERR(data);
> -
> -	return sprintf(buf, "%d\n", 1000 * data->temp[attr->index]);
> +	return err;
>  }
>  
>  static ssize_t alarm_mask_show(struct device *dev,
>  			   struct device_attribute *devattr,
>  			   char *buf)
>  {
> -	struct adt7470_data *data = adt7470_update_device(dev);
> -
> -	if (IS_ERR(data))
> -		return PTR_ERR(data);
> +	struct adt7470_data *data = dev_get_drvdata(dev);
>  
>  	return sprintf(buf, "%x\n", data->alarms_mask);
>  }
> @@ -574,6 +592,7 @@ static ssize_t alarm_mask_store(struct device *dev,
>  {
>  	struct adt7470_data *data = dev_get_drvdata(dev);
>  	long mask;
> +	int err;
>  
>  	if (kstrtoul(buf, 0, &mask))
>  		return -EINVAL;
> @@ -583,113 +602,80 @@ static ssize_t alarm_mask_store(struct device *dev,
>  
>  	mutex_lock(&data->lock);
>  	data->alarms_mask = mask;
> -	adt7470_write_word_data(data->client, ADT7470_REG_ALARM1_MASK, mask);
> +	err = adt7470_write_word_data(data, ADT7470_REG_ALARM1_MASK, mask);
>  	mutex_unlock(&data->lock);
>  
> -	return count;
> +	return err < 0 ? err : count;
>  }
>  
> -static ssize_t fan_max_show(struct device *dev,
> -			    struct device_attribute *devattr, char *buf)
> +static int adt7470_fan_read(struct device *dev, u32 attr, int channel, long *val)
>  {
> -	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>  	struct adt7470_data *data = adt7470_update_device(dev);
>  
>  	if (IS_ERR(data))
>  		return PTR_ERR(data);
>  
> -	if (FAN_DATA_VALID(data->fan_max[attr->index]))
> -		return sprintf(buf, "%d\n",
> -			       FAN_PERIOD_TO_RPM(data->fan_max[attr->index]));
> -	else
> -		return sprintf(buf, "0\n");
> +	switch (attr) {
> +	case hwmon_fan_input:
> +		if (FAN_DATA_VALID(data->fan[channel]))
> +			*val = FAN_PERIOD_TO_RPM(data->fan[channel]);
> +		else
> +			*val = 0;
> +		break;
> +	case hwmon_fan_min:
> +		if (FAN_DATA_VALID(data->fan_min[channel]))
> +			*val = FAN_PERIOD_TO_RPM(data->fan_min[channel]);
> +		else
> +			*val = 0;
> +		break;
> +	case hwmon_fan_max:
> +		if (FAN_DATA_VALID(data->fan_max[channel]))
> +			*val = FAN_PERIOD_TO_RPM(data->fan_max[channel]);
> +		else
> +			*val = 0;
> +		break;
> +	case hwmon_fan_alarm:
> +		*val = !!(data->alarm & (1 << (12 + channel)));
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return 0;
>  }
>  
> -static ssize_t fan_max_store(struct device *dev,
> -			     struct device_attribute *devattr,
> -			     const char *buf, size_t count)
> +static int adt7470_fan_write(struct device *dev, u32 attr, int channel, long val)
>  {
> -	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>  	struct adt7470_data *data = dev_get_drvdata(dev);
> -	struct i2c_client *client = data->client;
> -	long temp;
> +	int err;
>  
> -	if (kstrtol(buf, 10, &temp) || !temp)
> -		return -EINVAL;
> +	val = FAN_RPM_TO_PERIOD(val);
> +	val = clamp_val(val, 1, 65534);
>  
> -	temp = FAN_RPM_TO_PERIOD(temp);
> -	temp = clamp_val(temp, 1, 65534);
> +	switch (attr) {
> +	case hwmon_fan_min:
> +		mutex_lock(&data->lock);
> +		data->fan_min[channel] = val;
> +		err = adt7470_write_word_data(data, ADT7470_REG_FAN_MIN(channel), val);
> +		mutex_unlock(&data->lock);
> +		break;
> +	case hwmon_fan_max:
> +		mutex_lock(&data->lock);
> +		data->fan_max[channel] = val;
> +		err = adt7470_write_word_data(data, ADT7470_REG_FAN_MAX(channel), val);
> +		mutex_unlock(&data->lock);
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
>  
> -	mutex_lock(&data->lock);
> -	data->fan_max[attr->index] = temp;
> -	adt7470_write_word_data(client, ADT7470_REG_FAN_MAX(attr->index), temp);
> -	mutex_unlock(&data->lock);
> -
> -	return count;
> -}
> -
> -static ssize_t fan_min_show(struct device *dev,
> -			    struct device_attribute *devattr, char *buf)
> -{
> -	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> -	struct adt7470_data *data = adt7470_update_device(dev);
> -
> -	if (IS_ERR(data))
> -		return PTR_ERR(data);
> -
> -	if (FAN_DATA_VALID(data->fan_min[attr->index]))
> -		return sprintf(buf, "%d\n",
> -			       FAN_PERIOD_TO_RPM(data->fan_min[attr->index]));
> -	else
> -		return sprintf(buf, "0\n");
> -}
> -
> -static ssize_t fan_min_store(struct device *dev,
> -			     struct device_attribute *devattr,
> -			     const char *buf, size_t count)
> -{
> -	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> -	struct adt7470_data *data = dev_get_drvdata(dev);
> -	struct i2c_client *client = data->client;
> -	long temp;
> -
> -	if (kstrtol(buf, 10, &temp) || !temp)
> -		return -EINVAL;
> -
> -	temp = FAN_RPM_TO_PERIOD(temp);
> -	temp = clamp_val(temp, 1, 65534);
> -
> -	mutex_lock(&data->lock);
> -	data->fan_min[attr->index] = temp;
> -	adt7470_write_word_data(client, ADT7470_REG_FAN_MIN(attr->index), temp);
> -	mutex_unlock(&data->lock);
> -
> -	return count;
> -}
> -
> -static ssize_t fan_show(struct device *dev, struct device_attribute *devattr,
> -			char *buf)
> -{
> -	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> -	struct adt7470_data *data = adt7470_update_device(dev);
> -
> -	if (IS_ERR(data))
> -		return PTR_ERR(data);
> -
> -	if (FAN_DATA_VALID(data->fan[attr->index]))
> -		return sprintf(buf, "%d\n",
> -			       FAN_PERIOD_TO_RPM(data->fan[attr->index]));
> -	else
> -		return sprintf(buf, "0\n");
> +	return err;
>  }
>  
>  static ssize_t force_pwm_max_show(struct device *dev,
>  				  struct device_attribute *devattr, char *buf)
>  {
> -	struct adt7470_data *data = adt7470_update_device(dev);
> -
> -	if (IS_ERR(data))
> -		return PTR_ERR(data);
> +	struct adt7470_data *data = dev_get_drvdata(dev);
>  
>  	return sprintf(buf, "%d\n", data->force_pwm_max);
>  }
> @@ -699,57 +685,20 @@ static ssize_t force_pwm_max_store(struct device *dev,
>  				   const char *buf, size_t count)
>  {
>  	struct adt7470_data *data = dev_get_drvdata(dev);
> -	struct i2c_client *client = data->client;
>  	long temp;
> -	u8 reg;
> +	int err;
>  
>  	if (kstrtol(buf, 10, &temp))
>  		return -EINVAL;
>  
>  	mutex_lock(&data->lock);
>  	data->force_pwm_max = temp;
> -	reg = i2c_smbus_read_byte_data(client, ADT7470_REG_CFG);
> -	if (temp)
> -		reg |= ADT7470_FSPD_MASK;
> -	else
> -		reg &= ~ADT7470_FSPD_MASK;
> -	i2c_smbus_write_byte_data(client, ADT7470_REG_CFG, reg);
> +	err = regmap_update_bits(data->regmap, ADT7470_REG_CFG,
> +				 ADT7470_FSPD_MASK,
> +				 temp ? ADT7470_FSPD_MASK : 0);
>  	mutex_unlock(&data->lock);
>  
> -	return count;
> -}
> -
> -static ssize_t pwm_show(struct device *dev, struct device_attribute *devattr,
> -			char *buf)
> -{
> -	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> -	struct adt7470_data *data = adt7470_update_device(dev);
> -
> -	if (IS_ERR(data))
> -		return PTR_ERR(data);
> -
> -	return sprintf(buf, "%d\n", data->pwm[attr->index]);
> -}
> -
> -static ssize_t pwm_store(struct device *dev, struct device_attribute *devattr,
> -			 const char *buf, size_t count)
> -{
> -	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> -	struct adt7470_data *data = dev_get_drvdata(dev);
> -	struct i2c_client *client = data->client;
> -	long temp;
> -
> -	if (kstrtol(buf, 10, &temp))
> -		return -EINVAL;
> -
> -	temp = clamp_val(temp, 0, 255);
> -
> -	mutex_lock(&data->lock);
> -	data->pwm[attr->index] = temp;
> -	i2c_smbus_write_byte_data(client, ADT7470_REG_PWM(attr->index), temp);
> -	mutex_unlock(&data->lock);
> -
> -	return count;
> +	return err < 0 ? err : count;
>  }
>  
>  /* These are the valid PWM frequencies to the nearest Hz */
> @@ -757,17 +706,20 @@ static const int adt7470_freq_map[] = {
>  	11, 15, 22, 29, 35, 44, 59, 88, 1400, 22500
>  };
>  
> -static ssize_t pwm1_freq_show(struct device *dev,
> -			      struct device_attribute *devattr, char *buf)
> +static int pwm1_freq_get(struct device *dev)
>  {
> -	struct adt7470_data *data = adt7470_update_device(dev);
> -	unsigned char cfg_reg_1;
> -	unsigned char cfg_reg_2;
> +	struct adt7470_data *data = dev_get_drvdata(dev);
> +	unsigned int cfg_reg_1, cfg_reg_2;
>  	int index;
> +	int err;
>  
>  	mutex_lock(&data->lock);
> -	cfg_reg_1 = i2c_smbus_read_byte_data(data->client, ADT7470_REG_CFG);
> -	cfg_reg_2 = i2c_smbus_read_byte_data(data->client, ADT7470_REG_CFG_2);
> +	err = regmap_read(data->regmap, ADT7470_REG_CFG, &cfg_reg_1);
> +	if (err < 0)
> +		goto out;
> +	err = regmap_read(data->regmap, ADT7470_REG_CFG_2, &cfg_reg_2);
> +	if (err < 0)
> +		goto out;
>  	mutex_unlock(&data->lock);
>  
>  	index = (cfg_reg_2 & ADT7470_FREQ_MASK) >> ADT7470_FREQ_SHIFT;
> @@ -776,22 +728,43 @@ static ssize_t pwm1_freq_show(struct device *dev,
>  	if (index >= ARRAY_SIZE(adt7470_freq_map))
>  		index = ARRAY_SIZE(adt7470_freq_map) - 1;
>  
> -	return scnprintf(buf, PAGE_SIZE, "%d\n", adt7470_freq_map[index]);
> +	return adt7470_freq_map[index];
> +
> +out:
> +	mutex_unlock(&data->lock);
> +	return err;
>  }
>  
> -static ssize_t pwm1_freq_store(struct device *dev,
> -			       struct device_attribute *devattr,
> -			       const char *buf, size_t count)
> +static int adt7470_pwm_read(struct device *dev, u32 attr, int channel, long *val)
> +{
> +	struct adt7470_data *data = adt7470_update_device(dev);
> +
> +	if (IS_ERR(data))
> +		return PTR_ERR(data);
> +
> +	switch (attr) {
> +	case hwmon_pwm_input:
> +		*val = data->pwm[channel];
> +		break;
> +	case hwmon_pwm_enable:
> +		*val = 1 + data->pwm_automatic[channel];
> +		break;
> +	case hwmon_pwm_freq:
> +		*val = pwm1_freq_get(dev);
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return 0;
> +}
> +
> +static int pwm1_freq_set(struct device *dev, long freq)
>  {
>  	struct adt7470_data *data = dev_get_drvdata(dev);
> -	struct i2c_client *client = data->client;
> -	long freq;
> +	unsigned int low_freq = ADT7470_CFG_LF;
>  	int index;
> -	int low_freq = ADT7470_CFG_LF;
> -	unsigned char val;
> -
> -	if (kstrtol(buf, 10, &freq))
> -		return -EINVAL;
> +	int err;
>  
>  	/* Round the user value given to the closest available frequency */
>  	index = find_closest(freq, adt7470_freq_map,
> @@ -804,16 +777,62 @@ static ssize_t pwm1_freq_store(struct device *dev,
>  
>  	mutex_lock(&data->lock);
>  	/* Configuration Register 1 */
> -	val = i2c_smbus_read_byte_data(client, ADT7470_REG_CFG);
> -	i2c_smbus_write_byte_data(client, ADT7470_REG_CFG,
> -				  (val & ~ADT7470_CFG_LF) | low_freq);
> +	err = regmap_update_bits(data->regmap, ADT7470_REG_CFG,
> +				 ADT7470_CFG_LF, low_freq);
> +	if (err < 0)
> +		goto out;
> +
>  	/* Configuration Register 2 */
> -	val = i2c_smbus_read_byte_data(client, ADT7470_REG_CFG_2);
> -	i2c_smbus_write_byte_data(client, ADT7470_REG_CFG_2,
> -		(val & ~ADT7470_FREQ_MASK) | (index << ADT7470_FREQ_SHIFT));
> +	err = regmap_update_bits(data->regmap, ADT7470_REG_CFG_2,
> +				 ADT7470_FREQ_MASK,
> +				 index << ADT7470_FREQ_SHIFT);
> +out:
>  	mutex_unlock(&data->lock);
>  
> -	return count;
> +	return err;
> +}
> +
> +static int adt7470_pwm_write(struct device *dev, u32 attr, int channel, long val)
> +{
> +	struct adt7470_data *data = dev_get_drvdata(dev);
> +	unsigned int pwm_auto_reg_mask;
> +	int err;
> +
> +	switch (attr) {
> +	case hwmon_pwm_input:
> +		val = clamp_val(val, 0, 255);
> +		mutex_lock(&data->lock);
> +		data->pwm[channel] = val;
> +		err = regmap_write(data->regmap, ADT7470_REG_PWM(channel),
> +				   data->pwm[channel]);
> +		mutex_unlock(&data->lock);
> +		break;
> +	case hwmon_pwm_enable:
> +		if (channel % 2)
> +			pwm_auto_reg_mask = ADT7470_PWM2_AUTO_MASK;
> +		else
> +			pwm_auto_reg_mask = ADT7470_PWM1_AUTO_MASK;
> +
> +		if (val != 2 && val != 1)
> +			return -EINVAL;
> +		val--;
> +
> +		mutex_lock(&data->lock);
> +		data->pwm_automatic[channel] = val;
> +		err = regmap_update_bits(data->regmap, ADT7470_REG_PWM_CFG(channel),
> +				pwm_auto_reg_mask,
> +				val ? pwm_auto_reg_mask : 0);
> +		mutex_unlock(&data->lock);
> +		break;
> +	case hwmon_pwm_freq:
> +		err = pwm1_freq_set(dev, val);
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return err;
> +
>  }
>  
>  static ssize_t pwm_max_show(struct device *dev,
> @@ -834,8 +853,8 @@ static ssize_t pwm_max_store(struct device *dev,
>  {
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>  	struct adt7470_data *data = dev_get_drvdata(dev);
> -	struct i2c_client *client = data->client;
>  	long temp;
> +	int err;
>  
>  	if (kstrtol(buf, 10, &temp))
>  		return -EINVAL;
> @@ -844,11 +863,11 @@ static ssize_t pwm_max_store(struct device *dev,
>  
>  	mutex_lock(&data->lock);
>  	data->pwm_max[attr->index] = temp;
> -	i2c_smbus_write_byte_data(client, ADT7470_REG_PWM_MAX(attr->index),
> -				  temp);
> +	err = regmap_write(data->regmap, ADT7470_REG_PWM_MAX(attr->index),
> +			   temp);
>  	mutex_unlock(&data->lock);
>  
> -	return count;
> +	return err < 0 ? err : count;
>  }
>  
>  static ssize_t pwm_min_show(struct device *dev,
> @@ -869,8 +888,8 @@ static ssize_t pwm_min_store(struct device *dev,
>  {
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>  	struct adt7470_data *data = dev_get_drvdata(dev);
> -	struct i2c_client *client = data->client;
>  	long temp;
> +	int err;
>  
>  	if (kstrtol(buf, 10, &temp))
>  		return -EINVAL;
> @@ -879,11 +898,11 @@ static ssize_t pwm_min_store(struct device *dev,
>  
>  	mutex_lock(&data->lock);
>  	data->pwm_min[attr->index] = temp;
> -	i2c_smbus_write_byte_data(client, ADT7470_REG_PWM_MIN(attr->index),
> -				  temp);
> +	err = regmap_write(data->regmap, ADT7470_REG_PWM_MIN(attr->index),
> +			   temp);
>  	mutex_unlock(&data->lock);
>  
> -	return count;
> +	return err < 0 ? err : count;
>  }
>  
>  static ssize_t pwm_tmax_show(struct device *dev,
> @@ -917,8 +936,8 @@ static ssize_t pwm_tmin_store(struct device *dev,
>  {
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>  	struct adt7470_data *data = dev_get_drvdata(dev);
> -	struct i2c_client *client = data->client;
>  	long temp;
> +	int err;
>  
>  	if (kstrtol(buf, 10, &temp))
>  		return -EINVAL;
> @@ -928,60 +947,11 @@ static ssize_t pwm_tmin_store(struct device *dev,
>  
>  	mutex_lock(&data->lock);
>  	data->pwm_tmin[attr->index] = temp;
> -	i2c_smbus_write_byte_data(client, ADT7470_REG_PWM_TMIN(attr->index),
> -				  temp);
> +	err = regmap_write(data->regmap, ADT7470_REG_PWM_TMIN(attr->index),
> +			   temp);
>  	mutex_unlock(&data->lock);
>  
> -	return count;
> -}
> -
> -static ssize_t pwm_auto_show(struct device *dev,
> -			     struct device_attribute *devattr, char *buf)
> -{
> -	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> -	struct adt7470_data *data = adt7470_update_device(dev);
> -
> -	if (IS_ERR(data))
> -		return PTR_ERR(data);
> -
> -	return sprintf(buf, "%d\n", 1 + data->pwm_automatic[attr->index]);
> -}
> -
> -static ssize_t pwm_auto_store(struct device *dev,
> -			      struct device_attribute *devattr,
> -			      const char *buf, size_t count)
> -{
> -	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> -	struct adt7470_data *data = dev_get_drvdata(dev);
> -	struct i2c_client *client = data->client;
> -	int pwm_auto_reg = ADT7470_REG_PWM_CFG(attr->index);
> -	int pwm_auto_reg_mask;
> -	long temp;
> -	u8 reg;
> -
> -	if (kstrtol(buf, 10, &temp))
> -		return -EINVAL;
> -
> -	if (attr->index % 2)
> -		pwm_auto_reg_mask = ADT7470_PWM2_AUTO_MASK;
> -	else
> -		pwm_auto_reg_mask = ADT7470_PWM1_AUTO_MASK;
> -
> -	if (temp != 2 && temp != 1)
> -		return -EINVAL;
> -	temp--;
> -
> -	mutex_lock(&data->lock);
> -	data->pwm_automatic[attr->index] = temp;
> -	reg = i2c_smbus_read_byte_data(client, pwm_auto_reg);
> -	if (temp)
> -		reg |= pwm_auto_reg_mask;
> -	else
> -		reg &= ~pwm_auto_reg_mask;
> -	i2c_smbus_write_byte_data(client, pwm_auto_reg, reg);
> -	mutex_unlock(&data->lock);
> -
> -	return count;
> +	return err < 0 ? err : count;
>  }
>  
>  static ssize_t pwm_auto_temp_show(struct device *dev,
> @@ -1016,10 +986,10 @@ static ssize_t pwm_auto_temp_store(struct device *dev,
>  {
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>  	struct adt7470_data *data = dev_get_drvdata(dev);
> -	struct i2c_client *client = data->client;
>  	int pwm_auto_reg = ADT7470_REG_PWM_AUTO_TEMP(attr->index);
> +	unsigned int mask, val;
>  	long temp;
> -	u8 reg;
> +	int err;
>  
>  	if (kstrtol(buf, 10, &temp))
>  		return -EINVAL;
> @@ -1030,111 +1000,27 @@ static ssize_t pwm_auto_temp_store(struct device *dev,
>  
>  	mutex_lock(&data->lock);
>  	data->pwm_automatic[attr->index] = temp;
> -	reg = i2c_smbus_read_byte_data(client, pwm_auto_reg);
>  
>  	if (!(attr->index % 2)) {
> -		reg &= 0xF;
> -		reg |= (temp << 4) & 0xF0;
> +		mask = 0xF0;
> +		val = (temp << 4) & 0xF0;
>  	} else {
> -		reg &= 0xF0;
> -		reg |= temp & 0xF;
> +		mask = 0x0F;
> +		val = temp & 0x0F;
>  	}
>  
> -	i2c_smbus_write_byte_data(client, pwm_auto_reg, reg);
> +	err = regmap_update_bits(data->regmap, pwm_auto_reg, mask, val);
>  	mutex_unlock(&data->lock);
>  
> -	return count;
> -}
> -
> -static ssize_t alarm_show(struct device *dev,
> -			  struct device_attribute *devattr, char *buf)
> -{
> -	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> -	struct adt7470_data *data = adt7470_update_device(dev);
> -
> -	if (data->alarm & attr->index)
> -		return sprintf(buf, "1\n");
> -	else
> -		return sprintf(buf, "0\n");
> +	return err < 0 ? err : count;
>  }
>  
>  static DEVICE_ATTR_RW(alarm_mask);
>  static DEVICE_ATTR_RW(num_temp_sensors);
>  static DEVICE_ATTR_RW(auto_update_interval);
>  
> -static SENSOR_DEVICE_ATTR_RW(temp1_max, temp_max, 0);
> -static SENSOR_DEVICE_ATTR_RW(temp2_max, temp_max, 1);
> -static SENSOR_DEVICE_ATTR_RW(temp3_max, temp_max, 2);
> -static SENSOR_DEVICE_ATTR_RW(temp4_max, temp_max, 3);
> -static SENSOR_DEVICE_ATTR_RW(temp5_max, temp_max, 4);
> -static SENSOR_DEVICE_ATTR_RW(temp6_max, temp_max, 5);
> -static SENSOR_DEVICE_ATTR_RW(temp7_max, temp_max, 6);
> -static SENSOR_DEVICE_ATTR_RW(temp8_max, temp_max, 7);
> -static SENSOR_DEVICE_ATTR_RW(temp9_max, temp_max, 8);
> -static SENSOR_DEVICE_ATTR_RW(temp10_max, temp_max, 9);
> -
> -static SENSOR_DEVICE_ATTR_RW(temp1_min, temp_min, 0);
> -static SENSOR_DEVICE_ATTR_RW(temp2_min, temp_min, 1);
> -static SENSOR_DEVICE_ATTR_RW(temp3_min, temp_min, 2);
> -static SENSOR_DEVICE_ATTR_RW(temp4_min, temp_min, 3);
> -static SENSOR_DEVICE_ATTR_RW(temp5_min, temp_min, 4);
> -static SENSOR_DEVICE_ATTR_RW(temp6_min, temp_min, 5);
> -static SENSOR_DEVICE_ATTR_RW(temp7_min, temp_min, 6);
> -static SENSOR_DEVICE_ATTR_RW(temp8_min, temp_min, 7);
> -static SENSOR_DEVICE_ATTR_RW(temp9_min, temp_min, 8);
> -static SENSOR_DEVICE_ATTR_RW(temp10_min, temp_min, 9);
> -
> -static SENSOR_DEVICE_ATTR_RO(temp1_input, temp, 0);
> -static SENSOR_DEVICE_ATTR_RO(temp2_input, temp, 1);
> -static SENSOR_DEVICE_ATTR_RO(temp3_input, temp, 2);
> -static SENSOR_DEVICE_ATTR_RO(temp4_input, temp, 3);
> -static SENSOR_DEVICE_ATTR_RO(temp5_input, temp, 4);
> -static SENSOR_DEVICE_ATTR_RO(temp6_input, temp, 5);
> -static SENSOR_DEVICE_ATTR_RO(temp7_input, temp, 6);
> -static SENSOR_DEVICE_ATTR_RO(temp8_input, temp, 7);
> -static SENSOR_DEVICE_ATTR_RO(temp9_input, temp, 8);
> -static SENSOR_DEVICE_ATTR_RO(temp10_input, temp, 9);
> -
> -static SENSOR_DEVICE_ATTR_RO(temp1_alarm, alarm, ADT7470_R1T_ALARM);
> -static SENSOR_DEVICE_ATTR_RO(temp2_alarm, alarm, ADT7470_R2T_ALARM);
> -static SENSOR_DEVICE_ATTR_RO(temp3_alarm, alarm, ADT7470_R3T_ALARM);
> -static SENSOR_DEVICE_ATTR_RO(temp4_alarm, alarm, ADT7470_R4T_ALARM);
> -static SENSOR_DEVICE_ATTR_RO(temp5_alarm, alarm, ADT7470_R5T_ALARM);
> -static SENSOR_DEVICE_ATTR_RO(temp6_alarm, alarm, ADT7470_R6T_ALARM);
> -static SENSOR_DEVICE_ATTR_RO(temp7_alarm, alarm, ADT7470_R7T_ALARM);
> -static SENSOR_DEVICE_ATTR_RO(temp8_alarm, alarm, ALARM2(ADT7470_R8T_ALARM));
> -static SENSOR_DEVICE_ATTR_RO(temp9_alarm, alarm, ALARM2(ADT7470_R9T_ALARM));
> -static SENSOR_DEVICE_ATTR_RO(temp10_alarm, alarm, ALARM2(ADT7470_R10T_ALARM));
> -
> -static SENSOR_DEVICE_ATTR_RW(fan1_max, fan_max, 0);
> -static SENSOR_DEVICE_ATTR_RW(fan2_max, fan_max, 1);
> -static SENSOR_DEVICE_ATTR_RW(fan3_max, fan_max, 2);
> -static SENSOR_DEVICE_ATTR_RW(fan4_max, fan_max, 3);
> -
> -static SENSOR_DEVICE_ATTR_RW(fan1_min, fan_min, 0);
> -static SENSOR_DEVICE_ATTR_RW(fan2_min, fan_min, 1);
> -static SENSOR_DEVICE_ATTR_RW(fan3_min, fan_min, 2);
> -static SENSOR_DEVICE_ATTR_RW(fan4_min, fan_min, 3);
> -
> -static SENSOR_DEVICE_ATTR_RO(fan1_input, fan, 0);
> -static SENSOR_DEVICE_ATTR_RO(fan2_input, fan, 1);
> -static SENSOR_DEVICE_ATTR_RO(fan3_input, fan, 2);
> -static SENSOR_DEVICE_ATTR_RO(fan4_input, fan, 3);
> -
> -static SENSOR_DEVICE_ATTR_RO(fan1_alarm, alarm, ALARM2(ADT7470_FAN1_ALARM));
> -static SENSOR_DEVICE_ATTR_RO(fan2_alarm, alarm, ALARM2(ADT7470_FAN2_ALARM));
> -static SENSOR_DEVICE_ATTR_RO(fan3_alarm, alarm, ALARM2(ADT7470_FAN3_ALARM));
> -static SENSOR_DEVICE_ATTR_RO(fan4_alarm, alarm, ALARM2(ADT7470_FAN4_ALARM));
> -
>  static SENSOR_DEVICE_ATTR_RW(force_pwm_max, force_pwm_max, 0);
>  
> -static SENSOR_DEVICE_ATTR_RW(pwm1, pwm, 0);
> -static SENSOR_DEVICE_ATTR_RW(pwm2, pwm, 1);
> -static SENSOR_DEVICE_ATTR_RW(pwm3, pwm, 2);
> -static SENSOR_DEVICE_ATTR_RW(pwm4, pwm, 3);
> -
> -static DEVICE_ATTR_RW(pwm1_freq);
> -
>  static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point1_pwm, pwm_min, 0);
>  static SENSOR_DEVICE_ATTR_RW(pwm2_auto_point1_pwm, pwm_min, 1);
>  static SENSOR_DEVICE_ATTR_RW(pwm3_auto_point1_pwm, pwm_min, 2);
> @@ -1155,11 +1041,6 @@ static SENSOR_DEVICE_ATTR_RO(pwm2_auto_point2_temp, pwm_tmax, 1);
>  static SENSOR_DEVICE_ATTR_RO(pwm3_auto_point2_temp, pwm_tmax, 2);
>  static SENSOR_DEVICE_ATTR_RO(pwm4_auto_point2_temp, pwm_tmax, 3);
>  
> -static SENSOR_DEVICE_ATTR_RW(pwm1_enable, pwm_auto, 0);
> -static SENSOR_DEVICE_ATTR_RW(pwm2_enable, pwm_auto, 1);
> -static SENSOR_DEVICE_ATTR_RW(pwm3_enable, pwm_auto, 2);
> -static SENSOR_DEVICE_ATTR_RW(pwm4_enable, pwm_auto, 3);
> -
>  static SENSOR_DEVICE_ATTR_RW(pwm1_auto_channels_temp, pwm_auto_temp, 0);
>  static SENSOR_DEVICE_ATTR_RW(pwm2_auto_channels_temp, pwm_auto_temp, 1);
>  static SENSOR_DEVICE_ATTR_RW(pwm3_auto_channels_temp, pwm_auto_temp, 2);
> @@ -1169,68 +1050,7 @@ static struct attribute *adt7470_attrs[] = {
>  	&dev_attr_alarm_mask.attr,
>  	&dev_attr_num_temp_sensors.attr,
>  	&dev_attr_auto_update_interval.attr,
> -	&sensor_dev_attr_temp1_max.dev_attr.attr,
> -	&sensor_dev_attr_temp2_max.dev_attr.attr,
> -	&sensor_dev_attr_temp3_max.dev_attr.attr,
> -	&sensor_dev_attr_temp4_max.dev_attr.attr,
> -	&sensor_dev_attr_temp5_max.dev_attr.attr,
> -	&sensor_dev_attr_temp6_max.dev_attr.attr,
> -	&sensor_dev_attr_temp7_max.dev_attr.attr,
> -	&sensor_dev_attr_temp8_max.dev_attr.attr,
> -	&sensor_dev_attr_temp9_max.dev_attr.attr,
> -	&sensor_dev_attr_temp10_max.dev_attr.attr,
> -	&sensor_dev_attr_temp1_min.dev_attr.attr,
> -	&sensor_dev_attr_temp2_min.dev_attr.attr,
> -	&sensor_dev_attr_temp3_min.dev_attr.attr,
> -	&sensor_dev_attr_temp4_min.dev_attr.attr,
> -	&sensor_dev_attr_temp5_min.dev_attr.attr,
> -	&sensor_dev_attr_temp6_min.dev_attr.attr,
> -	&sensor_dev_attr_temp7_min.dev_attr.attr,
> -	&sensor_dev_attr_temp8_min.dev_attr.attr,
> -	&sensor_dev_attr_temp9_min.dev_attr.attr,
> -	&sensor_dev_attr_temp10_min.dev_attr.attr,
> -	&sensor_dev_attr_temp1_input.dev_attr.attr,
> -	&sensor_dev_attr_temp2_input.dev_attr.attr,
> -	&sensor_dev_attr_temp3_input.dev_attr.attr,
> -	&sensor_dev_attr_temp4_input.dev_attr.attr,
> -	&sensor_dev_attr_temp5_input.dev_attr.attr,
> -	&sensor_dev_attr_temp6_input.dev_attr.attr,
> -	&sensor_dev_attr_temp7_input.dev_attr.attr,
> -	&sensor_dev_attr_temp8_input.dev_attr.attr,
> -	&sensor_dev_attr_temp9_input.dev_attr.attr,
> -	&sensor_dev_attr_temp10_input.dev_attr.attr,
> -	&sensor_dev_attr_temp1_alarm.dev_attr.attr,
> -	&sensor_dev_attr_temp2_alarm.dev_attr.attr,
> -	&sensor_dev_attr_temp3_alarm.dev_attr.attr,
> -	&sensor_dev_attr_temp4_alarm.dev_attr.attr,
> -	&sensor_dev_attr_temp5_alarm.dev_attr.attr,
> -	&sensor_dev_attr_temp6_alarm.dev_attr.attr,
> -	&sensor_dev_attr_temp7_alarm.dev_attr.attr,
> -	&sensor_dev_attr_temp8_alarm.dev_attr.attr,
> -	&sensor_dev_attr_temp9_alarm.dev_attr.attr,
> -	&sensor_dev_attr_temp10_alarm.dev_attr.attr,
> -	&sensor_dev_attr_fan1_max.dev_attr.attr,
> -	&sensor_dev_attr_fan2_max.dev_attr.attr,
> -	&sensor_dev_attr_fan3_max.dev_attr.attr,
> -	&sensor_dev_attr_fan4_max.dev_attr.attr,
> -	&sensor_dev_attr_fan1_min.dev_attr.attr,
> -	&sensor_dev_attr_fan2_min.dev_attr.attr,
> -	&sensor_dev_attr_fan3_min.dev_attr.attr,
> -	&sensor_dev_attr_fan4_min.dev_attr.attr,
> -	&sensor_dev_attr_fan1_input.dev_attr.attr,
> -	&sensor_dev_attr_fan2_input.dev_attr.attr,
> -	&sensor_dev_attr_fan3_input.dev_attr.attr,
> -	&sensor_dev_attr_fan4_input.dev_attr.attr,
> -	&sensor_dev_attr_fan1_alarm.dev_attr.attr,
> -	&sensor_dev_attr_fan2_alarm.dev_attr.attr,
> -	&sensor_dev_attr_fan3_alarm.dev_attr.attr,
> -	&sensor_dev_attr_fan4_alarm.dev_attr.attr,
>  	&sensor_dev_attr_force_pwm_max.dev_attr.attr,
> -	&sensor_dev_attr_pwm1.dev_attr.attr,
> -	&dev_attr_pwm1_freq.attr,
> -	&sensor_dev_attr_pwm2.dev_attr.attr,
> -	&sensor_dev_attr_pwm3.dev_attr.attr,
> -	&sensor_dev_attr_pwm4.dev_attr.attr,
>  	&sensor_dev_attr_pwm1_auto_point1_pwm.dev_attr.attr,
>  	&sensor_dev_attr_pwm2_auto_point1_pwm.dev_attr.attr,
>  	&sensor_dev_attr_pwm3_auto_point1_pwm.dev_attr.attr,
> @@ -1247,10 +1067,6 @@ static struct attribute *adt7470_attrs[] = {
>  	&sensor_dev_attr_pwm2_auto_point2_temp.dev_attr.attr,
>  	&sensor_dev_attr_pwm3_auto_point2_temp.dev_attr.attr,
>  	&sensor_dev_attr_pwm4_auto_point2_temp.dev_attr.attr,
> -	&sensor_dev_attr_pwm1_enable.dev_attr.attr,
> -	&sensor_dev_attr_pwm2_enable.dev_attr.attr,
> -	&sensor_dev_attr_pwm3_enable.dev_attr.attr,
> -	&sensor_dev_attr_pwm4_enable.dev_attr.attr,
>  	&sensor_dev_attr_pwm1_auto_channels_temp.dev_attr.attr,
>  	&sensor_dev_attr_pwm2_auto_channels_temp.dev_attr.attr,
>  	&sensor_dev_attr_pwm3_auto_channels_temp.dev_attr.attr,
> @@ -1260,6 +1076,129 @@ static struct attribute *adt7470_attrs[] = {
>  
>  ATTRIBUTE_GROUPS(adt7470);
>  
> +static int adt7470_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
> +			int channel, long *val)
> +{
> +	switch (type) {
> +	case hwmon_temp:
> +		return adt7470_temp_read(dev, attr, channel, val);
> +	case hwmon_fan:
> +		return adt7470_fan_read(dev, attr, channel, val);
> +	case hwmon_pwm:
> +		return adt7470_pwm_read(dev, attr, channel, val);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static int adt7470_write(struct device *dev, enum hwmon_sensor_types type, u32 attr,
> +			int channel, long val)
> +{
> +	switch (type) {
> +	case hwmon_temp:
> +		return adt7470_temp_write(dev, attr, channel, val);
> +	case hwmon_fan:
> +		return adt7470_fan_write(dev, attr, channel, val);
> +	case hwmon_pwm:
> +		return adt7470_pwm_write(dev, attr, channel, val);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static umode_t adt7470_is_visible(const void *_data, enum hwmon_sensor_types type,
> +				  u32 attr, int channel)
> +{
> +	umode_t mode = 0;
> +
> +	switch (type) {
> +	case hwmon_temp:
> +		switch (attr) {
> +		case hwmon_temp:
> +		case hwmon_temp_alarm:
> +			mode = 0444;
> +			break;
> +		case hwmon_temp_min:
> +		case hwmon_temp_max:
> +			mode = 0644;
> +			break;
> +		default:
> +			break;
> +		}
> +		break;
> +	case hwmon_fan:
> +		switch (attr) {
> +		case hwmon_fan_input:
> +		case hwmon_fan_alarm:
> +			mode = 0444;
> +			break;
> +		case hwmon_fan_min:
> +		case hwmon_fan_max:
> +			mode = 0644;
> +			break;
> +		default:
> +			break;
> +		}
> +		break;
> +	case hwmon_pwm:
> +		switch (attr) {
> +		case hwmon_pwm_input:
> +		case hwmon_pwm_enable:
> +			mode = 0644;
> +			break;
> +		case hwmon_pwm_freq:
> +			if (channel == 0)
> +				mode = 0644;
> +			else
> +				mode = 0;
> +			break;
> +		default:
> +			break;
> +		}
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return mode;
> +}
> +
> +static const struct hwmon_ops adt7470_hwmon_ops = {
> +	.is_visible = adt7470_is_visible,
> +	.read = adt7470_read,
> +	.write = adt7470_write,
> +};
> +
> +static const struct hwmon_channel_info *adt7470_info[] = {
> +	HWMON_CHANNEL_INFO(temp,
> +			HWMON_T_INPUT | HWMON_T_MIN | HWMON_T_MAX | HWMON_T_ALARM,
> +			HWMON_T_INPUT | HWMON_T_MIN | HWMON_T_MAX | HWMON_T_ALARM,
> +			HWMON_T_INPUT | HWMON_T_MIN | HWMON_T_MAX | HWMON_T_ALARM,
> +			HWMON_T_INPUT | HWMON_T_MIN | HWMON_T_MAX | HWMON_T_ALARM,
> +			HWMON_T_INPUT | HWMON_T_MIN | HWMON_T_MAX | HWMON_T_ALARM,
> +			HWMON_T_INPUT | HWMON_T_MIN | HWMON_T_MAX | HWMON_T_ALARM,
> +			HWMON_T_INPUT | HWMON_T_MIN | HWMON_T_MAX | HWMON_T_ALARM,
> +			HWMON_T_INPUT | HWMON_T_MIN | HWMON_T_MAX | HWMON_T_ALARM,
> +			HWMON_T_INPUT | HWMON_T_MIN | HWMON_T_MAX | HWMON_T_ALARM,
> +			HWMON_T_INPUT | HWMON_T_MIN | HWMON_T_MAX | HWMON_T_ALARM),
> +	HWMON_CHANNEL_INFO(fan,
> +			HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_MAX | HWMON_F_DIV | HWMON_F_ALARM,
> +			HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_MAX | HWMON_F_DIV | HWMON_F_ALARM,
> +			HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_MAX | HWMON_F_DIV | HWMON_F_ALARM,
> +			HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_MAX | HWMON_F_DIV | HWMON_F_ALARM),
> +	HWMON_CHANNEL_INFO(pwm,
> +			HWMON_PWM_INPUT | HWMON_PWM_ENABLE | HWMON_PWM_FREQ,
> +			HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
> +			HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
> +			HWMON_PWM_INPUT | HWMON_PWM_ENABLE),
> +	NULL
> +};
> +
> +static const struct hwmon_chip_info adt7470_chip_info = {
> +	.ops = &adt7470_hwmon_ops,
> +	.info = adt7470_info,
> +};
> +
>  /* Return 0 if detection is successful, -ENODEV otherwise */
>  static int adt7470_detect(struct i2c_client *client,
>  			  struct i2c_board_info *info)
> @@ -1287,23 +1226,19 @@ static int adt7470_detect(struct i2c_client *client,
>  	return 0;
>  }
>  
> -static void adt7470_init_client(struct i2c_client *client)
> -{
> -	int reg = i2c_smbus_read_byte_data(client, ADT7470_REG_CFG);
> -
> -	if (reg < 0) {
> -		dev_err(&client->dev, "cannot read configuration register\n");
> -	} else {
> -		/* start monitoring (and do a self-test) */
> -		i2c_smbus_write_byte_data(client, ADT7470_REG_CFG, reg | 3);
> -	}
> -}
> +static const struct regmap_config adt7470_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.use_single_read = true,
> +	.use_single_write = true,
> +};
>  
>  static int adt7470_probe(struct i2c_client *client)
>  {
>  	struct device *dev = &client->dev;
>  	struct adt7470_data *data;
>  	struct device *hwmon_dev;
> +	int err;
>  
>  	data = devm_kzalloc(dev, sizeof(struct adt7470_data), GFP_KERNEL);
>  	if (!data)
> @@ -1311,29 +1246,34 @@ static int adt7470_probe(struct i2c_client *client)
>  
>  	data->num_temp_sensors = -1;
>  	data->auto_update_interval = AUTO_UPDATE_INTERVAL;
> +	data->regmap = devm_regmap_init_i2c(client, &adt7470_regmap_config);
> +	if (IS_ERR(data->regmap))
> +		return PTR_ERR(data->regmap);
>  
>  	i2c_set_clientdata(client, data);
> -	data->client = client;
>  	mutex_init(&data->lock);
>  
>  	dev_info(&client->dev, "%s chip found\n", client->name);
>  
>  	/* Initialize the ADT7470 chip */
> -	adt7470_init_client(client);
> +	err = regmap_update_bits(data->regmap, ADT7470_REG_CFG,
> +				 ADT7470_STRT_MASK | ADT7470_TEST_MASK,
> +				 ADT7470_STRT_MASK | ADT7470_TEST_MASK);
> +	if (err < 0)
> +		return err;
>  
>  	/* Register sysfs hooks */
> -	hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
> -							   data,
> -							   adt7470_groups);
> +	hwmon_dev = devm_hwmon_device_register_with_info(dev, client->name, data,
> +							 &adt7470_chip_info,
> +							 adt7470_groups);
>  
>  	if (IS_ERR(hwmon_dev))
>  		return PTR_ERR(hwmon_dev);
>  
>  	data->auto_update = kthread_run(adt7470_update_thread, client, "%s",
>  					dev_name(hwmon_dev));
> -	if (IS_ERR(data->auto_update)) {
> +	if (IS_ERR(data->auto_update))
>  		return PTR_ERR(data->auto_update);
> -	}
>  
>  	return 0;
>  }
