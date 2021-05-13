Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8215837F453
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 10:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbhEMIqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 04:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbhEMIqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 04:46:09 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4AFC061574;
        Thu, 13 May 2021 01:45:00 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id u25-20020a0568302319b02902ac3d54c25eso23063634ote.1;
        Thu, 13 May 2021 01:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SRofZYXv67eyg6ETbiRUhhuS19/6MF1X7H2YWc2HqVk=;
        b=lgW58ub1pPvcn/0j6/7Kc0I3IqzRu6z19eAZIrCqvw99N/s9yegdRdKujZYmCUeet2
         F4WSuTLPz2/FZ8kC/O/V9mvFO1mAODVicos1v4Nny23TANBvEGKV5TujoSiEbp+d5zfO
         MsGBGhAa1bFbnxq8bwDew5ho7qOgEnVLa9LgjX4M4ytzHZWkzs7ZmYD7rSvZtmOagUbN
         /g7ifgISkWD4xKP6VA4PRphsNlCzvyvuLFvw0uEuFcBOutw2IynnoIaxhtujQp+Y1SKU
         eCM0b6RS+XSUVXSKPq7o2xZguSosymRb0BjrDdk7FJfUknWUcd0307cljevZGXr4fKtc
         aOMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=SRofZYXv67eyg6ETbiRUhhuS19/6MF1X7H2YWc2HqVk=;
        b=tN8AK7dZHwSPK1LoZ3scnwdeObORRV2Ts+3x23oXs+qIPLCZl9SKoh33MzmJ4JMw5Z
         gdxI763DPwaXbTX6kubXDhzU008Lbj5E6Zmktg/l7DKvnzYOezhqWxQwJTb7DeiwWP6f
         38NIqZxJrAaYO80n6zG9CmJvFdKXcZHN5HBx1quan5jN/t25GZCQVZDL6/xNzS2Bg2xE
         f8tCh0Exs7EPl/nfnL5odEydL1Z3jdJycXZrf9KtI+XNkRaDA5v+v2zO5CaraQn3kWno
         PXbHVVYdHwhJmrN8KxyjFXhyfe+uEXliUgVOIdHW9aXzT1qGjj+1BcO8jiKCaqldt0qY
         pFGQ==
X-Gm-Message-State: AOAM531ah4BfAvySqYwSzwI0l1Y/90PdVf1vTdnvyious2auf6ZfwAys
        p7+OhUPjiZxE0fOVKb7xAWg=
X-Google-Smtp-Source: ABdhPJw8paYHVGe6bXkXxNa3hQlF1Wu/nMJde4EA2zAbFTBs5JvrfyKDvvpuiu6DMmmLSloPdiO7yA==
X-Received: by 2002:a9d:6d93:: with SMTP id x19mr2822945otp.117.1620895499497;
        Thu, 13 May 2021 01:44:59 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j16sm518333otn.55.2021.05.13.01.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 01:44:58 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 13 May 2021 01:44:57 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Navin Sankar Velliangiri <navin@linumiz.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] hwmon: Add sht4x Temperature and Humidity Sensor
 Driver
Message-ID: <20210513084457.GA2555011@roeck-us.net>
References: <20210513035613.35363-1-navin@linumiz.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210513035613.35363-1-navin@linumiz.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ resending - the previous message had a bad recipient and may have been
  dropped by mailers. Please check your e-mail configuration ]

