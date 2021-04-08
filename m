Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97B11358944
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 18:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232253AbhDHQHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 12:07:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25379 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231875AbhDHQHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 12:07:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617898057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uB6u1YzjbtDyPwkHUv1YZOjRf0ydZhgxNGQbVLUWhBg=;
        b=hXJ5J518nTRc7iIVq923xi7Godjsu3fJmLoFuyelacPwqJguvty6wGr7WzcB9fgs607AJN
        V8fCUAO2OaQQTcLIcXuTyYRfI4ogwvLJU6oEjrL5D0XZoRXPJ/BoHLwRz2ikduxcNaPWut
        jrbitPWzipCOuMfBJ/FxiIkTjEuIhuc=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-602-qrZeZWMeNIumtimH4tzXjQ-1; Thu, 08 Apr 2021 12:07:36 -0400
X-MC-Unique: qrZeZWMeNIumtimH4tzXjQ-1
Received: by mail-ed1-f71.google.com with SMTP id a8so1272402edt.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 09:07:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uB6u1YzjbtDyPwkHUv1YZOjRf0ydZhgxNGQbVLUWhBg=;
        b=f2s6iA8awUoE2zFUckVXBm/A+3Rq8A8n1l8V/g3mTfhH3INC9pEQqFR03kgRyo3SB8
         moJeMOXEcyTaX4zk498t7IbJwL+B0n8LT/mA6gge9TYZXnJjLviZubxLeYKLyDP/YU8D
         JMFmBqEsYXEhFFIkG6IUc/SOb7QYJ8Bhdoc1kZ8aOR7vZ/bEYoN3mYNTMfvIiqmpZRSP
         rjxmhX7GuFPtFr/7HKSe5XB/OmK2A+GXMue/HhpL47DZOA9nd3qX4Ltbb6pd5WTIG0BO
         D5rJ1FP08G++glsJ6lBcfY/gnKy5MjSF6FQX8kAofQtc0n2VqnnplJH1MQ800vw6bjul
         Z/CA==
X-Gm-Message-State: AOAM533qYMYjeoSOY4qVXriBH1C/jhza7j5DR2ZW+Y7mN9H5p1Hj3w53
        ENAzH5xok3rbVIjX3OL1eKvYxEWfNeNupYXUAKkg4utzFMemGWWBOf8P6Qcwcd68SVnd2EmWarS
        JM7QV4NDszk6FTG3zfbXxZt2j
X-Received: by 2002:a17:906:1b45:: with SMTP id p5mr9907461ejg.215.1617898054921;
        Thu, 08 Apr 2021 09:07:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJybi20bHncsNFA3bB27/6pzAIHvx1q7rUM3wkyQ2XHHj1YwkXCAq/StConXdE+HGvrMpOgRYw==
X-Received: by 2002:a17:906:1b45:: with SMTP id p5mr9907439ejg.215.1617898054615;
        Thu, 08 Apr 2021 09:07:34 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id x4sm17086880edd.58.2021.04.08.09.07.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Apr 2021 09:07:34 -0700 (PDT)
Subject: Re: [PATCH v2] platform/x86: add Gigabyte WMI temperature driver
To:     Guenter Roeck <linux@roeck-us.net>,
        =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>
Cc:     platform-driver-x86@vger.kernel.org,
        Mark Gross <mgross@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Barnab=c3=a1s_P=c5=91cze?= <pobrn@protonmail.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>
References: <N6sOrC__lJeA1mtEKUtB18DPy9hp5bSjL9rq1TfOXiRE7IAO5aih5oyPEpq-vyqdZZsF4W8FIe-9GWB15lO-3fQlqjWQrMTlTJvqLBBGYOQ=@protonmail.com>
 <20210405204810.339763-1-linux@weissschuh.net>
 <20210408150821.GA205657@roeck-us.net>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <245fe6eb-b188-ee50-bf75-8a16fe8f5d67@redhat.com>
Date:   Thu, 8 Apr 2021 18:07:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210408150821.GA205657@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

