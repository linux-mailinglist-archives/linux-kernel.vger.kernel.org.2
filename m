Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94D79364DA7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 00:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbhDSW31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 18:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhDSW30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 18:29:26 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E390C06174A;
        Mon, 19 Apr 2021 15:28:54 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id i3-20020a4ad3830000b02901ef20f8cae8so783353oos.11;
        Mon, 19 Apr 2021 15:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=B5rDePvRaj5NS7N94Zu08Mt3EJMdzkxJrQGLwb882Mg=;
        b=qSd39FxZ7/QvUAMYsUj6L54OoSP8MLbS8n8wvmjWQaYhjWD/jDOU0YkDF5URCcq/nu
         hGhrUl9A4m9zYps34zvKaVYf7xunx/3eD1BjiflUpOpopRsW8sGTwWAwaVLsPewUlBr+
         GHbEJO2eAakwL162R5+WRnIsiFpZ+wChGwojrqgwszuBuqNlhe8AT/T3VNOm5mDVAOja
         9yVpkkNF2aDSSRETdKFsR4KY3z7a/g6uEcM4aGmojegdLgdb1Ed44EHqPpCzRg3XbjnK
         T9dJJQ88a9IUMe6GKO0X7z4VcdWpjVSmErhRttgKhQjaEyeUAVRF14Mvb7gRZ1iD3KTH
         mW9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=B5rDePvRaj5NS7N94Zu08Mt3EJMdzkxJrQGLwb882Mg=;
        b=j1N4CUpMI0F799QRbyWoh+RGZBz0guS35pKMZcwb5LO4dfxxlGsAesvv1ChU2mFhV8
         MJ2bkZvBnXwlibPfeOdVeYRpClZZzwVGmokqjGgPx6/rvneDdtDYVkm8fizodq2OOajL
         RTEXvakccECkyEO9DwYfK+9r0DM0WwxVMJ1gGh+30qQ1Qn2A7+mCfzGvlCVRs+5ANDRa
         CrdskSSta48DqpznSXqTuKxcIWxyqcRnTKD1q8YAZrjS+mFgR7SPk0YXAxqmBFo54faC
         CePXKdKI492+NC3gtRAL0Tm1EY+Ji84jBCdWTvTejhis62y8yQHsvsAYAK/GCrwPqLI6
         vCLw==
X-Gm-Message-State: AOAM533VgRuA5iPndtuhCNAOyYcjQY5fTKCuWTMgCP/ocokojzb+u9dy
        53UNB9UVbyVsl9xRToyMcDHpl+ZYHPY=
X-Google-Smtp-Source: ABdhPJwyJswY+nOjQlxMWz6YdQBoKDRgKJB0VyIQ9dcVQ2Yzf9wuS7NoSlOxir8am2DxE2LUY8gE5g==
X-Received: by 2002:a4a:9f45:: with SMTP id d5mr11344395ool.91.1618871333487;
        Mon, 19 Apr 2021 15:28:53 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2sm3787243otl.48.2021.04.19.15.28.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Apr 2021 15:28:51 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 19 Apr 2021 15:28:49 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Erik Rosen <erik.rosen@metormote.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (pmbus/max15301) Add pmbus driver for MAX15301
Message-ID: <20210419222849.GA229037@roeck-us.net>
References: <20210419101251.24840-1-erik.rosen@metormote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210419101251.24840-1-erik.rosen@metormote.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19, 2021 at 12:12:51PM +0200, Erik Rosen wrote:
> Add pmbus driver support for Maxim MAX15301 InTune Automatically
> Compensated Digital PoL Controller with Driver and PMBus Telemetry
> 
> Even though the specification does not specifically mention it,
> extensive empirical testing has revealed that auto-detection of
> limit-registers will fail in a random fashion unless the delay
> parameter is set to above about 80us. The default delay is set
> to 100us to include some safety margin.
> 
> This patch is tested on a Flex BMR461 converter module.
> 
> Signed-off-by: Erik Rosen <erik.rosen@metormote.com>

Applied. Note that I added above rationale to the driver header.

