Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68A1A35D9C9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 10:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242219AbhDMIOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 04:14:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36688 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241950AbhDMIOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 04:14:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618301672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=34/QK2iPNGlE0YUWGtTdG3TtOt7bhlF3eYIJYcaGVyg=;
        b=DY3wLNwEuRdhup+jK5nxv4yB4+sVSE4XXXNsn+z6+exWv4seDVP2lY9sM8snuognAXvYfl
        IUur7Bm1xHPK9h8TSljGNyLJcX5liLDLBKamJizzrcXtYrziFgmuViDi6P4BAPn1VYP4xR
        Foln41nQJPioIDFOAJvHdgFQfqTiAyU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-vuyOmf-VNsSwCre1SuAjbw-1; Tue, 13 Apr 2021 04:14:30 -0400
X-MC-Unique: vuyOmf-VNsSwCre1SuAjbw-1
Received: by mail-ed1-f69.google.com with SMTP id bm19-20020a0564020b13b02903789d6e74b5so856245edb.21
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 01:14:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=34/QK2iPNGlE0YUWGtTdG3TtOt7bhlF3eYIJYcaGVyg=;
        b=Co+DwWS8FNvuXaX7GsYlz0MIo7yJUhAo6M1bLXVKnVTSz5MXu4vtqNOOchzJtuSvJr
         gO2FENICFKeB13gqe7s3PMgOQ/CD6wlr6yOujcdDEkeyB4ZNJ4IP4eWCcFW6WY7PCCYn
         ChwY6WZDzfOzUdMYqaCjXq/jAJhqOz7MmsZXrp+Jda1phg4K1KEgAAfy60Y6MwIW0mSq
         hgDd9E9vv52lK8TZFg2ANLupQeOuEk3df3jCBlaz06EOb+onVrbcdJ/f5nc5u9Dguvw1
         gXE1erAyrXC8vgHfHUYrc5hfFvhebmpX2ixT+fn0OwxupDW8/jsjRHzB4AODvseG4WA8
         OckA==
X-Gm-Message-State: AOAM532uru37wn7DfmS9N9u1197AMOMPs7AMrCO90Qqr+lYm4GKqN+Yi
        zfS36stllzWiwQ2uuoO6DsAy3fDENXxSxweAzf1dVuuIrA/TsaJxkVKlTMwZkkry2XE3PK3IW18
        JHYshwDKZKBipa77ezCID4boY
X-Received: by 2002:aa7:de12:: with SMTP id h18mr27091757edv.380.1618301668828;
        Tue, 13 Apr 2021 01:14:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzOeY4qjKaeZvBe/RZ6qv8piou/UeISkX5paTwhmlbrExpIw9RSOd2DmHS7fNs6+VPxvT2GJA==
X-Received: by 2002:aa7:de12:: with SMTP id h18mr27091738edv.380.1618301668655;
        Tue, 13 Apr 2021 01:14:28 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id lr27sm2600562ejb.8.2021.04.13.01.14.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Apr 2021 01:14:28 -0700 (PDT)
Subject: Re: [PATCH v5] platform/x86: add Gigabyte WMI temperature driver
To:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
        platform-driver-x86@vger.kernel.org,
        Mark Gross <mgross@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Barnab=c3=a1s_P=c5=91cze?= <pobrn@protonmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Cc:     Matthew Garrett <mjg59@srcf.ucam.org>
References: <20210410181856.144988-1-linux@weissschuh.net>
 <20210412123513.628901-1-linux@weissschuh.net>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <26b71512-354d-5214-1cce-34a65d563452@redhat.com>