On 4/8/21 5:08 PM, Guenter Roeck wrote:
> On Mon, Apr 05, 2021 at 10:48:10PM +0200, Thomas Weißschuh wrote:
>> Changes since v1:
>> * Incorporate feedback from Barnabás Pőcze
>>   * Use a WMI driver instead of a platform driver
>>   * Let the kernel manage the driver lifecycle
>>   * Fix errno/ACPI error confusion
>>   * Fix resource cleanup
>>   * Document reason for integer casting
>>
>> Thank you Barnabás for your review, it is much appreciated.
>>
>> -- >8 --
>>
>> Tested with a X570 I Aorus Pro Wifi.
>> The mainboard contains an ITE IT8688E chip for management.
>> This chips is also handled by drivers/hwmon/i87.c but as it is also used
>> by the firmware itself it needs an ACPI driver.
>>
>> Unfortunately not all sensor registers are handled by the firmware and even
>> less are exposed via WMI.
>>
>> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
>> ---
>>  drivers/platform/x86/Kconfig        |  11 +++
>>  drivers/platform/x86/Makefile       |   1 +
>>  drivers/platform/x86/gigabyte-wmi.c | 138 ++++++++++++++++++++++++++++
> 
> Originally drivers/platform was supposed to be used for platform specific
> code. Not that I have control over it, but I really dislike that more and
> more hwmon drivers end up there.
> 
> At least hwmon is in good company - I see drivers for various other subsystems
> there as well. I just wonder if that is such a good idea. That entire directory
> is bypassing subsystem maintainer reviews.

In case you are not aware I've recent(ish) taken over the drivers/platform/x86
maintainership from Andy Shevchenko.

Yes it is a bit of an odd grab-bag it mostly deals with vendor specific
ACPI / WMI interfaces which often more or less require using a single
driver while offering multiple functionalities. These firmware interfaces
do not really lend themselves to demultiplexing through something like
MFD. These are mostly found on laptops where they deal with some or all of:

- Hotkeys for brightness adjust / wlan-on/off toggle, touchpad on/off toggle, etc.
  (input subsystem stuff)
- Mic. / Speaker mute LEDS (and other special LEDs) found on some laptops
  (LED subsystem stuff)
- Enabling/disabling radios
  (rfkill stuff)
- Controlling the DPTF performance profile
  (ACPI stuff)
- Various sensors, some hwmon, some IIO
- Backlight control (drm/kms subsys)
- Enabling/disabling of LCD-builtin privacy filters (requires KMS/DRM subsys integration, pending)
- Fan control (hwmon subsys)

And often all of this in a single driver. This is all "stuff" for which
there are no standard APIs shared between vendors, so it is a free for
all and often it is all stuffed behind a single WMI or ACPI object,
because that is how the vendor's drivers under Windows work.

It certainly is not my intention to bypass review by other subsystem
maintainers and when there are significant questions I do try to always
get other subsys maintainers involved. See e.g. this thread, but also the
"[PATCH 1/3] thinkpad_acpi: add support for force_discharge" thread
where I asked for input from sre for the power-supply aspects of that.

The WMI code was reworked a while back to make WMI be a bus and have
individual WMI objects be devices on that bus. version 2 of this
driver has been reworked to use this. Since this new driver is just a hwmon
driver and as this is for a desktop I expect it will stay that way,
I'm fine with moving this one over to drivers/hwmon if that has your
preference.

As for other cases then this driver, if you want to make sure you are at
least Cc-ed on all hwmon related changes I'm fine with adding you as a
reviewer to the pdx86 MAINTAINERS entry.

Regards,

Hans




