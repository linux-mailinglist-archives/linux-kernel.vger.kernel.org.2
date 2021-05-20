Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8891C389CF4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 07:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbhETFNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 01:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbhETFN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 01:13:28 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C323AC061574;
        Wed, 19 May 2021 22:12:06 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id c20so15060245qkm.3;
        Wed, 19 May 2021 22:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iGt6GNjsfcEFc3c4nOlUAk3fFQaMQQwdP1dl8p3iAGA=;
        b=XsbtYwLM8yDhrIKnU1IPeW+OBWK+iRII6f3dhXjBfqmI/dkveyf/Lh6LrsoNFbqXJE
         iPl+z2Utn/HJQ9tSnambS4e4WLzwuk+nhT5GNp0KcEFYX/UczmDtmeBX0zKu3XmDuMaT
         RqE24wTrcjJ/uO9UjdeD+t06Nl9qAqZ4KJ0kXilDdjSGL2y4Ez9CfhxivE8hp3B5lxV0
         oj04bJF7d/EfJd3vIWpp6fTCY/EizQdHR8uFUL6hWqqOt/3S/Q3Rca8xuDHkkXZjGwvn
         IYU20X9+cLIW49Wn/XZj1jsVdhHeS4OUd6sX4yxZIuDIVrMGqRZ4VI6reY4Y0kfPKAtQ
         mItw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iGt6GNjsfcEFc3c4nOlUAk3fFQaMQQwdP1dl8p3iAGA=;
        b=jRoU+mZQnvG6EHBN672RVFQXmROhFj1zeO5hW5SZLf496IUNEApPBB3klzHHJ4HE9F
         pVrqH60uID7YP6j+MMsqzn7HU3erRXu5u8EBp9ypno9PxX/a7Pn20+LEULbu2TWpWNqR
         y3bqhr+d8nuo+pfU3jDF6A8CvxOGN7nVuSedUF+uif9jfdhtolmChIEM4UURL7nDDkHm
         ZMMGJNBHoZRSnxeReRoTLu1kSX9zvQkPgCsb9zJyXkqYo4fizO6j+aBziau85mCckpvp
         uFIfj6xjgiC1ZEaya5uKQxbSl62QbdM/v937J2Z2Cn4XCMZlhJUBRvdU29Mgy4niiQR5
         wwew==
X-Gm-Message-State: AOAM533/PY810cMkdE7UcWRCMpWjUKfRYswEvSt7k4KEC42z+oO8lI5i
        obt+rMeBu+DHQ1iagm4JXaoVvemVCso=
X-Google-Smtp-Source: ABdhPJwLeGsPMKAx/rwckCUPjNK7U9lKL0vV5aAiUFFz5sL8F2Il7TrcEncxfg+Z9fG/nkuFDjFh7g==
X-Received: by 2002:a05:620a:24cf:: with SMTP id m15mr3002581qkn.435.1621487525665;
        Wed, 19 May 2021 22:12:05 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p19sm1328845qki.119.2021.05.19.22.12.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 May 2021 22:12:05 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v5 1/5] hwmon: (max31790) Rework to use regmap
To:     =?UTF-8?B?VsOhY2xhdiBLdWJlcm7DoXQ=?= <kubernat@cesnet.cz>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210512013052.903297-1-kubernat@cesnet.cz>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <f8ed6593-f120-959c-cc5c-481df11e38b6@roeck-us.net>
Date:   Wed, 19 May 2021 22:12:03 -0700
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
> +};
> +
> +static const struct regmap_access_table max31790_volatile_table = {
> +	.no_ranges = max31790_volatile_ranges,
> +	.n_no_ranges = 2,
> +	.n_yes_ranges = 0
> +};
> +
> +static const struct regmap_config max31790_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.reg_stride = 1,
> +	.max_register = MAX31790_REG_USER_BYTE_67,
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

Please use the NR_CHANNEL constant.

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

Better written without conditional as
		*val = !!(fault & (1 << (channel % NR_CHANNEL)));

Guenter
