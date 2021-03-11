Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A19BF337FE3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 22:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbhCKVsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 16:48:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbhCKVsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 16:48:40 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7603C061574;
        Thu, 11 Mar 2021 13:48:40 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id x28so2574034otr.6;
        Thu, 11 Mar 2021 13:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=FLFJ/cfbWjjDQmovjePYB1SvwwbHlMBXgTEQGX1t96s=;
        b=XesCgyqdJdWS4444WrdJNNuPovODkvXZd1O3rmtyGOY9sqcSCpJmkAylz73TJ+5jvC
         evV/lSTnWN6E9a01Q3QwVa4HtsJrkAOk2Vyk1f0pandhimTLgpM1G4fyukLstZq+TD2n
         LqIwGV260kyLBDfBm6mjVXBePTier8G/GMdHDeQiQEzcsGtbDevKk+qzZdiZUXszZZWK
         g5T9sR4ZnYup2K4W6wrMRdEaiqo75OF1xvl4qz5YbUBx/6Ei1sD7UiNOVJPVyfaOniFv
         R5EU90ml9xQCCjyhi1PVQEClLYW2uL/eMJtuNB1MYqTcb6cwvNSA6WwpHO4XDmgQxpMA
         Vkig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=FLFJ/cfbWjjDQmovjePYB1SvwwbHlMBXgTEQGX1t96s=;
        b=jWeR07x/bVwRPOPaNSLLqbuF+8LW5BJPVaj6bPK2gb8o4LxlXmNj+TAMrqu3n7eaps
         eHAlDkjBf6a/7bfs7qL21WFYlLaQZsJH0pDibFsgtcfvScH5NyCt1p3PMSuSVklW8hRN
         TO8MTplbhFlbvrR4rA0HR8YhSbNhLlH660PeyZwbeEtIWtrpOGK/DUKdzLK6ezGPnzd6
         vQSdlTZ9eNX0eMDVKqlHyMmXq6OK3laVLxKqZj/nrR+RB6HczOojslDeTw50JI8Ce/zL
         RKLnG0hPxKms1mUsM/3IHZ9gqgFfW4r4yrodJ7rcCi95qH3HAsKN7v0YhYIoYwuocOd1
         U9Rg==
X-Gm-Message-State: AOAM533wyFiiMLG4Rq2/aWFV5pvN3NJFtaL6nSGqRBzLZt1opkuJQIHe
        DFHup5W1jglFEab0o/lwBf0=
X-Google-Smtp-Source: ABdhPJx6wGN2tYknfFIvovrmwvQBFQdQ5WYTj+7z/OaDlFqSGacer0gQWK/b+F7VlkvVZSz0qf2UNQ==
X-Received: by 2002:a9d:7512:: with SMTP id r18mr863295otk.90.1615499320227;
        Thu, 11 Mar 2021 13:48:40 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o9sm873506otl.39.2021.03.11.13.48.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Mar 2021 13:48:39 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 11 Mar 2021 13:48:38 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     robh+dt@kernel.org, jdelvare@suse.com, devicetree@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 2/2] hwmon: (pmbus): Add driver for Infineon IR36021
Message-ID: <20210311214838.GA36413@roeck-us.net>
References: <20210301035954.16713-1-chris.packham@alliedtelesis.co.nz>
 <20210301035954.16713-3-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210301035954.16713-3-chris.packham@alliedtelesis.co.nz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 01, 2021 at 04:59:54PM +1300, Chris Packham wrote:
> The IR36021 is a dual‐loop digital multi‐phase buck controller.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

Applied.

Thanks,
Guenter

