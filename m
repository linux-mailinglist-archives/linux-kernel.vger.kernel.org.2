Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF0E390F86
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 06:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbhEZEb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 00:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbhEZEbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 00:31:55 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373D7C061574;
        Tue, 25 May 2021 21:30:24 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id t10-20020a05683022eab0290304ed8bc759so30793456otc.12;
        Tue, 25 May 2021 21:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:to:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eSEUr13IdSicad5ezNLJhLbCXVl/KqNznnhra1ykMK0=;
        b=cYJKhm7yrby1IVW+AhVgjaha7aoNBSV+3iNABWetTn9zRe9/wfi8k1YSIYhuVefCHW
         LiYma6z+toSdnsf1ky96joZdZxeQ843IC5mTOS7ZKo2es9McMS5TKnxk0DTaAHGRiD2k
         oF6v4s6fLkU/XDQB0UwcgCAuLGoYPPTphyB0De3qVsgaO8nQcF1BWOa2jy3AI8CwX7Nz
         6JQ98vq6OKCvH/78TvAdd7zj7uN4MTvkD50E8aMLAGmV0TbKbdjMAFz6T+i28BtiAITV
         JIi0N/qEFMWiu+AD/rK4aiPLhz/ApJ+Lvc4xu6pFPpWPBfO4W5g7ojGY35E0qktoyEEs
         5Trw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:to:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eSEUr13IdSicad5ezNLJhLbCXVl/KqNznnhra1ykMK0=;
        b=gW2y7Drl4s/h764I70bx9aXY+kjRTC8UdAsZKelQWgJKCpKakPTQQ8ZRwKODqpmBR9
         Ej2EssNxPWTvKrDvWL8+90ofcDoZD0Il6vOkoVIpY6meBtQlzbLhooScpSTGKYhFcn8P
         3b0SAAsz0MDOmAB6Hv71lwn1svjgbhiRpxNoKI5elbLhyzE7AZy5n2WG3zQ9LUSbjinU
         JFas0XkEThIxhQodN2YGH5JVjyehwdbGQnbrfQvqVRyRjzZ0IGQQt+LhLWbVq0Zm3TyE
         yEQXibnXjFCf3otSAtffQ8o1xoLYhSnEstQy2VV380oF0AHlkfFBK+Rb1hedTiTH4GPT
         Qc5g==
X-Gm-Message-State: AOAM532EalIP28RLN/EQIhVkqKepJOh/BK2LCAs9L1beDk6KNcBMpsuh
        aL4rDf9Qf+BwYGMHYRRbiqJYDMudoGo=
X-Google-Smtp-Source: ABdhPJzycDSalaoX4kt2fmR46b6822Y0W/T6SuzuYRVq1DtAzKvfeYdstCbxWINBRQcAp9tNZ+o6OA==
X-Received: by 2002:a05:6830:4120:: with SMTP id w32mr851609ott.139.1622003423225;
        Tue, 25 May 2021 21:30:23 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b18sm4260508otk.62.2021.05.25.21.30.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 May 2021 21:30:22 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Erik Rosen <erik.rosen@metormote.com>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210524150246.90546-1-erik.rosen@metormote.com>
 <20210524150246.90546-6-erik.rosen@metormote.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v3 5/6] hwmon: (pmbus/pim4328) Add PMBus driver for
 PIM4006, PIM4328 and PIM4820
