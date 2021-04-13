Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0B735E224
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 16:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345533AbhDMO7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 10:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237178AbhDMO70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 10:59:26 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931A0C061574;
        Tue, 13 Apr 2021 07:59:05 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id p6-20020a9d69460000b029028bb7c6ff64so261423oto.10;
        Tue, 13 Apr 2021 07:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6/QcNH0l5zssPXV+dgOUoBHAbh5T2tvtsYlA7VbhPGs=;
        b=ZcnV8gs2AlEMgL9vRCkkUSu6EYuf1cZVbVT3Y+1BBmTNT8xWnPAJwBhGrl9NBaNZDo
         Ybdi+MsCVHqyr/w4z2EqiWbEbQ/i3VgCX9y58VWNfUdJAGFuagxc4+Y9o9XqyQALmjVE
         Av8i5M39ErWigY0NMKSPOzGRVSxSuaCCK6FhDIApR1hF6yoMQdZXgOfulohu4FCW++5d
         QfPaxoJZIuL/gQory8AE4TtbpRFCBLX9IQg+P7usH3a25dnEAkXlVVqZuU1DqUxA5UTR
         IdD3bTIii6G9CuwjOfsiF6EAltk4oYx2mKcEmeRSPeOTVKaDk0K31jFT/Br68s/LQt/y
         QqWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=6/QcNH0l5zssPXV+dgOUoBHAbh5T2tvtsYlA7VbhPGs=;
        b=mSasufBbcDU1qgRU5aXNVsThto3g32qwsVLBltLgiMNgM50FHeJ/xWwSifdX1mVRLZ
         QHVGOCPKuNdPwWKqj0LZB4jo1c9EU51SL6/ANEW0y5aIJMxr+Zf0u9RfUfqm796WSVIi
         TOMXWXvrsvuBgwaXPnxlgJcfeYS3qYQtSLhnHzkbUVNQxeJTOJWnuY7c+dWLEebasYqn
         srFLl7MFIG2Fe2BabNXXQfOED/qV8OPaDCLQ4uONNN6HKE68/Pe0yKHxoi64aN5OFPz7
         eMTNvpv/pK/X8j/SkF69MmVqZkee89GFLZWZ/eNGpfjbSsYt25TVMlt1cwM8j189EgFW
         rpOg==
X-Gm-Message-State: AOAM533hKeSJdIjJBfLWjMVD7sib7rxkPNdc7NxevcLNNotV1WUcHuVl
        8QsxxUwZI/Yi+i2KdVCKUK7QxE/glSQ=
X-Google-Smtp-Source: ABdhPJw/T1WynSGg+KEmyl7XgQqBpO8xWX5HmgxlylBzq7YTr18OaCrGu2ydigDAsFkowk4OVTnBWg==
X-Received: by 2002:a9d:6951:: with SMTP id p17mr15888836oto.206.1618325944342;
        Tue, 13 Apr 2021 07:59:04 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z24sm3524861otp.44.2021.04.13.07.59.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Apr 2021 07:59:03 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v4] hwmon: Add driver for fsp-3y PSUs and PDUs
To:     =?UTF-8?B?VsOhY2xhdiBLdWJlcm7DoXQ=?= <kubernat@cesnet.cz>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210329143833.1047539-1-kubernat@cesnet.cz>
 <20210413104233.1857736-1-kubernat@cesnet.cz>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <43c5cc02-d2ad-ceee-7709-190681b81ae7@roeck-us.net>
Date:   Tue, 13 Apr 2021 07:59:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210413104233.1857736-1-kubernat@cesnet.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/13/21 3:42 AM, Václav Kubernát wrote:
> This patch adds support for these devices:
> - YH-5151E - the PDU
> - YM-2151E - the PSU
> 
> The device datasheet says that the devices support PMBus 1.2, but in my
> testing, a lot of the commands aren't supported and if they are, they
> sometimes behave strangely or inconsistently. For example, writes to the
> PAGE command requires using PEC, otherwise the write won't work and the
> page won't switch, even though, the standard says that PEC is opiotnal.

optional

> On the other hand, writes the SMBALERT don't require PEC. Because of

s/writes the/writes to/ ?

> this, the driver is mostly reverse engineered with the help of a tool
> called pmbus_peek written by David Brownell (and later adopted by my
> colleague Jan Kundrát).
> 
> The device also has some sort of a timing issue when switching pages,
> which is explained further in the code.
> 
> Because of this, the driver support is limited. It exposes only the
> values, that have been tested to work correctly.
> 

You might want to add those details into the driver code, below the
copyright line. It would be more valuable there than in the commit log.