On Thu, May 13, 2021 at 09:26:09AM +0530, Navin Sankar Velliangiri wrote:
> This patch adds a hwmon driver for the SHT4x Temperature and
> Humidity sensor.
> 
> Signed-off-by: Navin Sankar Velliangiri <navin@linumiz.com>
> 
> Changes in v2:
> 
> * Removed unused macro SHT4X_MIN_POLL_INTERVAL
> * Replaced time_after instead of ktime_after
> * Used goto statements for error handling
> * Hardcoded the interval_time instead of clamp_val().
> 
> Changes in v3:
> 
> * Accept the poll interval if it is greater than SHT4X_MIN_POLL_INTERVAL and
>   return -EINVAL for negative values & less than SHT4X_MIN_POLL_INTERVAL
> * Changed the data type of update_interval and last_updated to long.
> 
> Changes in v4:
> 
> * "update_interval" is long but msecs_to_jiffies() accepts only unsigned int.
>   clamp_val() api is used to assign the update_interval stays within UINT_MAX.
> 
> Changes in v5:
> 
> * Added error handling when master unable to send the data.
> ---
>  Documentation/hwmon/index.rst |   1 +
>  Documentation/hwmon/sht4x.rst |  45 +++++
>  drivers/hwmon/Kconfig         |  11 ++
>  drivers/hwmon/Makefile        |   1 +
>  drivers/hwmon/sht4x.c         | 307 ++++++++++++++++++++++++++++++++++
>  5 files changed, 365 insertions(+)
>  create mode 100644 Documentation/hwmon/sht4x.rst
>  create mode 100644 drivers/hwmon/sht4x.c
> 
> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> index 8d5a2df1ecb6..2a20c6616e21 100644
> --- a/Documentation/hwmon/index.rst
> +++ b/Documentation/hwmon/index.rst
> @@ -160,6 +160,7 @@ Hardware Monitoring Kernel Drivers
>     sht15
>     sht21
>     sht3x
> +   sht4x
>     shtc1
>     sis5595
>     sl28cpld
> diff --git a/Documentation/hwmon/sht4x.rst b/Documentation/hwmon/sht4x.rst
> new file mode 100644
> index 000000000000..3b37abcd4a46
> --- /dev/null
> +++ b/Documentation/hwmon/sht4x.rst
> @@ -0,0 +1,45 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +Kernel driver sht4x
> +===================
> +
> +Supported Chips:
> +
> +  * Sensirion SHT4X
> +
> +    Prefix: 'sht4x'
> +
> +    Addresses scanned: None
> +
> +    Datasheet:
> +
> +      English: https://www.sensirion.com/fileadmin/user_upload/customers/sensirion/Dokumente/2_Humidity_Sensors/Datasheets/Sensirion_Humidity_Sensors_SHT4x_Datasheet.pdf
> +
> +Author: Navin Sankar Velliangiri <navin@linumiz.com>
> +
> +
> +Description
> +-----------
> +
> +This driver implements support for the Sensirion SHT4x chip, a humidity
> +and temperature sensor. Temperature is measured in degree celsius, relative
> +humidity is expressed as a percentage. In sysfs interface, all values are
> +scaled by 1000, i.e. the value for 31.5 degrees celsius is 31500.
> +
> +Usage Notes
> +-----------
> +
> +The device communicates with the I2C protocol. Sensors can have the I2C
> +address 0x44. See Documentation/i2c/instantiating-devices.rst for methods
> +to instantiate the device.
> +
> +Sysfs entries
> +-------------
> +
> +=============== ============================================
> +temp1_input     Measured temperature in millidegrees Celcius
> +humidity1_input Measured humidity in %H
> +update_interval The minimum interval for polling the sensor,
> +                in milliseconds. Writable. Must be at least
> +                2000.
> +============== =============================================
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 54f04e61fb83..0640e510f3c8 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1583,6 +1583,17 @@ config SENSORS_SHT3x
>  	  This driver can also be built as a module. If so, the module
>  	  will be called sht3x.
>  
> +config SENSORS_SHT4x
> +	tristate "Sensiron humidity and temperature sensors. SHT4x and compat."
> +	depends on I2C
> +	select CRC8
> +	help
> +	  If you say yes here you get support for the Sensiron SHT40, SHT41 and
> +	  SHT45 humidity and temperature sensors.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called sht4x.
> +
>  config SENSORS_SHTC1
>  	tristate "Sensiron humidity and temperature sensors. SHTC1 and compat."
>  	depends on I2C
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index fe38e8a5c979..62cee3e03c7f 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -170,6 +170,7 @@ obj-$(CONFIG_SENSORS_SL28CPLD)	+= sl28cpld-hwmon.o
>  obj-$(CONFIG_SENSORS_SHT15)	+= sht15.o
>  obj-$(CONFIG_SENSORS_SHT21)	+= sht21.o
>  obj-$(CONFIG_SENSORS_SHT3x)	+= sht3x.o
> +obj-$(CONFIG_SENSORS_SHT4x)	+= sht4x.o
>  obj-$(CONFIG_SENSORS_SHTC1)	+= shtc1.o
>  obj-$(CONFIG_SENSORS_SIS5595)	+= sis5595.o
>  obj-$(CONFIG_SENSORS_SMM665)	+= smm665.o
> diff --git a/drivers/hwmon/sht4x.c b/drivers/hwmon/sht4x.c
> new file mode 100644
> index 000000000000..e1602dc794fb
> --- /dev/null
> +++ b/drivers/hwmon/sht4x.c
> @@ -0,0 +1,307 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +/*
> + * Copyright (c) Linumiz 2021
> + *
> + * sht4x.c - Linux hwmon driver for SHT4x Temperature and Humidity sensor
> + *
> + * Author: Navin Sankar Velliangiri <navin@linumiz.com>
> + */
> +
> +#include <linux/crc8.h>
> +#include <linux/delay.h>
> +#include <linux/hwmon.h>
> +#include <linux/i2c.h>
> +#include <linux/jiffies.h>
> +#include <linux/module.h>
> +
> +/*
> + * Poll intervals (in milliseconds)
> + */
> +#define SHT4X_MIN_POLL_INTERVAL	2000
> +
> +/*
> + * I2C command delays (in microseconds)
> + */
> +#define SHT4X_MEAS_DELAY	1000
> +#define SHT4X_DELAY_EXTRA	10000
> +
> +/*
> + * Command Bytes
> + */
> +#define SHT4X_CMD_MEASURE_HPM	0b11111101
> +#define SHT4X_CMD_RESET		0b10010100
> +
> +#define SHT4X_CMD_LEN		1
> +#define SHT4X_CRC8_LEN		1
> +#define SHT4X_WORD_LEN		2
> +#define SHT4X_RESPONSE_LENGTH	6
> +#define SHT4X_CRC8_POLYNOMIAL	0x31
> +#define SHT4X_CRC8_INIT		0xff
> +#define SHT4X_MIN_TEMPERATURE	-45000
> +#define SHT4X_MAX_TEMPERATURE	125000
> +#define SHT4X_MIN_HUMIDITY	0
> +#define SHT4X_MAX_HUMIDITY	100000
> +
> +DECLARE_CRC8_TABLE(sht4x_crc8_table);
> +
> +/**
> + * struct sht4x_data - All the data required to operate an SHT4X chip
> + * @client: the i2c client associated with the SHT4X
> + * @lock: a mutex that is used to prevent parallel access to the i2c client
> + * @update_interval: the minimum poll interval
> + * @last_updated: the previous time that the SHT4X was polled
> + * @temperature: the latest temperature value received from the SHT4X
> + * @humidity: the latest humidity value received from the SHT4X
> + */
> +struct sht4x_data {
> +	struct i2c_client	*client;
> +	struct mutex		lock;	/* atomic read data updates */
> +	bool			valid;	/* validity of fields below */
> +	long			update_interval;	/* in milli-seconds */
> +	long			last_updated;	/* in jiffies */
> +	s32			temperature;
> +	s32			humidity;
> +};
> +
> +/**
> + * sht4x_read_values() - read and parse the raw data from the SHT4X
> + * @sht4x_data: the struct sht4x_data to use for the lock
> + * Return: 0 if succesfull, 1 if not
> + */
> +static int sht4x_read_values(struct sht4x_data *data)
> +{
> +	int ret;
> +	u16 t_ticks, rh_ticks;
> +	unsigned long next_update;
> +	struct i2c_client *client = data->client;
> +	u8 crc, raw_data[SHT4X_RESPONSE_LENGTH],
> +	cmd[] = {SHT4X_CMD_MEASURE_HPM};
> +
> +	mutex_lock(&data->lock);
> +	next_update = data->last_updated +
> +		      msecs_to_jiffies(data->update_interval);
> +	if (!data->valid || time_after(jiffies, next_update)) {
> +		ret = i2c_master_send(client, cmd, SHT4X_CMD_LEN);
> +		if (ret < 0)
> +			goto unlock;
> +
> +		usleep_range(SHT4X_MEAS_DELAY,
> +			     SHT4X_MEAS_DELAY + SHT4X_DELAY_EXTRA);
> +
> +		ret = i2c_master_recv(client, raw_data, SHT4X_RESPONSE_LENGTH);
> +		if (ret != SHT4X_RESPONSE_LENGTH) {
> +			if (ret >= 0)
> +				ret = -ENODATA;
> +
> +			goto unlock;
> +		}
> +
> +		t_ticks = raw_data[0] << 8 | raw_data[1];
> +		rh_ticks = raw_data[3] << 8 | raw_data[4];
> +
> +		crc = crc8(sht4x_crc8_table, &raw_data[0], SHT4X_WORD_LEN, CRC8_INIT_VALUE);
> +		if (crc != raw_data[2]) {
> +			dev_err(&client->dev, "data integrity check failed\n");
> +			ret = -EIO;
> +			goto unlock;
> +		}
> +
> +		crc = crc8(sht4x_crc8_table, &raw_data[3], SHT4X_WORD_LEN, CRC8_INIT_VALUE);
> +		if (crc != raw_data[5]) {
> +			dev_err(&client->dev, "data integrity check failed\n");
> +			ret = -EIO;
> +			goto unlock;
> +		}
> +
> +		data->temperature = ((21875 * (int32_t)t_ticks) >> 13) - 45000;
> +		data->humidity = ((15625 * (int32_t)rh_ticks) >> 13) - 6000;
> +		data->last_updated = jiffies;
> +		data->valid = true;
> +	}
> +
> +unlock:
> +	mutex_unlock(&data->lock);
> +	return ret;
> +}
> +
> +static ssize_t sht4x_interval_write(struct sht4x_data *data,
> +				    long val)
> +{
> +	if (val < SHT4X_MIN_POLL_INTERVAL)
> +		return -EINVAL;
> +

I don't see the point of rejecting small values (and expecting the user
to know what the minimum value is).