Message-ID: <99e7401d-86b5-5df0-3050-78a225d1b9fe@roeck-us.net>
Date:   Tue, 25 May 2021 21:30:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210524150246.90546-6-erik.rosen@metormote.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/24/21 8:02 AM, Erik Rosen wrote:
> Add hardware monitoring support for Flex power interface modules PIM4006,
> PIM4328 and PIM4820.
> 
> Signed-off-by: Erik Rosen <erik.rosen@metormote.com>
> ---
>   drivers/hwmon/pmbus/Kconfig   |   9 ++
>   drivers/hwmon/pmbus/Makefile  |   1 +
>   drivers/hwmon/pmbus/pim4328.c | 240 ++++++++++++++++++++++++++++++++++
>   3 files changed, 250 insertions(+)
>   create mode 100644 drivers/hwmon/pmbus/pim4328.c
> 
> diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
> index 37a5c39784fa..001527c71269 100644
> --- a/drivers/hwmon/pmbus/Kconfig
> +++ b/drivers/hwmon/pmbus/Kconfig
> @@ -257,6 +257,15 @@ config SENSORS_MP2975
>   	  This driver can also be built as a module. If so, the module will
>   	  be called mp2975.
>   
> +config SENSORS_PIM4328
> +	tristate "Flex PIM4328 and compatibles"
> +	help
> +	  If you say yes here you get hardware monitoring support for Flex
> +	  PIM4328, PIM4820 and PIM4006 Power Interface Modules.
> +
> +	  This driver can also be built as a module. If so, the module will
> +	  be called pim4328.
> +
>   config SENSORS_PM6764TR
>   	tristate "ST PM6764TR"
>   	help
> diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
> index f8dcc27cd56a..2a12397535ba 100644
> --- a/drivers/hwmon/pmbus/Makefile
> +++ b/drivers/hwmon/pmbus/Makefile
> @@ -39,3 +39,4 @@ obj-$(CONFIG_SENSORS_UCD9000)	+= ucd9000.o
>   obj-$(CONFIG_SENSORS_UCD9200)	+= ucd9200.o
>   obj-$(CONFIG_SENSORS_XDPE122)	+= xdpe12284.o
>   obj-$(CONFIG_SENSORS_ZL6100)	+= zl6100.o
> +obj-$(CONFIG_SENSORS_PIM4328)   += pim4328.o
> diff --git a/drivers/hwmon/pmbus/pim4328.c b/drivers/hwmon/pmbus/pim4328.c
> new file mode 100644
> index 000000000000..ead7419479ef
> --- /dev/null
> +++ b/drivers/hwmon/pmbus/pim4328.c
> @@ -0,0 +1,240 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Hardware monitoring driver for PIM4006, PIM4328 and PIM4820
> + *
> + * Copyright (c) 2021 Flextronics International Sweden AB
> + */
> +
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/pmbus.h>
> +#include <linux/slab.h>
> +#include "pmbus.h"
> +
> +enum chips { pim4006, pim4328, pim4820 };
> +
> +struct pim4328_data {
> +	enum chips id;
> +	struct pmbus_driver_info info;
> +};
> +
> +#define to_pim4328_data(x)  container_of(x, struct pim4328_data, info)
> +
> +/* PIM4006 and PIM4328 */
> +#define PIM4328_MFR_READ_VINA		0xd3
> +#define PIM4328_MFR_READ_VINB		0xd4
> +
> +/* PIM4006 */
> +#define PIM4328_MFR_READ_IINA		0xd6
> +#define PIM4328_MFR_READ_IINB		0xd7
> +#define PIM4328_MFR_FET_CHECKSTATUS     0xd9

tabs please for alignment