> ---
>  Documentation/hwmon/index.rst    |   1 +
>  Documentation/hwmon/max15301.rst |  87 +++++++++++++++
>  MAINTAINERS                      |   7 ++
>  drivers/hwmon/pmbus/Kconfig      |   9 ++
>  drivers/hwmon/pmbus/Makefile     |   1 +
>  drivers/hwmon/pmbus/max15301.c   | 183 +++++++++++++++++++++++++++++++
>  6 files changed, 288 insertions(+)
>  create mode 100644 Documentation/hwmon/max15301.rst
>  create mode 100644 drivers/hwmon/pmbus/max15301.c
> 
> 
> base-commit: 1e28eed17697bcf343c6743f0028cc3b5dd88bf0
> 
> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> index 8d5a2df1ecb6..6583a1ea76cb 100644
> --- a/Documentation/hwmon/index.rst
> +++ b/Documentation/hwmon/index.rst
> @@ -112,6 +112,7 @@ Hardware Monitoring Kernel Drivers
>     ltc4260
>     ltc4261
>     max127
> +   max15301
>     max16064
>     max16065
>     max1619
> diff --git a/Documentation/hwmon/max15301.rst b/Documentation/hwmon/max15301.rst
> new file mode 100644
> index 000000000000..e3dc22fe1c6d
> --- /dev/null
> +++ b/Documentation/hwmon/max15301.rst
> @@ -0,0 +1,87 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +Kernel driver max15301
> +======================
> +
> +Supported chips:
> +
> +  * Maxim MAX15301
> +
> +    Prefix: 'max15301', 'bmr461'
> +
> +    Addresses scanned: -
> +
> +    Datasheet: https://datasheets.maximintegrated.com/en/ds/MAX15301.pdf
> +
> +Author: Erik Rosen <erik.rosen@metormote.com>
> +
> +
> +Description
> +-----------
> +
> +This driver supports hardware monitoring for Maxim MAX15301 controller chip and
> +compatible modules.
> +
> +The driver is a client driver to the core PMBus driver. Please see
> +Documentation/hwmon/pmbus.rst and Documentation.hwmon/pmbus-core for details
> +on PMBus client drivers.
> +
> +
> +Usage Notes
> +-----------
> +
> +This driver does not auto-detect devices. You will have to instantiate the
> +devices explicitly. Please see Documentation/i2c/instantiating-devices.rst for
> +details.
> +
> +
> +Platform data support
> +---------------------
> +
> +The driver supports standard PMBus driver platform data.
> +
> +
> +Module parameters
> +-----------------
> +
> +delay
> +-----
> +
> +The controller requires a minimum interval between I2C bus accesses.
> +The default interval is set to 100 us. For manual override, the driver
> +provides a writeable module parameter, 'delay', which can be used to
> +set the interval to a value between 0 and 65,535 microseconds.
> +
> +
> +Sysfs entries
> +-------------
> +
> +The following attributes are supported. Limits are read-write; all other
> +attributes are read-only.
> +
> +======================= ========================================================
> +in1_label		"vin"
> +in1_input		Measured input voltage.
> +in1_lcrit		Critical minimum input voltage.
> +in1_crit		Critical maximum input voltage.
> +in1_lcrit_alarm		Input voltage critical low alarm.
> +in1_crit_alarm		Input voltage critical high alarm.
> +
> +in2_label		"vout1"
> +in2_input		Measured output voltage.
> +in2_lcrit		Critical minimum output Voltage.
> +in2_crit		Critical maximum output voltage.
> +in2_lcrit_alarm		Critical output voltage critical low alarm.
> +in2_crit_alarm		Critical output voltage critical high alarm.
> +
> +curr1_label		"iout1"
> +curr1_input		Measured output current.
> +curr1_crit		Critical maximum output current.
> +curr1_crit_alarm	Output current critical high alarm.
> +
> +temp1_input		Measured maximum temperature of all phases.
> +temp1_max		Maximum temperature limit.
> +temp1_max_alarm		High temperature alarm.
> +temp1_crit		Critical maximum temperature limit.
> +temp1_crit_alarm	Critical maximum temperature alarm.
> +======================= ========================================================
> diff --git a/MAINTAINERS b/MAINTAINERS
> index aa84121c5611..de2ad7223055 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10790,6 +10790,13 @@ S:	Orphan
>  F:	drivers/video/fbdev/matrox/matroxfb_*
>  F:	include/uapi/linux/matroxfb.h
>  
> +MAX15301 DRIVER
> +M:	Daniel Nilsson <daniel.nilsson@flex.com>
> +L:	linux-hwmon@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/hwmon/max15301.rst
> +F:	drivers/hwmon/pmbus/max15301.c
> +
>  MAX16065 HARDWARE MONITOR DRIVER
>  M:	Guenter Roeck <linux@roeck-us.net>
>  L:	linux-hwmon@vger.kernel.org
> diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
> index 32d2fc850621..5c9fb1a88cec 100644
> --- a/drivers/hwmon/pmbus/Kconfig
> +++ b/drivers/hwmon/pmbus/Kconfig
> @@ -148,6 +148,15 @@ config SENSORS_LTC3815
>  	  This driver can also be built as a module. If so, the module will
>  	  be called ltc3815.
>  
> +config SENSORS_MAX15301
> +	tristate "Maxim MAX15301"
> +	help
> +	  If you say yes here you get hardware monitoring support for Maxim
> +	  MAX15301, as well as for Flex BMR461.
> +
> +	  This driver can also be built as a module. If so, the module will
> +	  be called max15301.
> +
>  config SENSORS_MAX16064
>  	tristate "Maxim MAX16064"
>  	help
> diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
> index 6a4ba0fdc1db..6040bc8718e9 100644
> --- a/drivers/hwmon/pmbus/Makefile
> +++ b/drivers/hwmon/pmbus/Makefile
> @@ -17,6 +17,7 @@ obj-$(CONFIG_SENSORS_ISL68137)	+= isl68137.o
>  obj-$(CONFIG_SENSORS_LM25066)	+= lm25066.o
>  obj-$(CONFIG_SENSORS_LTC2978)	+= ltc2978.o
>  obj-$(CONFIG_SENSORS_LTC3815)	+= ltc3815.o
> +obj-$(CONFIG_SENSORS_MAX15301)	+= max15301.o
>  obj-$(CONFIG_SENSORS_MAX16064)	+= max16064.o
>  obj-$(CONFIG_SENSORS_MAX16601)	+= max16601.o
>  obj-$(CONFIG_SENSORS_MAX20730)	+= max20730.o
> diff --git a/drivers/hwmon/pmbus/max15301.c b/drivers/hwmon/pmbus/max15301.c
> new file mode 100644
> index 000000000000..eb9b7a5ef052
> --- /dev/null
> +++ b/drivers/hwmon/pmbus/max15301.c
> @@ -0,0 +1,183 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Hardware monitoring driver for Maxim MAX15301
> + *
> + * Copyright (c) 2021 Flextronics International Sweden AB
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/err.h>
> +#include <linux/slab.h>
> +#include <linux/i2c.h>
> +#include <linux/ktime.h>
> +#include <linux/delay.h>
> +#include <linux/pmbus.h>
> +#include "pmbus.h"
> +
> +static const struct i2c_device_id max15301_id[] = {
> +	{"bmr461", 0},
> +	{"max15301", 0},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, max15301_id);
> +
> +struct max15301_data {
> +	int id;
> +	ktime_t access;		/* Chip access time */
> +	int delay;		/* Delay between chip accesses in us */
> +	struct pmbus_driver_info info;
> +};
> +
> +#define to_max15301_data(x)  container_of(x, struct max15301_data, info)
> +
> +#define MAX15301_WAIT_TIME		100	/* us	*/
> +
> +static ushort delay = MAX15301_WAIT_TIME;
> +module_param(delay, ushort, 0644);
> +MODULE_PARM_DESC(delay, "Delay between chip accesses in us");
> +
> +static struct max15301_data max15301_data = {
> +	.info = {
> +		.pages = 1,
> +		.func[0] = PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT
> +			| PMBUS_HAVE_VIN | PMBUS_HAVE_STATUS_INPUT
> +			| PMBUS_HAVE_TEMP | PMBUS_HAVE_TEMP2
> +			| PMBUS_HAVE_STATUS_TEMP
> +			| PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT,
> +	}
> +};
> +
> +/* This chip needs a delay between accesses */
> +static inline void max15301_wait(const struct max15301_data *data)
> +{
> +	if (data->delay) {
> +		s64 delta = ktime_us_delta(ktime_get(), data->access);
> +
> +		if (delta < data->delay)
> +			udelay(data->delay - delta);
> +	}
> +}
> +
> +static int max15301_read_word_data(struct i2c_client *client, int page,
> +				   int phase, int reg)
> +{
> +	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
> +	struct max15301_data *data = to_max15301_data(info);
> +	int ret;
> +
> +	if (page > 0)
> +		return -ENXIO;
> +
> +	if (reg >= PMBUS_VIRT_BASE)
> +		return -ENXIO;
> +
> +	max15301_wait(data);
> +	ret = pmbus_read_word_data(client, page, phase, reg);
> +	data->access = ktime_get();
> +
> +	return ret;
> +}
> +
> +static int max15301_read_byte_data(struct i2c_client *client, int page, int reg)
> +{
> +	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
> +	struct max15301_data *data = to_max15301_data(info);
> +	int ret;
> +
> +	if (page > 0)
> +		return -ENXIO;
> +
> +	max15301_wait(data);
> +	ret = pmbus_read_byte_data(client, page, reg);
> +	data->access = ktime_get();
> +
> +	return ret;
> +}
> +
> +static int max15301_write_word_data(struct i2c_client *client, int page, int reg,
> +				    u16 word)
> +{
> +	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
> +	struct max15301_data *data = to_max15301_data(info);
> +	int ret;
> +
> +	if (page > 0)
> +		return -ENXIO;
> +
> +	if (reg >= PMBUS_VIRT_BASE)
> +		return -ENXIO;
> +
> +	max15301_wait(data);
> +	ret = pmbus_write_word_data(client, page, reg, word);
> +	data->access = ktime_get();
> +
> +	return ret;
> +}
> +
> +static int max15301_write_byte(struct i2c_client *client, int page, u8 value)
> +{
> +	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
> +	struct max15301_data *data = to_max15301_data(info);
> +	int ret;
> +
> +	if (page > 0)
> +		return -ENXIO;
> +
> +	max15301_wait(data);
> +	ret = pmbus_write_byte(client, page, value);
> +	data->access = ktime_get();
> +
> +	return ret;
> +}
> +
> +static int max15301_probe(struct i2c_client *client)
> +{
> +	int status;
> +	u8 device_id[I2C_SMBUS_BLOCK_MAX + 1];
> +	const struct i2c_device_id *mid;
> +	struct pmbus_driver_info *info = &max15301_data.info;
> +
> +	if (!i2c_check_functionality(client->adapter,
> +				     I2C_FUNC_SMBUS_READ_BYTE_DATA
> +				     | I2C_FUNC_SMBUS_BLOCK_DATA))
> +		return -ENODEV;
> +
> +	status = i2c_smbus_read_block_data(client, PMBUS_IC_DEVICE_ID, device_id);
> +	if (status < 0) {
> +		dev_err(&client->dev, "Failed to read Device Id\n");
> +		return status;
> +	}
> +	for (mid = max15301_id; mid->name[0]; mid++) {
> +		if (!strncasecmp(mid->name, device_id, strlen(mid->name)))
> +			break;
> +	}
> +	if (!mid->name[0]) {
> +		dev_err(&client->dev, "Unsupported device\n");
> +		return -ENODEV;
> +	}
> +
> +	max15301_data.delay = delay;
> +
> +	info->read_byte_data = max15301_read_byte_data;
> +	info->read_word_data = max15301_read_word_data;
> +	info->write_byte = max15301_write_byte;
> +	info->write_word_data = max15301_write_word_data;
> +
> +	return pmbus_do_probe(client, info);
> +}
> +
> +static struct i2c_driver max15301_driver = {
> +	.driver = {
> +		   .name = "max15301",
> +		   },
> +	.probe_new = max15301_probe,
> +	.id_table = max15301_id,
> +};
> +
> +module_i2c_driver(max15301_driver);
> +
> +MODULE_AUTHOR("Erik Rosen <erik.rosen@metormote.com>");
> +MODULE_DESCRIPTION("PMBus driver for Maxim MAX15301");
> +MODULE_LICENSE("GPL");