From sysfs ABI:

"What to do if a value is found to be invalid, depends on the type of the
sysfs attribute that is being set. If it is a continuous setting like a
tempX_max or inX_max attribute, then the value should be clamped to its
limits using clamp_val(value, min_limit, max_limit). If it is not continuous
like for example a tempX_type, then when an invalid value is written,
-EINVAL should be returned."

> +
> +     data->update_interval = clamp_val(val, SHT4X_MIN_POLL_INTERVAL,
> +                                       UINT_MAX);

Please keep it simple and just use clamp_val(). I really do not understand
why we have to keep arguing about this. Do I need to clarify the ABI
document to make it easier to understand ? How do I need to phrase
it to explain more clearly what should be done here ?

Thanks,
Guenter

> +
> +	return 0;
> +}
> +
> +/**
> + * sht4x_interval_read() - read the minimum poll interval
> + *			   in milliseconds
> + */
> +static size_t sht4x_interval_read(struct sht4x_data *data,
> +				  long *val)
> +{
> +	*val = data->update_interval;
> +	return 0;
> +}
> +
> +/**
> + * sht4x_temperature1_read() - read the temperature in millidegrees
> + */
> +static int sht4x_temperature1_read(struct sht4x_data *data, long *val)
> +{
> +	int ret;
> +
> +	ret = sht4x_read_values(data);
> +	if (ret < 0)
> +		return ret;
> +
> +	*val = data->temperature;
> +
> +	return 0;
> +}
> +
> +/**
> + * sht4x_humidity1_read() - read a relative humidity in millipercent
> + */
> +static int sht4x_humidity1_read(struct sht4x_data *data, long *val)
> +{
> +	int ret;
> +
> +	ret = sht4x_read_values(data);
> +	if (ret < 0)
> +		return ret;
> +
> +	*val = data->humidity;
> +
> +	return 0;
> +}
> +
> +static umode_t sht4x_hwmon_visible(const void *data,
> +				   enum hwmon_sensor_types type,
> +				   u32 attr, int channel)
> +{
> +	switch (type) {
> +	case hwmon_temp:
> +	case hwmon_humidity:
> +		return 0444;
> +	case hwmon_chip:
> +		return 0644;
> +	default:
> +		return 0;
> +	}
> +}
> +
> +static int sht4x_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
> +			    u32 attr, int channel, long *val)
> +{
> +	struct sht4x_data *data = dev_get_drvdata(dev);
> +
> +	switch (type) {
> +	case hwmon_temp:
> +		return sht4x_temperature1_read(data, val);
> +	case hwmon_humidity:
> +		return sht4x_humidity1_read(data, val);
> +	case hwmon_chip:
> +		return sht4x_interval_read(data, val);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static int sht4x_hwmon_write(struct device *dev, enum hwmon_sensor_types type,
> +			     u32 attr, int channel, long val)
> +{
> +	struct sht4x_data *data = dev_get_drvdata(dev);
> +
> +	switch (type) {
> +	case hwmon_chip:
> +		return sht4x_interval_write(data, val);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static const struct hwmon_channel_info *sht4x_info[] = {
> +	HWMON_CHANNEL_INFO(chip, HWMON_C_UPDATE_INTERVAL),
> +	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT),
> +	HWMON_CHANNEL_INFO(humidity, HWMON_H_INPUT),
> +	NULL,
> +};
> +
> +static const struct hwmon_ops sht4x_hwmon_ops = {
> +	.is_visible = sht4x_hwmon_visible,
> +	.read = sht4x_hwmon_read,
> +	.write = sht4x_hwmon_write,
> +};
> +
> +static const struct hwmon_chip_info sht4x_chip_info = {
> +	.ops = &sht4x_hwmon_ops,
> +	.info = sht4x_info,
> +};
> +
> +static int sht4x_probe(struct i2c_client *client,
> +		       const struct i2c_device_id *sht4x_id)
> +{
> +	struct device *device = &client->dev;
> +	struct device *hwmon_dev;
> +	struct sht4x_data *data;
> +	u8 cmd[] = {SHT4X_CMD_RESET};
> +	int ret;
> +
> +	/*
> +	 * we require full i2c support since the sht4x uses multi-byte read and
> +	 * writes as well as multi-byte commands which are not supported by
> +	 * the smbus protocol
> +	 */
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
> +		return -EOPNOTSUPP;
> +
> +	data = devm_kzalloc(device, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->update_interval = SHT4X_MIN_POLL_INTERVAL;
> +	data->client = client;
> +
> +	mutex_init(&data->lock);
> +
> +	crc8_populate_msb(sht4x_crc8_table, SHT4X_CRC8_POLYNOMIAL);
> +
> +	ret = i2c_master_send(client, cmd, SHT4X_CMD_LEN);
> +	if (ret < 0)
> +		return ret;
> +	if (ret != SHT4X_CMD_LEN)
> +		return -EIO;
> +
> +	hwmon_dev = devm_hwmon_device_register_with_info(device,
> +							 client->name,
> +							 data,
> +							 &sht4x_chip_info,
> +							 NULL);
> +
> +	return PTR_ERR_OR_ZERO(hwmon_dev);
> +}
> +
> +static const struct i2c_device_id sht4x_id[] = {
> +	{ "sht4x", 0 },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(i2c, sht4x_id);
> +
> +static struct i2c_driver sht4x_driver = {
> +	.driver = {
> +		.name = "sht4x",
> +	},
> +	.probe		= sht4x_probe,
> +	.id_table	= sht4x_id,
> +};
> +
> +module_i2c_driver(sht4x_driver);
> +
> +MODULE_AUTHOR("Navin Sankar Velliangiri <navin@linumiz.com>");
> +MODULE_DESCRIPTION("Sensirion SHT4x humidity and temperature sensor driver");
> +MODULE_LICENSE("GPL v2");
