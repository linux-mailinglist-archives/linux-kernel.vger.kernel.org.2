Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01B2838DB57
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 16:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbhEWODI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 10:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbhEWODH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 10:03:07 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2FFCC061574;
        Sun, 23 May 2021 07:01:39 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id i23-20020a9d68d70000b02902dc19ed4c15so22737614oto.0;
        Sun, 23 May 2021 07:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=85o3ARCeqv2WoUzy+YD0a4MS1G1Bt9v4SZegPWpN42Q=;
        b=e9nT41xKFA1VVvio8EXZYbERREMUAKZGf2lciPVimf3O7vMMnogP6i61r7syPsGiGT
         cCYjhPCJny6k7Zff6kY7JR3oK42LXDMMlgd8/7RNUdWu8aPqO9ZNnbWrmIuaEfZoXC+O
         qh+9WqbOpeC3VZ1zLZfwyhB4GtLLwlJ8ERDjhTu8XkzXeFQjSk26fmCs2gV9gRolDE9x
         BFcL3ZFeEWaYrC8rddA5WQ2qNq1dNSSI2yDWyvT+mA7sQyYJdrdLCuI3EB6fBLyQBPkA
         SA5XCeEhkDoK4o7STv8zZVDSlNx9P5tHR9mwkSbrgfD4RNtYQnB/4u4SM0rS20P9hKPn
         5Bpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=85o3ARCeqv2WoUzy+YD0a4MS1G1Bt9v4SZegPWpN42Q=;
        b=BqiNLtWssNTPI1YFBZq5g+/7dM/WBNNa9nSCfiHDNF9keElsu6htTqtHEzmNEFXgnp
         ezdwKVb+PzBZNSgoW0Zyc6BTIs+z41dT9Ce+ZeYbRyPmG38IbXCIvZzRpG0Wo2+p24ve
         qOmvxg8zWvElDdNAe4pdprxTVycu7lPRZSwASy6pjidXQP2slrBsdw5OkUL7npBuOYJl
         3CtBNncN09RLSNIHcP1uF4WIzJicdMO8NmUHQbyaVv9jb0ocSzZhO6/mrBuwzAVxcuDF
         QoDxeRq1mWWcoNC/4niLZd9eg2zBZ+/I4Vp3/88xnKpv9f49/9Uff/5xOoDjzKG1G6Hj
         EaLQ==
X-Gm-Message-State: AOAM5335nGjohC0iQ6CMVAktytGxtw+VwwaiwNEJlRF2Tky+UfO0mZH4
        qUjIKvVxRnoYoTvTY04s8gnKbIt8IyY=
X-Google-Smtp-Source: ABdhPJxsnAQt+C9UddHKLBRD/OpEde33r956A2yxo0CyLzV4QBxpF2ZS6QOwZ3APLDo7DL82nOjkWw==
X-Received: by 2002:a9d:600d:: with SMTP id h13mr14912988otj.259.1621778498053;
        Sun, 23 May 2021 07:01:38 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p1sm2567620otk.58.2021.05.23.07.01.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 May 2021 07:01:37 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v6] hwmon: Add sht4x Temperature and Humidity Sensor
 Driver
To:     Navin Sankar Velliangiri <navin@linumiz.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210522060917.41256-1-navin@linumiz.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <0fdb63a8-f353-cbcb-b97b-b54ab2da9d7f@roeck-us.net>
Date:   Sun, 23 May 2021 07:01:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210522060917.41256-1-navin@linumiz.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/21/21 11:09 PM, Navin Sankar Velliangiri wrote:
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

Ah yes, the value of ret will be uninitialized, and the function will return
a random value if data->valid is false or if two measurements follow each other.

Please fix and resubmit. The driver looks good otherwise.

Guenter
