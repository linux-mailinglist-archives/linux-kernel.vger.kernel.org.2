Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB2A3704B8
	for <lists+linux-kernel@lfdr.de>; Sat,  1 May 2021 03:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbhEABow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 21:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbhEABov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 21:44:51 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443C5C06174A;
        Fri, 30 Apr 2021 18:44:02 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id g4-20020a9d6b040000b029029debbbb3ecso195386otp.7;
        Fri, 30 Apr 2021 18:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1Utpx379AVKUAAV9TFD7KKMd/IMdAjVk9AJgNMIUbb8=;
        b=Rfijp+yUmZUl92GcKutWJcB78e52S7rPVrCdTjcF6jy9lED+8qNkFo89SOCMpapida
         0RB54Fx/LzRuHcfNFWuqnIQFNvx3d6zeJpb6LBHifKyWIsi3mf8KwrL8fndX1rGDnGEQ
         VO6wbehHfi9WJqiOYyjnydFHHDR9n/Y+C2AclbmC40LtSQsspgrWZZHeRwrBsjCQyth3
         kREViX2Y8DoY7DZnOvraoLm6dSaGF47VLSnSBCxndRbv53XmwAYlzNVEYlfuVWevaKW5
         YoHYD6o76Aw838S5bAWNdpi4ABVnmkfqHLu8LJfG8ZwqsmuN1+gaQAKaENXLjbsqfiZn
         NpsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1Utpx379AVKUAAV9TFD7KKMd/IMdAjVk9AJgNMIUbb8=;
        b=THkO7JkM1goAnVuhg+E4GuA5VnJL9Cxe6Q+17Q4O11L0X7+iybZ4zA3CqjeU6M4lcz
         dYuwk+QobW1oQvCEbXZzqTpFciEdivAjFXk7VblQPS8uJbrayUk1hsKerQu73Q8TFGPp
         V+255nWASQ1SqQVlqNTBmllNUqn87TW6z1+QFMBbyNp5m2MAmpWmlXzdtUcNo4CHsxUJ
         pLy+JMoj8tFCey2ZWGCkXNRiiB+hmTYFYNASl8y2xBHykUKb8SNWW3mgmF4i8QBVZLq4
         izTcWjKR95vw1OhttZpVLwBK0iLZFqX4H26TTB0TuprB5zjLEng6S2jEljltD4mH2O/B
         2Vhw==
X-Gm-Message-State: AOAM530wrgw19IxurgufDRBIyY9kyQc4044uxuRHR9pjTLpkChiw+ssV
        dtKne7eO4U8YdfowKKt9G9ZbVGDm8Ig=
X-Google-Smtp-Source: ABdhPJy2Xqpw39G6MRbwOwoyRzPJ5BmJSTJsdPFRgEfMfcF8R5J/zvbjvJ9uiRnTkXmgreeY+nzM+g==
X-Received: by 2002:a9d:479a:: with SMTP id b26mr5930925otf.180.1619833441056;
        Fri, 30 Apr 2021 18:44:01 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x24sm1133026otk.16.2021.04.30.18.43.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Apr 2021 18:44:00 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Navin Sankar Velliangiri <navin@linumiz.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210429022058.106757-1-navin@linumiz.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] hwmon: Add sht4x Temperature and Humidity Sensor Driver
Message-ID: <745c6a96-11fe-e70c-3658-f6f6880f188a@roeck-us.net>
Date:   Fri, 30 Apr 2021 18:43:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210429022058.106757-1-navin@linumiz.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/28/21 7:20 PM, Navin Sankar Velliangiri wrote:
> This patch adds a hwmon driver for the SHT4x Temperature and
> Humidity sensor.
> 
> Signed-off-by: Navin Sankar Velliangiri <navin@linumiz.com>
> ---
>  Documentation/hwmon/index.rst |   1 +
>  Documentation/hwmon/sht4x.rst |  45 +++++
>  drivers/hwmon/Kconfig         |  13 +-
>  drivers/hwmon/Makefile        |   1 +
>  drivers/hwmon/sht4x.c         | 312 ++++++++++++++++++++++++++++++++++
>  5 files changed, 371 insertions(+), 1 deletion(-)
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
> index 54f04e61fb83..ad10469d7b13 100644
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
> +	  If you say yes here you get support for thr Sensiron SHT40, SHT41 and
> +	  SHT45 humidity and temperature sensors.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called sht4x.
> +
>  config SENSORS_SHTC1
>  	tristate "Sensiron humidity and temperature sensors. SHTC1 and compat."
>  	depends on I2C
> @@ -1798,7 +1809,7 @@ config SENSORS_ADS7871
>  
>  config SENSORS_AMC6821
>  	tristate "Texas Instruments AMC6821"
> -	depends on I2C 
> +	depends on I2C
>  	help
>  	  If you say yes here you get support for the Texas Instruments
>  	  AMC6821 hardware monitoring chips.
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
> index 000000000000..439ccdabb30c
> --- /dev/null
> +++ b/drivers/hwmon/sht4x.c
> @@ -0,0 +1,312 @@
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
> +#include <linux/module.h>
> +#include <linux/ktime.h>
> +
> +/*
> + * Poll intervals (in milliseconds)
> + */
> +#define SHT4X_DEFAULT_MIN_POLL_INTERVAL	2000
> +#define SHT4X_MIN_POLL_INTERVAL		2000
> +