Date:   Tue, 13 Apr 2021 10:14:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210412123513.628901-1-linux@weissschuh.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/12/21 2:35 PM, Thomas Weißschuh wrote:
> Tested with
> * X570 I Aorus Pro Wifi (rev 1.0)
> * B550M DS3H
> * B550 Gaming X V2 (rev.1.x)
> * Z390 I AORUS PRO WIFI (rev. 1.0)
> 
> Those mainboards contain an ITE chips for management and
> monitoring.
> 
> They could also be handled by drivers/hwmon/i87.c.
> But the SuperIO range used by i87 is already claimed and used by the
> firmware.
> 
> The following warning is printed at boot:
> 
> kernel: ACPI Warning: SystemIO range 0x0000000000000A45-0x0000000000000A46 conflicts with OpRegion 0x0000000000000A45-0x0000000000000A46 (\GSA1.SIO1) (20200528/utaddress-204)
> kernel: ACPI: This conflict may cause random problems and system instability
> kernel: ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
> 
> This driver implements such an ACPI driver.

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans






> 
> Unfortunately not all sensor registers are handled by the firmware and even
> less are exposed via WMI.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> 
> ---
> 
> Changes since v4:
> * Style
> * Wording
> * Alignment of email addresses
> ---
>  MAINTAINERS                         |   6 +
>  drivers/platform/x86/Kconfig        |  11 ++
>  drivers/platform/x86/Makefile       |   1 +
>  drivers/platform/x86/gigabyte-wmi.c | 195 ++++++++++++++++++++++++++++
>  4 files changed, 213 insertions(+)
>  create mode 100644 drivers/platform/x86/gigabyte-wmi.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d92f85ca831d..7fb5e2ba489b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7543,6 +7543,12 @@ F:	Documentation/filesystems/gfs2*
>  F:	fs/gfs2/
>  F:	include/uapi/linux/gfs2_ondisk.h
>  
> +GIGABYTE WMI DRIVER
> +M:	Thomas Weißschuh <thomas@weissschuh.net>
> +L:	platform-driver-x86@vger.kernel.org
> +S:	Maintained
> +F:	drivers/platform/x86/gigabyte-wmi.c
> +
>  GNSS SUBSYSTEM
>  M:	Johan Hovold <johan@kernel.org>
>  S:	Maintained
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index ad4e630e73e2..96622a2106f7 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -123,6 +123,17 @@ config XIAOMI_WMI
>  	  To compile this driver as a module, choose M here: the module will
>  	  be called xiaomi-wmi.
>  
> +config GIGABYTE_WMI
> +	tristate "Gigabyte WMI temperature driver"
> +	depends on ACPI_WMI
> +	depends on HWMON
> +	help
> +	  Say Y here if you want to support WMI-based temperature reporting on
> +	  Gigabyte mainboards.
> +
> +	  To compile this driver as a module, choose M here: the module will
> +	  be called gigabyte-wmi.
> +
>  config ACERHDF
>  	tristate "Acer Aspire One temperature and fan driver"
>  	depends on ACPI && THERMAL
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
> index 60d554073749..1621ebfd04fd 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -15,6 +15,7 @@ obj-$(CONFIG_INTEL_WMI_THUNDERBOLT)	+= intel-wmi-thunderbolt.o
>  obj-$(CONFIG_MXM_WMI)			+= mxm-wmi.o
>  obj-$(CONFIG_PEAQ_WMI)			+= peaq-wmi.o
>  obj-$(CONFIG_XIAOMI_WMI)		+= xiaomi-wmi.o
> +obj-$(CONFIG_GIGABYTE_WMI)		+= gigabyte-wmi.o
>  
>  # Acer
>  obj-$(CONFIG_ACERHDF)		+= acerhdf.o
> diff --git a/drivers/platform/x86/gigabyte-wmi.c b/drivers/platform/x86/gigabyte-wmi.c
> new file mode 100644
> index 000000000000..bb1b0b205fa7
> --- /dev/null
> +++ b/drivers/platform/x86/gigabyte-wmi.c
> @@ -0,0 +1,195 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + *  Copyright (C) 2021 Thomas Weißschuh <thomas@weissschuh.net>
> + */
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/acpi.h>
> +#include <linux/dmi.h>
> +#include <linux/hwmon.h>
> +#include <linux/module.h>
> +#include <linux/wmi.h>
> +
> +#define GIGABYTE_WMI_GUID	"DEADBEEF-2001-0000-00A0-C90629100000"
> +#define NUM_TEMPERATURE_SENSORS	6
> +
> +static bool force_load;
> +module_param(force_load, bool, 0444);
> +MODULE_PARM_DESC(force_load, "Force loading on unknown platform");
> +
> +static u8 usable_sensors_mask;
> +
> +enum gigabyte_wmi_commandtype {
> +	GIGABYTE_WMI_BUILD_DATE_QUERY       =   0x1,
> +	GIGABYTE_WMI_MAINBOARD_TYPE_QUERY   =   0x2,
> +	GIGABYTE_WMI_FIRMWARE_VERSION_QUERY =   0x4,
> +	GIGABYTE_WMI_MAINBOARD_NAME_QUERY   =   0x5,
> +	GIGABYTE_WMI_TEMPERATURE_QUERY      = 0x125,
> +};
> +
> +struct gigabyte_wmi_args {
> +	u32 arg1;
> +};
> +
> +static int gigabyte_wmi_perform_query(struct wmi_device *wdev,
> +				      enum gigabyte_wmi_commandtype command,
> +				      struct gigabyte_wmi_args *args, struct acpi_buffer *out)
> +{
> +	const struct acpi_buffer in = {
> +		.length = sizeof(*args),
> +		.pointer = args,
> +	};
> +
> +	acpi_status ret = wmidev_evaluate_method(wdev, 0x0, command, &in, out);
> +
> +	if (ACPI_FAILURE(ret))
> +		return -EIO;
> +
> +	return 0;
> +}
> +
> +static int gigabyte_wmi_query_integer(struct wmi_device *wdev,
> +				      enum gigabyte_wmi_commandtype command,
> +				      struct gigabyte_wmi_args *args, u64 *res)
> +{
> +	union acpi_object *obj;
> +	struct acpi_buffer result = { ACPI_ALLOCATE_BUFFER, NULL };
> +	int ret;
> +
> +	ret = gigabyte_wmi_perform_query(wdev, command, args, &result);
> +	if (ret)
> +		return ret;
> +	obj = result.pointer;
> +	if (obj && obj->type == ACPI_TYPE_INTEGER)
> +		*res = obj->integer.value;
> +	else
> +		ret = -EIO;
> +	kfree(result.pointer);
> +	return ret;
> +}
> +
> +static int gigabyte_wmi_temperature(struct wmi_device *wdev, u8 sensor, long *res)
> +{
> +	struct gigabyte_wmi_args args = {
> +		.arg1 = sensor,
> +	};
> +	u64 temp;
> +	acpi_status ret;
> +
> +	ret = gigabyte_wmi_query_integer(wdev, GIGABYTE_WMI_TEMPERATURE_QUERY, &args, &temp);
> +	if (ret == 0) {
> +		if (temp == 0)
> +			return -ENODEV;
> +		*res = (s8)temp * 1000; // value is a signed 8-bit integer
> +	}
> +	return ret;
> +}
> +
> +static int gigabyte_wmi_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
> +				   u32 attr, int channel, long *val)
> +{
> +	struct wmi_device *wdev = dev_get_drvdata(dev);
> +
> +	return gigabyte_wmi_temperature(wdev, channel, val);
> +}
> +
> +static umode_t gigabyte_wmi_hwmon_is_visible(const void *data, enum hwmon_sensor_types type,
> +					     u32 attr, int channel)
> +{
> +	return usable_sensors_mask & BIT(channel) ? 0444  : 0;
> +}
> +
> +static const struct hwmon_channel_info *gigabyte_wmi_hwmon_info[] = {
> +	HWMON_CHANNEL_INFO(temp,
> +			   HWMON_T_INPUT,
> +			   HWMON_T_INPUT,
> +			   HWMON_T_INPUT,
> +			   HWMON_T_INPUT,
> +			   HWMON_T_INPUT,
> +			   HWMON_T_INPUT),
> +	NULL
> +};
> +
> +static const struct hwmon_ops gigabyte_wmi_hwmon_ops = {
> +	.read = gigabyte_wmi_hwmon_read,
> +	.is_visible = gigabyte_wmi_hwmon_is_visible,
> +};
> +
> +static const struct hwmon_chip_info gigabyte_wmi_hwmon_chip_info = {
> +	.ops = &gigabyte_wmi_hwmon_ops,
> +	.info = gigabyte_wmi_hwmon_info,
> +};
> +
> +static u8 gigabyte_wmi_detect_sensor_usability(struct wmi_device *wdev)
> +{
> +	int i;
> +	long temp;
> +	u8 r = 0;
> +
> +	for (i = 0; i < NUM_TEMPERATURE_SENSORS; i++) {
> +		if (!gigabyte_wmi_temperature(wdev, i, &temp))
> +			r |= BIT(i);
> +	}
> +	return r;
> +}
> +
> +static const struct dmi_system_id gigabyte_wmi_known_working_platforms[] = {
> +	{ .matches = {
> +		DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "Gigabyte Technology Co., Ltd."),
> +		DMI_EXACT_MATCH(DMI_BOARD_NAME, "B550 GAMING X V2"),
> +	}},
> +	{ .matches = {
> +		DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "Gigabyte Technology Co., Ltd."),
> +		DMI_EXACT_MATCH(DMI_BOARD_NAME, "B550M DS3H"),
> +	}},
> +	{ .matches = {
> +		DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "Gigabyte Technology Co., Ltd."),
> +		DMI_EXACT_MATCH(DMI_BOARD_NAME, "Z390 I AORUS PRO WIFI-CF"),
> +	}},
> +	{ .matches = {
> +		DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "Gigabyte Technology Co., Ltd."),
> +		DMI_EXACT_MATCH(DMI_BOARD_NAME, "X570 I AORUS PRO WIFI"),
> +	}},
> +	{ }
> +};
> +
> +static int gigabyte_wmi_probe(struct wmi_device *wdev, const void *context)
> +{
> +	struct device *hwmon_dev;
> +
> +	if (!dmi_check_system(gigabyte_wmi_known_working_platforms)) {
> +		if (!force_load)
> +			return -ENODEV;
> +		dev_warn(&wdev->dev, "Forcing load on unknown platform");
> +	}
> +
> +	usable_sensors_mask = gigabyte_wmi_detect_sensor_usability(wdev);
> +	if (!usable_sensors_mask) {
> +		dev_info(&wdev->dev, "No temperature sensors usable");
> +		return -ENODEV;
> +	}
> +
> +	hwmon_dev = devm_hwmon_device_register_with_info(&wdev->dev, "gigabyte_wmi", wdev,
> +							 &gigabyte_wmi_hwmon_chip_info, NULL);
> +
> +	return PTR_ERR_OR_ZERO(hwmon_dev);
> +}
> +
> +static const struct wmi_device_id gigabyte_wmi_id_table[] = {
> +	{ GIGABYTE_WMI_GUID, NULL },
> +	{ }
> +};
> +
> +static struct wmi_driver gigabyte_wmi_driver = {
> +	.driver = {
> +		.name = "gigabyte-wmi",
> +	},
> +	.id_table = gigabyte_wmi_id_table,
> +	.probe = gigabyte_wmi_probe,
> +};
> +module_wmi_driver(gigabyte_wmi_driver);
> +
> +MODULE_DEVICE_TABLE(wmi, gigabyte_wmi_id_table);
> +MODULE_AUTHOR("Thomas Weißschuh <thomas@weissschuh.net>");
> +MODULE_DESCRIPTION("Gigabyte WMI temperature driver");
> +MODULE_LICENSE("GPL");
> 
> base-commit: 144c79ef33536b4ecb4951e07dbc1f2b7fa99d32
> 