> ---
> Changes in v2:
> - update against latest kernel for pmbus API changes
> - avoid double negation
> 
>  Documentation/hwmon/index.rst   |  1 +
>  Documentation/hwmon/ir36021.rst | 62 ++++++++++++++++++++++++++
>  drivers/hwmon/pmbus/Kconfig     |  9 ++++
>  drivers/hwmon/pmbus/Makefile    |  1 +
>  drivers/hwmon/pmbus/ir36021.c   | 79 +++++++++++++++++++++++++++++++++
>  5 files changed, 152 insertions(+)
>  create mode 100644 Documentation/hwmon/ir36021.rst
>  create mode 100644 drivers/hwmon/pmbus/ir36021.c
> 
> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> index 8d5a2df1ecb6..b34894403c2b 100644
> --- a/Documentation/hwmon/index.rst
> +++ b/Documentation/hwmon/index.rst
> @@ -77,6 +77,7 @@ Hardware Monitoring Kernel Drivers
>     intel-m10-bmc-hwmon
>     ir35221
>     ir38064
> +   ir36021
>     isl68137
>     it87
>     jc42
> diff --git a/Documentation/hwmon/ir36021.rst b/Documentation/hwmon/ir36021.rst
> new file mode 100644
> index 000000000000..36ef8d518b81
> --- /dev/null
> +++ b/Documentation/hwmon/ir36021.rst
> @@ -0,0 +1,62 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +Kernel driver ir36021
> +=====================
> +
> +Supported chips:
> +
> +  * Infineon IR36021
> +
> +    Prefix: ir36021
> +    Addresses scanned: -
> +
> +    Datasheet: Publicly available at the Infineon website
> +      https://www.infineon.com/dgdl/ir36021.pdf?fileId=5546d462533600a4015355d0aa2d1775
> +
> +Authors:
> +      - Chris Packham <chris.packham@alliedtelesis.co.nz>
> +
> +Description
> +-----------
> +
> +The IR36021 is a dual‐loop digital multi‐phase buck controller designed for
> +point of load applications.
> +
> +Usage Notes
> +-----------
> +
> +This driver does not probe for PMBus devices. You will have to instantiate
> +devices explicitly.
> +
> +Sysfs attributes
> +----------------
> +
> +======================= ===========================
> +curr1_label             "iin"
> +curr1_input             Measured input current
> +curr1_alarm             Input fault alarm
> +
> +curr2_label             "iout1"
> +curr2_input             Measured output current
> +curr2_alarm             Output over-current alarm
> +
> +in1_label               "vin"
> +in1_input               Measured input voltage
> +in1_alarm               Input under-voltage alarm
> +
> +in2_label               "vout1"
> +in2_input               Measured output voltage
> +in2_alarm               Output over-voltage alarm
> +
> +power1_label            "pin"
> +power1_input            Measured input power
> +power1_alarm            Input under-voltage alarm
> +
> +power2_label            "pout1"
> +power2_input            Measured output power
> +
> +temp1_input             Measured temperature
> +temp1_alarm             Temperature alarm
> +
> +temp2_input             Measured other loop temperature
> +temp2_alarm             Temperature alarm
> diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
> index 32d2fc850621..ee8c27b3b83d 100644
> --- a/drivers/hwmon/pmbus/Kconfig
> +++ b/drivers/hwmon/pmbus/Kconfig
> @@ -84,6 +84,15 @@ config SENSORS_IR35221
>  	  This driver can also be built as a module. If so, the module will
>  	  be called ir35221.
>  
> +config SENSORS_IR36021
> +	tristate "Infineon IR36021"
> +	help
> +	  If you say yes here you get hardware monitoring support for Infineon
> +	  IR36021.
> +
> +	  This driver can also be built as a module. If so, the module will
> +	  be called ir36021.
> +
>  config SENSORS_IR38064
>  	tristate "Infineon IR38064"
>  	help
> diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
> index 6a4ba0fdc1db..685a6bc2b15f 100644
> --- a/drivers/hwmon/pmbus/Makefile
> +++ b/drivers/hwmon/pmbus/Makefile
> @@ -11,6 +11,7 @@ obj-$(CONFIG_SENSORS_BEL_PFE)	+= bel-pfe.o
>  obj-$(CONFIG_SENSORS_IBM_CFFPS)	+= ibm-cffps.o
>  obj-$(CONFIG_SENSORS_INSPUR_IPSPS) += inspur-ipsps.o
>  obj-$(CONFIG_SENSORS_IR35221)	+= ir35221.o
> +obj-$(CONFIG_SENSORS_IR36021)	+= ir36021.o
>  obj-$(CONFIG_SENSORS_IR38064)	+= ir38064.o
>  obj-$(CONFIG_SENSORS_IRPS5401)	+= irps5401.o
>  obj-$(CONFIG_SENSORS_ISL68137)	+= isl68137.o
> diff --git a/drivers/hwmon/pmbus/ir36021.c b/drivers/hwmon/pmbus/ir36021.c
> new file mode 100644
> index 000000000000..4767e39cc965
> --- /dev/null
> +++ b/drivers/hwmon/pmbus/ir36021.c
> @@ -0,0 +1,79 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Hardware monitoring driver for Infineon IR36021
> + *
> + * Copyright (c) 2021 Allied Telesis
> + */
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include "pmbus.h"
> +
> +static struct pmbus_driver_info ir36021_info = {
> +	.pages = 1,
> +	.format[PSC_VOLTAGE_IN] = linear,
> +	.format[PSC_VOLTAGE_OUT] = linear,
> +	.format[PSC_CURRENT_IN] = linear,
> +	.format[PSC_CURRENT_OUT] = linear,
> +	.format[PSC_POWER] = linear,
> +	.format[PSC_TEMPERATURE] = linear,
> +	.func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_VOUT
> +		| PMBUS_HAVE_IIN | PMBUS_HAVE_IOUT
> +		| PMBUS_HAVE_PIN | PMBUS_HAVE_POUT
> +		| PMBUS_HAVE_TEMP | PMBUS_HAVE_TEMP2
> +		| PMBUS_HAVE_STATUS_TEMP,
> +};
> +
> +static int ir36021_probe(struct i2c_client *client)
> +{
> +	u8 buf[I2C_SMBUS_BLOCK_MAX];
> +	int ret;
> +
> +	if (!i2c_check_functionality(client->adapter,
> +				     I2C_FUNC_SMBUS_READ_BYTE_DATA
> +				     | I2C_FUNC_SMBUS_READ_WORD_DATA
> +				     | I2C_FUNC_SMBUS_READ_BLOCK_DATA))
> +		return -ENODEV;
> +
> +	ret = i2c_smbus_read_i2c_block_data(client, PMBUS_MFR_MODEL, 2, buf);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "Failed to read PMBUS_MFR_MODEL\n");
> +		return ret;
> +	}
> +	if (ret != 2 || buf[0] != 0x01 || buf[1] != 0x2d) {
> +		dev_err(&client->dev, "MFR_MODEL unrecognised\n");
> +		return -ENODEV;
> +	}
> +
> +	return pmbus_do_probe(client, &ir36021_info);
> +}
> +
> +static const struct i2c_device_id ir36021_id[] = {
> +	{ "ir36021", 0 },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(i2c, ir36021_id);
> +
> +static const struct of_device_id __maybe_unused ir36021_of_id[] = {
> +	{ .compatible = "infineon,ir36021" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, ir36021_of_id);
> +
> +static struct i2c_driver ir36021_driver = {
> +	.class = I2C_CLASS_HWMON,
> +	.driver = {
> +		.name = "ir36021",
> +		.of_match_table = of_match_ptr(ir36021_of_id),
> +	},
> +	.probe_new = ir36021_probe,
> +	.id_table = ir36021_id,
> +};
> +
> +module_i2c_driver(ir36021_driver);
> +
> +MODULE_AUTHOR("Chris Packham <chris.packham@alliedtelesis.co.nz>");
> +MODULE_DESCRIPTION("PMBus driver for Infineon IR36021");
> +MODULE_LICENSE("GPL");
