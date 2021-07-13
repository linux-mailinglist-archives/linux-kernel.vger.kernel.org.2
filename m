Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4C63C6CF8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 11:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234957AbhGMJOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 05:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234397AbhGMJOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 05:14:15 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A0FC0613DD;
        Tue, 13 Jul 2021 02:11:25 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id e1-20020a9d63c10000b02904b8b87ecc43so7880603otl.4;
        Tue, 13 Jul 2021 02:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=N8tVkCLIOHC8tQlM3lOUmxEAnRAXk6f8wcRyPngBfC0=;
        b=DaNwZfuJzvql2YKziqG8YfpN4KPtiVMPqYzBCf11ALP9JTqB83GqsWfpaC+nlvQxbm
         TIdbsdcoG/Sk++nwf8HCAL7fATfkc9FGJQAon/WuvQJKpA5dlpCmCIMM/Uau09Q6VE8C
         zGATYXnBEQEEqBuISbspXz6QWstmB+3vyfGE4KvbSRHN1emNToWdLhymEawxPCpTmlzv
         A5i278jmONI5ICGx9iFhGo1UPOqLrHbVfNZ7gGHmZov7HlvVOoJtdX0SBcnXS/+3dtRD
         CPT5S0Jwg7lYLnjqCzaa2tzSsXXamGjlzVxZa9EAq21uEDS9zsMlX3YDWUZoXJZEsgHB
         6CuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=N8tVkCLIOHC8tQlM3lOUmxEAnRAXk6f8wcRyPngBfC0=;
        b=SdAYI4uxA16lkS79uw2Nrt3ZsD6XWcY45E9ER3iFBRMZMKtSZMc/iDZ6GZQqEzdabs
         D2Y+qg6/X2L07NkcueZr42IPWmiauVyoWgvzWCSeZkeBEfPZFTaLf+CJjlKoM9D4fBqE
         +q5m31eIK7rbYTVfrzyCCBb9BZV6FZjawa1gGDPjHetfg2Kq+zIFJV8wEX8t6My/RNaN
         0WWoMBdHEzudWtotJteXov4DWwAMdGPs20RL1FJKZ6GNGMh5Tg9lI4YEbzt7ys3xcxc0
         tG6IO3OdJ8D1SJ/Zyhi1g5PvZMtLD1wW9AisU1nt/ZdECddKtCSdrU/uoktxNY3b0SpT
         sp2w==
X-Gm-Message-State: AOAM531uJfySEjvdbaiQP6U+4xjoZWhODy6Op3gseH716Ns4M1KP0ZbT
        Wxel2vHrHD0CuVks1SZw7Ao=
X-Google-Smtp-Source: ABdhPJyEmJ54iiMXDtCHbs5J4YChfUo2Bfa8JGRGajy7bwU6lXC2GsoItE6uqAeoa722QK5xCu2pag==
X-Received: by 2002:a05:6830:1495:: with SMTP id s21mr2721116otq.86.1626167484975;
        Tue, 13 Jul 2021 02:11:24 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n20sm3680323otj.11.2021.07.13.02.11.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jul 2021 02:11:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Quan Nguyen <quan@os.amperecomputing.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        openbmc@lists.ozlabs.org
Cc:     Open Source Submission <patches@amperecomputing.com>,
        Phong Vo <phong@os.amperecomputing.com>,
        "Thang Q . Nguyen" <thang@os.amperecomputing.com>
References: <20210713060031.31568-1-quan@os.amperecomputing.com>
 <20210713060031.31568-3-quan@os.amperecomputing.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v5 2/4] mfd: smpro-mfd: Adds Ampere's Altra SMpro MFD
 driver
Message-ID: <4e251a34-5c0f-da9d-e471-517c1d581fa4@roeck-us.net>
Date:   Tue, 13 Jul 2021 02:11:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210713060031.31568-3-quan@os.amperecomputing.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/12/21 11:00 PM, Quan Nguyen wrote:
> Adds Multi-function devices driver for SMpro co-processor found on the
> Mt.Jade hardware reference platform with Ampere's Altra processor family.
> 
> Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>

Maybe that has been discussed, but is there anything else besides
hardware monitoring connected to this i2c interface, and are there
more child drivers coming ? I don't find the BMC Interface Specification
mentioned in the documentation patch, but the hardware specification
seems to suggest that the i2c bus is dedicated for hardware monitoring.
If there is no other child driver, an mfd driver would not make sense.

Thanks,
Guenter