You have those two defines, both the same, and then you use 2000
directly below in the code. One define please, and please use it everywhere.

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
> + * @min_poll_interval: the minimum poll interval
> + * @previous_poll_time: the previous time that the SHT4X was polled
> + * @temperature: the latest temperature value received from the SHT4X
> + * @humidity: the latest humidity value received from the SHT4X
> + */
> +struct sht4x_data {
> +	struct i2c_client *client;
> +	/*
> +	 * Prevent simultaneous access to the i2c client
> +	 */
> +	struct mutex lock;
> +	ktime_t min_poll_interval;
> +	ktime_t previous_poll_time;
> +	s32 temperature;
> +	s32 humidity;
> +};
> +
> +/**
> + * sht4x_polltime_expired() - check if the minimum poll interval has expired
> + * @data: the data containing the time to compare
> + * Return: 1 if the minimum poll interval has expired, 0 if not
> + */
> +static bool sht4x_polltime_expired(struct sht4x_data *data)
> +{
> +	ktime_t current_time = ktime_get_boottime();
> +	ktime_t difference = ktime_sub(current_time, data->previous_poll_time);
> +
> +	return ktime_after(difference, data->min_poll_interval);

Any reason for using ktime and not a simple
	time_after(jiffies, data->previous_poll_time + data->min_poll_interval)
combined with
	data->previous_poll_time = jiffies;
?

I don't really see value in the additional complexity.

> +}
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
> +	struct i2c_client *client = data->client;
> +	u8 crc, raw_data[SHT4X_RESPONSE_LENGTH],
> +	cmd[] = {SHT4X_CMD_MEASURE_HPM};
> +
> +	mutex_lock(&data->lock);
> +	if (sht4x_polltime_expired(data)) {> +		ret = i2c_master_send(client, cmd, SHT4X_CMD_LEN);
> +		if (ret < 0) {
> +			mutex_unlock(&data->lock);
> +			return ret;
> +		}
> +
> +		usleep_range(SHT4X_MEAS_DELAY,
> +			     SHT4X_MEAS_DELAY + SHT4X_DELAY_EXTRA);
> +
> +		ret = i2c_master_recv(client, raw_data, SHT4X_RESPONSE_LENGTH);
> +		if (ret != SHT4X_RESPONSE_LENGTH) {
> +			mutex_unlock(&data->lock);
> +			if (ret >= 0)
> +				return -ENODATA;
> +			else
> +				return ret;
> +		}
> +
> +		t_ticks = raw_data[0] << 8 | raw_data[1];
> +		rh_ticks = raw_data[3] << 8 | raw_data[4];
> +
> +		crc = crc8(sht4x_crc8_table, &raw_data[0], SHT4X_WORD_LEN, CRC8_INIT_VALUE);
> +		if (crc != raw_data[2]) {
> +			mutex_unlock(&data->lock);
> +			dev_err(&client->dev, "data integrity check failed\n");
> +			return -EIO;

Please use goto unlock; for error handling.

> +		}
> +
> +		crc = crc8(sht4x_crc8_table, &raw_data[3], SHT4X_WORD_LEN, CRC8_INIT_VALUE);
> +		if (crc != raw_data[5]) {
> +			mutex_unlock(&data->lock);
> +			dev_err(&client->dev, "data integrity check failed\n");
> +			return -EIO;
> +		}
> +
> +		data->temperature = ((21875 * (int32_t)t_ticks) >> 13) - 45000;
> +		data->humidity = ((15625 * (int32_t)rh_ticks) >> 13) - 6000;
> +		data->previous_poll_time = ktime_get_boottime();
> +	}
> +
unlock:

> +	mutex_unlock(&data->lock);
> +	return 0;
> +}
> +
> +static ssize_t sht4x_interval_write(struct sht4x_data *data,
> +				    long val)
> +{
> +	data->min_poll_interval = ms_to_ktime(clamp_val(val, 2000, LONG_MAX));

Does a maximum poll interval of LONG_MAX milliseconds really make sense ?

Also, is this needed/useful in the first place to make this configurable ?
What is the rationale ?

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
> +	*val = ktime_to_ms(data->min_poll_interval);
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
> +	data->min_poll_interval = ms_to_ktime(SHT4X_DEFAULT_MIN_POLL_INTERVAL);
> +	data->client = client;
> +
> +	mutex_init(&data->lock);
> +
> +	crc8_populate_msb(sht4x_crc8_table, SHT4X_CRC8_POLYNOMIAL);
> +
> +	ret = i2c_master_send(client, cmd, SHT4X_CMD_LEN);
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

