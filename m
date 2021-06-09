Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81CFD3A1D6E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 21:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhFITGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 15:06:38 -0400
Received: from mail-ot1-f43.google.com ([209.85.210.43]:41863 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhFITGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 15:06:36 -0400
Received: by mail-ot1-f43.google.com with SMTP id 36-20020a9d0ba70000b02902e0a0a8fe36so25002186oth.8;
        Wed, 09 Jun 2021 12:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=15uCjNLhjwGWlgk+1C7m0hraHR2AQYwT27ERVnGT2M0=;
        b=YxhbwVjeHDedokS7kJb024FK7ZhViHcSq8MOEyZ58bmIDdKvfHaJrto0epVq7sBOb8
         4JkaK1P0EzQNOfN350Tq6GlSs4HOd8EHpj1O+y0vfZ1QCgkYzk3WJSs6i4jWrCWoxSAx
         DQiulDLZEto9Za4W2VSxicrykwmUpC8AMV1vhAAEEptvqWMpM68hxZs14Xf3F0Qz98lm
         seRYPvsxLrrM//0tdFCHy6Z7DESBQx36/kyQUVRy6fTIpuf1a/oCuhLR61Az6kzltoVP
         RbfmcQnB1eEDamcIM6x0m8U1OJP8aekFU54HMfQ1ozpRy28qqfGIAHzjoaOYVjBi/rf+
         zOtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=15uCjNLhjwGWlgk+1C7m0hraHR2AQYwT27ERVnGT2M0=;
        b=ccQVal1IOmtQHfxkcOYh7KMyIUWTrb4S/7Z66mGofjbOBsLAEeeFlUrb0g0VPbsv3Q
         43ny8t0h2eS5ScjfM5YZIxRUGvAc5dYggz3DgpAH8zsRyd+I3p9s/wGhNOTspoDn+15i
         yqL10rGng1k+5f0Mqoz0nWpxH20QPaYZEKH+OkemdbdeE3QsSQ98p0wzsA3aS0ppfD7R
         STrwx5whCJ8drSMBnbU963joa8K1DBOX73u310dpVwAlsaQwyHd8UnmseOGi9EalM+w6
         GVAMlDPvYFgZL2AS4DiFglFl91jb/N0zIrxc4IwQW85lOOInGnGlOjWvev8ygiZjn1ER
         Iupw==
X-Gm-Message-State: AOAM532rQK0A2dweO4rkYNqwtSLvw3kOFZpN6/HNQB4UOwJNGgfYSCjq
        oApgYII/taOOmDI0xBh42yA=
X-Google-Smtp-Source: ABdhPJxxFuuObl42co2gFEe+1Vr9rZur5EWHZjUTbB14sDI/vVuQQaNAyTa9n2WmVSlk2SbVOnc+5A==
X-Received: by 2002:a9d:6244:: with SMTP id i4mr735129otk.182.1623265405939;
        Wed, 09 Jun 2021 12:03:25 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p10sm180222otf.45.2021.06.09.12.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 12:03:25 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 9 Jun 2021 12:03:23 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     robh+dt@kernel.org, jdelvare@suse.com, corbet@lwn.net,
        trivial@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, luka.perkov@sartura.hr,
        jmp@epiphyte.org, pmenzel@molgen.mpg.de, buczek@molgen.mpg.de
Subject: Re: [PATCH v4 1/3] hwmon: (pmbus) Add driver for Delta DPS-920AB PSU
Message-ID: <20210609190323.GA2534956@roeck-us.net>
References: <20210607103431.2039073-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210607103431.2039073-1-robert.marko@sartura.hr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2021 at 12:34:29PM +0200, Robert Marko wrote:
> This adds support for the Delta DPS-920AB PSU.
> 
> Only missing feature is fan control which the PSU supports.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>

Series applied.

Thanks,
Guenter

> ---
> Changes in v4:
> * Alphabetically order documentation in index.rst
> * Null terminate manufacturer and mode ID-s
> * Drop debugfs directory and I2C clients from the
> global structure, use local variables
> 
> Changes in v3:
> * Use generic pmbus_read/write_word_data()
> * Correct word data return code
> * Cache PMBUS_MFR_ID and PMBUS_MFR_MODEL instead
> of reading them everytime that debugfs is read
> 
> Changes in v2:
> * Check for Manufacturer and Model
> * Restrict word read/write to supported only
> * Update documentation to reflect driver changes
> * Add basic debugfs entries
> 
>  Documentation/hwmon/dps920ab.rst |  73 +++++++++++
>  Documentation/hwmon/index.rst    |   1 +
>  drivers/hwmon/pmbus/Kconfig      |   9 ++
>  drivers/hwmon/pmbus/Makefile     |   1 +
>  drivers/hwmon/pmbus/dps920ab.c   | 207 +++++++++++++++++++++++++++++++
>  5 files changed, 291 insertions(+)
>  create mode 100644 Documentation/hwmon/dps920ab.rst
>  create mode 100644 drivers/hwmon/pmbus/dps920ab.c
> 
> diff --git a/Documentation/hwmon/dps920ab.rst b/Documentation/hwmon/dps920ab.rst
> new file mode 100644
> index 000000000000..c33b4cdc0a60
> --- /dev/null
> +++ b/Documentation/hwmon/dps920ab.rst
> @@ -0,0 +1,73 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +Kernel driver dps920ab
> +========================
> +
> +Supported chips:
> +
> +  * Delta DPS920AB
> +
> +    Prefix: 'dps920ab'
> +
> +    Addresses scanned: -
> +
> +Authors:
> +    Robert Marko <robert.marko@sartura.hr>
> +
> +
> +Description
> +-----------
> +
> +This driver implements support for Delta DPS920AB 920W 54V DC single output
> +power supply with PMBus support.
> +
> +The driver is a client driver to the core PMBus driver.
> +Please see Documentation/hwmon/pmbus.rst for details on PMBus client drivers.
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
> +Sysfs entries
> +-------------
> +
> +======================= ======================================================
> +curr1_label		"iin"
> +curr1_input		Measured input current
> +curr1_alarm		Input current high alarm
> +
> +curr2_label		"iout1"
> +curr2_input		Measured output current
> +curr2_max		Maximum output current
> +curr2_rated_max		Maximum rated output current
> +
> +in1_label		"vin"
> +in1_input		Measured input voltage
> +in1_alarm		Input voltage alarm
> +
> +in2_label		"vout1"
> +in2_input		Measured output voltage
> +in2_rated_min		Minimum rated output voltage
> +in2_rated_max		Maximum rated output voltage
> +in2_alarm		Output voltage alarm
> +
> +power1_label		"pin"
> +power1_input		Measured input power
> +power1_alarm		Input power high alarm
> +
> +power2_label		"pout1"
> +power2_input		Measured output power
> +power2_rated_max	Maximum rated output power
> +
> +temp[1-3]_input		Measured temperature
> +temp[1-3]_alarm		Temperature alarm
> +
> +fan1_alarm		Fan 1 warning.
> +fan1_fault		Fan 1 fault.
> +fan1_input		Fan 1 speed in RPM.
> +======================= ======================================================
> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> index 8d5a2df1ecb6..8abdaf440a3c 100644
> --- a/Documentation/hwmon/index.rst
> +++ b/Documentation/hwmon/index.rst
> @@ -53,6 +53,7 @@ Hardware Monitoring Kernel Drivers
>     da9055
>     dell-smm-hwmon
>     dme1737
> +   dps920ab
>     drivetemp
>     ds1621
>     ds620
> diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
> index 32d2fc850621..865ade0aa205 100644
> --- a/drivers/hwmon/pmbus/Kconfig
> +++ b/drivers/hwmon/pmbus/Kconfig
> @@ -66,6 +66,15 @@ config SENSORS_IBM_CFFPS
>  	  This driver can also be built as a module. If so, the module will
>  	  be called ibm-cffps.
>  
> +config SENSORS_DPS920AB
> +	tristate "Delta DPS920AB Power Supply"
> +	help
> +	  If you say yes here you get hardware monitoring support for Delta
> +	  DPS920AB Power Supplies.
> +
> +	  This driver can also be built as a module. If so, the module will
> +	  be called dps920ab.
> +
>  config SENSORS_INSPUR_IPSPS
>  	tristate "INSPUR Power System Power Supply"
>  	help
> diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
> index 6a4ba0fdc1db..f59ba0123d68 100644
> --- a/drivers/hwmon/pmbus/Makefile
> +++ b/drivers/hwmon/pmbus/Makefile
> @@ -9,6 +9,7 @@ obj-$(CONFIG_SENSORS_ADM1266)	+= adm1266.o
>  obj-$(CONFIG_SENSORS_ADM1275)	+= adm1275.o
>  obj-$(CONFIG_SENSORS_BEL_PFE)	+= bel-pfe.o
>  obj-$(CONFIG_SENSORS_IBM_CFFPS)	+= ibm-cffps.o
> +obj-$(CONFIG_SENSORS_DPS920AB)	+= dps920ab.o
>  obj-$(CONFIG_SENSORS_INSPUR_IPSPS) += inspur-ipsps.o
>  obj-$(CONFIG_SENSORS_IR35221)	+= ir35221.o
>  obj-$(CONFIG_SENSORS_IR38064)	+= ir38064.o
> diff --git a/drivers/hwmon/pmbus/dps920ab.c b/drivers/hwmon/pmbus/dps920ab.c
> new file mode 100644
> index 000000000000..692a86cdfb6d
> --- /dev/null
> +++ b/drivers/hwmon/pmbus/dps920ab.c
> @@ -0,0 +1,207 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Driver for Delta DPS920AB PSU
> + *
> + * Copyright (C) 2021 Delta Networks, Inc.
> + * Copyright (C) 2021 Sartura Ltd.
> + */
> +
> +#include <linux/debugfs.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include "pmbus.h"
> +
> +struct dps920ab_data {
> +	char *mfr_model;
> +	char *mfr_id;
> +};
> +
> +static int dps920ab_read_word_data(struct i2c_client *client, int page, int phase, int reg)
> +{
> +	/*
> +	 * This masks commands which are not supported.
> +	 * PSU advertises that all features are supported,
> +	 * in reality that unfortunately is not true.
> +	 * So enable only those that the datasheet confirms.
> +	 */
> +	switch (reg) {
> +	case PMBUS_FAN_COMMAND_1:
> +	case PMBUS_IOUT_OC_WARN_LIMIT:
> +	case PMBUS_STATUS_WORD:
> +	case PMBUS_READ_VIN:
> +	case PMBUS_READ_IIN:
> +	case PMBUS_READ_VOUT:
> +	case PMBUS_READ_IOUT:
> +	case PMBUS_READ_TEMPERATURE_1:
> +	case PMBUS_READ_TEMPERATURE_2:
> +	case PMBUS_READ_TEMPERATURE_3:
> +	case PMBUS_READ_FAN_SPEED_1:
> +	case PMBUS_READ_POUT:
> +	case PMBUS_READ_PIN:
> +	case PMBUS_MFR_VOUT_MIN:
> +	case PMBUS_MFR_VOUT_MAX:
> +	case PMBUS_MFR_IOUT_MAX:
> +	case PMBUS_MFR_POUT_MAX:
> +		return pmbus_read_word_data(client, page, phase, reg);
> +	default:
> +		return -ENXIO;
> +	}
> +}
> +
> +static int dps920ab_write_word_data(struct i2c_client *client, int page, int reg,
> +				    u16 word)
> +{
> +	/*
> +	 * This masks commands which are not supported.
> +	 * PSU only has one R/W register and that is
> +	 * for the fan.
> +	 */
> +	switch (reg) {
> +	case PMBUS_FAN_COMMAND_1:
> +		return pmbus_write_word_data(client, page, reg, word);
> +	default:
> +		return -EACCES;
> +	}
> +}
> +
> +static struct pmbus_driver_info dps920ab_info = {
> +	.pages = 1,
> +
> +	.format[PSC_VOLTAGE_IN] = linear,
> +	.format[PSC_VOLTAGE_OUT] = linear,
> +	.format[PSC_CURRENT_IN] = linear,
> +	.format[PSC_CURRENT_OUT] = linear,
> +	.format[PSC_POWER] = linear,
> +	.format[PSC_FAN] = linear,
> +	.format[PSC_TEMPERATURE] = linear,
> +
> +	.func[0] =
> +		PMBUS_HAVE_VIN | PMBUS_HAVE_IIN | PMBUS_HAVE_PIN |
> +		PMBUS_HAVE_VOUT | PMBUS_HAVE_IOUT | PMBUS_HAVE_POUT |
> +		PMBUS_HAVE_TEMP  | PMBUS_HAVE_TEMP2 | PMBUS_HAVE_TEMP3 |
> +		PMBUS_HAVE_FAN12 | PMBUS_HAVE_STATUS_FAN12 |
> +		PMBUS_HAVE_STATUS_VOUT | PMBUS_HAVE_STATUS_IOUT |
> +		PMBUS_HAVE_STATUS_INPUT | PMBUS_HAVE_STATUS_TEMP,
> +	.read_word_data = dps920ab_read_word_data,
> +	.write_word_data = dps920ab_write_word_data,
> +};
> +
> +static int dps920ab_mfr_id_show(struct seq_file *s, void *data)
> +{
> +	struct dps920ab_data *priv = s->private;
> +
> +	seq_printf(s, "%s\n", priv->mfr_id);
> +
> +	return 0;
> +}
> +
> +DEFINE_SHOW_ATTRIBUTE(dps920ab_mfr_id);
> +
> +static int dps920ab_mfr_model_show(struct seq_file *s, void *data)
> +{
> +	struct dps920ab_data *priv = s->private;
> +
> +	seq_printf(s, "%s\n", priv->mfr_model);
> +
> +	return 0;
> +}
> +
> +DEFINE_SHOW_ATTRIBUTE(dps920ab_mfr_model);
> +
> +static void dps920ab_init_debugfs(struct dps920ab_data *data, struct i2c_client *client)
> +{
> +	struct dentry *debugfs_dir;
> +	struct dentry *root;
> +
> +	root = pmbus_get_debugfs_dir(client);
> +	if (!root)
> +		return;
> +
> +	debugfs_dir = debugfs_create_dir(client->name, root);
> +	if (!debugfs_dir)
> +		return;
> +
> +	debugfs_create_file("mfr_id",
> +			    0400,
> +			    debugfs_dir,
> +			    data,
> +			    &dps920ab_mfr_id_fops);
> +
> +	debugfs_create_file("mfr_model",
> +			    0400,
> +			    debugfs_dir,
> +			    data,
> +			    &dps920ab_mfr_model_fops);
> +}
> +
> +static int dps920ab_probe(struct i2c_client *client)
> +{
> +	u8 buf[I2C_SMBUS_BLOCK_MAX + 1];
> +	struct dps920ab_data *data;
> +	int ret;
> +
> +	data = devm_kzalloc(&client->dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	ret = i2c_smbus_read_block_data(client, PMBUS_MFR_ID, buf);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "Failed to read Manufacturer ID\n");
> +		return ret;
> +	}
> +
> +	buf[ret] = '\0';
> +	if (ret != 5 || strncmp(buf, "DELTA", 5)) {
> +		buf[ret] = '\0';
> +		dev_err(&client->dev, "Unsupported Manufacturer ID '%s'\n", buf);
> +		return -ENODEV;
> +	}
> +	data->mfr_id = devm_kstrdup(&client->dev, buf, GFP_KERNEL);
> +	if (!data->mfr_id)
> +		return -ENOMEM;
> +
> +	ret = i2c_smbus_read_block_data(client, PMBUS_MFR_MODEL, buf);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "Failed to read Manufacturer Model\n");
> +		return ret;
> +	}
> +
> +	buf[ret] = '\0';
> +	if (ret != 11 || strncmp(buf, "DPS-920AB", 9)) {
> +		dev_err(&client->dev, "Unsupported Manufacturer Model '%s'\n", buf);
> +		return -ENODEV;
> +	}
> +	data->mfr_model = devm_kstrdup(&client->dev, buf, GFP_KERNEL);
> +	if (!data->mfr_model)
> +		return -ENOMEM;
> +
> +	ret = pmbus_do_probe(client, &dps920ab_info);
> +	if (ret)
> +		return ret;
> +
> +	dps920ab_init_debugfs(data, client);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id __maybe_unused dps920ab_of_match[] = {
> +	{ .compatible = "delta,dps920ab", },
> +	{}
> +};
> +
> +MODULE_DEVICE_TABLE(of, dps920ab_of_match);
> +
> +static struct i2c_driver dps920ab_driver = {
> +	.driver = {
> +		   .name = "dps920ab",
> +		   .of_match_table = of_match_ptr(dps920ab_of_match),
> +	},
> +	.probe_new = dps920ab_probe,
> +};
> +
> +module_i2c_driver(dps920ab_driver);
> +
> +MODULE_AUTHOR("Robert Marko <robert.marko@sartura.hr>");
> +MODULE_DESCRIPTION("PMBus driver for Delta DPS920AB PSU");
> +MODULE_LICENSE("GPL");
> -- 
> 2.31.1
> 
