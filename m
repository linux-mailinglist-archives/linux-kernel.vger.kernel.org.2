Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D15835AECD
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 17:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234813AbhDJPV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 11:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234392AbhDJPVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 11:21:25 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5DCC06138A;
        Sat, 10 Apr 2021 08:21:10 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id h2-20020a4ad7420000b02901e5901169a5so1809954oot.8;
        Sat, 10 Apr 2021 08:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pjI6u6UYsUkFtZQA7WTP9+7XiMaMvTGfuvAt/AdrZpE=;
        b=ul9vhkECX9ZtPHmn00cPAEOTNPFYMkc4vVlLAdFgA0ImSW2Yz/cqrLDDaCbiQGf+w/
         cNN/cJTUA3sTYVW/YkL5D1AA1ok8DUy85P8GF4gXn/leQJkhfAGBrrvX1nC7Kaec1G7+
         e61ykR7cz8w/E/vSLqXxmvfWwd440ktxmCcZnLkt8Y3ZwTrWh8WWSGIKb/GBSIOJzCgR
         Y0ViOfNDoLzXwgwqXMkSWZlo6DM69YqZoFZ4haMYgvIWc7XEE2DpZbxn4TijMBMhIyiu
         G75fXKIOgX+3JbJC9W4XTrVV45ozMDg3U6lX4V3iQxrIEvbBEjatrt2wbFJ5wPgsGhJg
         GTqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=pjI6u6UYsUkFtZQA7WTP9+7XiMaMvTGfuvAt/AdrZpE=;
        b=Lb4bkC/XC4ucs+g74pa0bUNjo9rbfds70aH3RDWW1z3GKm012rOF5ncfnVur5GprDT
         /FSzwU+INB5UGVBm4Xg0flPvRjlCWY2g/534xkqk7ew7+dpTIEwLYQqENOTlBCHI0O1s
         5CaXdgbaiBGPY5BZJEsaV4F+A110X5XuVM6hZnQ+g/vmyM4ApQpWm4pMgymb7jXv3hff
         vMLYcZiDYP515Cvd0uCVgNbvWRJjEcRG6vp06+kgELD2YHpyMBOc5rtZR2SleQhXNyEu
         ghRB7PSU6kwMDEm5KKdMSR19nMy2CpCjugobPnIvt9ssJuK7DTSLjGugVjgghnYWe0iF
         skuw==
X-Gm-Message-State: AOAM531fImHjHc4ir391CHsP6fyaDvsYBF21i7luRLRp5Lpz27Si9TPs
        TInLjdMxe6YUhBP+JD7OZLNkXTVdZoM=
X-Google-Smtp-Source: ABdhPJw+BlPSHq6JzuPgNUDjljHiuRm/+F7JCpOhqwtHwoIWLfUdHIl2EnT9QNcRd4/2zSxeljK2EA==
X-Received: by 2002:a4a:bd1a:: with SMTP id n26mr16097535oop.45.1618068069960;
        Sat, 10 Apr 2021 08:21:09 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v65sm1164166oib.42.2021.04.10.08.21.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Apr 2021 08:21:09 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v3] platform/x86: add Gigabyte WMI temperature driver
To:     Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
        platform-driver-x86@vger.kernel.org,
        Mark Gross <mgross@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Barnab=c3=a1s_P=c5=91cze?= <pobrn@protonmail.com>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org
Cc:     Matthew Garrett <mjg59@srcf.ucam.org>
References: <117cadef-c1cb-d66a-15f8-ce50d596be4b@redhat.com>
 <20210410144021.138035-1-linux@weissschuh.net>
 <e1b86746-b04d-0f14-8121-d24da4d10ceb@redhat.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <2ffc9df4-f5d1-e093-6223-e6c705ef8688@roeck-us.net>