> +
> +/* PIM4328 */
> +#define PIM4328_MFR_STATUS_BITS		0xd5
> +
> +/* PIM4820 */
> +#define PIM4328_MFR_READ_STATUS		0xd0
> +
> +static const struct i2c_device_id pim4328_id[] = {
> +	{"bmr455", pim4328},
> +	{"pim4006", pim4006},
> +	{"pim4106", pim4006},
> +	{"pim4206", pim4006},
> +	{"pim4306", pim4006},
> +	{"pim4328", pim4328},
> +	{"pim4406", pim4006},
> +	{"pim4820", pim4820},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, pim4328_id);
> +
> +static int pim4328_read_word_data(struct i2c_client *client, int page,
> +				  int phase, int reg)
> +{
> +	int ret;
> +
> +	if (page > 0)
> +		return -ENXIO;
> +
> +	switch (reg) {
> +	case PMBUS_READ_VIN:
> +		if (phase != 0xff) {
> +			ret = pmbus_read_word_data(client, page, phase,
> +						   phase == 0 ? PIM4328_MFR_READ_VINA
> +							      : PIM4328_MFR_READ_VINB);
> +		} else {
> +			ret = -ENODATA;
> +		}
> +		break;
> +	case PMBUS_READ_IIN:
> +		if (phase != 0xff) {

It might be easier to just have

	if (phase == 0xff)
		return -ENODATA;

at the beginning of the function.

> +			ret = pmbus_read_word_data(client, page, phase,
> +						   phase == 0 ? PIM4328_MFR_READ_IINA
> +							      : PIM4328_MFR_READ_IINB);
> +		} else {
> +			ret = -ENODATA;
> +		}
> +		break;
> +	default:
> +		ret = -ENODATA;
> +	}
> +
> +	return ret;
> +}
> +
> +static int pim4328_read_byte_data(struct i2c_client *client, int page, int reg)
> +{
> +	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
> +	struct pim4328_data *data = to_pim4328_data(info);
> +	int ret, status;
> +
> +	if (page > 0)
> +		return -ENXIO;
> +
> +	switch (reg) {
> +	case PMBUS_STATUS_BYTE:
> +		ret = pmbus_read_byte_data(client, page, PMBUS_STATUS_BYTE);
> +		if (ret >= 0) {

Please use
		if (ret < 0)
			return ret;

> +			if (data->id == pim4006) {
> +				status = pmbus_read_word_data(client, page, 0xff,
> +							      PIM4328_MFR_FET_CHECKSTATUS);
> +				if (status > 0) {
> +					if (status & 0x0630) /* Input UV */
> +						ret |= 0x08;

Please use existing bit masks (here: PB_STATUS_VIN_UV)

> +				}

Does this ignore errors on purpose ?
Same question below.

> +			} else if (data->id == pim4328) {
> +				status = pmbus_read_byte_data(client, page,
> +							      PIM4328_MFR_STATUS_BITS);
> +				if (status > 0) {
> +					if (status & 0x04) /* Input UV */
> +						ret |= 0x08;
> +					if (status & 0x40) /* Output UV */
> +						ret |= 0x80;
> +				}
> +			} else if (data->id == pim4820) {
> +				status = pmbus_read_byte_data(client, page,
> +							      PIM4328_MFR_READ_STATUS);
> +				if (status > 0) {
> +					if (status & 0x05) /* Input OV or OC */
> +						ret |= 0x01;
> +					if (status & 0x1a) /* Input UV */
> +						ret |= 0x08;
> +					if (status & 0x40) /* OT */
> +						ret |= 0x04;
> +				}
> +			}
> +		}
> +		break;
> +	default:
> +		ret = -ENODATA;
> +	}
> +
> +	return ret;
> +}
> +
> +static int pim4328_probe(struct i2c_client *client)
> +{
> +	int status;
> +	u8 device_id[I2C_SMBUS_BLOCK_MAX + 1];
> +	const struct i2c_device_id *mid;
> +	struct pim4328_data *data;
> +	struct pmbus_driver_info *info;
> +	struct pmbus_platform_data *pdata;
> +	struct device *dev = &client->dev;
> +
> +	if (!i2c_check_functionality(client->adapter,
> +				     I2C_FUNC_SMBUS_READ_BYTE_DATA
> +				     | I2C_FUNC_SMBUS_BLOCK_DATA))
> +		return -ENODEV;
> +
> +	data = devm_kzalloc(&client->dev, sizeof(struct pim4328_data),
> +			    GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	status = i2c_smbus_read_block_data(client, PMBUS_MFR_MODEL, device_id);
> +	if (status < 0) {
> +		dev_err(&client->dev, "Failed to read Manufacturer Model\n");
> +		return status;
> +	}
> +	for (mid = pim4328_id; mid->name[0]; mid++) {
> +		if (!strncasecmp(mid->name, device_id, strlen(mid->name)))
> +			break;
> +	}
> +	if (!mid->name[0]) {
> +		dev_err(&client->dev, "Unsupported device\n");
> +		return -ENODEV;
> +	}
> +
> +	if (strcmp(client->name, mid->name) != 0)

!= 0 is unnecessary

> +		dev_notice(&client->dev,
> +			   "Device mismatch: Configured %s, detected %s\n",
> +			   client->name, mid->name);
> +
> +	data->id = mid->driver_data;
> +	info = &data->info;
> +	info->pages = 1;
> +	info->read_byte_data = pim4328_read_byte_data;
> +	info->read_word_data = pim4328_read_word_data;
> +
> +	switch (data->id) {
> +	case pim4006:
> +		info->phases[0] = 2;
> +		info->func[0] = PMBUS_PHASE_VIRTUAL | PMBUS_HAVE_VIN
> +			| PMBUS_HAVE_TEMP | PMBUS_HAVE_IOUT;
> +		info->pfunc[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_IIN;
> +		info->pfunc[1] = PMBUS_HAVE_VIN | PMBUS_HAVE_IIN;
> +		break;
> +	case pim4328:
> +		info->phases[0] = 2;
> +		info->func[0] = PMBUS_PHASE_VIRTUAL
> +			| PMBUS_HAVE_VCAP | PMBUS_HAVE_VIN
> +			| PMBUS_HAVE_TEMP | PMBUS_HAVE_IOUT;
> +		info->pfunc[0] = PMBUS_HAVE_VIN;
> +		info->pfunc[1] = PMBUS_HAVE_VIN;
> +		info->format[PSC_VOLTAGE_IN] = direct;
> +		info->format[PSC_TEMPERATURE] = direct;
> +		info->format[PSC_CURRENT_OUT] = direct;
> +		break;
> +	case pim4820:
> +		info->func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_TEMP
> +			| PMBUS_HAVE_IIN;
> +		info->format[PSC_VOLTAGE_IN] = direct;
> +		info->format[PSC_TEMPERATURE] = direct;
> +		info->format[PSC_CURRENT_IN] = direct;
> +		break;
> +	default:
> +		return -ENODEV;
> +	}
> +
> +	pdata = devm_kzalloc(dev, sizeof(struct pmbus_platform_data),
> +			     GFP_KERNEL);
> +	if (!pdata)
> +		return -ENOMEM;
> +
> +	pdata->flags = PMBUS_NO_CAPABILITY | PMBUS_NO_WRITE_PROTECT;
> +	if (data->id == pim4328 || data->id == pim4820)
> +		pdata->flags |= PMBUS_USE_COEFFICIENTS_CMD;

It would be better to move pdata allocation ahead of the switch statement
above, and set the additional flags in the case statements.

> +
> +	dev->platform_data = pdata;
> +
> +	return pmbus_do_probe(client, info);
> +}
> +
> +static struct i2c_driver pim4328_driver = {
> +	.driver = {
> +		   .name = "pim4328",
> +		   },
> +	.probe_new = pim4328_probe,
> +	.id_table = pim4328_id,
> +};
> +
> +module_i2c_driver(pim4328_driver);
> +
> +MODULE_AUTHOR("Erik Rosen <erik.rosen@metormote.com>");
> +MODULE_DESCRIPTION("PMBus driver for PIM4006, PIM4328, PIM4820 power interface modules");
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(PMBUS);
> 