> ---
> Changes in v5:
>    + Dropped the use of simple-mfd-i2c driver [Quan]
>    + Introduced drivers/mfd/smpro-mfd.c driver to instantiate
>    sub-devices. This is to avoid DT nodes without resource issue [Quan]
>    + Revised commit message [Quan]
> 
> Changes in v4:
>    + Add "depends on I2C" to fix build issue found by kernel test
>    robot [Guenter]
> 
> Changes in v3:
>    + None
> 
> Changes in v2:
>    + Used 'struct of_device_id's .data attribute [Lee Jones]
> 
>   drivers/mfd/Kconfig     | 12 +++++++
>   drivers/mfd/Makefile    |  1 +
>   drivers/mfd/smpro-mfd.c | 74 +++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 87 insertions(+)
>   create mode 100644 drivers/mfd/smpro-mfd.c
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 6a3fd2d75f96..25e502cca32f 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -77,6 +77,18 @@ config MFD_AS3711
>   	help
>   	  Support for the AS3711 PMIC from AMS
>   
> +config MFD_SMPRO
> +	tristate "Ampere Computing MFD SMpro core driver"
> +	depends on I2C
> +	select MFD_CORE
> +	select REGMAP_I2C
> +	help
> +	  Say yes here to enable SMpro driver support for Ampere's Altra
> +	  processor family.
> +
> +	  Ampere's Altra SMpro exposes an I2C regmap interface that can
> +	  be accessed by child devices.
> +
>   config MFD_AS3722
>   	tristate "ams AS3722 Power Management IC"
>   	select MFD_CORE
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 8116c19d5fd4..046fd36de85a 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -268,6 +268,7 @@ obj-$(CONFIG_MFD_QCOM_PM8008)	+= qcom-pm8008.o
>   
>   obj-$(CONFIG_SGI_MFD_IOC3)	+= ioc3.o
>   obj-$(CONFIG_MFD_SIMPLE_MFD_I2C)	+= simple-mfd-i2c.o
> +obj-$(CONFIG_MFD_SMPRO)		+= smpro-mfd.o
>   obj-$(CONFIG_MFD_INTEL_M10_BMC)   += intel-m10-bmc.o
>   
>   obj-$(CONFIG_MFD_ATC260X)	+= atc260x-core.o
> diff --git a/drivers/mfd/smpro-mfd.c b/drivers/mfd/smpro-mfd.c
> new file mode 100644
> index 000000000000..b0cd3c248507
> --- /dev/null
> +++ b/drivers/mfd/smpro-mfd.c
> @@ -0,0 +1,74 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Ampere Altra Family SMPro MFD - I2C
> + *
> + * Copyright (c) 2021, Ampere Computing LLC
> + *
> + * Author: Quan Nguyen <quan@os.amperecomputing..com>
> + */
> +
> +#include <linux/i2c.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_platform.h>
> +#include <linux/mfd/core.h>
> +#include <linux/regmap.h>
> +
> +/* Identification Registers */
> +#define MANUFACTURER_ID_REG     0x02
> +#define AMPERE_MANUFACTURER_ID  0xCD3A
> +
> +static const struct regmap_config simple_word_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 16,
> +};
> +
> +static const struct mfd_cell smpro_devs[] = {
> +	MFD_CELL_NAME("smpro-hwmon"),
> +};
> +
> +static int smpro_mfd_probe(struct i2c_client *i2c)
> +{
> +	const struct regmap_config *config;
> +	struct regmap *regmap;
> +	unsigned int val;
> +	int ret;
> +
> +	config = device_get_match_data(&i2c->dev);
> +	if (!config)
> +		config = &simple_word_regmap_config;
> +
> +	regmap = devm_regmap_init_i2c(i2c, config);
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> +
> +	/* Check for valid ID */
> +	ret = regmap_read(regmap, MANUFACTURER_ID_REG, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (val != AMPERE_MANUFACTURER_ID)
> +		return -ENODEV;
> +
> +	return devm_mfd_add_devices(&i2c->dev, PLATFORM_DEVID_AUTO,
> +				    smpro_devs, ARRAY_SIZE(smpro_devs), NULL, 0, NULL);
> +}
> +
> +static const struct of_device_id smpro_mfd_of_match[] = {
> +	{ .compatible = "ampere,smpro", .data = &simple_word_regmap_config },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, smpro_mfd_of_match);
> +
> +static struct i2c_driver smpro_mfd_driver = {
> +	.probe_new = smpro_mfd_probe,
> +	.driver = {
> +		.name = "smpro-mfd-i2c",
> +		.of_match_table = smpro_mfd_of_match,
> +	},
> +};
> +module_i2c_driver(smpro_mfd_driver);
> +
> +MODULE_AUTHOR("Quan Nguyen <quan@os.amperecomputing.com>");
> +MODULE_DESCRIPTION("SMPRO MFD - I2C driver");
> +MODULE_LICENSE("GPL v2");
> 