> Signed-off-by: Václav Kubernát <kubernat@cesnet.cz>
> ---
>  Documentation/hwmon/fsp-3y.rst |  26 ++++

Needs to be added to index.rst.

>  drivers/hwmon/pmbus/Kconfig    |  10 ++
>  drivers/hwmon/pmbus/Makefile   |   1 +
>  drivers/hwmon/pmbus/fsp-3y.c   | 239 +++++++++++++++++++++++++++++++++
>  4 files changed, 276 insertions(+)
>  create mode 100644 Documentation/hwmon/fsp-3y.rst
>  create mode 100644 drivers/hwmon/pmbus/fsp-3y.c
> 
> diff --git a/Documentation/hwmon/fsp-3y.rst b/Documentation/hwmon/fsp-3y.rst
> new file mode 100644
> index 000000000000..68a547021846
> --- /dev/null
> +++ b/Documentation/hwmon/fsp-3y.rst
> @@ -0,0 +1,26 @@
> +Kernel driver fsp3y
> +======================
> +Supported devices:
> +  * 3Y POWER YH-5151E
> +  * 3Y POWER YM-2151E
> +
> +Author: Václav Kubernát <kubernat@cesnet.cz>
> +
> +Description
> +-----------
> +This driver implements limited support for two 3Y POWER devices.
> +
> +Sysfs entries
> +-------------
> +in1_input            input voltage
> +in2_input            12V output voltage
> +in3_input            5V output voltage
> +curr1_input          input current
> +curr2_input          12V output current
> +curr3_input          5V output current
> +fan1_input           fan rpm
> +temp1_input          temperature 1
> +temp2_input          temperature 2
> +temp3_input          temperature 3
> +power1_input         input power
> +power2_input         output power
> diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
> index 03606d4298a4..9d12d446396c 100644
> --- a/drivers/hwmon/pmbus/Kconfig
> +++ b/drivers/hwmon/pmbus/Kconfig
> @@ -56,6 +56,16 @@ config SENSORS_BEL_PFE
>  	  This driver can also be built as a module. If so, the module will
>  	  be called bel-pfe.
>  
> +config SENSORS_FSP_3Y
> +	tristate "FSP/3Y-Power power supplies"
> +	help
> +	  If you say yes here you get hardware monitoring support for
> +	  FSP/3Y-Power hot-swap power supplies.
> +	  Supported models: YH-5151E, YM-2151E
> +
> +	  This driver can also be built as a module. If so, the module will
> +	  be called fsp-3y.
> +
>  config SENSORS_IBM_CFFPS
>  	tristate "IBM Common Form Factor Power Supply"
>  	depends on LEDS_CLASS
> diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
> index 6a4ba0fdc1db..bfe218ad898f 100644
> --- a/drivers/hwmon/pmbus/Makefile
> +++ b/drivers/hwmon/pmbus/Makefile
> @@ -8,6 +8,7 @@ obj-$(CONFIG_SENSORS_PMBUS)	+= pmbus.o
>  obj-$(CONFIG_SENSORS_ADM1266)	+= adm1266.o
>  obj-$(CONFIG_SENSORS_ADM1275)	+= adm1275.o
>  obj-$(CONFIG_SENSORS_BEL_PFE)	+= bel-pfe.o
> +obj-$(CONFIG_SENSORS_FSP_3Y)	+= fsp-3y.o
>  obj-$(CONFIG_SENSORS_IBM_CFFPS)	+= ibm-cffps.o
>  obj-$(CONFIG_SENSORS_INSPUR_IPSPS) += inspur-ipsps.o
>  obj-$(CONFIG_SENSORS_IR35221)	+= ir35221.o
> diff --git a/drivers/hwmon/pmbus/fsp-3y.c b/drivers/hwmon/pmbus/fsp-3y.c
> new file mode 100644
> index 000000000000..2185ab119fd2
> --- /dev/null
> +++ b/drivers/hwmon/pmbus/fsp-3y.c
> @@ -0,0 +1,239 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Hardware monitoring driver for FSP 3Y-Power PSUs
> + *
> + * Copyright (c) 2021 Václav Kubernát, CESNET
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include "pmbus.h"
> +
> +#define YM2151_PAGE_12V_LOG	0x00
> +#define YM2151_PAGE_12V_REAL	0x00
> +#define YM2151_PAGE_5VSB_LOG	0x01
> +#define YM2151_PAGE_5VSB_REAL	0x20
> +#define YH5151E_PAGE_12V_LOG	0x00
> +#define YH5151E_PAGE_12V_REAL	0x00
> +#define YH5151E_PAGE_5V_LOG	0x01
> +#define YH5151E_PAGE_5V_REAL	0x10
> +#define YH5151E_PAGE_3V3_LOG	0x02
> +#define YH5151E_PAGE_3V3_REAL	0x11
> +
> +enum chips {
> +	ym2151e,
> +	yh5151e
> +};
> +
> +struct fsp3y_data {
> +	struct pmbus_driver_info info;
> +	int chip;
> +	int page;
> +};
> +
> +#define to_fsp3y_data(x) container_of(x, struct fsp3y_data, info)
> +
> +static int page_log_to_page_real(int page_log, enum chips chip)
> +{
> +	switch (chip) {
> +	case ym2151e:
> +		switch (page_log) {
> +		case YM2151_PAGE_12V_LOG:
> +			return YM2151_PAGE_12V_REAL;
> +		case YM2151_PAGE_5VSB_LOG:
> +			return YM2151_PAGE_5VSB_REAL;
> +		}
> +		return -EINVAL;
> +	case yh5151e:
> +		switch (page_log) {
> +		case YH5151E_PAGE_12V_LOG:
> +			return YH5151E_PAGE_12V_REAL;
> +		case YH5151E_PAGE_5V_LOG:
> +			return YH5151E_PAGE_5V_LOG;
> +		case YH5151E_PAGE_3V3_LOG:
> +			return YH5151E_PAGE_3V3_REAL;
> +		}
> +		return -EINVAL;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int set_page(struct i2c_client *client, int page_log)
> +{
> +	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
> +	struct fsp3y_data *data = to_fsp3y_data(info);
> +	int rv;
> +	int page_real;
> +
> +	if (page_log < 0)
> +		return 0;
> +
> +	page_real = page_log_to_page_real(page_log, data->chip);
> +	if (page_real < 0)
> +		return page_real;
> +
> +	if (data->page != page_real) {
> +		rv = i2c_smbus_write_byte_data(client, PMBUS_PAGE, page_real);
> +		if (rv < 0)
> +			return rv;
> +
> +		data->page = page_real;
> +
> +		/* Testing showed that the device has a timing issue. After

Somehow network subsystem multi-line alignments slipped in.
Not in hwmon, please. I cringe at those; it makes my brain focus on the
comment (because it is asynchronous) instead of the code.

> +		 * setting a page, it takes a while, before the device actually
> +		 * gives the correct values from the correct page. 20 ms was
> +		 * tested to be enough to not give wrong values (15 ms wasn't
> +		 * enough)
> +		 */
> +		usleep_range(20000, 30000);
> +	}
> +
> +	return 0;
> +}
> +
> +static int fsp3y_read_byte_data(struct i2c_client *client, int page, int reg)
> +{
> +	int rv;
> +
> +	rv = set_page(client, page);
> +	if (rv < 0)
> +		return rv;
> +
> +	return i2c_smbus_read_byte_data(client, reg);
> +}
> +
> +static int fsp3y_read_word_data(struct i2c_client *client, int page, int phase, int reg)
> +{
> +	int rv;
> +
> +	/* This masks commands which weren't tested to work correctly. Some of the masked commands
> +	 * return either 0xFFFF. These would probably get tagged as invalid by pmbus_core. Other

s/either// ?

> +	 * ones do return values, which might be useful (that is, they are not 0xFFFF), but their

s/values,/values/

> +	 * encoding is unknown, and so they are unsupported.
> +	 */
> +	switch (reg) {
> +	case PMBUS_READ_FAN_SPEED_1:
> +	case PMBUS_READ_IIN:
> +	case PMBUS_READ_IOUT:
> +	case PMBUS_READ_PIN:
> +	case PMBUS_READ_POUT:
> +	case PMBUS_READ_TEMPERATURE_1:
> +	case PMBUS_READ_TEMPERATURE_2:
> +	case PMBUS_READ_TEMPERATURE_3:
> +	case PMBUS_READ_VIN:
> +	case PMBUS_READ_VOUT:
> +	case PMBUS_STATUS_WORD:
> +		break;
> +	default:
> +		return -ENXIO;
> +	}
> +
> +	rv = set_page(client, page);
> +	if (rv < 0)
> +		return rv;
> +
> +	return i2c_smbus_read_word_data(client, reg);
> +}
> +
> +struct pmbus_driver_info fsp3y_info[] = {
> +	[ym2151e] = {
> +		.pages = 2,
> +		.func[YM2151_PAGE_12V_LOG] =
> +			PMBUS_HAVE_VOUT | PMBUS_HAVE_IOUT |
> +			PMBUS_HAVE_PIN | PMBUS_HAVE_POUT  |
> +			PMBUS_HAVE_TEMP | PMBUS_HAVE_TEMP2 |
> +			PMBUS_HAVE_VIN | PMBUS_HAVE_IIN |
> +			PMBUS_HAVE_FAN12,
> +		.func[YM2151_PAGE_5VSB_LOG] =
> +			PMBUS_HAVE_VOUT | PMBUS_HAVE_IOUT,
> +			PMBUS_HAVE_IIN,
> +		.read_word_data = fsp3y_read_word_data,
> +		.read_byte_data = fsp3y_read_byte_data,
> +	},
> +	[yh5151e] = {
> +		.pages = 3,
> +		.func[YH5151E_PAGE_12V_LOG] =
> +			PMBUS_HAVE_VOUT | PMBUS_HAVE_IOUT |
> +			PMBUS_HAVE_POUT  |
> +			PMBUS_HAVE_TEMP | PMBUS_HAVE_TEMP2 | PMBUS_HAVE_TEMP3,
> +		.func[YH5151E_PAGE_5V_LOG] =
> +			PMBUS_HAVE_VOUT | PMBUS_HAVE_IOUT |
> +			PMBUS_HAVE_POUT,
> +		.func[YH5151E_PAGE_3V3_LOG] =
> +			PMBUS_HAVE_VOUT | PMBUS_HAVE_IOUT |
> +			PMBUS_HAVE_POUT,
> +		.read_word_data = fsp3y_read_word_data,
> +		.read_byte_data = fsp3y_read_byte_data,
> +	}
> +};
> +
> +static int fsp3y_detect(struct i2c_client *client)
> +{
> +	int rv;
> +	u8 buf[I2C_SMBUS_BLOCK_MAX];
> +
> +	rv = i2c_smbus_read_block_data(client, PMBUS_MFR_MODEL, buf);
> +	if (rv < 0)
> +		return rv;
> +
> +	if (rv == 8 && !strncmp(buf, "YM-2151E", strlen("YM-2151E")))
> +		return ym2151e;
> +	else if (rv == 8 && !strncmp(buf, "YH-5151E", strlen("YH-5151E")))
> +		return yh5151e;

better
	if (rv == 8) {
		/* rest of check */
	}

> +
> +	dev_err(&client->dev, "Unsupported model %.*s\n", rv, buf);

Sorry I didn't notice before. This assumes that the buffer is zero-terminated,
which may not be the case. For this to work, add another byte to the buffer
(u8 buf[I2C_SMBUS_BLOCK_MAX + 1];), and add
	buf[rv] = '\0';

You could actually do that before checking the returned strings and then just
use strcmp() for the model comparisons, without bothering about the return
length.

> +	return -ENODEV;
> +}
> +
> +static const struct i2c_device_id fsp3y_id[] = {
> +	{"ym2151e", ym2151e},
> +	{"yh5151e", yh5151e}
> +};
> +
> +static int fsp3y_probe(struct i2c_client *client)
> +{
> +	struct fsp3y_data *data;
> +	const struct i2c_device_id *id;
> +	int rv;
> +
> +	data = devm_kzalloc(&client->dev, sizeof(struct fsp3y_data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->chip = fsp3y_detect(client);
> +	if (data->chip < 0)
> +		return data->chip;
> +
> +	id = i2c_match_id(fsp3y_id, client);
> +	if (data->chip != id->driver_data)
> +		dev_warn(&client->dev, "Device mismatch: Configured %s (%d), detected %d\n", id->name, (int)id->driver_data, data->chip);
> +
> +	rv = i2c_smbus_read_byte_data(client, PMBUS_PAGE);
> +	if (rv < 0)
> +		return rv;
> +	data->page = rv;
> +
> +	data->info = fsp3y_info[data->chip];
> +
> +	return pmbus_do_probe(client, &data->info);
> +}
> +
> +MODULE_DEVICE_TABLE(i2c, pmbus_id);
> +
> +/* This is the driver that will be inserted */

Nit: Useless comment

> +static struct i2c_driver fsp3y_driver = {
> +	.driver = {
> +		   .name = "fsp3y",
> +		   },
> +	.probe_new = fsp3y_probe,
> +	.id_table = fsp3y_id
> +};
> +
> +module_i2c_driver(fsp3y_driver);
> +
> +MODULE_AUTHOR("Václav Kubernát");
> +MODULE_DESCRIPTION("PMBus driver for FSP/3Y-Power power supplies");
> +MODULE_LICENSE("GPL");
> 

