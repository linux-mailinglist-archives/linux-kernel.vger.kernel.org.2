Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27097357ADD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 05:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbhDHDop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 23:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhDHDon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 23:44:43 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0F2C061760;
        Wed,  7 Apr 2021 20:44:31 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id i3so764926oik.7;
        Wed, 07 Apr 2021 20:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vjzflC2pyWC8bHhAoYYdc4oFYm8ALwnjjdtxo/FASFg=;
        b=GgRrCTmqXPZDBeCsbbSHLuAV856olpXoizCxW2iBVvusDz5VDt5D+zQYxtxlGQyZ/j
         re1O17aAP+3b1edlWraac4u13hlTdUbjEb0hlckeGrXZ9jibRCPEqKFOTBfoBXCQNJVR
         DJJ4k/dohYfjttC2VrGgBZ7zK+1B9iKEf7OsLh/W59CLSJ6WnZLtEuoffuRCVta+uMet
         4huPR8wsPKmHEcQKF+B0CeIcsepXbHg2fI9xl2/xKEjJbpOynxxoP6Ev2IvebM7AD45D
         ABv2E8W9Yp97OqlC+a8+k23YvsufwKeU7fm5HRefrQ8ycs5Ogbdeqv9UcV43DXTJU0hE
         3pgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=vjzflC2pyWC8bHhAoYYdc4oFYm8ALwnjjdtxo/FASFg=;
        b=m53mvNAYKbTGMFTnAM0vbhAbtTokQoi6cNweFGHKUw+1HQkIDm1vUU2X7N4ox6I4HM
         qCStVF1d3K/pYdre6FobgZgDKVmERMxf16QWSJHviIdHJDztYalzXW/jm6mICwyWec2w
         Mn1iUD2+dSWJ7cyegT4cvuoo05x3iXk0pfR0zD5W0ae9rVTPqOdMZrNcJVGd+EEutiN/
         Tnywz+0eHXdOPYkvm5EJ8L96E3J5cZ5PfeOyz6DHoTkYX8n487v2ub5Pr7kt78G5F/Cl
         5hKfrH1seBPbtnUOEo48DMzJRLkOY37CWTdgU7jrnLuIxeFwydHvE8X8IU4WNZ5jwWyp
         Sx7g==
X-Gm-Message-State: AOAM532P3oey+P2OB326x5RMrfE8NuYzNTGvtXHqTH3IzQ+RIaknrOuN
        kxWSpZgaqGxvVIfoyv4ezL89PJZFxYc=
X-Google-Smtp-Source: ABdhPJz4in/qglj7Jc5fMXXek9sFPN1vmSkYKxELefFwLWhzuPJofUYFP8CNxAxQe7uWWRGKcF+p5Q==
X-Received: by 2002:aca:4d4e:: with SMTP id a75mr4560222oib.107.1617853470492;
        Wed, 07 Apr 2021 20:44:30 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s83sm4667971oif.43.2021.04.07.20.44.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Apr 2021 20:44:29 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v2] hwmon: Add driver for fsp-3y PSUs and PDUs
To:     =?UTF-8?B?VsOhY2xhdiBLdWJlcm7DoXQ=?= <kubernat@cesnet.cz>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210329143833.1047539-1-kubernat@cesnet.cz>
 <20210408023427.650428-1-kubernat@cesnet.cz>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <11d33d66-b59e-3153-9233-447213d93171@roeck-us.net>