Date:   Sat, 10 Apr 2021 08:21:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e1b86746-b04d-0f14-8121-d24da4d10ceb@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/10/21 7:57 AM, Hans de Goede wrote:
> Hi,
> 
> On 4/10/21 4:40 PM, Thomas Weißschuh wrote:
>> Changes since v1:
>> * Incorporate feedback from Barnabás Pőcze
>>   * Use a WMI driver instead of a platform driver
>>   * Let the kernel manage the driver lifecycle
>>   * Fix errno/ACPI error confusion
>>   * Fix resource cleanup
>>   * Document reason for integer casting
>>
>> Changes since v2:
>> * Style cleanups
>> * Test for usability during probing
>> * DMI-based whitelist
>> * CC hwmon maintainers
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
> 
> This looks good, one small nitpick:
> 
> I know this is a touchy subject for some, but we are trying to move away
> from the whitelist/blacklist naming where possible and we don't want to
> introduce any new cases, see:
> 
> https://github.com/torvalds/linux/blob/master/Documentation/process/coding-style.rst#4-naming
> 
> The driver currently uses this twice:
> "Force loading on non-whitelisted platform"
> "Forcing loading on non-whitelisted platform"
> 
> Interestingly enough you already avoided naming the dmi_system_id table
> a whitelist (good).
> 
> I would like to see "non-whitelisted" replaced with "unknown" so that we end up with:
> 
> "Force loading on unknown platform"
> "Forcing loading on unknown platform"
> 
> And while at it, I think for the second sentence this would be better English
> (I'm not a native speaker myself):
> 
> "Forcing load on unknown platform"
> 

Not native either, but I think it is either "Forcing load" or "Force loading".

> If you are ok with these changes I can fix this up while merging, no need
> to send a v4. Although if you prefer to send a v4 that is fine too.
> 

Please consider adding an existence check into the is_visible function.
Sysfs attributes for non-existing sensors should not be created.

Thanks,
Guenter

> Either way let me know.
> 
> Regards,
> 
> Hans
> 
> p.s.
> 
> For v4 or for a next patch, the way to add the changelog so that it does
> not get picked up / automatically gets snipped by git am is to put it
> below the Signed-off-by at the end of the commit message like this:
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
> Changes since v1:
> * Incorporate feedback from Barnabás Pőcze
>   * Use a WMI driver instead of a platform driver
>   * Let the kernel manage the driver lifecycle
>   * Fix errno/ACPI error confusion
>   * Fix resource cleanup
>   * Document reason for integer casting
>  
> Changes since v2:
> * Style cleanups
> * Test for usability during probing
> * DMI-based whitelist
> * CC hwmon maintainers
> 
> 
> 
> 
> 
> 
> 
>> ---
>>  MAINTAINERS                         |   6 +
>>  drivers/platform/x86/Kconfig        |  11 ++
>>  drivers/platform/x86/Makefile       |   1 +
>>  drivers/platform/x86/gigabyte-wmi.c | 194 ++++++++++++++++++++++++++++
>>  4 files changed, 212 insertions(+)
>>  create mode 100644 drivers/platform/x86/gigabyte-wmi.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index d92f85ca831d..9c10cfc00fe8 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -7543,6 +7543,12 @@ F:	Documentation/filesystems/gfs2*
>>  F:	fs/gfs2/
>>  F:	include/uapi/linux/gfs2_ondisk.h
>>  
>> +GIGABYTE WMI DRIVER
>> +M:	Thomas Weißschuh <linux@weissschuh.net>
>> +L:	platform-driver-x86@vger.kernel.org
>> +S:	Maintained
>> +F:	drivers/platform/x86/gigabyte-wmi.c
>> +
>>  GNSS SUBSYSTEM
>>  M:	Johan Hovold <johan@kernel.org>
>>  S:	Maintained
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
>> index 000000000000..fb4e6d4c1823
>> --- /dev/null
>> +++ b/drivers/platform/x86/gigabyte-wmi.c
>> @@ -0,0 +1,194 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + *  Copyright (C) 2021 Thomas Weißschuh <thomas@weissschuh.net>
>> + */
>> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>> +
>> +#include <linux/acpi.h>
>> +#include <linux/dmi.h>
>> +#include <linux/hwmon.h>
>> +#include <linux/module.h>
>> +#include <linux/wmi.h>
>> +
>> +#define GIGABYTE_WMI_GUID "DEADBEEF-2001-0000-00A0-C90629100000"
>> +#define NUM_TEMPERATURE_SENSORS 6
>> +
>> +static bool force_load;
>> +module_param(force_load, bool, 0);
>> +MODULE_PARM_DESC(force_load, "Force loading on non-whitelisted platform");
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
>> +static int gigabyte_wmi_perform_query(struct wmi_device *wdev,
>> +				      enum gigabyte_wmi_commandtype command,
>> +				      struct gigabyte_wmi_args *args, struct acpi_buffer *out)
>> +{
>> +	const struct acpi_buffer in = {
>> +		.length = sizeof(*args),
>> +		.pointer = args,
>> +	};
>> +
>> +	acpi_status ret = wmidev_evaluate_method(wdev, 0x0, command, &in, out);
>> +
>> +	if ACPI_FAILURE(ret)
>> +		return -EIO;
>> +
>> +	return 0;
>> +}
>> +
>> +static int gigabyte_wmi_query_integer(struct wmi_device *wdev,
>> +				      enum gigabyte_wmi_commandtype command,
>> +				      struct gigabyte_wmi_args *args, u64 *res)
>> +{
>> +	union acpi_object *obj;
>> +	struct acpi_buffer result = { ACPI_ALLOCATE_BUFFER, NULL };
>> +	int ret;
>> +
>> +	ret = gigabyte_wmi_perform_query(wdev, command, args, &result);
>> +	if (ret)
>> +		return ret;
>> +	obj = result.pointer;
>> +	if (obj && obj->type == ACPI_TYPE_INTEGER)
>> +		*res = obj->integer.value;
>> +	else
>> +		ret = -EIO;
>> +	kfree(result.pointer);
>> +	return ret;
>> +}
>> +
>> +static int gigabyte_wmi_temperature(struct wmi_device *wdev, u8 sensor, long *res)
>> +{
>> +	struct gigabyte_wmi_args args = {
>> +		.arg1 = sensor,
>> +	};
>> +	u64 temp;
>> +	acpi_status ret;
>> +
>> +	ret = gigabyte_wmi_query_integer(wdev, GIGABYTE_WMI_TEMPERATURE_QUERY, &args, &temp);
>> +	if (ret == 0) {
>> +		if (temp == 0)
>> +			return -ENODEV;
>> +		*res = (s8)temp * 1000; // value is a signed 8-bit integer
>> +	}
>> +	return ret;
>> +}
>> +
>> +static int gigabyte_wmi_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
>> +				   u32 attr, int channel, long *val)
>> +{
>> +	struct wmi_device *wdev = dev_get_drvdata(dev);
>> +
>> +	return gigabyte_wmi_temperature(wdev, channel, val);
>> +}
>> +
>> +static umode_t gigabyte_wmi_hwmon_is_visible(const void *data, enum hwmon_sensor_types type,
>> +					     u32 attr, int channel)
>> +{
>> +	return 0444;
>> +}
>> +
>> +static const struct hwmon_channel_info *gigabyte_wmi_hwmon_info[] = {
>> +	HWMON_CHANNEL_INFO(temp,
>> +			   HWMON_T_INPUT,
>> +			   HWMON_T_INPUT,
>> +			   HWMON_T_INPUT,
>> +			   HWMON_T_INPUT,
>> +			   HWMON_T_INPUT,
>> +			   HWMON_T_INPUT),
>> +	NULL
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
>> +static int gigabyte_wmi_validate_sensor_presence(struct wmi_device *wdev)
>> +{
>> +	int working_sensors = 0, i;
>> +	long temp;
>> +
>> +	for (i = 0; i < NUM_TEMPERATURE_SENSORS; i++) {
>> +		if (!gigabyte_wmi_temperature(wdev, i, &temp))
>> +			working_sensors++;
>> +	}
>> +	return working_sensors ? 0 : -ENODEV;
>> +}
>> +
>> +static const struct dmi_system_id gigabyte_wmi_known_working_platforms[] = {
>> +	{ .matches = {
>> +		DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "Gigabyte Technology Co., Ltd."),
>> +		DMI_EXACT_MATCH(DMI_BOARD_NAME, "B550 GAMING X V2"),
>> +	}},
>> +	{ .matches = {
>> +		DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "Gigabyte Technology Co., Ltd."),
>> +		DMI_EXACT_MATCH(DMI_BOARD_NAME, "B550M DS3H"),
>> +	}},
>> +	{ .matches = {
>> +		DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "Gigabyte Technology Co., Ltd."),
>> +		DMI_EXACT_MATCH(DMI_BOARD_NAME, "Z390 I AORUS PRO WIFI-CF"),
>> +	}},
>> +	{ .matches = {
>> +		DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "Gigabyte Technology Co., Ltd."),
>> +		DMI_EXACT_MATCH(DMI_BOARD_NAME, "X570 I AORUS PRO WIFI"),
>> +	}},
>> +	{ }
>> +};
>> +
>> +static int gigabyte_wmi_probe(struct wmi_device *wdev, const void *context)
>> +{
>> +	struct device *hwmon_dev;
>> +	int ret;
>> +
>> +	if (!dmi_check_system(gigabyte_wmi_known_working_platforms)) {
>> +		if (force_load)
>> +			dev_warn(&wdev->dev, "Forcing loading on non-whitelisted platform");
>> +		else
>> +			return -ENODEV;
>> +	}
>> +
>> +	ret = gigabyte_wmi_validate_sensor_presence(wdev);
>> +	if (ret) {
>> +		dev_info(&wdev->dev, "No temperature sensors usable");
>> +		return ret;
>> +	}
>> +
>> +	hwmon_dev = devm_hwmon_device_register_with_info(&wdev->dev, "gigabyte_wmi", wdev,
>> +							 &gigabyte_wmi_hwmon_chip_info, NULL);
>> +
>> +	return PTR_ERR_OR_ZERO(hwmon_dev);
>> +}
>> +
>> +static const struct wmi_device_id gigabyte_wmi_id_table[] = {
>> +	{ GIGABYTE_WMI_GUID, NULL },
>> +	{ }
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
>> +MODULE_DESCRIPTION("Gigabyte WMI temperature Driver");
>> +MODULE_LICENSE("GPL");
>>
>> base-commit: 144c79ef33536b4ecb4951e07dbc1f2b7fa99d32
>>
> 

