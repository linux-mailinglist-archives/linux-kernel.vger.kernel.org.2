Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7AF93FA10D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 23:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbhH0VSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 17:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231823AbhH0VSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 17:18:38 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADCBAC0613D9;
        Fri, 27 Aug 2021 14:17:48 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id h133so11298576oib.7;
        Fri, 27 Aug 2021 14:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QA0XqvZPCifytY2PE9UKhpkQ8QBD49Ke9HlQduRdrKQ=;
        b=mjUKH4Avo02XmICIHGOfutPjyc7Mn5GWOzzngXNJ0llTbAwb3YLvBvKg1MNjEQ3EKU
         szCcINMqDLqJ2ftK3B7yoi50AmOCRtP9oZHlf2XR3RXwgHdJvDBemUyDPSaUYqdfmMq5
         xtwGYseUOlvDdbtVcljPuQ71x1ZNXMbWAye3VxJY53LVU7MCP7LCoy+l1r3U1cq9Zl0b
         DsIsX6pYlUk2lgfpHMOTCLuP6iI8pWIUIjNH+tUcKE86QygLmLLBPTn/ULBkc8p50s6l
         4LI+qzgNGAXhphVglOR79MqvhmStqgmZm/jDdBmys29aXfgV4P2XUfTVHHevKrhw1acH
         SijQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=QA0XqvZPCifytY2PE9UKhpkQ8QBD49Ke9HlQduRdrKQ=;
        b=LjACdOJ9S2hgM1BZYj7pmmyqb9YPnmGjobdwXXydKcnJUkTw5TR3wn0BoSbUZcvaGf
         hLBvBWQqKy75tNec43AYgTQxsZe/fTwTAw3xO8jOdsbQyzV0gKNXdbb5yCnIPtjmsvFC
         rTuEbGFK1pHaRJ1jwcPnRRNea6xWvLzEzihVgQKkda6Tmg9a8KI4PR6iESBFRBocLpGK
         BICaef5PLz4joykqZAgHCQstMsNFmsPVTSTuEg0VsbK4UFvl5YYL05WfphVXohh7m47j
         4z1MfWHMP2tvjyDfzVAk0FjEpZ+9afDvgkg20NRTJNw/Gq5JRUP/rGtxOyd7NtgIIHav
         dWmQ==
X-Gm-Message-State: AOAM533feXMzxp2dlCMXRwYRED0ZsKpmhAVEaNDbvDPsTl6dP5mVJbCN
        TJVRHSXD5R4GyMwUo1C7c88MA5Rei6I=
X-Google-Smtp-Source: ABdhPJzw6NJUX9fNdnHvImVDTWLzgQ3yLP7dBhGPmgd1kTBJOiE+J7U79RtETOLYJS6lVnG4/XlCvQ==
X-Received: by 2002:aca:4557:: with SMTP id s84mr15912601oia.77.1630099067905;
        Fri, 27 Aug 2021 14:17:47 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q7sm1443485otl.68.2021.08.27.14.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 14:17:47 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 27 Aug 2021 14:17:46 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] hwmon: (adt7470) Convert to use regmap
Message-ID: <20210827211746.GA706743@roeck-us.net>
References: <20210826024121.15665-1-chris.packham@alliedtelesis.co.nz>
 <20210826024121.15665-3-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210826024121.15665-3-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2021 at 02:41:19PM +1200, Chris Packham wrote:
> Convert the adt7470 to using regmap which allows better error handling.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

Applied.

Thanks,
Guenter

