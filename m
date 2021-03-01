Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD972327650
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 04:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbhCADHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Feb 2021 22:07:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbhCADHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Feb 2021 22:07:20 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6060C06174A;
        Sun, 28 Feb 2021 19:06:39 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id k13so15077182otn.13;
        Sun, 28 Feb 2021 19:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PQy9DUga17dC1j5lhL+chR7q1K2xLcHK/hnkUXVcO08=;
        b=Q7UTs4XWQBFvDtVQTSJfkldtqIH4+5RCUlADZhPaB4DpFpy5D4PJzqMteXxIngSkhu
         II3LwSiOhEHX7cFp9hmXbMPHppmr5/02ou1hlmKVYTQvtpopoHj1saHLpVGNnMihrXRi
         XTIuv0knu09fpUfBiS/OoaXOfq6Wwyf9B+O+2/G3759EhF44fBBg3jXKvI0pFAKstNt2
         cS+TN+dA8EhBcg5OgXgVSujgqQ4eWsJZNZB1xXfLgm8yYdi5T+GLctDNiigGGeb4iMtD
         G9MM+QMZS1hQ2y5kvJDZH4QvSqoajxJiCU+kS3vO70TxL2R7FhvI88bSRZ+FP8DQziuM
         w30Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=PQy9DUga17dC1j5lhL+chR7q1K2xLcHK/hnkUXVcO08=;
        b=VZ6f9Lz+HZQ/f2l05W4Rm3jNIRapI9VmxYk9ZlZAPI1HhnVKfB9hFhDopTzUwvpiA3
         lXubnH5p5sL4Lt+eWCZ6K7XRT7CGQQQ38kskC1cfX/CUmzhAJESzzJ7o6q4ZUb0d6tsq
         c0UNwu4HcuYWTJDX0R0vrMhvZQsoGV/JR4z4U1v+ouNjGPmwa6f75sr51fJ1lOWZaUDN
         AxRTS0JTFf2Naf9jcgJfu1OJfv1BEGxSrAEmdHzMDuqJpBKm1tKLJ9slABv/EK29VG/A
         jVhJkn6Vli7BhEdhdH+87Oel/NxmYShDJadAi5XdKvLdOSSF84qDQhsEGDdhH6KrAeso
         fQJQ==
X-Gm-Message-State: AOAM530J0Xi1/vIrlNvOeORLawZmawrQqu260+llPmRUdpwEVY+pl9+I
        XZnifOokhUkvGqmFKOfmjDWVaZcUP1Q=
X-Google-Smtp-Source: ABdhPJwzk101cktBuXfGI9+eTixwatJ6ER183fa7rvUh/rqsJbTbimjO1AjuJ4BQ1ugEmuowepE7Qg==
X-Received: by 2002:a9d:4d0f:: with SMTP id n15mr11304008otf.134.1614567998777;
        Sun, 28 Feb 2021 19:06:38 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 43sm3525771otv.69.2021.02.28.19.06.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Feb 2021 19:06:38 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH 2/2] hwmon: (pmbus): Add driver for Infineon IR36021
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>,
        robh+dt@kernel.org, jdelvare@suse.com
Cc:     devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
References: <20210228230714.26578-1-chris.packham@alliedtelesis.co.nz>
 <20210228230714.26578-3-chris.packham@alliedtelesis.co.nz>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <f617d277-0ac9-3a7a-198f-ae2312ca4e86@roeck-us.net>
Date:   Sun, 28 Feb 2021 19:06:35 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210228230714.26578-3-chris.packham@alliedtelesis.co.nz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

On 2/28/21 3:07 PM, Chris Packham wrote:
> The IR36021 is a dual‐loop digital multi‐phase buck controller.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>  Documentation/hwmon/index.rst   |  1 +
>  Documentation/hwmon/ir36021.rst | 62 +++++++++++++++++++++++++
>  drivers/hwmon/pmbus/Kconfig     |  9 ++++
>  drivers/hwmon/pmbus/Makefile    |  1 +
>  drivers/hwmon/pmbus/ir36021.c   | 81 +++++++++++++++++++++++++++++++++
>  5 files changed, 154 insertions(+)
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
> index 000000000000..99b5c7311afd
> --- /dev/null
> +++ b/drivers/hwmon/pmbus/ir36021.c
> @@ -0,0 +1,81 @@
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
> +static int ir36021_probe(struct i2c_client *client,
> +			 const struct i2c_device_id *id)
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
> +	if (ret != 2 || !(buf[0] == 0x01 || buf[1] == 0x2d)) {

Please use
			buf[0] != 0x01 || buf[1] != 0x2d

I am not a friend of double negations and find it confusing.

> +		dev_err(&client->dev, "MFR_MODEL unrecognised\n");
> +		return -ENODEV;
> +	}
> +
> +	return pmbus_do_probe(client, id, &ir36021_info);

Please rebase to the latest upstream kernel (parameter change).

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
> +	.probe = ir36021_probe,

Please use the .probe_new callback.

> +	.remove = pmbus_do_remove,

pmbus_do_remove is no longer needed (and does not exist anymore).

Thanks,
Guenter

> +	.id_table = ir36021_id,
> +};
> +
> +module_i2c_driver(ir36021_driver);
> +
> +MODULE_AUTHOR("Chris Packham <chris.packham@alliedtelesis.co.nz>");
> +MODULE_DESCRIPTION("PMBus driver for Infineon IR36021");
> +MODULE_LICENSE("GPL");
> 