Date:   Wed, 7 Apr 2021 20:44:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210408023427.650428-1-kubernat@cesnet.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/7/21 7:34 PM, Václav Kubernát wrote:
> This patch adds support for these devices:
> - YH-5151E - the PDU
> - YM-2151E - the PSU
> 
> The device datasheet says that the devices support PMBus 1.2, but in my
> testing, a lot of the commands aren't supported and if they are, they
> sometimes behave strangely or inconsistently. For example, writes to the
> PAGE command requires using PEC, otherwise the write won't work and the
> page won't switch, even though, the standard says that PEC is opiotnal.
> On the other hand, writes the SMBALERT don't require PEC. Because of
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
> Signed-off-by: Václav Kubernát <kubernat@cesnet.cz>
> ---
>  Documentation/hwmon/fsp-3y.rst |  26 ++++
>  drivers/hwmon/pmbus/Kconfig    |  10 ++
>  drivers/hwmon/pmbus/Makefile   |   1 +
>  drivers/hwmon/pmbus/fsp-3y.c   | 217 +++++++++++++++++++++++++++++++++
>  4 files changed, 254 insertions(+)
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
> index 000000000000..2c165e034fa8
> --- /dev/null
> +++ b/drivers/hwmon/pmbus/fsp-3y.c
> @@ -0,0 +1,217 @@
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
> +	enum chips chip;
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
> +		return -1;
> +	case yh5151e:
> +		switch (page_log) {
> +		case YH5151E_PAGE_12V_LOG:
> +			return YH5151E_PAGE_12V_REAL;
> +		case YH5151E_PAGE_5V_LOG:
> +			return YH5151E_PAGE_5V_LOG;
> +		case YH5151E_PAGE_3V3_LOG:
> +			return YH5151E_PAGE_3V3_REAL;
> +		}
> +		return -1;
> +	}
> +
> +	return -1;
> +}
> +
> +static int set_page(struct i2c_client *client, int page_log)
> +{
> +	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
> +	struct fsp3y_data *data = to_fsp3y_data(info);
> +	int rv;
> +	int page_real = page_log_to_page_real(page_log, data->chip);
> +
> +	if (page_log < 0)
> +		return 0;
> +
I am quite sure this should be

	if (page_real < 0)
		return 0;

I would suggest to return an error code, though; if page_log_to_page_real()
indeed returns an error, the selected page is wrong, and the reported data
would be pretty much random. That should not really happen, but since you check
for the error code here you might as well do it right. Best would be to have
page_log_to_page_real() return, say, -EINVAL on error and implement the check
as follows.

	if (page_real < 0)
		return page_real;

> +	if (data->page != page_real) {
> +		rv = pmbus_set_page(client, page_real, 0xff);
> +		if (rv < 0)
> +			return rv;
> +
> +		data->page = page_real;
> +
> +		/* Testing showed that the device has a timing issue. After
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
> +static int fsp3y_probe(struct i2c_client *client)
> +{
> +	struct fsp3y_data *data;
> +	int rv;
> +	u8 buf[I2C_SMBUS_BLOCK_MAX];
> +
> +	data = devm_kzalloc(&client->dev, sizeof(struct fsp3y_data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	rv = i2c_smbus_read_byte_data(client, PMBUS_PAGE);
> +	if (rv < 0)
> +		return rv;
> +	data->page = rv;
> +
> +	rv = i2c_smbus_read_block_data(client, PMBUS_MFR_MODEL, buf);
> +	if (rv < 0)
> +		return rv;
> +	if (rv != 8)
> +		return -ENODEV;
> +
> +	if (!strncmp(buf, "YM-2151E", strlen("YM-2151E")))
> +		data->chip = ym2151e;
> +	else if (!strncmp(buf, "YH-5151E", strlen("YH-5151E")))
> +		data->chip = yh5151e;
> +	else
> +		return -ENODEV;
> +
> +	data->info = fsp3y_info[data->chip];
> +
> +	return pmbus_do_probe(client, &data->info);
> +}
> +
> +static const struct i2c_device_id pmbus_id[] = {
> +	{"fsp3y", 0},

Normally you would have something like

	{"ym2151e", ym2151e},
	{"yh5151e", yh5151e},

to match specific supplies. The probe function should then warn
if there is a mismatch. See other pmbus drivers for examples.

Guenter

> +	{}
> +};
> +
> +MODULE_DEVICE_TABLE(i2c, pmbus_id);
> +
> +/* This is the driver that will be inserted */
> +static struct i2c_driver fsp3y_driver = {
> +	.driver = {
> +		   .name = "fsp3y",
> +		   },
> +	.probe_new = fsp3y_probe,
> +	.id_table = pmbus_id
> +};
> +
> +module_i2c_driver(fsp3y_driver);
> +
> +MODULE_AUTHOR("Václav Kubernát");
> +MODULE_DESCRIPTION("PMBus driver for FSP/3Y-Power power supplies");
> +MODULE_LICENSE("GPL");
> 