> ---
> Change in v2:
> - split regmap and devm_hwmon_device_register_with_info into separate
>   patches to aid review
> 
>  drivers/hwmon/adt7470.c | 430 +++++++++++++++++++++++-----------------
>  1 file changed, 249 insertions(+), 181 deletions(-)
> 
> diff --git a/drivers/hwmon/adt7470.c b/drivers/hwmon/adt7470.c
> index 3358ec58b977..ad3e46667be8 100644
> --- a/drivers/hwmon/adt7470.c
> +++ b/drivers/hwmon/adt7470.c
> @@ -18,6 +18,7 @@
>  #include <linux/delay.h>
>  #include <linux/log2.h>
>  #include <linux/kthread.h>
> +#include <linux/regmap.h>
>  #include <linux/slab.h>
>  #include <linux/util_macros.h>
>  
> @@ -35,7 +36,10 @@ static const unsigned short normal_i2c[] = { 0x2C, 0x2E, 0x2F, I2C_CLIENT_END };
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
> @@ -137,7 +141,7 @@ static const unsigned short normal_i2c[] = { 0x2C, 0x2E, 0x2F, I2C_CLIENT_END };
>  #define ADT7470_FREQ_SHIFT	4
>  
>  struct adt7470_data {
> -	struct i2c_client	*client;
> +	struct regmap		*regmap;
>  	struct mutex		lock;
>  	char			sensors_valid;
>  	char			limits_valid;
> @@ -171,52 +175,76 @@ struct adt7470_data {
>   * 16-bit registers on the ADT7470 are low-byte first.  The data sheet says
>   * that the low byte must be read before the high byte.
>   */
> -static inline int adt7470_read_word_data(struct i2c_client *client, u8 reg)
> +static inline int adt7470_read_word_data(struct adt7470_data *data, unsigned int reg,
> +					 unsigned int *val)
>  {
> -	u16 foo;
> +	u8 regval[2];
> +	int err;
>  
> -	foo = i2c_smbus_read_byte_data(client, reg);
> -	foo |= ((u16)i2c_smbus_read_byte_data(client, reg + 1) << 8);
> -	return foo;
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
> @@ -224,26 +252,31 @@ static int adt7470_read_temperatures(struct i2c_client *client,
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
> @@ -258,7 +291,7 @@ static int adt7470_update_thread(void *p)
>  
>  	while (!kthread_should_stop()) {
>  		mutex_lock(&data->lock);
> -		adt7470_read_temperatures(client, data);
> +		adt7470_read_temperatures(data);
>  		mutex_unlock(&data->lock);
>  
>  		set_current_state(TASK_INTERRUPTIBLE);
> @@ -273,89 +306,116 @@ static int adt7470_update_thread(void *p)
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
> +
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
> +	err = regmap_read(data->regmap, ADT7470_REG_CFG, &val);
> +	if (err < 0)
> +		return err;
> +	data->force_pwm_max = !!(val & ADT7470_FSPD_MASK);
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
> +	err = adt7470_read_word_data(data, ADT7470_REG_ALARM1_MASK, &val);
> +	if (err < 0)
> +		return err;
> +	data->alarms_mask = val;
>  
>  	return 0;
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
> @@ -491,8 +551,8 @@ static ssize_t temp_min_store(struct device *dev,
>  {
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>  	struct adt7470_data *data = dev_get_drvdata(dev);
> -	struct i2c_client *client = data->client;
>  	long temp;
> +	int err;
>  
>  	if (kstrtol(buf, 10, &temp))
>  		return -EINVAL;
> @@ -502,11 +562,11 @@ static ssize_t temp_min_store(struct device *dev,
>  
>  	mutex_lock(&data->lock);
>  	data->temp_min[attr->index] = temp;
> -	i2c_smbus_write_byte_data(client, ADT7470_TEMP_MIN_REG(attr->index),
> +	err = regmap_write(data->regmap, ADT7470_TEMP_MIN_REG(attr->index),
>  				  temp);
>  	mutex_unlock(&data->lock);
>  
> -	return count;
> +	return err < 0 ? err : count;
>  }
>  
>  static ssize_t temp_max_show(struct device *dev,
> @@ -527,8 +587,8 @@ static ssize_t temp_max_store(struct device *dev,
>  {
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>  	struct adt7470_data *data = dev_get_drvdata(dev);
> -	struct i2c_client *client = data->client;
>  	long temp;
> +	int err;
>  
>  	if (kstrtol(buf, 10, &temp))
>  		return -EINVAL;
> @@ -538,11 +598,10 @@ static ssize_t temp_max_store(struct device *dev,
>  
>  	mutex_lock(&data->lock);
>  	data->temp_max[attr->index] = temp;
> -	i2c_smbus_write_byte_data(client, ADT7470_TEMP_MAX_REG(attr->index),
> -				  temp);
> +	err = regmap_write(data->regmap, ADT7470_TEMP_MAX_REG(attr->index), temp);
>  	mutex_unlock(&data->lock);
>  
> -	return count;
> +	return err < 0 ? err : count;
>  }
>  
>  static ssize_t temp_show(struct device *dev, struct device_attribute *devattr,
> @@ -575,6 +634,7 @@ static ssize_t alarm_mask_store(struct device *dev,
>  {
>  	struct adt7470_data *data = dev_get_drvdata(dev);
>  	long mask;
> +	int err;
>  
>  	if (kstrtoul(buf, 0, &mask))
>  		return -EINVAL;
> @@ -584,10 +644,10 @@ static ssize_t alarm_mask_store(struct device *dev,
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
>  static ssize_t fan_max_show(struct device *dev,
> @@ -612,8 +672,8 @@ static ssize_t fan_max_store(struct device *dev,
>  {
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>  	struct adt7470_data *data = dev_get_drvdata(dev);
> -	struct i2c_client *client = data->client;
>  	long temp;
> +	int err;
>  
>  	if (kstrtol(buf, 10, &temp) || !temp)
>  		return -EINVAL;
> @@ -623,10 +683,10 @@ static ssize_t fan_max_store(struct device *dev,
>  
>  	mutex_lock(&data->lock);
>  	data->fan_max[attr->index] = temp;
> -	adt7470_write_word_data(client, ADT7470_REG_FAN_MAX(attr->index), temp);
> +	err = adt7470_write_word_data(data, ADT7470_REG_FAN_MAX(attr->index), temp);
>  	mutex_unlock(&data->lock);
>  
> -	return count;
> +	return err < 0 ? err : count;
>  }
>  
>  static ssize_t fan_min_show(struct device *dev,
> @@ -651,8 +711,8 @@ static ssize_t fan_min_store(struct device *dev,
>  {
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>  	struct adt7470_data *data = dev_get_drvdata(dev);
> -	struct i2c_client *client = data->client;
>  	long temp;
> +	int err;
>  
>  	if (kstrtol(buf, 10, &temp) || !temp)
>  		return -EINVAL;
> @@ -662,10 +722,10 @@ static ssize_t fan_min_store(struct device *dev,
>  
>  	mutex_lock(&data->lock);
>  	data->fan_min[attr->index] = temp;
> -	adt7470_write_word_data(client, ADT7470_REG_FAN_MIN(attr->index), temp);
> +	err = adt7470_write_word_data(data, ADT7470_REG_FAN_MIN(attr->index), temp);
>  	mutex_unlock(&data->lock);
>  
> -	return count;
> +	return err < 0 ? err : count;
>  }
>  
>  static ssize_t fan_show(struct device *dev, struct device_attribute *devattr,
> @@ -700,24 +760,20 @@ static ssize_t force_pwm_max_store(struct device *dev,
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
> +	return err < 0 ? err : count;
>  }
>  
>  static ssize_t pwm_show(struct device *dev, struct device_attribute *devattr,
> @@ -737,8 +793,8 @@ static ssize_t pwm_store(struct device *dev, struct device_attribute *devattr,
>  {
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>  	struct adt7470_data *data = dev_get_drvdata(dev);
> -	struct i2c_client *client = data->client;
>  	long temp;
> +	int err;
>  
>  	if (kstrtol(buf, 10, &temp))
>  		return -EINVAL;
> @@ -747,10 +803,10 @@ static ssize_t pwm_store(struct device *dev, struct device_attribute *devattr,
>  
>  	mutex_lock(&data->lock);
>  	data->pwm[attr->index] = temp;
> -	i2c_smbus_write_byte_data(client, ADT7470_REG_PWM(attr->index), temp);
> +	err = regmap_write(data->regmap, ADT7470_REG_PWM(attr->index), temp);
>  	mutex_unlock(&data->lock);
>  
> -	return count;
> +	return err < 0 ? err : count;
>  }
>  
>  /* These are the valid PWM frequencies to the nearest Hz */
> @@ -762,13 +818,20 @@ static ssize_t pwm1_freq_show(struct device *dev,
>  			      struct device_attribute *devattr, char *buf)
>  {
>  	struct adt7470_data *data = adt7470_update_device(dev);
> -	unsigned char cfg_reg_1;
> -	unsigned char cfg_reg_2;
> +	unsigned int cfg_reg_1, cfg_reg_2;
>  	int index;
> +	int err;
> +
> +	if (IS_ERR(data))
> +		return PTR_ERR(data);
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
> @@ -778,6 +841,10 @@ static ssize_t pwm1_freq_show(struct device *dev,
>  		index = ARRAY_SIZE(adt7470_freq_map) - 1;
>  
>  	return scnprintf(buf, PAGE_SIZE, "%d\n", adt7470_freq_map[index]);
> +
> +out:
> +	mutex_unlock(&data->lock);
> +	return err;
>  }
>  
>  static ssize_t pwm1_freq_store(struct device *dev,
> @@ -785,11 +852,10 @@ static ssize_t pwm1_freq_store(struct device *dev,
>  			       const char *buf, size_t count)
>  {
>  	struct adt7470_data *data = dev_get_drvdata(dev);
> -	struct i2c_client *client = data->client;
>  	long freq;
>  	int index;
>  	int low_freq = ADT7470_CFG_LF;
> -	unsigned char val;
> +	int err;
>  
>  	if (kstrtol(buf, 10, &freq))
>  		return -EINVAL;
> @@ -805,16 +871,19 @@ static ssize_t pwm1_freq_store(struct device *dev,
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
> +	return err < 0 ? err : count;
>  }
>  
>  static ssize_t pwm_max_show(struct device *dev,
> @@ -835,8 +904,8 @@ static ssize_t pwm_max_store(struct device *dev,
>  {
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>  	struct adt7470_data *data = dev_get_drvdata(dev);
> -	struct i2c_client *client = data->client;
>  	long temp;
> +	int err;
>  
>  	if (kstrtol(buf, 10, &temp))
>  		return -EINVAL;
> @@ -845,11 +914,11 @@ static ssize_t pwm_max_store(struct device *dev,
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
> @@ -870,8 +939,8 @@ static ssize_t pwm_min_store(struct device *dev,
>  {
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>  	struct adt7470_data *data = dev_get_drvdata(dev);
> -	struct i2c_client *client = data->client;
>  	long temp;
> +	int err;
>  
>  	if (kstrtol(buf, 10, &temp))
>  		return -EINVAL;
> @@ -880,11 +949,11 @@ static ssize_t pwm_min_store(struct device *dev,
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
> @@ -918,8 +987,8 @@ static ssize_t pwm_tmin_store(struct device *dev,
>  {
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>  	struct adt7470_data *data = dev_get_drvdata(dev);
> -	struct i2c_client *client = data->client;
>  	long temp;
> +	int err;
>  
>  	if (kstrtol(buf, 10, &temp))
>  		return -EINVAL;
> @@ -929,11 +998,11 @@ static ssize_t pwm_tmin_store(struct device *dev,
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
> +	return err < 0 ? err : count;
>  }
>  
>  static ssize_t pwm_auto_show(struct device *dev,
> @@ -954,11 +1023,9 @@ static ssize_t pwm_auto_store(struct device *dev,
>  {
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>  	struct adt7470_data *data = dev_get_drvdata(dev);
> -	struct i2c_client *client = data->client;
> -	int pwm_auto_reg = ADT7470_REG_PWM_CFG(attr->index);
>  	int pwm_auto_reg_mask;
>  	long temp;
> -	u8 reg;
> +	int err;
>  
>  	if (kstrtol(buf, 10, &temp))
>  		return -EINVAL;
> @@ -974,15 +1041,12 @@ static ssize_t pwm_auto_store(struct device *dev,
>  
>  	mutex_lock(&data->lock);
>  	data->pwm_automatic[attr->index] = temp;
> -	reg = i2c_smbus_read_byte_data(client, pwm_auto_reg);
> -	if (temp)
> -		reg |= pwm_auto_reg_mask;
> -	else
> -		reg &= ~pwm_auto_reg_mask;
> -	i2c_smbus_write_byte_data(client, pwm_auto_reg, reg);
> +	err = regmap_update_bits(data->regmap, ADT7470_REG_PWM_CFG(attr->index),
> +				 pwm_auto_reg_mask,
> +				 temp ? pwm_auto_reg_mask : 0);
>  	mutex_unlock(&data->lock);
>  
> -	return count;
> +	return err < 0 ? err : count;
>  }
>  
>  static ssize_t pwm_auto_temp_show(struct device *dev,
> @@ -1017,10 +1081,10 @@ static ssize_t pwm_auto_temp_store(struct device *dev,
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
> @@ -1031,20 +1095,19 @@ static ssize_t pwm_auto_temp_store(struct device *dev,
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
> +	return err < 0 ? err : count;
>  }
>  
>  static ssize_t alarm_show(struct device *dev,
> @@ -1053,6 +1116,9 @@ static ssize_t alarm_show(struct device *dev,
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>  	struct adt7470_data *data = adt7470_update_device(dev);
>  
> +	if (IS_ERR(data))
> +		return PTR_ERR(data);
> +
>  	if (data->alarm & attr->index)
>  		return sprintf(buf, "1\n");
>  	else
> @@ -1288,23 +1354,19 @@ static int adt7470_detect(struct i2c_client *client,
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
> @@ -1312,15 +1374,21 @@ static int adt7470_probe(struct i2c_client *client)
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
>  	hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
