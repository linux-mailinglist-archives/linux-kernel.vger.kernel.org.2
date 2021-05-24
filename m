Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4DCB38E84F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 16:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232942AbhEXOKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 10:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232462AbhEXOKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 10:10:35 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50C6C061574;
        Mon, 24 May 2021 07:09:07 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id c196so18954968oib.9;
        Mon, 24 May 2021 07:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=o7CLir1PLpSoekN7HG+8aA3BrPc01kxQajb9KjLV5l4=;
        b=tEju27IHwOw6efgYeLMuBKQncK+4X3DyXW/zeSO/V1OkNbYFV/NwLJveOGUekswyna
         z3xj9R3y09rxxMUNsf1EwIAymuhVpxXnov3uZpdSDX648CHSBk9iVYZIPlZCKTAQhn2k
         V7MeX4W39IZ+2If2sInL9lCQLdJT4nSpf5/fViLm1r5IVU+9NmYbyca5R3+wiEo72OG3
         Zdu0cbzUcIkV8j23WYmst2dhLCjmNmTqRlbjzLumB79x/JL8imrbROFWZajIZCDhRqHC
         Gnsl7EXBftMup+dQEej2pa6qG7Tf71Se4RsB/FEpzHx8sCZAVzdyjUjDU3xqSQmvHMtb
         WXRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=o7CLir1PLpSoekN7HG+8aA3BrPc01kxQajb9KjLV5l4=;
        b=iYq7+QaiSPVLkn0XXoGN7Psly7YDDuZyUrhIwUJBvsUuDqOYvcTWZSlRXrBJofm0DA
         ebJdmz57bIQB7mWznLYnqoJPhmRBLi3s3o84QlCjsefQsaq29Ed6QLd6l0B24J/lG9xB
         zEAG3/3n8EGVfPX4iJSOeuxJ4h9KQZPY8KiONn1vXpk7bLRR2wHbV4UFi+stPaHIHjRs
         sbOchC2Jxc5ByHtAa1TqcerUPB+9tEka8Wk6qBzRiQuJS6hGqcVTkfyeHVZbrDqFsyBM
         pausakp3CPM6BtowExkZJ5bTxIu3zHSpYJ8Vs4yQ7yCgycO6zhG/Gj5b1Xk93v8lGBz2
         yXLQ==
X-Gm-Message-State: AOAM5325F4BEXEkwdAgLFEp9U2fHjzq7EhWH1r0N2y3s3WVLY6OXAHpz
        lvJeVgFiMHfjMfS2lGDSzo5lak6aM18=
X-Google-Smtp-Source: ABdhPJzgz3pU39JQUzGqVImlOvQ1V/Zg32t/Us+gwAIjc4mp6rL/PgYC3mDTlmbr6YMUYb1b2LXwng==
X-Received: by 2002:a05:6808:128b:: with SMTP id a11mr10775351oiw.88.1621865347239;
        Mon, 24 May 2021 07:09:07 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 129sm2814742ooq.34.2021.05.24.07.09.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 May 2021 07:09:06 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v7] hwmon: Add sht4x Temperature and Humidity Sensor
 Driver
To:     Navin Sankar Velliangiri <navin@linumiz.com>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     jdelvare@suse.com, corbet@lwn.net
References: <20210524100425.64052-1-navin@linumiz.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <8ae3dac2-54d5-d64c-cc9b-d1e661d6a4c5@roeck-us.net>
Date:   Mon, 24 May 2021 07:09:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210524100425.64052-1-navin@linumiz.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/24/21 3:04 AM, Navin Sankar Velliangiri wrote:
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
>    return -EINVAL for negative values & less than SHT4X_MIN_POLL_INTERVAL
> * Changed the data type of update_interval and last_updated to long.
> 
> Changes in v4:
> 
> * "update_interval" is long but msecs_to_jiffies() accepts only unsigned int.
>    clamp_val() api is used to assign the update_interval stays within UINT_MAX.
> 
> Changes in v5:
> 
> * Added error handling when master unable to send the data.
> 
> Changes in v6:
> 
> * clamp_val() alone is used to set the update interval. since the update
>    interval is a continuous setting.
> 
> Changes in v7:
> 
> * initialized the ret variable to -EINVAL in sht4x_read_values() function,
>    whenever if condition fail's it return's -EINVAL.

That wasn't the problem; it needs to be initialized with 0.
And you did not actually do it.

Guenter

> ---
>   Documentation/hwmon/index.rst |   1 +
>   Documentation/hwmon/sht4x.rst |  45 +++++
>   drivers/hwmon/Kconfig         |  11 ++
>   drivers/hwmon/Makefile        |   1 +
>   drivers/hwmon/sht4x.c         | 305 ++++++++++++++++++++++++++++++++++
>   5 files changed, 363 insertions(+)
>   create mode 100644 Documentation/hwmon/sht4x.rst
>   create mode 100644 drivers/hwmon/sht4x.c
> 
> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> index 9ed60fa84cbe..b6fcae40258c 100644
> --- a/Documentation/hwmon/index.rst
> +++ b/Documentation/hwmon/index.rst
> @@ -164,6 +164,7 @@ Hardware Monitoring Kernel Drivers
>      sht15
>      sht21
>      sht3x
> +   sht4x
>      shtc1
>      sis5595
>      sl28cpld
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
> index 87624902ea80..e3675377bc5d 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1583,6 +1583,17 @@ config SENSORS_SHT3x
>   	  This driver can also be built as a module. If so, the module
>   	  will be called sht3x.
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
>   config SENSORS_SHTC1
>   	tristate "Sensiron humidity and temperature sensors. SHTC1 and compat."
>   	depends on I2C
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index 59e78bc212cf..d712c61c1f5e 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -171,6 +171,7 @@ obj-$(CONFIG_SENSORS_SL28CPLD)	+= sl28cpld-hwmon.o
>   obj-$(CONFIG_SENSORS_SHT15)	+= sht15.o
>   obj-$(CONFIG_SENSORS_SHT21)	+= sht21.o
>   obj-$(CONFIG_SENSORS_SHT3x)	+= sht3x.o
> +obj-$(CONFIG_SENSORS_SHT4x)	+= sht4x.o
>   obj-$(CONFIG_SENSORS_SHTC1)	+= shtc1.o
>   obj-$(CONFIG_SENSORS_SIS5595)	+= sis5595.o
>   obj-$(CONFIG_SENSORS_SMM665)	+= smm665.o
> diff --git a/drivers/hwmon/sht4x.c b/drivers/hwmon/sht4x.c
> new file mode 100644
> index 000000000000..39e1b4a123fa
> --- /dev/null
> +++ b/drivers/hwmon/sht4x.c
> @@ -0,0 +1,305 @@
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
> +
> +	data->update_interval = clamp_val(val, SHT4X_MIN_POLL_INTERVAL,
> +					  UINT_MAX);
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
> 