> 
> Guenter
> 
>>  3 files changed, 150 insertions(+)
>>  create mode 100644 drivers/platform/x86/gigabyte-wmi.c
>>
>> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
>> index ad4e630e73e2..96622a2106f7 100644
>> --- a/drivers/platform/x86/Kconfig
>> +++ b/drivers/platform/x86/Kconfig
>> @@ -123,6 +123,17 @@ config XIAOMI_WMI
>>  	  To compile this driver as a module, choose M here: the module will
>>  	  be called xiaomi-wmi.
>>  
>> +config GIGABYTE_WMI
>> +	tristate "Gigabyte WMI temperature driver"
>> +	depends on ACPI_WMI
>> +	depends on HWMON
>> +	help
>> +	  Say Y here if you want to support WMI-based temperature reporting on
>> +	  Gigabyte mainboards.
>> +
>> +	  To compile this driver as a module, choose M here: the module will
>> +	  be called gigabyte-wmi.
>> +
>>  config ACERHDF
>>  	tristate "Acer Aspire One temperature and fan driver"
>>  	depends on ACPI && THERMAL
>> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
>> index 60d554073749..1621ebfd04fd 100644
>> --- a/drivers/platform/x86/Makefile
>> +++ b/drivers/platform/x86/Makefile
>> @@ -15,6 +15,7 @@ obj-$(CONFIG_INTEL_WMI_THUNDERBOLT)	+= intel-wmi-thunderbolt.o
>>  obj-$(CONFIG_MXM_WMI)			+= mxm-wmi.o
>>  obj-$(CONFIG_PEAQ_WMI)			+= peaq-wmi.o
>>  obj-$(CONFIG_XIAOMI_WMI)		+= xiaomi-wmi.o
>> +obj-$(CONFIG_GIGABYTE_WMI)		+= gigabyte-wmi.o
>>  
>>  # Acer
>>  obj-$(CONFIG_ACERHDF)		+= acerhdf.o
>> diff --git a/drivers/platform/x86/gigabyte-wmi.c b/drivers/platform/x86/gigabyte-wmi.c
>> new file mode 100644
>> index 000000000000..8618363e3ccf
>> --- /dev/null
>> +++ b/drivers/platform/x86/gigabyte-wmi.c
>> @@ -0,0 +1,138 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + *  Copyright (C) 2021 Thomas Weißschuh <thomas@weissschuh.net>
>> + */
>> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>> +
>> +#include <linux/acpi.h>
>> +#include <linux/hwmon.h>
>> +#include <linux/module.h>
>> +#include <linux/wmi.h>
>> +
>> +#define GIGABYTE_WMI_GUID "DEADBEEF-2001-0000-00A0-C90629100000"
>> +
>> +enum gigabyte_wmi_commandtype {
>> +	GIGABYTE_WMI_BUILD_DATE_QUERY       =   0x1,
>> +	GIGABYTE_WMI_MAINBOARD_TYPE_QUERY   =   0x2,
>> +	GIGABYTE_WMI_FIRMWARE_VERSION_QUERY =   0x4,
>> +	GIGABYTE_WMI_MAINBOARD_NAME_QUERY   =   0x5,
>> +	GIGABYTE_WMI_TEMPERATURE_QUERY      = 0x125,
>> +};
>> +
>> +struct gigabyte_wmi_args {
>> +	u32 arg1;
>> +};
>> +
>> +static int gigabyte_wmi_perform_query(enum gigabyte_wmi_commandtype command,
>> +		struct gigabyte_wmi_args *args, struct acpi_buffer *out)
>> +{
>> +	const struct acpi_buffer in = {
>> +		.length = sizeof(*args),
>> +		.pointer = args,
>> +	};
>> +
>> +	acpi_status ret = wmi_evaluate_method(GIGABYTE_WMI_GUID, 0x0, command, &in, out);
>> +	if (ret == AE_OK) {
>> +		return 0;
>> +	} else {
>> +		return -EIO;
>> +	};
>> +}
>> +
>> +static int gigabyte_wmi_query_integer(enum gigabyte_wmi_commandtype command,
>> +		struct gigabyte_wmi_args *args, u64 *res)
>> +{
>> +	union acpi_object *obj;
>> +	struct acpi_buffer result = { ACPI_ALLOCATE_BUFFER, NULL };
>> +	int ret;
>> +
>> +	ret = gigabyte_wmi_perform_query(command, args, &result);
>> +	if (ret) {
>> +		goto out;
>> +	}
>> +	obj = result.pointer;
>> +	if (obj && obj->type == ACPI_TYPE_INTEGER) {
>> +		*res = obj->integer.value;
>> +		ret = 0;
>> +	} else {
>> +		ret = -EIO;
>> +	}
>> +out:
>> +	kfree(result.pointer);
>> +	return ret;
>> +}
>> +
>> +static int gigabyte_wmi_temperature(u8 sensor, long *res)
>> +{
>> +	struct gigabyte_wmi_args args = {
>> +		.arg1 = sensor,
>> +	};
>> +	u64 temp;
>> +	acpi_status ret;
>> +
>> +	ret = gigabyte_wmi_query_integer(GIGABYTE_WMI_TEMPERATURE_QUERY, &args, &temp);
>> +	if (ret == 0)
>> +		*res = (s8) temp * 1000; // value is a signed 8-bit integer
>> +	return ret;
>> +}
>> +
>> +static int gigabyte_wmi_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
>> +		u32 attr, int channel, long *val)
>> +{
>> +	return gigabyte_wmi_temperature(channel, val);
>> +}
>> +
>> +static umode_t gigabyte_wmi_hwmon_is_visible(const void *data, enum hwmon_sensor_types type,
>> +		u32 attr, int channel)
>> +{
>> +	return 0444;
>> +}
>> +
>> +static const struct hwmon_channel_info *gigabyte_wmi_hwmon_info[] = {
>> +	HWMON_CHANNEL_INFO(temp,
>> +			HWMON_T_INPUT,
>> +			HWMON_T_INPUT,
>> +			HWMON_T_INPUT,
>> +			HWMON_T_INPUT,
>> +			HWMON_T_INPUT,
>> +			HWMON_T_INPUT),
>> +	NULL,
>> +};
>> +
>> +static const struct hwmon_ops gigabyte_wmi_hwmon_ops = {
>> +	.read = gigabyte_wmi_hwmon_read,
>> +	.is_visible = gigabyte_wmi_hwmon_is_visible,
>> +};
>> +
>> +static const struct hwmon_chip_info gigabyte_wmi_hwmon_chip_info = {
>> +	.ops = &gigabyte_wmi_hwmon_ops,
>> +	.info = gigabyte_wmi_hwmon_info,
>> +};
>> +
>> +static int gigabyte_wmi_probe(struct wmi_device *wdev, const void *context)
>> +{
>> +	struct device *hwmon_dev = devm_hwmon_device_register_with_info(&wdev->dev,
>> +			"gigabyte_wmi", NULL,
>> +			&gigabyte_wmi_hwmon_chip_info, NULL);
>> +
>> +	return PTR_ERR_OR_ZERO(hwmon_dev);
>> +}
>> +
>> +static const struct wmi_device_id gigabyte_wmi_id_table[] = {
>> +	{ GIGABYTE_WMI_GUID, NULL },
>> +	{ },
>> +};
>> +
>> +static struct wmi_driver gigabyte_wmi_driver = {
>> +	.driver = {
>> +		.name = "gigabyte-wmi",
>> +	},
>> +	.id_table = gigabyte_wmi_id_table,
>> +	.probe = gigabyte_wmi_probe,
>> +};
>> +module_wmi_driver(gigabyte_wmi_driver);
>> +
>> +MODULE_DEVICE_TABLE(wmi, gigabyte_wmi_id_table);
>> +MODULE_AUTHOR("Thomas Weißschuh <thomas@weissschuh.net>");
>> +MODULE_DESCRIPTION("Gigabyte Temperature WMI Driver");
>> +MODULE_LICENSE("GPL");
>>
>> base-commit: 144c79ef33536b4ecb4951e07dbc1f2b7fa99d32
>> -- 
>> 2.31.1
>>
> 

